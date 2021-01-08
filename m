Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D07592EF46D
	for <lists+linux-acpi@lfdr.de>; Fri,  8 Jan 2021 16:04:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727453AbhAHPDw (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 8 Jan 2021 10:03:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726735AbhAHPDv (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 8 Jan 2021 10:03:51 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA817C0612A8
        for <linux-acpi@vger.kernel.org>; Fri,  8 Jan 2021 07:02:41 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id a12so9282972wrv.8
        for <linux-acpi@vger.kernel.org>; Fri, 08 Jan 2021 07:02:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=M6xu+NZsefpfo8WqjQL32PlY8NL0QuBVkGqSt5snD+A=;
        b=kxuUCMV1WAqpwwvoibNUsWYrlPgddFb1B3XDtYKriSKJqhZ7YxBdz7idYeFiPEusdj
         oSxwzMXDVtdAhRbiUIPtiWxDXm3EOdY0B1oZ4RFYK1eN63WYymsf6s1QMgxe1Fp+XJLm
         7MYSyOGWzgv+FVOhkD8wVISPR0VlGxk9zmYIDuW8ATAmQ8SghsBmSoZJE31MhRs/IXU7
         jcMsXHSkhBXTuv9sJLCqbDDqfbxZnhaRfmDInXFrql1M/HVbnCpK9DeM9XJWQDFfFBiX
         CVAh4zvNMBGGzxZ42Xa9GLW4zEO7yuaspaFGL8sBAQLWZMjutowtPglRsb0G7rH8euGW
         4JKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=M6xu+NZsefpfo8WqjQL32PlY8NL0QuBVkGqSt5snD+A=;
        b=bLku92v8u1nT2nkU6DdFWQ9iEdSHaZW7ynEgcY3DJ0AjWUiYKVx1+xVvJnAnJJPGPQ
         aEymF0rULIWxTltS4ZQ/MybHNEeSZkdVlaH/WCu012ELwVP8mI6B2a2IiyBLz5IosSxV
         F/jxbcrk3FbVqsPRoY2Of7DZD+ONtJQHdKNilobpCJ633rI8WcTZSGpHmvn/sSOuqkOJ
         PM7HHs6kziHPfC3RwPC1wBrKp/QjJSHBMTbbP9X58xX2VB9ZiA1CKG9i4mXn/hoAa583
         jwTwbVj9ZbrqDEpjBLlKLCXO996ryKyJIfcujGA40+xAAY4VSw91hBXqey4vYGN1SFnB
         kwhg==
X-Gm-Message-State: AOAM530vcJhzbS9BqkeBf5DSCZGu+Sb8JlhoQSy8wkgD28+7o8IKjUMW
        O78VWTBn0kaGKZATVmlD/5dSpA==
X-Google-Smtp-Source: ABdhPJxXGloEPafSPINGJsoqaUcfHJIL8u06StaksnduujJItHcYtBuA/olK4ECauRMs3Zhmv7TwtA==
X-Received: by 2002:a05:6000:c9:: with SMTP id q9mr3946567wrx.259.1610118160590;
        Fri, 08 Jan 2021 07:02:40 -0800 (PST)
Received: from localhost.localdomain ([2001:1715:4e26:a7e0:116c:c27a:3e7f:5eaf])
        by smtp.gmail.com with ESMTPSA id s13sm14258464wra.53.2021.01.08.07.02.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Jan 2021 07:02:39 -0800 (PST)
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     joro@8bytes.org, will@kernel.org
Cc:     lorenzo.pieralisi@arm.com, robh+dt@kernel.org,
        guohanjun@huawei.com, sudeep.holla@arm.com, rjw@rjwysocki.net,
        lenb@kernel.org, robin.murphy@arm.com, Jonathan.Cameron@huawei.com,
        eric.auger@redhat.com, iommu@lists.linux-foundation.org,
        devicetree@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-accelerators@lists.ozlabs.org, baolu.lu@linux.intel.com,
        vdumpa@nvidia.com, zhangfei.gao@linaro.org,
        shameerali.kolothum.thodi@huawei.com, vivek.gautam@arm.com,
        Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: [PATCH v9 09/10] ACPI/IORT: Enable stall support for platform devices
Date:   Fri,  8 Jan 2021 15:52:17 +0100
Message-Id: <20210108145217.2254447-10-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210108145217.2254447-1-jean-philippe@linaro.org>
References: <20210108145217.2254447-1-jean-philippe@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Copy the "Stall supported" bit, that tells whether a named component
supports stall, into the dma-can-stall device property.

Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
v9: dropped fwspec member in favor of device properties
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
2.29.2

