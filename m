Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12A037A1399
	for <lists+linux-acpi@lfdr.de>; Fri, 15 Sep 2023 04:13:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230512AbjIOCNR (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 14 Sep 2023 22:13:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229584AbjIOCNQ (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 14 Sep 2023 22:13:16 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CE071FCC
        for <linux-acpi@vger.kernel.org>; Thu, 14 Sep 2023 19:13:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694743992; x=1726279992;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Y8FsBrE2zFb+CfVLiOvn7+rHs6rmIW4pomrtZC30VF4=;
  b=FHU/vEMGrKbA2CJPPVvnPYCJ44Okx4uRM4iBcMeOCVsmM1yYdHxMsrBK
   aGaTz5zXLNhrAWztB9iiFpzLhM0Cb+t7j4e7MTNnWEbcFeo5z+jba5GIU
   TitQAtmcbok/Pr6NuCdpRnv3hBqo83rHHP5G4wMapeXnM1ycv4Y+1JjEf
   sVg3sqGIWeOja2urxmj97zoS7JITNhWEwav2p2CCBgG8cVN1AK5iGW0Kh
   Gg3Q2lKr3tJkP+xl61kf3U8+e2W4lOto5LAViW1UH6m9lCfnj3SNDFuc3
   ksdMm0iezCwGteqMxexmeEkWBwVP3Zild+wnrZ5oFXoD/CTVKhDO6tYcW
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10833"; a="381864232"
X-IronPort-AV: E=Sophos;i="6.02,147,1688454000"; 
   d="scan'208";a="381864232"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2023 19:13:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10833"; a="779913181"
X-IronPort-AV: E=Sophos;i="6.02,147,1688454000"; 
   d="scan'208";a="779913181"
Received: from lkp-server02.sh.intel.com (HELO 9ef86b2655e5) ([10.239.97.151])
  by orsmga001.jf.intel.com with ESMTP; 14 Sep 2023 19:13:10 -0700
Received: from kbuild by 9ef86b2655e5 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qgyKS-0002J3-0H;
        Fri, 15 Sep 2023 02:13:08 +0000
Date:   Fri, 15 Sep 2023 10:12:17 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ken Xue <Ken.Xue@amd.com>, andriy.shevchenko@linux.intel.com,
        linux-acpi@vger.kernel.org
Cc:     oe-kbuild-all@lists.linux.dev, rafael@kernel.org,
        cwhuang@linux.org.tw, Ken Xue <Ken.Xue@amd.com>
Subject: Re: [PATCH V4] acpi: trigger wakeup key event from power button
Message-ID: <202309150947.YLjvs2Vv-lkp@intel.com>
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
config: i386-debian-10.3 (https://download.01.org/0day-ci/archive/20230915/202309150947.YLjvs2Vv-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20230915/202309150947.YLjvs2Vv-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202309150947.YLjvs2Vv-lkp@intel.com/

All errors (new ones prefixed by >>):

   ld: drivers/acpi/sleep.o: in function `acpi_pm_finish':
>> drivers/acpi/sleep.c:514: undefined reference to `acpi_power_button_wakeup'


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
