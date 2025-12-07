// ...existing code...
(function(){
  const tabLogin = document.getElementById('tab-login');
  const tabRegister = document.getElementById('tab-register');
  const loginPanel = document.getElementById('loginPanel');
  const registerPanel = document.getElementById('registerPanel');

  if(!tabLogin || !tabRegister) return;

  function show(mode){
    if(mode === 'register'){
      tabLogin.classList.remove('active'); tabLogin.setAttribute('aria-selected','false');
      tabRegister.classList.add('active'); tabRegister.setAttribute('aria-selected','true');
      loginPanel.classList.add('hidden'); registerPanel.classList.remove('hidden');
    } else {
      tabRegister.classList.remove('active'); tabRegister.setAttribute('aria-selected','false');
      tabLogin.classList.add('active'); tabLogin.setAttribute('aria-selected','true');
      registerPanel.classList.add('hidden'); loginPanel.classList.remove('hidden');
    }
  }

  tabLogin.addEventListener('click', ()=>{ show('login'); history.replaceState(null,'',' #login'); });
  tabRegister.addEventListener('click', ()=>{ show('register'); history.replaceState(null,'',' #register'); });

  function applyHash(){
    const h = (location.hash || '').replace('#','');
    if(h === 'register') show('register'); else show('login');
  }
  window.addEventListener('hashchange', applyHash);
  applyHash();
})();