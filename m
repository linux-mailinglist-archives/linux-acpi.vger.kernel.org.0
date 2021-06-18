Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66F3C3ACF24
	for <lists+linux-acpi@lfdr.de>; Fri, 18 Jun 2021 17:33:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235493AbhFRPfM (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 18 Jun 2021 11:35:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235669AbhFRPez (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 18 Jun 2021 11:34:55 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCB9CC061A30
        for <linux-acpi@vger.kernel.org>; Fri, 18 Jun 2021 08:30:26 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id gt18so16475432ejc.11
        for <linux-acpi@vger.kernel.org>; Fri, 18 Jun 2021 08:30:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rpRcMlANuJMVLr/XwX8HEu/R5blh278L1JFLoof2k1A=;
        b=jO4a4H8Yhggcga4GQdZHUtondp+5Jx+D9WWbrevj+4RY3niqEa7Gjxo9T0BM+3mFzj
         q7Kjb+dga1Uy0PA0AIU3gPoqzIGyr3Zyhhr+ELhL6dj55qnE/8J00aGATXw7obrxrjHc
         fDxsl5c0eNS6ExRmSIPOIogUma7fv7B+Zlb9CXFU+YbLEtXgmxZUosqgnUPtM2gTMoFb
         3EHZu4+eKUmgSdc/Gnm9yDnbIJSrWyiNtION2WYfgl59CR3LvTGF12+CATOUdvom3/XV
         cGh+zU5eQWCjbhXehiI74kJeaclkuwe5nSulA+QKKQuKMvcBkYkApJH7trVKqt7Txo5D
         j3fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rpRcMlANuJMVLr/XwX8HEu/R5blh278L1JFLoof2k1A=;
        b=oM2bAxaRWR+rO1nzKPH0QOTHdSkHVsX908Y1KlgodQbwOlv9Ozo9Vv4m0CAF8prcLA
         RgXgxZVd7MI/LtzG/RAy/LHR0WWX3i2o8bSKejqwQmQVvDIacwQRJT3cYFr0ZNk7/3BZ
         aR0jDpoINHe0h43gqA76Md40ebKBhljLtI9gu0UI0yavNwbydJtBO3xLA7r1FoRmz1sg
         gDXlnw4wXGh7U8iPUSgVqgJV+yJCH8LdyNgWVWBS4rBOOpCsFbCf69xE4b6bV7g8RxS6
         +dEup56AthX6xvmzKWecupQLcXU1FprG70z9ID0Sn6iGxWIF1enkCl20XXCWaK5+JlBo
         w9SA==
X-Gm-Message-State: AOAM533Zt8U1QzP8X4HUV3DCeELvlwT7MScIWn1nA+QWHeUhvVCrHHK4
        qB/3BzuHWMvZEg4VBhrVF0GV4A==
X-Google-Smtp-Source: ABdhPJwv2gkUGSnBNaByT41YPue7mNT8OUrgVjtrwBeLgH2oLQ6rAXxgrzJb3pLtycur69cTKQfF+A==
X-Received: by 2002:a17:906:b0c6:: with SMTP id bk6mr11670554ejb.97.1624030225430;
        Fri, 18 Jun 2021 08:30:25 -0700 (PDT)
Received: from localhost.localdomain (adsl-84-226-111-173.adslplus.ch. [84.226.111.173])
        by smtp.gmail.com with ESMTPSA id bn7sm1197613ejb.111.2021.06.18.08.30.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Jun 2021 08:30:25 -0700 (PDT)
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
Subject: [PATCH v5 5/5] iommu/virtio: Enable x86 support
Date:   Fri, 18 Jun 2021 17:21:00 +0200
Message-Id: <20210618152059.1194210-6-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210618152059.1194210-1-jean-philippe@linaro.org>
References: <20210618152059.1194210-1-jean-philippe@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

With the VIOT support in place, x86 platforms can now use the
virtio-iommu.

Because the other x86 IOMMU drivers aren't yet ready to use the
acpi_dma_setup() path, x86 doesn't implement arch_setup_dma_ops() at the
moment. Similarly to Vt-d and AMD IOMMU, clear the DMA ops and call
iommu_setup_dma_ops() from probe_finalize().

Acked-by: Joerg Roedel <jroedel@suse.de>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
Tested-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
 drivers/iommu/Kconfig        |  3 ++-
 drivers/iommu/dma-iommu.c    |  1 +
 drivers/iommu/virtio-iommu.c | 11 +++++++++++
 3 files changed, 14 insertions(+), 1 deletion(-)

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
index c62e19bed302..9dbbc95c8189 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -1330,6 +1330,7 @@ void iommu_setup_dma_ops(struct device *dev, u64 dma_base, u64 dma_limit)
 	 pr_warn("Failed to set up IOMMU for device %s; retaining platform DMA ops\n",
 		 dev_name(dev));
 }
+EXPORT_SYMBOL_GPL(iommu_setup_dma_ops);
 
 static struct iommu_dma_msi_page *iommu_dma_get_msi_page(struct device *dev,
 		phys_addr_t msi_addr, struct iommu_domain *domain)
diff --git a/drivers/iommu/virtio-iommu.c b/drivers/iommu/virtio-iommu.c
index c6e5ee4d9cef..fe581f0c9b3a 100644
--- a/drivers/iommu/virtio-iommu.c
+++ b/drivers/iommu/virtio-iommu.c
@@ -10,6 +10,7 @@
 #include <linux/amba/bus.h>
 #include <linux/delay.h>
 #include <linux/dma-iommu.h>
+#include <linux/dma-map-ops.h>
 #include <linux/freezer.h>
 #include <linux/interval_tree.h>
 #include <linux/iommu.h>
@@ -904,6 +905,15 @@ static struct iommu_device *viommu_probe_device(struct device *dev)
 	return ERR_PTR(ret);
 }
 
+static void viommu_probe_finalize(struct device *dev)
+{
+#ifndef CONFIG_ARCH_HAS_SETUP_DMA_OPS
+	/* First clear the DMA ops in case we're switching from a DMA domain */
+	set_dma_ops(dev, NULL);
+	iommu_setup_dma_ops(dev, 0, U64_MAX);
+#endif
+}
+
 static void viommu_release_device(struct device *dev)
 {
 	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
@@ -940,6 +950,7 @@ static struct iommu_ops viommu_ops = {
 	.iova_to_phys		= viommu_iova_to_phys,
 	.iotlb_sync		= viommu_iotlb_sync,
 	.probe_device		= viommu_probe_device,
+	.probe_finalize		= viommu_probe_finalize,
 	.release_device		= viommu_release_device,
 	.device_group		= viommu_device_group,
 	.get_resv_regions	= viommu_get_resv_regions,
-- 
2.32.0

