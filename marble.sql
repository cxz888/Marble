-- MySQL dump 10.13  Distrib 8.0.31, for Win64 (x86_64)
--
-- Host: localhost    Database: marble
-- ------------------------------------------------------
-- Server version	8.0.31

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `pages`
--

DROP TABLE IF EXISTS `pages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `pages` (
  `pg_id` int NOT NULL AUTO_INCREMENT,
  `pg_title` varchar(15) NOT NULL DEFAULT '',
  `pg_content` text NOT NULL,
  PRIMARY KEY (`pg_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pages`
--

LOCK TABLES `pages` WRITE;
/*!40000 ALTER TABLE `pages` DISABLE KEYS */;
INSERT INTO `pages` VALUES (1,'home','# 首页\n\n## 欢迎\n\n这是一个简易的博客网站。\n\n我将这个博客系统命名为 Marble，意为大理石，代表它简洁有力，专注写作的特征。\n\n还有一层原因是，想和我现在投入精力的操作系统 Granite（花岗岩）和打算未来尝试设计的编程语言 Calcite（方解石）呼应。\n\n也许等我以后有精力和能力了，还可以写一个图形引擎，给石头家族多添一员 :)\n\n## 使用指南\n\n上方是导航栏。点击左侧网站标题或 logo 可以回到主页。\n\n导航栏右侧的「登录」目前只能支持博客管理员的登录，不支持注册等。未登录的游客只能浏览文章，暂时无法做出任何其他的互动。\n\n「文章」页面按照时间线列出所有文章列表，点击文章标题即可查看某篇具体的文章。\n\n「关于」页面是我个人的自我介绍。\n\n「友链」页面放着一位指导我搭建博客的大佬的链接。同时也放着目前我维护的博客链接。\n\n右上角还有一个在「日间模式」和「夜间模式」之间切换的按钮。\n\n网站标题下面有 Github 图标和 Home 图标，分别指向我的 Github 帐号和我的博客。\n\n点击登录后，填写用户名密码即可作为博客管理员登录。目前仅有一个管理员账号，用户名为 `blogadmin`，密码为 `123456`。\n\n在登录的状态下，每个页面（主页、关于、友链）上的内容都是可以修改的——点击页面右侧的编辑按钮，编辑后点击保存修改的按钮即可。\n\n同样，文章页面也会有编辑、保存和删除的按钮。\n\n登录状态下，导航栏上会多出「发布」页和注销按钮。可以发布新的文章以及退出登录。\n\n## 未来计划\n\n从上向下的优先级依次降低\n\n- 帐号系统，支持注册、权限等\n- 评论\n- 文章分类、文章标签\n'),(2,'about','# 关于\n\n## 我\n\n- 一个计算机专业的大学生\n- 算是一个技术宅\n- 现在对操作系统很感兴趣\n- 有点二次元\n- 打游戏，不多，手游网游单机荤素不忌\n- 除去编程还写点小说，纯自娱自乐\n- 对世界茫然无知\n\n## 内容\n\n- 写博客的主要原因是想要记录一下学习技术的经历。\n- 偶尔也会写点生活中的事情。\n\n## 技能\n\n- 熟悉使用 Rust\n- 较熟悉使用 C/C++\n- 会使用 Python、JS/TS、Java\n- 参与过算法竞赛\n- 前端开发新手\n\n## 联系方式\n\n- qq:（隐私问题，不公开）\n- idlercloud@gmail.com\n\n## 感谢\n\n- 本站前端使用 [Vue](https://cn.vuejs.org/) 框架完成\n- 使用的后端框架：[Axum](https://github.com/tokio-rs/axum)\n'),(3,'friends','# 友链\n\n|头像|名称|网址|描述|\n|-|-|-|-|\n|<img src=\"https://cxz888.xyz/images/avatar.png\" width=\"50px\" style=\"background-color: transparent;\">|闲云|<https://cxz888.xyz/>|在互联网的小角落里，慢慢学习和生活|\n|<img src=\"https://gravatar.loli.net/avatar/fbd34f6d37010eb9a615fc9cc22e95f0?s=300\" width=\"50px\" style=\"background-color: transparent;\">|TriNitroTofu|<https://tofu.icu/>|\\_(:з」∠)\\_|\n\n## 交换友链\n\n通过“关于”中的联系方式联系我，并提供如下信息：\n\n- 网站名\n- 网址\n- logo 地址\n- 简单的描述\n\n## 本站信息\n\n- 名称：闲云的博客\n- <https://cxz888.xyz>\n- logo: <https://cxz888.xyz/images/avatar.png>\n- 描述：在互联网的小角落里，慢慢学习和生活\n');
/*!40000 ALTER TABLE `pages` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `posts`
--

DROP TABLE IF EXISTS `posts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `posts` (
  `p_id` int NOT NULL AUTO_INCREMENT,
  `p_title` varchar(63) NOT NULL DEFAULT '',
  `p_content` text NOT NULL,
  `p_time` datetime NOT NULL,
  PRIMARY KEY (`p_id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `posts`
--

LOCK TABLES `posts` WRITE;
/*!40000 ALTER TABLE `posts` DISABLE KEYS */;
INSERT INTO `posts` VALUES (2,'Linux 通过 gogs 或 gitea 自建 Git 服务','# Linux 通过 gogs 或 gitea 自建 Git 服务\r\n\r\n之前写课设时因为需要合作，于是在服务器上搭建了一个临时、简陋的 git 服务。\r\n\r\n没有 web 界面，纯命令行交互，添加密钥都要手动 ssh 到服务器。\r\n\r\n这次就尝试用开源应用搭建一个功能完善、使用方便、颜值能打的 git 服务。\r\n\r\n## gogs\r\n\r\n[官网地址](https://gogs.io/)\r\n\r\n国人大佬维护的、以 Golang 开发、支持 Linux、macOS、Windows 和基于 ARM 的操作系统的易用 Git 服务。\r\n\r\n它的优点是所需性能极低，甚至可以在树莓派上运行起来；使用极其简单，只需几步设置。\r\n\r\n预览（图片来自官网）\r\n\r\n![gogs 预览](https://cxz888.xyz/images/gogs_preview.png)\r\n\r\n### 通过 Docker 使用\r\n\r\n这里假设你已经安装好 docker，并且懂得基本的使用。\r\n\r\n```bash\r\n# 拉取官方镜像\r\ndocker pull gogs/gogs\r\n\r\n# 本地创建存放数据的目录\r\nmkdir -p /var/gogs\r\n\r\n# 运行镜像\r\ndocker run --name=gogs -p 10022:22 -p 10880:3000 -v /var/gogs:/data gogs/gogs\r\n```\r\n\r\n`docker run` 中的两个 `-p` 分别代表着 ssh 服务和主服务，将容器内的 22 号端口和 3000 号端口分别映射到外界的 10022 和 10880 端口。\r\n\r\n注意，如果你看了一些过期的教程，它们可能让你将 3000 映射到 10080。从前这是可以的，但是某个版本之后，Chrome 因为安全原因禁止了 10080 端口的访问（Edge 和 Firefox 应该也是）。如果你用 10080，可能就会看到 `error: kex_exchange_identification: client sent invalid protocol identifier` 的错误提示。\r\n\r\n如果一切顺利，现在就可以通过 服务器 IP:10880 在浏览器中看到安装界面了。如下：\r\n\r\n![gogs 安装界面 1](https://cxz888.xyz/images/gogs_installation_1.png)\r\n\r\n数据库可以选 MySQL、PostgreSQL 或 SQLite3。注意如果用 MySQL 需要 5.7 及以上版本。实际上大部分情况 SQLite3 就够用了。\r\n\r\n然后是下面的应用基本设置。\r\n\r\n一般情况下其它不动，尤其是运行系统用户，似乎必须写 git，因为 docker 的运行脚本里面好像硬编码了 RUN_USER 为 git。\r\n\r\n下图红框框选出的三个最好自己决定。应用名称我不知道会影响什么，但域名和应用 url，正如图中提示所言，会影响 clone 的地址。\r\n\r\n![gogs 安装界面 2](https://cxz888.xyz/images/gogs_installation_2.png)\r\n\r\n如果不加修改，最后仓库的 clone 地址就会类似这样：\r\n\r\n![gogs 安装界面 3](https://cxz888.xyz/images/gogs_installation_3.png)\r\n![gogs 安装界面 4](https://cxz888.xyz/images/gogs_installation_4.png)\r\n\r\n下面还有可选设置，如邮件服务器、禁止用户注册等等，不一一介绍。\r\n\r\n现在，点击“立即安装”即可。\r\n\r\n如果没有在可选设置里面注册管理员帐号，那么默认第一个注册的用户即是管理员。\r\n\r\ngogs 的一些设置可以在 数据目录/gogs/conf/app.ini 修改，如：\r\n\r\n![gogs 设置](https://cxz888.xyz/images/gogs_settings.png \"app.ini 位置\")\r\n\r\n设置的名称和格式都比较清楚，如有疑问可以查看 [仓库里的 app.ini](https://github.com/gogs/gogs/blob/main/conf/app.ini)。这是内嵌到二进制分发中的默认设置，其中有每个选项的英文介绍。\r\n\r\n### 二进制安装\r\n\r\n和 Docker 大同小异。这里参考一下 [官方文档](https://gogs.io/docs/installation/install_from_binary)。\r\n\r\n根据自己的版本下载二进制文件，上传到服务器。比如我放在了网站目录，实际上随便放个地方都行。\r\n\r\n然后这里有个需要注意的点，平时我们 ssh 到服务器可能一直都是用的 root 用户。\r\n\r\n而如果你运行 ./gogs web 时用的是 root 用户，应用设置里填的运行系统用户却是 git。那么最后就会报错 运行系统用户非当前用户:git -> root。\r\n\r\n实际上 git 服务也完全不需要 root 用户，我们应该切换到普通用户。\r\n\r\n最好是用 git 这个用户名，这样最后 ssh 的 clone 地址就是 git@xxxx。不过如果你已经安装过 git，那么 git 这个用户可能已经被注册了，而且如果用 su git 切换到这个用户后似乎无法正常使用命令。\r\n\r\ngit 这个用户不行的话，就用 sudo adduser 另外创建用户，比如 sudo adduser gogs。按照指示完成创建，最后用 su gogs 切换过去即可。\r\n\r\ncd 到二进制文件所在的目录，如果直接执行 ./gogs web 可能显示权限不足，那么就先 chmod +x gogs。如果是用 SQLite3 的话，为了后续能创建数据库，这里还要进行一下 chown gogs:gogs /www/wwwroot/repo.cxz888.xyz 把目录的权限赋予给当前用户。\r\n\r\n剩下的就和 docker 差不多了，不过最后 ssh clone 地址是 gogs@xxxx。\r\n\r\n可能遇到的情况是，gogs 默认情况下使用的是 3000 端口。如果你的 3000 端口已经被占用，那可能就需要一些修改。\r\n\r\n按照官方所说，你不应该修改源代码中的 app.ini，而是应该在二进制文件所在目录下新建 custom/conf/app.ini。（docker 方式安装无需担心这点）\r\n\r\n你可以添加如下内容修改端口：\r\n\r\n\r\n[server]\r\nHTTP_PORT        = 10880\r\n\r\n\r\n## gitea\r\n\r\n[官网地址](https://github.com/go-gitea/gitea)\r\n\r\ngitea 是 2016 年的时候从 gogs 项目中 fork 出来的。\r\n\r\n似乎是策略不同，gitea 明显活跃程度更高一些，无论是 issue、PR 还是 commit 都远超 gogs。\r\n\r\n我个人也觉得文档、功能、提示方面 gitea 做得更好。（仅个人感受，无意冒犯）\r\n\r\n我直接尝试了二进制安装，参考 [官方教程](https://docs.gitea.io/zh-cn/install-from-binary/)。\r\n\r\n同样需要把目录权限赋予当前用户。\r\n\r\n如果在 root 用户下启用 ./gitea web，它会提示你 git 不需要用 root 用户并退出，硬要用 root 似乎也可以，按它的提示即可。\r\n\r\n端口默认也是 3000，如有冲突解决方法和 gogs 类似。\r\n\r\n官方提供了一个 [样例](https://github.com/go-gitea/gitea/blob/main/custom/conf/app.example.ini) 来解释你可以设置的选项。\r\n\r\n启动之后的设置和 gogs 基本一样，不过你可以看见，默认主题是暗色主题（我挺喜欢这个）\r\n\r\n预览一下最终界面：\r\n\r\n![gitea 预览](https://cxz888.xyz/images/gitea_preview.png)\r\n\r\n## IP 和端口映射\r\n\r\n到现在为止，无论是 gogs 还是 gitea，也无论如何安装，用户都得通过 服务器 IP:端口 的方式访问主页，这无疑是很不便而丑陋的。\r\n\r\n所以应当通过映射来使用域名直接访问。\r\n\r\n可以参考我的[「个人博客建站笔记」1.网站建成](https://cxz888.xyz/posts/tech/blog_site_note_1/)中域名解析的部分。\r\n\r\n在你的域名服务上提供的 DNS 解析里添加 A 记录。比如我是将 repo.cxz888.xyz 解析到自己的服务器 IP。\r\n\r\nDNS 解析对端口是一无所知的，所以现在得通过 repo.cxz888.xyz:端口号 来访问 git 服务，还是比较丑。\r\n\r\n下一步就是通过宝塔的反向代理来解析端口。如果你不是用宝塔，那么可以根据你使用的 web 服务器软件，如 nginx、apache，去百度或谷歌搜索反向代理的方法。\r\n\r\n> 你也可以顺手给这个网站申请个 SSL 证书\r\n\r\n![宝塔设置反向代理](https://cxz888.xyz/images/gitea_bt_reverse_proxy.png)\r\n\r\n如上图，在宝塔后台设置反向代理，名称随意填，目标 URL 代表你实际要访问的地址，可以填入 http://服务器 IP:端口号，发送域名就填上刚刚解析的域名即可。\r\n\r\n现在，应该可以直接通过域名进入 git 服务了。\r\n\r\n恭喜你完成了自建 git 服务。_★,°_:.☆(￣ ▽ ￣)/$:_.°★_\r\n\r\n如有疑问，欢迎评论留言~\r\n\r\n> 版权声明：本文采用 [CC BY 4.0](http://creativecommons.org/licenses/by/4.0/) 进行许可，转载请注明出处。\r\n\r\n','2022-12-10 15:20:51'),(3,'测试文章 1','# 测试文章 1\n\n## 修改测试 1','2022-12-11 15:57:27'),(7,'最长公共子序列 (LCS) 在 diff 命令中的应用——Myers 算法','# 最长公共子序列 (LCS) 在 diff 命令中的应用——Myers 算法\n\n今天 (2022/2/26) 做 CS 110L 的 week2 作业，内容是用 Rust 编写一个简单的 `diff` 命令。\n\n我才知道原来 Linux 和 Git 的 `diff` 命令，它的底层算法之一叫做 Myers 算法，而其根本原理是最长公共子序列。\n\n本文讲述 **LCS 的使用和 Myers 算法**。前置知识是动态规划求解 LCS。\n\n## diff 命令做了什么\n\n如果你常用 GitHub，应该经常可以看到如下界面。\n\n![diff 示例](http://cxz888.xyz/images/what_diff_does.png)\n\n这表示 `diff` 命令显示出的本次提交和仓库里之前版本的区别。如你所见，红色、以 `-` 开头的行代表删除，绿色、以 `+` 开头的行代表新内容。\n\n你可能会说，上图这样明显是对同一行进行修改，而并没有删除或者添加行啊。确实，但是仔细想想，修改的操作其实可以等价地转换为删除原来的行，然后添上修改之后的行。\n\n这样的等价转换对于底层算法的实现是比较有利的。\n\n我们把代码不同版本的对比问题抽象一下。首先是代码，代码是一个行构成的序列，也就是说，它的先后关系是重要的；那么，两个版本的代码之间的比较，就相当于两个序列之间的比较。\n\n除去删除或者添加的行，你可以看到还有很多不变的行。它们就是两个序列所共有的成分。而你可以想一下，删除的行，实际上是旧版本代码的特有内容；新添的行，实际上是新版本代码的特有内容。\n\n那么每个代码都是由特有和共有的内容混合组成的，如下。\n\ncode1: 共有 1 旧特有 1 共有 2 旧特有 2 旧特有 3 共有 3\n\ncode2: 共有 1 共有 2 新特有 1 共有 3 新特有 2\n\n我们要做的，其实就是判断两个代码之间哪些是共有、哪些是旧版本特有，哪些是新版本特有的。\n\n到这你就可以想到了，共有的成分，那不就是公共子序列吗。\n\n## 最长公共子序列(LCS)\n\n这一部分我假定你是有相关基础的，如果没有的话建议去搜几篇文章看看。\n\n我们来回忆一下，LCS 描述这样一种问题：在两个序列中，找到它们共有的最长的子序列。序列一是 `1 2 3 4`，序列二是 `1 3 4 5`，那么 LCS 就是 `1 3 4`。\n\nLCS 的求法，比较常规的是动态规划 $O(n^2)$ 求解。\n\n假定两个序列是 `s1` 和 `s2`，长度分别为 `n` 和 `m`，我们定义二维数组 `dp[n+1][m+1]`（+1 是为了方便）。`dp[i][j]` 表示“`s1` 前 `i` 项和 `s2` 前 `j` 项的 LCS 的长度”。那么就有如下状态转移函数。\n\n$$\n\\begin{aligned}\ndp[i][j]=\n\\begin{cases}\n&0,&若 i=0 或 j=0\\\\\\\\\n&dp[i-1][j-1]+1,&若s[i-1]=s[j-1]\\\\\\\\\n&max(dp[i-1][j],dp[i][j-1]),&若s[i-1]\\ne s[j-1]\n\\end{cases}\n\\end{aligned}\n$$\n\n## Myers 算法\n\n如果让你用 LCS 来做 `diff`，你会如何完成？我的第一想法是，从`dp[n][m]`开始，可以依次往上追溯，找到所有的公共项。那么两个序列中剩下的部分就是各自特有的了。\n\nMyers 算法也是这个思路，不过它稍微高明一些，在回溯的过程中就同时判定公共项和特有项。\n\n我们先来看一张图。\n\n![LCS 二维表格](http://cxz888.xyz/images/LCS_grid.png)\n\n> 图片来自[这个博客](https://www.cnblogs.com/zqybegin/p/13734107.html)\n\n上图是序列 `ABCBDAB` 和 `BDCABA` 的 dp 结果。箭头表示转移路径。\n\n如你所见，从最右下角出发，沿着路径一直向左上方找到起点（灰色底色）。\n\nMyers 算法的思路就是：如果它是向左上转移，说明这是公共部分；如果向上转移，那么它就是第一个序列的特有部分；如果向左转移，那么就是第二个序列的特有部分。\n\nC++ 代码如下（Rust 直接改的，我没测试）\n\n```cpp\nvoid print_diff(vector<vector<int>> &dp, vector<string> &s1, vector<string> &s2, int i, int j) {\n    if(i > 0 && j > 0 && s1[i - 1] == s2[j - 1]) {\n        print_diff(dp, s1, s2, i - 1, j - 1);\n        cout << \"  \" << s1[i - 1] << endl;\n    } else if(j > 0 && (i == 0 || dp[i][j - 1] >= dp[i - 1][j])) {\n        print_diff(dp, s1, s2, i, j - 1);\n        cout << \"+ \" << s2[j - 1] << endl;\n    } else if(i > 0 && (j == 0 || dp[i][j - 1] < dp[i - 1][j])) {\n        print_diff(dp, s1, s2, i - 1, j);\n        cout << \"- \" << s1[i - 1];\n    } else {\n        cout << endl;\n    }\n}\n```\n\n你可以看到，它是一个递归的做法，以此来让输出顺序颠倒。\n\n你也可以不用递归，每次把输出结果存在一个 `stack` 中，以此用循环完成。\n\n## 总结\n\n有了以上知识点，想实现 `diff` 就很容易了。我们可以用 `getline` 之类的读入代码，用一个 `vector<string>` 存储，每一项存储一行代码。然后再用一个 LCS 函数求出 `dp` 数组。最后传 到`print_diff` 函数，就可以得到结果了。\n\n不过，LCS 的 DP 求解算法复杂度是 $O(n^2)$，而且据说被证明不可改进。所以据说实践中常常用一些线性复杂度的近似算法。\n\n> 版权声明：本文采用<a rel=\"license\" href=\"http://creativecommons.org/licenses/by/4.0/\">CC BY 4.0</a>进行许可，转载请注明出处。\n>\n> 本文链接：<http://cxz888.xyz/posts/tech/lcs_for_diff_myers/>','2022-12-11 17:50:28');
/*!40000 ALTER TABLE `posts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `u_id` int NOT NULL AUTO_INCREMENT,
  `u_name` varchar(20) DEFAULT NULL,
  `u_password` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`u_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'blogadmin','123456');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2022-12-12 13:40:53
