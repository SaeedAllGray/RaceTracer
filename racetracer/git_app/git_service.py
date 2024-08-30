import git

class GitService:
    def __init__(self, path):
        self.repo = git.Repo(path)

    def git_add(self):
        self.repo.git.add(A=True)

    def git_commit(self, message):
        result = self.repo.index.commit('racetracer\n'+message)
        return result

    # def git_diff(self):
    #     print(self.repo.git.diff())
    #     return self.repo.git.diff()

    def git_diff(self, file_paths=None):
        if file_paths:
            diff = self.repo.git.diff(' '.join(file_paths))
        else:
            diff = self.repo.git.diff()
        print(diff)
        return diff
        
    def git_push(self):
        origin = self.repo.remote(name='origin')
        result = origin.push(refspec=f'racetracer:racetracer')
        print(result)
    
    def switchBranch(self):
        if 'racetracer' in self.repo.heads:
            # Switch to existing branch
            new_branch = self.repo.heads['racetracer']
            self.repo.head.reference = new_branch
        else:
            # Create and switch to a new branch
            new_branch = self.repo.create_head('racetracer')
            self.repo.head.reference = new_branch