exports.get404 = (req, res) => {
    res.status(404).send({message: 'Page not found'});
};
  