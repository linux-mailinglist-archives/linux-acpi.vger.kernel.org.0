Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93E3D30601E
	for <lists+linux-acpi@lfdr.de>; Wed, 27 Jan 2021 16:48:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236206AbhA0PsE (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 27 Jan 2021 10:48:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236651AbhA0Pqj (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 27 Jan 2021 10:46:39 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3079C061356
        for <linux-acpi@vger.kernel.org>; Wed, 27 Jan 2021 07:44:46 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id f16so1910318wmq.5
        for <linux-acpi@vger.kernel.org>; Wed, 27 Jan 2021 07:44:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=P/EAy3wFo2SkAvzlEqANsfgzLeO0MB9eAURTmLNsvNA=;
        b=mb07EcDaQibTEwHyo1+my09q6bkkLrDK+31eVBj3xeA3p0boN8Cnn6DHCFEjErg6ay
         1qVr03v/rFH29yu2BvCS2DbIo97LHYGyuv88KKQNM2MTQ2+U4Bl3vu4LuBfUSrrG7uak
         6aDNhLCw2Q8ymqA8LvqcjEjg/PNki0B2ltIM9AHHsXFIhulJH5o+h060GC3ZenURtkBN
         8ysP23TmFVJIj6bNYAQip6zL0bPvbTVeQPIGR30xGFngU0oajhJjG2BRFpYrUvvg5WBo
         NmGSP9P24o0UZJ3BVjroLLiiBev9KxkbokaPnFyaRq/BegljrmRMi+x5tle1qwRvtGKF
         m2jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=P/EAy3wFo2SkAvzlEqANsfgzLeO0MB9eAURTmLNsvNA=;
        b=MQeNnLTTogDo4oeudoZRnHUeOEUMRNq4+7K8+/IQmafNucBIpV9bICt/aJXQfL2KQr
         3DHOshInodBSsnbkFx/bLRwhPu6wmxckjhQ8P8hcnpSyBUAFx3kTRuauiMYPmzquj4hf
         BJDko7KLM37W2N05xrax2vLIvkMOtMFqiXgkAPT39wiKE6AD92Q/xP3h1Bc7+G/SmLuG
         IPSXv3zGusOrIVQTM+ogWwkyQH9wfGcBE0fhX0dXaxNAXXrP2RuAAn44xJRddBsJ6UQm
         yWG2Jlczuvl80phZKBu8JmnAg2bMPgE7XxJK/z6QbYqsIzUMr5Z7eKWK+Ywju4vknQAr
         hf7w==
X-Gm-Message-State: AOAM530o/aOp7xK3qxJXL91COoMnaZ/+NmSa0hjZs9eZZMILNse0I0yY
        hUYX1X3LuGtc7Cb7KvKUF40Gwg==
X-Google-Smtp-Source: ABdhPJxDNGjMbngdefhVghUfb0JN88zaAJwQb8TwLjwsDCOpCI43m4o3Qu457Rvsh0CFa6Zcy7TnHA==
X-Received: by 2002:a1c:e407:: with SMTP id b7mr4745128wmh.46.1611762285528;
        Wed, 27 Jan 2021 07:44:45 -0800 (PST)
Received: from localhost.localdomain ([2001:1715:4e26:a7e0:116c:c27a:3e7f:5eaf])
        by smtp.gmail.com with ESMTPSA id r13sm3046921wmh.9.2021.01.27.07.44.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Jan 2021 07:44:44 -0800 (PST)
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
Subject: [PATCH v12 09/10] ACPI/IORT: Enable stall support for platform devices
Date:   Wed, 27 Jan 2021 16:43:22 +0100
Message-Id: <20210127154322.3959196-10-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210127154322.3959196-1-jean-philippe@linaro.org>
References: <20210127154322.3959196-1-jean-philippe@linaro.org>
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

