package fr.smile.jahia.handler;

import fr.smile.jahia.model.ContactInfo;
import org.jahia.services.content.JCRCallback;
import org.jahia.services.content.JCRNodeWrapper;
import org.jahia.services.content.JCRSessionWrapper;
import org.jahia.services.content.JCRTemplate;
import org.jahia.services.content.decorator.JCRUserNode;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import javax.jcr.RepositoryException;
import java.io.Serializable;

/**
 * Webflow handler in order to update with user contact information
 */
public class ContactInfoHandler implements Serializable {

	private static final long serialVersionUID = 1L;
	
	private static final Logger logger = LoggerFactory.getLogger(ContactInfoHandler.class);

    /**
     * Init contactInfo with user data
     * @param contactInfo contact info
     * @param formNode the node
     * @throws RepositoryException
     */
    public void init(
            final ContactInfo contactInfo,
            final JCRNodeWrapper formNode) throws RepositoryException {
        JCRSessionWrapper session = formNode.getSession();
        final JCRUserNode userNode = session.getUserNode();
        contactInfo.setEmail(userNode.getPropertyAsString("j:email"));
        contactInfo.setPhone(userNode.getPropertyAsString("j:phoneNumber"));
        contactInfo.setMobile(userNode.getPropertyAsString("j:mobileNumber"));

    }
    /**
     * Update current user contact information
     *
     * @param contactInfo Java bean where temproray contact information are saved
     * @param formNode    current resource
     * @throws RepositoryException
     */
    public void update(
            final ContactInfo contactInfo,
            final JCRNodeWrapper formNode) throws RepositoryException {
        logger.debug("contactInfo=" + contactInfo.toString());
        logger.debug("formNode=" + formNode.getPropertiesAsString());
        JCRTemplate.getInstance().doExecuteWithSystemSessionAsUser(
                formNode.getSession().getUser(),
                formNode.getSession().getWorkspace().getName(),
                formNode.getSession().getLocale(),
                new JCRCallback<Boolean>() {
                    @Override
                    public Boolean doInJCR(JCRSessionWrapper session) throws RepositoryException {
                        logger.debug("user=" + formNode.getSession().getUser().getUsername());
                        logger.debug("workspaceName=" + formNode.getSession().getWorkspace().getName());
                        logger.debug("locale=" + formNode.getSession().getLocale());

                        final JCRUserNode userNode = session.getUserNode();
                        userNode.setProperty("j:email", contactInfo.getEmail());
                        userNode.setProperty("j:phoneNumber", contactInfo.getPhone());
                        userNode.setProperty("j:mobileNumber", contactInfo.getMobile());
                        session.save();
                        logger.debug("JCR Session was saved!");

                        return Boolean.TRUE;
                    }

                });
    }
}