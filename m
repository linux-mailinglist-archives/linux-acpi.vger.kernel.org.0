Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA60232A4C1
	for <lists+linux-acpi@lfdr.de>; Tue,  2 Mar 2021 16:47:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383250AbhCBLPv (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 2 Mar 2021 06:15:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239616AbhCBJgW (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 2 Mar 2021 04:36:22 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC55DC06178B
        for <linux-acpi@vger.kernel.org>; Tue,  2 Mar 2021 01:35:31 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id a18so10886501wrc.13
        for <linux-acpi@vger.kernel.org>; Tue, 02 Mar 2021 01:35:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cEvh5d2SHvxkSF+1irchEvrHiYiFzIPFtl5KjBbhkiY=;
        b=e0QdvPzBHHsEWw8yEUV63Abhpos9MC8ghOLDX4KpBWQHX7ucYQLT1YohHplRdd1zWv
         MsXtxpCExw1/mrCBDAuhbSb0Ki8sJDYCXMYOlfkPnS1TSu+HOTMXh+yBivoQUwNrMJ8L
         x3uhIY9nhxSRtqRnBJ+Fz7azE098RqmzW+feKSdcNSMY0Rb+J/B+sbXlblnOwArExQ3Q
         OTnGY6UWnuczU+CPWx9NZyIBzqwmumm2H9sLU8YvwZ9l3OBEewLY8qAVSXfZKnkF0UwU
         nT8CMx0ljrIjGklCr2zkJ2uHjWXnXJTEUgnp6WQMmNp4lSPQHnUsuus8J0kxsBGoSeub
         cuRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cEvh5d2SHvxkSF+1irchEvrHiYiFzIPFtl5KjBbhkiY=;
        b=p6FEHEFCM+BJd2+vskeORfa6fJ/wSSZR/yp9Rhljxm4MI+fWNFm4zzKrv1+8NyGjlR
         JD2J/ztd/imvcR2Ja/ro7L13O++utVnsO8G5DlaL4i6kXayNpbSC87Oh0UsxjfVt6Jb1
         TdLMoWFIdbcRqemitFbkC2Ak88eNwfApAGX4mlRv1yAhLiHWQyTzUF9dmXGTcTfu8pPR
         jRyeZ5lF1X59d2xGbz2D/C91daUTJfMwRG4UK6lEwDL3w79z9aFj8kO0Za0DZrhf4+x7
         uRfDbUi+OQ3ZRvLWgK4/r4adazYQZcsWIWGJcTRJv2G6pgVkNhbcebez2Jrf/eQpmDey
         GMKQ==
X-Gm-Message-State: AOAM531XmOirLRNCPWibL2HAY9BVBs9OwyBNdQCwdQ2OYZGQz0Y5iW1l
        0+XTLENbQsI7EffGOCeQJoSrXw==
X-Google-Smtp-Source: ABdhPJzwD2G5q6rP9T+vUtD3KyAyfU1qRsMeo52c3TFT0pOxMNOJrhtlwKkPcLVRuwoKj88VYCWBtg==
X-Received: by 2002:adf:ef08:: with SMTP id e8mr22098078wro.200.1614677730353;
        Tue, 02 Mar 2021 01:35:30 -0800 (PST)
Received: from localhost.localdomain ([2001:1715:4e26:a7e0:116c:c27a:3e7f:5eaf])
        by smtp.gmail.com with ESMTPSA id w131sm1963818wmb.8.2021.03.02.01.35.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Mar 2021 01:35:29 -0800 (PST)
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
Subject: [PATCH v13 00/10] iommu: I/O page faults for SMMUv3
Date:   Tue,  2 Mar 2021 10:26:36 +0100
Message-Id: <20210302092644.2553014-1-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.30.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Add stall support to the SMMUv3 driver, along with a common I/O Page
Fault handler.

Since v12 [1]:
* Fixed failure path of arm_smmu_insert_master(), in patch 07 (Keqian
  Zhu)
* In arm_smmu_handle_evt(), patch 10, don't report IPA field on stage-1
  faults, and report accurate fault reason (Eric Auger)
* Fix possible use-after-free in arm_smmu_handle_evt(), patch 10: if a
  master is removed while we handle its events, we could in theory
  dereference a freed master struct. Hold streams_mutex while using a
  master struct obtained with arm_smmu_find_master().


Future work regarding IOPF:
* Keep stall disabled by default, only enable it per CD when drivers
  request it [2][3].
* Add PRI support to SMMUv3.
* Route all recoverable faults through io-pgfault.c, so we can track
  partial faults better [4].
* Nested IOPF [5].

[1] https://lore.kernel.org/linux-iommu/20210127154322.3959196-1-jean-philippe@linaro.org/
[2] https://lore.kernel.org/linux-iommu/22fa4120-eadf-20d5-0d0a-9935aa0f1fb5@hisilicon.com/
[3] https://lore.kernel.org/linux-iommu/YAhui7UOw7743shI@myrica/
[4] https://lore.kernel.org/kvm/YB0f5Yno9frihQq4@myrica/
[5] https://lore.kernel.org/linux-acpi/MWHPR11MB188653AF6EFA0E55DE17815F8CA40@MWHPR11MB1886.namprd11.prod.outlook.com/

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
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   | 354 ++++++++++++--
 drivers/iommu/intel/iommu.c                   |  11 +-
 drivers/iommu/io-pgfault.c                    | 461 ++++++++++++++++++
 drivers/iommu/of_iommu.c                      |   5 -
 drivers/misc/uacce/uacce.c                    |  39 +-
 12 files changed, 1024 insertions(+), 74 deletions(-)
 create mode 100644 drivers/iommu/io-pgfault.c

-- 
2.30.1

