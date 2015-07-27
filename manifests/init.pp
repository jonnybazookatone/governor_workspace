$version = "1.4.1"
  
exec { "download-golang":
  command => "/usr/bin/wget --no-check-certificate -O /usr/local/src/go$version.linux-amd64.tar.gz http://golang.org/dl/go$version.linux-amd64.tar.gz",
  creates => "/usr/local/src/go$version.linux-amd64.tar.gz"
}

exec { "unarchive-golang-tools":
  command => "/bin/tar -C /usr/local -xzf /usr/local/src/go$version.linux-amd64.tar.gz",
  require => Exec["download-golang"]
}

exec { "setup-path":
  command => "/bin/echo 'export PATH=/vagrant/bin:/usr/local/go/bin:\$PATH' >> /home/vagrant/.profile",
}

exec { "setup-workspace":
  command => "/bin/echo 'export GOPATH=/vagrant' >> /home/vagrant/.profile",
}

package { "git":
  ensure => present,
}

Exec["download-golang"] -> Exec["unarchive-golang-tools"] -> Exec["setup-path"] -> Exec["setup-workspace"] -> Package["git"]
