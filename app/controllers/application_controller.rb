class ApplicationController < ActionController::Base
  ## 初期設定で用意されていないカラムを追加しているときに必要になる
  # devise利用の機能が使われる場合、その前にconfigure_permitted_parametersが実行される
  before_action :configure_permitted_parameters, if: :devise_controller?

  # deviseはデフォルトではルートにルーティングする
  # ここを追加することでリダイレクト先を変更できる
	def after_sign_in_path_for(resource)
		user_path(current_user)
	end

  protected

  def configure_permitted_parameters
    # ユーザ登録（sign_up）の際に、name,emailの操作を許可
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :email])
    # ユーザ登録（sign_in）の際に、nameの操作を許可
    devise_parameter_sanitizer.permit(:sign_in, keys: [:name])
  end
end
