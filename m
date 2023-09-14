Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6F907A1024
	for <lists+linux-acpi@lfdr.de>; Thu, 14 Sep 2023 23:59:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229531AbjINV7T (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 14 Sep 2023 17:59:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbjINV7T (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 14 Sep 2023 17:59:19 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20D7D1BFA
        for <linux-acpi@vger.kernel.org>; Thu, 14 Sep 2023 14:59:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694728755; x=1726264755;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=orTRfm3EWFvxsGYhX/MqmdMcQ7oo82in9+K7MsVadmc=;
  b=m67bnL4ibR7IAMzlOwBDKnE9nJeCOe2QxdMO4lzGSN2n5NmwSAaPTifX
   4DJuTtRPVD0g6KTGAqjdjJDtmEc28p42BpGLC9iYlYMh0ox0lsnSqfhrt
   8zLrfuk4g9DGFECGhw5cizI2qOxKG/AU0y4yDVMcokzrv9stxcX//PB9F
   9AuGV8BXCq5iFB7dGrpBZvxjOaqL96AxfTdgnwBlvnn4DoSfD1A5GWgIt
   i8t/DFyrJlOU3qXds86cHAZj+sAMyJybkZ66uvc9pQOiDD1UieFEV0Y/b
   PDYlShw/DcJYe+J1oC2iKdbq2QqSRN+JFdEg9yHGf8bDV4KVeEt74E2Yk
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10833"; a="377999180"
X-IronPort-AV: E=Sophos;i="6.02,147,1688454000"; 
   d="scan'208";a="377999180"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2023 14:59:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10833"; a="747939318"
X-IronPort-AV: E=Sophos;i="6.02,147,1688454000"; 
   d="scan'208";a="747939318"
Received: from lkp-server02.sh.intel.com (HELO 9ef86b2655e5) ([10.239.97.151])
  by fmsmga007.fm.intel.com with ESMTP; 14 Sep 2023 14:58:50 -0700
Received: from kbuild by 9ef86b2655e5 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qguMK-00025t-1c;
        Thu, 14 Sep 2023 21:58:48 +0000
Date:   Fri, 15 Sep 2023 05:58:42 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ken Xue <Ken.Xue@amd.com>, andriy.shevchenko@linux.intel.com,
        linux-acpi@vger.kernel.org
Cc:     oe-kbuild-all@lists.linux.dev, rafael@kernel.org,
        cwhuang@linux.org.tw, Ken Xue <Ken.Xue@amd.com>
Subject: Re: [PATCH V4] acpi: trigger wakeup key event from power button
Message-ID: <202309150547.0dolJMlI-lkp@intel.com>
References: <20230913002145.743571-1-Ken.Xue@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230913002145.743571-1-Ken.Xue@amd.com>
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Ken,

kernel test robot noticed the following build errors:

[auto build test ERROR on b483d3b8a54a544ab8854ca6dbb8d99c423b3ba4]

url:    https://github.com/intel-lab-lkp/linux/commits/Ken-Xue/acpi-trigger-wakeup-key-event-from-power-button/20230913-084852
base:   b483d3b8a54a544ab8854ca6dbb8d99c423b3ba4
patch link:    https://lore.kernel.org/r/20230913002145.743571-1-Ken.Xue%40amd.com
patch subject: [PATCH V4] acpi: trigger wakeup key event from power button
config: loongarch-randconfig-001-20230914 (https://download.01.org/0day-ci/archive/20230915/202309150547.0dolJMlI-lkp@intel.com/config)
compiler: loongarch64-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20230915/202309150547.0dolJMlI-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202309150547.0dolJMlI-lkp@intel.com/

All errors (new ones prefixed by >>):

   loongarch64-linux-ld: drivers/acpi/sleep.o: in function `acpi_pm_finish':
>> drivers/acpi/sleep.c:514:(.text+0x29c): undefined reference to `acpi_power_button_wakeup'


vim +514 drivers/acpi/sleep.c

   472	
   473	/**
   474	 *	acpi_pm_finish - Instruct the platform to leave a sleep state.
   475	 *
   476	 *	This is called after we wake back up (or if entering the sleep state
   477	 *	failed).
   478	 */
   479	static void acpi_pm_finish(void)
   480	{
   481		struct acpi_device *pwr_btn_adev;
   482		u32 acpi_state = acpi_target_sleep_state;
   483	
   484		acpi_ec_unblock_transactions();
   485		suspend_nvs_free();
   486	
   487		if (acpi_state == ACPI_STATE_S0)
   488			return;
   489	
   490		pr_info("Waking up from system sleep state S%d\n", acpi_state);
   491		acpi_disable_wakeup_devices(acpi_state);
   492		acpi_leave_sleep_state(acpi_state);
   493	
   494		/* reset firmware waking vector */
   495		acpi_set_waking_vector(0);
   496	
   497		acpi_target_sleep_state = ACPI_STATE_S0;
   498	
   499		acpi_resume_power_resources();
   500	
   501		/* If we were woken with the fixed power button, provide a small
   502		 * hint to userspace in the form of a wakeup event on the fixed power
   503		 * button device (if it can be found).
   504		 *
   505		 * We delay the event generation til now, as the PM layer requires
   506		 * timekeeping to be running before we generate events. */
   507		if (!pwr_btn_event_pending)
   508			return;
   509	
   510		pwr_btn_event_pending = false;
   511		pwr_btn_adev = acpi_dev_get_first_match_dev(ACPI_BUTTON_HID_POWERF,
   512							    NULL, -1);
   513		if (pwr_btn_adev) {
 > 514			acpi_power_button_wakeup(pwr_btn_adev);
   515			pm_wakeup_event(&pwr_btn_adev->dev, 0);
   516			acpi_dev_put(pwr_btn_adev);
   517		}
   518	}
   519	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
