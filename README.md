# Project AiAi

[![GitHub Commits Count](https://img.shields.io/github/commits-since/AiAiHealthcare/ProjectAiAi/0.0.svg?maxAge=300&label=Github%20Commits)](https://github.com/AiAiHealthcare/ProjectAiAi/graphs/punch-card)

AiAi.care project is teaching computers to "see" chest X-rays and interpret them how a human Radiologist would. We are using 700,000 labeled Chest X-Rays + Deep Learning to build an FDA 💊 approved, open-source screening tool for Tuberculosis and Lung Cancer. After an MRMC clinical trial, AiAi CAD will be distributed for free to emerging nations, charitable hospitals, and organizations like WHO 🌏 

Our secondary goal is to open-source **'Medical Imagenet'** pretrained models and weights.  Medical data is hard to obtain, so many current Radiology-AI papers rely on transfer-learning ImageNet weights.  There are significant differences between ImageNet images (color, low-res, high-contrast) and Radiology images (grayscale, high-res, low-contrast), so we believe that our Medical Imagenet weights will improve sensitivity and specificity across the board for future research. 

If you are looking for a non-technical introduction to Project AiAi, please [click here to visit https://AiAi.care website](https://AiAi.care).  In case you were wondering about the project's name, AiAi stands for _AI Augmented Imaging_.


[![Follow Our Twitter Updates](https://img.shields.io/twitter/follow/AiAiHealthcare.svg?style=social&label=Follow&maxAge=3600)](https://twitter.com/AiAiHealthcare/) 
[![Join Gitter Discussion](https://img.shields.io/gitter/room/AiAi-care/Lobby.svg?maxAge=3600)](https://gitter.im/AiAi-care/Lobby) 
[![Website](https://img.shields.io/website-up-down-green-red/https/AiAi.care.svg?maxAge=3600)](https://AiAi.care/) 


# Project Milestones 
Here are [major milestones](https://github.com/AiAiHealthcare/ProjectAiAi/milestones) for the project and target completion dates:

1. :white_check_mark: X-Ray and CT Data Loading, Cleaning _(Completed Feb 1, 2017)_
1. :white_check_mark: Deep Learning Docker Image (**PyTorch**, HIPAA) _(Completed Feb 28, 2017 )_
1. :white_check_mark: Data Augmentation Tests : March 30, 2017 _(Completed May 2017)_
1. :white_check_mark: Level 1 Models : April 12, 2017 _(Completed May 2017)_
1. :white_check_mark: HIPAA IT Audit and Validation : December 30, 2017 _(Internal Audit Completed 2017)_
1. :soon: Experiements with DL architectures, activations, and augmentation: _(In Progress, ETA Q2 2019)_
1. :soon: Incorporate 500,000+ additional DR (Digital Radiograph) images in dataset. _(In Progress, ETA Feb 2019)_
1. Level 2/3 model ensembles (Detection, Classification) : _(In Progress, ETA Q2 2019)_
1. Build mobile-friendly front-end for AiAi CAD (Computer Aided Detection) : Q2 2019
1. PACS / VNA / DICOM / HL7 / EHR ingestion engine Q3 2019
1. MRMC clinical validation for FDA application : Q3 2019


# Donate your DL / FHIR / PACS Expertise

If you are a Machine Learning maestro, Kaggle king, or HL7 hacker then please check out our [KANBAN project tracker here](https://github.com/AiAiHealthcare/ProjectAiAi/projects/1?fullscreen=true). You can donate your time and expertise by contributing to any of the issues/tasks pinned on the KANBAN board.


# Contribute to Legal Strategy Wiki

Project AiAi is the first effort of its kind to donate an open-source, medical algorithm to the world.  This presents some interesting legal challenges, so we have [set up a wiki page where lawyers can donate their time and advice for Project AiAi.](https://github.com/AiAiHealthcare/ProjectAiAi/wiki)
