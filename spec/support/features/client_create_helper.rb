module Features
  module ClientCreateHelpers
    def create_client(name)
      visit new_client_path
      fill_in "Name", with: name
      find_button("submit_client").click
    end
  end
end
