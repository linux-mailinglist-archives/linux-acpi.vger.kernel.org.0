Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7BC56CF325
	for <lists+linux-acpi@lfdr.de>; Wed, 29 Mar 2023 21:29:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230313AbjC2T3O (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 29 Mar 2023 15:29:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230232AbjC2T3O (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 29 Mar 2023 15:29:14 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 423FD134;
        Wed, 29 Mar 2023 12:29:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680118153; x=1711654153;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=eXdFVSGTvIKz7EDIZLcUeytXl6nXJcuFiBB8WJdknyI=;
  b=fBdsS07wLkDJ6kwKiZMWchxDmY9JEA+ehCmNmhzVwfujpdztf9ScaY30
   x7gVbQzKyIFnLH2L865px8TWZW+HIkaXUZYuSG6Oq474z7UcRAu1Pi5Dp
   csUogy3sc0sRTRRasR4KPkgk3lcTS/if5am7h82/p0Z3a3y49wkWyywnw
   bZF02lr021b0iI8X+3FtemYNjJZF6Yp4AY7l7hLLQcCrRnVsc1KF+KIYV
   9njswgLcXZqt82eMNouRR5X0hP+8D69IBo9syojMcVIjE+t16vqFrJegQ
   jOydbvgc1iM/9Zv7c4+AO5soh+GvQWUwG0hlIFEV2phWPQ805cYBqg4qE
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10664"; a="427255361"
X-IronPort-AV: E=Sophos;i="5.98,301,1673942400"; 
   d="scan'208";a="427255361"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2023 12:29:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10664"; a="677902215"
X-IronPort-AV: E=Sophos;i="5.98,301,1673942400"; 
   d="scan'208";a="677902215"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 29 Mar 2023 12:29:10 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1phbTp-000JsG-23;
        Wed, 29 Mar 2023 19:29:09 +0000
Date:   Thu, 30 Mar 2023 03:28:38 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ben Cheatham <Benjamin.Cheatham@amd.com>, rafael@kernel.org
Cc:     oe-kbuild-all@lists.linux.dev, benjamin.cheatham@amd.com,
        yazen.ghannam@amd.com, linux-acpi@vger.kernel.org,
        linux-cxl@vger.kernel.org, tony.luck@intel.com
Subject: Re: [PATCH] ACPI, APEI, EINJ: Remove memory range validation for CXL
 error types
Message-ID: <202303300345.QZXN7i0i-lkp@intel.com>
References: <20230329143813.25849-1-Benjamin.Cheatham@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230329143813.25849-1-Benjamin.Cheatham@amd.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Ben,

I love your patch! Perhaps something to improve:

[auto build test WARNING on rafael-pm/linux-next]
[also build test WARNING on linus/master v6.3-rc4 next-20230329]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Ben-Cheatham/ACPI-APEI-EINJ-Remove-memory-range-validation-for-CXL-error-types/20230329-224405
base:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git linux-next
patch link:    https://lore.kernel.org/r/20230329143813.25849-1-Benjamin.Cheatham%40amd.com
patch subject: [PATCH] ACPI, APEI, EINJ: Remove memory range validation for CXL error types
config: i386-allyesconfig (https://download.01.org/0day-ci/archive/20230330/202303300345.QZXN7i0i-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-8) 11.3.0
reproduce (this is a W=1 build):
        # https://github.com/intel-lab-lkp/linux/commit/f0c48248d842ab224de7ac3d62d260e9f411e80c
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Ben-Cheatham/ACPI-APEI-EINJ-Remove-memory-range-validation-for-CXL-error-types/20230329-224405
        git checkout f0c48248d842ab224de7ac3d62d260e9f411e80c
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=i386 olddefconfig
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash drivers/acpi/apei/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202303300345.QZXN7i0i-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/acpi/apei/einj.c: In function 'einj_error_inject':
>> drivers/acpi/apei/einj.c:527:13: warning: unused variable 'available_error_types' [-Wunused-variable]
     527 |         u32 available_error_types = 0;
         |             ^~~~~~~~~~~~~~~~~~~~~


vim +/available_error_types +527 drivers/acpi/apei/einj.c

   521	
   522	/* Inject the specified hardware error */
   523	static int einj_error_inject(u32 type, u32 flags, u64 param1, u64 param2,
   524				     u64 param3, u64 param4)
   525	{
   526		int rc;
 > 527		u32 available_error_types = 0;
   528		u64 base_addr, size;
   529	
   530		/* If user manually set "flags", make sure it is legal */
   531		if (flags && (flags &
   532			~(SETWA_FLAGS_APICID|SETWA_FLAGS_MEM|SETWA_FLAGS_PCIE_SBDF)))
   533			return -EINVAL;
   534	
   535		/*
   536		 * We need extra sanity checks for memory errors.
   537		 * Other types leap directly to injection.
   538		 */
   539	
   540		/* ensure param1/param2 existed */
   541		if (!(param_extension || acpi5))
   542			goto inject;
   543	
   544		/* ensure injection is memory related */
   545		if (type & ACPI5_VENDOR_BIT) {
   546			if (vendor_flags != SETWA_FLAGS_MEM)
   547				goto inject;
   548		} else if (!(type & MEM_ERROR_MASK) && !(flags & SETWA_FLAGS_MEM)) {
   549			goto inject;
   550		} else if (type & CXL_ERROR_MASK) {
   551			goto inject;
   552		}
   553	
   554		/*
   555		 * Disallow crazy address masks that give BIOS leeway to pick
   556		 * injection address almost anywhere. Insist on page or
   557		 * better granularity and that target address is normal RAM or
   558		 * NVDIMM.
   559		 */
   560		base_addr = param1 & param2;
   561		size = ~param2 + 1;
   562	
   563		if (((param2 & PAGE_MASK) != PAGE_MASK) ||
   564		    ((region_intersects(base_addr, size, IORESOURCE_SYSTEM_RAM, IORES_DESC_NONE)
   565					!= REGION_INTERSECTS) &&
   566		     (region_intersects(base_addr, size, IORESOURCE_MEM, IORES_DESC_PERSISTENT_MEMORY)
   567					!= REGION_INTERSECTS) &&
   568		     (region_intersects(base_addr, size, IORESOURCE_MEM, IORES_DESC_SOFT_RESERVED)
   569					!= REGION_INTERSECTS) &&
   570		     !arch_is_platform_page(base_addr)))
   571			return -EINVAL;
   572	
   573		if (is_zero_pfn(base_addr >> PAGE_SHIFT))
   574			return -EADDRINUSE;
   575	
   576	inject:
   577		mutex_lock(&einj_mutex);
   578		rc = __einj_error_inject(type, flags, param1, param2, param3, param4);
   579		mutex_unlock(&einj_mutex);
   580	
   581		return rc;
   582	}
   583	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
