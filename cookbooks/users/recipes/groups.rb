search(:groups, "*:*").each do |group_data|
	user group_data['id'] do
		gid group_data['gid']
		members group_data['members']
	end
end

include_recipe "users::groups"