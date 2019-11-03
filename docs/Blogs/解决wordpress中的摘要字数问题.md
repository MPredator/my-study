解决 Wordpress 中的摘要字数问题
---

Wordpress 是一个比较完善的博客系统, 也是我用来淘汰 Emlog 的方案, 但是最近发现有个问题, 即对中文的文字摘要做的不好, 默认是 55 个字符, 但实际上往往会把整片文章进行输出.

通过搜索引擎可以查阅到以下几个解决方案:

+ [1. WordPress 修改摘要擷取字數](https://v123.tw/wordpress-custom-excerpt-length-2/)
+ [2. WordPress 技巧：正确获取文章摘要](https://blog.wpjam.com/m/get_post_excerpt/)
+ [3. Wordpress 中文摘要插件](https://github.com/overtrue/wp-cn-excerpt)
+ [4. 教程：WordPress完美解决中文摘要不准确问题](https://www.iesay.com/fix-chinese-language-wordpress-excerpts-issue.html)

从这里面可以了解到, 问题的核心在于 Wordpress 的截取算法是默认通过空格进行计算的. 也就是说对于东亚文字而言, 没有空格的长篇大论都是认为是一个字. 所以, 我们需要通过部分的代码修改进行改正.

但是, 考虑到部分文档的历史久远, 以及严谨的态度, 我还是主要从代码出发, 最终定位到代码的位置为 **wordpress/wp-includes/formatting.php line:3699** 版本号为 5.2.4 也就是目前最新的版本:

```php
function wp_trim_excerpt( $text = '', $post = null ) {
	$raw_excerpt = $text;
	if ( '' == $text ) {
		$post = get_post( $post );
		$text = get_the_content( '', false, $post );

		$text = strip_shortcodes( $text );
		$text = excerpt_remove_blocks( $text );

		$text = apply_filters( 'the_content', $text );
		$text = str_replace( ']]>', ']]&gt;', $text );

		$excerpt_length = apply_filters( 'excerpt_length', 55 );
		$excerpt_more = apply_filters( 'excerpt_more', ' ' . '[&hellip;]' );
		$text         = wp_trim_words( $text, $excerpt_length, $excerpt_more );
	}

	return apply_filters( 'wp_trim_excerpt', $text, $raw_excerpt );
}
```

可以看到, 这段代码的主要用途就是截取摘要, 通常, 很多的教程都是在这里进行替换, 将 wp_trim_words 这句改成 substr 或者截取行数之类的, 但实际上这一步是多余的操作. 我们直接看 wp_trim_words 函数:

```php
function wp_trim_words( $text, $num_words = 55, $more = null ) {
	if ( null === $more ) {
		$more = __( '&hellip;' );
	}

	$original_text = $text;
	$text          = wp_strip_all_tags( $text );


	/*
	 * translators: If your word count is based on single characters (e.g. East Asian characters),
	 * enter 'characters_excluding_spaces' or 'characters_including_spaces'. Otherwise, enter 'words'.
	 * Do not translate into your own language.
	 */
	if ( strpos( _x( 'words', 'Word count type. Do not translate!' ), 'characters' ) === 0
        && preg_match( '/^utf\-?8$/i', get_option( 'blog_charset' ) ) )
    {
		$text = trim( preg_replace( "/[\n\r\t ]+/", ' ', $text ), ' ' );
		preg_match_all( '/./u', $text, $words_array );
		$words_array = array_slice( $words_array[0], 0, $num_words + 1 );
		$sep         = '';
	} else {
		$words_array = preg_split( "/[\n\r\t ]+/", $text, $num_words + 1, PREG_SPLIT_NO_EMPTY );
		$sep         = ' ';
	}

	if ( count( $words_array ) > $num_words ) {
		array_pop( $words_array );
		$text = implode( $sep, $words_array );
		$text = $text . $more;
	} else {
		$text = implode( $sep, $words_array );
	}

	return apply_filters( 'wp_trim_words', $text, $num_words, $more, $original_text );
}
```

注意那段注释, 我们可以看到, 对于不同的语言, 实际上是已经做好了判断, 所以, 最简单的做法就是把网站的文字直接定义为中文. 具体的操作就是在 `Settings -> General -> Site Language` 中选择'简体中文'. 然后就可以了. 但是如果想在后台使用英文, 但是实际还是使用中文进行博客撰写的人来说, 只需要将那里面的 `words` 修改成 `characters_excluding_spaces` 就好.

最后修改完成的结果是:

```php
function wp_trim_words( $text, $num_words = 55, $more = null ) {
	if ( null === $more ) {
		$more = __( '&hellip;' );
	}

	$original_text = $text;
	$text          = wp_strip_all_tags( $text );

	/*
	 * translators: If your word count is based on single characters (e.g. East Asian characters),
	 * enter 'characters_excluding_spaces' or 'characters_including_spaces'. Otherwise, enter 'words'.
	 * Do not translate into your own language.
	 */
    // 主要修改这句
	if ( strpos( _x( 'characters_excluding_spaces', 'Word count type. Do not translate!' ), 'characters' ) === 0
        && preg_match( '/^utf\-?8$/i', get_option( 'blog_charset' ) ) )
    {
		$text = trim( preg_replace( "/[\n\r\t ]+/", ' ', $text ), ' ' );
		preg_match_all( '/./u', $text, $words_array );
		$words_array = array_slice( $words_array[0], 0, $num_words + 1 );
		$sep         = '';
	} else {
		$words_array = preg_split( "/[\n\r\t ]+/", $text, $num_words + 1, PREG_SPLIT_NO_EMPTY );
		$sep         = ' ';
	}

	if ( count( $words_array ) > $num_words ) {
		array_pop( $words_array );
		$text = implode( $sep, $words_array );
		$text = $text . $more;
	} else {
		$text = implode( $sep, $words_array );
	}

	return apply_filters( 'wp_trim_words', $text, $num_words, $more, $original_text );
}
```

就解决了.


**PS:**

因为升级 5.2.4 不小心把 content 文件删了... 导致现在 15 年以前的博客中的图显示不全...也是挺惨的, 不恢复了, 反正也用不到了.
