Return-Path: <linux-acpi+bounces-19754-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 755D7CD55EC
	for <lists+linux-acpi@lfdr.de>; Mon, 22 Dec 2025 10:45:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BF4C4303C994
	for <lists+linux-acpi@lfdr.de>; Mon, 22 Dec 2025 09:44:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 612543126CB;
	Mon, 22 Dec 2025 09:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="FbHp4OzD"
X-Original-To: linux-acpi@vger.kernel.org
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B3EC3126AF;
	Mon, 22 Dec 2025 09:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766396659; cv=none; b=mDkuhQztNuSSBA5wAvOHbTstfdFbqIIv0h/KwNeO1kcXDquoy8F7VxMu18uNebJX4Ugz4NcK97PgflxvhpJ1llyICJvPiR3CugxLEPDJhSRQ/dc7oFUvjaSclLE3qGjP1hE7W2lwiUEap19dr8X1UgE4LyH6TKCl0xg+Pt4lB/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766396659; c=relaxed/simple;
	bh=JxvMWPoKGlB3uCfwmZ2W41dAQhQ/djGCES7s6qCtI0A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XD54CBO/YiyLhAflnkac9nH/mio8AfDombSIgs9wXm5vqUm2+hK26E/A/AvMypxQK2Cp0vCD6xolfMDk5VEwMUctgy+ECdIhk2WEHxT+giAngeiPQmMofSdkNfdM/OIFjm22u7xV/q1bJwqhZu6RV5k+6+vu0rmRmyDk8H/eNkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=FbHp4OzD; arc=none smtp.client-ip=115.124.30.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1766396653; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=5Gb/0pO9ZhFEXcQF/4tc/EbwH+IhljJ6XBnX4XBc2RQ=;
	b=FbHp4OzDjENTWrouiaqvzQcMMc0jb8bCtvhtMQVnW/xSkOnB0M9gDUpig/d/QkJaeY5qSxW5HcYgIux0p8CyiLOZwki7wM8SNJNpnCBIIKEc3rYaEBDJdERwGWjJdRtHq9HKSVn2xc8oR3OWSZBEt93YqDxSetSSrpo6B1rFeuA=
Received: from localhost(mailfrom:tianruidong@linux.alibaba.com fp:SMTPD_---0WvOT.PY_1766396651 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 22 Dec 2025 17:44:13 +0800
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
Subject: [PATCH v4 05/17] ras: AEST: Probe RAS system architecture version
Date: Mon, 22 Dec 2025 17:43:38 +0800
Message-Id: <20251222094351.38792-6-tianruidong@linux.alibaba.com>
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

The RAS version of a component can be probed via its ERRDEVARCH register.

In cases where a component (e.g., SMMU) does not implement an ERRDEVARCH
register, the driver falls back to using the RAS version of the Processing
Element (PE).

Signed-off-by: Ruidong Tian <tianruidong@linux.alibaba.com>
---
 arch/arm64/include/asm/ras.h |  3 +++
 drivers/ras/aest/aest-core.c | 22 ++++++++++++++++++++++
 drivers/ras/aest/aest.h      |  3 +++
 3 files changed, 28 insertions(+)

diff --git a/arch/arm64/include/asm/ras.h b/arch/arm64/include/asm/ras.h
index b6640b9972bf..da7c441252fe 100644
--- a/arch/arm64/include/asm/ras.h
+++ b/arch/arm64/include/asm/ras.h
@@ -4,6 +4,9 @@
 
 #include <linux/types.h>
 
+/* ERRDEVARCH */
+#define ERRDEVARCH_REV GENMASK(19, 16)
+
 struct ras_ext_regs {
 	u64 err_fr;
 	u64 err_ctlr;
diff --git a/drivers/ras/aest/aest-core.c b/drivers/ras/aest/aest-core.c
index f4a5119dc513..84b2fb8127ff 100644
--- a/drivers/ras/aest/aest-core.c
+++ b/drivers/ras/aest/aest-core.c
@@ -16,6 +16,27 @@ DEFINE_PER_CPU(struct aest_device, percpu_adev);
 #undef pr_fmt
 #define pr_fmt(fmt) "AEST: " fmt
 
+static int get_aest_node_ver(struct aest_node *node)
+{
+	u64 reg;
+	void *devarch_base;
+
+	if (node->type == ACPI_AEST_GIC_ERROR_NODE) {
+		devarch_base = ioremap(node->info->interface_hdr->address +
+					       GIC_ERRDEVARCH,
+				       PAGE_SIZE);
+		if (!devarch_base)
+			return 0;
+
+		reg = readl_relaxed(devarch_base);
+		iounmap(devarch_base);
+
+		return FIELD_GET(ERRDEVARCH_REV, reg);
+	}
+
+	return FIELD_GET(ID_AA64PFR0_EL1_RAS_MASK, read_cpuid(ID_AA64PFR0_EL1));
+}
+
 static int aest_init_record(struct aest_record *record, int i,
 			    struct aest_node *node)
 {
@@ -108,6 +129,7 @@ static int aest_init_node(struct aest_device *adev, struct aest_node *node,
 	node->adev = adev;
 	node->info = anode;
 	node->type = anode->type;
+	node->version = get_aest_node_ver(node);
 	node->name = alloc_aest_node_name(node);
 	if (!node->name)
 		return -ENOMEM;
diff --git a/drivers/ras/aest/aest.h b/drivers/ras/aest/aest.h
index 31131cce9928..bf0b9a49fdaa 100644
--- a/drivers/ras/aest/aest.h
+++ b/drivers/ras/aest/aest.h
@@ -61,6 +61,8 @@
 #define ERXMISC2 0x30
 #define ERXMISC3 0x38
 
+#define GIC_ERRDEVARCH 0xFFBC
+
 struct aest_access {
 	u64 (*read)(void *base, u32 offset);
 	void (*write)(void *base, u32 offset, u64 val);
@@ -141,6 +143,7 @@ struct aest_node {
 	 *              error events.
 	 */
 	unsigned long *status_reporting;
+	int version;
 
 	const struct aest_group *group;
 	struct aest_device *adev;
-- 
2.51.2.612.gdc70283dfc


