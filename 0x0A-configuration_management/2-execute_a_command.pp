# A script that kills a process

exec { 'pkill':
	command => 'pkill killmenow',
	provider => 'shell',
}
