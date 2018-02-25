# coding: utf-8
# ruby

class BaseController
  attr_reader :request
  
  def initialize(request)
    @request = request
  end

  def index
    @title = "Welcome to my zoo!"
    build_response render_template
  end

  private

  def render_template(name = params[:action])
    templates_dir = self.class.name.downcase.sub("controller", "")
    template_file = File.join(templates_dir, "#{name}.html.erb")
    file_path = template_file_path_for template_file
    
    if File.exists? file_path
      puts "Rendering template file #{template_file}"
      render_file file_path
    else
      "ERROR: template file not found #{template_file}"
    end
  end

  def render_partial(template_file)
    file_path = template_file_path_for template_file
    
    if File.exists? file_path
      puts "Rendering partial file #{template_file}"
      render_file file_path
    else
      "ERROR: partial file not found #{template_file}"
    end
  end

  def template_file_path_for(template_file)
    File.expand_path(File.join("../../views", template_file), __FILE__)
  end

  def render_file(file_path)
    erb_file = File.read(file_path)
    
    # binding is a method of Ruby core which returns the current 
    # Binding object as the evaluation context
    ERB.new(erb_file).result(binding)
  end
  
  def build_response(body, status: 200)
    [status, {"Content-Type" => "text/html"}, [body]]
  end

  def redirect_to(uri)
    [302, {"Location" => uri}, []]
  end

  def params
    @request.params
  end
end
