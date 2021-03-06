std::vector<std::vector<double> > positions_init(int agent_number, 
    double box_size, int dim, std::mt19937& gen, std::string init_mode = "random_uniform")
{
    std::vector<std::vector<double> > positions(agent_number, 
        std::vector<double>(dim));
    // saves current positions for each agent
    
    if (init_mode == "random_uniform")
    {
        // RNG: draw from [0;box_size)
        std::uniform_real_distribution<> dis(0.0, box_size);

        // draw for each agent, for each dimension one random number
        for (int agent_ind = 0; agent_ind < agent_number; agent_ind++)
        {
            for (int dim_ind = 0; dim_ind < dim; dim_ind++)
            {
                positions[agent_ind][dim_ind] = dis(gen);
            }
        }
    }
                      
    return positions;
}

std::vector<std::vector<double> > angles_init(int agent_number, 
    double box_size, int dim, double angle_interval_low, double angle_interval_high,
    std::mt19937& gen, std::string init_mode = "random_uniform")
{
    std::vector<std::vector<double> > angles(agent_number, 
        std::vector<double>(dim-1));
    // saves current angles
 
    if (init_mode == "random_uniform")
    {
        // RNG: draw from [0;box_size)
        std::uniform_real_distribution<> dis(angle_interval_low, angle_interval_high);
        // CAUTION: for generalization to 3D adapt random interval
        
        // draw for each agent, for each dimension one random number
        for (int agent_ind = 0; agent_ind < agent_number; agent_ind++)
        {
            for (int dim_ind = 0; dim_ind < dim-1; dim_ind++)
            {
                angles[agent_ind][dim_ind] = dis(gen);
            }
        }
    }
    return angles;
}
