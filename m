Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E69863CB476
	for <lists+linux-acpi@lfdr.de>; Fri, 16 Jul 2021 10:43:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237576AbhGPIhm (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 16 Jul 2021 04:37:42 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:3417 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237980AbhGPIhm (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 16 Jul 2021 04:37:42 -0400
Received: from fraeml713-chm.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4GR44z0lzMz6H7Pb;
        Fri, 16 Jul 2021 16:23:31 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml713-chm.china.huawei.com (10.206.15.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Fri, 16 Jul 2021 10:34:45 +0200
Received: from A2006125610.china.huawei.com (10.47.80.222) by
 lhreml710-chm.china.huawei.com (10.201.108.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Fri, 16 Jul 2021 09:34:38 +0100
From:   Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
To:     <linux-arm-kernel@lists.infradead.org>,
        <linux-acpi@vger.kernel.org>, <iommu@lists.linux-foundation.org>
CC:     <linuxarm@huawei.com>, <lorenzo.pieralisi@arm.com>,
        <joro@8bytes.org>, <robin.murphy@arm.com>,
        <wanghuiqiang@huawei.com>, <guohanjun@huawei.com>,
        <steven.price@arm.com>, <Sami.Mujawar@arm.com>,
        <jon@solid-run.com>, <eric.auger@redhat.com>,
        <yangyicong@huawei.com>
Subject: [PATCH v6 0/9] ACPI/IORT: Support for IORT RMR node
Date:   Fri, 16 Jul 2021 09:34:33 +0100
Message-ID: <20210716083442.1708-1-shameerali.kolothum.thodi@huawei.com>
X-Mailer: git-send-email 2.12.0.windows.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.47.80.222]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi,

Major Changes from v5:
- Addressed comments from Robin & Lorenzo.
  : Moved iort_parse_rmr() to acpi_iort_init() from
    iort_init_platform_devices().
  : Removed use of struct iort_rmr_entry during the initial
    parse. Using struct iommu_resv_region instead.
  : Report RMR address alignment and overlap errors, but continue.
  : Reworked arm_smmu_init_bypass_stes() (patch # 6).
- Updated SMMUv2 bypass SMR code. Thanks to Jon N (patch #8).
- Set IOMMU protection flags(IOMMU_CACHE, IOMMU_MMIO) based
  on Type of RMR region. Suggested by Jon N.

Sanity tested on a HiSilicon D06(SMMUv3). Further testing and
feedback is greatly appreciated.

Thanks,
Shameer

------
v4 --> v5
 -Added a fw_data union to struct iommu_resv_region and removed
  struct iommu_rmr (Based on comments from Joerg/Robin).
 -Added iommu_put_rmrs() to release mem.
 -Thanks to Steve for verifying on SMMUv2, but not added the Tested-by
  yet because of the above changes.

v3 -->v4
-Included the SMMUv2 SMR bypass install changes suggested by
 Steve(patch #7)
-As per Robin's comments, RMR reserve implementation is now
 more generic  (patch #8) and dropped v3 patches 8 and 10.
-Rebase to 5.13-rc1

RFC v2 --> v3
 -Dropped RFC tag as the ACPICA header changes are now ready to be
  part of 5.13[0]. But this series still has a dependency on that patch.
 -Added IORT E.b related changes(node flags, _DSM function 5 checks for
  PCIe).
 -Changed RMR to stream id mapping from M:N to M:1 as per the spec and
  discussion here[1].
 -Last two patches add support for SMMUv2(Thanks to Jon Nettleton!)
------

Jon Nettleton (1):
  iommu/arm-smmu: Get associated RMR info and install bypass SMR

Shameer Kolothum (8):
  iommu: Introduce a union to struct iommu_resv_region
  ACPI/IORT: Add support for RMR node parsing
  iommu/dma: Introduce generic helper to retrieve RMR info
  ACPI/IORT: Add a helper to retrieve RMR memory regions
  iommu/arm-smmu-v3: Introduce strtab init helper
  iommu/arm-smmu-v3: Refactor arm_smmu_init_bypass_stes() to force
    bypass
  iommu/arm-smmu-v3: Get associated RMR info and install bypass STE
  iommu/dma: Reserve any RMR regions associated with a dev

 drivers/acpi/arm64/iort.c                   | 172 +++++++++++++++++++-
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c |  76 +++++++--
 drivers/iommu/arm/arm-smmu/arm-smmu.c       |  48 ++++++
 drivers/iommu/dma-iommu.c                   |  89 +++++++++-
 include/linux/acpi_iort.h                   |   7 +
 include/linux/dma-iommu.h                   |  13 ++
 include/linux/iommu.h                       |  11 ++
 7 files changed, 393 insertions(+), 23 deletions(-)

-- 
2.17.1

