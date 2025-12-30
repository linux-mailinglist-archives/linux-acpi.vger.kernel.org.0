Return-Path: <linux-acpi+bounces-19905-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F869CE92F5
	for <lists+linux-acpi@lfdr.de>; Tue, 30 Dec 2025 10:15:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7A0B13040658
	for <lists+linux-acpi@lfdr.de>; Tue, 30 Dec 2025 09:13:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18987296BC3;
	Tue, 30 Dec 2025 09:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="Mz0cOcT5"
X-Original-To: linux-acpi@vger.kernel.org
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBA3828F935;
	Tue, 30 Dec 2025 09:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767086020; cv=none; b=Mi70maozSFD34LZvOikWTfDqndA4OpKbj4SgrL0xi4S1LCeDc4+mG5jCFN7+jXamE0uDr531x5DVOstIjmtAr9mNbFG8UIccZSKxwCxNt/6x9jmr9rD4zil6UUi4zfx7IXK0+gDVU8rOE3kzey/e60c0+xzAz1LdiAj/PP4SWsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767086020; c=relaxed/simple;
	bh=pyja+59uomzqLzxRptu44/VK92yEFMvlK3Vp6USK2SE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZvgCQz49BnYoMO36RLURobd3SiQW4+dxuEgAqlTG5RMMtNfjRpoBPgwLt1KruF2WPtwV9CSUuFfQJ8SbCN8F4ExTxIo+MOlLYJ2FTGe0q8SgKbk3tROd/sbghnL70azNrCMtLQUKpGx38Ge8C2rbIphdAaNPAUmL8kTpDb70/qY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=Mz0cOcT5; arc=none smtp.client-ip=115.124.30.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1767086015; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=z6bjjzmoiF3Vk4RhLCBDs5f1E17Xepav3f46Orj2EhI=;
	b=Mz0cOcT5GiTBTIknyGo2QdBpDk50lYezZtcUzwFznMEOuxqqNyybEj0YceDUdQyFjHi07LvGvkWYzSQT1MIMVlLd9U3PK9CSHxygNXdPYlTVIvJG23iYapzOQl6UNoOGt6rhXHgJGgT0la63CqQnJpySUwiqELEO7fpmPtqKxk0=
Received: from localhost(mailfrom:tianruidong@linux.alibaba.com fp:SMTPD_---0WvzWEmD_1767086013 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 30 Dec 2025 17:13:35 +0800
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
Subject: [PATCH v5 15/17] ras: AEST: Add framework to process AEST vendor node
Date: Tue, 30 Dec 2025 17:13:32 +0800
Message-Id: <20251230091332.50209-1-tianruidong@linux.alibaba.com>
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

AEST table include vendor error node to support the component that do
not implement standard Arm RAS architecture[1]. Each vendor node may
have their own initialize and interrupt handle function. This patch
supply a framework to process vendor error nodes, the vendor process
function is binded with vendor HID.

[1]: https://developer.arm.com/documentation/ddi0587/latest/

Signed-off-by: Ruidong Tian <tianruidong@linux.alibaba.com>
---
 drivers/ras/aest/aest-core.c | 28 +++++++++++++++++++++++++++-
 drivers/ras/aest/aest.h      |  5 +++++
 2 files changed, 32 insertions(+), 1 deletion(-)

diff --git a/drivers/ras/aest/aest-core.c b/drivers/ras/aest/aest-core.c
index 052211ca3e2a..4d20e54832fd 100644
--- a/drivers/ras/aest/aest-core.c
+++ b/drivers/ras/aest/aest-core.c
@@ -925,6 +925,29 @@ static int aest_setup_irq(struct platform_device *pdev,
 	return 0;
 }
 
+static struct aest_vendor_match vendor_match[] = {
+	{  },
+};
+
+static int
+aest_vendor_probe(struct aest_device *adev, struct aest_hnode *ahnode)
+{
+	int i;
+	struct acpi_aest_node *anode;
+
+	anode = list_first_entry(&ahnode->list, struct acpi_aest_node, list);
+	if (!anode)
+		return -ENODEV;
+
+	aest_dev_dbg(adev, "Try to probe vendor node %s\n", anode->vendor->acpi_hid);
+	for (i = 0; i < ARRAY_SIZE(vendor_match); i++) {
+		if (!strncmp(vendor_match[i].hid, anode->vendor->acpi_hid, 8))
+			return vendor_match[i].probe(adev, ahnode);
+	}
+
+	return -ENODEV;
+}
+
 static int aest_device_probe(struct platform_device *pdev)
 {
 	int ret;
@@ -950,7 +973,10 @@ static int aest_device_probe(struct platform_device *pdev)
 	}
 	init_llist_head(&adev->event_list);
 
-	ret = aest_init_nodes(adev, ahnode);
+	if (ahnode->type == ACPI_AEST_VENDOR_ERROR_NODE)
+		ret = aest_vendor_probe(adev, ahnode);
+	else
+		ret = aest_init_nodes(adev, ahnode);
 	if (ret)
 		return ret;
 
diff --git a/drivers/ras/aest/aest.h b/drivers/ras/aest/aest.h
index 2f6a7b9ca4ef..304c03839d31 100644
--- a/drivers/ras/aest/aest.h
+++ b/drivers/ras/aest/aest.h
@@ -244,6 +244,11 @@ static const char *const aest_node_name[] = {
 	[ACPI_AEST_PROXY_ERROR_NODE] = "proxy",
 };
 
+struct aest_vendor_match {
+	char hid[ACPI_ID_LEN];
+	int (*probe)(struct aest_device *adev, struct aest_hnode *anode);
+};
+
 static inline int aest_set_name(struct aest_device *adev,
 				struct aest_hnode *ahnode)
 {
-- 
2.47.3


