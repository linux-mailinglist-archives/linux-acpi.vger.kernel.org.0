Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F03D2B05DE
	for <lists+linux-acpi@lfdr.de>; Thu, 12 Nov 2020 14:03:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728338AbgKLNDe (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 12 Nov 2020 08:03:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728278AbgKLNDX (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 12 Nov 2020 08:03:23 -0500
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7982CC061A4A
        for <linux-acpi@vger.kernel.org>; Thu, 12 Nov 2020 05:03:21 -0800 (PST)
Received: by mail-wr1-x442.google.com with SMTP id p8so5921965wrx.5
        for <linux-acpi@vger.kernel.org>; Thu, 12 Nov 2020 05:03:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3ygm1AXTLu+53w4Gri7BYEJbuhvyMFezCUVbiVOA1cI=;
        b=uA63WGlRDXWDF9rIZV4RZkVq6oJU37wcFuSQmD8BzO159BANMh6M+qpRZeX3/9SDUX
         NgjC/6kMJoth33QcDclO+ynaJlZA5DobFNRQNYs96uO5BecxpNBWMkORbZcRWO5P6qD/
         BJkF/jlsL/X45r34/KxlPQbUjbKshwp4elCUfaZGnESVEwpxokGBOQy9Uvj/8ap3OCIH
         X4XkbC3JjCUSG2bj/0UjM+bplVf6wDID7rR7qluxsv54s4WElIx8dWnQLCnODfH4+4TN
         1fQtFlyLdLdG2hhM+mcaKhRK/XdUJ1cFPfj1ecKiWJDeJr3prD0gWxlUnB4H0tf5eUhK
         2bmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3ygm1AXTLu+53w4Gri7BYEJbuhvyMFezCUVbiVOA1cI=;
        b=S+/jrUHYoD2HCG1/GmB2qQyQbmqSXUPFmTs1Zt9wZaZ4ymZaLFTYtb87UCiCFdh+ri
         ePD7D4lzGTfCyetbQOR50FGWbC6/T9a8GmItYitpMWoNhT8QXJqf3nDguMw6YaGmCxXH
         /z8HIFl3PiGESykT7xItYjIpy7l4E+HbdkWjOmhz0WkWwF3vIT6VEHSzzIBjtGX+Irb8
         TfRSMfqf9XBQhGfZBZid9YW7lVyxn2CnOpz07PbQ0ODZXcw+f1ze5BXqyYUl06aKn6Q0
         We9wIR7PpL8mNd4sw189BUIVjSQUE7mRI/mtDsGGRFXyKd/ZEIATJpoSp46M8KAUbHaB
         Ye6A==
X-Gm-Message-State: AOAM530nvGF7y6SZYc/z4ioFTdP6YR0KPw4MKP+Hjy3cUCMSzBKXHmbv
        1poaZ7wPgZZgGjq7dh4bhRVmZg==
X-Google-Smtp-Source: ABdhPJz9bTvkN2/dsnznhn0qkGq1x4rrRxxckt9ZNtviWKF6XljTnBbloojb2RmpNHrLbr6LrtRoPQ==
X-Received: by 2002:a5d:660f:: with SMTP id n15mr30481293wru.345.1605186200191;
        Thu, 12 Nov 2020 05:03:20 -0800 (PST)
Received: from localhost.localdomain ([2001:1715:4e26:a7e0:116c:c27a:3e7f:5eaf])
        by smtp.gmail.com with ESMTPSA id m22sm6877508wrb.97.2020.11.12.05.03.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2020 05:03:19 -0800 (PST)
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     joro@8bytes.org, will@kernel.org, lorenzo.pieralisi@arm.com,
        robh+dt@kernel.org
Cc:     guohanjun@huawei.com, sudeep.holla@arm.com, rjw@rjwysocki.net,
        lenb@kernel.org, robin.murphy@arm.com, bhelgaas@google.com,
        Jonathan.Cameron@huawei.com, eric.auger@redhat.com,
        iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pci@vger.kernel.org, baolu.lu@linux.intel.com,
        zhangfei.gao@linaro.org, shameerali.kolothum.thodi@huawei.com,
        vivek.gautam@arm.com,
        Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: [PATCH v8 4/9] of/iommu: Support dma-can-stall property
Date:   Thu, 12 Nov 2020 13:55:16 +0100
Message-Id: <20201112125519.3987595-5-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.29.1
In-Reply-To: <20201112125519.3987595-1-jean-philippe@linaro.org>
References: <20201112125519.3987595-1-jean-philippe@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Copy the dma-can-stall property into the fwspec structure.

Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
 include/linux/iommu.h    | 2 ++
 drivers/iommu/of_iommu.c | 5 ++++-
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index a1c78c4cdeb1..9076fb592c8f 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -572,6 +572,7 @@ struct iommu_group *fsl_mc_device_group(struct device *dev);
  * @iommu_fwnode: firmware handle for this device's IOMMU
  * @iommu_priv: IOMMU driver private data for this device
  * @num_pasid_bits: number of PASID bits supported by this device
+ * @can_stall: the device is allowed to stall
  * @num_ids: number of associated device IDs
  * @ids: IDs which this device may present to the IOMMU
  */
@@ -579,6 +580,7 @@ struct iommu_fwspec {
 	const struct iommu_ops	*ops;
 	struct fwnode_handle	*iommu_fwnode;
 	u32			num_pasid_bits;
+	bool			can_stall;
 	unsigned int		num_ids;
 	u32			ids[];
 };
diff --git a/drivers/iommu/of_iommu.c b/drivers/iommu/of_iommu.c
index e505b9130a1c..d6255ca823d8 100644
--- a/drivers/iommu/of_iommu.c
+++ b/drivers/iommu/of_iommu.c
@@ -212,9 +212,12 @@ const struct iommu_ops *of_iommu_configure(struct device *dev,
 		err = of_iommu_configure_device(master_np, dev, id);
 
 		fwspec = dev_iommu_fwspec_get(dev);
-		if (!err && fwspec)
+		if (!err && fwspec) {
 			of_property_read_u32(master_np, "pasid-num-bits",
 					     &fwspec->num_pasid_bits);
+			fwspec->can_stall = of_property_read_bool(master_np,
+								  "dma-can-stall");
+		}
 	}
 
 	/*
-- 
2.29.1

