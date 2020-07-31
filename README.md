# Rails template for PDF Rendering

Rendering PDFs is a common feature on our Rails apps. This template, which works
similarly to Rails generator, will create and edit files in your existing Rails
app to implement the feature. You can then tweak these files to suit the needs
of your app.

## How-to use this template

```bash
# Step 1: Navigate to your Rails app in your terminal
$ cd path/to/your/rails/app

# Step 2: Ensure you are in a clean git environment.
#
#  * This template will edit/create files that you will want to review and edit
#    before you commit them - that will be more annoying if you have other
#    uncommited changes.

# Step 3: Run the template by referencing it's location on Github ...
$ bundle exec rails app:template LOCATION=https://raw.githubusercontent.com/ackama/rails-template-pdf-rendering/main/template.rb

# ... or if you have already cloned this repo locally then you can use that path
$ bundle exec rails app:template LOCATION=path/to/wherever/you/cloned/rails-template-pdf-rendering/template.rb

# Step 4: Address all the TODO items which appear in the output of the template
```

## How-to improve this template

```bash
# First, clone this repo

$ cd path/to/this/repo

$ bundle install

# Run our (very minimal) checks
$ bundle exec rubocop
```

```bash
# Create/choose a rails app to test this template on

# Apply the template to your application
$ cd path/to/new/rails/app
$ bundle exec rails app:template LOCATION=path/to/wherever/you/cloned/rails-template-pdf-rendering/template.rb

# Clean up changes made by this template
# WARNING: this can delete files you care about - understand what `git clean`
#          does before you run it.
$ git clean -fd && git checkout .
```
