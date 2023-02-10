Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1412F6915B0
	for <lists+linux-acpi@lfdr.de>; Fri, 10 Feb 2023 01:40:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230029AbjBJAjw (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 9 Feb 2023 19:39:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229674AbjBJAjv (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 9 Feb 2023 19:39:51 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 325AD677A1;
        Thu,  9 Feb 2023 16:39:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675989565; x=1707525565;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=PXyJgNPvZehyPMk+XcL+100g+1+DfTr5lbVyZtp1LCE=;
  b=OwKZ2s60vWs8F/dath/+Fqt6hQ3Tpxu7FxK2qa8lacLeBAECvKeBbL5Z
   xqlBd3Bp5+gJrsCn4pPxDuHO9qPgHeR9vVXF12wZv+hiCZdJzguai3lVk
   Zp17n6VvpKxIQ+ykXJ/kQr9xiZPUChEvDzEcbkdhyzF46Z+2DjeAUNUwQ
   sfQOznoa3+T+APRiiGxZ+nWM11W9KevAXTLVz6KVlUPMgTStT1u558NWL
   p79QSKJk0WPsHGblkdgYkxRq2Xpxxqb9HvdaYzgvKuTVhZsWAPFsEVGz3
   q+HoSoMImOEXKfgZ+JEzdXoavM+OiXPYhsr5oqt6xIPJDjTNt3ffkCyMf
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10616"; a="310656960"
X-IronPort-AV: E=Sophos;i="5.97,285,1669104000"; 
   d="scan'208";a="310656960"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2023 16:37:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10616"; a="756606662"
X-IronPort-AV: E=Sophos;i="5.97,285,1669104000"; 
   d="scan'208";a="756606662"
Received: from lkp-server01.sh.intel.com (HELO 4455601a8d94) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 09 Feb 2023 16:37:13 -0800
Received: from kbuild by 4455601a8d94 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pQHPc-0005PK-1M;
        Fri, 10 Feb 2023 00:37:12 +0000
Date:   Fri, 10 Feb 2023 08:36:59 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     oe-kbuild-all@lists.linux.dev, linux-acpi@vger.kernel.org,
        devel@acpica.org, linux-pm@vger.kernel.org
Subject: [rafael-pm:bleeding-edge 209/212] drivers/cpuidle/driver.c:187:
 undefined reference to `__divdi3'
Message-ID: <202302100849.6RI86Ten-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
head:   ccf0090d0435abab1a8c84e595802e88ad90b357
commit: de375f9c854a136822d5409a92d4efb57ac65e32 [209/212] cpuidle: driver: Update microsecond values of state parameters as needed
config: i386-randconfig-a001 (https://download.01.org/0day-ci/archive/20230210/202302100849.6RI86Ten-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-8) 11.3.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git/commit/?id=de375f9c854a136822d5409a92d4efb57ac65e32
        git remote add rafael-pm https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git
        git fetch --no-tags rafael-pm bleeding-edge
        git checkout de375f9c854a136822d5409a92d4efb57ac65e32
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=i386 olddefconfig
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202302100849.6RI86Ten-lkp@intel.com/

All errors (new ones prefixed by >>):

   ld: drivers/cpuidle/driver.o: in function `__cpuidle_driver_init':
>> drivers/cpuidle/driver.c:187: undefined reference to `__divdi3'
>> ld: drivers/cpuidle/driver.c:194: undefined reference to `__divdi3'


vim +187 drivers/cpuidle/driver.c

   149	
   150	/**
   151	 * __cpuidle_driver_init - initialize the driver's internal data
   152	 * @drv: a valid pointer to a struct cpuidle_driver
   153	 */
   154	static void __cpuidle_driver_init(struct cpuidle_driver *drv)
   155	{
   156		int i;
   157	
   158		/*
   159		 * Use all possible CPUs as the default, because if the kernel boots
   160		 * with some CPUs offline and then we online one of them, the CPU
   161		 * notifier has to know which driver to assign.
   162		 */
   163		if (!drv->cpumask)
   164			drv->cpumask = (struct cpumask *)cpu_possible_mask;
   165	
   166		for (i = 0; i < drv->state_count; i++) {
   167			struct cpuidle_state *s = &drv->states[i];
   168	
   169			/*
   170			 * Look for the timer stop flag in the different states and if
   171			 * it is found, indicate that the broadcast timer has to be set
   172			 * up.
   173			 */
   174			if (s->flags & CPUIDLE_FLAG_TIMER_STOP)
   175				drv->bctimer = 1;
   176	
   177			/*
   178			 * The core will use the target residency and exit latency
   179			 * values in nanoseconds, but allow drivers to provide them in
   180			 * microseconds too.
   181			 */
   182			if (s->target_residency > 0)
   183				s->target_residency_ns = s->target_residency * NSEC_PER_USEC;
   184			else if (s->target_residency_ns < 0)
   185				s->target_residency_ns = 0;
   186			else
 > 187				s->target_residency = s->target_residency_ns / NSEC_PER_USEC;
   188	
   189			if (s->exit_latency > 0)
   190				s->exit_latency_ns = s->exit_latency * NSEC_PER_USEC;
   191			else if (s->exit_latency_ns < 0)
   192				s->exit_latency_ns =  0;
   193			else
 > 194				s->exit_latency = s->exit_latency_ns / NSEC_PER_USEC;
   195		}
   196	}
   197	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
