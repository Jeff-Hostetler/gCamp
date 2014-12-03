def create_admin
  User.create!(
    first_name: "Test",
    last_name: "Admin",
    email: "test@test.com",
    password: "password",
    password_confirmation: "password",
    admin: true,
  )
end

def create_user
  User.create!(
    first_name: "Test",
    last_name: "User",
    email: "test@test.com",
    password: "password",
    password_confirmation: "password",
  )
end

def create_project
  Project.create!(
    name: "Test Project",
  )
end

def create_owner(user, project)
  Membership.create!(
    role: "owner",
    user_id: user.id,
    project_id: project.id,
  )
end

def create_member(user, project)
  Membership.create!(
  role: "member",
  user_id: user.id,
  project_id: project.id,
  )
end

def create_task(project)
  Task.create!(
  description: "Test Task",
  project_id: project.id,
  )
end

def create_comment(user, task)
  Comment.create!(
    description: "Test Comment",
    user_id: user.id,
    task_id: task.id,
  )
end
