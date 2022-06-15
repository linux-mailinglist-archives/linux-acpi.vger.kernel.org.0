Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCD4354C587
	for <lists+linux-acpi@lfdr.de>; Wed, 15 Jun 2022 12:11:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243109AbiFOKLh (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 15 Jun 2022 06:11:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243110AbiFOKLg (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 15 Jun 2022 06:11:36 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 796DB4AE38
        for <linux-acpi@vger.kernel.org>; Wed, 15 Jun 2022 03:11:34 -0700 (PDT)
Received: from fraeml739-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4LNLb94KqMz6H8X3;
        Wed, 15 Jun 2022 18:07:49 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml739-chm.china.huawei.com (10.206.15.220) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 15 Jun 2022 12:11:31 +0200
Received: from A2006125610.china.huawei.com (10.202.227.178) by
 lhreml710-chm.china.huawei.com (10.201.108.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 15 Jun 2022 11:11:24 +0100
From:   Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
To:     <linux-arm-kernel@lists.infradead.org>,
        <linux-acpi@vger.kernel.org>, <iommu@lists.linux-foundation.org>
CC:     <linuxarm@huawei.com>, <lorenzo.pieralisi@arm.com>,
        <joro@8bytes.org>, <robin.murphy@arm.com>, <will@kernel.org>,
        <wanghuiqiang@huawei.com>, <guohanjun@huawei.com>,
        <steven.price@arm.com>, <Sami.Mujawar@arm.com>,
        <jon@solid-run.com>, <eric.auger@redhat.com>,
        <laurentiu.tudor@nxp.com>, <hch@infradead.org>
Subject: [PATCH v13 0/9] ACPI/IORT: Support for IORT RMR node
Date:   Wed, 15 Jun 2022 11:10:35 +0100
Message-ID: <20220615101044.1972-1-shameerali.kolothum.thodi@huawei.com>
X-Mailer: git-send-email 2.12.0.windows.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.202.227.178]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=0.4 required=5.0 tests=AC_FROM_MANY_DOTS,BAYES_00,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi

v12 --> v13
  -No changes. Rebased to 5.19-rc1.
  -Picked up tags received from Laurentiu, Hanjun and Will. Thanks!.

Thanks,
Shameer

From old:
We have faced issues with 3408iMR RAID controller cards which
fail to boot when SMMU is enabled. This is because these
controllers make use of host memory for various caching related
purposes and when SMMU is enabled the iMR firmware fails to
access these memory regions as there is no mapping for them.
IORT RMR provides a way for UEFI to describe and report these
memory regions so that the kernel can make a unity mapping for
these in SMMU.

Change History:

v11 --> v12
  -Minor fix in patch #4 to address the issue reported by the kernel test robot.
  -Added R-by tags by Christoph(patch #1) and Lorenzo(patch #4).
  -Added T-by from Steve to all relevant patches. Many thanks!.

v10 --> v11
 -Addressed Christoph's comments. We now have a  callback to 
  struct iommu_resv_region to free all related memory and also dropped
  the FW specific union and now has a container struct iommu_iort_rmr_data.
  See patches #1 & #4
 -Added R-by from Christoph.
 -Dropped R-by from Lorenzo for patches #4 & #5 due to the above changes.
 -Also dropped T-by from Steve and Laurentiu. Many thanks for your test
  efforts. I have done basic sanity testing on my platform but please
  do it again at your end.

v9 --> v10
 - Dropped patch #1 ("Add temporary RMR node flag definitions") since
   the ACPICA header updates patch is now in the mailing list
 - Based on the suggestion from Christoph, introduced a 
   resv_region_free_fw_data() callback in struct iommu_resv_region and
   used that to free RMR specific memory allocations.

v8 --> v9
 - Adressed comments from Robin on interfaces.
 - Addressed comments from Lorenzo.

v7 --> v8
  - Patch #1 has temp definitions for RMR related changes till
    the ACPICA header changes are part of kernel.
  - No early parsing of RMR node info and is only parsed at the
    time of use.
  - Changes to the RMR get/put API format compared to the
    previous version.
  - Support for RMR descriptor shared by multiple stream IDs.

v6 --> v7
 -fix pointed out by Steve to the SMMUv2 SMR bypass install in patch #8.

v5 --> v6
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
 more generic  (patch #8) and dropped v3 patches 8 and 10.
-Rebase to 5.13-rc1

RFC v2 --> v3
 -Dropped RFC tag as the ACPICA header changes are now ready to be
  part of 5.13[0]. But this series still has a dependency on that patch.
 -Added IORT E.b related changes(node flags, _DSM function 5 checks for
  PCIe).
 -Changed RMR to stream id mapping from M:N to M:1 as per the spec and
  discussion here[1].
 -Last two patches add support for SMMUv2(Thanks to Jon Nettleton!)

Jon Nettleton (1):
  iommu/arm-smmu: Get associated RMR info and install bypass SMR

Shameer Kolothum (8):
  iommu: Introduce a callback to struct iommu_resv_region
  ACPI/IORT: Make iort_iommu_msi_get_resv_regions() return void
  ACPI/IORT: Provide a generic helper to retrieve reserve regions
  ACPI/IORT: Add support to retrieve IORT RMR reserved regions
  ACPI/IORT: Add a helper to retrieve RMR info directly
  iommu/arm-smmu-v3: Introduce strtab init helper
  iommu/arm-smmu-v3: Refactor arm_smmu_init_bypass_stes() to force
    bypass
  iommu/arm-smmu-v3: Get associated RMR info and install bypass STE

 drivers/acpi/arm64/iort.c                   | 360 ++++++++++++++++++--
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c |  78 ++++-
 drivers/iommu/arm/arm-smmu/arm-smmu.c       |  52 +++
 drivers/iommu/dma-iommu.c                   |   2 +-
 drivers/iommu/iommu.c                       |  16 +-
 include/linux/acpi_iort.h                   |  14 +-
 include/linux/iommu.h                       |  10 +
 7 files changed, 486 insertions(+), 46 deletions(-)

-- 
2.25.1

