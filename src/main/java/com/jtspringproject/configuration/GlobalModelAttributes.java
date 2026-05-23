package com.jtspringproject.configuration;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ModelAttribute;

@ControllerAdvice
public class GlobalModelAttributes {

    @Value("${app.currency.symbol:\u20AC}")
    private String currencySymbol;

    @ModelAttribute("currencySymbol")
    public String currencySymbol() {
        return currencySymbol;
    }
}
