Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F03753517CF
	for <lists+linux-acpi@lfdr.de>; Thu,  1 Apr 2021 19:47:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235464AbhDARmt (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 1 Apr 2021 13:42:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234397AbhDARhF (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 1 Apr 2021 13:37:05 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDB2DC02D561
        for <linux-acpi@vger.kernel.org>; Thu,  1 Apr 2021 08:48:23 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id j7so2311135wrd.1
        for <linux-acpi@vger.kernel.org>; Thu, 01 Apr 2021 08:48:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Pua2Ae+rON0ZlDGkY5ERFS3L6AfCPNmqgc0wotIPcEI=;
        b=AQvPYJQL0dmJB8IZi8mOx5ajxcUoc5TP5FrCan7PcbU1GTN0XGGjNban28AqG/S1eT
         OudspSuh2Y3yKLRQat1UH9wPkhK7kK1V4/Nse8fGfuXTANeCQz/6GNyEkkuQ892jAlBN
         uLktlNmlJ+cpmtV+v1kZNPG9+f9Je/j0w4TkbAnbKuaTJsEudCj75aijL+6mht/qNUdC
         N3MdPwLKorkokFBX8FVIOAgztR5GGcUSmgB+MNc9zvwZOzl3Fl/HJ+GVNCrbohS5mLLd
         zQV/qSheXVl+YDvYbKfJ9D0XLZOoNDYB9n3zFvZmrgJ75fH8m/Xm/ZvqRNEWYW1jeHdB
         Vz1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Pua2Ae+rON0ZlDGkY5ERFS3L6AfCPNmqgc0wotIPcEI=;
        b=FIfqx07644vMDvAuUt5Mb2raXgs0P/Z9/UVZEUy5ld/LPKkuOh2WewMltXWY/z6ZFw
         ISx4boAyJclCmzW1Se5kXQgpUJjfn4bHbOeUMMHIFb9OhJnYrUOvi/HagYBEo1EKqfq2
         sn2mWMNjCrJCNjZWUgTu/G4sTv8k/8ZtVdg0DWO+NIORVC1r0+vGPx4KKZ0DoK6Hshkb
         04EAo3hjwGomTKi+sj5xQ99keH40XqQ7IQmcl5MSyW+JRC/Dz6lHhuBo80JUBEfxffQD
         x406yuNXUz2dzU4X9mPzzblfekwpPB2mibEtk8AajFPuE+IK5gSDpcilCMruEf2xvxDI
         S20w==
X-Gm-Message-State: AOAM530Jy7PrU/iHkMbdtQyW98lm+mzNvS6FMCpC7g8vKByn9x65GH8P
        ZdLvccyzNZOOqghYh0kyED8vqg==
X-Google-Smtp-Source: ABdhPJyrIah1qqCxNJvBbipg66vyVTPCXXhRfRjwHTQ1aqsgM2ee8hefPg9PttDsuRkr/f0yUE7kcA==
X-Received: by 2002:adf:d1c5:: with SMTP id b5mr10474358wrd.126.1617292102724;
        Thu, 01 Apr 2021 08:48:22 -0700 (PDT)
Received: from localhost.localdomain ([2001:1715:4e26:a7e0:116c:c27a:3e7f:5eaf])
        by smtp.gmail.com with ESMTPSA id y8sm8722505wmi.46.2021.04.01.08.48.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Apr 2021 08:48:22 -0700 (PDT)
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
Subject: [PATCH v14 09/10] ACPI/IORT: Enable stall support for platform devices
Date:   Thu,  1 Apr 2021 17:47:18 +0200
Message-Id: <20210401154718.307519-10-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210401154718.307519-1-jean-philippe@linaro.org>
References: <20210401154718.307519-1-jean-philippe@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Copy the "Stall supported" bit, that tells whether a named component
supports stall, into the dma-can-stall device property.

Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
 drivers/acpi/arm64/iort.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
index 3912a1f6058e..0828f70cb782 100644
--- a/drivers/acpi/arm64/iort.c
+++ b/drivers/acpi/arm64/iort.c
@@ -968,13 +968,15 @@ static int iort_pci_iommu_init(struct pci_dev *pdev, u16 alias, void *data)
 static void iort_named_component_init(struct device *dev,
 				      struct acpi_iort_node *node)
 {
-	struct property_entry props[2] = {};
+	struct property_entry props[3] = {};
 	struct acpi_iort_named_component *nc;
 
 	nc = (struct acpi_iort_named_component *)node->node_data;
 	props[0] = PROPERTY_ENTRY_U32("pasid-num-bits",
 				      FIELD_GET(ACPI_IORT_NC_PASID_BITS,
 						nc->node_flags));
+	if (nc->node_flags & ACPI_IORT_NC_STALL_SUPPORTED)
+		props[1] = PROPERTY_ENTRY_BOOL("dma-can-stall");
 
 	if (device_add_properties(dev, props))
 		dev_warn(dev, "Could not add device properties\n");
-- 
2.31.1

