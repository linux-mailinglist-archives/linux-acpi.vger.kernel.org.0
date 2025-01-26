Return-Path: <linux-acpi+bounces-10836-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FFAEA1CBAC
	for <lists+linux-acpi@lfdr.de>; Sun, 26 Jan 2025 16:52:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB4E61882A31
	for <lists+linux-acpi@lfdr.de>; Sun, 26 Jan 2025 15:49:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 437C722A4C9;
	Sun, 26 Jan 2025 15:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F6ezrMj4"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A52A22A4C6;
	Sun, 26 Jan 2025 15:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737903893; cv=none; b=Jdcv8vsQ8o+EpJDFBgJF5RuPQTI1aRM0XwIUtWvBM9PG6hop4PAyWq+duhraiTebM5oIuLxIMur6jZ20qkHmESkv2vyrVBZhOLpcUaHi39ZjW12DZKBeHqQC8jsRtStKaj3KKh9gQSv9Z31Qy45hJ+D6mZV/5JDAiY5TbuJZFac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737903893; c=relaxed/simple;
	bh=uIEGC/NAmq0+V2kfEBz/VQAfjXTFILX2uZ7sTBL23t0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KVTA/htH2DpkKcTLY5B3vVBK5LA+cVlzM5JrnnGt9JYpxkYsxpqsQbWC3dshag/zNb4UkfdVYKBPdDrtj1LZmYfCjCcO2h6yrcMpudwwapWhT7bPr8aERwCXJwAYUJjIPJhN7goBF/WYhMXF/kC2W65fdfrvb75+23elTmE21lY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F6ezrMj4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 786EBC4CEE2;
	Sun, 26 Jan 2025 15:04:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737903893;
	bh=uIEGC/NAmq0+V2kfEBz/VQAfjXTFILX2uZ7sTBL23t0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=F6ezrMj4Tp0Tr8qiE7A5uAsp87sVOdtXBgz0NaIP5GnqascRLFcYAFLFXvw1Z6s/C
	 2Gnag1pYlcS8rVKMWWpwrO2B/1O2U5qcIVmZc5hyW4g987eY21aFeGXRyHDm2D4J11
	 7sFlB37+ITo8pXNRg9DXDK1mvPbUYNMs2/ZfzliNuRO+lvG8XQuNdW2Oik4ZuHI9QA
	 v9cyC5TFW76O8AVi4l/e7vmhfKOVP4I8QAhMFCIjaOrGi5hVbQh19qSN5vTPE5i3gm
	 WdsTTNxz0jmyMyJPGYMK4mQI4qyzKgayCxEfCpuZUWFLsMv2rTfKqace+LwEKVO/Ld
	 GU7gWauj0q7nA==
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
	u.kleine-koenig@baylibre.com,
	peterz@infradead.org,
	dan.j.williams@intel.com,
	linux-acpi@vger.kernel.org
Subject: [PATCH AUTOSEL 5.15 10/14] APEI: GHES: Have GHES honor the panic= setting
Date: Sun, 26 Jan 2025 10:04:26 -0500
Message-Id: <20250126150430.958708-10-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250126150430.958708-1-sashal@kernel.org>
References: <20250126150430.958708-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.177
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
index 160606af8b4f5..a6c8514110736 100644
--- a/drivers/acpi/apei/ghes.c
+++ b/drivers/acpi/apei/ghes.c
@@ -155,8 +155,6 @@ static unsigned long ghes_estatus_pool_size_request;
 static struct ghes_estatus_cache *ghes_estatus_caches[GHES_ESTATUS_CACHES_SIZE];
 static atomic_t ghes_estatus_cache_alloced;
 
-static int ghes_panic_timeout __read_mostly = 30;
-
 static void __iomem *ghes_map(u64 pfn, enum fixed_addresses fixmap_idx)
 {
 	phys_addr_t paddr;
@@ -858,14 +856,16 @@ static void __ghes_panic(struct ghes *ghes,
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


