Return-Path: <linux-acpi+bounces-457-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 144E67BAF96
	for <lists+linux-acpi@lfdr.de>; Fri,  6 Oct 2023 02:32:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sy.mirrors.kernel.org (Postfix) with ESMTP id 4D92FB209A5
	for <lists+linux-acpi@lfdr.de>; Fri,  6 Oct 2023 00:32:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68C7D15B4
	for <lists+linux-acpi@lfdr.de>; Fri,  6 Oct 2023 00:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ClOq/JHe"
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D4C341A9B
	for <linux-acpi@vger.kernel.org>; Thu,  5 Oct 2023 23:00:44 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFE4AD4F;
	Thu,  5 Oct 2023 16:00:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696546838; x=1728082838;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=YSc5DqPuCbhoQCscHYL5riDMSg61/UNw+XjJOkVlsYk=;
  b=ClOq/JHenUDs/DEFwcalJZTrpVTEXzdZquRfQfsadWKjZsnZlxF25IjJ
   Cvti4DllVy/HC6ZL+qVHDs2M2ru0hNT0+RsZK1y7tkZLWg/2gAt4H0Brl
   9j7m4LE2C+7ieRtCDzkYPnUCjjxH6fwvot1tSyzDwLmC8F9BJ4e00nh75
   IZj0Jo0/0kqFPN+X/S1R/uaD90tv6AxJqowXXZFmJHl54dkp/5NvdhK1s
   kZOqjsX4k78BFQSz72pmRXQEWqybfqU+KXg/94Ivv4RcTOLAVSZ6qryQD
   8QHEHOHG7QNAsNDxMdg4itfX+bYRajI3P60VNsDV6nzmdPM1AcvIzMfvK
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10854"; a="387516067"
X-IronPort-AV: E=Sophos;i="6.03,203,1694761200"; 
   d="scan'208";a="387516067"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2023 16:00:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10854"; a="895648208"
X-IronPort-AV: E=Sophos;i="6.03,203,1694761200"; 
   d="scan'208";a="895648208"
Received: from lkp-server02.sh.intel.com (HELO c3b01524d57c) ([10.239.97.151])
  by fmsmga001.fm.intel.com with ESMTP; 05 Oct 2023 15:59:05 -0700
Received: from kbuild by c3b01524d57c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1qoXKb-000M09-0N;
	Thu, 05 Oct 2023 23:00:33 +0000
Date: Fri, 6 Oct 2023 07:00:04 +0800
From: kernel test robot <lkp@intel.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: oe-kbuild-all@lists.linux.dev, linux-acpi@vger.kernel.org,
	devel@acpica.org, linux-pm@vger.kernel.org
Subject: [rafael-pm:bleeding-edge 127/130]
 drivers/thermal/gov_power_allocator.c:127:13: warning: unused variable 'ret'
