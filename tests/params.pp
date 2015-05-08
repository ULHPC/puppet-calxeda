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

$names = ["ensure", "ipmi_git", "ipmi_dep", "build_dep", "ipmi_build_dir", "cxmanage_dep", "cxmanage_name"]

notice("calxeda::params::ensure = ${calxeda::params::ensure}")
notice("calxeda::params::ipmi_git = ${calxeda::params::ipmi_git}")
notice("calxeda::params::ipmi_dep = ${calxeda::params::ipmi_dep}")
notice("calxeda::params::build_dep = ${calxeda::params::build_dep}")
notice("calxeda::params::ipmi_build_dir = ${calxeda::params::ipmi_build_dir}")
notice("calxeda::params::cxmanage_dep = ${calxeda::params::cxmanage_dep}")
notice("calxeda::params::cxmanage_name = ${calxeda::params::cxmanage_name}")

#each($names) |$v| {
#    $var = "calxeda::params::${v}"
#    notice("${var} = ", inline_template('<%= scope.lookupvar(@var) %>'))
#}
