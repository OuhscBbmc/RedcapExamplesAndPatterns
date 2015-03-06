[![DOI](https://zenodo.org/badge/4971/OuhscBbmc/RedcapExamplesAndPatterns.png)](http://dx.doi.org/10.5281/zenodo.11923)

REDCap Examples and Patterns
================

A public repository sponsored by the Biomedical and Behavioral Methodology Core ([BBMC](http://ouhsc.edu/bbmc/)) in the OUHSC [Pediatrics Dept](http://www.oumedicine.com/pediatrics).  It has two purposes.  First, it contains examples and advice how to connect to the [REDCap](http://www.project-redcap.org/) API, to import and export data.  Second, it demonstrates the software patterns and practice that we believe help an empiricially-driven project:

 1. be developed in parallel across multiple developers and statisticians.
 1. exceed the security standards mandated by campus IT and HIPAA regulations.
 1. minimize spent time on redundant and brittle manipulation code, so there's more time to dedicate to analysis.
 1. be generalizable to other projects, so time you spend learning this structure will help you be more efficient on your subsequent projects.

### Pattern Documentation
We've started a collection of documents that describe the essential features of the patterns we like. Click on any file in the [Documentation Patterns](./documentation_patterns/) directory.  From these documents, you'll be able to follow hyperlinks to examples of each pattern.

### Installation
Instructions for installing the pieces required for generating and running our reports. 
[ResourcesInstallation.md](https://github.com/OuhscBbmc/RedcapExamplesAndPatterns/blob/master/DocumentationGlobal/ResourcesInstallation.md)

### Official Documentation
Most of these links are from the primary developer, and are focused on a specific part of our workflow. 
[ResourcesOfficial.md](https://github.com/OuhscBbmc/RedcapExamplesAndPatterns/blob/master/DocumentationGlobal/ResourcesOfficial.md)

### Opinions
Theis collection of articles, blogs, and unofficial documentation should help provide context for what we're trying to do with our workflow. 
[ResourcesOpinions.md](https://github.com/OuhscBbmc/RedcapExamplesAndPatterns/blob/master/DocumentationGlobal/ResourcesOpinions.md)

### Security Issues
As David says, no matter how cool and efficient our reporting system is, it won't matter if it introduces a security hole.  Make sure that this public GitHub repository does NOT contain any PHI dataset, or a password/token to the MySQL or REDCap server.  As we design and run reports, let's continue to add items to this checklist:
[ReportChecklist.md](https://github.com/OuhscBbmc/RedcapExamplesAndPatterns/blob/master/DocumentationGlobal/ReportChecklist.md)

### Project Health, History, & Guidelines
The repository's website describes the progress from a few perspectives.  The [issue tracker](https://github.com/OuhscCcanMiechvEvaluation/Abcd/issues?state=open) manages the tasks assigned to different collaborators, and lists the associated milestones.  Differences & inconsistencies in programming style should be minimized by following a set of guidelines that we collectively agree upon in [ProjectGuidelines.md](https://github.com/OuhscBbmc/RedcapExamplesAndPatterns/blob/master/DocumentationGlobal/ProjectGuidelines.md).

#### Are You Looking for Moved Files?
The purpose of this repository has evolved a lot in the past year.  If you're looking for a file that's no longer in this repository, please look in the repository dedicated to the common [BBMC resources](https://github.com/OuhscBbmc/BbmcResources).
