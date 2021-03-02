Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF1AF32A4CF
	for <lists+linux-acpi@lfdr.de>; Tue,  2 Mar 2021 16:56:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1446533AbhCBLSA (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 2 Mar 2021 06:18:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379099AbhCBJja (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 2 Mar 2021 04:39:30 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C2B4C061225
        for <linux-acpi@vger.kernel.org>; Tue,  2 Mar 2021 01:35:41 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id d15so3860194wrv.5
        for <linux-acpi@vger.kernel.org>; Tue, 02 Mar 2021 01:35:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Tljaa6sLGzqVEkWTy8WFZ8+1JVN/U6naVu2IpICY8qc=;
        b=CUqHhZIYRju55gc+SgJJfVnY562fuTxugAA10rym5tTkb8g8m152o+DT++duK/z+Fp
         5E+eDlGNVXS5r3h4+KvyMUE9P96vilcFmZT+EnHNNa9MJl+MZ1zyKriTkgySFqJ8NoVM
         6Rt2AA3J3Kk2WMRXeGu9VXSp9tJHuj7/jS077RIVONKPfbBxA6kJHgZVfAhhszUAkLLJ
         gYael+2uxEimdDjb5FL2gB2UfzfmgCSRrAELmBRIepAtkUEQimQU/LFw6NJEfqsvhei5
         bWJl4B+z4JSM+OExnA+1C6+FYFU2kn+LWS556rFB6/W/5FQVf2A38rvwhRVQXW+Vc1Hb
         FOdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Tljaa6sLGzqVEkWTy8WFZ8+1JVN/U6naVu2IpICY8qc=;
        b=obRj6xl2WC6ywN728rnr+e0m8/VFrVLSg4MGNdKvOZgiRlMjZHhnalFg3Ug80wGtB2
         B6BglFds1xkfQ0rmm5wZ42CdxU2RWV+0FE55gQvQjAQl0I3O+GiteMOn5c9Twk6vsnv4
         hwJ1R67IVQR+VE+FrGnDEGsuF/NkoK9UBiDeHKOHA6xUeGkIuK73MTaf2UXKInlUA6T6
         IhUgRI0eFj4RX4rYs3AHldVWjVIpDqCXwwhePQBb91nublWmBUiD3RVxVsK2NlHOL2dk
         QM6Afl6/T3iPXIA32tQ+XxfLzsRlhBVSafmrZjqeJXblcJDCHE8bb9X+JC8CAOUROiIK
         TXRw==
X-Gm-Message-State: AOAM530p0JZpQKkr+A+rBy9TyRb6Y9HXBLPotiwfwoHy+ih1SoeRYZOS
        qwmzG5pp4JiWPX+b0P9MHamwpQ==
X-Google-Smtp-Source: ABdhPJy5shG4cAWZu1Stz095i3ckx38acnf/wOYqacuVRhrdrmVSW4ctRbes8RS7Kd/oDkBHRXqASA==
X-Received: by 2002:adf:f8cd:: with SMTP id f13mr20377429wrq.27.1614677740193;
        Tue, 02 Mar 2021 01:35:40 -0800 (PST)
Received: from localhost.localdomain ([2001:1715:4e26:a7e0:116c:c27a:3e7f:5eaf])
        by smtp.gmail.com with ESMTPSA id w131sm1963818wmb.8.2021.03.02.01.35.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Mar 2021 01:35:39 -0800 (PST)
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
Subject: [PATCH v13 09/10] ACPI/IORT: Enable stall support for platform devices
Date:   Tue,  2 Mar 2021 10:26:45 +0100
Message-Id: <20210302092644.2553014-10-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210302092644.2553014-1-jean-philippe@linaro.org>
References: <20210302092644.2553014-1-jean-philippe@linaro.org>
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
2.30.1

