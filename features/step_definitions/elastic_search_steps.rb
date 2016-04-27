Given("Start indexing") do
    JobRequest.__elasticsearch__.create_index! force: true
    # JobRequest.__elasticsearch__.create_index! index: 'test_job_requests', force: true
    # JobRequest.__elasticsearch__.refresh_index! index: 'test_job_requests'
    # JobRequest.import index: 'test_job_requests'
    puts JobRequest.all.to_a
end

# After('@requires_indexing') do
#     #JobRequest.__elasticsearch__.delete_index! index: 'test_job_requests'
#     #JobRequest.__elasticsearch__.index_name = 'not-test_job_requests'
#     puts JobRequest.all.to_a

# end