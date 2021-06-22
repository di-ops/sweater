package com.myCompany.sweater.repositories;

import com.myCompany.sweater.domain.Message;
import com.myCompany.sweater.domain.User;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.repository.CrudRepository;

import java.util.List;

public interface UserRepository extends JpaRepository<User, Long> {
    User findByUsername(String username);
}
