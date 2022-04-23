Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5C6850C9D6
	for <lists+linux-acpi@lfdr.de>; Sat, 23 Apr 2022 14:15:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235393AbiDWMSG (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sat, 23 Apr 2022 08:18:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235385AbiDWMR6 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sat, 23 Apr 2022 08:17:58 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A9C41C7
        for <linux-acpi@vger.kernel.org>; Sat, 23 Apr 2022 05:15:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650716100; x=1682252100;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=54Pwo3VGf6Jw6AXUj1EVoQ33XD/JZntUqfjROph5OpA=;
  b=j3kt3pASXeSAZ5/3qz9lZzcT0cuazDhW9emR538EkJ952MJ1E/RvADmQ
   rNs61U6sMaWM7sybJ7xNDbHbqsmHRtHt6LQvKStkm2dVGOfFXwkvNCLZ5
   xkNSTzBHFLRen3atw3fJByNmhDHoB3nlIVG79vaUV0YVKnNJqgdqSFRZU
   Yh4Esns8yUs1L8bUr7i2vH/zu8t6n82/wbaOreIYFYCdZypbVb+6JjS/v
   +0+nfGxPebXmlwWAEpUUmvFthePYynSEeX9Xn11XDk2YjnoI+BVPK3EJ9
   wQaoAPOwImnSiGQoCenIHDFZZzphUbXJEUjGZrCt+uQImRvtdJ5Dd3a+n
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10324"; a="351336962"
X-IronPort-AV: E=Sophos;i="5.90,284,1643702400"; 
   d="scan'208";a="351336962"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2022 05:15:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,284,1643702400"; 
   d="scan'208";a="563411951"
Received: from lkp-server01.sh.intel.com (HELO dd58949a6e39) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 23 Apr 2022 05:14:55 -0700
Received: from kbuild by dd58949a6e39 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1niEf9-0000GR-9m;
        Sat, 23 Apr 2022 12:14:55 +0000
Date:   Sat, 23 Apr 2022 20:14:15 +0800
From:   kernel test robot <lkp@intel.com>
To:     Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
        linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org,
        iommu@lists.linux-foundation.org
Cc:     kbuild-all@lists.01.org, linuxarm@huawei.com,
        lorenzo.pieralisi@arm.com, joro@8bytes.org, robin.murphy@arm.com,
        will@kernel.org, wanghuiqiang@huawei.com, guohanjun@huawei.com,
        steven.price@arm.com, Sami.Mujawar@arm.com, jon@solid-run.com,
        eric.auger@redhat.com, laurentiu.tudor@nxp.com, hch@infradead.org
Subject: Re: [PATCH v11 4/9] ACPI/IORT: Add support to retrieve IORT RMR
 reserved regions
Message-ID: <202204232022.kmUBeE9L-lkp@intel.com>
References: <20220422162907.1276-5-shameerali.kolothum.thodi@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220422162907.1276-5-shameerali.kolothum.thodi@huawei.com>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Shameer,

I love your patch! Perhaps something to improve:

[auto build test WARNING on joro-iommu/next]
[also build test WARNING on rafael-pm/linux-next arm/for-next arm64/for-next/core soc/for-next linus/master v5.18-rc3 next-20220422]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Shameer-Kolothum/ACPI-IORT-Support-for-IORT-RMR-node/20220423-003822
base:   https://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git next
config: arm64-allyesconfig (https://download.01.org/0day-ci/archive/20220423/202204232022.kmUBeE9L-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/5b73fd681a27e2ad450bac28f8a81f4b35fe4d68
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Shameer-Kolothum/ACPI-IORT-Support-for-IORT-RMR-node/20220423-003822
        git checkout 5b73fd681a27e2ad450bac28f8a81f4b35fe4d68
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross W=1 O=build_dir ARCH=arm64 SHELL=/bin/bash drivers/acpi/arm64/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/acpi/arm64/iort.c:801:29: warning: no previous prototype for 'iort_rmr_alloc' [-Wmissing-prototypes]
     801 | struct iommu_iort_rmr_data *iort_rmr_alloc(struct acpi_iort_rmr_desc *rmr_desc,
         |                             ^~~~~~~~~~~~~~
   drivers/acpi/arm64/iort.c: In function 'iort_get_rmrs':
   drivers/acpi/arm64/iort.c:896:34: error: 'ACPI_IORT_RMR_REMAP_PERMITTED' undeclared (first use in this function)
     896 |                 if (rmr->flags & ACPI_IORT_RMR_REMAP_PERMITTED)
         |                                  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/acpi/arm64/iort.c:896:34: note: each undeclared identifier is reported only once for each function it appears in
   drivers/acpi/arm64/iort.c:901:34: error: 'ACPI_IORT_RMR_ACCESS_PRIVILEGE' undeclared (first use in this function)
     901 |                 if (rmr->flags & ACPI_IORT_RMR_ACCESS_PRIVILEGE)
         |                                  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/acpi/arm64/iort.c:905:21: error: implicit declaration of function 'ACPI_IORT_RMR_ACCESS_ATTRIBUTES'; did you mean 'ACPI_IORT_MF_ATTRIBUTES'? [-Werror=implicit-function-declaration]
     905 |                 if (ACPI_IORT_RMR_ACCESS_ATTRIBUTES(rmr->flags) <=
         |                     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
         |                     ACPI_IORT_MF_ATTRIBUTES
   drivers/acpi/arm64/iort.c:906:33: error: 'ACPI_IORT_RMR_ATTR_DEVICE_GRE' undeclared (first use in this function)
     906 |                                 ACPI_IORT_RMR_ATTR_DEVICE_GRE)
         |                                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/acpi/arm64/iort.c:909:33: error: 'ACPI_IORT_RMR_ATTR_NORMAL_IWB_OWB' undeclared (first use in this function)
     909 |                                 ACPI_IORT_RMR_ATTR_NORMAL_IWB_OWB)
         |                                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors


vim +/iort_rmr_alloc +801 drivers/acpi/arm64/iort.c

   800	
 > 801	struct iommu_iort_rmr_data *iort_rmr_alloc(struct acpi_iort_rmr_desc *rmr_desc,
   802						   int prot, enum iommu_resv_type type,
   803						   u32 *sids, u32 num_sids)
   804	{
   805		struct iommu_iort_rmr_data *rmr_data;
   806		struct iommu_resv_region *region;
   807		u32 *sids_copy;
   808		u64 addr = rmr_desc->base_address, size = rmr_desc->length;
   809	
   810		rmr_data = kmalloc(sizeof(*rmr_data), GFP_KERNEL);
   811		if (!rmr_data)
   812			return NULL;
   813	
   814		/* Create a copy of SIDs array to associate with this rmr_data */
   815		sids_copy = kmemdup(sids, num_sids * sizeof(*sids), GFP_KERNEL);
   816		if (!sids_copy) {
   817			kfree(rmr_data);
   818			return NULL;
   819		}
   820		rmr_data->sids = sids_copy;
   821		rmr_data->num_sids = num_sids;
   822	
   823		if (!IS_ALIGNED(addr, SZ_64K) || !IS_ALIGNED(size, SZ_64K)) {
   824			/* PAGE align base addr and size */
   825			addr &= PAGE_MASK;
   826			size = PAGE_ALIGN(size + offset_in_page(rmr_desc->base_address));
   827	
   828			pr_err(FW_BUG "RMR descriptor[0x%llx - 0x%llx] not aligned to 64K, continue with [0x%llx - 0x%llx]\n",
   829			       rmr_desc->base_address,
   830			       rmr_desc->base_address + rmr_desc->length - 1,
   831			       addr, addr + size - 1);
   832		}
   833	
   834		region = &rmr_data->rr;
   835		INIT_LIST_HEAD(&region->list);
   836		region->start = addr;
   837		region->length = size;
   838		region->prot = prot;
   839		region->type = type;
   840		region->free = iort_rmr_free;
   841	
   842		return rmr_data;
   843	}
   844	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
