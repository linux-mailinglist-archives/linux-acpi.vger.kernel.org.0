Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7332830600D
	for <lists+linux-acpi@lfdr.de>; Wed, 27 Jan 2021 16:47:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236566AbhA0PrA (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 27 Jan 2021 10:47:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236555AbhA0PpQ (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 27 Jan 2021 10:45:16 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 184C4C061573
        for <linux-acpi@vger.kernel.org>; Wed, 27 Jan 2021 07:44:36 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id m187so1919136wme.2
        for <linux-acpi@vger.kernel.org>; Wed, 27 Jan 2021 07:44:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0PBUJkI6WkOQ4c7ebH11XhAeKbkF/R51HzjghE20E74=;
        b=BQJC3HuzpSzPBhYU8dAoIE4ZFOsaKvTTyDozAsFM/UlXGrWhBWsG1EBwunnAFsQ7fi
         Cx6syUteFUWRkMbIUgIP/7mUtZnmYFakuGW4SsO2HYY8yC3V29+hRjP6BBmROUg7LaQI
         aqsoQl5WG6wx9FDljC24Hkkr2MSU5/DJAJ6zVS02cIGN54trZqTVDl7jf2gKnTFxcFsR
         brLgpNCFXSoX9613SmJxNT49S2bJcbAxoyN26EEtgxLXXUnadPwjEgY/e506opSx3820
         uNXoF0qCGnGL5/tkm1T76snDHbiUJrhNkBBpAuFEKzUgjQ+DiexDYpHVV90v9UMZ47Il
         uBZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0PBUJkI6WkOQ4c7ebH11XhAeKbkF/R51HzjghE20E74=;
        b=LC4kQPunoMD+gxRjMV1opMs533/ULRKdkf2Chj9cn+yyRucZNy1eJM+/rg24YzMbVi
         hDsN33oztxdg5xIsplMFJkjQBUbbvOXWhrhFQurLHEowaD+AUlAXMpFjIfkd/9ZPKd7W
         WoybKtBQZNIrWmgqhqrd98o3WVeyNSOCOoXQQL1kGdP3tYqpltN/G2okZEGOCkA8kevd
         9fRVasqnqoYFyHsDxIg3+btmVq8903ZghEumR4XUiQnEsID68hCND37mhmgaaOKcrx6c
         c9OPCnYOQJJS7nMQg0hakt1DltkI9O0KW/E8Dlw1b3MPcWyGPCYpDzVO2glL9GD4Q8OW
         e4Tg==
X-Gm-Message-State: AOAM533pmydvqhuMe4eQn1Yg58XfUIFDQF1C7SvfHOkoBWDFbliW6U/P
        NzUImTORzLIv/jLdSVX6vD95kw==
X-Google-Smtp-Source: ABdhPJy7KRFJ7NFIkxsBzkZIFHw9c+dEAyELqQZaTxwXlNuad0dlgQbMzSL7a36FagOJol78uVNV6w==
X-Received: by 2002:a1c:cc14:: with SMTP id h20mr4755144wmb.180.1611762274755;
        Wed, 27 Jan 2021 07:44:34 -0800 (PST)
Received: from localhost.localdomain ([2001:1715:4e26:a7e0:116c:c27a:3e7f:5eaf])
        by smtp.gmail.com with ESMTPSA id r13sm3046921wmh.9.2021.01.27.07.44.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Jan 2021 07:44:34 -0800 (PST)
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
Subject: [PATCH v12 01/10] iommu: Fix comment for struct iommu_fwspec
Date:   Wed, 27 Jan 2021 16:43:14 +0100
Message-Id: <20210127154322.3959196-2-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210127154322.3959196-1-jean-philippe@linaro.org>
References: <20210127154322.3959196-1-jean-philippe@linaro.org>
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
index b3f0e2018c62..bdf3f34a4457 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -570,7 +570,7 @@ struct iommu_group *fsl_mc_device_group(struct device *dev);
  * struct iommu_fwspec - per-device IOMMU instance data
  * @ops: ops for this device's IOMMU
  * @iommu_fwnode: firmware handle for this device's IOMMU
- * @iommu_priv: IOMMU driver private data for this device
+ * @flags: IOMMU_FWSPEC_* flags
  * @num_pasid_bits: number of PASID bits supported by this device
  * @num_ids: number of associated device IDs
  * @ids: IDs which this device may present to the IOMMU
-- 
2.30.0

