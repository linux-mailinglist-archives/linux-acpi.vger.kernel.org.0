Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55CB52EF463
	for <lists+linux-acpi@lfdr.de>; Fri,  8 Jan 2021 16:04:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727651AbhAHPDK (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 8 Jan 2021 10:03:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727629AbhAHPDJ (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 8 Jan 2021 10:03:09 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EA74C0612EA
        for <linux-acpi@vger.kernel.org>; Fri,  8 Jan 2021 07:02:29 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id y23so8676981wmi.1
        for <linux-acpi@vger.kernel.org>; Fri, 08 Jan 2021 07:02:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9LxmaGFsoHsyiW4BIZVKPeyt3J9qr8cLi2zlatmsMp0=;
        b=KZFJdK1uOxU13tuF7A1+PLi2EH+/cnbUqwMv9T1ACMWomHP3A/P/Bpr6aDWS7/LBsg
         r7hV7S/g38e3vl2vdXsDzcl/HJsUBPgyWSl8s0Ir3r9LXLbpYkYjy4j258sT+zyf5NX/
         jenNm/Spg8b6eOUDml2FPQZPKN0KaobawaJTgkpigzohy3P5Rob0HL6m+DZFOsAs02uX
         65SuIJt6sFoG+R5MlglHdQQyE/F/iMPD4WRur8w5d9ORqq2DDjhtde80HUrtnc5RQdbN
         TH2UcgGb6BE5Xo1XAAx3ZRRHtt3w5YKmWY79M9kgcluqs5Wo7EFME/KmHGx6Wbv2n4vw
         cQAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9LxmaGFsoHsyiW4BIZVKPeyt3J9qr8cLi2zlatmsMp0=;
        b=UepQJ7IbfrbKpEVzd865wgXGHSNU+SHjarq9Ng+qaYUiBaX2ZN8E2X+jWB26/0NAUS
         cyC6IWq1rkT1wcf/dClUl8Sz+k6A2ItEvTCDmNOzO3staSxZ8ZK2y6CfzHU42/a+k1e3
         ubFU6aFth8pOJx1gpyLRJgunl2GNneFiasMgnLrtve+TPkcjNK9Ww1BAXaZL5xqNmGtd
         XsuF1dTD7WlnDTUFsiFZCMNqnLWk7uYe9d1igv687XZYlzrw1uvSLTO/cWdmikgHUgpp
         dEIJkDezoYke/GPttyBUFIpvZTfxapT/JsIGGErW8fe3j/k4DCzo8bC7sM5ugNwf3Kef
         dDmA==
X-Gm-Message-State: AOAM531RXjntYThGyNCqZSMFyZnSsOYxKFNABn6ePp2PWQYqGUtFZM/h
        ONaJCddNOFmlkx/sOhPi4NbSYg==
X-Google-Smtp-Source: ABdhPJwryieGz+IIpJFdRcitNF3mYDnUq00efz6rzlTllf+zarGcbHI5biYr33cJ6dUnp49vkxQ9ZQ==
X-Received: by 2002:a1c:e10b:: with SMTP id y11mr3515616wmg.65.1610118147821;
        Fri, 08 Jan 2021 07:02:27 -0800 (PST)
Received: from localhost.localdomain ([2001:1715:4e26:a7e0:116c:c27a:3e7f:5eaf])
        by smtp.gmail.com with ESMTPSA id s13sm14258464wra.53.2021.01.08.07.02.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Jan 2021 07:02:26 -0800 (PST)
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
Subject: [PATCH v9 00/10] iommu: I/O page faults for SMMUv3
Date:   Fri,  8 Jan 2021 15:52:08 +0100
Message-Id: <20210108145217.2254447-1-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Add stall support to the SMMUv3, along with a common I/O Page Fault
handler.

Changes since v8 [1]:
* Added patches 1 and 2 which aren't strictly related to IOPF but need to
  be applied in order - 8 depends on 2 which depends on 1. Patch 2 moves
  pasid-num-bits to a device property, following Robin's comment on v8.
* Patches 3-5 extract the IOPF feature from the SVA one, to support SVA
  implementations that handle I/O page faults through the device driver
  rather than the IOMMU driver [2]
* Use device properties for dma-can-stall, instead of a special fwspec
  member.
* Dropped PRI support for now, since it doesn't seem to be available in
  hardware and adds some complexity.
* Had to drop some Acks and Tested tags unfortunately, due to code
  changes.

As usual, you can get the latest SVA patches from
http://jpbrucker.net/git/linux sva/current

[1] https://lore.kernel.org/linux-iommu/20201112125519.3987595-1-jean-philippe@linaro.org/
[2] https://lore.kernel.org/linux-iommu/BY5PR12MB3764F5D07E8EC48327E39C86B3C60@BY5PR12MB3764.namprd12.prod.outlook.com/

Jean-Philippe Brucker (10):
  iommu: Remove obsolete comment
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
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h   |  74 ++-
 drivers/iommu/iommu-sva-lib.h                 |  53 ++
 include/linux/iommu.h                         |  25 +-
 drivers/acpi/arm64/iort.c                     |  15 +-
 .../iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c   |  70 ++-
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   | 354 ++++++++++++--
 drivers/iommu/intel/iommu.c                   |  11 +-
 drivers/iommu/io-pgfault.c                    | 462 ++++++++++++++++++
 drivers/iommu/of_iommu.c                      |   5 -
 drivers/misc/uacce/uacce.c                    |  32 +-
 12 files changed, 1046 insertions(+), 74 deletions(-)
 create mode 100644 drivers/iommu/io-pgfault.c

-- 
2.29.2

