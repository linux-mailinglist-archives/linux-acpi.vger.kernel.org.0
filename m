Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CA9A3A2611
	for <lists+linux-acpi@lfdr.de>; Thu, 10 Jun 2021 10:02:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229778AbhFJIEv (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 10 Jun 2021 04:04:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229770AbhFJIEv (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 10 Jun 2021 04:04:51 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6278DC061760
        for <linux-acpi@vger.kernel.org>; Thu, 10 Jun 2021 01:02:55 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id s70-20020a1ca9490000b02901a589651424so4302562wme.0
        for <linux-acpi@vger.kernel.org>; Thu, 10 Jun 2021 01:02:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=o4eUQK2AFEVDf4pa1XuHff+3rIiA7+oIVY3xnoGa6wY=;
        b=XTDav+B8gT/1ifsCDS1Li2uacTSbnexp8r5J77P2gZpxWe7w8Ei6kIXPG7R8nvM+1S
         FuJ/ArwesV+mdX7IpHAratIh5TtjH1HcJPDnOzi14+7a1Krcc9R6t2hcpTOTM6M6ePRN
         xdrMr4Gqee3y9QyRiImYc7hTw03FrGXOz+8WpuUX/801y4iyuOk9wNyb6066qpPe3NVx
         MH/A8Kv/qBFaAm7chmPfrTohNNkMF4attVGnn72WPRHXJVHe2WlzBIi9keOFH/VvSyh2
         4Z/PTWZVP/LEHned/8zaNrORkp4OLYt1wXV7wV0fWBM3mHIPZPNd1pW3ipYsrQ3Wt6fa
         yrOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=o4eUQK2AFEVDf4pa1XuHff+3rIiA7+oIVY3xnoGa6wY=;
        b=cIs8f5Kb0z3ciOzCXla5rbLhq12Y/SblwiQofoH//HYHEVocWk7Etu81e7NZ5z7wmt
         mXS03xsDXiORmZi9YPjA7FiuIs+4MFSebMjj+7eJO2oRrj6+wXj83Y+jFbzbh4aU0x+j
         GFc0O/WKsQup7dtuc0pW31ECBnGdTbNH1PH/NUZSkpYXibxy+AM4jMpRkVGFcUMX0T2k
         phrTt3wZrbOcSHRLoiyxGxvX67pcqpAIi7KW2FsAvYEhq9cfz3tRqMP3q7T6Rddzvamy
         kzWc2RRb+ZIKs/8ZjnRrsAxpbypWi5uEhS2sbowY06AEpMA5It8adjQ0VSnLrB/W1eRw
         G/yA==
X-Gm-Message-State: AOAM531KKEqo3hpVciRfchlju2Byhl4wJkZJsMkb1LZlx/sHoNnIbpum
        4pSbwWQx672kT/K4+qNdAQdPQg==
X-Google-Smtp-Source: ABdhPJx2koDYeA+siqnGagD7qMuftNsXW3jO8Xh3lYQXDR5aJEtWgMgDDbbclFK3Zh/WfkpajxAnjA==
X-Received: by 2002:a05:600c:3647:: with SMTP id y7mr13935102wmq.149.1623312173963;
        Thu, 10 Jun 2021 01:02:53 -0700 (PDT)
Received: from localhost.localdomain (adsl-84-226-111-173.adslplus.ch. [84.226.111.173])
        by smtp.gmail.com with ESMTPSA id o3sm2715059wrm.78.2021.06.10.01.02.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jun 2021 01:02:53 -0700 (PDT)
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     rjw@rjwysocki.net, lenb@kernel.org, joro@8bytes.org, mst@redhat.com
Cc:     will@kernel.org, catalin.marinas@arm.com, baolu.lu@linux.intel.com,
        dwmw2@infradead.org, linux-acpi@vger.kernel.org,
        iommu@lists.linux-foundation.org,
        virtualization@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org, eric.auger@redhat.com,
        sebastien.boeuf@intel.com, robin.murphy@arm.com,
        kevin.tian@intel.com, lorenzo.pieralisi@arm.com,
        guohanjun@huawei.com, sudeep.holla@arm.com,
        jean-philippe@linaro.org
Subject: [PATCH v4 6/6] iommu/virtio: Enable x86 support
Date:   Thu, 10 Jun 2021 09:51:33 +0200
Message-Id: <20210610075130.67517-7-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210610075130.67517-1-jean-philippe@linaro.org>
References: <20210610075130.67517-1-jean-philippe@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

With the VIOT support in place, x86 platforms can now use the
virtio-iommu.

Because the other x86 IOMMU drivers aren't yet ready to use the
acpi_dma_setup() path, x86 doesn't implement arch_setup_dma_ops() at the
moment. Similarly to Vt-d and AMD IOMMU, call iommu_setup_dma_ops() from
probe_finalize().

Acked-by: Joerg Roedel <jroedel@suse.de>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
 drivers/iommu/Kconfig        | 3 ++-
 drivers/iommu/dma-iommu.c    | 1 +
 drivers/iommu/virtio-iommu.c | 8 ++++++++
 3 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
index aff8a4830dd1..07b7c25cbed8 100644
--- a/drivers/iommu/Kconfig
+++ b/drivers/iommu/Kconfig
@@ -400,8 +400,9 @@ config HYPERV_IOMMU
 config VIRTIO_IOMMU
 	tristate "Virtio IOMMU driver"
 	depends on VIRTIO
-	depends on ARM64
+	depends on (ARM64 || X86)
 	select IOMMU_API
+	select IOMMU_DMA
 	select INTERVAL_TREE
 	select ACPI_VIOT if ACPI
 	help
diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index 175f8eaeb5b3..46ed43c400cf 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -1332,6 +1332,7 @@ void iommu_setup_dma_ops(struct device *dev, u64 dma_base, u64 dma_limit)
 	 pr_warn("Failed to set up IOMMU for device %s; retaining platform DMA ops\n",
 		 dev_name(dev));
 }
+EXPORT_SYMBOL_GPL(iommu_setup_dma_ops);
 
 static struct iommu_dma_msi_page *iommu_dma_get_msi_page(struct device *dev,
 		phys_addr_t msi_addr, struct iommu_domain *domain)
diff --git a/drivers/iommu/virtio-iommu.c b/drivers/iommu/virtio-iommu.c
index 218fe8560e8d..77aee1207ced 100644
--- a/drivers/iommu/virtio-iommu.c
+++ b/drivers/iommu/virtio-iommu.c
@@ -1026,6 +1026,13 @@ static struct iommu_device *viommu_probe_device(struct device *dev)
 	return ERR_PTR(ret);
 }
 
+static void viommu_probe_finalize(struct device *dev)
+{
+#ifndef CONFIG_ARCH_HAS_SETUP_DMA_OPS
+	iommu_setup_dma_ops(dev, 0, U64_MAX);
+#endif
+}
+
 static void viommu_release_device(struct device *dev)
 {
 	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
@@ -1062,6 +1069,7 @@ static struct iommu_ops viommu_ops = {
 	.iova_to_phys		= viommu_iova_to_phys,
 	.iotlb_sync		= viommu_iotlb_sync,
 	.probe_device		= viommu_probe_device,
+	.probe_finalize		= viommu_probe_finalize,
 	.release_device		= viommu_release_device,
 	.device_group		= viommu_device_group,
 	.get_resv_regions	= viommu_get_resv_regions,
-- 
2.31.1

