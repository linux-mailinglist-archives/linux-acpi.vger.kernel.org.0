Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3FD1A3518A4
	for <lists+linux-acpi@lfdr.de>; Thu,  1 Apr 2021 19:49:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234910AbhDARqs (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 1 Apr 2021 13:46:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235186AbhDARmX (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 1 Apr 2021 13:42:23 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBB95C02D555
        for <linux-acpi@vger.kernel.org>; Thu,  1 Apr 2021 08:48:17 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id n11-20020a05600c4f8bb029010e5cf86347so4061677wmq.1
        for <linux-acpi@vger.kernel.org>; Thu, 01 Apr 2021 08:48:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=x9VnvWleXoCq4M6l74+6R8Pt6mH42n0/TIw6tHc9m0s=;
        b=ELNpZqvjV2tpdsGfwDdVSIYOMEo06hNAmBAYGz00nCzz6P7m31Rsai4XFH2EhXToD/
         r6/HKm1mRACp7JdijV2odAhSrHedfiHGBJ0fLxuERhw0WWFkPUwNZn1N665dm0ITTJa0
         PpNKtYTxMxDKaf0LVBoqu2bs0b4KT8nhhmNlWpW+WcSddCR7f0oOv3NLvJ4SKuC8gVlW
         0k004zm1Eb9ZFIqbzNHIinDVKKZ+mNpB9YEmj9uuGxmZ01XayG3ltAF0Cz3zvzD8qzHO
         jey3iq4KkxNShDIkfE6S+uZ3IhwMQKlOtlGUzNFw4nnBoPqjTZxBCY26sCaf6RNgrfc3
         JMaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=x9VnvWleXoCq4M6l74+6R8Pt6mH42n0/TIw6tHc9m0s=;
        b=MhpHZ8KUnv0+GyKxk3Z08WzJ4wz5dQBSmKJLN/toByZqqFU9s2Gjpnc8S3zAFQTeFL
         7uZUJk5GyExiu9vX11novKk8m/SrsxKy8m+0hAfJDrb4p7il11jzD6QB/i/KOTTGqzpD
         BsWIOfNfH9usL4zV6uKspzDsqSbIO36V7Et2/3bpHqsgsF66X4PACAzuDxvKG4PZ8LiM
         NiLnnqTzCmTIumWa2JMlSqjcFObDQZb8Gr85A1Ibyd2u5DjPYoC+dBCZF1oPCWj2B8bW
         1ZQk56a2TfJlm+8QWxTENojDDZ1drmZvdGNIsWGNZZd1RVRkWhNgpyR43e447OsY3SVd
         g/+A==
X-Gm-Message-State: AOAM532lUh4UjVQGMZYdmfgkkGm59xNr2S1eRjb9FqDXc3EZ7gdgeGGA
        jbp9WWui/khtf8vi1ucNna+MsA==
X-Google-Smtp-Source: ABdhPJyWAAL1I1BwCzp1+WSRmFZywB7yMUt24/4+GrLJVIX+8q/Tl0kZMiKtpNt1QxjTrN1PL/OndA==
X-Received: by 2002:a1c:bc8a:: with SMTP id m132mr8471783wmf.6.1617292096559;
        Thu, 01 Apr 2021 08:48:16 -0700 (PDT)
Received: from localhost.localdomain ([2001:1715:4e26:a7e0:116c:c27a:3e7f:5eaf])
        by smtp.gmail.com with ESMTPSA id y8sm8722505wmi.46.2021.04.01.08.48.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Apr 2021 08:48:16 -0700 (PDT)
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
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        David Woodhouse <dwmw2@infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH v14 03/10] iommu: Separate IOMMU_DEV_FEAT_IOPF from IOMMU_DEV_FEAT_SVA
Date:   Thu,  1 Apr 2021 17:47:12 +0200
Message-Id: <20210401154718.307519-4-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210401154718.307519-1-jean-philippe@linaro.org>
References: <20210401154718.307519-1-jean-philippe@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Some devices manage I/O Page Faults (IOPF) themselves instead of relying
on PCIe PRI or Arm SMMU stall. Allow their drivers to enable SVA without
mandating IOMMU-managed IOPF. The other device drivers now need to first
enable IOMMU_DEV_FEAT_IOPF before enabling IOMMU_DEV_FEAT_SVA. Enabling
IOMMU_DEV_FEAT_IOPF on its own doesn't have any effect visible to the
device driver, it is used in combination with other features.

Reviewed-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: David Woodhouse <dwmw2@infradead.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Joerg Roedel <joro@8bytes.org>
Cc: Lu Baolu <baolu.lu@linux.intel.com>
Cc: Will Deacon <will@kernel.org>
Cc: Zhangfei Gao <zhangfei.gao@linaro.org>
Cc: Zhou Wang <wangzhou1@hisilicon.com>
---
 include/linux/iommu.h | 20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 16ce75693d83..45c4eb372f56 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -156,10 +156,24 @@ struct iommu_resv_region {
 	enum iommu_resv_type	type;
 };
 
-/* Per device IOMMU features */
+/**
+ * enum iommu_dev_features - Per device IOMMU features
+ * @IOMMU_DEV_FEAT_AUX: Auxiliary domain feature
+ * @IOMMU_DEV_FEAT_SVA: Shared Virtual Addresses
+ * @IOMMU_DEV_FEAT_IOPF: I/O Page Faults such as PRI or Stall. Generally
+ *			 enabling %IOMMU_DEV_FEAT_SVA requires
+ *			 %IOMMU_DEV_FEAT_IOPF, but some devices manage I/O Page
+ *			 Faults themselves instead of relying on the IOMMU. When
+ *			 supported, this feature must be enabled before and
+ *			 disabled after %IOMMU_DEV_FEAT_SVA.
+ *
+ * Device drivers query whether a feature is supported using
+ * iommu_dev_has_feature(), and enable it using iommu_dev_enable_feature().
+ */
 enum iommu_dev_features {
-	IOMMU_DEV_FEAT_AUX,	/* Aux-domain feature */
-	IOMMU_DEV_FEAT_SVA,	/* Shared Virtual Addresses */
+	IOMMU_DEV_FEAT_AUX,
+	IOMMU_DEV_FEAT_SVA,
+	IOMMU_DEV_FEAT_IOPF,
 };
 
 #define IOMMU_PASID_INVALID	(-1U)
-- 
2.31.1

