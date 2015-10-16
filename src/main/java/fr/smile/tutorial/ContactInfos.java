package fr.smile.tutorial;

import java.io.Serializable;

/**
 * Created by fegoo on 16/10/15.
 */
public class ContactInfos implements Serializable {

    private static final long serialVersionUID = 6716048385027138182L;


    private String email;
    private String mobilePhone;
    private String homePhone;

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getMobilePhone() {
        return mobilePhone;
    }

    public void setMobilePhone(String mobilePhone) {
        this.mobilePhone = mobilePhone;
    }

    public String getHomePhone() {
        return homePhone;
    }

    public void setHomePhone(String homePhone) {
        this.homePhone = homePhone;
    }

    @Override
    public String toString() {
        return "ContactInfos{" +
                "email='" + email + '\'' +
                ", mobilePhone='" + mobilePhone + '\'' +
                ", homePhone='" + homePhone + '\'' +
                '}';
    }
}
