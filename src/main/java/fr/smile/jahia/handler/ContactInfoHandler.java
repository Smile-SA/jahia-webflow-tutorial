package fr.smile.jahia.handler;

import fr.smile.jahia.model.ContactInfo;
import org.jahia.services.content.JCRCallback;
import org.jahia.services.content.JCRNodeWrapper;
import org.jahia.services.content.JCRSessionWrapper;
import org.jahia.services.content.JCRTemplate;
import org.jahia.services.content.decorator.JCRUserNode;

import javax.jcr.RepositoryException;
import java.io.Serializable;

public class ContactInfoHandler implements Serializable {

    public void update(
            final ContactInfo contactInfo,
            final JCRNodeWrapper formNode) throws RepositoryException {
        JCRTemplate.getInstance().doExecuteWithSystemSessionAsUser(
                formNode.getSession().getUser(),
                formNode.getSession().getWorkspace().getName(),
                formNode.getSession().getLocale(),
                new JCRCallback<Boolean>() {
                    @Override
                    public Boolean doInJCR(JCRSessionWrapper session) throws RepositoryException {
                        final JCRUserNode userNode = session.getUserNode();
                        userNode.setProperty("j:email", contactInfo.getEmail());
                        //userNode.setProperty("phone", contactInfo.getPhone());
                        //userNode.setProperty("mobile", contactInfo.getMobile());
                        session.save();
                        return Boolean.TRUE;
                    }

                });
    }
}