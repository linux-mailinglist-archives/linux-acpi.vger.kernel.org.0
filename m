Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E18372FEA62
	for <lists+linux-acpi@lfdr.de>; Thu, 21 Jan 2021 13:43:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730059AbhAUMmC (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 21 Jan 2021 07:42:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731458AbhAUMld (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 21 Jan 2021 07:41:33 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C67EAC0617A1
        for <linux-acpi@vger.kernel.org>; Thu, 21 Jan 2021 04:39:43 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id e15so1400811wme.0
        for <linux-acpi@vger.kernel.org>; Thu, 21 Jan 2021 04:39:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=34NOfBoAQbhC4EqUo+bMrvAxSDfvSBJrgTwiEwqrJqM=;
        b=jh49AsG8Ku0X4MhQbeMX7gD6G5UG3nPk0+s0Syjj6Dy+TDWxpcfUm1e3LYSB6p4OvM
         Kg7SYcQuula7b+NVb/TXvcqksYjq2JPVI+6D1CxevtRxa9tZYqhap6+zOMQBpd649qPu
         zaQFYlaVbzfUOo3p1I61spJduaApW3KsUwNjJLUqaBOV7hqUtwjm9KtGxYIFztBX1RNI
         zbgYMQFWzDmEv+XcAHZckcAKOvqzmBgM1inzWfUawY2CEgxYMsTNSC+E/Z93Z1mv+ka6
         VEMPecgh4nyCWC/EWc1m7jDWKJD8cj6xR21JNGmxdyy9qYq6kAm5HvjThelK7GRoVVtx
         bR7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=34NOfBoAQbhC4EqUo+bMrvAxSDfvSBJrgTwiEwqrJqM=;
        b=iDEqBs5mRXixzh4cwQa4SgNfbniVUHrPQaCnorKm+OjAZMHizIc7X9V9Voy1m/bCtW
         bkStDk1ZB2glg/3GdUf4ORRwsLadnIjT2d+ai8D3pSN+lUQ24B6QiU2Y1x9SLrWmuATX
         vcFa4BljCmBnogUY5MFqLfSnBQnx5T+YcP7nNTd+4SnbPGE6v5K9idZIWQejgnEByaOn
         HypDlnny0KiaxVPlWlmxP6hyGX43HvGNBOcSGJ19TtYVqtiwwwqMxva4AgAZDflu5rtZ
         SD2xzSLVnCJh9bboxt94rwmmlF9tBPoX2m4yVckNYKF8MMFsPP3z63z9qMAi42khskNy
         bjRg==
X-Gm-Message-State: AOAM5314TU1vjbzkzu1fkEExwOJ/aROj5IVQt5FffPJw9QVWVSWfjC1h
        GC/jIKkC5Z7z2mbT0tEl2rIU+Q==
X-Google-Smtp-Source: ABdhPJy4aVE7nUGRBVsnvQda65l+P+gt53hIs8sV+GNjymDZ9tsnP67X7H+cf54+VmJof+s0v8IZkw==
X-Received: by 2002:a1c:5403:: with SMTP id i3mr8695684wmb.87.1611232782538;
        Thu, 21 Jan 2021 04:39:42 -0800 (PST)
Received: from localhost.localdomain ([2001:1715:4e26:a7e0:116c:c27a:3e7f:5eaf])
        by smtp.gmail.com with ESMTPSA id p18sm7979248wmc.31.2021.01.21.04.39.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Jan 2021 04:39:41 -0800 (PST)
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
        Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: [PATCH v10 09/10] ACPI/IORT: Enable stall support for platform devices
Date:   Thu, 21 Jan 2021 13:36:23 +0100
Message-Id: <20210121123623.2060416-10-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210121123623.2060416-1-jean-philippe@linaro.org>
References: <20210121123623.2060416-1-jean-philippe@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Copy the "Stall supported" bit, that tells whether a named component
supports stall, into the dma-can-stall device property.

Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
 drivers/acpi/arm64/iort.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
index c9a8bbb74b09..42820d7eb869 100644
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
2.30.0

