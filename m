Return-Path: <linux-acpi+bounces-19411-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 235EDC9F0A9
	for <lists+linux-acpi@lfdr.de>; Wed, 03 Dec 2025 14:03:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EEEF54E448C
	for <lists+linux-acpi@lfdr.de>; Wed,  3 Dec 2025 13:03:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC0792F5308;
	Wed,  3 Dec 2025 13:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="b1kEgj3x"
X-Original-To: linux-acpi@vger.kernel.org
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A4B42DAFAE;
	Wed,  3 Dec 2025 13:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764766992; cv=none; b=Hn7WmjjWhTs2nosCVG3uyZ2wi2RlElKurILMwnlMDuZPbzWO+dP6pRS+4bjVHCi4nMQ3cCq1aJ0qGMb/Mj3uzjcUnPSMCYytGXJPsGcCixAX1Ge/dq4pS7rlYrS78Jnikd7GCwf4Vh9lG/n3+D6l+n2rNftUL+gSkcmtzKl1MlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764766992; c=relaxed/simple;
	bh=niRAa2D8g84O610u9+Z+A11OvECu7j1aWrMp4Ngezus=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OyWStYtcc4DZmJ6oKN4h7OWoQX8K1IBK6I9Zl3wKS7nFMWowJHAJShsB1TG2K3HT7sT8ltrgwT9VtNnucDEfjZFviZffRLn4IxMKPNdSQGX8W9eMjQwB1j/PtekyDWZivfJQ9Y5xZBFCN/7Resqtx/9cYD7TNP7KmOQCRMy2Kps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=b1kEgj3x; arc=none smtp.client-ip=115.124.30.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1764766979; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=1MvtZ5ab+ryK10NzwLqSh+RbaAmADfpIYi1fbjQ+wyM=;
	b=b1kEgj3xVOE4W7aYwuz66esniVL0oMqQEbdiuWrILXRkd0LSeHcJfrv7JXQ2zuTAye5tOL2GH54qLKw3glKn4s+APPpdw5ZbgYEcK1UoD2XGzw9AupgqDcZ6cQKBGzs2qvWbuQvtWDqjKyn9s6OOq79hJgOVos9pfr1FuJJfTYw=
Received: from localhost.localdomain(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0Wu.aDva_1764766978 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 03 Dec 2025 21:02:58 +0800
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
Subject: [PATCH 3/3] ACPI: APEI: GHES: Improve ghes_notify_sea() status check
Date: Wed,  3 Dec 2025 21:02:53 +0800
Message-Id: <20251203130253.73888-4-xueshuai@linux.alibaba.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20251203130253.73888-1-xueshuai@linux.alibaba.com>
References: <20251203130253.73888-1-xueshuai@linux.alibaba.com>
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

Signed-off-by: Shuai Xue <xueshuai@linux.alibaba.com>
---
 drivers/acpi/apei/ghes.c | 20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
index 2c7f3ca6ce50..0be46d63db53 100644
--- a/drivers/acpi/apei/ghes.c
+++ b/drivers/acpi/apei/ghes.c
@@ -1455,6 +1455,9 @@ int ghes_notify_sea(void)
 	static DEFINE_RAW_SPINLOCK(ghes_notify_lock_sea);
 	int rv;
 
+	if (!ghes_has_active_errors(&ghes_sea))
+		return -ENOENT;
+
 	raw_spin_lock(&ghes_notify_lock_sea);
 	rv = ghes_in_nmi_spool_from_list(&ghes_sea, FIX_APEI_GHES_SEA);
 	raw_spin_unlock(&ghes_notify_lock_sea);
@@ -1462,11 +1465,19 @@ int ghes_notify_sea(void)
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
@@ -1474,10 +1485,11 @@ static void ghes_sea_remove(struct ghes *ghes)
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
 
@@ -1710,7 +1722,9 @@ static int ghes_probe(struct platform_device *ghes_dev)
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


