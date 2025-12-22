Return-Path: <linux-acpi+bounces-19755-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 59EAACD55FB
	for <lists+linux-acpi@lfdr.de>; Mon, 22 Dec 2025 10:46:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9E45C3048095
	for <lists+linux-acpi@lfdr.de>; Mon, 22 Dec 2025 09:44:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E25A3126D4;
	Mon, 22 Dec 2025 09:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="Zt5nLT9l"
X-Original-To: linux-acpi@vger.kernel.org
Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 516B431195B;
	Mon, 22 Dec 2025 09:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766396661; cv=none; b=H1CxHFl1vQfRVljRdo+8878V1vT1gMMJ2WtrsVPU5hXu5SJizMFcIuLow2JGL1zBe+Yg7Tq2W27FRW2PlcpYIxADjNAlA88XWVqHN72T7lD6XEuS+G1Y+BTERQOP5LXRNwY2YBMJdDWpBUCWTO3GW5SIc6UtrPuRGo0xILrC14U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766396661; c=relaxed/simple;
	bh=DnMBcfwUjtt1RUKLWGSecejfX5UC0YZOIdosE1gy7YA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jA4SXgDbhxSeJimxQ1VCwFxKmm9eXtdhyt40GfHDQlgYriGgrBwBjGMyJsjgwy3izDK1akE5IzOd4t+3ahbE6uk/1Uy7/Gtq6yPK2JuInT3yp8Km0KVNABDXXZlO2izPVxyRHVLao3P5T3e9UDC45SFt8ADhZTl82hfhjeZOMtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=Zt5nLT9l; arc=none smtp.client-ip=115.124.30.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1766396655; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=a2pQ+C4SUP4Ig2ZogJ3bhHxA66J4i8YOEkIhS0I/+MI=;
	b=Zt5nLT9lNnFKgrYRuBXdLvwUx/TARg7pog+L6uZfdWv0MvdD0Gra+eiJT1MNs8sMgO/HZb0R54ar9kvW+QfoMW+eoOZ5aAgj9f9gXQB42xW+DVBCCsD28+n1PiAl3e2g70V2z++8akVr7snXqERGTExhsj+1sF0NLK1LzlLckXQ=
Received: from localhost(mailfrom:tianruidong@linux.alibaba.com fp:SMTPD_---0WvOl83P_1766396653 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 22 Dec 2025 17:44:15 +0800
From: Ruidong Tian <tianruidong@linux.alibaba.com>
To: catalin.marinas@arm.com,
	will@kernel.org,
	lpieralisi@kernel.org,
	guohanjun@huawei.com,
	sudeep.holla@arm.com,
	xueshuai@linux.alibaba.com,
	linux-kernel@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	rafael@kernel.org,
	lenb@kernel.org,
	tony.luck@intel.com,
	bp@alien8.de,
	yazen.ghannam@amd.com,
	misono.tomohiro@fujitsu.com
Cc: tianruidong@linux.alibaba.com
Subject: [PATCH v4 06/17] ras: AEST: Support RAS Common Fault Injection Model Extension
Date: Mon, 22 Dec 2025 17:43:39 +0800
Message-Id: <20251222094351.38792-7-tianruidong@linux.alibaba.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20251222094351.38792-1-tianruidong@linux.alibaba.com>
References: <20251222094351.38792-1-tianruidong@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add inject register descripted in Common Fault Injection Model
Extension.

Signed-off-by: Ruidong Tian <tianruidong@linux.alibaba.com>
---
 drivers/ras/aest/aest-core.c | 15 ++++++++++++++-
 drivers/ras/aest/aest.h      | 10 ++++++++++
 2 files changed, 24 insertions(+), 1 deletion(-)

diff --git a/drivers/ras/aest/aest-core.c b/drivers/ras/aest/aest-core.c
index 84b2fb8127ff..1218ae51079c 100644
--- a/drivers/ras/aest/aest-core.c
+++ b/drivers/ras/aest/aest-core.c
@@ -124,7 +124,7 @@ static int aest_init_node(struct aest_device *adev, struct aest_node *node,
 			  struct acpi_aest_node *anode)
 {
 	int i, ret;
-	u64 address;
+	u64 address, flags;
 
 	node->adev = adev;
 	node->info = anode;
@@ -145,6 +145,19 @@ static int aest_init_node(struct aest_device *adev, struct aest_node *node,
 			return -ENOMEM;
 	}
 
+	flags = anode->interface_hdr->flags;
+	address = node->info->common->fault_inject_register_base;
+	if ((flags & AEST_XFACE_FLAG_FAULT_INJECT) && address) {
+		if (address - anode->interface_hdr->address < node->group->size)
+			node->inj = node->base +
+				    (address - anode->interface_hdr->address);
+		else {
+			node->inj = devm_ioremap(adev->dev, address, PAGE_SIZE);
+			if (!node->inj)
+				return -ENOMEM;
+		}
+	}
+
 	ret = aest_node_set_errgsr(adev, node);
 	if (ret)
 		return ret;
diff --git a/drivers/ras/aest/aest.h b/drivers/ras/aest/aest.h
index bf0b9a49fdaa..505ecd9635bc 100644
--- a/drivers/ras/aest/aest.h
+++ b/drivers/ras/aest/aest.h
@@ -60,6 +60,9 @@
 #define ERXMISC1 0x28
 #define ERXMISC2 0x30
 #define ERXMISC3 0x38
+#define ERXPFGF 0x800
+#define ERXPFGCTL 0x808
+#define ERXPFGCDN 0x810
 
 #define GIC_ERRDEVARCH 0xFFBC
 
@@ -120,6 +123,7 @@ struct aest_node {
 	u8 type;
 	void *errgsr;
 	void *base;
+	void *inj;
 
 	/*
 	 * This bitmap indicates which of the error records within this error
@@ -208,6 +212,9 @@ static inline u64 aest_sysreg_read(void *__unused, u32 offset)
 		CASE_READ(res, ERXMISC1)
 		CASE_READ(res, ERXMISC2)
 		CASE_READ(res, ERXMISC3)
+		CASE_READ(res, ERXPFGF)
+		CASE_READ(res, ERXPFGCTL)
+		CASE_READ(res, ERXPFGCDN)
 	default :
 		res = 0;
 	}
@@ -225,6 +232,9 @@ static inline void aest_sysreg_write(void *base, u32 offset, u64 val)
 		CASE_WRITE(val, ERXMISC1)
 		CASE_WRITE(val, ERXMISC2)
 		CASE_WRITE(val, ERXMISC3)
+		CASE_WRITE(val, ERXPFGF)
+		CASE_WRITE(val, ERXPFGCTL)
+		CASE_WRITE(val, ERXPFGCDN)
 	default :
 		return;
 	}
-- 
2.51.2.612.gdc70283dfc


