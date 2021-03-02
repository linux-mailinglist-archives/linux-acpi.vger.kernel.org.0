Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6887932A4C2
	for <lists+linux-acpi@lfdr.de>; Tue,  2 Mar 2021 16:47:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442174AbhCBLQ0 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 2 Mar 2021 06:16:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241432AbhCBJgW (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 2 Mar 2021 04:36:22 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDCADC061793
        for <linux-acpi@vger.kernel.org>; Tue,  2 Mar 2021 01:35:32 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id a18so10886557wrc.13
        for <linux-acpi@vger.kernel.org>; Tue, 02 Mar 2021 01:35:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=q1dBU0HCqaN2oBJe9EmSK9n4bOZOtCnnbOc1d9k2Lwk=;
        b=TjiGWaeH01qGoIEQwfZkE7Z5JsNayNoEh2k+bi13tJXonskCNhseJfQymh+UJSVBGY
         tQhTKXwiAJn4JRbC70qRUg+BSzt/tKIZ8YkjJks/LvKxcsxcuHVlkitDHLBeh1PxJrXj
         c5ASycut8M9NUDlB3StAbfCtaLJROK1bLKvUDQ8ryVV6skmVutS2tX0BSi6dRM1JAkMv
         sOl1UtbRJV55dRe5eIEov7WsPcStFJaoR7bTretXUc/lbGCZo11gafb+W2so/0XiRYJn
         HSZQEGVLwYQupOMz68Urbcq9FOu3bfPvFhIUo4eZRraVMDxVR7y1Nf4tpC+Sz8OpsrKh
         8c3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=q1dBU0HCqaN2oBJe9EmSK9n4bOZOtCnnbOc1d9k2Lwk=;
        b=adLChl31y9xW0gjMXM6bYWYASq1nL3jBFH/QdaUTfobfESLq5p2ZO7uqAJ2dUir3+z
         DxGenJyprbIcevTonJwbN5kEoBJg38924ywFmy8UkTf4yu85RRdf/gK0Ic92VyjPPfwC
         jSvRCeOIGNUjMh9X3/FvYfMO7nZ8LGgNCo/juUXOwX4sgaKie7sMBA5VNp5Ln+aHH0uq
         vDufshXf5ZzgAdkMewpJjwdXkB6dX3Uoyd1ZOHsyOB+SnhBkKIenWgpgTe7kYyVwumaQ
         +J3P54RgdBKv+h/gp95vGCQylDNKrxcD/4dii2ex2ajBsWggIAoVi40PFxAizlZjtrtb
         HUTQ==
X-Gm-Message-State: AOAM530C5WOKzCS8UhJQsIJe/rEhxgLOOV4zWBYuVIylmnBJTUHCxvaY
        psGH65XC38OovYlep8EyDG4TyA==
X-Google-Smtp-Source: ABdhPJw0xjkmPSp0mtZPb6X4Nd58+owZ0dVYxXm8u5GKEjL3scy/QYMFqL4xdWND/ojmSq+WV9cIEA==
X-Received: by 2002:a5d:6103:: with SMTP id v3mr10571422wrt.375.1614677731470;
        Tue, 02 Mar 2021 01:35:31 -0800 (PST)
Received: from localhost.localdomain ([2001:1715:4e26:a7e0:116c:c27a:3e7f:5eaf])
        by smtp.gmail.com with ESMTPSA id w131sm1963818wmb.8.2021.03.02.01.35.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Mar 2021 01:35:31 -0800 (PST)
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
Subject: [PATCH v13 01/10] iommu: Fix comment for struct iommu_fwspec
Date:   Tue,  2 Mar 2021 10:26:37 +0100
Message-Id: <20210302092644.2553014-2-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210302092644.2553014-1-jean-philippe@linaro.org>
References: <20210302092644.2553014-1-jean-philippe@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Commit 986d5ecc5699 ("iommu: Move fwspec->iommu_priv to struct
dev_iommu") removed iommu_priv from fwspec and commit 5702ee24182f
("ACPI/IORT: Check ATS capability in root complex nodes") added @flags.
Update the struct doc.

Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
 include/linux/iommu.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 5e7fe519430a..1d422bf722a1 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -571,7 +571,7 @@ struct iommu_group *fsl_mc_device_group(struct device *dev);
  * struct iommu_fwspec - per-device IOMMU instance data
  * @ops: ops for this device's IOMMU
  * @iommu_fwnode: firmware handle for this device's IOMMU
- * @iommu_priv: IOMMU driver private data for this device
+ * @flags: IOMMU_FWSPEC_* flags
  * @num_pasid_bits: number of PASID bits supported by this device
  * @num_ids: number of associated device IDs
  * @ids: IDs which this device may present to the IOMMU
-- 
2.30.1

