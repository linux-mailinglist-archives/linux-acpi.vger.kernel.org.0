Return-Path: <linux-acpi+bounces-12045-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BC2EA5A659
	for <lists+linux-acpi@lfdr.de>; Mon, 10 Mar 2025 22:42:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 84B45171F0E
	for <lists+linux-acpi@lfdr.de>; Mon, 10 Mar 2025 21:42:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 295981E3787;
	Mon, 10 Mar 2025 21:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wk22D0YR"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA8D41581F9;
	Mon, 10 Mar 2025 21:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741642974; cv=none; b=Qz3ZWC59Hb+W5DebG5J4fGzB3S977K5Nxpc6NIJJoFKOcMFzA2ZtXiOAw86+MH8ahPnSz010vnrPR2VPxZVLVil1w7wDGkj8KuFen3EAlpaQXhxen8yQokhKGkHW+s77InbeCDYKT/jV6wtiqImAq+r3ipf8/wN4NU83Xkw0nHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741642974; c=relaxed/simple;
	bh=Hgfqycyk5WAvowUEhLw7wDnMIf6XtuNalb//mZR8AGY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=WHbKGBbokUAvF+jBKCvHATJWu+0Vyrq7oUcOX6GKrhE91bAho4sEJVbZ9JkmdRtwHC7cHqBSM880vAgpWpJrIS7wHet9V+1hmay6u5YlwdOqardabvX2LbTPehHyQWUKyLs6HHbEuGsZjyUKVIRDr/yaTiK1rQs0xWRaC98UThI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wk22D0YR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DFACC4CEE5;
	Mon, 10 Mar 2025 21:42:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741642973;
	bh=Hgfqycyk5WAvowUEhLw7wDnMIf6XtuNalb//mZR8AGY=;
	h=From:To:Cc:Subject:Date:From;
	b=Wk22D0YR3b17pAiC+UtyGJTkNn4f/SCu58jZlCG8EtJEsYJE0ZTS7FDv7FGYZgvo3
	 Zw8aIH8Jp1FwXbXAKz+bXKMERwjfFMFrUhJ0bUcw9ic883MXTGjJpiXBmpnrELzxZu
	 Mr58Hq9+71qorcYrzyL+gee8iYn8JNfHk+Q7POStc5sVPiu5Le65C7DRvQIfu/QqHc
	 Q59Vnn81tapAcI+efnO87N5WZNvAhSAit/vSYI+8ZgxhWImDr35+sZnF9RQ+XRNZAw
	 JmkXhvO5xve9PBgSf/UKOUo/1PYDM7dqDlsGK0bSJwkKR2cA3JYZeD9eBe9rwNQ4Sl
	 4C8cAPiiEkUmg==
From: Kees Cook <kees@kernel.org>
To: Miguel Ojeda <ojeda@kernel.org>
Cc: Kees Cook <kees@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Marco Elver <elver@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Hao Luo <haoluo@google.com>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Johannes Weiner <hannes@cmpxchg.org>,
	linux-acpi@vger.kernel.org,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Alexander Potapenko <glider@google.com>,
	Yafang Shao <laoar.shao@gmail.com>,
	Jan Hendrik Farr <kernel@jfarr.cc>,
	Tony Ambardar <tony.ambardar@gmail.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Alice Ryhl <aliceryhl@google.com>,
	Tejun Heo <tj@kernel.org>,
	Yoann Congal <yoann.congal@smile.fr>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Jens Axboe <axboe@kernel.dk>,
	Chen Ridong <chenridong@huawei.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Jann Horn <jannh@google.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev,
	linux-hardening@vger.kernel.org
Subject: [PATCH] compiler_types: Introduce __nonstring_array
Date: Mon, 10 Mar 2025 14:42:48 -0700
Message-Id: <20250310214244.work.194-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4227; i=kees@kernel.org; h=from:subject:message-id; bh=Hgfqycyk5WAvowUEhLw7wDnMIf6XtuNalb//mZR8AGY=; b=owGbwMvMwCVmps19z/KJym7G02pJDOnnY250lb4+9jb5eIJS+5/U8MWXp+Qst9x3Yqqd93nNg MnXEhwndJSyMIhxMciKKbIE2bnHuXi8bQ93n6sIM4eVCWQIAxenAEwk/CzDf9eb1ZL5xsK7Ox6a dWptfW1umrQ/PPH6fWmtGbVi7n5aNgz/NH09gypDt73QUtNrmx0wYxWr98x/dmGb97hmvX0jPWc GJwA=
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

