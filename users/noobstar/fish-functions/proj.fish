function proj \
  --description="Navigate to a project folder." \
  --argument-names="project" \
  --wraps="cd" \

  set base $HOME/Projects

  if test -n "$project"
    cd $base/$project
  else
    cd $base
  end

end
