Return-Path: <linux-acpi+bounces-10838-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35AEFA1CC16
	for <lists+linux-acpi@lfdr.de>; Sun, 26 Jan 2025 17:01:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B9833A9945
	for <lists+linux-acpi@lfdr.de>; Sun, 26 Jan 2025 15:52:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AD9A22DF8F;
	Sun, 26 Jan 2025 15:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QMpKWPbO"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E83B122DF8C;
	Sun, 26 Jan 2025 15:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737903922; cv=none; b=o1hq7pZZUb+fqJ+ZbqpJoau4YtNPAxu/IFrvszdPv88HCGDBNa2GKPkqdy5Ty9ZhHhO0+p3hG7Cm82ZisgfA6gYNhbKQgcWP/b6RAbxRdRwXOXxuWq1/oSnYMqadmzmVYcg/27JIK1m6uYrwNsIhPPTA8hGPiqsxGF90Zyi0Nt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737903922; c=relaxed/simple;
	bh=uIEGC/NAmq0+V2kfEBz/VQAfjXTFILX2uZ7sTBL23t0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cyRRluNhb609BFxAbnK9gll9M/9N2tYXC73NSXktpJO/Q40tvET4ETtGpZGfZ2XN+i9PHgo0pAMq/tO7MvH/HDii0U/8Fw8KkrCHr7kxo6mMLShCaIAw+wmFAtPNaVcOxW8j/Svf1bn6aoPg/Vz8Sj8CMw+VHXjDTefnEQ5CBU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QMpKWPbO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36939C4CED3;
	Sun, 26 Jan 2025 15:05:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737903921;
	bh=uIEGC/NAmq0+V2kfEBz/VQAfjXTFILX2uZ7sTBL23t0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QMpKWPbO1yii/9/ZLKm7hTqNIKtVkswBVVVK8K0YSoBGkKmPQgaVM2416X2ib0WUp
	 QZSWdck+i1dlH03MN74Y4KRFz8am5mXzUKtYtpg4+3pQ/jRB3jHGkWZakbNTZCaoJG
	 5b0LWCt/QApYnx2UCv1xZrXWxcUu9d/uBbmVbGQV79IbZ8fcKEbJOLWLusPsWE1fLa
	 jMqWS7QAFtl8XFBWyP9t91oUceabYuO0mth1o+6teBQsvcdLW+U2QvVyUidw6OoVo3
	 nLDaJUwvhtuHqPVTbh52UDKxbTwDuW3ZBW+ANuY+9EX3i+qMeevqJCbSo0snL2tiVV
	 UmZzS3Q7lETWQ==
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
	Jonathan.Cameron@huawei.com,
	u.kleine-koenig@baylibre.com,
	dan.j.williams@intel.com,
	peterz@infradead.org,
	linux-acpi@vger.kernel.org
Subject: [PATCH AUTOSEL 5.10 09/12] APEI: GHES: Have GHES honor the panic= setting
Date: Sun, 26 Jan 2025 10:04:57 -0500
Message-Id: <20250126150500.959521-9-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250126150500.959521-1-sashal@kernel.org>
References: <20250126150500.959521-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.233
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


