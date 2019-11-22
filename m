Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 92CEF106F91
	for <lists+linux-acpi@lfdr.de>; Fri, 22 Nov 2019 12:16:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728368AbfKVLQM (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 22 Nov 2019 06:16:12 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:39289 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729483AbfKVKvC (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 22 Nov 2019 05:51:02 -0500
Received: by mail-wr1-f66.google.com with SMTP id y11so4938683wrt.6
        for <linux-acpi@vger.kernel.org>; Fri, 22 Nov 2019 02:51:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CtJV+Z/+/tbCQItMssO61Gtwu58uukk1EMY1cx5Lnrc=;
        b=mCKz+BwSiQij013yjrKfw6oVS8rZuOUhHnkYyeMuylQQuFFsn9XIbdgBHPAB3A8pdU
         cMUMBgkrvvyXzSZLc4JjMGoOSzDyj//LqR8hEsiytCRio7CzvsCfCntQef1cjjByIfQ+
         0DBqbuPYhmOF4UbwVb2bHkiMX1wUo68X/5aywzwjn2hqptbDdDMBAVskk51+xMBuyCTU
         0aOnmA88FRuITCJgViQafNz+hmtGYWMc11yYsyCe7/24XyqUneiJC1AQ84o9o8cla+Ey
         ATsb1Rzo34z2s9+ijfxeiOEUyGmCjwuFbjm2z5hrxBdndr6/6EsPwSvHM8DWWWBQjgAR
         RgBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CtJV+Z/+/tbCQItMssO61Gtwu58uukk1EMY1cx5Lnrc=;
        b=alO4t3CqdVzxD6DY5GC99zNbyr0eOjIamgKUNZ2wPqt9C7UzI1/jCsvDpN9SjqRdvB
         gRUnEcvuGM8YDKf2KL+nCOW7f5X8V+wTsFTikys2p9lia0+dZboPxkIVZ8/VmlRSQW8K
         2AiH+6ZJyqi9LJUmRIGEPKtp3p+Co8S+SUfrG6lp3GDkAgj/KWhKC9Zl79uAvRp6dvtv
         4CWqyL154u7TOIe4UOQNLhicXgyZl45yhXZYV/wAYvl5WCFg1I2usjoSNh6n9oX7T+Dj
         w/LzvSmkZm8+gO5I+GUzON6A19BxtGlpS1NrOnA+lTTEKUV3D36/Iw99LgzPQhGabGof
         Jp+g==
X-Gm-Message-State: APjAAAWIgGk6iGSqaZeFE8OHX/z9y8UtO0uQudui2rv94jNOO/i5t2bd
        4EmTBBSxPSDgANomLtPCbAEgJVIXS84=
X-Google-Smtp-Source: APXvYqx7MG4bOlzFFisEZutGEcVZWtWFA9RVeyazzfivhpVCLuQP4wNiRtqWewtbovVtsPJwXnRjLg==
X-Received: by 2002:a5d:4a8c:: with SMTP id o12mr508171wrq.43.1574419860358;
        Fri, 22 Nov 2019 02:51:00 -0800 (PST)
Received: from localhost.localdomain (xdsl-188-155-204-106.adslplus.ch. [188.155.204.106])
        by smtp.gmail.com with ESMTPSA id o133sm2088197wmb.4.2019.11.22.02.50.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Nov 2019 02:50:59 -0800 (PST)
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org,
        virtualization@lists.linux-foundation.org,
        linux-pci@vger.kernel.org, virtio-dev@lists.oasis-open.org
Cc:     rjw@rjwysocki.net, lenb@kernel.org, lorenzo.pieralisi@arm.com,
        guohanjun@huawei.com, sudeep.holla@arm.com,
        gregkh@linuxfoundation.org, joro@8bytes.org, bhelgaas@google.com,
        mst@redhat.com, jasowang@redhat.com, jacob.jun.pan@intel.com,
        eric.auger@redhat.com, sebastien.boeuf@intel.com,
        kevin.tian@intel.com
Subject: [RFC 07/13] ACPI/IORT: Defer probe until virtio-iommu-pci has registered a fwnode
Date:   Fri, 22 Nov 2019 11:49:54 +0100
Message-Id: <20191122105000.800410-8-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191122105000.800410-1-jean-philippe@linaro.org>
References: <20191122105000.800410-1-jean-philippe@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

When the IOMMU is PCI-based, IORT doesn't know the fwnode until the
driver has had a chance to register it. In addition to deferring the
probe until the IOMMU ops are set, also defer the probe until the fwspec
is available.

Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
 drivers/acpi/iort.c | 54 ++++++++++++++++++++++++++-------------------
 1 file changed, 31 insertions(+), 23 deletions(-)

diff --git a/drivers/acpi/iort.c b/drivers/acpi/iort.c
index b517aa4e83ba..f08f72d8af78 100644
--- a/drivers/acpi/iort.c
+++ b/drivers/acpi/iort.c
@@ -61,6 +61,22 @@ static bool iort_type_matches(u8 type, enum iort_node_category category)
 	}
 }
 
