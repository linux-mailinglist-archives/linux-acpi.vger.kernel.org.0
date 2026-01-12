Return-Path: <linux-acpi+bounces-20163-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D8E42D1075A
	for <lists+linux-acpi@lfdr.de>; Mon, 12 Jan 2026 04:23:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D06643020391
	for <lists+linux-acpi@lfdr.de>; Mon, 12 Jan 2026 03:23:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D7B230BB94;
	Mon, 12 Jan 2026 03:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="uild/EbX"
X-Original-To: linux-acpi@vger.kernel.org
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AE4B23BCEE;
	Mon, 12 Jan 2026 03:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768188190; cv=none; b=IMEKrBJQR/B3vjAvkZI9jORE5odKUjlUuUfYIguLCo/+TrTrJOVR1hh37NW7rUSpoT1UehdSNDJEtcMT+q4D7dBJ/iGj5kq0nXxVKslSWBN/lu9pedm3plprJJGktcOj/aqXgFEzX9Xn1e7W5W0JuWSldShYRDWnU7Jb5WjTA8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768188190; c=relaxed/simple;
	bh=64dISNUVY5AP8WHKRJI69pS8A1/wPTnJm0IR14v3Y58=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=N1zIYoYaVavBsrPIfhDG/yTR08+YVHSM/ysDAV543dRyQdfLlADCoui85LTrBdtQtjr3sDn6DkUz5Zg+hr5yscCFDwtK/p7u/45EuFAVUd0lXdrSm2vgHqpEGyMPcIp357tmJaRS1SY3shMM+HAj9Xt/UYEP2/rLMW/4BzNJgxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=uild/EbX; arc=none smtp.client-ip=115.124.30.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1768188185; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=YEWcD1FMFTtewMN40wiMkThOAR4BNo7qfiDreB/YjfU=;
	b=uild/EbXWKMqwfW1D5rpvVSCloKGTGCSulWEEuLtxOlW3Cy0oDuL9QbWh1QHwJni21SVKb1rIzdxQcWEKGZr/C8/QwBpJuL6JSlxTii5YCp+yQz1Bh1+uWkbudz3G+cSxmqL3HMC0zZ2/11QtpNQcLF2dxgZBCHBMkRYrtwVQLU=
Received: from localhost.localdomain(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0WwntGDq_1768188183 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 12 Jan 2026 11:23:04 +0800
From: Shuai Xue <xueshuai@linux.alibaba.com>
To: tony.luck@intel.com,
	guohanjun@huawei.com,
	mchehab@kernel.org,
	dolinux.peng@gmail.com,
	yazen.ghannam@amd.com,
	rafael@kernel.org
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
	zhuo.song@linux.alibaba.com
Subject: [PATCH v3 3/3] ACPI: APEI: GHES: Improve ghes_notify_sea() status check
Date: Mon, 12 Jan 2026 11:22:39 +0800
Message-Id: <20260112032239.30023-4-xueshuai@linux.alibaba.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20260112032239.30023-1-xueshuai@linux.alibaba.com>
References: <20260112032239.30023-1-xueshuai@linux.alibaba.com>
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
index b2f06bb96450..8b85af6e2868 100644
--- a/drivers/acpi/apei/ghes.c
+++ b/drivers/acpi/apei/ghes.c
@@ -1483,6 +1483,9 @@ int ghes_notify_sea(void)
 	static DEFINE_RAW_SPINLOCK(ghes_notify_lock_sea);
 	int rv;
 
+	if (!ghes_has_active_errors(&ghes_sea))
+		return -ENOENT;
+
 	raw_spin_lock(&ghes_notify_lock_sea);
 	rv = ghes_in_nmi_spool_from_list(&ghes_sea, FIX_APEI_GHES_SEA);
 	raw_spin_unlock(&ghes_notify_lock_sea);
@@ -1490,11 +1493,19 @@ int ghes_notify_sea(void)
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
@@ -1502,10 +1513,11 @@ static void ghes_sea_remove(struct ghes *ghes)
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
 
@@ -1737,7 +1749,9 @@ static int ghes_probe(struct platform_device *ghes_dev)
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


