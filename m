Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 167B811738D
	for <lists+linux-acpi@lfdr.de>; Mon,  9 Dec 2019 19:12:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726647AbfLISMB (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 9 Dec 2019 13:12:01 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:50720 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726677AbfLISMB (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 9 Dec 2019 13:12:01 -0500
Received: by mail-wm1-f67.google.com with SMTP id p9so342832wmg.0
        for <linux-acpi@vger.kernel.org>; Mon, 09 Dec 2019 10:12:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=B8BypQ1D+CaqFBtDE2c69vGRS8hRXLPOwwy0I1wmRy8=;
        b=JMfFh5ck7ruppTPVZqznNBMI/hxmWCjBpPowpLszgpJgLI9svpqtubPWnw++UtquCe
         9/EsqaBZQOZiD9DeL4JMlv+RlivsGqAkmZEbjLdWnnircfNMMlJ+KtlYSYx/gvCJ8YNI
         8DhuuCIuawo38qojPOQ0Q7TnHAfbBJQJQiSSNgSOEUR7IiulB5I0UhAtV/G1D1eUVOpn
         7oy3FXhiC+cIOJIgiTqxwFhjpW5BOeV9b84Rc0pZnpwcG6kdaKbEAJ8w/ZWYfQ4X4F1E
         +MH4HodDir1ZRCvOKwV6mJVBSYrCv2uLhUaQ7DaUcVhzKdSMZItcR33jnufY5u22jwGq
         /Uzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=B8BypQ1D+CaqFBtDE2c69vGRS8hRXLPOwwy0I1wmRy8=;
        b=mpZGw+KtisrMVt3vshBgZji9xoj08s0DeEF/GFzMnQS1kIAveqxvQcZhjPkJesy01O
         WRXa4BCfAxNrv0c2Im41TjpDB6sqriLmRL23StZKsQH7tKDPX6i0hyZr4JDHxR5GFle5
         eXXnDu9PFh8qA7EoIHtMlns+WKyjVVmHZD4uRZfA+naCAH1kOXS3t2ozRA6Px51Gpx75
         AQANPtY585kkU5uqxtSkmUIv/pvqFOoU2Igdtc+Oo3FBdF/OKg3LzdZ8Qhg7RQUfLirg
         OzMcbjVOpSpe55K3FPLWzFreefR/vLmJsIJ9ivr9Ed7efqthjNzTzRwa2+7nN83WJD+W
         7udA==
X-Gm-Message-State: APjAAAWVRUAPcxDCBJYb5cDBjQ1ginBcajsqrGJjnYE5Abjj8Dx3CJNJ
        8FRHbucAhYgXu7HjEPwgNwnahQ==
X-Google-Smtp-Source: APXvYqy1n0Wv9Ft0LN1Rvvok34SZLAdZtkxTAoI3MM3VwUT99d0zPnBGlzSTfWyEenShrdSM85zXbw==
X-Received: by 2002:a05:600c:2113:: with SMTP id u19mr298745wml.157.1575915119329;
        Mon, 09 Dec 2019 10:11:59 -0800 (PST)
Received: from localhost.localdomain (adsl-62-167-101-88.adslplus.ch. [62.167.101.88])
        by smtp.gmail.com with ESMTPSA id h2sm309838wrv.66.2019.12.09.10.11.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2019 10:11:58 -0800 (PST)
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-acpi@vger.kernel.org, devicetree@vger.kernel.org,
        iommu@lists.linux-foundation.org
Cc:     joro@8bytes.org, robh+dt@kernel.org, mark.rutland@arm.com,
        lorenzo.pieralisi@arm.com, guohanjun@huawei.com,
        sudeep.holla@arm.com, rjw@rjwysocki.net, lenb@kernel.org,
        will@kernel.org, robin.murphy@arm.com, bhelgaas@google.com,
        eric.auger@redhat.com, jonathan.cameron@huawei.com,
        zhangfei.gao@linaro.org
Subject: [PATCH v3 03/13] iommu/arm-smmu-v3: Support platform SSID
Date:   Mon,  9 Dec 2019 19:05:04 +0100
Message-Id: <20191209180514.272727-4-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191209180514.272727-1-jean-philippe@linaro.org>
References: <20191209180514.272727-1-jean-philippe@linaro.org>
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
index d4e8b7f8d9f4..837b4283b4dc 100644
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
@@ -2571,6 +2578,12 @@ static int arm_smmu_add_device(struct device *dev)
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
index 026ad2b29dcd..b3ccb2f7f1c7 100644
--- a/drivers/iommu/of_iommu.c
+++ b/drivers/iommu/of_iommu.c
@@ -196,8 +196,12 @@ const struct iommu_ops *of_iommu_configure(struct device *dev,
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
index 3a113c5d7394..bd46775c3329 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -581,6 +581,7 @@ struct iommu_group *fsl_mc_device_group(struct device *dev);
  * @ops: ops for this device's IOMMU
  * @iommu_fwnode: firmware handle for this device's IOMMU
  * @iommu_priv: IOMMU driver private data for this device
+ * @num_pasid_bits: number of PASID bits supported by this device
  * @num_ids: number of associated device IDs
  * @ids: IDs which this device may present to the IOMMU
  */
@@ -589,6 +590,7 @@ struct iommu_fwspec {
 	struct fwnode_handle	*iommu_fwnode;
 	void			*iommu_priv;
 	u32			flags;
+	u32			num_pasid_bits;
 	unsigned int		num_ids;
 	u32			ids[1];
 };
-- 
2.24.0

