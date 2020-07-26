# Rails template for PDF Rendering

Rendering PDFs in Rails is a pattern we need fairly regularly.

* This Rails template can be applied to an an existing Rails app.
* Rails templates are a bit like generators - this template will create and edit files in your app to implement PDF rendering.
* You can review and edit the files as you need before you commit them to your app.


## How-to use this template

```bash
# Step 1: Ensure you are in a clean git environment.
$ cd path/to/your/rails/app

# Step 2: Ensure you are in a clean git environment.
#
#  * This template will edit/create files that you will want to review and edit
#    before you commit them - that will be more annoying if you have other
#    uncommited changes.

# Step 3:

$ bundle exec rails app:template LOCATION=https://raw.githubusercontent.com/ackama/rails-template-pdf-rendering/main/template.rb

# or if you have already cloned this repo locally then
$ bundle exec rails app:template LOCATION=path/to/wherever/you/cloned/rails-template-pdf-rendering/template.rb
```

## How to develop this template

```bash
# Step: Clone this repo

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
