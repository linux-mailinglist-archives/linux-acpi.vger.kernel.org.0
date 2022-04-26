Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53A0A50FC22
	for <lists+linux-acpi@lfdr.de>; Tue, 26 Apr 2022 13:43:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349600AbiDZLqs convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-acpi@lfdr.de>); Tue, 26 Apr 2022 07:46:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349605AbiDZLqq (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 26 Apr 2022 07:46:46 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20F423C497
        for <linux-acpi@vger.kernel.org>; Tue, 26 Apr 2022 04:43:36 -0700 (PDT)
Received: from dggpemm500021.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Kng4Q1L81zgYqW;
        Tue, 26 Apr 2022 19:43:18 +0800 (CST)
Received: from dggpemm100002.china.huawei.com (7.185.36.179) by
 dggpemm500021.china.huawei.com (7.185.36.109) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 26 Apr 2022 19:43:35 +0800
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 dggpemm100002.china.huawei.com (7.185.36.179) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 26 Apr 2022 19:43:33 +0800
Received: from lhreml710-chm.china.huawei.com ([169.254.81.184]) by
 lhreml710-chm.china.huawei.com ([169.254.81.184]) with mapi id
 15.01.2375.024; Tue, 26 Apr 2022 12:43:32 +0100
From:   Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
To:     kernel test robot <lkp@intel.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>
CC:     "llvm@lists.linux.dev" <llvm@lists.linux.dev>,
        "kbuild-all@lists.01.org" <kbuild-all@lists.01.org>,
        Linuxarm <linuxarm@huawei.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
        "will@kernel.org" <will@kernel.org>,
        wanghuiqiang <wanghuiqiang@huawei.com>,
        "Guohanjun (Hanjun Guo)" <guohanjun@huawei.com>,
        "steven.price@arm.com" <steven.price@arm.com>,
        "Sami.Mujawar@arm.com" <Sami.Mujawar@arm.com>,
        "jon@solid-run.com" <jon@solid-run.com>,
        "eric.auger@redhat.com" <eric.auger@redhat.com>,
        "laurentiu.tudor@nxp.com" <laurentiu.tudor@nxp.com>,
        "hch@infradead.org" <hch@infradead.org>
Subject: RE: [PATCH v11 4/9] ACPI/IORT: Add support to retrieve IORT RMR
 reserved regions
Thread-Topic: [PATCH v11 4/9] ACPI/IORT: Add support to retrieve IORT RMR
 reserved regions
Thread-Index: AQHYVmZKfsv4Ue0JXEuZq1FbubftY6z9MaGAgATjIbA=
Date:   Tue, 26 Apr 2022 11:43:31 +0000
Message-ID: <ada9f0011e544fc5be9b61b7700f44d5@huawei.com>
References: <20220422162907.1276-5-shameerali.kolothum.thodi@huawei.com>
 <202204231737.0jkKpxZk-lkp@intel.com>
In-Reply-To: <202204231737.0jkKpxZk-lkp@intel.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.202.227.178]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org



> -----Original Message-----
> From: kernel test robot [mailto:lkp@intel.com]
> Sent: 23 April 2022 10:51
> To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>;
> linux-arm-kernel@lists.infradead.org; linux-acpi@vger.kernel.org;
> iommu@lists.linux-foundation.org
> Cc: llvm@lists.linux.dev; kbuild-all@lists.01.org; Linuxarm
> <linuxarm@huawei.com>; lorenzo.pieralisi@arm.com; joro@8bytes.org;
> robin.murphy@arm.com; will@kernel.org; wanghuiqiang
> <wanghuiqiang@huawei.com>; Guohanjun (Hanjun Guo)
> <guohanjun@huawei.com>; steven.price@arm.com; Sami.Mujawar@arm.com;
> jon@solid-run.com; eric.auger@redhat.com; laurentiu.tudor@nxp.com;
> hch@infradead.org
> Subject: Re: [PATCH v11 4/9] ACPI/IORT: Add support to retrieve IORT RMR
> reserved regions
> 

[...]
 
