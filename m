Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67B7C351DC1
	for <lists+linux-acpi@lfdr.de>; Thu,  1 Apr 2021 20:49:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235208AbhDASbw (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 1 Apr 2021 14:31:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235049AbhDASSk (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 1 Apr 2021 14:18:40 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3AC9C02D554
        for <linux-acpi@vger.kernel.org>; Thu,  1 Apr 2021 08:48:16 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id z2so2295505wrl.5
        for <linux-acpi@vger.kernel.org>; Thu, 01 Apr 2021 08:48:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eQXI58zAvM15zhWnJhtaneb3Z5TB5viNxz6ThN07yYo=;
        b=qa6RtSxJehdNDHEbtRQDoG4EjnNvOV+ZM3UIaISDIGaRWAvE0zgsBdS4zmi/EHd+7d
         vI1+IG+eKz3jFoYzdABhdk1UQJ3v0kYL7my4xBC6Ew0NzGfcDAq1gHJOp/gNfS0A0cOc
         0nfxHbHzpZ3E3Z1puZpD8a81zWNDrJknkp5TcRFikilIV4KAWo2PzdaD829hl1i0b27S
         dpeLZA6sLK22L/cdQg646NJpv/pOjmCMMGY9IAabcxPBIKMd+o3CvmqOUybrGArngNiN
         6nRmFjJ9Bp1J0f0iZOiYm/qyXM3gAC7ME2d5CWoLxl4G3hSU9rU8piaWw2rFDj90/PNJ
         VQrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eQXI58zAvM15zhWnJhtaneb3Z5TB5viNxz6ThN07yYo=;
        b=n8rl0+J5VqZud9Zt2/EpOZm4sBsmUZ++rwYHraiOaUf5x3I9YeqOWS2952kQQRAUBC
         NzUq+CGfoOq3iDuzWqLE5sMdQhasnsNPV+nkFdq+SoIlPA7NjVRlUCkRX+rwZCTKWin0
         EVCKr8oisD/VHstogS+c6ndrjLWtK9yeEeV3TTfVd5WYw8on+QlJ9R1eA16Q5DBQZMki
         djnTVLvUNJSuuiNqxA9Tlvn/igD5NF7ok9dv+KC8Qj3N5JgN/Sp84W+G/MJrqQPxB3nP
         QD2fP7uEg7pAFVisvpF+EgXSO91UM8WUnTMYUkJmkjkgWUo66WHkaOkveaSuBFBpYov5
         7Azg==
X-Gm-Message-State: AOAM532I7KYvwStFgEhxmr2H/a2lMqlcwgUhXyDkDzizoout2EsBXtUB
        SdJfVA2PVgAAqax/KrS1dMC5/w==
X-Google-Smtp-Source: ABdhPJwaZfUexbQcEF/4acyTvCXSYeM92XQ1EEDNpmG5V7T4wXNFsmzkO4N4IY6aRHJTe4JNVNkWtA==
X-Received: by 2002:adf:8151:: with SMTP id 75mr10543223wrm.152.1617292095498;
        Thu, 01 Apr 2021 08:48:15 -0700 (PDT)
Received: from localhost.localdomain ([2001:1715:4e26:a7e0:116c:c27a:3e7f:5eaf])
        by smtp.gmail.com with ESMTPSA id y8sm8722505wmi.46.2021.04.01.08.48.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Apr 2021 08:48:14 -0700 (PDT)
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
        zhukeqian1@huawei.com, wangzhou1@hisilicon.com,
        Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: [PATCH v14 02/10] iommu/arm-smmu-v3: Use device properties for pasid-num-bits
Date:   Thu,  1 Apr 2021 17:47:11 +0200
Message-Id: <20210401154718.307519-3-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210401154718.307519-1-jean-philippe@linaro.org>
References: <20210401154718.307519-1-jean-philippe@linaro.org>
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
Acked-by: Will Deacon <will@kernel.org>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
 include/linux/iommu.h                       |  2 --
 drivers/acpi/arm64/iort.c                   | 13 +++++++------
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c |  3 ++-
 drivers/iommu/of_iommu.c                    |  5 -----
 4 files changed, 9 insertions(+), 14 deletions(-)

diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 1d422bf722a1..16ce75693d83 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -572,7 +572,6 @@ struct iommu_group *fsl_mc_device_group(struct device *dev);
  * @ops: ops for this device's IOMMU
  * @iommu_fwnode: firmware handle for this device's IOMMU
  * @flags: IOMMU_FWSPEC_* flags
- * @num_pasid_bits: number of PASID bits supported by this device
  * @num_ids: number of associated device IDs
  * @ids: IDs which this device may present to the IOMMU
  */
@@ -580,7 +579,6 @@ struct iommu_fwspec {
 	const struct iommu_ops	*ops;
 	struct fwnode_handle	*iommu_fwnode;
 	u32			flags;
-	u32			num_pasid_bits;
 	unsigned int		num_ids;
 	u32			ids[];
 };
diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
index 2494138a6905..3912a1f6058e 100644
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
index 941ba5484731..bd77495023c8 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -2395,7 +2395,8 @@ static struct iommu_device *arm_smmu_probe_device(struct device *dev)
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
2.31.1

