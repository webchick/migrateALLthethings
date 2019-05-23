# Get a copy of Drupal 7 and the top 50 contributed modules.
# We clone from Git in order to get the latest code, which may or may not
# correspond to the latest release.
git clone --branch 7.x https://git.drupalcode.org/project/drupal.git d7top50
cd d7top50

# Awww yeah, using MAMP like it's 1999... ;)
drush8 si --db-url=mysql://root:root@127.0.0.1:8889/d7top50 -y

MODULES="ctools		\
views			\
token			\
libraries		\
pathauto		\
entity			\
jquery_update		\
admin_menu		\
webform			\
date			\
metatag			\
imce			\
module_filter		\
link			\
wysiwyg			\
field_group		\
rules			\
transliteration		\
entityreference		\
captcha			\
xmlsitemap		\
colorbox		\
media			\
features		\
backup_migrate		\
views_bulk_operations	\
variable		\
file_entity		\
views_slideshow		\
panels			\
l10n_update		\
menu_block		\
i18n			\
devel			\
globalredirect		\
field_collection	\
redirect		\
context			\
block_class		\
imce_wysiwyg		\
strongarm		\
ds			\
menu_attributes		\
mailsystem		\
email			\
superfish		\
addressfield		\
admin_views"

# Download and enable the top 50 contributed modules.
drush8 dl -y $MODULES
drush8 en -y $MODULES

# Google Analtyics is a bit "special" since the project name and module name
# mismatch.
drush8 dl -y google_analytics 
drush8 en -y googleanalytics

# For some reason CKEditor wigs out when included in list above, so instead
# add it manually here.
drush8 dl -y ckeditor 
drush8 en -y ckeditor
