Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6B82AF4F7C
	for <lists+linux-acpi@lfdr.de>; Fri,  8 Nov 2019 16:26:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726804AbfKHP0w (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 8 Nov 2019 10:26:52 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:35948 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726743AbfKHP0v (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 8 Nov 2019 10:26:51 -0500
Received: by mail-wr1-f65.google.com with SMTP id r10so7527426wrx.3
        for <linux-acpi@vger.kernel.org>; Fri, 08 Nov 2019 07:26:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SJ0pi6TcxZ7peU2M0iysnkfrxFwiFSB7n/XBu4wivSo=;
        b=FJH028lD8udbYUj9HmW9HX+1pehY+1lWWRbuMjmApuHYEIKQLcSg0vICaIv4+60xTP
         SZObRA6SwQO9RwBVxZugqTUZI+vA8BvgqNj052zrmBwRHwWzaojQtHWRGbFCtztastzr
         pmnt/WYGWHFKd5AIcAMo8pJ6oAExUKnBYXeKVhe6kKjq+nXxzRdtnQJqvWgIRIrK+0ku
         4w7Dv2dYtYuKDn+v92hj11WbpQkpItAZUnzsJTk2q+ms3DMjKlct9veZzcMJgZOs9qQH
         iADkZLXOARDNATZhqDbKKo0FVoWdnh6jiRIOlQnG9iluhoxnk9D5UjR8R2mtDUOOVWdC
         O1HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SJ0pi6TcxZ7peU2M0iysnkfrxFwiFSB7n/XBu4wivSo=;
        b=DRRFgFPJbVZbQFq4Ds/C9xXen5gwgJwXw8SHSa5w7e1B+PMVaniebMC78mI0sEgUSs
         M5R1gLgiq5FQEK9CCzdur/3yLX/gC8I3dDIwnphQ/zhg9iYIfrlc2JP91btcMHD3rsRB
         RfMzUJ6UstT+qEPzETh2S0nNkeKIVpHx8IHH4v6QI//gaOpZFtORDw04SYs+pQEeDzOD
         ZiAYsruKYeklNm52IXgUjmh4l6KEjrNut5C52eaQFjDNSQjjzyChstJlEK2kBtJInJqM
         4YCgKZ63NOcwTOT+mZLTFlhPuypms8CB1251RM4+4G3ijir4hvVL/mXSu6nokxj1BMXl
         WLdQ==
X-Gm-Message-State: APjAAAWXMuC5OhAl5Xerdh1F0QT8QIoWhUMam3Mbliz39Le6G9az9Ufg
        kLG+lnzVQ+JjxiPrS8nEJHCg3A==
X-Google-Smtp-Source: APXvYqwyU++SQOEON9veNpljNNQZ0DLUXxBMuURhZ+hXhsR0MUMzQbS2imzKSghHCvbQFiMGMII/Dw==
X-Received: by 2002:adf:edc5:: with SMTP id v5mr8967125wro.322.1573226809763;
        Fri, 08 Nov 2019 07:26:49 -0800 (PST)
Received: from localhost.localdomain ([85.195.192.192])
        by smtp.gmail.com with ESMTPSA id w18sm6579232wrp.31.2019.11.08.07.26.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Nov 2019 07:26:49 -0800 (PST)
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     joro@8bytes.org, robh+dt@kernel.org, mark.rutland@arm.com,
        lorenzo.pieralisi@arm.com, guohanjun@huawei.com,
        sudeep.holla@arm.com, rjw@rjwysocki.net, lenb@kernel.org,
        will@kernel.org, robin.murphy@arm.com, zhangfei.gao@linaro.org,
        eric.auger@redhat.com, jonathan.cameron@huawei.com
Subject: [PATCH v2 2/8] iommu/arm-smmu-v3: Support platform SSID
Date:   Fri,  8 Nov 2019 16:25:02 +0100
Message-Id: <20191108152508.4039168-3-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191108152508.4039168-1-jean-philippe@linaro.org>
References: <20191108152508.4039168-1-jean-philippe@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

For platform devices that support SubstreamID (SSID), firmware provides
the number of supported SSID bits. Restrict it to what the SMMU supports
and cache it into master->ssid_bits, which will also be used for PCI
PASID.

Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
 drivers/iommu/arm-smmu-v3.c | 13 +++++++++++++
 drivers/iommu/of_iommu.c    |  6 +++++-
 include/linux/iommu.h       |  2 ++
 3 files changed, 20 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index 8da93e730d6f..33488da8f742 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -292,6 +292,12 @@
 
 #define CTXDESC_CD_1_TTB0_MASK		GENMASK_ULL(51, 4)
 
+/*
+ * When the SMMU only supports linear context descriptor tables, pick a
+ * reasonable size limit (64kB).
+ */
+#define CTXDESC_LINEAR_CDMAX		ilog2(SZ_64K / (CTXDESC_CD_DWORDS << 3))
+
 /* Convert between AArch64 (CPU) TCR format and SMMU CD format */
 #define ARM_SMMU_TCR2CD(tcr, fld)	FIELD_PREP(CTXDESC_CD_0_TCR_##fld, \
 					FIELD_GET(ARM64_TCR_##fld, tcr))
@@ -638,6 +644,7 @@ struct arm_smmu_master {
 	u32				*sids;
 	unsigned int			num_sids;
 	bool				ats_enabled;
+	unsigned int			ssid_bits;
 };
 
 /* SMMU private data for an IOMMU domain */
@@ -2572,6 +2579,12 @@ static int arm_smmu_add_device(struct device *dev)
 		}
 	}
 
+	master->ssid_bits = min(smmu->ssid_bits, fwspec->num_pasid_bits);
+
+	if (!(smmu->features & ARM_SMMU_FEAT_2_LVL_CDTAB))
+		master->ssid_bits = min_t(u8, master->ssid_bits,
+					  CTXDESC_LINEAR_CDMAX);
+
 	group = iommu_group_get_for_dev(dev);
 	if (!IS_ERR(group)) {
 		iommu_group_put(group);
diff --git a/drivers/iommu/of_iommu.c b/drivers/iommu/of_iommu.c
index 614a93aa5305..aab63e9f283f 100644
--- a/drivers/iommu/of_iommu.c
+++ b/drivers/iommu/of_iommu.c
@@ -194,8 +194,12 @@ const struct iommu_ops *of_iommu_configure(struct device *dev,
 			if (err)
 				break;
 		}
-	}
 
+		fwspec = dev_iommu_fwspec_get(dev);
+		if (!err && fwspec)
+			of_property_read_u32(master_np, "pasid-num-bits",
+					     &fwspec->num_pasid_bits);
+	}
 
 	/*
 	 * Two success conditions can be represented by non-negative err here:
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index f84fe76f0eea..0a3d9c3c368a 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -576,6 +576,7 @@ struct iommu_group *fsl_mc_device_group(struct device *dev);
  * @ops: ops for this device's IOMMU
  * @iommu_fwnode: firmware handle for this device's IOMMU
  * @iommu_priv: IOMMU driver private data for this device
+ * @num_pasid_bits: number of PASID bits supported by this device
  * @num_ids: number of associated device IDs
  * @ids: IDs which this device may present to the IOMMU
  */
@@ -584,6 +585,7 @@ struct iommu_fwspec {
 	struct fwnode_handle	*iommu_fwnode;
 	void			*iommu_priv;
 	u32			flags;
+	u32			num_pasid_bits;
 	unsigned int		num_ids;
 	u32			ids[1];
 };
-- 
2.23.0

