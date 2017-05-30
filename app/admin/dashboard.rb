ActiveAdmin.register_page "Dashboard" do

  menu priority: 1, label: proc{ I18n.t("active_admin.dashboard") }

  content title: proc{ I18n.t("active_admin.dashboard") } do
    columns class: "columns dashboard-columns" do
      column do
        panel "Students Online" do
          User.students.online.count
        end

        panel "Active Students" do
          User.students.count
        end

        panel "Inactive Students" do
          User.inactive.students.count
        end
      end

      column do
        panel "Teachers Online" do
          User.teachers.online.count
        end

        panel "Active Teachers" do
          User.teachers.count
        end

        panel "Inactive Teachers" do
          User.inactive.teachers.count
        end
      end
    end
  end # content
end
