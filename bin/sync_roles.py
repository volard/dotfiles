import os
import shutil

# 1. scan roles directory (without common_tasks) and gets the list of roles' names
# 2. put the result list in group_vars/all.yml
# 3. put main.yml to role's tasks that not contain it with the tasks defined in common_tasks/include_distribution_tasks.yml

# Get the script's directory and construct paths
script_dir = os.path.dirname(os.path.abspath(__file__))
roles_dir = os.path.normpath(os.path.join(script_dir, '..', 'roles'))
group_vars_file = os.path.normpath(os.path.join(script_dir, '..', 'group_vars', 'all.yml'))
common_tasks_file = os.path.normpath(os.path.join(roles_dir, 'common_tasks/tasks', 'include_distribution_tasks.yml'))

# Check if directories and files exist
if not os.path.exists(roles_dir):
    print(f"\033[91mERROR:\033[0m Roles directory not found: {roles_dir}")
    exit(1)
if not os.path.exists(group_vars_file):
    print(f"\033[91mERROR:\033[0m Group vars file not found: {group_vars_file}")
    exit(1)
if not os.path.exists(common_tasks_file):
    print(f"\033[91mERROR:\033[0m Common tasks file not found: {common_tasks_file}")
    exit(1)

# Get the list of roles, excluding 'common_tasks'
roles = [
    d for d in os.listdir(roles_dir)
    if os.path.isdir(os.path.join(roles_dir, d)) and d not in  ['common_tasks']
]

# Update group_vars/all.yml
with open(group_vars_file, 'r+') as f:
    lines = f.readlines()
    f.seek(0)
    found_default_roles = False
    for line in lines:
        if line.startswith('default_roles:'):
            found_default_roles = True
            f.write('default_roles:\n')
            for role in roles:
                f.write(f'  - {role}\n')
        else:
            if not found_default_roles:
                f.write(line)
    if not found_default_roles:
        f.write('default_roles:\n')
        for role in roles:
            f.write(f'  - {role}\n')
    f.truncate()

# Create tasks subdirectory and tasks/main.yml in each role directory with the roles/common_tasks/tasks/include_discribution_tasks.yml content
for role in roles:
    main_yml_path = os.path.join(roles_dir, role, 'tasks/main.yml')
    tasks_dir = os.path.dirname(main_yml_path)
    if not os.path.exists(tasks_dir):
        os.makedirs(tasks_dir)
    if not os.path.exists(main_yml_path):
        shutil.copyfile(common_tasks_file, main_yml_path)

print()
print("\033[92mINFO:\033[0m Roles updated successfully!")
print()