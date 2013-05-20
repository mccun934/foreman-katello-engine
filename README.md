Foreman Katello Rails Engine
============================
[![Build Status](https://travis-ci.org/Katello/foreman-katello-engine.png?branch=master)](https://travis-ci.org/Katello/foreman-katello-engine)

Bringing Katello specific code into Foreman.

Installation
------------

Create `bundler.d/katello.rb` in your Foreman installation:

```ruby
gem 'foreman-katello-engine'
```

How it works?
-------------

The gem modifies some of the Foreman functionality to play nice with
Katello managed infrastructure. Often, just the HTML forms are
slightly modified using a `deface` gem, leveraging the Foreman data
model to model Katello entities.

Modified functionality
----------------------

### Host Group forms

New tab 'Activation Keys is added to the host groups form, exposing a select
box for activation keys.

Also environments select box is improved to group Foreman environments
by Katello organizations and environments.

The activation keys are modeled similarly using foreman custom params.
The value entered into 'Activation Keys' is saved as
`kt_activation_keys` custom parameter and can be used in the kickstart
template like other parameters.

The activation keys are autocompleted for better user experience and
the list of products for each used activation key is displayed at the
bottom of the Katello tab.

Testing
-------

Since this is a Rails engine, it needs a host app to test the
functionality properly. Therefore to run the tests, you need to get
the source for the Foreman, as well as setting the development
environment.

The easiest way to do it is running this rake task:

    rake test:foreman_prepare

This downloads the latest Foreman develop code, as well as installs
required dependencies.

To run the whole suite use:

    rake test

To execute a single test file run:

    ruby -Itest:lib path/to/your_test.rb

Licence
-------

Copyright (c) 2013 Red Hat Inc.

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program.  If not, see <http://www.gnu.org/licenses/>.
