Return-Path: <linux-acpi+bounces-10832-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A45EFA1CB3B
	for <lists+linux-acpi@lfdr.de>; Sun, 26 Jan 2025 16:43:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BFF331885406
	for <lists+linux-acpi@lfdr.de>; Sun, 26 Jan 2025 15:40:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AFF521D5AE;
	Sun, 26 Jan 2025 15:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LevECVoU"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31F4421D5AB;
	Sun, 26 Jan 2025 15:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737903825; cv=none; b=ILNoQmVdG8rVKHAUmiGsbjHwUVVbXtXbPpQXUayMhiWxzy8sERZZEBP9PNvElzXlfnOXXu7EyFlkBY78yNRaBkj+V1Orh8dVZKWA/lUX7JmOTW53enk6okBmA2ipSKj09/mK6yZXJAIfVtOVGqXiY32KzZmAFgNRLG4YCAOzv8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737903825; c=relaxed/simple;
	bh=+IRXfmqs4Ru+3DP/w63IlokNsAGyx0vXYyfjfhxnxck=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nOWY34NpfRkXJfuUI8bWpYrJKuCX3iGlXZ2y0Nvfzif5u2pkrACQHuQdgjhSlOAW6f7xYsNhZ3/YG6R0j1WNYMofmvYxgw/VgjLvASmTNvACbwRNrdEZqQDcIfDVaf9HbgfwUYcZuOAusblrPEiBwi9eyhVurX84RKGR9HAa0w4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LevECVoU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E813C4CEE3;
	Sun, 26 Jan 2025 15:03:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737903824;
	bh=+IRXfmqs4Ru+3DP/w63IlokNsAGyx0vXYyfjfhxnxck=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LevECVoUalJr08BuQ2N7Jgz6f26NN+4iM+Wtw/MFw8HLHb0iSIvdwB8kFp1UbKRCd
	 dzlw6ZnyR3JleZe/6RDIKNSRdlIStmeS4/TL9yNZK4gjp+lFTz2d1HhdclCRyyMNPr
	 M1xZeKzuZV+cx0crokR2DGNynZAOP0ocGZPBagv7ZWCVC/gyEFL/fbcA1Wvg/WMu4s
	 W5sOJ/ldvVCM4Zow4UiLauZ2kNTHqcSSABhv8MIiYYFILovv+8Kzry0ChtlO2TvdNs
	 q31T5QShOBOT47s4RSfcIgVeUC/nZ6DoAM4Z7grRcMdtr7GMj50K6fe1Q7qcJCc4Bk
	 m/AkMzfLkVvbA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Borislav Petkov <bp@alien8.de>,
	Feng Tang <feng.tang@linux.alibaba.com>,
	Ira Weiny <ira.weiny@intel.com>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	rafael@kernel.org,
	dave.jiang@intel.com,
	Jonathan.Cameron@huawei.com,
	dan.j.williams@intel.com,
	u.kleine-koenig@baylibre.com,
	linux-acpi@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 14/19] APEI: GHES: Have GHES honor the panic= setting
Date: Sun, 26 Jan 2025 10:03:09 -0500
Message-Id: <20250126150315.956795-14-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250126150315.956795-1-sashal@kernel.org>
References: <20250126150315.956795-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.74
Content-Transfer-Encoding: 8bit

From: Borislav Petkov <bp@alien8.de>

[ Upstream commit 5c0e00a391dd0099fe95991bb2f962848d851916 ]

The GHES driver overrides the panic= setting by force-rebooting the
system after a fatal hw error has been reported. The intent being that
such an error would be reported earlier.

However, this is not optimal when a hard-to-debug issue requires long
time to reproduce and when that happens, the box will get rebooted after
30 seconds and thus destroy the whole hw context of when the error
happened.

So rip out the default GHES panic timeout and honor the global one.

In the panic disabled (panic=0) case, the error will still be logged to
dmesg for later inspection and if panic after a hw error is really
required, then that can be controlled the usual way - use panic= on the
cmdline or set it in the kernel .config's CONFIG_PANIC_TIMEOUT.

Reported-by: Feng Tang <feng.tang@linux.alibaba.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Feng Tang <feng.tang@linux.alibaba.com>
Reviewed-by: Ira Weiny <ira.weiny@intel.com>
Link: https://patch.msgid.link/20250113125224.GFZ4UMiNtWIJvgpveU@fat_crate.local
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/acpi/apei/ghes.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
index ab2a82cb1b0b4..3aadc632d7dd5 100644
--- a/drivers/acpi/apei/ghes.c
+++ b/drivers/acpi/apei/ghes.c
@@ -170,8 +170,6 @@ static struct gen_pool *ghes_estatus_pool;
 static struct ghes_estatus_cache __rcu *ghes_estatus_caches[GHES_ESTATUS_CACHES_SIZE];
 static atomic_t ghes_estatus_cache_alloced;
 
-static int ghes_panic_timeout __read_mostly = 30;
-
 static void __iomem *ghes_map(u64 pfn, enum fixed_addresses fixmap_idx)
 {
 	phys_addr_t paddr;
@@ -899,14 +897,16 @@ static void __ghes_panic(struct ghes *ghes,
 			 struct acpi_hest_generic_status *estatus,
 			 u64 buf_paddr, enum fixed_addresses fixmap_idx)
 {
+	const char *msg = GHES_PFX "Fatal hardware error";
+
 	__ghes_print_estatus(KERN_EMERG, ghes->generic, estatus);
 
 	ghes_clear_estatus(ghes, estatus, buf_paddr, fixmap_idx);
 
-	/* reboot to log the error! */
 	if (!panic_timeout)
-		panic_timeout = ghes_panic_timeout;
-	panic("Fatal hardware error!");
+		pr_emerg("%s but panic disabled\n", msg);
+
+	panic(msg);
 }
 
 static int ghes_proc(struct ghes *ghes)
-- 
2.39.5


