guard 'rspec', :version => 2, :bundler => true do
  watch(%r{^spec/.+_spec\.rb$})
  watch(%r{^lib/(.+)\.rb$}) { |m| "spec/#{m[1]}_spec.rb" }
  watch(%r{^config/(.+)\.rb}) { 'spec' }
  watch('spec/spec_helper.rb') { 'spec' }
end
