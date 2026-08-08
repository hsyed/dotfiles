{
  programs.herdr = {
    enable = true;

    settings.ui = {
      agent_panel_sort = "spaces";
      sidebar_width = 40;
      sidebar_max_width = 48;

      sidebar.agents.rows_by_agent.cursor = [
        [
          "state_icon"
          {
            token = "agent";
            fg = "#bac2de";
            dim = false;
          }
          "state_text"
        ]
        [
          {
            token = "terminal_title_stripped";
            fg = "#cdd6f4";
            bold = false;
            dim = false;
          }
        ]
        [
          {
            token = "workspace";
            fg = "#bac2de";
            dim = false;
          }
          {
            token = "tab";
            fg = "#bac2de";
            dim = false;
          }
        ]
      ];

      sidebar.agents.rows_by_agent.opencode = [
        [
          "state_icon"
          {
            token = "agent";
            fg = "#bac2de";
            dim = false;
          }
          "state_text"
        ]
        [
          {
            token = "terminal_title_stripped";
            fg = "#cdd6f4";
            bold = false;
            dim = false;
          }
        ]
        [
          {
            token = "workspace";
            fg = "#bac2de";
            dim = false;
          }
          {
            token = "tab";
            fg = "#bac2de";
            dim = false;
          }
        ]
      ];

      sidebar.agents.rows_by_agent.codex = [
        [
          "state_icon"
          {
            token = "agent";
            fg = "#bac2de";
            dim = false;
          }
          "state_text"
        ]
        [
          {
            token = "terminal_title_stripped";
            fg = "#cdd6f4";
            bold = false;
            dim = false;
          }
        ]
        [
          {
            token = "workspace";
            fg = "#bac2de";
            dim = false;
          }
          {
            token = "tab";
            fg = "#bac2de";
            dim = false;
          }
        ]
      ];
    };
  };
}
