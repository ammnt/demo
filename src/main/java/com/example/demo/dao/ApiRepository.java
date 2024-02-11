package com.example.demo.dao;
import org.springframework.data.repository.CrudRepository;
import java.util.List;

public interface ApiRepository extends CrudRepository<ApiEntity, Long> {
    List<ApiEntity> findAllByNameContaining(String name);
}
