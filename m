Return-Path: <linux-acpi+bounces-10839-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C8F7DA1CC17
	for <lists+linux-acpi@lfdr.de>; Sun, 26 Jan 2025 17:01:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A4D2B3B04EC
	for <lists+linux-acpi@lfdr.de>; Sun, 26 Jan 2025 15:54:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA39A230269;
	Sun, 26 Jan 2025 15:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f2O7u2yw"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EBA4230263;
	Sun, 26 Jan 2025 15:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737903942; cv=none; b=nOXt9NTyaQJE9oZIESupeDhE8emlOQ8hWXRzQCqVqOj/Ivg2CusjO6uOAUYv24ORtv5npc9BVGM8KWSAYUlfUl+p1aHgJbGbIcG+PcyHwLd3QgvPlWF1s1FGl08sSwqF8lBS5PtbhJlM29b2NHDApB6DK2IHQzGvbhGjOZ61RNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737903942; c=relaxed/simple;
	bh=CNJQ+QICW40Pa+BDnOGMrVBfVz0a2+8S215DRjhfXqw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=D/RQv2HTfHCwYadR4jVbFawP29d9PSVJKhW2zNlCsQV+Qk4a/pOv2GQJh86Xq4E6cOd68fqb8elj+gdOnrIgYIYgeJM4+jZ5VcheosKHR2c0vz2Ua/odYofQUyl0qENsijzAWl5sg8SxwNEU+hrmE5WZuH+YRJI+D5KVuPNffOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f2O7u2yw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E467BC4CED3;
	Sun, 26 Jan 2025 15:05:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737903942;
	bh=CNJQ+QICW40Pa+BDnOGMrVBfVz0a2+8S215DRjhfXqw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=f2O7u2ywo48sw+y61HQK2JxTM0H5B1atFnXL2YKRVvw00vf+oXv4c4+Zc5QesYn7J
	 TVE/nTUB9ejpmqSXuGfahlKG0mu3IkzGsdaxJKM4ezPxnTH1e4Z4m9ylTY13vra2v5
	 DGagm6orBIhlIo20rKCEyG/FAQZmrM0qgSEKALydNFwDtmI1xrp8lnx+9WeYNxWtem
	 2Bh+1/fjQLNYnOdPPGC8qz4g2oGDTGowXtCEhEofn0qCpC/XKmyd/wF4+JLfjpU/ri
	 VpzWHEDc+PvMgPaAjV/8u5WO0QIquTE5WDnQBFDT7sSquKxnyRMMhkR76Les94nHVX
	 TzKbydKmixO3Q==
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
	alison.schofield@intel.com,
	u.kleine-koenig@baylibre.com,
	peterz@infradead.org,
	dan.j.williams@intel.com,
	linux-acpi@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 7/7] APEI: GHES: Have GHES honor the panic= setting
Date: Sun, 26 Jan 2025 10:05:27 -0500
Message-Id: <20250126150527.960265-7-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250126150527.960265-1-sashal@kernel.org>
References: <20250126150527.960265-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.4.289
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
index e0d82fab1f448..50bed5a708125 100644
--- a/drivers/acpi/apei/ghes.c
+++ b/drivers/acpi/apei/ghes.c
@@ -128,8 +128,6 @@ static unsigned long ghes_estatus_pool_size_request;
 static struct ghes_estatus_cache *ghes_estatus_caches[GHES_ESTATUS_CACHES_SIZE];
 static atomic_t ghes_estatus_cache_alloced;
 
-static int ghes_panic_timeout __read_mostly = 30;
-
 static void __iomem *ghes_map(u64 pfn, enum fixed_addresses fixmap_idx)
 {
 	phys_addr_t paddr;
@@ -707,14 +705,16 @@ static void __ghes_panic(struct ghes *ghes,
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


