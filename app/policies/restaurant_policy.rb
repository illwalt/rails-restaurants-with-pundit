class RestaurantPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      # scope.all because Anyone can view any restaurant
      scope.all

      # display only restaurant belong only to user
      # scope.where(user: user)
    end
  end

  def new?
    return true # Anyone can create a restaurant!
  end

  def create?
    return true
  end

  def show?
    return true
  end

  def edit?
    # rule
    # if I created the restaurant => true
    # otherwise false
    # - user => current_user
    # - record => @restaurant authorized restaurant
    if record.user == user || user.admin
      true
    else
      false
    end
  end

  def update?
    user_is_owner_or_admin
  end

  def destroy?
    # 1. admin user

    # 2. record owner
    user_is_owner_or_admin
  end

  private

  def user_is_owner_or_admin
    record.user == user || user.admin
  end
end
