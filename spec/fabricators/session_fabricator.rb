Fabricator(:session) do
  user { User.first || Fabricate(:user) }
end
