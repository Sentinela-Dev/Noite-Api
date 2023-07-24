require './app/repositories/user_repository'

module User
  class Select
    def initialize(user_repository: UserRepository)
      @user_repository = user_repository.new
    end

    def fromId(id)
      @user_repository.find_by_id(id)
    end
  end
end
