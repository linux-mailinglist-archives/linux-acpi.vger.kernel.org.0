Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC72D302448
	for <lists+linux-acpi@lfdr.de>; Mon, 25 Jan 2021 12:30:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727802AbhAYL3f (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 25 Jan 2021 06:29:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727740AbhAYLJY (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 25 Jan 2021 06:09:24 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BB31C0613D6
        for <linux-acpi@vger.kernel.org>; Mon, 25 Jan 2021 03:08:43 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id 190so10329384wmz.0
        for <linux-acpi@vger.kernel.org>; Mon, 25 Jan 2021 03:08:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=L6FzDVWaEEDJLy1ZljH6o/Vmgdxo9JDDb7VAWw5br1s=;
        b=z15BQeUBB8VJb9yD2URB91vmkJHi2zOy3Q34XsHOPk0xk5wiDYl7tdaS4gsd+3N2T+
         fMYFFOFRh3dxoSEmiWempbG7aD9RfYjINgLwMfkhkTxhO/Itm+Mh5sFd3VGII8HUAWR4
         br9XJRJWbB8OcvgDNLmdwgl0H52zwg9lChy3GAEXZMtuAx8MRrjcuhnddLNlKvjRzEp2
         zQR3KB6jWakZURZ2hVfPGVPxo5sTSy8UD+WchIijFKZS/nzuW6Wvya7RtHfwZkMQci1W
         Q9JiRc/cmrkiwa3XOJcH5PtKJFX9S8yPk+nh5JwoGjzc4+VyqxHi1m/HLHN14yjSDWs3
         stog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=L6FzDVWaEEDJLy1ZljH6o/Vmgdxo9JDDb7VAWw5br1s=;
        b=j5zFV7l3A7JAvhwY+KtQiBx22abAb8qCXMLLJDs+uWyAcLgxruzdQznUb8jowDdrhh
         todx6SyTRwoonZCaKhysTKnqQCfN9r2M6O3d0ejmaAxIWuopOnKw4Y8+T+WHw44lrki5
         to//RJRDhnZIDIIgQdPWJXCLgHckty+NAFOgTN1yzac1Mkzvd9WmvW6Op3lcDA7vLIr0
         C15hKBuJ1T2u8ZsLT6IidGiHJzNPsuLtxG7ZCXrfiNHG5iZSlOJD6ODT+plBPt3yd1bE
         R7r9Hv1iKThdBzstzYKlpOst0++jOaDls/eaqyCBFDwwNtnzNTzQ7FapDR1UvBy1vs8O
         4xuA==
X-Gm-Message-State: AOAM530LBSaPjcVC/hmUuCmdAxiSlMMpMc6e7IkCuGZoufUBmLOE9V4T
        NJ+JDkO33EGNBtA7fq+XYbOMsw==
X-Google-Smtp-Source: ABdhPJx4ipeZUtiOJeZtJOpzaet9OUvA/7DVVO4eH4Qnc3/pg38U0sy5ZrThSKDxr751NTEqfXQ9qQ==
X-Received: by 2002:a1c:7413:: with SMTP id p19mr6006695wmc.39.1611572921919;
        Mon, 25 Jan 2021 03:08:41 -0800 (PST)
Received: from localhost.localdomain ([2001:1715:4e26:a7e0:116c:c27a:3e7f:5eaf])
        by smtp.gmail.com with ESMTPSA id u6sm16636014wro.75.2021.01.25.03.08.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jan 2021 03:08:41 -0800 (PST)
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
Subject: [PATCH v11 00/10] iommu: I/O page faults for SMMUv3
Date:   Mon, 25 Jan 2021 12:06:41 +0100
Message-Id: <20210125110650.3232195-1-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Add stall support to the SMMUv3, along with a common I/O Page Fault
handler.

This version fixes a typo introduced in v10 [1] and adds review tags
(thanks!) You can find the range diff for v10->v11 below.

[1] https://lore.kernel.org/linux-iommu/20210121123623.2060416-1-jean-philippe@linaro.org/

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
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   | 349 +++++++++++--
 drivers/iommu/intel/iommu.c                   |  11 +-
 drivers/iommu/io-pgfault.c                    | 461 ++++++++++++++++++
 drivers/iommu/of_iommu.c                      |   5 -
 drivers/misc/uacce/uacce.c                    |  39 +-
 12 files changed, 1019 insertions(+), 74 deletions(-)
 create mode 100644 drivers/iommu/io-pgfault.c


-- 
 @@ drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c: static void arm_smmu_release_device(struct device *dev)
    master = dev_iommu_priv_get(dev);
-   WARN_ON(arm_smmu_master_sva_enabled(master));
-+  iopf_queue_remove_device(master->smmu->evtq.iopf, dev);
+-  WARN_ON(arm_smmu_master_sva_enabled(master));
++  if (WARN_ON(arm_smmu_master_sva_enabled(master)))
++          iopf_queue_remove_device(master->smmu->evtq.iopf, dev);
    arm_smmu_detach_dev(master);
    arm_smmu_disable_pasid(master);
    arm_smmu_remove_master(master);
@@ drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c: static struct iommu_ops arm_smmu_op
    .pgsize_bitmap          = -1UL, /* Restricted during device attach */
  };
  
-@@ drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c: static int arm_smmu_cmdq_init(struct arm_smmu_device *smmu)
- static int arm_smmu_init_queues(struct arm_smmu_device *smmu)
- {
-   int ret;
-+  bool sva = smmu->features & ARM_SMMU_FEAT_STALLS;
- 
-   /* cmdq */
-   ret = arm_smmu_init_one_queue(smmu, &smmu->cmdq.q, ARM_SMMU_CMDQ_PROD,
 @@ drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c: static int arm_smmu_init_queues(struct arm_smmu_device *smmu)
    if (ret)
            return ret;
  
-+  if (sva && smmu->features & ARM_SMMU_FEAT_STALLS) {
++  if ((smmu->features & ARM_SMMU_FEAT_SVA) &&
++      (smmu->features & ARM_SMMU_FEAT_STALLS)) {
 +          smmu->evtq.iopf = iopf_queue_alloc(dev_name(smmu->dev));
 +          if (!smmu->evtq.iopf)
 +                  return -ENOMEM;