+static inline bool iort_iommu_driver_enabled(u8 type)
+{
+	switch (type) {
+	case ACPI_IORT_NODE_SMMU_V3:
+		return IS_BUILTIN(CONFIG_ARM_SMMU_V3);
+	case ACPI_IORT_NODE_SMMU:
+		return IS_BUILTIN(CONFIG_ARM_SMMU);
+	case ACPI_VIOT_IORT_NODE_VIRTIO_MMIO_IOMMU:
+	case ACPI_VIOT_IORT_NODE_VIRTIO_PCI_IOMMU:
+		return IS_ENABLED(CONFIG_VIRTIO_IOMMU);
+	default:
+		pr_warn("IORT node type %u does not describe an IOMMU\n", type);
+		return false;
+	}
+}
+
 /**
  * iort_set_fwnode() - Create iort_fwnode and use it to register
  *		       iommu data in the iort_fwnode_list
@@ -102,9 +118,9 @@ static inline int iort_set_fwnode(struct acpi_iort_node *iort_node,
  *
  * Returns: fwnode_handle pointer on success, NULL on failure
  */
-static inline struct fwnode_handle *iort_get_fwnode(
-			struct acpi_iort_node *node)
+static inline struct fwnode_handle *iort_get_fwnode(struct acpi_iort_node *node)
 {
+	int err = -ENODEV;
 	struct iort_fwnode *curr;
 	struct fwnode_handle *fwnode = NULL;
 
@@ -112,12 +128,20 @@ static inline struct fwnode_handle *iort_get_fwnode(
 	list_for_each_entry(curr, &iort_fwnode_list, list) {
 		if (curr->iort_node == node) {
 			fwnode = curr->fwnode;
+			if (!fwnode && curr->pci_devid) {
+				/*
+				 * Postpone probe until virtio-iommu has
+				 * registered its fwnode.
+				 */
+				err = iort_iommu_driver_enabled(node->type) ?
+					-EPROBE_DEFER : -ENODEV;
+			}
 			break;
 		}
 	}
 	spin_unlock(&iort_fwnode_lock);
 
-	return fwnode;
+	return fwnode ?: ERR_PTR(err);
 }
 
 /**
@@ -874,22 +898,6 @@ int iort_iommu_msi_get_resv_regions(struct device *dev, struct list_head *head)
 	return (resv == its->its_count) ? resv : -ENODEV;
 }
 
-static inline bool iort_iommu_driver_enabled(u8 type)
-{
-	switch (type) {
-	case ACPI_IORT_NODE_SMMU_V3:
-		return IS_BUILTIN(CONFIG_ARM_SMMU_V3);
-	case ACPI_IORT_NODE_SMMU:
-		return IS_BUILTIN(CONFIG_ARM_SMMU);
-	case ACPI_VIOT_IORT_NODE_VIRTIO_MMIO_IOMMU:
-	case ACPI_VIOT_IORT_NODE_VIRTIO_PCI_IOMMU:
-		return IS_ENABLED(CONFIG_VIRTIO_IOMMU);
-	default:
-		pr_warn("IORT node type %u does not describe an IOMMU\n", type);
-		return false;
-	}
-}
-
 static int arm_smmu_iort_xlate(struct device *dev, u32 streamid,
 			       struct fwnode_handle *fwnode,
 			       const struct iommu_ops *ops)
@@ -920,8 +928,8 @@ static int iort_iommu_xlate(struct device *dev, struct acpi_iort_node *node,
 		return -ENODEV;
 
 	iort_fwnode = iort_get_fwnode(node);
-	if (!iort_fwnode)
-		return -ENODEV;
+	if (IS_ERR(iort_fwnode))
+		return PTR_ERR(iort_fwnode);
 
 	/*
 	 * If the ops look-up fails, this means that either
@@ -1618,8 +1626,8 @@ static int __init iort_add_platform_device(struct acpi_iort_node *node,
 
 	fwnode = iort_get_fwnode(node);
 
-	if (!fwnode) {
-		ret = -ENODEV;
+	if (IS_ERR(fwnode)) {
+		ret = PTR_ERR(fwnode);
 		goto dev_put;
 	}
 
-- 
2.24.0

