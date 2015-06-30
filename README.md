[![Build Status](https://semaphoreci.com/api/v1/projects/056267a7-6787-482b-b9e0-50bfc275ce19/420189/badge.svg)](https://semaphoreci.com/avargas/web)

# Billion
Changing the way the world crowdfunds. For good.

## Tech Stack

* Rails 4.2
* Postgresql
* Redis (eventually)
* HTML/SASS
* Backbone/Marionette
* Vagrant
* AWS (OpsWorks, Ec2, RDS, etc)

## Contributing

1. Pick out an issue on https://trello.com/b/qbGuSBuA/development. If the issue
you are working on does not exist there, add it.
2. Branch off of `develop`. If I am working on Trello issue 1, my branch might
look like `1_landing_page`.
3. Write the feature. Back-end code should be tested. Front-end code will not
be tested until the UI matures.
4. Run `rspec`. All tests should pass.
5. Run `rubocop`. All tests should pass. If you disagree with a style guideline,
bring it up. Our rubocop config is still a work in progress.
6. Submit a PR. The semaphor build should pass.
7. When the code is merged, it will automatically be deployed to
int.billioneffect.com.

## Vagrant

### Vagrant: setup

1. (Install VirtualBox)[https://www.virtualbox.org/wiki/Downloads]. Pick the
version that matches your OS under the **VirtualBox platform packages** section.

2. (Install Vagrant)[http://www.vagrantup.com/downloads]. Pick the package
that matches your OS.

3. `cd` into the root of your lambda-api project directory.

4. Run `vagrant up`.

5. Go grab a coffee. This will provision you VM and take a while.

6. The VM is running an apache server - you can check out the site locally at
`http://192.168.60.66/`.

7. Start hacking!

### Vagrant: crash course

This is by no means intended to be a conprehensive guide to all things Vagrant.
If you want that, feel free to check out
(the docs)[https://docs.vagrantup.com/v2/].

* `vagrant up` - This command creates and configures guest machines according
to your `Vagrantfile`.

* `vagrant ssh` - This will ssh you into the vagrant VM. Your project directory
will be kept in sync with the `/vagrant` directory in your vagrant VM. Any
changes you make in your project directory will be reflected in the vagrant VM
and vice versa.

* `vagrant halt` - This command shuts down the running machine Vagrant is
managing. You'll want to do this when ypu are not actively developing Lambda.

* `vagrant reload` - The equivalent of running a `vagrant halt` followed by a
`vagrant up`.

### Vagrant: recommended workflow

I like to do all of my regular development directly in my project directory. I
ssh into the vagrant box and cd into the `/vagrant` directory to run `rake`
tasks, `bundle install`, `rspec`, and `rubocop`.
