Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 603E3792FE9
	for <lists+linux-acpi@lfdr.de>; Tue,  5 Sep 2023 22:24:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243652AbjIEUYo (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 5 Sep 2023 16:24:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243547AbjIEUYb (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 5 Sep 2023 16:24:31 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EC2CD1;
        Tue,  5 Sep 2023 13:24:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693945464; x=1725481464;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=XyUUG1HMbirzP2NvYtvvRf7Q4WUL/r2/+NfmU8fIqRQ=;
  b=kFY+C0BKyHWPSD/7KnYi9I38EmdHYgsUviXwGbv8BMNmFdv/HjWVRPro
   htntedvRS/WNBq5Zqzq46h2wQ62vVx5SZ/dj4YuQzeQVxL1SKvfbY70Ac
   HwMyH9Zify8L2tjWqBzUKTPIj7I2HzbjMGCMgA987fEiU+QLjCLp3GvOn
   rQDuNdh5R7s/lNE1bRhjFocWv6Y1CMLYXj3Z3x9SdcWaEFhiGEFb0Ju9f
   oMY7/gl6vosJIQcch7dDTI3z4ZA6IU2gJKzUMZ6FkqvWG/k41arCXOz8T
   6Rbsj5rYM4wpdfmZQChvRxmgCoWvxoHBPDlKMvSJzfw4AOLLsgpq8zg/u
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10824"; a="380703012"
X-IronPort-AV: E=Sophos;i="6.02,230,1688454000"; 
   d="scan'208";a="380703012"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2023 13:24:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10824"; a="744410815"
X-IronPort-AV: E=Sophos;i="6.02,230,1688454000"; 
   d="scan'208";a="744410815"
Received: from lkp-server02.sh.intel.com (HELO e0b2ea88afd5) ([10.239.97.151])
  by fmsmga007.fm.intel.com with ESMTP; 05 Sep 2023 13:24:12 -0700
Received: from kbuild by e0b2ea88afd5 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qdcag-00022f-26;
        Tue, 05 Sep 2023 20:24:05 +0000
Date:   Wed, 6 Sep 2023 04:22:41 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ben Cheatham <Benjamin.Cheatham@amd.com>, rafael@kernel.org,
        dan.j.williams@intel.com, linux-cxl@vger.kernel.org,
        linux-acpi@vger.kernel.org
Cc:     oe-kbuild-all@lists.linux.dev, bhelgaas@google.com,
        benjamin.cheatham@amd.com, yazen.ghannam@amd.com
Subject: Re: [PATCH v3 2/3] ACPI, APEI, EINJ: Add CXL 1.1 EINJ error type
 support
Message-ID: <202309060439.NyMjpqql-lkp@intel.com>
References: <20230905184406.135851-3-Benjamin.Cheatham@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230905184406.135851-3-Benjamin.Cheatham@amd.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Ben,

kernel test robot noticed the following build warnings:

[auto build test WARNING on rafael-pm/linux-next]
[also build test WARNING on linus/master v6.5 next-20230905]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Ben-Cheatham/CXL-PCIE-Add-cxl_rcrb_addr-file-to-dport_dev/20230906-025405
base:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git linux-next
patch link:    https://lore.kernel.org/r/20230905184406.135851-3-Benjamin.Cheatham%40amd.com
patch subject: [PATCH v3 2/3] ACPI, APEI, EINJ: Add CXL 1.1 EINJ error type support
config: alpha-allyesconfig (https://download.01.org/0day-ci/archive/20230906/202309060439.NyMjpqql-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20230906/202309060439.NyMjpqql-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202309060439.NyMjpqql-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from drivers/cxl/cxl.h:11,
                    from drivers/cxl/cxlmem.h:9,
                    from drivers/cxl/core/port.c:11:
>> include/linux/cxl.h:12:19: warning: no previous prototype for 'cxl_find_rch_dport_by_rcrb' [-Wmissing-prototypes]
      12 | struct cxl_dport *cxl_find_rch_dport_by_rcrb(resource_size_t rcrb_base)
         |                   ^~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/cxl/core/port.c:1125:19: error: redefinition of 'cxl_find_rch_dport_by_rcrb'
    1125 | struct cxl_dport *cxl_find_rch_dport_by_rcrb(resource_size_t rcrb_base)
         |                   ^~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/cxl.h:12:19: note: previous definition of 'cxl_find_rch_dport_by_rcrb' with type 'struct cxl_dport *(resource_size_t)' {aka 'struct cxl_dport *(long long unsigned int)'}
      12 | struct cxl_dport *cxl_find_rch_dport_by_rcrb(resource_size_t rcrb_base)
         |                   ^~~~~~~~~~~~~~~~~~~~~~~~~~
--
   In file included from drivers/cxl/cxl.h:11,
                    from drivers/cxl/cxlmem.h:9,
                    from drivers/cxl/core/pmem.c:6:
>> include/linux/cxl.h:12:19: warning: no previous prototype for 'cxl_find_rch_dport_by_rcrb' [-Wmissing-prototypes]
      12 | struct cxl_dport *cxl_find_rch_dport_by_rcrb(resource_size_t rcrb_base)
         |                   ^~~~~~~~~~~~~~~~~~~~~~~~~~


vim +/cxl_find_rch_dport_by_rcrb +12 include/linux/cxl.h

     8	
     9	#if IS_ENABLED(CONFIG_CXL_ACPI)
    10	struct cxl_dport *cxl_find_rch_dport_by_rcrb(resource_size_t rcrb_base);
    11	#else
  > 12	struct cxl_dport *cxl_find_rch_dport_by_rcrb(resource_size_t rcrb_base)
    13	{
    14		return NULL;
    15	}
    16	#endif
    17	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
