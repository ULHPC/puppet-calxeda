# File::      <tt>params.pp</tt>
# Author::    UL HPC Management Team (hpc-sysadmins@uni.lu)
# Copyright:: Copyright (c) 2015 UL HPC Management Team
# License::   Gpl-3.0
#
# ------------------------------------------------------------------------------
# You need the 'future' parser to be able to execute this manifest (that's
# required for the each loop below).
#
# Thus execute this manifest in your vagrant box as follows:
#
#      sudo puppet apply -t --parser future /vagrant/tests/params.pp
#
#

include 'calxeda::params'

$names = ['ensure', 'protocol', 'port', 'packagename']

notice("calxeda::params::ensure = ${calxeda::params::ensure}")
notice("calxeda::params::protocol = ${calxeda::params::protocol}")
notice("calxeda::params::port = ${calxeda::params::port}")
notice("calxeda::params::packagename = ${calxeda::params::packagename}")

#each($names) |$v| {
#    $var = "ULHPC/calxeda::params::${v}"
#    notice("${var} = ", inline_template('<%= scope.lookupvar(@var) %>'))
#}
