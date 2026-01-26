package com.ckfinder.config;

import com.cksource.ckfinder.config.Config;
import com.cksource.ckfinder.config.loader.ConfigLoader;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.dataformat.yaml.YAMLFactory;

import jakarta.inject.Named;
import java.io.InputStream;

@Named
public class CustomConfigLoader implements ConfigLoader {
    @Override
    public Config loadConfig() throws Exception {
        ObjectMapper mapper = new ObjectMapper(new YAMLFactory());
        try (InputStream is = Thread.currentThread()
                .getContextClassLoader()
                .getResourceAsStream("ckfinder.yml")) {
            if (is == null) {
                throw new IllegalStateException("ckfinder.yml not found on classpath");
            }

            return mapper.readValue(is, CustomConfig.class);
        }
    }
}
