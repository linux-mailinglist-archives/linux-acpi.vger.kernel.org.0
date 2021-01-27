Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2431306006
	for <lists+linux-acpi@lfdr.de>; Wed, 27 Jan 2021 16:46:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235978AbhA0PqB (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 27 Jan 2021 10:46:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236507AbhA0Pou (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 27 Jan 2021 10:44:50 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2BD1C0613ED
        for <linux-acpi@vger.kernel.org>; Wed, 27 Jan 2021 07:44:34 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id q7so2362300wre.13
        for <linux-acpi@vger.kernel.org>; Wed, 27 Jan 2021 07:44:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wS1ZhkPy53Ug869D5KbFul/TixGQjhvdRxH2RGl6FFE=;
        b=yN8+ZEYXs60LN4H3/iPUmkayFZ/QFexI3MYPBddUqnXmHvaY0MXGcSoHtKGUGxBV7c
         htle9Dm4IzXGK+AFIQBxOCDlyawRU2/4Zxpk022izvBIRBliGrxNFxcTQBDRUV8NGYff
         WjI+fQb5fNoNcnAcq1+EM4Zr40bYkcq0Pq9P8M1MRSSkWNS/u7gmKPYcWqSWnuZDM2sY
         7O235W+myUX8QySNqVx40PNuAvAQePQiBSFrRXdcGt1cNOmrWFEiBxF2Y2jp5jL50DRM
         UNJ9LSP88Qref/3tFFBjVg1GkIQGAKo4NjTZsaCKcq8f9eE2WMxyrP1DYs3odfFOss1P
         Nhuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wS1ZhkPy53Ug869D5KbFul/TixGQjhvdRxH2RGl6FFE=;
        b=CC+P59fk1slvAyNtrzhnJ+uUm3j0nqovuraFHYwvP4PfBqiKv1JgPyG3V0yRIeWyCe
         5CJnBEvzuKKrpra6VC+9e60OGNOCjiXnkHiNNtudWglx6A48lW6m8QpOgwKauKiuWXET
         S+yyLkjeOmFeyry299oU7Fg2TvZwRu/3pForKqRb8GZ1rRpkuNgdASSuf6fSZdWAx5RP
         PoApTa5eW3hkRBtYybKjSdW5zvgSo+0bp+X4qTXblQ7g2FHEYRBtQvz5Nbf2wq/kCsu+
         cPBWOdg7BE9DrM3lvi2aRgYNTjDueJnbSYme/77T5PJ2/VVhwdt44sJOuilXCo5I7iho
         hR3w==
X-Gm-Message-State: AOAM530KIyESRETtHPkUFegrk0+TqpIf6QeszTTTfOfG3GGJye9PkKdC
        mYvkd88jXzE25jsXBRko+PQEWg==
X-Google-Smtp-Source: ABdhPJw8bmHv9UQA9WE+SkZNIdRG10VRBsv+I85VSHEhTtrJjAVrYGHN6RHpUEQcYQaNw5S9xdZKEg==
X-Received: by 2002:adf:f743:: with SMTP id z3mr11958548wrp.165.1611762273360;
        Wed, 27 Jan 2021 07:44:33 -0800 (PST)
Received: from localhost.localdomain ([2001:1715:4e26:a7e0:116c:c27a:3e7f:5eaf])
        by smtp.gmail.com with ESMTPSA id r13sm3046921wmh.9.2021.01.27.07.44.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Jan 2021 07:44:32 -0800 (PST)
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
Subject: [PATCH v12 00/10] iommu: I/O page faults for SMMUv3
Date:   Wed, 27 Jan 2021 16:43:13 +0100
Message-Id: <20210127154322.3959196-1-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Add stall support to the SMMUv3, along with a common I/O Page Fault
handler.

Since v11 I added a sanity check in arm_smmu_dev_disable_feature(),
patch 10: return -EBUSY if device drivers attempt to disable the IOPF
feature before SVA. That would leak the IOPF param and fault handler.

v11: https://lore.kernel.org/linux-iommu/20210125110650.3232195-1-jean-philippe@linaro.org/
v10: https://lore.kernel.org/linux-iommu/20210121123623.2060416-1-jean-philippe@linaro.org/
v9: https://lore.kernel.org/linux-iommu/20210108145217.2254447-1-jean-philippe@linaro.org/

Jean-Philippe Brucker (10):
  iommu: Fix comment for struct iommu_fwspec
  iommu/arm-smmu-v3: Use device properties for pasid-num-bits
  iommu: Separate IOMMU_DEV_FEAT_IOPF from IOMMU_DEV_FEAT_SVA
  iommu/vt-d: Support IOMMU_DEV_FEAT_IOPF
  uacce: Enable IOMMU_DEV_FEAT_IOPF
  iommu: Add a page fault handler
  iommu/arm-smmu-v3: Maintain a SID->device structure
  dt-bindings: document stall property for IOMMU masters
  ACPI/IORT: Enable stall support for platform devices
  iommu/arm-smmu-v3: Add stall support for platform devices

 drivers/iommu/Makefile                        |   1 +
 .../devicetree/bindings/iommu/iommu.txt       |  18 +
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h   |  56 ++-
 drivers/iommu/iommu-sva-lib.h                 |  53 ++
 include/linux/iommu.h                         |  26 +-
 drivers/acpi/arm64/iort.c                     |  15 +-
 .../iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c   |  59 ++-
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   | 351 +++++++++++--
 drivers/iommu/intel/iommu.c                   |  11 +-
 drivers/iommu/io-pgfault.c                    | 461 ++++++++++++++++++
 drivers/iommu/of_iommu.c                      |   5 -
 drivers/misc/uacce/uacce.c                    |  39 +-
 12 files changed, 1021 insertions(+), 74 deletions(-)
 create mode 100644 drivers/iommu/io-pgfault.c

-- 
2.30.0

