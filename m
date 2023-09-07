Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DAA5797C65
	for <lists+linux-acpi@lfdr.de>; Thu,  7 Sep 2023 20:54:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233206AbjIGSyL (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 7 Sep 2023 14:54:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232643AbjIGSyL (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 7 Sep 2023 14:54:11 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FE2910FA
        for <linux-acpi@vger.kernel.org>; Thu,  7 Sep 2023 11:53:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694112811; x=1725648811;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=vgnOU7mN8H0dHSzr5JvqUcawQyl3aS/repDyOYVvMX4=;
  b=KGtqj5+PbVTOb7Gz92Ov9angvA2pZyHtz8jvG0KM2DRGP8XuUAWQiM6O
   GbvcNXADG4mFnSPQH7YopaVW28Yn5pa1x+HVRk50YEiwl8n5bmwmNPf6D
   sxbftuKFP8OLCwYvILgOtDMcpJNX1XAb/5zPwWyapwMY9Rr2Ydwi/agFy
   kBbOH0bDPpYc00d308EHZxhID3T8VkXlNy8pCFjsrSIA4LSVaVpYYQv7b
   5/QhNmaAvAMnoowNF2Y9ip091rRlhrS0yOXXhorHogH8VgUjj6/mWKcnZ
   4/ooyUJPEpp6aVeTVjwyiLyYn6EhqOSuOBNs2wYF0zN0eSujQlSxtcDYq
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10826"; a="408437007"
X-IronPort-AV: E=Sophos;i="6.02,235,1688454000"; 
   d="scan'208";a="408437007"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2023 11:51:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10826"; a="1072971200"
X-IronPort-AV: E=Sophos;i="6.02,235,1688454000"; 
   d="scan'208";a="1072971200"
Received: from lkp-server01.sh.intel.com (HELO 59b3c6e06877) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 07 Sep 2023 11:51:28 -0700
Received: from kbuild by 59b3c6e06877 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qeK69-0001Tb-2z;
        Thu, 07 Sep 2023 18:51:25 +0000
Date:   Fri, 8 Sep 2023 02:51:12 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ken Xue <Ken.Xue@amd.com>, linux-acpi@vger.kernel.org,
        rafael@kernel.org, andriy.shevchenko@linux.intel.com
Cc:     oe-kbuild-all@lists.linux.dev, Ken.Xue@amd.com
Subject: Re: [PATCH] acpi: trigger wakeup key event from power button
Message-ID: <202309080239.IiC7uLpW-lkp@intel.com>
References: <20230907074342.7722-1-Ken.Xue@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230907074342.7722-1-Ken.Xue@amd.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Ken,

kernel test robot noticed the following build warnings:

[auto build test WARNING on rafael-pm/linux-next]
[also build test WARNING on linus/master v6.5 next-20230907]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Ken-Xue/acpi-trigger-wakeup-key-event-from-power-button/20230907-232828
base:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git linux-next
patch link:    https://lore.kernel.org/r/20230907074342.7722-1-Ken.Xue%40amd.com
patch subject: [PATCH] acpi: trigger wakeup key event from power button
config: riscv-defconfig (https://download.01.org/0day-ci/archive/20230908/202309080239.IiC7uLpW-lkp@intel.com/config)
compiler: riscv64-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20230908/202309080239.IiC7uLpW-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202309080239.IiC7uLpW-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from drivers/gpu/drm/nouveau/nouveau_connector.c:27:
>> include/acpi/button.h:11:45: warning: 'struct acpi_device' declared inside parameter list will not be visible outside of this definition or declaration
      11 | extern void acpi_power_button_wakeup(struct acpi_device *device);
         |                                             ^~~~~~~~~~~


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
