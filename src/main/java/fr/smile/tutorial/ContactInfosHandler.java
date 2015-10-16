package fr.smile.tutorial;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.io.Serializable;

/**
 * Created by fegoo on 16/10/15.
 */
public class ContactInfosHandler implements Serializable {

    private static final long serialVersionUID = -4788571325460688293L;

    Logger LOGGER = LoggerFactory.getLogger(ContactInfosHandler.class);

    public void processContactInfos(ContactInfos contactInfos){
        LOGGER.info("-------------------------proccesing contact infos : " + contactInfos.toString());
    }
}
