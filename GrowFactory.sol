pragma solidity ^0.4.19;

contract GrowFactory {
  // Grow identifying information, environmental data, component states
  struct Grow {
    uint id;
    string name;
    uint temp;
    uint humidity;
    uint soilMoisture;
    uint lightIntensity;
    bool intakeActive;
    bool exhaustActive;
    bool waterActive;
    bool lightActive;
  }

  // Grow added
  event GrowAdded(uint id, string name);
  // Temperature changed
  event TempChange(uint id, uint temp);
  // Humidity changed
  event HumidityChange(uint id, uint humidity);
  // Soil Moisture changed
  event SoilMoistureChange(uint id, uint soilMoisture);
  // Light Intensity changed
  event LightIntensityChange(uint id, uint lightIntensity);
  // Intake toggled on/off
  event IntakeToggled(uint id, bool intakeActive);
  // Exhaust toggled on/off
  event ExhaustToggled(uint id, bool exhaustActive);
  // Water toggled on/off
  event WaterToggled(uint id, bool waterActive);
  // Light toggled on/off
  event LightToggled(uint id, bool lightActive);

  // Associate Grow with an owner address
  mapping(uint => address) public growToOwner;
  // Associate Grow with a bucket address
  mapping(uint => address) public growToBucket;

  // Unique Grow identifier
  uint currentGrowId = 0;

  // Collection of Grows
  Grow[] public grows;

  // Create new Grow
  // Assign to sender address
  // Trigger GrowAdded event
  // Increment unique Grow identifier
  function createGrow(string _newName, address _newBucketAddress) public {
    grows.push(Grow(currentGrowId, _newName, 0, 0, 0, 0, false, false, false, false));
    growToOwner[currentGrowId] = msg.sender;
    growToBucket[currentGrowId] = _newBucketAddress;
    GrowAdded(currentGrowId, _newName);
    currentGrowId++;
  }

  // Address permission helper
  function isPermittedAddress(uint _growId, address _senderAddress) private constant returns (bool) {
    return _senderAddress == growToOwner[_growId] || _senderAddress == growToBucket[_growId];
  }

  // Setters
  // Check that sender owns the Grow
  // Update stored value for a Grow
  // Trigger change event
  function setTemp(uint _growId, uint _newTemp) public {
    require(isPermittedAddress(_growId, msg.sender));
    grows[_growId].temp = _newTemp;
    TempChange(_growId, _newTemp);
  }

  function setHumidity(uint _growId, uint _newHumidity) public {
    require(isPermittedAddress(_growId, msg.sender));
    grows[_growId].humidity = _newHumidity;
    HumidityChange(_growId, _newHumidity);
  }

  function setSoilMoisture(uint _growId, uint _newSoilMoisture) public {
    require(isPermittedAddress(_growId, msg.sender));
    grows[_growId].soilMoisture = _newSoilMoisture;
    SoilMoistureChange(_growId, _newSoilMoisture);
  }

  function setLightIntensity(uint _growId, uint _newLightIntensity) public {
    require(isPermittedAddress(_growId, msg.sender));
    grows[_growId].lightIntensity = _newLightIntensity;
    LightIntensityChange(_growId, _newLightIntensity);
  }

  function toggleIntake(uint _growId) public {
    require(isPermittedAddress(_growId, msg.sender));
    bool newIntakeActive = !grows[_growId].intakeActive;
    grows[_growId].intakeActive = newIntakeActive;
    IntakeToggled(_growId, newIntakeActive);
  }

  function toggleExhaust(uint _growId) public {
    require(isPermittedAddress(_growId, msg.sender));
    bool newExhaustActive = !grows[_growId].exhaustActive;
    grows[_growId].exhaustActive = newExhaustActive;
    ExhaustToggled(_growId, newExhaustActive);
  }

  function toggleWater(uint _growId) public {
    require(isPermittedAddress(_growId, msg.sender));
    bool newWaterActive = !grows[_growId].waterActive;
    grows[_growId].waterActive = newWaterActive;
    WaterToggled(_growId, newWaterActive);
  }

  function toggleLight(uint _growId) public {
    require(isPermittedAddress(_growId, msg.sender));
    bool newLightActive = !grows[_growId].lightActive;
    grows[_growId].lightActive = newLightActive;
    LightToggled(_growId, newLightActive);
  }

  // Getters
  function getTemp(uint _growId) public constant returns (uint) {
    return grows[_growId].temp;
  }

  function getHumidity(uint _growId) public constant returns (uint) {
    return grows[_growId].humidity;
  }

  function getSoilMoisture(uint _growId) public constant returns (uint) {
    return grows[_growId].soilMoisture;
  }

  function getLightIntensity(uint _growId) public constant returns (uint) {
    return grows[_growId].lightIntensity;
  }

  function isIntakeActive(uint _growId) public constant returns (bool) {
    return grows[_growId].intakeActive;
  }

  function isExhaustActive(uint _growId) public constant returns (bool) {
    return grows[_growId].exhaustActive;
  }

  function isWaterActive(uint _growId) public constant returns (bool) {
    return grows[_growId].waterActive;
  }

  function isLightActive(uint _growId) public constant returns (bool) {
    return grows[_growId].lightActive;
  }
}
