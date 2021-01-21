Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B1082FEA52
	for <lists+linux-acpi@lfdr.de>; Thu, 21 Jan 2021 13:41:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730913AbhAUMkh (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 21 Jan 2021 07:40:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731403AbhAUMkf (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 21 Jan 2021 07:40:35 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE69DC0613D6
        for <linux-acpi@vger.kernel.org>; Thu, 21 Jan 2021 04:39:34 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id 6so1596237wri.3
        for <linux-acpi@vger.kernel.org>; Thu, 21 Jan 2021 04:39:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Xa3mkhAFAfGDN5Nx5YV7r1/0JdiXBkjmJvNODotr9yQ=;
        b=xuoZdT6vqwdrneBsF/iCnyTISoVL6EQQ4dRUz5RXrweGgFfY2e3+LFYOkBLW6OxXaf
         3FsvhXsO+XEGNf6Qkg/vccPkZfxeFW0xXnmHhW3RGErdQ1RR0bYC1xP+IfR6SzwKhe5i
         j1guZ9z3q7kXMMumYGSf01olU15rNGwMjBS3QZucupVeBzpVCIvlVZ5AdSDxRVXsRuTH
         ALdcmHngExbY020NmAnmjP0CAhOnMta30/ZIrI66UY1toMlS12woqmKcE3Oe0Itdi5l9
         RTlDfhrpLWgV/PRR57/VAnB76a2mQEYlNXTbtdF2GvfzxAQzx1WZQ05l1ufOyMPs9U3p
         xE0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Xa3mkhAFAfGDN5Nx5YV7r1/0JdiXBkjmJvNODotr9yQ=;
        b=CeIakQwgmmxMXuDpTFmH0Vhk87AYAtGHM6x5QsCGAHpsTTFCxO9SJvbG8/NQ8xg9Lg
         84kf6tJVBGeUVNHwa6euIYm64pBRy7aT+WYoDoUtS8BT1D/QWMZ4ybrM4d/kJvAlvLck
         kHb7yHwhlzn1fA6RAy+QAHGzG7rRVBZxlhrmPJ+SV7DSaXreP5Ug7hmAtxzExtjFp8wd
         hHn4OMpyAR8nnYr0HViAzyh5bTaIuOI5sTyVW7KS4j3ILufoh8pgxwc6CeZyVF+KPE/U
         lcVofRMHocpI7mjQEjAnDQEyIzqoa6vqcH4kAx0hMtrEK/I3pziMWYECa55ILWX8oI++
         E6mA==
X-Gm-Message-State: AOAM532fU6WLN1mJfr94DmUkY5UWwLWcXdmQj0CDZCXWG2el3scL50fo
        Fs64V7z9XGew9sBmrcvZMugHNA==
X-Google-Smtp-Source: ABdhPJxIVzp3e5I6veT1ajGc0bpHZbJyW457OdA6YWVtClLbwRId43hhoVOvyBUfJnr66KJvzFVCAA==
X-Received: by 2002:a5d:61ca:: with SMTP id q10mr14245966wrv.124.1611232773572;
        Thu, 21 Jan 2021 04:39:33 -0800 (PST)
Received: from localhost.localdomain ([2001:1715:4e26:a7e0:116c:c27a:3e7f:5eaf])
        by smtp.gmail.com with ESMTPSA id p18sm7979248wmc.31.2021.01.21.04.39.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Jan 2021 04:39:33 -0800 (PST)
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
Subject: [PATCH v10 02/10] iommu/arm-smmu-v3: Use device properties for pasid-num-bits
Date:   Thu, 21 Jan 2021 13:36:16 +0100
Message-Id: <20210121123623.2060416-3-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210121123623.2060416-1-jean-philippe@linaro.org>
References: <20210121123623.2060416-1-jean-philippe@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

The pasid-num-bits property shouldn't need a dedicated fwspec field,
it's a job for device properties. Add properties for IORT, and access
the number of PASID bits using device_property_read_u32().

Suggested-by: Robin Murphy <robin.murphy@arm.com>
Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
 include/linux/iommu.h                       |  2 --
 drivers/acpi/arm64/iort.c                   | 13 +++++++------
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c |  3 ++-
 drivers/iommu/of_iommu.c                    |  5 -----
 4 files changed, 9 insertions(+), 14 deletions(-)

diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index bdf3f34a4457..b7ea11fc1a93 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -571,7 +571,6 @@ struct iommu_group *fsl_mc_device_group(struct device *dev);
  * @ops: ops for this device's IOMMU
  * @iommu_fwnode: firmware handle for this device's IOMMU
  * @flags: IOMMU_FWSPEC_* flags
- * @num_pasid_bits: number of PASID bits supported by this device
  * @num_ids: number of associated device IDs
  * @ids: IDs which this device may present to the IOMMU
  */
@@ -579,7 +578,6 @@ struct iommu_fwspec {
 	const struct iommu_ops	*ops;
 	struct fwnode_handle	*iommu_fwnode;
 	u32			flags;
-	u32			num_pasid_bits;
 	unsigned int		num_ids;
 	u32			ids[];
 };
diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
index d4eac6d7e9fb..c9a8bbb74b09 100644
--- a/drivers/acpi/arm64/iort.c
+++ b/drivers/acpi/arm64/iort.c
@@ -968,15 +968,16 @@ static int iort_pci_iommu_init(struct pci_dev *pdev, u16 alias, void *data)
 static void iort_named_component_init(struct device *dev,
 				      struct acpi_iort_node *node)
 {
+	struct property_entry props[2] = {};
 	struct acpi_iort_named_component *nc;
-	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
-
-	if (!fwspec)
-		return;
 
 	nc = (struct acpi_iort_named_component *)node->node_data;
-	fwspec->num_pasid_bits = FIELD_GET(ACPI_IORT_NC_PASID_BITS,
-					   nc->node_flags);
+	props[0] = PROPERTY_ENTRY_U32("pasid-num-bits",
+				      FIELD_GET(ACPI_IORT_NC_PASID_BITS,
+						nc->node_flags));
+
+	if (device_add_properties(dev, props))
+		dev_warn(dev, "Could not add device properties\n");
 }
 
 static int iort_nc_iommu_map(struct device *dev, struct acpi_iort_node *node)
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 8ca7415d785d..6a53b4edf054 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -2366,7 +2366,8 @@ static struct iommu_device *arm_smmu_probe_device(struct device *dev)
 		}
 	}
 
-	master->ssid_bits = min(smmu->ssid_bits, fwspec->num_pasid_bits);
+	device_property_read_u32(dev, "pasid-num-bits", &master->ssid_bits);
+	master->ssid_bits = min(smmu->ssid_bits, master->ssid_bits);
 
 	/*
 	 * Note that PASID must be enabled before, and disabled after ATS:
diff --git a/drivers/iommu/of_iommu.c b/drivers/iommu/of_iommu.c
index e505b9130a1c..a9d2df001149 100644
--- a/drivers/iommu/of_iommu.c
+++ b/drivers/iommu/of_iommu.c
@@ -210,11 +210,6 @@ const struct iommu_ops *of_iommu_configure(struct device *dev,
 					     of_pci_iommu_init, &info);
 	} else {
 		err = of_iommu_configure_device(master_np, dev, id);
-
-		fwspec = dev_iommu_fwspec_get(dev);
-		if (!err && fwspec)
-			of_property_read_u32(master_np, "pasid-num-bits",
-					     &fwspec->num_pasid_bits);
 	}
 
 	/*
-- 
2.30.0

