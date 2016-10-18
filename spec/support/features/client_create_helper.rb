module Features
  module ClientCreateHelpers
    def create_client(first_name, last_name)
      visit new_client_path
      fill_in "First name", with: first_name
      fill_in "Last name", with: last_name
      find_button("submit_client").click
    end
  end
end
