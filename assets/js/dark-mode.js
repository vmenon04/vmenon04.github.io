// Dark Mode Toggle
(function() {
    // Check for saved theme preference or default to light mode
    const currentTheme = localStorage.getItem('theme') || 'light';
    
    // Apply theme immediately to prevent flash
    document.documentElement.setAttribute('data-theme', currentTheme);
    
    // Function to update giscus theme
    function updateGiscusTheme(theme) {
        const iframe = document.querySelector('iframe.giscus-frame');
        if (!iframe) return;
        
        const giscusTheme = theme === 'dark' 
            ? 'https://vmenon04.github.io/assets/css/giscus-dark.css'
            : 'https://vmenon04.github.io/assets/css/giscus-custom.css';
        
        iframe.contentWindow.postMessage(
            { giscus: { setConfig: { theme: giscusTheme } } },
            'https://giscus.app'
        );
    }
    
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
            
            // Update giscus theme
            updateGiscusTheme(newTheme);
        });
    });
})();
