# Pin npm packages by running ./bin/importmap

pin "application", preload: true
pin "jquery", to: "jquery.slim.js", preload: true # @3.6.1
pin "bootstrap", to: "bootstrap.min.js", preload: true
pin "@popperjs/core", to: "popper.js", preload: true
pin "@nathanvda/cocoon", to: "https://ga.jspm.io/npm:@nathanvda/cocoon@1.2.14/cocoon.js"
pin "imask", to: "https://ga.jspm.io/npm:imask@6.4.2/esm/index.js"