Return-Path: <linux-acpi+bounces-2779-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A413B82944B
	for <lists+linux-acpi@lfdr.de>; Wed, 10 Jan 2024 08:28:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 249F9B2452E
	for <lists+linux-acpi@lfdr.de>; Wed, 10 Jan 2024 07:28:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A0213A8CB;
	Wed, 10 Jan 2024 07:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OysyzjQE"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BACD539FC0;
	Wed, 10 Jan 2024 07:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704871702; x=1736407702;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=RdL3JLaABYR7lAnPBZfj8AcnQb0dWP0L6Db1mzsmXaU=;
  b=OysyzjQElN0IsyuZYx/QalPWAWDqLLb1Dff0/r7r/NTlJmbAnoadkcx1
   Ron8T4rdRZnffNeMr6X+RG98mX/zQiYDg5fTtGSP1ul+Tcqgw0Qej27/B
   xk8nKj224AV44Gcacb1WJnb0SeLQUpE0cnWcMhiGnTjfb7YvzZYzeo4Wm
   EpRTs6zJEkXMe2Da2owLbA42gI3LZIB+4ndOlXQejGl1R15T6lvutiZyh
   c0/AGpdO4XSWPIAZA48yzQazn94lQeFrLYA7KCPog/pkRPNnwHpLS7DhI
   7R0a8cy7+Hxqpe2jd0KHJpNDVT0xsvP7+PSRLqoFk/l9cXp63xTysWMMJ
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10947"; a="398123625"
X-IronPort-AV: E=Sophos;i="6.04,184,1695711600"; 
   d="scan'208";a="398123625"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jan 2024 23:28:15 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10947"; a="775139771"
X-IronPort-AV: E=Sophos;i="6.04,184,1695711600"; 
   d="scan'208";a="775139771"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orsmga007.jf.intel.com with ESMTP; 09 Jan 2024 23:28:13 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rNSxL-0006jk-1x;
	Wed, 10 Jan 2024 07:25:11 +0000
Date: Wed, 10 Jan 2024 15:17:24 +0800
From: kernel test robot <lkp@intel.com>
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-acpi@vger.kernel.org,
	devel@acpica.org, linux-pm@vger.kernel.org,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [rafael-pm:bleeding-edge 1764/1779]
 drivers/thermal/thermal_debugfs.c:149: warning: Function parameter or member
 'tz_episodes' not described in 'tz_debugfs'
Message-ID: <202401101509.DstqlL7i-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
head:   335ccbd84e3d5491e06eaf60e3f6be2ef657a495
commit: 15c1b25dd5fa2735060be35c7022bfbea4978a55 [1764/1779] thermal/debugfs: Add thermal debugfs information for mitigation episodes
config: sh-allmodconfig (https://download.01.org/0day-ci/archive/20240110/202401101509.DstqlL7i-lkp@intel.com/config)
compiler: sh4-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240110/202401101509.DstqlL7i-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202401101509.DstqlL7i-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/thermal/thermal_debugfs.c:149: warning: Function parameter or member 'tz_episodes' not described in 'tz_debugfs'


vim +149 drivers/thermal/thermal_debugfs.c

   129	
   130	/**
   131	 * struct tz_debugfs - Store all mitigation episodes for a thermal zone
   132	 *
   133	 * The tz_debugfs structure contains the list of the mitigation
   134	 * episodes and has to track which trip point has been crossed in
   135	 * order to handle correctly nested trip point mitigation episodes.
   136	 *
   137	 * We keep the history of the trip point crossed in an array and as we
   138	 * can go back and forth inside this history, eg. trip 0,1,2,1,2,1,0,
   139	 * we keep track of the current position in the history array.
   140	 *
   141	 * @tz_episode: a list of thermal mitigation episodes
   142	 * @trips_crossed: an array of trip points crossed by id
   143	 * @nr_trips: the number of trip points currently being crossed
   144	 */
   145	struct tz_debugfs {
   146		struct list_head tz_episodes;
   147		int *trips_crossed;
   148		int nr_trips;
 > 149	};
   150	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

