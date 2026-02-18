
import { Routes } from '@angular/router';
import { Login } from './components/login/login';
import { Register } from './components/register/register';
import { Spaces } from './components/spaces/spaces';
import { HomeDashboard } from './components/home-dashboard/home-dashboard';
import { ResponsableZona } from './components/responsable-zona/responsable-zona';
import { ChangePassword } from './components/change-password/change-password';
import { EvacuationComponent } from './components/evacuation/evacuation';

import { AuthGuard } from './auth.guard';

export const routes: Routes = [
  {path: 'responsable', component: ResponsableZona},

  { path: 'login', component: Login },
  { path: 'registrar', component: Register},

  { path: 'home', component: HomeDashboard, canActivate: [AuthGuard] },
  { path: 'spaces', component: Spaces, canActivate: [AuthGuard] },
  { path: 'change-password', component: ChangePassword, canActivate: [AuthGuard] },
  { path: 'evacuation', component: EvacuationComponent, canActivate: [AuthGuard] },

  { path: '', redirectTo: 'responsable', pathMatch: 'full' },
  { path: '**', redirectTo: 'responsable' }
];