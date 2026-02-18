export interface Evacuation {
    id: number;
    started_at: string;
    ended_at: string | null;
    active: boolean;
    started_by: number | null;
    unverified_spaces_count: number | null;
    created_at: string;
    updated_at: string;
}
