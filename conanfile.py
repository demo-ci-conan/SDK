from conans import ConanFile

class SDK(ConanFile):
    name = "sdk"
    version = "0.0"

    scm = {"type": "git",
           "url": "auto",
           "revision": "auto"}

    def requirements(self):
        self.requires("App1/0.0@demo/testing")
        self.requires("App2/0.0@demo/testing")
