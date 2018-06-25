module ApplicationHelper
  def usertype_helper
    if current_user.role.superadmin_role?
      raw("<li class='nav-item dropdown'>
      <a class='nav-link dropdown-toggle' href='' id='navbarDropdown'
      role='button' data-toggle='dropdown' aria-haspopup='true'
      aria-expanded='false'>
          Administracion
      </a>
      <div class='dropdown-menu' aria-labelledby='navbarDropdown'>
         <a class='dropdown-item' href=#{rails_admin.dashboard_path}>Panel de Administracion</a>
      </div>
    </li>"
      )
    elsif current_user.role.supervisor_role?
      raw("<li class='nav-item-active'>
            <a class='nav-link'>Supervisor</a></li>")
    end
  end

  def options_user
    raw("<li class='nav-item dropdown mr-2'>
    <a class='nav-link dropdown-toggle' href='' id='navbarDropdown'
    role='button' data-toggle='dropdown' aria-haspopup='true'
    aria-expanded='false'>
        Opciones
    </a>
      <div class='dropdown-menu dropdown-margin' aria-labelledby='navbarDropdown'>
         <a class='dropdown-item' href=#{edit_user_registration_path}>Perfil</a>
         <a class='dropdown-item' data-method='delete' href=#{destroy_user_session_path}>Logout</a>
    </div>
    </li>")
  end
end
