module ApplicationHelper
  def usertype_helper
    if current_user.role.superadmin_role?
      content_tag(:a ,(link_to "Admin", rails_admin.dashboard_path,method: :get,style:"text-decoration: none; color: white;"),class:"nav-link", style:"color: white")
    elsif current_user.role.supervisor_role?
      content_tag(:a ,content_tag(:href, 'supervisor'),class:"nav-link", style:"color: white")
    end
  end
end
