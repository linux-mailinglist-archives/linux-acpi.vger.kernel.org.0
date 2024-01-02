Return-Path: <linux-acpi+bounces-2677-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28A83822571
	for <lists+linux-acpi@lfdr.de>; Wed,  3 Jan 2024 00:20:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 34DA61C21A8E
	for <lists+linux-acpi@lfdr.de>; Tue,  2 Jan 2024 23:20:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E398F17740;
	Tue,  2 Jan 2024 23:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aHgUYL+H"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0AD51773D;
	Tue,  2 Jan 2024 23:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704237628; x=1735773628;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Ux+MBx3ndzvuSHoRhV99v9zK1ijm22s5cA4UAbiYEZs=;
  b=aHgUYL+H+qJsOVUfqheMfOTDQnHRkeQtFsXCPtUrNR5Fiu++HVLgeMb3
   3PwxyGlbvqtc38mM/kpBle0uNtQHeCguyStc7iwoatfUO+speW9iodb66
   g5l4m43cBDuiDyr2PjycUhzmOmx3V+Be6T6R5hKWIh7xR83blojrmQhu+
   EDEg5ISzmij+QEwqj78KXeB4P1W6Q+bH1gZupZLqgjbp4T7qHYBtItRwr
   A0AWo9fjE6W2SGqycob/6Mh5MVkFgemqCnxGPqT4dLuhxIs1NhH7mUbod
   lgzoyaulC/ZR34uvGPixZQ0QMfplhfopOREciBK7MP8mzf6po1yayjrrQ
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10941"; a="3768937"
X-IronPort-AV: E=Sophos;i="6.04,326,1695711600"; 
   d="scan'208";a="3768937"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jan 2024 15:20:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10941"; a="729622034"
X-IronPort-AV: E=Sophos;i="6.04,326,1695711600"; 
   d="scan'208";a="729622034"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 02 Jan 2024 15:20:22 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rKo3R-000LXM-1Q;
	Tue, 02 Jan 2024 23:20:19 +0000
Date: Wed, 3 Jan 2024 07:19:40 +0800
From: kernel test robot <lkp@intel.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: oe-kbuild-all@lists.linux.dev, linux-acpi@vger.kernel.org,
	devel@acpica.org, linux-pm@vger.kernel.org
Subject: [rafael-pm:bleeding-edge 154/159]
 drivers/thermal/intel/../thermal_netlink.h:27:20: warning: 'struct
 thermal_trip' declared inside parameter list will not be visible outside of
 this definition or declaration
Message-ID: <202401030734.oCkQjI4z-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
head:   b8a1fe5b94254945ed28a3f519e8ecd60e288871
commit: 1fccea663914c7d8e334904525b6696eef0f6345 [154/159] thermal: netlink: Pass pointers to thermal_notify_tz_trip_change()
config: i386-randconfig-005-20240102 (https://download.01.org/0day-ci/archive/20240103/202401030734.oCkQjI4z-lkp@intel.com/config)
compiler: gcc-7 (Ubuntu 7.5.0-6ubuntu2) 7.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240103/202401030734.oCkQjI4z-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202401030734.oCkQjI4z-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from drivers/thermal/intel/intel_hfi.c:46:0:
>> drivers/thermal/intel/../thermal_netlink.h:27:20: warning: 'struct thermal_trip' declared inside parameter list will not be visible outside of this definition or declaration
          const struct thermal_trip *trip);
                       ^~~~~~~~~~~~
>> drivers/thermal/intel/../thermal_netlink.h:26:48: warning: 'struct thermal_zone_device' declared inside parameter list will not be visible outside of this definition or declaration
    int thermal_notify_tz_trip_change(const struct thermal_zone_device *tz,
                                                   ^~~~~~~~~~~~~~~~~~~


vim +27 drivers/thermal/intel/../thermal_netlink.h

    12	
    13	/* Netlink notification function */
    14	#ifdef CONFIG_THERMAL_NETLINK
    15	int __init thermal_netlink_init(void);
    16	void __init thermal_netlink_exit(void);
    17	int thermal_notify_tz_create(int tz_id, const char *name);
    18	int thermal_notify_tz_delete(int tz_id);
    19	int thermal_notify_tz_enable(int tz_id);
    20	int thermal_notify_tz_disable(int tz_id);
    21	int thermal_notify_tz_trip_down(int tz_id, int id, int temp);
    22	int thermal_notify_tz_trip_up(int tz_id, int id, int temp);
    23	int thermal_notify_tz_trip_delete(int tz_id, int id);
    24	int thermal_notify_tz_trip_add(int tz_id, int id, int type,
    25				       int temp, int hyst);
  > 26	int thermal_notify_tz_trip_change(const struct thermal_zone_device *tz,
  > 27					  const struct thermal_trip *trip);
    28	int thermal_notify_cdev_state_update(int cdev_id, int state);
    29	int thermal_notify_cdev_add(int cdev_id, const char *name, int max_state);
    30	int thermal_notify_cdev_delete(int cdev_id);
    31	int thermal_notify_tz_gov_change(int tz_id, const char *name);
    32	int thermal_genl_sampling_temp(int id, int temp);
    33	int thermal_genl_cpu_capability_event(int count,
    34					      struct thermal_genl_cpu_caps *caps);
    35	#else
    36	static inline int thermal_netlink_init(void)
    37	{
    38		return 0;
    39	}
    40	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

