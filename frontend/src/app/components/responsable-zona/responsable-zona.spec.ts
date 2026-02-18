import { ComponentFixture, TestBed } from '@angular/core/testing';

import { ResponsableZona } from './responsable-zona';

describe('ResponsableZona', () => {
  let component: ResponsableZona;
  let fixture: ComponentFixture<ResponsableZona>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [ResponsableZona]
    })
    .compileComponents();

    fixture = TestBed.createComponent(ResponsableZona);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
