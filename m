Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90CFB306018
	for <lists+linux-acpi@lfdr.de>; Wed, 27 Jan 2021 16:48:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234782AbhA0Prb (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 27 Jan 2021 10:47:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236644AbhA0Pp6 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 27 Jan 2021 10:45:58 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D6BFC061352
        for <linux-acpi@vger.kernel.org>; Wed, 27 Jan 2021 07:44:44 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id 190so1923350wmz.0
        for <linux-acpi@vger.kernel.org>; Wed, 27 Jan 2021 07:44:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tYnI/Xt3oYzBq3RcE9O/zctEuyA4AvchKpT/A0KDE3A=;
        b=ruYUr3asCJkiWMZqX/2pPM1Py9KGdSwjvw86YXdm8jjE5F4yusgIfV1RKx3Cs/cq/F
         e5+A6cmTJMkM27OdjClhQau+TH66YdIs+Oy3VVgjKpMDeBDJcMVC/ZsHnYq7uwMvdMts
         EbceoCB7MCfhN91HROZuPB4t8n/6RZ6m44l+FS7wghy/zp+PtFLLUuYd2cTZ7akA6flQ
         CpujCePN2Ift9R3fC3ZSlU0I/OA8fkq5tYOBm6sDEcLw67jgx7+69ZD7CQpKXs3T2DLx
         cx/2lrNnk60w+/WhoxqeZTE7NQaN14rXdyro9XdKK7YWEMKPeY6R5RnhIb7NUTl0jX9V
         zm3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tYnI/Xt3oYzBq3RcE9O/zctEuyA4AvchKpT/A0KDE3A=;
        b=qIb4bFTYGcAUDLrOVFMtBLKJ1d5wnZJsixX054Fd7Zf3tNup9uqm8NHp4fXkLJOFhi
         uwsDyIL5y5pZZHyBWnlvbYk6GjOtx9Lm07z0S576VupvXiOq478v8EHb7Zn3g1YtgeFw
         UR3cpFUU1cW9VkZfSSMYlNBXf3473ZEAu7tAXwy2P44in7Wka+4taoV7zJIs/9Gz2Ou6
         KMizPotRc6SHWDcZNpGM2thAh7wHaovNJB8A/UzvgZVGZpy/J2LZYbk5HhhfKBuWFu2t
         r0Xiujfwl3Cj1u76gsjgP9g9Gl8bbIKS55SUBJ8raza68U9a5oJNx04n7cr9R5vz1qFe
         FEGA==
X-Gm-Message-State: AOAM5333699+6q1k62LjDqCkjDhS1IPY+HDX+ivX1S/XK72dNIE6tahg
        elcHUepSfMOOvj5kQf5X+S0ByA==
X-Google-Smtp-Source: ABdhPJxtxvrLE5P8Khnc7eSt7OAabAcUtAYcS23ssj89jKfRlHTuVCmEd5gwJW6c5FmK7NIxMGi40Q==
X-Received: by 2002:a1c:a145:: with SMTP id k66mr4719492wme.18.1611762282841;
        Wed, 27 Jan 2021 07:44:42 -0800 (PST)
Received: from localhost.localdomain ([2001:1715:4e26:a7e0:116c:c27a:3e7f:5eaf])
        by smtp.gmail.com with ESMTPSA id r13sm3046921wmh.9.2021.01.27.07.44.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Jan 2021 07:44:42 -0800 (PST)
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     joro@8bytes.org, will@kernel.org
Cc:     lorenzo.pieralisi@arm.com, robh+dt@kernel.org,
        guohanjun@huawei.com, sudeep.holla@arm.com, rjw@rjwysocki.net,
        lenb@kernel.org, robin.murphy@arm.com, Jonathan.Cameron@huawei.com,
        eric.auger@redhat.com, iommu@lists.linux-foundation.org,
        devicetree@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-accelerators@lists.ozlabs.org, baolu.lu@linux.intel.com,
        jacob.jun.pan@linux.intel.com, kevin.tian@intel.com,
        vdumpa@nvidia.com, zhangfei.gao@linaro.org,
        shameerali.kolothum.thodi@huawei.com, vivek.gautam@arm.com,
        Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: [PATCH v12 07/10] iommu/arm-smmu-v3: Maintain a SID->device structure
Date:   Wed, 27 Jan 2021 16:43:20 +0100
Message-Id: <20210127154322.3959196-8-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210127154322.3959196-1-jean-philippe@linaro.org>
References: <20210127154322.3959196-1-jean-philippe@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

When handling faults from the event or PRI queue, we need to find the
struct device associated with a SID. Add a rb_tree to keep track of
SIDs.

Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h |  13 +-
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 161 ++++++++++++++++----
 2 files changed, 144 insertions(+), 30 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index f985817c967a..7b15b7580c6e 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -639,6 +639,15 @@ struct arm_smmu_device {
 
 	/* IOMMU core code handle */
 	struct iommu_device		iommu;
+
+	struct rb_root			streams;
+	struct mutex			streams_mutex;
+};
+
+struct arm_smmu_stream {
+	u32				id;
+	struct arm_smmu_master		*master;
+	struct rb_node			node;
 };
 
 /* SMMU private data for each master */
@@ -647,8 +656,8 @@ struct arm_smmu_master {
 	struct device			*dev;
 	struct arm_smmu_domain		*domain;
 	struct list_head		domain_head;
-	u32				*sids;
-	unsigned int			num_sids;
+	struct arm_smmu_stream		*streams;
+	unsigned int			num_streams;
 	bool				ats_enabled;
 	bool				sva_enabled;
 	struct list_head		bonds;
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 88dd9feb32f4..3afec6ed8075 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -909,8 +909,8 @@ static void arm_smmu_sync_cd(struct arm_smmu_domain *smmu_domain,
 
 	spin_lock_irqsave(&smmu_domain->devices_lock, flags);
 	list_for_each_entry(master, &smmu_domain->devices, domain_head) {
-		for (i = 0; i < master->num_sids; i++) {
-			cmd.cfgi.sid = master->sids[i];
+		for (i = 0; i < master->num_streams; i++) {
+			cmd.cfgi.sid = master->streams[i].id;
 			arm_smmu_cmdq_batch_add(smmu, &cmds, &cmd);
 		}
 	}
@@ -1355,6 +1355,32 @@ static int arm_smmu_init_l2_strtab(struct arm_smmu_device *smmu, u32 sid)
 	return 0;
 }
 
+__maybe_unused
+static struct arm_smmu_master *
+arm_smmu_find_master(struct arm_smmu_device *smmu, u32 sid)
+{
+	struct rb_node *node;
+	struct arm_smmu_stream *stream;
+	struct arm_smmu_master *master = NULL;
+
+	mutex_lock(&smmu->streams_mutex);
+	node = smmu->streams.rb_node;
+	while (node) {
+		stream = rb_entry(node, struct arm_smmu_stream, node);
+		if (stream->id < sid) {
+			node = node->rb_right;
+		} else if (stream->id > sid) {
+			node = node->rb_left;
+		} else {
+			master = stream->master;
+			break;
+		}
+	}
+	mutex_unlock(&smmu->streams_mutex);
+
+	return master;
+}
+
 /* IRQ and event handlers */
 static irqreturn_t arm_smmu_evtq_thread(int irq, void *dev)
 {
@@ -1588,8 +1614,8 @@ static int arm_smmu_atc_inv_master(struct arm_smmu_master *master)
 
 	arm_smmu_atc_inv_to_cmd(0, 0, 0, &cmd);
 
-	for (i = 0; i < master->num_sids; i++) {
-		cmd.atc.sid = master->sids[i];
+	for (i = 0; i < master->num_streams; i++) {
+		cmd.atc.sid = master->streams[i].id;
 		arm_smmu_cmdq_issue_cmd(master->smmu, &cmd);
 	}
 
@@ -1632,8 +1658,8 @@ int arm_smmu_atc_inv_domain(struct arm_smmu_domain *smmu_domain, int ssid,
 		if (!master->ats_enabled)
 			continue;
 
-		for (i = 0; i < master->num_sids; i++) {
-			cmd.atc.sid = master->sids[i];
+		for (i = 0; i < master->num_streams; i++) {
+			cmd.atc.sid = master->streams[i].id;
 			arm_smmu_cmdq_batch_add(smmu_domain->smmu, &cmds, &cmd);
 		}
 	}
@@ -2065,13 +2091,13 @@ static void arm_smmu_install_ste_for_dev(struct arm_smmu_master *master)
 	int i, j;
 	struct arm_smmu_device *smmu = master->smmu;
 
-	for (i = 0; i < master->num_sids; ++i) {
-		u32 sid = master->sids[i];
+	for (i = 0; i < master->num_streams; ++i) {
+		u32 sid = master->streams[i].id;
 		__le64 *step = arm_smmu_get_step_for_sid(smmu, sid);
 
 		/* Bridged PCI devices may end up with duplicated IDs */
 		for (j = 0; j < i; j++)
-			if (master->sids[j] == sid)
+			if (master->streams[j].id == sid)
 				break;
 		if (j < i)
 			continue;
@@ -2345,11 +2371,101 @@ static bool arm_smmu_sid_in_range(struct arm_smmu_device *smmu, u32 sid)
 	return sid < limit;
 }
 
+static int arm_smmu_insert_master(struct arm_smmu_device *smmu,
+				  struct arm_smmu_master *master)
+{
+	int i;
+	int ret = 0;
+	struct arm_smmu_stream *new_stream, *cur_stream;
+	struct rb_node **new_node, *parent_node = NULL;
+	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(master->dev);
+
+	master->streams = kcalloc(fwspec->num_ids,
+				  sizeof(*master->streams), GFP_KERNEL);
+	if (!master->streams)
+		return -ENOMEM;
+	master->num_streams = fwspec->num_ids;
+
+	mutex_lock(&smmu->streams_mutex);
+	for (i = 0; i < fwspec->num_ids && !ret; i++) {
+		u32 sid = fwspec->ids[i];
+
+		new_stream = &master->streams[i];
+		new_stream->id = sid;
+		new_stream->master = master;
+
+		/*
+		 * Check the SIDs are in range of the SMMU and our stream table
+		 */
+		if (!arm_smmu_sid_in_range(smmu, sid)) {
+			ret = -ERANGE;
+			break;
+		}
+
+		/* Ensure l2 strtab is initialised */
+		if (smmu->features & ARM_SMMU_FEAT_2_LVL_STRTAB) {
+			ret = arm_smmu_init_l2_strtab(smmu, sid);
+			if (ret)
+				break;
+		}
+
+		/* Insert into SID tree */
+		new_node = &(smmu->streams.rb_node);
+		while (*new_node) {
+			cur_stream = rb_entry(*new_node, struct arm_smmu_stream,
+					      node);
+			parent_node = *new_node;
+			if (cur_stream->id > new_stream->id) {
+				new_node = &((*new_node)->rb_left);
+			} else if (cur_stream->id < new_stream->id) {
+				new_node = &((*new_node)->rb_right);
+			} else {
+				dev_warn(master->dev,
+					 "stream %u already in tree\n",
+					 cur_stream->id);
+				ret = -EINVAL;
+				break;
+			}
+		}
+
+		if (!ret) {
+			rb_link_node(&new_stream->node, parent_node, new_node);
+			rb_insert_color(&new_stream->node, &smmu->streams);
+		}
+	}
+
+	if (ret) {
+		for (; i > 0; i--)
+			rb_erase(&master->streams[i].node, &smmu->streams);
+		kfree(master->streams);
+	}
+	mutex_unlock(&smmu->streams_mutex);
+
+	return ret;
+}
+
+static void arm_smmu_remove_master(struct arm_smmu_master *master)
+{
+	int i;
+	struct arm_smmu_device *smmu = master->smmu;
+	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(master->dev);
+
+	if (!smmu || !master->streams)
+		return;
+
+	mutex_lock(&smmu->streams_mutex);
+	for (i = 0; i < fwspec->num_ids; i++)
+		rb_erase(&master->streams[i].node, &smmu->streams);
+	mutex_unlock(&smmu->streams_mutex);
+
+	kfree(master->streams);
+}
+
 static struct iommu_ops arm_smmu_ops;
 
 static struct iommu_device *arm_smmu_probe_device(struct device *dev)
 {
-	int i, ret;
+	int ret;
 	struct arm_smmu_device *smmu;
 	struct arm_smmu_master *master;
 	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
@@ -2370,27 +2486,12 @@ static struct iommu_device *arm_smmu_probe_device(struct device *dev)
 
 	master->dev = dev;
 	master->smmu = smmu;
-	master->sids = fwspec->ids;
-	master->num_sids = fwspec->num_ids;
 	INIT_LIST_HEAD(&master->bonds);
 	dev_iommu_priv_set(dev, master);
 
-	/* Check the SIDs are in range of the SMMU and our stream table */
-	for (i = 0; i < master->num_sids; i++) {
-		u32 sid = master->sids[i];
-
-		if (!arm_smmu_sid_in_range(smmu, sid)) {
-			ret = -ERANGE;
-			goto err_free_master;
-		}
-
-		/* Ensure l2 strtab is initialised */
-		if (smmu->features & ARM_SMMU_FEAT_2_LVL_STRTAB) {
-			ret = arm_smmu_init_l2_strtab(smmu, sid);
-			if (ret)
-				goto err_free_master;
-		}
-	}
+	ret = arm_smmu_insert_master(smmu, master);
+	if (ret)
+		goto err_free_master;
 
 	device_property_read_u32(dev, "pasid-num-bits", &master->ssid_bits);
 	master->ssid_bits = min(smmu->ssid_bits, master->ssid_bits);
@@ -2429,6 +2530,7 @@ static void arm_smmu_release_device(struct device *dev)
 	WARN_ON(arm_smmu_master_sva_enabled(master));
 	arm_smmu_detach_dev(master);
 	arm_smmu_disable_pasid(master);
+	arm_smmu_remove_master(master);
 	kfree(master);
 	iommu_fwspec_free(dev);
 }
@@ -2852,6 +2954,9 @@ static int arm_smmu_init_structures(struct arm_smmu_device *smmu)
 {
 	int ret;
 
+	mutex_init(&smmu->streams_mutex);
+	smmu->streams = RB_ROOT;
+
 	ret = arm_smmu_init_queues(smmu);
 	if (ret)
 		return ret;
-- 
2.30.0

