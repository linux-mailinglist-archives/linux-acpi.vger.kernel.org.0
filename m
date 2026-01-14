Return-Path: <linux-acpi+bounces-20352-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BC8B4D21C21
	for <lists+linux-acpi@lfdr.de>; Thu, 15 Jan 2026 00:27:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7B610302D887
	for <lists+linux-acpi@lfdr.de>; Wed, 14 Jan 2026 23:27:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95F2C3904D5;
	Wed, 14 Jan 2026 23:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bojR1z4+"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CCA62FD685;
	Wed, 14 Jan 2026 23:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768433240; cv=none; b=l8HIsjrU4dy6b+H+jwVqtI6EOTRxOisv3EpIN0i8rAs4PFXp0dxrLQOx3IeJz006SNe4Rm6LZLqwNS46vRW5WYQLPll1P+Wy8CwPFuWPPjWaeqn8yRnyximpmFhBSCgI1nQ+cU8YmHr/mGJGihcFlhQg8HXc3kPhbai2vXgzNsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768433240; c=relaxed/simple;
	bh=QFhLAdfdwRbMaxWtoYTf49tqZsozy+rXRjby4c7UuNY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=LEAhzDMdvoWMEJfrFjaRE9c4l4g7KJBEBVFydPVyglgAfxCNGtvvgGgH0PTXexJY24GtNuv5OvNhVYNtH7x/YGSicBkJ6s+vbbAggMTIMcQROTb4t1PrzFGJED/5NIfm0zzU19qMfeld7+HB6PX8JrNTMK1NydBZS5a2YUQKR4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bojR1z4+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E069FC16AAE;
	Wed, 14 Jan 2026 23:27:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768433239;
	bh=QFhLAdfdwRbMaxWtoYTf49tqZsozy+rXRjby4c7UuNY=;
	h=From:Date:Subject:To:Cc:From;
	b=bojR1z4+h1yVjRTKlWNK+rOmoQAy3g77QHLMbDFuDFbOyHOhF1Ai7veGJKml1r8yK
	 5rzAJ9gltiWzi9ynbmXt0VKAsufOOwxaaJZ4HQtA83rPAPxfMk2b6ClYmojPGOarb+
	 0mJtFgtqcb/laKlTv7WiNtm1ilnyzbufbRs+S4t5Kc8JfBYwnQB+YjU+UDe5XpdPw2
	 A9NXvov0e4vqbXQjB/dyC/BPo5tde9PxfE/iGVP7P7M1QJ6ufQbpiDKQiThkus6fD3
	 ljSA27aVngW93RXp7jLSNFltRQvCNPnajQB+w9S5qMHoCgwUhe9EpjXS8mI5THTkLR
	 F7RFQEM58s0YQ==
From: Nathan Chancellor <nathan@kernel.org>
Date: Wed, 14 Jan 2026 16:27:11 -0700
Subject: [PATCH] ACPI: APEI: GHES: Disable KASAN instrumentation when
 compile testing with clang < 18
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260114-ghes-avoid-wflt-clang-older-than-18-v1-1-9c8248bfe4f4@kernel.org>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yWNQQrCMBBFr1Jm7UAS2mq9iriIybQdCY1kYhVK7
 +6oywfvv7+BUGESODcbFFpZOC8K9tBAmP0yEXJUBmdcb6xtcZpJ0K+ZI77GVDEktTCnSAWrLtC
 esDOt64ZwNIPvQUuPQiO/fy+X65/lebtTqN807PsH49QFOYcAAAA=
X-Change-ID: 20260114-ghes-avoid-wflt-clang-older-than-18-504259c709a6
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Tony Luck <tony.luck@intel.com>, Borislav Petkov <bp@alien8.de>, 
 Hanjun Guo <guohanjun@huawei.com>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Shuai Xue <xueshuai@linux.alibaba.com>, Len Brown <lenb@kernel.org>, 
 Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, 
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
 linux-acpi@vger.kernel.org, llvm@lists.linux.dev, patches@lists.linux.dev, 
 Nathan Chancellor <nathan@kernel.org>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2058; i=nathan@kernel.org;
 h=from:subject:message-id; bh=QFhLAdfdwRbMaxWtoYTf49tqZsozy+rXRjby4c7UuNY=;
 b=owGbwMvMwCUmm602sfCA1DTG02pJDJkZaiEdn6ZFtCfmpYZ/WLFCSkCqsf9iR/OpDoU/eYzGp
 415XvR1lLIwiHExyIopslQ/Vj1uaDjnLOONU5Ng5rAygQxh4OIUgIlsz2f4Z8+c1PHKKny6492N
 Fd8ZpaYuKTmxVWSZ3o3tTXGsDjf/LWNk+Bt77MgFlWR5ZnP+e0kte1sOX/5cm+HFJ6MxT6tKTiS
 YBQA=
X-Developer-Key: i=nathan@kernel.org; a=openpgp;
 fpr=2437CB76E544CB6AB3D9DFD399739260CB6CB716

After a recent innocuous change to drivers/acpi/apei/ghes.c, building
ARCH=arm64 allmodconfig with clang-17 or older (which has both
CONFIG_KASAN=y and CONFIG_WERROR=y) fails with:

  drivers/acpi/apei/ghes.c:902:13: error: stack frame size (2768) exceeds limit (2048) in 'ghes_do_proc' [-Werror,-Wframe-larger-than]
    902 | static void ghes_do_proc(struct ghes *ghes,
        |             ^

A KASAN pass that removes unneeded stack instrumentation, enabled by
default in clang-18 [1], drastically improves stack usage in this case.

To avoid the warning in the common allmodconfig case when it can break
the build, disable KASAN for ghes.o when compile testing with clang-17
and older. Disabling KASAN outright may hide legitimate runtime issues,
so live with the warning in that case; the user can either increase the
frame warning limit or disable -Werror, which they should probably do
when debugging with KASAN anyways.

Closes: https://github.com/ClangBuiltLinux/linux/issues/2148
Link: https://github.com/llvm/llvm-project/commit/51fbab134560ece663517bf1e8c2a30300d08f1a [1]
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
---
 drivers/acpi/apei/Makefile | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/acpi/apei/Makefile b/drivers/acpi/apei/Makefile
index 2c474e6477e1..346cdf0a0ef9 100644
--- a/drivers/acpi/apei/Makefile
+++ b/drivers/acpi/apei/Makefile
@@ -1,6 +1,10 @@
 # SPDX-License-Identifier: GPL-2.0
 obj-$(CONFIG_ACPI_APEI)		+= apei.o
 obj-$(CONFIG_ACPI_APEI_GHES)	+= ghes.o
+# clang versions prior to 18 may blow out the stack with KASAN
+ifeq ($(CONFIG_COMPILE_TEST)_$(CONFIG_CC_IS_CLANG)_$(call clang-min-version, 180000),y_y_)
+KASAN_SANITIZE_ghes.o := n
+endif
 obj-$(CONFIG_ACPI_APEI_EINJ)	+= einj.o
 einj-y				:= einj-core.o
 einj-$(CONFIG_ACPI_APEI_EINJ_CXL) += einj-cxl.o

---
base-commit: 4c96ec13fcaee154368f19887f7f84985ef605bc
change-id: 20260114-ghes-avoid-wflt-clang-older-than-18-504259c709a6

Best regards,
--  
Nathan Chancellor <nathan@kernel.org>


