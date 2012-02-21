module Omega::Hosting
  class AccountsController < ApplicationController

    # GET /accounts
    # GET /accounts.json
    def index
      @accounts = Account.all
  
      respond_to do |format|
        format.html # index.html.erb
        format.json { render json: @accounts }
      end
    end
  
    # GET /accounts/1
    # GET /accounts/1.json
    def show
      @account = Account.find(params[:id])
  
      respond_to do |format|
        format.html # show.html.erb
        format.json { render json: @account }
      end
    end
  
    # GET /accounts/new
    # GET /accounts/new.json
    def new
      @account = Account.new
  
      respond_to do |format|
        format.html # new.html.erb
        format.json { render json: @account }
      end
    end
  
    # GET /accounts/1/edit
    def edit
      @account = Account.find(params[:id])
    end
  
    # POST /accounts
    # POST /accounts.json
    def create
      @account = Account.new(params[:account])

      respond_to do |format|
        if @account.save
					Omega::Permission::DEFAULT_PERMISSIONS.each_key do |perm|
						Omega::Permission.create!(:account_id => @account.id, :name => perm.titleize, :value => perm)
					end
	
					Omega::Role::DEFAULT_ROLES.each_value do |role_attributes|
						role_attributes[:account_id] = @account.id
						Omega::Role.create!( role_attributes )
					end
	
					Omega::Role::DEFAULT_ASSIGNMENTS.each do |internal_role_name, perms|
						role = Omega::Role.find_by_internal_name_and_account_id(internal_role_name, @account.id)
						perms.map! { |perm| Omega::Permission.find_by_value_and_account_id(perm, @account.id) }
						role.permissions << perms
					end
	
					password = params[:user].delete(:password)
					confirm = params[:user].delete(:password_confirmation)
					@admin = User.new(:account_id => @account.id, :email => params[:user][:email], :username => params[:user][:username])
					@admin.password = password
					@admin.password_confirmation = confirm
					@admin.roles << Omega::Role.find_by_internal_name('administrator')
					@admin.save

          format.html { redirect_to @account, notice: 'Account was successfully created.' }
          format.json { render json: @account, status: :created, location: @account }
        else
          format.html { render action: "new" }
          format.json { render json: @account.errors, status: :unprocessable_entity }
        end
      end
    end
  
    # PUT /accounts/1
    # PUT /accounts/1.json
    def update
      @account = Account.find(params[:id])
  
      respond_to do |format|
        if @account.update_attributes(params[:account])
          format.html { redirect_to @account, notice: 'Account was successfully updated.' }
          format.json { head :ok }
        else
          format.html { render action: "edit" }
          format.json { render json: @account.errors, status: :unprocessable_entity }
        end
      end
    end
  
    # DELETE /accounts/1
    # DELETE /accounts/1.json
    def destroy
      @account = Account.find(params[:id])
      @account.destroy
  
      respond_to do |format|
        format.html { redirect_to accounts_url }
        format.json { head :ok }
      end
    end
  end
end
