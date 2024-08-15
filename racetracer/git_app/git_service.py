import git

class GitService:
    def __init__(self, path):
        self.repo = git.Repo(path)

    def git_add(self):
        self.repo.git.add(A=True)

    def git_commit(self, message):
        self.repo.index.commit(message)

    def git_diff(self):
        print(self.repo.git.diff())
        return self.repo.git.diff()
        
    def git_push(self):
        origin = self.repo.remote(name='origin')
        result = origin.push(refspec=f'racetracer:racetracer')
        print(result)
    
    def switchBranch(self):
        new_branch = self.repo.create_head('racetracer')
        self.repo.head.reference = new_branch
        self.repo.head.reset(index=True, working_tree=True)