Message-ID: <202310060618.FJ4z229a-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
head:   ef7625d78dd079600f642d5875c08e059b002b52
commit: 9212159685caa222bbe01f9b4d49f6c1f9ddb11a [127/130] thermal: gov_power_allocator: Use trip pointers instead of trip indices
config: mips-allyesconfig (https://download.01.org/0day-ci/archive/20231006/202310060618.FJ4z229a-lkp@intel.com/config)
compiler: mips-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231006/202310060618.FJ4z229a-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202310060618.FJ4z229a-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/thermal/gov_power_allocator.c: In function 'estimate_pid_constants':
>> drivers/thermal/gov_power_allocator.c:127:13: warning: unused variable 'ret' [-Wunused-variable]
     127 |         int ret;
         |             ^~~


vim +/ret +127 drivers/thermal/gov_power_allocator.c

e055bb0f9a6e5c drivers/thermal/power_allocator.c     Javi Merino       2015-09-14  110  
e055bb0f9a6e5c drivers/thermal/power_allocator.c     Javi Merino       2015-09-14  111  /**
e055bb0f9a6e5c drivers/thermal/power_allocator.c     Javi Merino       2015-09-14  112   * estimate_pid_constants() - Estimate the constants for the PID controller
e055bb0f9a6e5c drivers/thermal/power_allocator.c     Javi Merino       2015-09-14  113   * @tz:		thermal zone for which to estimate the constants
e055bb0f9a6e5c drivers/thermal/power_allocator.c     Javi Merino       2015-09-14  114   * @sustainable_power:	sustainable power for the thermal zone
9212159685caa2 drivers/thermal/gov_power_allocator.c Rafael J. Wysocki 2023-10-05  115   * @trip_switch_on:	trip point for the switch on temperature
e055bb0f9a6e5c drivers/thermal/power_allocator.c     Javi Merino       2015-09-14  116   * @control_temp:	target temperature for the power allocator governor
e055bb0f9a6e5c drivers/thermal/power_allocator.c     Javi Merino       2015-09-14  117   *
e055bb0f9a6e5c drivers/thermal/power_allocator.c     Javi Merino       2015-09-14  118   * This function is used to update the estimation of the PID
e055bb0f9a6e5c drivers/thermal/power_allocator.c     Javi Merino       2015-09-14  119   * controller constants in struct thermal_zone_parameters.
e055bb0f9a6e5c drivers/thermal/power_allocator.c     Javi Merino       2015-09-14  120   */
e055bb0f9a6e5c drivers/thermal/power_allocator.c     Javi Merino       2015-09-14  121  static void estimate_pid_constants(struct thermal_zone_device *tz,
9212159685caa2 drivers/thermal/gov_power_allocator.c Rafael J. Wysocki 2023-10-05  122  				   u32 sustainable_power,
9212159685caa2 drivers/thermal/gov_power_allocator.c Rafael J. Wysocki 2023-10-05  123  				   const struct thermal_trip *trip_switch_on,
90a996544946d1 drivers/thermal/gov_power_allocator.c Lukasz Luba       2020-11-24  124  				   int control_temp)
e055bb0f9a6e5c drivers/thermal/power_allocator.c     Javi Merino       2015-09-14  125  {
7f725a23f2b7bb drivers/thermal/gov_power_allocator.c Daniel Lezcano    2022-10-03  126  	u32 temperature_threshold = control_temp;
e055bb0f9a6e5c drivers/thermal/power_allocator.c     Javi Merino       2015-09-14 @127  	int ret;
e34a7233896928 drivers/thermal/gov_power_allocator.c Lukasz Luba       2020-11-24  128  	s32 k_i;
e055bb0f9a6e5c drivers/thermal/power_allocator.c     Javi Merino       2015-09-14  129  
9212159685caa2 drivers/thermal/gov_power_allocator.c Rafael J. Wysocki 2023-10-05  130  	if (trip_switch_on)
9212159685caa2 drivers/thermal/gov_power_allocator.c Rafael J. Wysocki 2023-10-05  131  		temperature_threshold -= trip_switch_on->temperature;
e055bb0f9a6e5c drivers/thermal/power_allocator.c     Javi Merino       2015-09-14  132  
44241628bb207e drivers/thermal/power_allocator.c     Andrea Arcangeli  2015-10-01  133  	/*
44241628bb207e drivers/thermal/power_allocator.c     Andrea Arcangeli  2015-10-01  134  	 * estimate_pid_constants() tries to find appropriate default
44241628bb207e drivers/thermal/power_allocator.c     Andrea Arcangeli  2015-10-01  135  	 * values for thermal zones that don't provide them. If a
44241628bb207e drivers/thermal/power_allocator.c     Andrea Arcangeli  2015-10-01  136  	 * system integrator has configured a thermal zone with two
44241628bb207e drivers/thermal/power_allocator.c     Andrea Arcangeli  2015-10-01  137  	 * passive trip points at the same temperature, that person
44241628bb207e drivers/thermal/power_allocator.c     Andrea Arcangeli  2015-10-01  138  	 * hasn't put any effort to set up the thermal zone properly
44241628bb207e drivers/thermal/power_allocator.c     Andrea Arcangeli  2015-10-01  139  	 * so just give up.
44241628bb207e drivers/thermal/power_allocator.c     Andrea Arcangeli  2015-10-01  140  	 */
44241628bb207e drivers/thermal/power_allocator.c     Andrea Arcangeli  2015-10-01  141  	if (!temperature_threshold)
44241628bb207e drivers/thermal/power_allocator.c     Andrea Arcangeli  2015-10-01  142  		return;
e055bb0f9a6e5c drivers/thermal/power_allocator.c     Javi Merino       2015-09-14  143  
e055bb0f9a6e5c drivers/thermal/power_allocator.c     Javi Merino       2015-09-14  144  	tz->tzp->k_po = int_to_frac(sustainable_power) /
e055bb0f9a6e5c drivers/thermal/power_allocator.c     Javi Merino       2015-09-14  145  		temperature_threshold;
e055bb0f9a6e5c drivers/thermal/power_allocator.c     Javi Merino       2015-09-14  146  
e055bb0f9a6e5c drivers/thermal/power_allocator.c     Javi Merino       2015-09-14  147  	tz->tzp->k_pu = int_to_frac(2 * sustainable_power) /
e055bb0f9a6e5c drivers/thermal/power_allocator.c     Javi Merino       2015-09-14  148  		temperature_threshold;
e055bb0f9a6e5c drivers/thermal/power_allocator.c     Javi Merino       2015-09-14  149  
e34a7233896928 drivers/thermal/gov_power_allocator.c Lukasz Luba       2020-11-24  150  	k_i = tz->tzp->k_pu / 10;
e34a7233896928 drivers/thermal/gov_power_allocator.c Lukasz Luba       2020-11-24  151  	tz->tzp->k_i = k_i > 0 ? k_i : 1;
e34a7233896928 drivers/thermal/gov_power_allocator.c Lukasz Luba       2020-11-24  152  
e055bb0f9a6e5c drivers/thermal/power_allocator.c     Javi Merino       2015-09-14  153  	/*
e055bb0f9a6e5c drivers/thermal/power_allocator.c     Javi Merino       2015-09-14  154  	 * The default for k_d and integral_cutoff is 0, so we can
e055bb0f9a6e5c drivers/thermal/power_allocator.c     Javi Merino       2015-09-14  155  	 * leave them as they are.
e055bb0f9a6e5c drivers/thermal/power_allocator.c     Javi Merino       2015-09-14  156  	 */
e055bb0f9a6e5c drivers/thermal/power_allocator.c     Javi Merino       2015-09-14  157  }
e055bb0f9a6e5c drivers/thermal/power_allocator.c     Javi Merino       2015-09-14  158  

:::::: The code at line 127 was first introduced by commit
:::::: e055bb0f9a6e5c09bedf41c2a5b881edbd7f2ed0 thermal: power_allocator: relax the requirement of a sustainable_power in tzp

:::::: TO: Javi Merino <javi.merino@arm.com>
:::::: CC: Eduardo Valentin <edubezval@gmail.com>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

