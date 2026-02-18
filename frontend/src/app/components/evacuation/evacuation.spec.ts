import { ComponentFixture, TestBed } from '@angular/core/testing';

import { Evacuation } from './evacuation';

describe('Evacuation', () => {
  let component: Evacuation;
  let fixture: ComponentFixture<Evacuation>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [Evacuation]
    })
    .compileComponents();

    fixture = TestBed.createComponent(Evacuation);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
