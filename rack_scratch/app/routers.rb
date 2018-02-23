# coding: utf-8
# ruby

class Router

  def initialize(request)
    @request = request
  end

  # URL pattern:
  #   GET /resource => index - get a list of the resources
  #   GET /resource/:id => show - geta specific resource
  #   GET /resource/new => new - get an HTML page with a form
  #   POST /resource => creat - create a new resource
  def route!
    if klass = controller_class
      add_route_info_to_request_params!

      controller = klass.new(@request)
      action = route_info[:action]

      if controller.respond_to? action
        puts "\nRouting to #{klass}##{action}"

        # public_send calls public methods only 
        return controller.public_send action 
      end
    end

    not_found
  end

  
  private

  def add_route_info_to_request_params!
    @request.params.merge! route_info
  end

  def controller_class
    # dog => DogController
    Object.const_get("#{route_info[:resource].capitalize}Controller")
  rescue NameError
    nil
  end

  def route_info
    @route_info ||= begin                      
                      resource = path_fragments[0] || "base"
                      id, action = find_id_and_action(path_fragments[1])
                      {resource: resource, action: action, id: id}
                    end
  end

  def find_id_and_action(fragment)
    case fragment
    when "new"
      [nil, :new]
    when nil
      action = if @request.get? then :index else :create end
      [nil, action]
    else
      [fragment, :show]
    end
  end

  def path_fragments
    @fragments ||= @request.path.split("/").reject { |f| f.empty? }
  end
  
  def not_found(message = "Not Found")
    [404, {"Content-Type" => "text/html"}, [message]]
  end
end
