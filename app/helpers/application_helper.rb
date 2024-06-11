module ApplicationHelper
    def default_meta_tags
        {
          site: 'Post代行',
          title: '〜面倒くさがりの君へ〜',
          reverse: true,
          charset: 'utf-8',
          description: 'Chat-GPTがあなたの代わりにXのPostを考えてくれます',
          keywords: 'X,Chat-GPT,ポスト',
          canonical: request.original_url,
          separator: '|',
          og: {
            site_name: :site,
            title: :title,
            description: :description,
            type: 'website',
            url: request.original_url,
            image: image_url('Post.png'), # 配置するパスやファイル名によって変更すること
            local: 'ja-JP'
          },
          # Twitter用の設定を個別で設定する
          twitter: {
            card: 'summary_large_image', # Twitterで表示する場合は大きいカードにする
            site: '@omaty410', # アプリの公式Twitterアカウントがあれば、アカウント名を書く
            image: image_url('Post.png') # 配置するパスやファイル名によって変更すること
          }
        }
      end
end
