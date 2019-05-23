# A script to quickly set up a D7 site with a bunch of popular modules and a D8
# site to migrate to. The idea is to track available migrations over time.
# @todo: See about splitting the D7 stuff from the D8 stuff.

# First, the Drupal 7 source site.
# We clone from Git in order to get the latest code, which may or may not
# correspond to the latest release.
git clone --branch 7.x https://git.drupalcode.org/project/drupal.git d7top50
cd d7top50

# Awww yeah, using MAMP like it's 1999... ;)
drush8 si --db-url=mysql://root:root@127.0.0.1:8889/d7top50 -y

MODULES_D7="ctools	\
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
drush8 dl -y $MODULES_D7
drush8 en -y $MODULES_D7

# Google Analtyics is a bit "special" since the project name and module name
# mismatch.
drush8 dl -y google_analytics 
drush8 en -y googleanalytics

# For some reason CKEditor wigs out when included in list above, so instead
# add it manually here.
drush8 dl -y ckeditor 
drush8 en -y ckeditor

# Now, set up a Drupal 8 site to migrate to.
rm -rf d8destination
composer create-project drupal-composer/drupal-project:8.x-dev d8top50 --no-interaction
cd d8destination
composer require drush/drush
composer install
drush8 si --db-url=mysql://root:root@127.0.0.1:8889/d8top50 -y

# Download and enable D8 equivalents for all of the above projects.
CORE_D8=(
  'views'
  'date'
  'link'
  'wysiwyg'
  'entity_reference'
  'media'
  'email'
  'content_translation'
  'locale'
  'language'
)

MODULES_D8=(
  'ctools'
  'token'
  'libraries'
  'pathauto'
  'entity'
  'admin_toolbar'
  'webform'
  'metatag'
  'imce'
  'module_filter'
  'field_group'
  'rules'
  'transliteration'
  'captcha'
  'xmlsitemap'
  'colorbox'
  'features'
  'backup_migrate'
  'views_bulk_operations'
  'file_entity'
  'views_slideshow'
  'panels'
  'menu_block'
  'devel'
  'paragraphs'
  'redirect'
  'block_class'
  'imce_wysiwyg'
  'ds'
  'menu_attributes'
  'mailsystem'
  'superfish'
  'address'
  'admin_views'
)

for MODULE in $(MODULES_D8[@]}; do
  "composer require drupal/{MODULE}"
  "drush en {MODULE}"
done

