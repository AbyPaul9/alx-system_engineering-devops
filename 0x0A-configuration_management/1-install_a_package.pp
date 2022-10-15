# installing puppet link
include python
include python::flask

package { 'flask':
    ensure   => '2.1.0',
    provider => 'pip',
    require  => Class['python::flask'],
}
