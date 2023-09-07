Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29E5A797CD1
	for <lists+linux-acpi@lfdr.de>; Thu,  7 Sep 2023 21:34:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235107AbjIGTel (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 7 Sep 2023 15:34:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234167AbjIGTel (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 7 Sep 2023 15:34:41 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BD611BCD
        for <linux-acpi@vger.kernel.org>; Thu,  7 Sep 2023 12:34:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694115273; x=1725651273;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=YSRUDy+REm2wMZJ02GINz5SuAfQQlfIKfALb/H9Gso4=;
  b=DeGKfWacpbTG1u96IuOJ7tJ5KjCPU+hVG5rJoUQto84c8pLv2LjVv3fy
   WczONbVx+vrby3l1DTXQk2wcrlB0Y+BNcFh5xBTfqWiYgTbS6YD8hUbuz
   BjluYdKIUZ+lD86MMgQVI2k79UL2U+MoGwCiBFnIr7oNudBbD1KB0gL0l
   4rl9b6akk3cwRiVX+IhQa3bEhAkH0lq1BeC7paZ1waJjzv9jNP76+NWZO
   Iw75ZHFWw+HkjTjQojyiAQjC66VvBIXPOm4vcS2/U39ZHJHQKonuwdq6g
   gVr/gw9Hoqbmr5H353KlLXnDg45ARQpg0MhLFGVuzo5yk7i2pHy0XE9vC
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10826"; a="380190252"
X-IronPort-AV: E=Sophos;i="6.02,235,1688454000"; 
   d="scan'208";a="380190252"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2023 12:34:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10826"; a="812264805"
X-IronPort-AV: E=Sophos;i="6.02,235,1688454000"; 
   d="scan'208";a="812264805"
Received: from lkp-server01.sh.intel.com (HELO 59b3c6e06877) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 07 Sep 2023 12:34:30 -0700
Received: from kbuild by 59b3c6e06877 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qeKln-0001Vn-2f;
        Thu, 07 Sep 2023 19:34:27 +0000
Date:   Fri, 8 Sep 2023 03:34:16 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ken Xue <Ken.Xue@amd.com>, linux-acpi@vger.kernel.org,
        rafael@kernel.org, andriy.shevchenko@linux.intel.com
Cc:     oe-kbuild-all@lists.linux.dev, Ken.Xue@amd.com
Subject: Re: [PATCH] acpi: trigger wakeup key event from power button
Message-ID: <202309080315.txQUEyHQ-lkp@intel.com>
References: <20230907074342.7722-1-Ken.Xue@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230907074342.7722-1-Ken.Xue@amd.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Ken,

kernel test robot noticed the following build errors:

[auto build test ERROR on rafael-pm/linux-next]
[also build test ERROR on linus/master v6.5 next-20230907]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Ken-Xue/acpi-trigger-wakeup-key-event-from-power-button/20230907-232828
base:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git linux-next
patch link:    https://lore.kernel.org/r/20230907074342.7722-1-Ken.Xue%40amd.com
patch subject: [PATCH] acpi: trigger wakeup key event from power button
config: i386-randconfig-r032-20230908 (https://download.01.org/0day-ci/archive/20230908/202309080315.txQUEyHQ-lkp@intel.com/config)
compiler: gcc-7 (Ubuntu 7.5.0-6ubuntu2) 7.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20230908/202309080315.txQUEyHQ-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202309080315.txQUEyHQ-lkp@intel.com/

All errors (new ones prefixed by >>):

   ld: drivers/acpi/sleep.o: in function `acpi_pm_finish':
>> drivers/acpi/sleep.c:511: undefined reference to `acpi_power_button_wakeup'


vim +511 drivers/acpi/sleep.c

   469	
   470	/**
   471	 *	acpi_pm_finish - Instruct the platform to leave a sleep state.
   472	 *
   473	 *	This is called after we wake back up (or if entering the sleep state
   474	 *	failed).
   475	 */
   476	static void acpi_pm_finish(void)
   477	{
   478		struct acpi_device *pwr_btn_adev;
   479		u32 acpi_state = acpi_target_sleep_state;
   480	
   481		acpi_ec_unblock_transactions();
   482		suspend_nvs_free();
   483	
   484		if (acpi_state == ACPI_STATE_S0)
   485			return;
   486	
   487		pr_info("Waking up from system sleep state S%d\n", acpi_state);
   488		acpi_disable_wakeup_devices(acpi_state);
   489		acpi_leave_sleep_state(acpi_state);
   490	
   491		/* reset firmware waking vector */
   492		acpi_set_waking_vector(0);
   493	
   494		acpi_target_sleep_state = ACPI_STATE_S0;
   495	
   496		acpi_resume_power_resources();
   497	
   498		/* If we were woken with the fixed power button, provide a small
   499		 * hint to userspace in the form of a wakeup event on the fixed power
   500		 * button device (if it can be found).
   501		 *
   502		 * We delay the event generation til now, as the PM layer requires
   503		 * timekeeping to be running before we generate events. */
   504		if (!pwr_btn_event_pending)
   505			return;
   506	
   507		pwr_btn_event_pending = false;
   508		pwr_btn_adev = acpi_dev_get_first_match_dev(ACPI_BUTTON_HID_POWERF,
   509							    NULL, -1);
   510		if (pwr_btn_adev) {
 > 511			acpi_power_button_wakeup(pwr_btn_adev);
   512			pm_wakeup_event(&pwr_btn_adev->dev, 0);
   513			acpi_dev_put(pwr_btn_adev);
   514		}
   515	}
   516	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
