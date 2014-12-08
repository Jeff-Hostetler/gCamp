require "rails_helper"

describe MembershipsController do
  describe "index" do
    it "redirects visitors to login" do
      project = create_project
      user = create_user

      get :index, {project_id: project.id, user_id: user.id}

      expect(response).to redirect_to(login_path)
    end

    it "allows members of projects to view memberships" do
      project = create_project
      user = create_user
      membership = create_member(user, project)
      session[:user_id] = user.id

      get :index, {project_id: project.id}

      expect(response).to be_success
    end

    it "allows admins to view memberships" do
      project = create_project
      admin = create_admin
      session[:user_id] = admin.id

      get :index, {project_id: project.id}

      expect(response).to be_success
    end

    it "does not allow non-members of projects to view memberships" do
      project = create_project
      user = create_user

      session[:user_id] = user.id

      get :index, {project_id: project.id}

      expect(response.status).to eq(404)
    end
  end

  describe "#create" do
    it "allows owner to create memberships" do
      user = create_user
      project = create_project
      membership = create_owner(user, project)
      session[:user_id] = user.id

      post :create, project_id: project.id, membership: { project_id: project, user_id: user, role: "member" }

      expect(response).to render_template('index')
    end

    it "allows admin to create memberships" do
      admin = create_admin
      project = create_project
      session[:user_id] = admin.id

      post :create, project_id: project.id, membership: { project_id: project, user_id: admin, role: "member" }

      expect(response.status).to eq(302)
    end
    it "does not allow member to create memberships" do
      user = create_user
      project = create_project
      membership = create_member(user, project)
      session[:user_id] = user.id

      post :create, project_id: project.id, membership: { project_id: project, user_id: user, role: "member" }

      expect(response.status).to eq(404)
    end
    it "does not allow non-member to create memberships" do
      user = create_user
      project = create_project
      session[:user_id] = user.id

      post :create, project_id: project.id, membership: { project_id: project, user_id: user, role: "member" }

      expect(response.status).to eq(404)
    end
  end

  describe "#update" do
    it "allows owner to update memberships" do
      user = create_user
      user2 = create_user2
      project = create_project
      membership = create_owner(user, project)
      membership2 = create_member(user2, project)
      session[:user_id] = user.id

      patch :update, project_id: project.id, id: membership2.id, membership: { project_id: project, user_id: user2, role: "owner" }

      expect(membership2.reload.role).to eq("owner")
    end
    it "allows admin to update memberships" do
      user = create_user
      admin = create_admin
      project = create_project
      membership = create_owner(user, project)
      session[:user_id] = admin.id

      patch :update, project_id: project.id, id: membership.id, membership: { project_id: project, user_id: user, role: "owner" }

      expect(response.status).to eq(200)
    end
    it "does not allow member to update memberships" do
      user = create_user
      user2 = create_user2
      project = create_project
      membership = create_owner(user, project)
      membership2 = create_member(user2, project)
      session[:user_id] = user2.id

      patch :update, project_id: project.id, id: membership2.id, membership: { project_id: project, user_id: user2, role: "owner" }

      expect(response.status).to eq(404)
    end
    it "does not allow non-member to update memberships" do
      user = create_user
      user2 = create_user2
      project = create_project
      membership = create_owner(user, project)
      session[:user_id] = user2.id

      patch :update, project_id: project.id, id: membership.id, membership: { project_id: project, user_id: user, role: "owner" }

      expect(response.status).to eq(404)
    end
  end

  describe "#destroy" do
    it "allows owner to delete memberships" do
      user = create_user
      user2 = create_user2
      project = create_project
      membership = create_owner(user, project)
      membership2 = create_member(user2, project)
      session[:user_id] = user.id

      expect(Membership.count).to eq(2)

      delete :destroy, project_id: project.id, id: membership2.id

      expect(Membership.count).to eq(1)
    end
    it "allows admin to delete memberships" do
      admin = create_admin
      user = create_user
      user2 = create_user2
      project = create_project
      membership = create_owner(user, project)
      membership2 = create_member(user2, project)
      session[:user_id] = admin.id

      expect(Membership.count).to eq(2)

      delete :destroy, project_id: project.id, id: membership2.id

      expect(Membership.count).to eq(1)
    end
    it "does not allow members to delete other memberships" do
      user = create_user
      user2 = create_user2
      project = create_project
      membership = create_owner(user, project)
      membership2 = create_member(user2, project)
      session[:user_id] = user2.id

      expect(Membership.count).to eq(2)

      delete :destroy, project_id: project.id, id: membership.id

      expect(Membership.count).to eq(2)
    end
    it "members can delete own memberships" do
      user = create_user
      user2 = create_user2
      project = create_project
      membership = create_owner(user, project)
      membership2 = create_member(user2, project)
      session[:user_id] = user2.id

      expect(Membership.count).to eq(2)

      delete :destroy, project_id: project.id, id: membership2.id

      expect(Membership.count).to eq(1)
    end
    it "does not allow non-members to delete memberships" do
      user = create_user
      user2 = create_user2
      project = create_project
      membership = create_owner(user, project)
      session[:user_id] = user2.id

      expect(Membership.count).to eq(1)

      delete :destroy, project_id: project.id, id: membership.id

      expect(Membership.count).to eq(1)
    end
  end
end
