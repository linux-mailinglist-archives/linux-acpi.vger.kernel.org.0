Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB9B1797D22
	for <lists+linux-acpi@lfdr.de>; Thu,  7 Sep 2023 22:07:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235841AbjIGUHC (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 7 Sep 2023 16:07:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229827AbjIGUHB (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 7 Sep 2023 16:07:01 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B942E47
        for <linux-acpi@vger.kernel.org>; Thu,  7 Sep 2023 13:06:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694117217; x=1725653217;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ji5oa4nWlim8LvXhOALWeS/GKJBN6DVAonZWF2hx+Q8=;
  b=lUjK0uZ1aaHxR7tVMkXTZOTUYOuTol1Gk+dLofuAiY7nMGDgRITyzbBt
   CVoO+h1FnJZm9k3aYHIJXwcyXU5EBGrIOL1fQMUKReMxsrR97F2YEVMSV
   PqvqK2/1Y9N02V3841sxbPk2uZTsakAondps1oIX6jxNUmmDqpRicYSBK
   a3ESU0n5Y4cd5n7CKQq31GA//nw7VOFoyxtBo5BDHFDKtaGB82KJxUQ48
   zO9ddvtl8OF5KbxmevqFmF2tZXz6rbaIlc3VOuzObBeYrfngnGuGRqdEi
   6XtWbbSZJtSVlgNH9N6tRtq+cArhm19ceIuKM5dQMq1OH3tuWAq7dyUx+
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10826"; a="377372755"
X-IronPort-AV: E=Sophos;i="6.02,236,1688454000"; 
   d="scan'208";a="377372755"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2023 13:06:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10826"; a="857026720"
X-IronPort-AV: E=Sophos;i="6.02,236,1688454000"; 
   d="scan'208";a="857026720"
Received: from lkp-server01.sh.intel.com (HELO 59b3c6e06877) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 07 Sep 2023 13:06:31 -0700
Received: from kbuild by 59b3c6e06877 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qeLGn-0001Xv-09;
        Thu, 07 Sep 2023 20:06:29 +0000
Date:   Fri, 8 Sep 2023 04:06:17 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ken Xue <Ken.Xue@amd.com>, linux-acpi@vger.kernel.org,
        rafael@kernel.org, andriy.shevchenko@linux.intel.com
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        Ken.Xue@amd.com
Subject: Re: [PATCH] acpi: trigger wakeup key event from power button
Message-ID: <202309080351.xHt2qhP2-lkp@intel.com>
References: <20230907074342.7722-1-Ken.Xue@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230907074342.7722-1-Ken.Xue@amd.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Ken,

kernel test robot noticed the following build warnings:

[auto build test WARNING on rafael-pm/linux-next]
[also build test WARNING on linus/master next-20230907]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Ken-Xue/acpi-trigger-wakeup-key-event-from-power-button/20230907-232828
base:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git linux-next
patch link:    https://lore.kernel.org/r/20230907074342.7722-1-Ken.Xue%40amd.com
patch subject: [PATCH] acpi: trigger wakeup key event from power button
config: x86_64-rhel-8.3-rust (https://download.01.org/0day-ci/archive/20230908/202309080351.xHt2qhP2-lkp@intel.com/config)
compiler: clang version 16.0.4 (https://github.com/llvm/llvm-project.git ae42196bc493ffe877a7e3dff8be32035dea4d07)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20230908/202309080351.xHt2qhP2-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202309080351.xHt2qhP2-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from drivers/gpu/drm/i915/display/intel_lvds.c:30:
>> include/acpi/button.h:11:45: warning: declaration of 'struct acpi_device' will not be visible outside of this function [-Wvisibility]
   extern void acpi_power_button_wakeup(struct acpi_device *device);
                                               ^
   1 warning generated.


vim +11 include/acpi/button.h

     8	
     9	#if IS_ENABLED(CONFIG_ACPI_BUTTON)
    10	extern int acpi_lid_open(void);
  > 11	extern void acpi_power_button_wakeup(struct acpi_device *device);
    12	#else
    13	static inline int acpi_lid_open(void)
    14	{
    15		return 1;
    16	}
    17	static inline void acpi_power_button_wakeup(struct acpi_device *device)
    18	{
    19		return;
    20	}
    21	#endif /* IS_ENABLED(CONFIG_ACPI_BUTTON) */
    22	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
