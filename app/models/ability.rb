class Ability
  include CanCan::Ability

  def initialize(user)
    #alias action para administrar Controladores por roles de usuarios
    alias_action :create, :read, :update, :destroy, to: :crud
    # Define abilities for the passed in user here. For example:
    #
    #   user ||= User.new # guest user (not logged in)
    #   if user.admin?
    #     can :manage, :all
    #   else
    #     can :read, :all
    #   end
    #
    # The first argument to `can` is the action you are giving the user
    # permission to do.
    # If you pass :manage it will apply to every action. Other common actions
    # here are :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on.
    # If you pass :all it will apply to every resource. Otherwise pass a Ruby
    # class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the
    # objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, :published => true
    #
    # See the wiki for details:
    # https://github.com/CanCanCommunity/cancancan/wiki/Defining-Abilities
    user ||= User.new # guest user (not logged in)

    #superadmin puede administrar todos los controllers, ademas tiene visibilidad para rails_admin definido en el partial _nav
    if user.role.superadmin_role
        can :manage, :all
        can :access, :rails_admin       # only allow admin users to access Rails Admin
        can :dashboard                  # allow access to dashboard
      #usuario supervisor, puede ejecutar tareas administrativas en los controlladores
    elsif user.role.supervisor_role?
        #can :manage, Post
        #can :manage, Comment
      #usuario normal puede ejecutar las acciones del crud solo para el
    elsif user.role.user_role?
        #can :crud, Post , user_id: user.id
        #can :crud, Comment, user_id: user.id
        can :crud, User, user_id: user.id
    end
  end
end
