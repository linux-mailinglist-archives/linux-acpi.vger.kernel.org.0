Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D9C7369197
	for <lists+linux-acpi@lfdr.de>; Fri, 23 Apr 2021 13:57:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229957AbhDWL5m (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 23 Apr 2021 07:57:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231472AbhDWL5h (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 23 Apr 2021 07:57:37 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E07BAC06175F
        for <linux-acpi@vger.kernel.org>; Fri, 23 Apr 2021 04:57:00 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id p6so41451380wrn.9
        for <linux-acpi@vger.kernel.org>; Fri, 23 Apr 2021 04:57:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UQIMwLFTls4/WJjymQFgC41Tqut/moVpCvSGVMf3p14=;
        b=Se4ZGfMvg0biJnx9os+LbCidHgcUoRYMUQXaJ9i8nJ8CAL99l38h8GPg0NHq49WW6Y
         mw1HDf5F6KlG0LIlhxpFz1Dbr6v7NyQtWGEUGnus7O1uj9JPoj+FvchqF9voIr3Lw7+2
         M5dc/EKCPMli8MltA6zuQTi89PJ9sKFptK+3b5ZJjI7nOKf8bLoctqz1zx/o4CnCIsrz
         JVrPibAH9yZspQx1yQAZZh7zv5PsJ/AMqDE0G3P0W0WF+vxlnmr3nPjMz3ikPlpBZRAf
         93+Y7IU3tAdRYBSUiBhAwU3/KwrrQ/nBjUi+aREYk3hY3aK8OVBk4gpyUtNN/QrgrUzU
         79hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UQIMwLFTls4/WJjymQFgC41Tqut/moVpCvSGVMf3p14=;
        b=QJ96PM9Syqm4YDiye5FXoIv2HXyJZ0KMaJfb0GEYcdIvMrcwTQrO2YBGsmnKCJNPIl
         T4PZxExNZXhvwdhx8DWJuG3pBl0BhHBTGILh2y1tlUrYQQLL+nmv7KMbtvaylyCgLmCZ
         J2T0Hl84R+JwQBDmj+R4ITl/g2FR9mVfmcE7VCt2qAD4lGy+8RM6JBG8Nv+pcOrX9xnE
         +i4xng1YrOtXFCwA8R6BenAQjCS8R24n6y57+iKZ5IWhKS5FlHcIwXzDyGJI/ltvCi3W
         7grOS8gJFG4tg8ZX9OP6ZhHvYWUWG/s6Psx8UxfHqb+iZzbaroRCGWuI15RcIJVY8JeE
         WVsA==
X-Gm-Message-State: AOAM5317jCZajOEGBWa68+JamtoE5b7mQtxxK/FsA0aX7tRgGI9YdYNh
        chuvS5eQvOQzoWn9ASXpa0GaTg==
X-Google-Smtp-Source: ABdhPJysuuOvIFTUKOIqqVw+v/bc4x5l41zhX5bZVOgfrTtfrN8ysU7xvrJmyKi3hnVPMITPgWptTQ==
X-Received: by 2002:adf:a1db:: with SMTP id v27mr4292159wrv.181.1619179019689;
        Fri, 23 Apr 2021 04:56:59 -0700 (PDT)
Received: from localhost.localdomain ([2001:1715:4e26:a7e0:116c:c27a:3e7f:5eaf])
        by smtp.gmail.com with ESMTPSA id g9sm7485195wmh.21.2021.04.23.04.56.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Apr 2021 04:56:59 -0700 (PDT)
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
Subject: [PATCH v2 6/6] iommu/virtio: Enable x86 support
Date:   Fri, 23 Apr 2021 13:38:37 +0200
Message-Id: <20210423113836.3974972-7-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210423113836.3974972-1-jean-philippe@linaro.org>
References: <20210423113836.3974972-1-jean-philippe@linaro.org>
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
index 29a397c2d12f..8be546a338e7 100644
--- a/drivers/iommu/virtio-iommu.c
+++ b/drivers/iommu/virtio-iommu.c
@@ -1027,6 +1027,13 @@ static struct iommu_device *viommu_probe_device(struct device *dev)
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
@@ -1063,6 +1070,7 @@ static struct iommu_ops viommu_ops = {
 	.iova_to_phys		= viommu_iova_to_phys,
 	.iotlb_sync		= viommu_iotlb_sync,
 	.probe_device		= viommu_probe_device,
+	.probe_finalize		= viommu_probe_finalize,
 	.release_device		= viommu_release_device,
 	.device_group		= viommu_device_group,
 	.get_resv_regions	= viommu_get_resv_regions,
-- 
2.31.1