GCC has expanded support of the "nonstring" attribute so that it can be
applied to arrays of character arrays[1], which is needed to identify
correct static initialization of those kinds of objects. Since this was
not supported prior to GCC 15, we need to distinguish the usage of Linux's
existing __nonstring macro for the attribute for non-multi-dimensional
char arrays. Until GCC 15 is the minimum version, use __nonstring_array to
mark arrays of non-string character arrays. (Regular non-string character
arrays can continue to use __nonstring.)

This allows for changes like this:

-static const char table_sigs[][ACPI_NAMESEG_SIZE] __initconst = {
+static const char table_sigs[][ACPI_NAMESEG_SIZE] __nonstring_array __initconst = {
        ACPI_SIG_BERT, ACPI_SIG_BGRT, ACPI_SIG_CPEP, ACPI_SIG_ECDT,

Which will silence the coming -Wunterminated-string-initialization
warnings in GCC 15:

In file included from ../include/acpi/actbl.h:371,                                                                   from ../include/acpi/acpi.h:26,                                                                     from ../include/linux/acpi.h:26,
                 from ../drivers/acpi/tables.c:19:
../include/acpi/actbl1.h:30:33: warning: initializer-string for array of 'char' truncates NUL terminator but destination lacks 'nonstring' attribute (5 chars into 4 available) [-Wunterminated-string-initialization]
   30 | #define ACPI_SIG_BERT           "BERT"  /* Boot Error Record Table */
      |                                 ^~~~~~                                                      ../drivers/acpi/tables.c:400:9: note: in expansion of macro 'ACPI_SIG_BERT'                           400 |         ACPI_SIG_BERT, ACPI_SIG_BGRT, ACPI_SIG_CPEP, ACPI_SIG_ECDT,
      |         ^~~~~~~~~~~~~                                                                       ../include/acpi/actbl1.h:31:33: warning: initializer-string for array of 'char' truncates NUL terminator but destination lacks 'nonstring' attribute (5 chars into 4 available) [-Wunterminated-string-initialization]
   31 | #define ACPI_SIG_BGRT           "BGRT"  /* Boot Graphics Resource Table */
      |                                 ^~~~~~

Link: https://gcc.gnu.org/bugzilla/show_bug.cgi?id=117178 [1]
Signed-off-by: Kees Cook <kees@kernel.org>
---
Cc: Miguel Ojeda <ojeda@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Len Brown <lenb@kernel.org>
Cc: Marco Elver <elver@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: Hao Luo <haoluo@google.com>
Cc: Masahiro Yamada <masahiroy@kernel.org>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: linux-acpi@vger.kernel.org
---
 include/linux/compiler_types.h | 12 ++++++++++++
 init/Kconfig                   |  3 +++
 2 files changed, 15 insertions(+)

diff --git a/include/linux/compiler_types.h b/include/linux/compiler_types.h
index 981cc3d7e3aa..7ccea700b46d 100644
--- a/include/linux/compiler_types.h
+++ b/include/linux/compiler_types.h
@@ -348,6 +348,18 @@ struct ftrace_likely_data {
 # define __counted_by(member)
 #endif
 
+/*
+ * Optional: only supported since gcc >= 15
+ * Optional: not supported by Clang
+ *
+ * gcc: https://gcc.gnu.org/bugzilla/show_bug.cgi?id=117178
+ */
+#ifdef CONFIG_CC_HAS_MULTIDIMENSIONAL_NONSTRING
+# define __nonstring_array		__attribute__((__nonstring__))
+#else
+# define __nonstring_array
+#endif
+
 /*
  * Apply __counted_by() when the Endianness matches to increase test coverage.
  */
diff --git a/init/Kconfig b/init/Kconfig
index d0d021b3fa3b..723dc69507d6 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -129,6 +129,9 @@ config CC_HAS_COUNTED_BY
 	# https://github.com/llvm/llvm-project/pull/112636
 	depends on !(CC_IS_CLANG && CLANG_VERSION < 190103)
 
+config CC_HAS_MULTIDIMENSIONAL_NONSTRING
+	def_bool $(success,echo 'char tag[][4] __attribute__((__nonstring__)) = { };' | $(CC) $(CLANG_FLAGS) -x c - -c -o /dev/null -Werror)
+
 config RUSTC_HAS_COERCE_POINTEE
 	def_bool RUSTC_VERSION >= 108400
 
-- 
2.34.1


