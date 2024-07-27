# ee-permissions.sh
#!/bin/bash

find ${WORKSPACE_FOLDER}/${SYSTEM_FOLDER}ee -type f -exec chmod 666 {} \;
find ${WORKSPACE_FOLDER}/${SYSTEM_FOLDER}user/cache -type f -exec chmod 666 {} \;
find ${WORKSPACE_FOLDER}/${SYSTEM_FOLDER}user/templates -type f -exec chmod 666 {} \;
chmod 666 ${WORKSPACE_FOLDER}/${SYSTEM_FOLDER}user/config/config.php
find ${WORKSPACE_FOLDER}/${PUBLIC_FOLDER}images/avatars -type f -exec chmod 666 {} \;
find ${WORKSPACE_FOLDER}/${PUBLIC_FOLDER}images/captchas -type f -exec chmod 666 {} \;
find ${WORKSPACE_FOLDER}/${PUBLIC_FOLDER}images/pm_attachments -type f -exec chmod 666 {} \;
find ${WORKSPACE_FOLDER}/${PUBLIC_FOLDER}images/uploads -type f -exec chmod 666 {} \;
find ${WORKSPACE_FOLDER}/${PUBLIC_FOLDER}themes/ee/ -type f -exec chmod 666 {} \;
find ${WORKSPACE_FOLDER}/${PUBLIC_FOLDER}themes/user -type f -exec chmod 666 {} \;

# ## folder permissions

find ${WORKSPACE_FOLDER}/${SYSTEM_FOLDER}ee -type d -exec chmod 777 {} \;
find ${WORKSPACE_FOLDER}/${SYSTEM_FOLDER}user/cache -type d -exec chmod 777 {} \;
find ${WORKSPACE_FOLDER}/${SYSTEM_FOLDER}user/templates -type d -exec chmod 777 {} \;
find ${WORKSPACE_FOLDER}/${PUBLIC_FOLDER}images/avatars -type d -exec chmod 777 {} \;
find ${WORKSPACE_FOLDER}/${PUBLIC_FOLDER}images/captchas -type d -exec chmod 777 {} \;
find ${WORKSPACE_FOLDER}/${PUBLIC_FOLDER}images/pm_attachments -type d -exec chmod 777 {} \;
find ${WORKSPACE_FOLDER}/${PUBLIC_FOLDER}images/uploads -type d -exec chmod 777 {} \;
find ${WORKSPACE_FOLDER}/${PUBLIC_FOLDER}themes/ee/ -type d -exec chmod 777 {} \;
find ${WORKSPACE_FOLDER}/${PUBLIC_FOLDER}themes/user -type d -exec chmod 777 {} \;