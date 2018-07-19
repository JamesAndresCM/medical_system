module ApplicationHelper
  def usertype_helper
    if current_user&.admin?
      raw("<li class='nav-item dropdown'>
      <a class='nav-link dropdown-toggle' href='' id='navbarDropdown'
      role='button' data-toggle='dropdown' aria-haspopup='true'
      aria-expanded='false'>
          Administracion
      </a>
      <div class='dropdown-menu' aria-labelledby='navbarDropdown'>
        <a class='dropdown-item' href=#{admin_dashboard_users_path}>Administrar Usuarios</a>
        <a class='dropdown-item' href=#{admin_dashboard_doctors_path}>Administrar Medicos</a>
        <a class='dropdown-item' href=#{admin_specialties_path}>Administrar Especialidades</a>
      </div>
    </li>"
      )
    elsif current_user&.user? || current_doctor.present?
      raw("<li class='nav-item'>
          <a class='nav-link' href=#{appointments_path}>Ver Citas Médicas <i style='color: white' class='fa fa-calendar'></i></a>
        </li>")
    end
  end

  def user_links
    if current_user&.user?
    raw("<li class='nav-item'>
          <a class='nav-link' href=#{user_prescription_path(current_user)}>Mis Preescripciones Médicas <i style='color: white' class='fa fa-medkit'></i></a>
        </li>")
    end
  end

  def doctor_links
    if current_doctor.present?
      raw("<li class='nav-item'>
            <a class='nav-link' href=#{doctor_prescription_index_path(current_doctor)}>Preescripción Médica <i style='color: white' class='fa fa-medkit'></i></a>
          </li>" +
          "<li class='nav-item'>
      <a class='nav-link' href=#{doctor_doctor_patients_path(current_doctor)}>Mis Pacientes <i style='color: white' class='fa fa-user-plus'></i></a>
      </li>"+
      "<li class='nav-item'>
            <a class='nav-link' href=#{doctor_time_slot_index_path(current_doctor)}>Horario <i style='color: white' class='fa fa-clock-o'></i></a>
          </li>")
    end
  end
end