> >> drivers/acpi/arm64/iort.c:801:29: warning: no previous prototype for
> function 'iort_rmr_alloc' [-Wmissing-prototypes]
>    struct iommu_iort_rmr_data *iort_rmr_alloc(struct acpi_iort_rmr_desc
> *rmr_desc,
>                                ^
>    drivers/acpi/arm64/iort.c:801:1: note: declare 'static' if the function is not
> intended to be used outside of this translation unit
>    struct iommu_iort_rmr_data *iort_rmr_alloc(struct acpi_iort_rmr_desc
> *rmr_desc,

Oops..missed the 'static' here. The rest of the warnings are because of the dependency
with ACPICA header patch here[1].

Hi Robin/Lorenzo,

I am planning to send out an updated series soon with that 'static' added and the R-by
tag received for patch #1 from Christoph. Appreciate if you can take a look and let me 
know if you have any further comments on this series.

Thanks,
Shameer

[1] https://lore.kernel.org/all/44610361.fMDQidcC6G@kreacher/


>    ^
>    static
>    drivers/acpi/arm64/iort.c:896:20: error: use of undeclared identifier
> 'ACPI_IORT_RMR_REMAP_PERMITTED'
>                    if (rmr->flags & ACPI_IORT_RMR_REMAP_PERMITTED)
>                                     ^
>    drivers/acpi/arm64/iort.c:901:20: error: use of undeclared identifier
> 'ACPI_IORT_RMR_ACCESS_PRIVILEGE'
>                    if (rmr->flags & ACPI_IORT_RMR_ACCESS_PRIVILEGE)
>                                     ^
>    drivers/acpi/arm64/iort.c:905:7: error: call to undeclared function
> 'ACPI_IORT_RMR_ACCESS_ATTRIBUTES'; ISO C99 and later do not support
> implicit function declarations [-Wimplicit-function-declaration]
>                    if (ACPI_IORT_RMR_ACCESS_ATTRIBUTES(rmr->flags) <=
>                        ^
>    drivers/acpi/arm64/iort.c:906:5: error: use of undeclared identifier
> 'ACPI_IORT_RMR_ATTR_DEVICE_GRE'
>                                    ACPI_IORT_RMR_ATTR_DEVICE_GRE)
>                                    ^
>    drivers/acpi/arm64/iort.c:909:5: error: use of undeclared identifier
> 'ACPI_IORT_RMR_ATTR_NORMAL_IWB_OWB'
> 
> ACPI_IORT_RMR_ATTR_NORMAL_IWB_OWB)
>                                    ^
>    1 warning and 5 errors generated.
> 
> 
> vim +/iort_rmr_alloc +801 drivers/acpi/arm64/iort.c
> 
>    800
>  > 801	struct iommu_iort_rmr_data *iort_rmr_alloc(struct
> acpi_iort_rmr_desc *rmr_desc,
>    802						   int prot, enum iommu_resv_type type,
>    803						   u32 *sids, u32 num_sids)
>    804	{
>    805		struct iommu_iort_rmr_data *rmr_data;
>    806		struct iommu_resv_region *region;
>    807		u32 *sids_copy;
>    808		u64 addr = rmr_desc->base_address, size = rmr_desc->length;
>    809
>    810		rmr_data = kmalloc(sizeof(*rmr_data), GFP_KERNEL);
>    811		if (!rmr_data)
>    812			return NULL;
>    813
>    814		/* Create a copy of SIDs array to associate with this rmr_data */
>    815		sids_copy = kmemdup(sids, num_sids * sizeof(*sids),
> GFP_KERNEL);
>    816		if (!sids_copy) {
>    817			kfree(rmr_data);
>    818			return NULL;
>    819		}
>    820		rmr_data->sids = sids_copy;
>    821		rmr_data->num_sids = num_sids;
>    822
>    823		if (!IS_ALIGNED(addr, SZ_64K) || !IS_ALIGNED(size, SZ_64K)) {
>    824			/* PAGE align base addr and size */
>    825			addr &= PAGE_MASK;
>    826			size = PAGE_ALIGN(size +
> offset_in_page(rmr_desc->base_address));
>    827
>    828			pr_err(FW_BUG "RMR descriptor[0x%llx - 0x%llx] not
> aligned to 64K, continue with [0x%llx - 0x%llx]\n",
>    829			       rmr_desc->base_address,
>    830			       rmr_desc->base_address + rmr_desc->length - 1,
>    831			       addr, addr + size - 1);
>    832		}
>    833
>    834		region = &rmr_data->rr;
>    835		INIT_LIST_HEAD(&region->list);
>    836		region->start = addr;
>    837		region->length = size;
>    838		region->prot = prot;
>    839		region->type = type;
>    840		region->free = iort_rmr_free;
>    841
>    842		return rmr_data;
>    843	}
>    844
> 
> --
> 0-DAY CI Kernel Test Service
> https://01.org/lkp
