class Resolvers::MyProfile < GraphQL::Function
  type do
    name 'MyProfile'

    field :user, Types::UserType
    field :roles, types[Types::RoleType]
  end

  def call(_obj, args, _ctx)
    user = _ctx[:current_user]
    if user != 'Invalid Access Token.'
      roles = Role.where(id: user.role.split(','))
    else
      user = User.new
      roles = Role.new
    end

    OpenStruct.new({
      user: user,
      roles: roles
    })
  end
end
