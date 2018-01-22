recipes = File.readlines('db/pdt_recipes.txt')
recipes.map! {|recipe| recipe.strip}.reject! {|recipe| recipe.empty?}

recipes = recipes.slice_before {|recipe| recipe.upcase == recipe}.map do |recipe|
  Cocktail.new_from_book(recipe)
end

User.create(firstname: "Dan", lastname: "O'Dea", username: 'dansbands', password: 'expertleveldrinker', password_confirmation: 'expertleveldrinker', email: "dan@dan.com", age: 100, bio: 'Amateur bartender, musician, and programmer.')

User.create(firstname: "Silvia", lastname: "Chung", username: 'schung97', password: 'ughpasswords', password_confirmation: 'ughpasswords', email: "silvia@silvia.com", age: 23, bio: 'Designer, event planner, and programmer.')
