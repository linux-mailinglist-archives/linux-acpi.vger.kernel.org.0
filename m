Return-Path: <linux-acpi+bounces-6988-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 37758937E8F
	for <lists+linux-acpi@lfdr.de>; Sat, 20 Jul 2024 03:05:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B2FDF1F21ADD
	for <lists+linux-acpi@lfdr.de>; Sat, 20 Jul 2024 01:05:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BDF13C39;
	Sat, 20 Jul 2024 01:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LG4U+UXE"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0014F1C14;
	Sat, 20 Jul 2024 01:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721437499; cv=none; b=OsSWNMXkT/9Gb35TYyUB8tBSfRKy+sbEEW78fATWS0xCNI5zneY7RJ5QybrbEfFzMCDhVQqNpZdk0bt0Q+cGtux12B9FCJBbzIyaifF9Bvo6SkFAjEmkT2psDGxK4pAnthdrhsKP+ZEM01F8s2j4OVfYG6Oc2YAmUKzl2HespRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721437499; c=relaxed/simple;
	bh=KSb83U1YtutdXTUH57iqsroyMV6ULQqkxWoZRbDKQMU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=EGxfmv/McG9hX9CRfSx67Ed0LXaLe3W0WqgxVno0HFucsfbA3IEQ0hgEJbWgGUxs4yUQkvtQXWCBsXQW/6rkHrzKY7iDeYwHVbUjH42Vn7LA5i7lASORmpW1JdmZdM4mLO4XYYTpS30mNZtei+qku7eK0/S6Q9BTXI9qg79tjzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LG4U+UXE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6967C4AF09;
	Sat, 20 Jul 2024 01:04:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721437498;
	bh=KSb83U1YtutdXTUH57iqsroyMV6ULQqkxWoZRbDKQMU=;
	h=From:Date:Subject:To:Cc:From;
	b=LG4U+UXEkwxMUoUajM/s0+YWtt13jZZ+fmeGqqBuzajmyEGJHcyfUU1qXFpFu9O7K
	 86RbPKJnd/pGbNElAxP4PEry7eFmzwDHj5QukirQ2zbKEtN4wQVsgme5+jO9ZFPpeu
	 upHhoPQ2o81QXfrYJXo9TKDeWffZ3nEjrMV08BHVJh1M2ojEci9XVydtNjPOtmVXMz
	 Rbq0YHP8LWtYeHvJ0CRT8LDf2NeftGm6IWtJE4696a9se/qWf9skro9gFTWPzqaeYF
	 x1QLJgSL+p1BI19iAhb7nyYDczC6o9XMXff6zTsScxVk+qIouCjur8hHgpiexjg5yq
	 SYCuaK8yOewGA==
From: Nathan Chancellor <nathan@kernel.org>
Date: Fri, 19 Jul 2024 18:04:25 -0700
Subject: [PATCH v2] ACPI: HMAT: Mark hmat_set_default_dram_perf() as __init
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240719-fix-modpost-warning-default_dram_nodes-v2-1-792ff57a50b0@kernel.org>
X-B4-Tracking: v=1; b=H4sIABgNm2YC/5WNQQ6CMBBFr0K6dgwtiMjKexhCKjOFRmjJFFFDu
 LuVG7h8P/nvrSIQWwqiSlbBtNhgvYugDoloe+06AouRhUpVnp5lCsa+YfQ4+TDDS7OzrgMko5/
 D3CDrsXEeKUBW3gujjaEMtYiyiSk+99CtjtzbMHv+7N1F/ta/E4sECeWlkPkpa9tS4fVB7Gg4e
 u5EvW3bF52q/djdAAAA
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
 Ho-Ren Chuang <horen.chuang@linux.dev>, 
 "Huang, Ying" <ying.huang@intel.com>, 
 Jonathan Cameron <Jonathan.Cameron@Huawei.com>, linux-acpi@vger.kernel.org, 
 linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>, 
 Nathan Chancellor <nathan@kernel.org>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2066; i=nathan@kernel.org;
 h=from:subject:message-id; bh=KSb83U1YtutdXTUH57iqsroyMV6ULQqkxWoZRbDKQMU=;
 b=owGbwMvMwCUmm602sfCA1DTG02pJDGmzeS03fo0xqDEQWvVx/pWN3c/X6MTlrwowVvvZ+GCS0
 JrLM5YydJSyMIhxMciKKbJUP1Y9bmg45yzjjVOTYOawMoEMYeDiFICJ8B9nZJjIfcPvlEflIofz
 L9l+fDB7Xby4wSmFbVXWGyXpYs35Z9cwMtwsnLV6h6D0sU1Tfmu/uyXZfIRL7WWIz9wnaRNX5DH
 WTWMDAA==
X-Developer-Key: i=nathan@kernel.org; a=openpgp;
 fpr=2437CB76E544CB6AB3D9DFD399739260CB6CB716

After commit 823430c8e9d9 ("memory tier: consolidate the initialization
of memory tiers"), there is a modpost warning when
hmat_set_default_dram_perf() is not inlined into its callsite, as it
appears that default_dram_nodes may be accessed after its memory has
been freed.

  WARNING: modpost: vmlinux: section mismatch in reference: hmat_set_default_dram_perf+0x18 (section: .text) -> default_dram_nodes (section: .init.data)

The single callsite, hmat_init(), is __init, so this warning is not a
problem in reality but it is easily solvable by marking
hmat_set_default_dram_perf() as __init, which should have been done when
this function was added in commit 3718c02dbd4c ("acpi, hmat: calculate
abstract distance with HMAT").

Fixes: 823430c8e9d9 ("memory tier: consolidate the initialization of memory tiers")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202406292310.hlRATeZJ-lkp@intel.com/
Reviewed-by: Huang, Ying <ying.huang@intel.com>
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
---
Changes in v2:
- The problematic change appears to be merged into mm-stable, so I added
  a fixes tag and updated the commit message with the stable hash.
- Add Ying's reviewed-by tag.
- Link to v1: https://lore.kernel.org/r/20240710-fix-modpost-warning-default_dram_nodes-v1-1-8961453cc82d@kernel.org
---
 drivers/acpi/numa/hmat.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/numa/hmat.c b/drivers/acpi/numa/hmat.c
index a2f9e7a4b479..ca0c0ea3e1ef 100644
--- a/drivers/acpi/numa/hmat.c
+++ b/drivers/acpi/numa/hmat.c
@@ -933,7 +933,7 @@ static int hmat_callback(struct notifier_block *self,
 	return NOTIFY_OK;
 }
 
-static int hmat_set_default_dram_perf(void)
+static __init int hmat_set_default_dram_perf(void)
 {
 	int rc;
 	int nid, pxm;

---
base-commit: 30d77b7eef019fa4422980806e8b7cdc8674493e
change-id: 20240710-fix-modpost-warning-default_dram_nodes-38b6faffe3da

Best regards,
-- 
Nathan Chancellor <nathan@kernel.org>


