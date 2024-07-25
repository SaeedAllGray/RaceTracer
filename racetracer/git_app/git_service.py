import git

class GitService:
    def __init__(self, path):
        self.repo = git.Repo(path)

    def git_add(self):
        self.repo.git.add(A=True)

    def git_commit(self, message):
        commit_message = message
        self.repo.git.commit(m = commit_message)

    def git_diff(self):
        print(self.repo.git.diff())
        return self.repo.git.diff()
        
    def git_push(self):
        origin = self.repo.remote(name='origin')
        origin.push()

    

        
       