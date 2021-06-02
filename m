Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C6DD398F69
	for <lists+linux-acpi@lfdr.de>; Wed,  2 Jun 2021 17:56:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232411AbhFBP55 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 2 Jun 2021 11:57:57 -0400
Received: from mail-ej1-f52.google.com ([209.85.218.52]:43666 "EHLO
        mail-ej1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232507AbhFBP54 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 2 Jun 2021 11:57:56 -0400
Received: by mail-ej1-f52.google.com with SMTP id ci15so4552625ejc.10
        for <linux-acpi@vger.kernel.org>; Wed, 02 Jun 2021 08:56:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=o4eUQK2AFEVDf4pa1XuHff+3rIiA7+oIVY3xnoGa6wY=;
        b=bExAtgh8euYkUKN+qFMYT8WIbypPHTQY181GV1KXdKuEkhgYCTsTU8ZhMmQFbqINUs
         YBYH72ddFNokmmjPFRin7FXc5BcfxLA5iLn1r848O/879blXjvkXW+dODgO2LK2A5ieS
         CkCubDq8GRmUUksQdbBfRlrF9+MaD7Bi2HirCMNYVQVvcA/degevWtntRaCRdxUT7s/L
         uVh1he4RZ0lOH5FftG3r2TcRSkq/x8ur0ttG9qKLw9HP8vAPoZ1gbOzEAf+UG97MVKeC
         5qBXNJq4y/FzgbnxOsYBn0rFrs19nBwxV1wc7jijMS+OmNfyePVZwr9pR2lpAKcay6Im
         Xb9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=o4eUQK2AFEVDf4pa1XuHff+3rIiA7+oIVY3xnoGa6wY=;
        b=aCTAAcNnFSNx+GdM9t66WMt8PojedrU7vkB6ef6UsTqdMFGAlvHjnlVlO+y/vWmltf
         NFFAbu00YFfJKgMBsVQHkYtBT+va69Re2aUWdRxizwDDtmEbWQx6P6ZgLMWR6TpG50tT
         BdFeeeU8uOayctqv8vjw/svdSYOOd9j/8zoDOOZylHYClQjjYpNqiqLIisFblsCZnlOd
         fuXvElvpPVdCBrN6+EnVN8HiDZBCDK+r2OiXI0eJGFc++zZAF1sLPDqzJvXQEL8YGkJ5
         LvXYvmIjoZ9vpMscLvI5HU7HQ9O03ub8alrsxKTtwC3+cg+Pghj6LilW3Q+TwHEPFqAh
         rj1g==
X-Gm-Message-State: AOAM532gAUDxseNxlAuPXRe381369SWF+C4Ym1OOsZKkdOLFTTCHlesV
        qWzqfD2Dybljo/OPx3Sr7qiczw==
X-Google-Smtp-Source: ABdhPJx8H/Wug8busq8mblZuxKyvThUPC+Gm9BLdmmMckkP7okW8+Gtuckc+NdAKI0hRzGk0uxsvNA==
X-Received: by 2002:a17:906:63d2:: with SMTP id u18mr34676925ejk.186.1622649312754;
        Wed, 02 Jun 2021 08:55:12 -0700 (PDT)
Received: from localhost.localdomain (adsl-84-226-111-173.adslplus.ch. [84.226.111.173])
        by smtp.gmail.com with ESMTPSA id d24sm174249edr.95.2021.06.02.08.55.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jun 2021 08:55:12 -0700 (PDT)
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
Subject: [PATCH v3 6/6] iommu/virtio: Enable x86 support
Date:   Wed,  2 Jun 2021 17:44:46 +0200
Message-Id: <20210602154444.1077006-7-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210602154444.1077006-1-jean-philippe@linaro.org>
References: <20210602154444.1077006-1-jean-philippe@linaro.org>
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

