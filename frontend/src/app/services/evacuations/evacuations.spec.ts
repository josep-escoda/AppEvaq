import { TestBed } from '@angular/core/testing';

import { Evacuations } from './evacuations';

describe('Evacuations', () => {
  let service: Evacuations;

  beforeEach(() => {
    TestBed.configureTestingModule({});
    service = TestBed.inject(Evacuations);
  });

  it('should be created', () => {
    expect(service).toBeTruthy();
  });
});
