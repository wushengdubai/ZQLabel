module Fastlane
  module Actions
    module SharedValues
      REMOVE_TAG_CUSTOM_VALUE = :REMOVE_TAG_CUSTOM_VALUE
    end

    class RemoveTagAction < Action
        def self.run(params)
        # fastlane will take care of reading in the parameter and fetching the environment variable:
        # 以下是最终要执行的内容
        
        # 0.获取参数
        tagName= params[:tag]
        isRemoveLocalTag = params[:rL]
        isRemoveRemoteTag = params[:rR]
        
        # 1、定义一个数组，存放相应的命令
        cmds = []
        
        # 2、删除本地的tag
        if isRemoveLocalTag
            cmds << "git tag -d #{tagName}"
        end
    
        #  3、删除远程tag
        if isRemoveRemoteTag
            cmds << "git push origin :#{tagname}"
        end

        # 4、执行数组中的命令
        result = Actions.sh(cmds.join('&'))
        UI.message("执行完毕 remove_tag的操作 🚀 ")
        return result;
        # sh "shellcommand ./path"

        # Actions.lane_context[SharedValues::REMOVE_TAG_CUSTOM_VALUE] = "my_val"
      end

      #####################################################
      # @!group Documentation
      #####################################################

      def self.description
      # 对于当前Action的简短描述
        "A short description with <= 80 characters of what this action does"
      end

      def self.details
      # 对于当前Action的详细描述
        # Optional:
        # this is your chance to provide a more detailed description of this action
        "You can use this action to do cool things..."
      end

      def self.available_options
        # Define all options your action supports. 
        # 这里是这个Action需要的入参，是同构数组进行分割的，看下面每一个入参的描述的信息，可以大概知道每一个入参的相关配置信息是干啥的

        # Below a few examples
        [
          FastlaneCore::ConfigItem.new(key: :tag,
                                       description: "需要被删除的tag版本", # a short description of this parameter
                                       is_string: true),
          FastlaneCore::ConfigItem.new(key: :rL,
                                       description: "是否需要删除本地标签",
                                       is_string: false, # true: verifies the input is a string, false: every kind of value
                                       default_value: true), # the default value if the user didn't provide one
         FastlaneCore::ConfigItem.new(key: :rR,
                                     description: "是否删除远程标签",
                                      options:true, # 是不是可以省略
                                     is_string: false,
                                     default_value: true)
        ]
      end

      def self.output
        # Define the shared values you are going to provide
        # Example
        [
          ['REMOVE_TAG_CUSTOM_VALUE', 'A description of what this value contains']
        ]
      end

      def self.return_value
        # If your method provides a return value, you can describe here what it does
      end

      def self.authors
        # So no one will ever forget your contribution to fastlane :) You are awesome btw!
        ["wushengdubai"]
      end

      def self.is_supported?(platform)
        # you can do things like
        # 
        #  true
        # 
        #  platform == :ios
        # 
        #  [:ios, :mac].include?(platform)
        # 

        platform == :ios
      end
    end
  end
end
