enum GridState { Init, Active, Paused, Sunset }
modifier onlyActiveGrid() {
    require(state == GridState.Active, "Grid inactive");
    _;
}

