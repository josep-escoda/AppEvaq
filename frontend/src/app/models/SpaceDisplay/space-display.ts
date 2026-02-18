import { Punt } from "../punt/punt";
export class SpaceDisplay {
    constructor(
        public name: string,
        public zone_id: number,
        public coordinates: Punt[],
        public status: 'unverified' | 'verified',
        public color: string,
        public floor: number,
        public id?: number
    ) { }
}
