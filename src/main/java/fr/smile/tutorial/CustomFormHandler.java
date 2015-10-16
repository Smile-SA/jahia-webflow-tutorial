package fr.smile.tutorial;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.io.Serializable;

/**
 * Created by fegoo on 15/10/15.
 */
public class CustomFormHandler implements Serializable {

    private static final long serialVersionUID = -4788571325460688293L;

    Logger LOGGER = LoggerFactory.getLogger(CustomFormHandler.class);

    public void processCustomFormData(InfosData infosData){

        LOGGER.info("Process custom form data ...");

    }
}
