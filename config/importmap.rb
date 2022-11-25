# Pin npm packages by running ./bin/importmap

pin "application", preload: true
pin "jquery", to: "jquery.slim.js", preload: true # @3.6.1
pin "bootstrap", to: "bootstrap.min.js", preload: true
pin "@popperjs/core", to: "popper.js", preload: true
pin "@nathanvda/cocoon", to: "@nathanvda--cocoon.js", preload: true # @1.2.14
# pin "imask", preload: true # @6.4.3