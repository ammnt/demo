package com.example.demo.model;

import lombok.Value;

@Value
public class Api {
    Long id;
    String name;
    String comment;
    Double rate;
}
