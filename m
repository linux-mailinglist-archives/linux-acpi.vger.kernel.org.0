Return-Path: <linux-acpi+bounces-19897-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C82B8CE92C2
	for <lists+linux-acpi@lfdr.de>; Tue, 30 Dec 2025 10:12:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 20EE93052207
	for <lists+linux-acpi@lfdr.de>; Tue, 30 Dec 2025 09:10:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D91AE29B77E;
	Tue, 30 Dec 2025 09:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="Dt7QvQjI"
X-Original-To: linux-acpi@vger.kernel.org
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC2C1293C44;
	Tue, 30 Dec 2025 09:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767085818; cv=none; b=Jk6Jx2Oxa7JVR+RAWF3QFWVX7pP6x1rHK0fUl5t1inpd/B03VcewgxWBcGl5BoK3YUgWp9s2NHN+biYtRNZeNOnHVik/9ebKIHoRY32exuGOWygq5opbAgwREKsX6N38aKPPytXGZme8MQuuIjKjm4HtOPGxCdmYIpuCScVcdxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767085818; c=relaxed/simple;
	bh=vPpk/THI/MN2mW+2LGbzYzRJE4ctHOj5JXUB4rNMiHg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MHluIny3sIBwmeDrYvYtw+GL/vfu+6HHvErsOZfbAEC7M7PjHvLNp35zlyuUfoA3lSM2zTjebq1nLOtUiJKIUV4RNB0FGHrUHghOUArts1uUcRqZ9Eew6P5El2t2LNOMi/1QfvL7zNEClNbQYaA5pIbH8+AMJronL0N01uIuMtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=Dt7QvQjI; arc=none smtp.client-ip=115.124.30.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1767085807; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=74GzSC8zfks/a1MM2nAWYChW5ObdAzQ3nbdjBXxWlb4=;
	b=Dt7QvQjIR3Tauz2YI/HtfmtXgjGEv6gvZuPb2xNGQltCYstv99hO3FQS4EnA6oMYSk42UAGXTciSsIpYqrnJPDq8+meUsiEERmE4dNpVOkAmrgQ/2jYfIi5tq/HRCfk5k8vVO6j+gRVsJoT1TeJR48vChPUumBfvp3gS1FzN3vY=
Received: from localhost(mailfrom:tianruidong@linux.alibaba.com fp:SMTPD_---0WvzUnDv_1767085804 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 30 Dec 2025 17:10:06 +0800
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
	misono.tomohiro@fujitsu.com,
	fengwei_yin@linux.alibaba.com
Cc: tianruidong@linux.alibaba.com
Subject: [PATCH v5 06/17] ras: AEST: Support RAS Common Fault Injection Model Extension
Date: Tue, 30 Dec 2025 17:09:34 +0800
Message-Id: <20251230090945.43969-7-tianruidong@linux.alibaba.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20251230090945.43969-1-tianruidong@linux.alibaba.com>
References: <20251230090945.43969-1-tianruidong@linux.alibaba.com>
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
2.47.3


