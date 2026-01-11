// Dark Mode Toggle
(function() {
    // Check for saved theme preference or default to light mode
    const currentTheme = localStorage.getItem('theme') || 'light';
    
    // Apply theme immediately to prevent flash
    document.documentElement.setAttribute('data-theme', currentTheme);
    
    // Wait for DOM to be ready
    document.addEventListener('DOMContentLoaded', function() {
        const toggleButton = document.getElementById('dark-mode-toggle');
        
        if (!toggleButton) return;
        
        // Update button icon based on current theme
        function updateToggleButton(theme) {
            toggleButton.textContent = theme === 'dark' ? '☀️' : '🌙';
            toggleButton.setAttribute('aria-label', 
                theme === 'dark' ? 'Switch to light mode' : 'Switch to dark mode');
        }
        
        // Set initial button state
        updateToggleButton(currentTheme);
        
        // Toggle theme on button click
        toggleButton.addEventListener('click', function() {
            const currentTheme = document.documentElement.getAttribute('data-theme');
            const newTheme = currentTheme === 'dark' ? 'light' : 'dark';
            
            // Apply new theme
            document.documentElement.setAttribute('data-theme', newTheme);
            localStorage.setItem('theme', newTheme);
            
            // Update button
            updateToggleButton(newTheme);
        });
    });
})();
