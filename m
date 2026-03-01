Return-Path: <linux-acpi+bounces-21281-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GFNAJ7Cdo2k3IQUAu9opvQ
	(envelope-from <linux-acpi+bounces-21281-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Sun, 01 Mar 2026 03:00:16 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 416BB1CC8EB
	for <lists+linux-acpi@lfdr.de>; Sun, 01 Mar 2026 03:00:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 065E830ECAFC
	for <lists+linux-acpi@lfdr.de>; Sun,  1 Mar 2026 01:54:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D54230C602;
	Sun,  1 Mar 2026 01:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cgE3TnKr"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2947230C354;
	Sun,  1 Mar 2026 01:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772329961; cv=none; b=h9zjLmsyfX8ptVJYYDCMLd1HCV5r/K85KhCp5+SDgS6cO8G9wV9LK0ToBtWUdsB2THZ1dUZn/OOYTYSjKUUl+4e+0kRg5dA1Dwc4rwpgr2diI/TLQxSki8Fhd1qETOrQYoGWSi+EmzAunxNsQCNBCsXufuZH0Cs9FDgtqHStN5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772329961; c=relaxed/simple;
	bh=l4owRCNvVkmpeUTQLmBTis4IAMulB7IykbJAx8fhJAg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=k+kyeYn1WzGt+WPak6gqSEv/nF0Cc8nGntQzdk7emlVAi9jI13w/5ms2yaf5Qa3vih8Wlp7P11urVSaUROJF5z3+g/xrlv/MNKpdu/l+t9ANxt6w+lfZ1mgc1E8rSrqRd9KOCg6hWNtmkrgcdrb1W1xhJtbTuY7dbr9wwU39LV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cgE3TnKr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E7FBC19421;
	Sun,  1 Mar 2026 01:52:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772329960;
	bh=l4owRCNvVkmpeUTQLmBTis4IAMulB7IykbJAx8fhJAg=;
	h=From:To:Cc:Subject:Date:From;
	b=cgE3TnKrxhMJStpuOwr7I++XzrDIFjSqAfLFWkfiOcN72WjlCWJ81SR0hJZGWddg/
	 BtU09f1/ptmkPCkikW8sM2EdVnbSV1MuYCikYTs5sYCLNvGDzSLdAD08BAn52MlBKk
	 VLpNW4OxjUUbS8Nlkk4THlGeNAq/NDTAChPkeDCyP4TK0YVl4yWPZmPLpFUq+Z4sVc
	 IP/SfexUxuYBHyvYU6roCi8JiDcLmvHbxU8poD8mPpTYcAdqYIY5rxQzll2IWTyEeN
	 ZoX8PcGDhlMImhs8F/EUGQMNavUSyYrVzWG4BsRoUFpDMqC+dE5LnqCW248YPfWyjc
	 6RUz3oBdGDStg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	nathan@kernel.org
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	linux-acpi@vger.kernel.org,
	llvm@lists.linux.dev
Subject: FAILED: Patch "ACPI: APEI: GHES: Disable KASAN instrumentation when compile testing with clang < 18" failed to apply to 5.15-stable tree
Date: Sat, 28 Feb 2026 20:52:38 -0500
Message-ID: <20260301015239.1719222-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: ignore
X-stable: review
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21281-lists,linux-acpi=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,linux-acpi@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-acpi];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,msgid.link:url]
X-Rspamd-Queue-Id: 416BB1CC8EB
X-Rspamd-Action: no action

The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From b584bfbd7ec417f257f651cc00a90c66e31dfbf1 Mon Sep 17 00:00:00 2001
From: Nathan Chancellor <nathan@kernel.org>
Date: Wed, 14 Jan 2026 16:27:11 -0700
Subject: [PATCH] ACPI: APEI: GHES: Disable KASAN instrumentation when compile
 testing with clang < 18

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
Cc: All applicable <stable@vger.kernel.org>
Link: https://patch.msgid.link/20260114-ghes-avoid-wflt-clang-older-than-18-v1-1-9c8248bfe4f4@kernel.org
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/apei/Makefile | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/acpi/apei/Makefile b/drivers/acpi/apei/Makefile
index 5db61dfb46915..1a0b85923cd42 100644
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
 obj-$(CONFIG_ACPI_APEI_PCIEAER)	+= ghes_helpers.o
 obj-$(CONFIG_ACPI_APEI_EINJ)	+= einj.o
 einj-y				:= einj-core.o
-- 
2.51.0





