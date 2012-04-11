Description
===========

Cookbook to automatically deploy the Gdash web interface for
Graphite.

Requirements
============

## Platform:

 * Debian/Ubuntu

## Cookbooks

 * build-essentials
 * runit

Attributes
==========

 See `attributes/default.rb` for defaults.

 * `node['gdash']['graphite_whisperdb']` - Full path to graphite
   database
 * `node['gdash']['templatedir']` - Full path to graph templates

Usage
=====

This cookbook currently sets up gdash and a basic runit service.
Graph creation is left to the user.

