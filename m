Return-Path: <linux-acpi+bounces-19942-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 02E85CF0E0F
	for <lists+linux-acpi@lfdr.de>; Sun, 04 Jan 2026 13:04:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7A9643020C43
	for <lists+linux-acpi@lfdr.de>; Sun,  4 Jan 2026 12:04:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 709552980C2;
	Sun,  4 Jan 2026 12:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="TxAkOMTd"
X-Original-To: linux-acpi@vger.kernel.org
Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9BBA28CF5F;
	Sun,  4 Jan 2026 12:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767528262; cv=none; b=q48BjxbfepQikx+nxytszNdGOrv1G5HV2zR4Q3AbZ8C+L8G64vd3aEFdvF6HZtHeDLtDy9gp6AuU2okzVLjZe6Tvhvor2Ob5VBXxRs7w7QIrtCrBn5bJctnVjXW+08yh0PWdurNAE34An/14OWr5w1obkOPUsEGRRSUVAKHsBT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767528262; c=relaxed/simple;
	bh=in0mvJHIM9/eic/0l2QwtjyPIFoH9qjDq0fUhHc9bJI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hhG8vwIjyygygif8GmOqRsoxdfEvXqK0tyTtDElyc06M5MGCWHgKM1SOImVIsZx/TB2VJKNLBEJc2NEXwA7AE7MuZYQxJu4m657EtoHIVjhQj59DdPJrXIRHS1T9uxuMuVCNWkTNZcv7p5m3JDImf94jVyaugSATcByDtpO0Vgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=TxAkOMTd; arc=none smtp.client-ip=115.124.30.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1767528252; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=u5obvNzNcLvGjs8qb6pMUxs8aoyCDyMM1pDJbd4Q3W8=;
	b=TxAkOMTdgcRbdO9qcdT0TBsU50NcHayTpKKgpetb4gxszQB1QeHn92KDB8rV/294OKLZMyOiEOXQIhO8xReLRZQUby2+PI9+7NZCc+H0CrxORADxQJ8QEQd4rSJD9knYhwtJZ+YDWmamyuzfP1za72GmRiAm/78wO/lsSgUU3tQ=
Received: from localhost.localdomain(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0WwEgE4g_1767528250 cluster:ay36)
          by smtp.aliyun-inc.com;
          Sun, 04 Jan 2026 20:04:11 +0800
From: Shuai Xue <xueshuai@linux.alibaba.com>
To: tony.luck@intel.com,
	guohanjun@huawei.com,
	mchehab@kernel.org,
	yazen.ghannam@amd.com
Cc: dave.jiang@intel.com,
	Smita.KoralahalliChannabasappa@amd.com,
	leitao@debian.org,
	pengdonglin@xiaomi.com,
	xueshuai@linux.alibaba.com,
	baolin.wang@linux.alibaba.com,
	benjamin.cheatham@amd.com,
	bp@alien8.de,
	dan.j.williams@intel.com,
	james.morse@arm.com,
	lenb@kernel.org,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	rafael@kernel.org,
	zhuo.song@linux.alibaba.com
Subject: [PATCH v2 3/3] ACPI: APEI: GHES: Improve ghes_notify_sea() status check
Date: Sun,  4 Jan 2026 20:04:05 +0800
Message-Id: <20260104120405.51555-4-xueshuai@linux.alibaba.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20260104120405.51555-1-xueshuai@linux.alibaba.com>
References: <20260104120405.51555-1-xueshuai@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Performance testing on ARMv8 systems shows significant overhead in error
status handling in SEA error handling.

- ghes_peek_estatus(): 8,138.3 ns (21,160 cycles).
- ghes_clear_estatus(): 2,038.3 ns (5,300 cycles).

Apply the same optimization used in ghes_notify_nmi() to
ghes_notify_sea() by checking for active errors before processing,

Tested-by: Tony Luck <tony.luck@intel.com>
Reviewed-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Shuai Xue <xueshuai@linux.alibaba.com>
---
 drivers/acpi/apei/ghes.c | 20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
index 7600063fe263..54a6461d277a 100644
--- a/drivers/acpi/apei/ghes.c
+++ b/drivers/acpi/apei/ghes.c
@@ -1487,6 +1487,9 @@ int ghes_notify_sea(void)
 	static DEFINE_RAW_SPINLOCK(ghes_notify_lock_sea);
 	int rv;
 
+	if (!ghes_has_active_errors(&ghes_sea))
+		return -ENOENT;
+
 	raw_spin_lock(&ghes_notify_lock_sea);
 	rv = ghes_in_nmi_spool_from_list(&ghes_sea, FIX_APEI_GHES_SEA);
 	raw_spin_unlock(&ghes_notify_lock_sea);
@@ -1494,11 +1497,19 @@ int ghes_notify_sea(void)
 	return rv;
 }
 
-static void ghes_sea_add(struct ghes *ghes)
+static int ghes_sea_add(struct ghes *ghes)
 {
+	int rc;
+
+	rc = ghes_map_error_status(ghes);
+	if (rc)
+		return rc;
+
 	mutex_lock(&ghes_list_mutex);
 	list_add_rcu(&ghes->list, &ghes_sea);
 	mutex_unlock(&ghes_list_mutex);
+
+	return 0;
 }
 
 static void ghes_sea_remove(struct ghes *ghes)
@@ -1506,10 +1517,11 @@ static void ghes_sea_remove(struct ghes *ghes)
 	mutex_lock(&ghes_list_mutex);
 	list_del_rcu(&ghes->list);
 	mutex_unlock(&ghes_list_mutex);
+	ghes_unmap_error_status(ghes);
 	synchronize_rcu();
 }
 #else /* CONFIG_ACPI_APEI_SEA */
-static inline void ghes_sea_add(struct ghes *ghes) { }
+static inline int ghes_sea_add(struct ghes *ghes) { return -EINVAL; }
 static inline void ghes_sea_remove(struct ghes *ghes) { }
 #endif /* CONFIG_ACPI_APEI_SEA */
 
@@ -1741,7 +1753,9 @@ static int ghes_probe(struct platform_device *ghes_dev)
 		break;
 
 	case ACPI_HEST_NOTIFY_SEA:
-		ghes_sea_add(ghes);
+		rc = ghes_sea_add(ghes);
+		if (rc)
+			goto err;
 		break;
 	case ACPI_HEST_NOTIFY_NMI:
 		rc = ghes_nmi_add(ghes);
-- 
2.39.3


