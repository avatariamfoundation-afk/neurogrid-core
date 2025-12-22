const axios = require('axios');
require('dotenv').config();

const BIO_SYNC_API_URL = process.env.BIO_SYNC_API_URL || 'https://api.aetherabiosync.com';
const BIO_SYNC_API_KEY = process.env.BIO_SYNC_API_KEY || 'your-biosync-api-key';

// Function to send post-operative care data to Aethera BioSync
async function sendPostOpDataToBioSync(patientId, postOpData) {
  try {
    const response = await axios.post(`${BIO_SYNC_API_URL}/postop-data`, 
      { patientId, data: postOpData }, 
      {
        headers: {
          'Authorization': `Bearer ${BIO_SYNC_API_KEY}`,
          'Content-Type': 'application/json'
        }
      }
    );
    return response.data;
  } catch (error) {
    console.error('Error sending data to BioSync:', error.message);
    throw new Error('Failed to send data to BioSync');
  }
}

// Function to retrieve patient recovery data from BioSync
async function getPatientRecoveryData(patientId) {
  try {
    const response = await axios.get(`${BIO_SYNC_API_URL}/recovery-data/${patientId}`, {
      headers: {
        'Authorization': `Bearer ${BIO_SYNC_API_KEY}`
      }
    });
    return response.data;
  } catch (error) {
    console.error('Error fetching recovery data from BioSync:', error.message);
    throw new Error('Failed to fetch recovery data from BioSync');
  }
}

module.exports = {
  sendPostOpDataToBioSync,
  getPatientRecoveryData
};
