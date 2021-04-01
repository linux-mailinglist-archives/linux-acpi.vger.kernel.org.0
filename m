Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DE87351DBE
	for <lists+linux-acpi@lfdr.de>; Thu,  1 Apr 2021 20:49:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235131AbhDASbu (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 1 Apr 2021 14:31:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236843AbhDASSk (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 1 Apr 2021 14:18:40 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBD9DC02D54F
        for <linux-acpi@vger.kernel.org>; Thu,  1 Apr 2021 08:48:14 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id u5-20020a7bcb050000b029010e9316b9d5so1142316wmj.2
        for <linux-acpi@vger.kernel.org>; Thu, 01 Apr 2021 08:48:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/Rqc2+6jggGKUT8/YAMcYP1juQODWAVCbo22wEIJOzg=;
        b=XkGSJlAzvgm3OxpT3lKOGiYqyTKylXidnXzbEQbvCvOrv1JBib0O+woGdI2pYUzsPs
         YjutU8dIM58r6FFx5bM2W2CM8K58JHvsTmyfbNYnImC1dY0paQzXYNdCjmKlXRsfcDgm
         Stf3yokmr8D+AOKQTwhqLBhdA0cqvjMkZ8pnxKFNO9KfoiXWpAwOaB93U9kQ38CRvfBy
         lt6wN4kmg7pd0aOwB5QGaod87brX+NBDUPbTIFW4J9utStdorl8ftkrcD/5bzDb+OPvd
         /qs2jGX46hUvuBn78thXYzyOco0wVORhvSd0yrP8wSpA/H0+dQsvw20J7EYNcXSEAnCZ
         /Xyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/Rqc2+6jggGKUT8/YAMcYP1juQODWAVCbo22wEIJOzg=;
        b=T2OcJtTGUCz/y1YYzTgN15jI1oXgz6BEkIvs27jiuekAccIv+S7A9Y/bwcSQ6sMUnQ
         +i3hvFKKXVNHQC+q6r3kXo5OpwipSv1+tW//zM7RannqIJZoUAf/NAMR0SV++S0DkmmA
         /zlI/ZuAO4A7TS9FABgBjDIqKyRBh1y3J4ftXKqLzmLvWMEOXlT+IEZiq6aY4JOCEQq4
         aq+iIqxcNrY3WIfSajS1rk4fcu/I2PNE9HkSoAlP1QFxWCs1CIAQnbpXZLbW3FxDGqsi
         yIWQESgeWez3KVZ/hSRoZfSEKEkrRws9YOTnFF1erebNo2m76uPT811Tr/2ucShBXnIp
         s76Q==
X-Gm-Message-State: AOAM5323O3JPTs3BgaNY5fqqEQIl6sT0rm5v5JfcghjvvycJP8wwjPct
        5w2fINs0BLBsj6rbK8n2tuoovQ==
X-Google-Smtp-Source: ABdhPJxN1jziZ4oZxiGvM5oGVMwG6ILgdWAeLhxA89O6osCdjCFgqJR9jExdn0MmdGKlbB9xdLtK0w==
X-Received: by 2002:a1c:23c2:: with SMTP id j185mr8637858wmj.54.1617292093384;
        Thu, 01 Apr 2021 08:48:13 -0700 (PDT)
Received: from localhost.localdomain ([2001:1715:4e26:a7e0:116c:c27a:3e7f:5eaf])
        by smtp.gmail.com with ESMTPSA id y8sm8722505wmi.46.2021.04.01.08.48.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Apr 2021 08:48:13 -0700 (PDT)
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
Subject: [PATCH v14 00/10] iommu: I/O page faults for SMMUv3
Date:   Thu,  1 Apr 2021 17:47:09 +0200
Message-Id: <20210401154718.307519-1-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Add stall support to the SMMUv3 driver, along with a common I/O Page
Fault handler.

Since [v13] I added review and ack tags (Thanks!), and a lockdep_assert.
It would be good to have all of it in v5.13, since patch 10 introduces
the first user for the IOPF interface from patch 6.  But if that's not
possible, please pick patches 1-6 so the Vt-d driver can start using
them.

[v13] https://lore.kernel.org/linux-iommu/20210302092644.2553014-1-jean-philippe@linaro.org/

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
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   | 355 ++++++++++++--
 drivers/iommu/intel/iommu.c                   |  11 +-
 drivers/iommu/io-pgfault.c                    | 461 ++++++++++++++++++
 drivers/iommu/of_iommu.c                      |   5 -
 drivers/misc/uacce/uacce.c                    |  39 +-
 12 files changed, 1025 insertions(+), 74 deletions(-)
 create mode 100644 drivers/iommu/io-pgfault.c

-- 
2.31.1

