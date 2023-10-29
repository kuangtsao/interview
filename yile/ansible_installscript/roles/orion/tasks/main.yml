---

- name: download orion
  get_url:
    url: https://dl.fromer.url/orion_linux_x86-64.tar.gz
    dest: /data/dl/orion_linux_x86-64.tar.gz
    username: yidevops
    password: Log@n0vu3

- name: create orion dir
  file:
    path: /data/disk_test
    state: directory

- name: tar.gz orion
  unarchive:
    src: /data/dl/orion_linux_x86-64.tar.gz
    dest: /data/disk_test
    remote_src: yes
  
- name: copy gp2test.lua to /data/disk_test
  copy:
    src: "gp2test.lua"
    dest: "/data/disk_test"
    remote_src: no

- name: change gp2test.lua url
  replace:
    path: /data/disk_test/gp2test.lua
    regexp: 'test'
    replace: "{{ test_url }}"
