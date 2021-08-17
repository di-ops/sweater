package com.myCompany.sweater.service;

import com.myCompany.sweater.domain.Role;
import com.myCompany.sweater.domain.User;
import com.myCompany.sweater.repositories.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;

import java.util.*;
import java.util.stream.Collectors;

@Service
public class UserService implements UserDetailsService {
    @Autowired
    private UserRepository userRepository;

    @Autowired
    private MailSender mailSender;
    @Override
    public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
        return userRepository.findByUsername(username);
    }

    public boolean addUser(User user){
        User userFromDb = userRepository.findByUsername(user.getUsername());

        if (userFromDb != null){
            return false;
        }

        user.setActive(true);
        user.setRoles(Collections.singleton(Role.USER));
        user.setActivationCode(UUID.randomUUID().toString());
        userRepository.save(user);

        sendActivationCode(user);
        return true;
    }

    private void sendActivationCode(User user) {
        if(StringUtils.hasLength(user.getMail())){
            String msg = String.format("Hello, %s! \n"
                                        + "Welcome to sweater! Please visit next link: \n"
                                        + "http://localhost:8080/activate/%s",
                                        user.getUsername(), user.getActivationCode());
            mailSender.send(user.getMail(), "Activation", msg);
        }
    }

    public boolean activateUser(String code) {
        User user = userRepository.findByActivationCode(code);
        if (user == null){
            return false;
        }

        user.setActivationCode(null);
        userRepository.save(user);
        return true;
    }

    public List<User> findAll() {
        return userRepository.findAll();
    }

    public void saveUser(User user, String username, Map<String, String> form) {
        user.setUsername(username);
        Set<String> roles = Arrays.stream(Role.values())
                .map(Role::name)
                .collect(Collectors.toSet());

        user.getRoles().clear();

        for (String key : form.keySet()) {
            if (roles.contains(key)){
                user.getRoles().add(Role.valueOf(key));
            }
        }
        userRepository.save(user);
    }

    public void updateProfile(User user, String password, String mail) {
        String userMail = user.getMail();
        boolean isEmailChanged = ((mail!=null && !mail.equals(userMail))
                            || (userMail!=null && !userMail.equals(mail)));
        if(isEmailChanged){
            user.setMail(mail);
            if (StringUtils.hasLength(mail)){
                user.setActivationCode(UUID.randomUUID().toString());
            }
        }
        if (StringUtils.hasLength(password)){
            user.setPassword(password);
        }
        userRepository.save(user);
        sendActivationCode(user);
    }
}
