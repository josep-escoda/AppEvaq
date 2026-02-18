import { Punt } from "../punt/punt";
import { Zone } from "../zone/zone";

export class Space {
    constructor(
        public name: string,
        public zone_id: number,
        public coordinates: Punt[],
        public status: 'unverified' | 'verified',
        public floor: number,
        public created_at?: string,
        public updated_at?: string,
        public zone?: Zone[],
        public color?: string,
        public id?: number
    ) { }
}
