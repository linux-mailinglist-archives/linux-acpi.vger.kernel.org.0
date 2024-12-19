Return-Path: <linux-acpi+bounces-10183-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 94A8C9F73E2
	for <lists+linux-acpi@lfdr.de>; Thu, 19 Dec 2024 06:23:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C9FE616AC0E
	for <lists+linux-acpi@lfdr.de>; Thu, 19 Dec 2024 05:23:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6053415AD9C;
	Thu, 19 Dec 2024 05:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IRZUHHzD"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EA372594;
	Thu, 19 Dec 2024 05:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734585820; cv=none; b=qqzWOub6jQhmZoUCTY6vqaPkHhNEMpKf3DjmM+QZr3i6/KvmXQumUE9bq/25GWe36fGS4lvt7brFYamXd6cETycgWO3PF9PSswVfpKfI3aOD3fYdm1NHTq4xjSHN9OSWAe0YBQMaBJQcKxc1egTp+u+AG4+vO6V140IBETtbrNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734585820; c=relaxed/simple;
	bh=EZ9htCJS8wFg9Dd5HxCPAWDLRA8JxqldVUelIo0qS5w=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=OSfyZuWs4ugra8HQyWJxRNapFd8hmwUAFPCR+iUJ7mTz+1YFOs3fsEqrBoYxJ9ClRkftevL3BNK+XNC5hemG/AEfs9TggzvqirrfQ5/FhzNKD366ssEL5trHe4O/gByYhKfOnSLWVYEcAVxMKcKPwqEUDuZgO7NYDImSJ5pxI7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IRZUHHzD; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734585815; x=1766121815;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=EZ9htCJS8wFg9Dd5HxCPAWDLRA8JxqldVUelIo0qS5w=;
  b=IRZUHHzDJ+gzGB8G+1WjEUHiDbd4K9UmymNU1DFv/4MgJ5BURLZHTXlj
   Hkq5zc+kbOMS90jeav2+nppgr7+pLzqTqX0v+8zW5cepUV32f8ZP2Ni0b
   DmH7gx4FboTO54SBDsWT5Cn1z9/pUWo73lFo3vhzKptpNnDQsOmvEks9g
   lMrKZIEuRaO8+db1S3PqHdNPwCBkSHu4SZoit5K0k3nkcU/CsSDMI0HHY
   82Zxoy3B/n/GumGPcYalgF1TtudXYWlUx4tB9qFDm5SiX9U+xGwMPwhSV
   K1+BvN+7VFuiIxdppQ1SFT8Jvhvalx+q2PLtBsdtMkhuzgIm7Z4klojA7
   w==;
X-CSE-ConnectionGUID: jHPaBPxNQISjn0MNkKCimA==
X-CSE-MsgGUID: emItJenISgqz6qLTqH7IMg==
X-IronPort-AV: E=McAfee;i="6700,10204,11290"; a="34407897"
X-IronPort-AV: E=Sophos;i="6.12,246,1728975600"; 
   d="scan'208";a="34407897"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Dec 2024 21:23:34 -0800
X-CSE-ConnectionGUID: hVoEGkJzTqqqFPcEfvBX5A==
X-CSE-MsgGUID: cVkyLojcTiaiucWH597gig==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="98566285"
Received: from lkp-server01.sh.intel.com (HELO a46f226878e0) ([10.239.97.150])
  by orviesa007.jf.intel.com with ESMTP; 18 Dec 2024 21:23:32 -0800
Received: from kbuild by a46f226878e0 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tO90T-00003a-1e;
	Thu, 19 Dec 2024 05:23:29 +0000
Date: Thu, 19 Dec 2024 13:23:16 +0800
From: kernel test robot <lkp@intel.com>
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-acpi@vger.kernel.org,
	devel@acpica.org, linux-pm@vger.kernel.org,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [rafael-pm:bleeding-edge 37/51]
 drivers/thermal/thermal_netlink.c:1422: undefined reference to `nla_put'
Message-ID: <202412191303.LjwoI57j-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
head:   e2bbcfa0b21a5bb2cf1e5fff2f1336515fb228a9
commit: 4596cbea0ed2ef4f563a92775c9f612700ece145 [37/51] thermal: intel: Remove explicit user_space governor selection
config: i386-buildonly-randconfig-006-20241219 (https://download.01.org/0day-ci/archive/20241219/202412191303.LjwoI57j-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241219/202412191303.LjwoI57j-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202412191303.LjwoI57j-lkp@intel.com/

All errors (new ones prefixed by >>):

   ld: drivers/thermal/thermal_netlink.o: in function `nla_put_u32':
>> drivers/thermal/thermal_netlink.c:1422: undefined reference to `nla_put'
   ld: drivers/thermal/thermal_netlink.o: in function `nla_nest_start_noflag':
>> include/net/netlink.h:2193: undefined reference to `nla_put'
   ld: drivers/thermal/thermal_netlink.o: in function `nla_put_string':
   include/net/netlink.h:1620: undefined reference to `nla_put'
   ld: drivers/thermal/thermal_netlink.o: in function `nlmsg_trim':
>> include/net/netlink.h:1071: undefined reference to `skb_trim'
   ld: drivers/thermal/thermal_netlink.o: in function `thermal_genl_cmd_dumpit':
>> drivers/thermal/thermal_netlink.c:783: undefined reference to `genlmsg_put'
   ld: drivers/thermal/thermal_netlink.o: in function `genl_has_listeners':
>> include/net/genetlink.h:642: undefined reference to `init_net'
>> ld: include/net/genetlink.h:642: undefined reference to `netlink_has_listeners'
   ld: drivers/thermal/thermal_netlink.o: in function `alloc_skb':
>> include/linux/skbuff.h:1323: undefined reference to `__alloc_skb'
   ld: drivers/thermal/thermal_netlink.o: in function `kfree_skb_reason':
>> include/linux/skbuff.h:1263: undefined reference to `sk_skb_reason_drop'
   ld: drivers/thermal/thermal_netlink.o: in function `genlmsg_multicast_netns_filtered':
   include/net/genetlink.h:495: undefined reference to `init_net'
   ld: drivers/thermal/thermal_netlink.o: in function `nlmsg_multicast_filtered':
>> include/net/netlink.h:1128: undefined reference to `netlink_broadcast_filtered'
   ld: drivers/thermal/thermal_netlink.o: in function `thermal_genl_send_event':
   drivers/thermal/thermal_netlink.c:329: undefined reference to `genlmsg_put'
   ld: drivers/thermal/thermal_netlink.o: in function `genlmsg_put_reply':
>> include/net/genetlink.h:445: undefined reference to `genlmsg_put'
   ld: drivers/thermal/thermal_netlink.o: in function `nlmsg_unicast':
>> include/net/netlink.h:1161: undefined reference to `init_net'
>> ld: include/net/netlink.h:1161: undefined reference to `netlink_unicast'
   ld: drivers/thermal/thermal_netlink.o: in function `thermal_genl_sampling_temp':
   drivers/thermal/thermal_netlink.c:103: undefined reference to `genlmsg_put'
   ld: drivers/thermal/thermal_netlink.o: in function `thermal_netlink_init':
>> drivers/thermal/thermal_netlink.c:931: undefined reference to `genl_register_family'
   ld: drivers/thermal/thermal_netlink.o: in function `thermal_netlink_exit':
>> drivers/thermal/thermal_netlink.c:936: undefined reference to `genl_unregister_family'

Kconfig warnings: (for reference only)
   WARNING: unmet direct dependencies detected for THERMAL_NETLINK
   Depends on [n]: THERMAL [=y] && NET [=n]
   Selected by [y]:
   - X86_PKG_TEMP_THERMAL [=y] && THERMAL [=y] && (X86 [=y] || X86_INTEL_QUARK [=n] || COMPILE_TEST [=y]) && X86_THERMAL_VECTOR [=y]


vim +1422 drivers/thermal/thermal_netlink.c

1ce50e7d408ef2b Daniel Lezcano      2020-07-06    1  // SPDX-License-Identifier: GPL-2.0
1ce50e7d408ef2b Daniel Lezcano      2020-07-06    2  /*
1ce50e7d408ef2b Daniel Lezcano      2020-07-06    3   * Copyright 2020 Linaro Limited
1ce50e7d408ef2b Daniel Lezcano      2020-07-06    4   *
1ce50e7d408ef2b Daniel Lezcano      2020-07-06    5   * Author: Daniel Lezcano <daniel.lezcano@linaro.org>
1ce50e7d408ef2b Daniel Lezcano      2020-07-06    6   *
1ce50e7d408ef2b Daniel Lezcano      2020-07-06    7   * Generic netlink for thermal management framework
1ce50e7d408ef2b Daniel Lezcano      2020-07-06    8   */
1ce50e7d408ef2b Daniel Lezcano      2020-07-06    9  #include <linux/module.h>
cf580ad490514cc Stanislaw Gruszka   2024-02-23   10  #include <linux/notifier.h>
1ce50e7d408ef2b Daniel Lezcano      2020-07-06   11  #include <linux/kernel.h>
1773572863c43a1 Daniel Lezcano      2024-10-22   12  #include <net/sock.h>
1ce50e7d408ef2b Daniel Lezcano      2020-07-06   13  #include <net/genetlink.h>
1ce50e7d408ef2b Daniel Lezcano      2020-07-06   14  #include <uapi/linux/thermal.h>
1ce50e7d408ef2b Daniel Lezcano      2020-07-06   15  
1ce50e7d408ef2b Daniel Lezcano      2020-07-06   16  #include "thermal_core.h"
1ce50e7d408ef2b Daniel Lezcano      2020-07-06   17  
1ce50e7d408ef2b Daniel Lezcano      2020-07-06   18  static const struct genl_multicast_group thermal_genl_mcgrps[] = {
5eb4f413ad60db7 Stanislaw Gruszka   2023-12-28   19  	[THERMAL_GENL_SAMPLING_GROUP] = { .name = THERMAL_GENL_SAMPLING_GROUP_NAME, },
5eb4f413ad60db7 Stanislaw Gruszka   2023-12-28   20  	[THERMAL_GENL_EVENT_GROUP]  = { .name = THERMAL_GENL_EVENT_GROUP_NAME,  },
1ce50e7d408ef2b Daniel Lezcano      2020-07-06   21  };
1ce50e7d408ef2b Daniel Lezcano      2020-07-06   22  
1ce50e7d408ef2b Daniel Lezcano      2020-07-06   23  static const struct nla_policy thermal_genl_policy[THERMAL_GENL_ATTR_MAX + 1] = {
1ce50e7d408ef2b Daniel Lezcano      2020-07-06   24  	/* Thermal zone */
1ce50e7d408ef2b Daniel Lezcano      2020-07-06   25  	[THERMAL_GENL_ATTR_TZ]			= { .type = NLA_NESTED },
1ce50e7d408ef2b Daniel Lezcano      2020-07-06   26  	[THERMAL_GENL_ATTR_TZ_ID]		= { .type = NLA_U32 },
1ce50e7d408ef2b Daniel Lezcano      2020-07-06   27  	[THERMAL_GENL_ATTR_TZ_TEMP]		= { .type = NLA_U32 },
1ce50e7d408ef2b Daniel Lezcano      2020-07-06   28  	[THERMAL_GENL_ATTR_TZ_TRIP]		= { .type = NLA_NESTED },
1ce50e7d408ef2b Daniel Lezcano      2020-07-06   29  	[THERMAL_GENL_ATTR_TZ_TRIP_ID]		= { .type = NLA_U32 },
1ce50e7d408ef2b Daniel Lezcano      2020-07-06   30  	[THERMAL_GENL_ATTR_TZ_TRIP_TEMP]	= { .type = NLA_U32 },
1ce50e7d408ef2b Daniel Lezcano      2020-07-06   31  	[THERMAL_GENL_ATTR_TZ_TRIP_TYPE]	= { .type = NLA_U32 },
1ce50e7d408ef2b Daniel Lezcano      2020-07-06   32  	[THERMAL_GENL_ATTR_TZ_TRIP_HYST]	= { .type = NLA_U32 },
1ce50e7d408ef2b Daniel Lezcano      2020-07-06   33  	[THERMAL_GENL_ATTR_TZ_MODE]		= { .type = NLA_U32 },
1ce50e7d408ef2b Daniel Lezcano      2020-07-06   34  	[THERMAL_GENL_ATTR_TZ_CDEV_WEIGHT]	= { .type = NLA_U32 },
1ce50e7d408ef2b Daniel Lezcano      2020-07-06   35  	[THERMAL_GENL_ATTR_TZ_NAME]		= { .type = NLA_STRING,
1ce50e7d408ef2b Daniel Lezcano      2020-07-06   36  						    .len = THERMAL_NAME_LENGTH },
1ce50e7d408ef2b Daniel Lezcano      2020-07-06   37  	/* Governor(s) */
1ce50e7d408ef2b Daniel Lezcano      2020-07-06   38  	[THERMAL_GENL_ATTR_TZ_GOV]		= { .type = NLA_NESTED },
1ce50e7d408ef2b Daniel Lezcano      2020-07-06   39  	[THERMAL_GENL_ATTR_TZ_GOV_NAME]		= { .type = NLA_STRING,
1ce50e7d408ef2b Daniel Lezcano      2020-07-06   40  						    .len = THERMAL_NAME_LENGTH },
1ce50e7d408ef2b Daniel Lezcano      2020-07-06   41  	/* Cooling devices */
1ce50e7d408ef2b Daniel Lezcano      2020-07-06   42  	[THERMAL_GENL_ATTR_CDEV]		= { .type = NLA_NESTED },
1ce50e7d408ef2b Daniel Lezcano      2020-07-06   43  	[THERMAL_GENL_ATTR_CDEV_ID]		= { .type = NLA_U32 },
1ce50e7d408ef2b Daniel Lezcano      2020-07-06   44  	[THERMAL_GENL_ATTR_CDEV_CUR_STATE]	= { .type = NLA_U32 },
1ce50e7d408ef2b Daniel Lezcano      2020-07-06   45  	[THERMAL_GENL_ATTR_CDEV_MAX_STATE]	= { .type = NLA_U32 },
1ce50e7d408ef2b Daniel Lezcano      2020-07-06   46  	[THERMAL_GENL_ATTR_CDEV_NAME]		= { .type = NLA_STRING,
1ce50e7d408ef2b Daniel Lezcano      2020-07-06   47  						    .len = THERMAL_NAME_LENGTH },
e4b1eb24ce5a696 Srinivas Pandruvada 2022-01-27   48  	/* CPU capabilities */
e4b1eb24ce5a696 Srinivas Pandruvada 2022-01-27   49  	[THERMAL_GENL_ATTR_CPU_CAPABILITY]		= { .type = NLA_NESTED },
e4b1eb24ce5a696 Srinivas Pandruvada 2022-01-27   50  	[THERMAL_GENL_ATTR_CPU_CAPABILITY_ID]		= { .type = NLA_U32 },
e4b1eb24ce5a696 Srinivas Pandruvada 2022-01-27   51  	[THERMAL_GENL_ATTR_CPU_CAPABILITY_PERFORMANCE]	= { .type = NLA_U32 },
e4b1eb24ce5a696 Srinivas Pandruvada 2022-01-27   52  	[THERMAL_GENL_ATTR_CPU_CAPABILITY_EFFICIENCY]	= { .type = NLA_U32 },
1773572863c43a1 Daniel Lezcano      2024-10-22   53  
1773572863c43a1 Daniel Lezcano      2024-10-22   54  	/* Thresholds */
1773572863c43a1 Daniel Lezcano      2024-10-22   55  	[THERMAL_GENL_ATTR_THRESHOLD]		= { .type = NLA_NESTED },
1773572863c43a1 Daniel Lezcano      2024-10-22   56  	[THERMAL_GENL_ATTR_THRESHOLD_TEMP]	= { .type = NLA_U32 },
1773572863c43a1 Daniel Lezcano      2024-10-22   57  	[THERMAL_GENL_ATTR_THRESHOLD_DIRECTION]	= { .type = NLA_U32 },
1ce50e7d408ef2b Daniel Lezcano      2020-07-06   58  };
1ce50e7d408ef2b Daniel Lezcano      2020-07-06   59  
1ce50e7d408ef2b Daniel Lezcano      2020-07-06   60  struct param {
1ce50e7d408ef2b Daniel Lezcano      2020-07-06   61  	struct nlattr **attrs;
1ce50e7d408ef2b Daniel Lezcano      2020-07-06   62  	struct sk_buff *msg;
1ce50e7d408ef2b Daniel Lezcano      2020-07-06   63  	const char *name;
1ce50e7d408ef2b Daniel Lezcano      2020-07-06   64  	int tz_id;
1ce50e7d408ef2b Daniel Lezcano      2020-07-06   65  	int cdev_id;
1ce50e7d408ef2b Daniel Lezcano      2020-07-06   66  	int trip_id;
1ce50e7d408ef2b Daniel Lezcano      2020-07-06   67  	int trip_temp;
1ce50e7d408ef2b Daniel Lezcano      2020-07-06   68  	int trip_type;
1ce50e7d408ef2b Daniel Lezcano      2020-07-06   69  	int trip_hyst;
1ce50e7d408ef2b Daniel Lezcano      2020-07-06   70  	int temp;
1773572863c43a1 Daniel Lezcano      2024-10-22   71  	int prev_temp;
1773572863c43a1 Daniel Lezcano      2024-10-22   72  	int direction;
1ce50e7d408ef2b Daniel Lezcano      2020-07-06   73  	int cdev_state;
1ce50e7d408ef2b Daniel Lezcano      2020-07-06   74  	int cdev_max_state;
e4b1eb24ce5a696 Srinivas Pandruvada 2022-01-27   75  	struct thermal_genl_cpu_caps *cpu_capabilities;
e4b1eb24ce5a696 Srinivas Pandruvada 2022-01-27   76  	int cpu_capabilities_count;
1ce50e7d408ef2b Daniel Lezcano      2020-07-06   77  };
1ce50e7d408ef2b Daniel Lezcano      2020-07-06   78  
1ce50e7d408ef2b Daniel Lezcano      2020-07-06   79  typedef int (*cb_t)(struct param *);
1ce50e7d408ef2b Daniel Lezcano      2020-07-06   80  
afdaff3706918b7 Stanislaw Gruszka   2024-02-23   81  static struct genl_family thermal_genl_family;
cf580ad490514cc Stanislaw Gruszka   2024-02-23   82  static BLOCKING_NOTIFIER_HEAD(thermal_genl_chain);
1ce50e7d408ef2b Daniel Lezcano      2020-07-06   83  
04c3b03044034ce Stanislaw Gruszka   2023-12-28   84  static int thermal_group_has_listeners(enum thermal_genl_multicast_groups group)
04c3b03044034ce Stanislaw Gruszka   2023-12-28   85  {
afdaff3706918b7 Stanislaw Gruszka   2024-02-23   86  	return genl_has_listeners(&thermal_genl_family, &init_net, group);
04c3b03044034ce Stanislaw Gruszka   2023-12-28   87  }
04c3b03044034ce Stanislaw Gruszka   2023-12-28   88  
1ce50e7d408ef2b Daniel Lezcano      2020-07-06   89  /************************** Sampling encoding *******************************/
1ce50e7d408ef2b Daniel Lezcano      2020-07-06   90  
1ce50e7d408ef2b Daniel Lezcano      2020-07-06   91  int thermal_genl_sampling_temp(int id, int temp)
1ce50e7d408ef2b Daniel Lezcano      2020-07-06   92  {
1ce50e7d408ef2b Daniel Lezcano      2020-07-06   93  	struct sk_buff *skb;
1ce50e7d408ef2b Daniel Lezcano      2020-07-06   94  	void *hdr;
1ce50e7d408ef2b Daniel Lezcano      2020-07-06   95  
04c3b03044034ce Stanislaw Gruszka   2023-12-28   96  	if (!thermal_group_has_listeners(THERMAL_GENL_SAMPLING_GROUP))
04c3b03044034ce Stanislaw Gruszka   2023-12-28   97  		return 0;
04c3b03044034ce Stanislaw Gruszka   2023-12-28   98  
1ce50e7d408ef2b Daniel Lezcano      2020-07-06   99  	skb = genlmsg_new(NLMSG_GOODSIZE, GFP_KERNEL);
1ce50e7d408ef2b Daniel Lezcano      2020-07-06  100  	if (!skb)
1ce50e7d408ef2b Daniel Lezcano      2020-07-06  101  		return -ENOMEM;
1ce50e7d408ef2b Daniel Lezcano      2020-07-06  102  
afdaff3706918b7 Stanislaw Gruszka   2024-02-23  103  	hdr = genlmsg_put(skb, 0, 0, &thermal_genl_family, 0,
1ce50e7d408ef2b Daniel Lezcano      2020-07-06  104  			  THERMAL_GENL_SAMPLING_TEMP);
1ce50e7d408ef2b Daniel Lezcano      2020-07-06  105  	if (!hdr)
48b458591749d35 Jing Xiangfeng      2020-09-29  106  		goto out_free;
1ce50e7d408ef2b Daniel Lezcano      2020-07-06  107  
1ce50e7d408ef2b Daniel Lezcano      2020-07-06  108  	if (nla_put_u32(skb, THERMAL_GENL_ATTR_TZ_ID, id))
1ce50e7d408ef2b Daniel Lezcano      2020-07-06  109  		goto out_cancel;
1ce50e7d408ef2b Daniel Lezcano      2020-07-06  110  
1ce50e7d408ef2b Daniel Lezcano      2020-07-06  111  	if (nla_put_u32(skb, THERMAL_GENL_ATTR_TZ_TEMP, temp))
1ce50e7d408ef2b Daniel Lezcano      2020-07-06  112  		goto out_cancel;
1ce50e7d408ef2b Daniel Lezcano      2020-07-06  113  
1ce50e7d408ef2b Daniel Lezcano      2020-07-06  114  	genlmsg_end(skb, hdr);
1ce50e7d408ef2b Daniel Lezcano      2020-07-06  115  
afdaff3706918b7 Stanislaw Gruszka   2024-02-23  116  	genlmsg_multicast(&thermal_genl_family, skb, 0, THERMAL_GENL_SAMPLING_GROUP, GFP_KERNEL);
1ce50e7d408ef2b Daniel Lezcano      2020-07-06  117  
1ce50e7d408ef2b Daniel Lezcano      2020-07-06  118  	return 0;
1ce50e7d408ef2b Daniel Lezcano      2020-07-06  119  out_cancel:
1ce50e7d408ef2b Daniel Lezcano      2020-07-06  120  	genlmsg_cancel(skb, hdr);
48b458591749d35 Jing Xiangfeng      2020-09-29  121  out_free:
1ce50e7d408ef2b Daniel Lezcano      2020-07-06  122  	nlmsg_free(skb);
1ce50e7d408ef2b Daniel Lezcano      2020-07-06  123  
1ce50e7d408ef2b Daniel Lezcano      2020-07-06  124  	return -EMSGSIZE;
1ce50e7d408ef2b Daniel Lezcano      2020-07-06  125  }
1ce50e7d408ef2b Daniel Lezcano      2020-07-06  126  
1ce50e7d408ef2b Daniel Lezcano      2020-07-06  127  /**************************** Event encoding *********************************/
1ce50e7d408ef2b Daniel Lezcano      2020-07-06  128  
1ce50e7d408ef2b Daniel Lezcano      2020-07-06  129  static int thermal_genl_event_tz_create(struct param *p)
1ce50e7d408ef2b Daniel Lezcano      2020-07-06  130  {
1ce50e7d408ef2b Daniel Lezcano      2020-07-06  131  	if (nla_put_u32(p->msg, THERMAL_GENL_ATTR_TZ_ID, p->tz_id) ||
1ce50e7d408ef2b Daniel Lezcano      2020-07-06  132  	    nla_put_string(p->msg, THERMAL_GENL_ATTR_TZ_NAME, p->name))
1ce50e7d408ef2b Daniel Lezcano      2020-07-06  133  		return -EMSGSIZE;
1ce50e7d408ef2b Daniel Lezcano      2020-07-06  134  
1ce50e7d408ef2b Daniel Lezcano      2020-07-06  135  	return 0;
1ce50e7d408ef2b Daniel Lezcano      2020-07-06  136  }
1ce50e7d408ef2b Daniel Lezcano      2020-07-06  137  
1ce50e7d408ef2b Daniel Lezcano      2020-07-06  138  static int thermal_genl_event_tz(struct param *p)
1ce50e7d408ef2b Daniel Lezcano      2020-07-06  139  {
1ce50e7d408ef2b Daniel Lezcano      2020-07-06  140  	if (nla_put_u32(p->msg, THERMAL_GENL_ATTR_TZ_ID, p->tz_id))
1ce50e7d408ef2b Daniel Lezcano      2020-07-06  141  		return -EMSGSIZE;
1ce50e7d408ef2b Daniel Lezcano      2020-07-06  142  
1ce50e7d408ef2b Daniel Lezcano      2020-07-06  143  	return 0;
1ce50e7d408ef2b Daniel Lezcano      2020-07-06  144  }
1ce50e7d408ef2b Daniel Lezcano      2020-07-06  145  
1ce50e7d408ef2b Daniel Lezcano      2020-07-06  146  static int thermal_genl_event_tz_trip_up(struct param *p)
1ce50e7d408ef2b Daniel Lezcano      2020-07-06  147  {
1ce50e7d408ef2b Daniel Lezcano      2020-07-06  148  	if (nla_put_u32(p->msg, THERMAL_GENL_ATTR_TZ_ID, p->tz_id) ||
fc656fa14da7865 Daniel Lezcano      2021-10-02  149  	    nla_put_u32(p->msg, THERMAL_GENL_ATTR_TZ_TRIP_ID, p->trip_id) ||
fc656fa14da7865 Daniel Lezcano      2021-10-02  150  	    nla_put_u32(p->msg, THERMAL_GENL_ATTR_TZ_TEMP, p->temp))
1ce50e7d408ef2b Daniel Lezcano      2020-07-06  151  		return -EMSGSIZE;
1ce50e7d408ef2b Daniel Lezcano      2020-07-06  152  
1ce50e7d408ef2b Daniel Lezcano      2020-07-06  153  	return 0;
1ce50e7d408ef2b Daniel Lezcano      2020-07-06  154  }
1ce50e7d408ef2b Daniel Lezcano      2020-07-06  155  
4ae535f37d0e3c5 Rafael J. Wysocki   2023-12-15  156  static int thermal_genl_event_tz_trip_change(struct param *p)
1ce50e7d408ef2b Daniel Lezcano      2020-07-06  157  {
1ce50e7d408ef2b Daniel Lezcano      2020-07-06  158  	if (nla_put_u32(p->msg, THERMAL_GENL_ATTR_TZ_ID, p->tz_id) ||
1ce50e7d408ef2b Daniel Lezcano      2020-07-06  159  	    nla_put_u32(p->msg, THERMAL_GENL_ATTR_TZ_TRIP_ID, p->trip_id) ||
1ce50e7d408ef2b Daniel Lezcano      2020-07-06  160  	    nla_put_u32(p->msg, THERMAL_GENL_ATTR_TZ_TRIP_TYPE, p->trip_type) ||
1ce50e7d408ef2b Daniel Lezcano      2020-07-06  161  	    nla_put_u32(p->msg, THERMAL_GENL_ATTR_TZ_TRIP_TEMP, p->trip_temp) ||
1ce50e7d408ef2b Daniel Lezcano      2020-07-06  162  	    nla_put_u32(p->msg, THERMAL_GENL_ATTR_TZ_TRIP_HYST, p->trip_hyst))
1ce50e7d408ef2b Daniel Lezcano      2020-07-06  163  		return -EMSGSIZE;
1ce50e7d408ef2b Daniel Lezcano      2020-07-06  164  
1ce50e7d408ef2b Daniel Lezcano      2020-07-06  165  	return 0;
1ce50e7d408ef2b Daniel Lezcano      2020-07-06  166  }
1ce50e7d408ef2b Daniel Lezcano      2020-07-06  167  
1ce50e7d408ef2b Daniel Lezcano      2020-07-06  168  static int thermal_genl_event_cdev_add(struct param *p)
1ce50e7d408ef2b Daniel Lezcano      2020-07-06  169  {
1ce50e7d408ef2b Daniel Lezcano      2020-07-06  170  	if (nla_put_string(p->msg, THERMAL_GENL_ATTR_CDEV_NAME,
1ce50e7d408ef2b Daniel Lezcano      2020-07-06  171  			   p->name) ||
1ce50e7d408ef2b Daniel Lezcano      2020-07-06  172  	    nla_put_u32(p->msg, THERMAL_GENL_ATTR_CDEV_ID,
1ce50e7d408ef2b Daniel Lezcano      2020-07-06  173  			p->cdev_id) ||
1ce50e7d408ef2b Daniel Lezcano      2020-07-06  174  	    nla_put_u32(p->msg, THERMAL_GENL_ATTR_CDEV_MAX_STATE,
1ce50e7d408ef2b Daniel Lezcano      2020-07-06  175  			p->cdev_max_state))
1ce50e7d408ef2b Daniel Lezcano      2020-07-06  176  		return -EMSGSIZE;
1ce50e7d408ef2b Daniel Lezcano      2020-07-06  177  
1ce50e7d408ef2b Daniel Lezcano      2020-07-06  178  	return 0;
1ce50e7d408ef2b Daniel Lezcano      2020-07-06  179  }
1ce50e7d408ef2b Daniel Lezcano      2020-07-06  180  
1ce50e7d408ef2b Daniel Lezcano      2020-07-06  181  static int thermal_genl_event_cdev_delete(struct param *p)
1ce50e7d408ef2b Daniel Lezcano      2020-07-06  182  {
1ce50e7d408ef2b Daniel Lezcano      2020-07-06  183  	if (nla_put_u32(p->msg, THERMAL_GENL_ATTR_CDEV_ID, p->cdev_id))
1ce50e7d408ef2b Daniel Lezcano      2020-07-06  184  		return -EMSGSIZE;
1ce50e7d408ef2b Daniel Lezcano      2020-07-06  185  
1ce50e7d408ef2b Daniel Lezcano      2020-07-06  186  	return 0;
1ce50e7d408ef2b Daniel Lezcano      2020-07-06  187  }
1ce50e7d408ef2b Daniel Lezcano      2020-07-06  188  
1ce50e7d408ef2b Daniel Lezcano      2020-07-06  189  static int thermal_genl_event_cdev_state_update(struct param *p)
1ce50e7d408ef2b Daniel Lezcano      2020-07-06  190  {
1ce50e7d408ef2b Daniel Lezcano      2020-07-06  191  	if (nla_put_u32(p->msg, THERMAL_GENL_ATTR_CDEV_ID,
1ce50e7d408ef2b Daniel Lezcano      2020-07-06  192  			p->cdev_id) ||
1ce50e7d408ef2b Daniel Lezcano      2020-07-06  193  	    nla_put_u32(p->msg, THERMAL_GENL_ATTR_CDEV_CUR_STATE,
1ce50e7d408ef2b Daniel Lezcano      2020-07-06  194  			p->cdev_state))
1ce50e7d408ef2b Daniel Lezcano      2020-07-06  195  		return -EMSGSIZE;
1ce50e7d408ef2b Daniel Lezcano      2020-07-06  196  
1ce50e7d408ef2b Daniel Lezcano      2020-07-06  197  	return 0;
1ce50e7d408ef2b Daniel Lezcano      2020-07-06  198  }
1ce50e7d408ef2b Daniel Lezcano      2020-07-06  199  
1ce50e7d408ef2b Daniel Lezcano      2020-07-06  200  static int thermal_genl_event_gov_change(struct param *p)
1ce50e7d408ef2b Daniel Lezcano      2020-07-06  201  {
1ce50e7d408ef2b Daniel Lezcano      2020-07-06  202  	if (nla_put_u32(p->msg, THERMAL_GENL_ATTR_TZ_ID, p->tz_id) ||
1ce50e7d408ef2b Daniel Lezcano      2020-07-06  203  	    nla_put_string(p->msg, THERMAL_GENL_ATTR_GOV_NAME, p->name))
1ce50e7d408ef2b Daniel Lezcano      2020-07-06  204  		return -EMSGSIZE;
1ce50e7d408ef2b Daniel Lezcano      2020-07-06  205  
1ce50e7d408ef2b Daniel Lezcano      2020-07-06  206  	return 0;
1ce50e7d408ef2b Daniel Lezcano      2020-07-06  207  }
1ce50e7d408ef2b Daniel Lezcano      2020-07-06  208  
e4b1eb24ce5a696 Srinivas Pandruvada 2022-01-27  209  static int thermal_genl_event_cpu_capability_change(struct param *p)
e4b1eb24ce5a696 Srinivas Pandruvada 2022-01-27  210  {
e4b1eb24ce5a696 Srinivas Pandruvada 2022-01-27  211  	struct thermal_genl_cpu_caps *cpu_cap = p->cpu_capabilities;
e4b1eb24ce5a696 Srinivas Pandruvada 2022-01-27  212  	struct sk_buff *msg = p->msg;
e4b1eb24ce5a696 Srinivas Pandruvada 2022-01-27  213  	struct nlattr *start_cap;
e4b1eb24ce5a696 Srinivas Pandruvada 2022-01-27  214  	int i;
e4b1eb24ce5a696 Srinivas Pandruvada 2022-01-27  215  
e4b1eb24ce5a696 Srinivas Pandruvada 2022-01-27  216  	start_cap = nla_nest_start(msg, THERMAL_GENL_ATTR_CPU_CAPABILITY);
e4b1eb24ce5a696 Srinivas Pandruvada 2022-01-27  217  	if (!start_cap)
e4b1eb24ce5a696 Srinivas Pandruvada 2022-01-27  218  		return -EMSGSIZE;
e4b1eb24ce5a696 Srinivas Pandruvada 2022-01-27  219  
e4b1eb24ce5a696 Srinivas Pandruvada 2022-01-27  220  	for (i = 0; i < p->cpu_capabilities_count; ++i) {
e4b1eb24ce5a696 Srinivas Pandruvada 2022-01-27  221  		if (nla_put_u32(msg, THERMAL_GENL_ATTR_CPU_CAPABILITY_ID,
e4b1eb24ce5a696 Srinivas Pandruvada 2022-01-27  222  				cpu_cap->cpu))
e4b1eb24ce5a696 Srinivas Pandruvada 2022-01-27  223  			goto out_cancel_nest;
e4b1eb24ce5a696 Srinivas Pandruvada 2022-01-27  224  
e4b1eb24ce5a696 Srinivas Pandruvada 2022-01-27  225  		if (nla_put_u32(msg, THERMAL_GENL_ATTR_CPU_CAPABILITY_PERFORMANCE,
e4b1eb24ce5a696 Srinivas Pandruvada 2022-01-27  226  				cpu_cap->performance))
e4b1eb24ce5a696 Srinivas Pandruvada 2022-01-27  227  			goto out_cancel_nest;
e4b1eb24ce5a696 Srinivas Pandruvada 2022-01-27  228  
e4b1eb24ce5a696 Srinivas Pandruvada 2022-01-27  229  		if (nla_put_u32(msg, THERMAL_GENL_ATTR_CPU_CAPABILITY_EFFICIENCY,
e4b1eb24ce5a696 Srinivas Pandruvada 2022-01-27  230  				cpu_cap->efficiency))
e4b1eb24ce5a696 Srinivas Pandruvada 2022-01-27  231  			goto out_cancel_nest;
e4b1eb24ce5a696 Srinivas Pandruvada 2022-01-27  232  
e4b1eb24ce5a696 Srinivas Pandruvada 2022-01-27  233  		++cpu_cap;
e4b1eb24ce5a696 Srinivas Pandruvada 2022-01-27  234  	}
e4b1eb24ce5a696 Srinivas Pandruvada 2022-01-27  235  
e4b1eb24ce5a696 Srinivas Pandruvada 2022-01-27  236  	nla_nest_end(msg, start_cap);
e4b1eb24ce5a696 Srinivas Pandruvada 2022-01-27  237  
e4b1eb24ce5a696 Srinivas Pandruvada 2022-01-27  238  	return 0;
e4b1eb24ce5a696 Srinivas Pandruvada 2022-01-27  239  out_cancel_nest:
e4b1eb24ce5a696 Srinivas Pandruvada 2022-01-27  240  	nla_nest_cancel(msg, start_cap);
e4b1eb24ce5a696 Srinivas Pandruvada 2022-01-27  241  
e4b1eb24ce5a696 Srinivas Pandruvada 2022-01-27  242  	return -EMSGSIZE;
e4b1eb24ce5a696 Srinivas Pandruvada 2022-01-27  243  }
e4b1eb24ce5a696 Srinivas Pandruvada 2022-01-27  244  
1773572863c43a1 Daniel Lezcano      2024-10-22  245  static int thermal_genl_event_threshold_add(struct param *p)
1773572863c43a1 Daniel Lezcano      2024-10-22  246  {
1773572863c43a1 Daniel Lezcano      2024-10-22  247  	if (nla_put_u32(p->msg, THERMAL_GENL_ATTR_TZ_ID, p->tz_id) ||
1773572863c43a1 Daniel Lezcano      2024-10-22  248  	    nla_put_u32(p->msg, THERMAL_GENL_ATTR_THRESHOLD_TEMP, p->temp) ||
1773572863c43a1 Daniel Lezcano      2024-10-22  249  	    nla_put_u32(p->msg, THERMAL_GENL_ATTR_THRESHOLD_DIRECTION, p->direction))
1773572863c43a1 Daniel Lezcano      2024-10-22  250  		return -EMSGSIZE;
1773572863c43a1 Daniel Lezcano      2024-10-22  251  
1773572863c43a1 Daniel Lezcano      2024-10-22  252  	return 0;
1773572863c43a1 Daniel Lezcano      2024-10-22  253  }
1773572863c43a1 Daniel Lezcano      2024-10-22  254  
1773572863c43a1 Daniel Lezcano      2024-10-22  255  static int thermal_genl_event_threshold_flush(struct param *p)
1773572863c43a1 Daniel Lezcano      2024-10-22  256  {
1773572863c43a1 Daniel Lezcano      2024-10-22  257  	if (nla_put_u32(p->msg, THERMAL_GENL_ATTR_TZ_ID, p->tz_id))
1773572863c43a1 Daniel Lezcano      2024-10-22  258  		return -EMSGSIZE;
1773572863c43a1 Daniel Lezcano      2024-10-22  259  
1773572863c43a1 Daniel Lezcano      2024-10-22  260  	return 0;
1773572863c43a1 Daniel Lezcano      2024-10-22  261  }
1773572863c43a1 Daniel Lezcano      2024-10-22  262  
1773572863c43a1 Daniel Lezcano      2024-10-22  263  static int thermal_genl_event_threshold_up(struct param *p)
1773572863c43a1 Daniel Lezcano      2024-10-22  264  {
1773572863c43a1 Daniel Lezcano      2024-10-22  265  	if (nla_put_u32(p->msg, THERMAL_GENL_ATTR_TZ_ID, p->tz_id) ||
1773572863c43a1 Daniel Lezcano      2024-10-22  266  	    nla_put_u32(p->msg, THERMAL_GENL_ATTR_TZ_PREV_TEMP, p->prev_temp) ||
1773572863c43a1 Daniel Lezcano      2024-10-22  267  	    nla_put_u32(p->msg, THERMAL_GENL_ATTR_TZ_TEMP, p->temp))
1773572863c43a1 Daniel Lezcano      2024-10-22  268  		return -EMSGSIZE;
1773572863c43a1 Daniel Lezcano      2024-10-22  269  
1773572863c43a1 Daniel Lezcano      2024-10-22  270  	return 0;
1773572863c43a1 Daniel Lezcano      2024-10-22  271  }
1773572863c43a1 Daniel Lezcano      2024-10-22  272  
1ce50e7d408ef2b Daniel Lezcano      2020-07-06  273  int thermal_genl_event_tz_delete(struct param *p)
1ce50e7d408ef2b Daniel Lezcano      2020-07-06  274  	__attribute__((alias("thermal_genl_event_tz")));
1ce50e7d408ef2b Daniel Lezcano      2020-07-06  275  
1ce50e7d408ef2b Daniel Lezcano      2020-07-06  276  int thermal_genl_event_tz_enable(struct param *p)
1ce50e7d408ef2b Daniel Lezcano      2020-07-06  277  	__attribute__((alias("thermal_genl_event_tz")));
1ce50e7d408ef2b Daniel Lezcano      2020-07-06  278  
1ce50e7d408ef2b Daniel Lezcano      2020-07-06  279  int thermal_genl_event_tz_disable(struct param *p)
1ce50e7d408ef2b Daniel Lezcano      2020-07-06  280  	__attribute__((alias("thermal_genl_event_tz")));
1ce50e7d408ef2b Daniel Lezcano      2020-07-06  281  
1ce50e7d408ef2b Daniel Lezcano      2020-07-06  282  int thermal_genl_event_tz_trip_down(struct param *p)
1ce50e7d408ef2b Daniel Lezcano      2020-07-06  283  	__attribute__((alias("thermal_genl_event_tz_trip_up")));
1ce50e7d408ef2b Daniel Lezcano      2020-07-06  284  
1773572863c43a1 Daniel Lezcano      2024-10-22  285  int thermal_genl_event_threshold_delete(struct param *p)
1773572863c43a1 Daniel Lezcano      2024-10-22  286  	__attribute__((alias("thermal_genl_event_threshold_add")));
1773572863c43a1 Daniel Lezcano      2024-10-22  287  
1773572863c43a1 Daniel Lezcano      2024-10-22  288  int thermal_genl_event_threshold_down(struct param *p)
1773572863c43a1 Daniel Lezcano      2024-10-22  289  	__attribute__((alias("thermal_genl_event_threshold_up")));
1773572863c43a1 Daniel Lezcano      2024-10-22  290  
1ce50e7d408ef2b Daniel Lezcano      2020-07-06  291  static cb_t event_cb[] = {
1ce50e7d408ef2b Daniel Lezcano      2020-07-06  292  	[THERMAL_GENL_EVENT_TZ_CREATE]		= thermal_genl_event_tz_create,
1ce50e7d408ef2b Daniel Lezcano      2020-07-06  293  	[THERMAL_GENL_EVENT_TZ_DELETE]		= thermal_genl_event_tz_delete,
1ce50e7d408ef2b Daniel Lezcano      2020-07-06  294  	[THERMAL_GENL_EVENT_TZ_ENABLE]		= thermal_genl_event_tz_enable,
1ce50e7d408ef2b Daniel Lezcano      2020-07-06  295  	[THERMAL_GENL_EVENT_TZ_DISABLE]		= thermal_genl_event_tz_disable,
1ce50e7d408ef2b Daniel Lezcano      2020-07-06  296  	[THERMAL_GENL_EVENT_TZ_TRIP_UP]		= thermal_genl_event_tz_trip_up,
1ce50e7d408ef2b Daniel Lezcano      2020-07-06  297  	[THERMAL_GENL_EVENT_TZ_TRIP_DOWN]	= thermal_genl_event_tz_trip_down,
1ce50e7d408ef2b Daniel Lezcano      2020-07-06  298  	[THERMAL_GENL_EVENT_TZ_TRIP_CHANGE]	= thermal_genl_event_tz_trip_change,
1ce50e7d408ef2b Daniel Lezcano      2020-07-06  299  	[THERMAL_GENL_EVENT_CDEV_ADD]		= thermal_genl_event_cdev_add,
1ce50e7d408ef2b Daniel Lezcano      2020-07-06  300  	[THERMAL_GENL_EVENT_CDEV_DELETE]	= thermal_genl_event_cdev_delete,
1ce50e7d408ef2b Daniel Lezcano      2020-07-06  301  	[THERMAL_GENL_EVENT_CDEV_STATE_UPDATE]	= thermal_genl_event_cdev_state_update,
1ce50e7d408ef2b Daniel Lezcano      2020-07-06  302  	[THERMAL_GENL_EVENT_TZ_GOV_CHANGE]	= thermal_genl_event_gov_change,
e4b1eb24ce5a696 Srinivas Pandruvada 2022-01-27  303  	[THERMAL_GENL_EVENT_CPU_CAPABILITY_CHANGE] = thermal_genl_event_cpu_capability_change,
1773572863c43a1 Daniel Lezcano      2024-10-22  304  	[THERMAL_GENL_EVENT_THRESHOLD_ADD]	= thermal_genl_event_threshold_add,
1773572863c43a1 Daniel Lezcano      2024-10-22  305  	[THERMAL_GENL_EVENT_THRESHOLD_DELETE]	= thermal_genl_event_threshold_delete,
1773572863c43a1 Daniel Lezcano      2024-10-22  306  	[THERMAL_GENL_EVENT_THRESHOLD_FLUSH]	= thermal_genl_event_threshold_flush,
1773572863c43a1 Daniel Lezcano      2024-10-22  307  	[THERMAL_GENL_EVENT_THRESHOLD_DOWN]	= thermal_genl_event_threshold_down,
1773572863c43a1 Daniel Lezcano      2024-10-22  308  	[THERMAL_GENL_EVENT_THRESHOLD_UP]	= thermal_genl_event_threshold_up,
1ce50e7d408ef2b Daniel Lezcano      2020-07-06  309  };
1ce50e7d408ef2b Daniel Lezcano      2020-07-06  310  
1ce50e7d408ef2b Daniel Lezcano      2020-07-06  311  /*
1ce50e7d408ef2b Daniel Lezcano      2020-07-06  312   * Generic netlink event encoding
1ce50e7d408ef2b Daniel Lezcano      2020-07-06  313   */
1ce50e7d408ef2b Daniel Lezcano      2020-07-06  314  static int thermal_genl_send_event(enum thermal_genl_event event,
1ce50e7d408ef2b Daniel Lezcano      2020-07-06  315  				   struct param *p)
1ce50e7d408ef2b Daniel Lezcano      2020-07-06  316  {
1ce50e7d408ef2b Daniel Lezcano      2020-07-06  317  	struct sk_buff *msg;
1ce50e7d408ef2b Daniel Lezcano      2020-07-06  318  	int ret = -EMSGSIZE;
1ce50e7d408ef2b Daniel Lezcano      2020-07-06  319  	void *hdr;
1ce50e7d408ef2b Daniel Lezcano      2020-07-06  320  
04c3b03044034ce Stanislaw Gruszka   2023-12-28  321  	if (!thermal_group_has_listeners(THERMAL_GENL_EVENT_GROUP))
04c3b03044034ce Stanislaw Gruszka   2023-12-28  322  		return 0;
04c3b03044034ce Stanislaw Gruszka   2023-12-28  323  
1ce50e7d408ef2b Daniel Lezcano      2020-07-06  324  	msg = genlmsg_new(NLMSG_GOODSIZE, GFP_KERNEL);
1ce50e7d408ef2b Daniel Lezcano      2020-07-06  325  	if (!msg)
1ce50e7d408ef2b Daniel Lezcano      2020-07-06  326  		return -ENOMEM;
1ce50e7d408ef2b Daniel Lezcano      2020-07-06  327  	p->msg = msg;
1ce50e7d408ef2b Daniel Lezcano      2020-07-06  328  
afdaff3706918b7 Stanislaw Gruszka   2024-02-23  329  	hdr = genlmsg_put(msg, 0, 0, &thermal_genl_family, 0, event);
1ce50e7d408ef2b Daniel Lezcano      2020-07-06  330  	if (!hdr)
1ce50e7d408ef2b Daniel Lezcano      2020-07-06  331  		goto out_free_msg;
1ce50e7d408ef2b Daniel Lezcano      2020-07-06  332  
1ce50e7d408ef2b Daniel Lezcano      2020-07-06  333  	ret = event_cb[event](p);
1ce50e7d408ef2b Daniel Lezcano      2020-07-06  334  	if (ret)
1ce50e7d408ef2b Daniel Lezcano      2020-07-06  335  		goto out_cancel_msg;
1ce50e7d408ef2b Daniel Lezcano      2020-07-06  336  
1ce50e7d408ef2b Daniel Lezcano      2020-07-06  337  	genlmsg_end(msg, hdr);
1ce50e7d408ef2b Daniel Lezcano      2020-07-06  338  
afdaff3706918b7 Stanislaw Gruszka   2024-02-23  339  	genlmsg_multicast(&thermal_genl_family, msg, 0, THERMAL_GENL_EVENT_GROUP, GFP_KERNEL);
1ce50e7d408ef2b Daniel Lezcano      2020-07-06  340  
1ce50e7d408ef2b Daniel Lezcano      2020-07-06  341  	return 0;
1ce50e7d408ef2b Daniel Lezcano      2020-07-06  342  
1ce50e7d408ef2b Daniel Lezcano      2020-07-06  343  out_cancel_msg:
1ce50e7d408ef2b Daniel Lezcano      2020-07-06  344  	genlmsg_cancel(msg, hdr);
1ce50e7d408ef2b Daniel Lezcano      2020-07-06  345  out_free_msg:
1ce50e7d408ef2b Daniel Lezcano      2020-07-06  346  	nlmsg_free(msg);
1ce50e7d408ef2b Daniel Lezcano      2020-07-06  347  
1ce50e7d408ef2b Daniel Lezcano      2020-07-06  348  	return ret;
1ce50e7d408ef2b Daniel Lezcano      2020-07-06  349  }
1ce50e7d408ef2b Daniel Lezcano      2020-07-06  350  
2f521890aa5b8a5 Rafael J. Wysocki   2024-01-03  351  int thermal_notify_tz_create(const struct thermal_zone_device *tz)
1ce50e7d408ef2b Daniel Lezcano      2020-07-06  352  {
2f521890aa5b8a5 Rafael J. Wysocki   2024-01-03  353  	struct param p = { .tz_id = tz->id, .name = tz->type };
1ce50e7d408ef2b Daniel Lezcano      2020-07-06  354  
1ce50e7d408ef2b Daniel Lezcano      2020-07-06  355  	return thermal_genl_send_event(THERMAL_GENL_EVENT_TZ_CREATE, &p);
1ce50e7d408ef2b Daniel Lezcano      2020-07-06  356  }
1ce50e7d408ef2b Daniel Lezcano      2020-07-06  357  
2f521890aa5b8a5 Rafael J. Wysocki   2024-01-03  358  int thermal_notify_tz_delete(const struct thermal_zone_device *tz)
1ce50e7d408ef2b Daniel Lezcano      2020-07-06  359  {
2f521890aa5b8a5 Rafael J. Wysocki   2024-01-03  360  	struct param p = { .tz_id = tz->id };
1ce50e7d408ef2b Daniel Lezcano      2020-07-06  361  
1ce50e7d408ef2b Daniel Lezcano      2020-07-06  362  	return thermal_genl_send_event(THERMAL_GENL_EVENT_TZ_DELETE, &p);
1ce50e7d408ef2b Daniel Lezcano      2020-07-06  363  }
1ce50e7d408ef2b Daniel Lezcano      2020-07-06  364  
2f521890aa5b8a5 Rafael J. Wysocki   2024-01-03  365  int thermal_notify_tz_enable(const struct thermal_zone_device *tz)
1ce50e7d408ef2b Daniel Lezcano      2020-07-06  366  {
2f521890aa5b8a5 Rafael J. Wysocki   2024-01-03  367  	struct param p = { .tz_id = tz->id };
1ce50e7d408ef2b Daniel Lezcano      2020-07-06  368  
1ce50e7d408ef2b Daniel Lezcano      2020-07-06  369  	return thermal_genl_send_event(THERMAL_GENL_EVENT_TZ_ENABLE, &p);
1ce50e7d408ef2b Daniel Lezcano      2020-07-06  370  }
1ce50e7d408ef2b Daniel Lezcano      2020-07-06  371  
2f521890aa5b8a5 Rafael J. Wysocki   2024-01-03  372  int thermal_notify_tz_disable(const struct thermal_zone_device *tz)
1ce50e7d408ef2b Daniel Lezcano      2020-07-06  373  {
2f521890aa5b8a5 Rafael J. Wysocki   2024-01-03  374  	struct param p = { .tz_id = tz->id };
1ce50e7d408ef2b Daniel Lezcano      2020-07-06  375  
1ce50e7d408ef2b Daniel Lezcano      2020-07-06  376  	return thermal_genl_send_event(THERMAL_GENL_EVENT_TZ_DISABLE, &p);
1ce50e7d408ef2b Daniel Lezcano      2020-07-06  377  }
1ce50e7d408ef2b Daniel Lezcano      2020-07-06  378  
f52557edf0648b4 Rafael J. Wysocki   2023-12-15  379  int thermal_notify_tz_trip_down(const struct thermal_zone_device *tz,
f52557edf0648b4 Rafael J. Wysocki   2023-12-15  380  				const struct thermal_trip *trip)
1ce50e7d408ef2b Daniel Lezcano      2020-07-06  381  {
f52557edf0648b4 Rafael J. Wysocki   2023-12-15  382  	struct param p = { .tz_id = tz->id,
f52557edf0648b4 Rafael J. Wysocki   2023-12-15  383  			   .trip_id = thermal_zone_trip_id(tz, trip),
f52557edf0648b4 Rafael J. Wysocki   2023-12-15  384  			   .temp = tz->temperature };
1ce50e7d408ef2b Daniel Lezcano      2020-07-06  385  
1ce50e7d408ef2b Daniel Lezcano      2020-07-06  386  	return thermal_genl_send_event(THERMAL_GENL_EVENT_TZ_TRIP_DOWN, &p);
1ce50e7d408ef2b Daniel Lezcano      2020-07-06  387  }
1ce50e7d408ef2b Daniel Lezcano      2020-07-06  388  
f52557edf0648b4 Rafael J. Wysocki   2023-12-15  389  int thermal_notify_tz_trip_up(const struct thermal_zone_device *tz,
f52557edf0648b4 Rafael J. Wysocki   2023-12-15  390  			      const struct thermal_trip *trip)
1ce50e7d408ef2b Daniel Lezcano      2020-07-06  391  {
f52557edf0648b4 Rafael J. Wysocki   2023-12-15  392  	struct param p = { .tz_id = tz->id,
f52557edf0648b4 Rafael J. Wysocki   2023-12-15  393  			   .trip_id = thermal_zone_trip_id(tz, trip),
f52557edf0648b4 Rafael J. Wysocki   2023-12-15  394  			   .temp = tz->temperature };
1ce50e7d408ef2b Daniel Lezcano      2020-07-06  395  
1ce50e7d408ef2b Daniel Lezcano      2020-07-06  396  	return thermal_genl_send_event(THERMAL_GENL_EVENT_TZ_TRIP_UP, &p);
1ce50e7d408ef2b Daniel Lezcano      2020-07-06  397  }
1ce50e7d408ef2b Daniel Lezcano      2020-07-06  398  
7e72fc41d424380 Rafael J. Wysocki   2024-01-03  399  int thermal_notify_tz_trip_change(const struct thermal_zone_device *tz,
7e72fc41d424380 Rafael J. Wysocki   2024-01-03  400  				  const struct thermal_trip *trip)
1ce50e7d408ef2b Daniel Lezcano      2020-07-06  401  {
7e72fc41d424380 Rafael J. Wysocki   2024-01-03  402  	struct param p = { .tz_id = tz->id,
7e72fc41d424380 Rafael J. Wysocki   2024-01-03  403  			   .trip_id = thermal_zone_trip_id(tz, trip),
7e72fc41d424380 Rafael J. Wysocki   2024-01-03  404  			   .trip_type = trip->type,
7e72fc41d424380 Rafael J. Wysocki   2024-01-03  405  			   .trip_temp = trip->temperature,
7e72fc41d424380 Rafael J. Wysocki   2024-01-03  406  			   .trip_hyst = trip->hysteresis };
1ce50e7d408ef2b Daniel Lezcano      2020-07-06  407  
1ce50e7d408ef2b Daniel Lezcano      2020-07-06  408  	return thermal_genl_send_event(THERMAL_GENL_EVENT_TZ_TRIP_CHANGE, &p);
1ce50e7d408ef2b Daniel Lezcano      2020-07-06  409  }
1ce50e7d408ef2b Daniel Lezcano      2020-07-06  410  
11fde939314836c Rafael J. Wysocki   2024-01-09  411  int thermal_notify_cdev_state_update(const struct thermal_cooling_device *cdev,
11fde939314836c Rafael J. Wysocki   2024-01-09  412  				     int state)
1ce50e7d408ef2b Daniel Lezcano      2020-07-06  413  {
11fde939314836c Rafael J. Wysocki   2024-01-09  414  	struct param p = { .cdev_id = cdev->id, .cdev_state = state };
1ce50e7d408ef2b Daniel Lezcano      2020-07-06  415  
1ce50e7d408ef2b Daniel Lezcano      2020-07-06  416  	return thermal_genl_send_event(THERMAL_GENL_EVENT_CDEV_STATE_UPDATE, &p);
1ce50e7d408ef2b Daniel Lezcano      2020-07-06  417  }
1ce50e7d408ef2b Daniel Lezcano      2020-07-06  418  
11fde939314836c Rafael J. Wysocki   2024-01-09  419  int thermal_notify_cdev_add(const struct thermal_cooling_device *cdev)
1ce50e7d408ef2b Daniel Lezcano      2020-07-06  420  {
11fde939314836c Rafael J. Wysocki   2024-01-09  421  	struct param p = { .cdev_id = cdev->id, .name = cdev->type,
11fde939314836c Rafael J. Wysocki   2024-01-09  422  			   .cdev_max_state = cdev->max_state };
1ce50e7d408ef2b Daniel Lezcano      2020-07-06  423  
1ce50e7d408ef2b Daniel Lezcano      2020-07-06  424  	return thermal_genl_send_event(THERMAL_GENL_EVENT_CDEV_ADD, &p);
1ce50e7d408ef2b Daniel Lezcano      2020-07-06  425  }
1ce50e7d408ef2b Daniel Lezcano      2020-07-06  426  
11fde939314836c Rafael J. Wysocki   2024-01-09  427  int thermal_notify_cdev_delete(const struct thermal_cooling_device *cdev)
1ce50e7d408ef2b Daniel Lezcano      2020-07-06  428  {
11fde939314836c Rafael J. Wysocki   2024-01-09  429  	struct param p = { .cdev_id = cdev->id };
1ce50e7d408ef2b Daniel Lezcano      2020-07-06  430  
1ce50e7d408ef2b Daniel Lezcano      2020-07-06  431  	return thermal_genl_send_event(THERMAL_GENL_EVENT_CDEV_DELETE, &p);
1ce50e7d408ef2b Daniel Lezcano      2020-07-06  432  }
1ce50e7d408ef2b Daniel Lezcano      2020-07-06  433  
2f521890aa5b8a5 Rafael J. Wysocki   2024-01-03  434  int thermal_notify_tz_gov_change(const struct thermal_zone_device *tz,
2f521890aa5b8a5 Rafael J. Wysocki   2024-01-03  435  				 const char *name)
1ce50e7d408ef2b Daniel Lezcano      2020-07-06  436  {
2f521890aa5b8a5 Rafael J. Wysocki   2024-01-03  437  	struct param p = { .tz_id = tz->id, .name = name };
1ce50e7d408ef2b Daniel Lezcano      2020-07-06  438  
1ce50e7d408ef2b Daniel Lezcano      2020-07-06  439  	return thermal_genl_send_event(THERMAL_GENL_EVENT_TZ_GOV_CHANGE, &p);
1ce50e7d408ef2b Daniel Lezcano      2020-07-06  440  }
1ce50e7d408ef2b Daniel Lezcano      2020-07-06  441  
e4b1eb24ce5a696 Srinivas Pandruvada 2022-01-27  442  int thermal_genl_cpu_capability_event(int count,
e4b1eb24ce5a696 Srinivas Pandruvada 2022-01-27  443  				      struct thermal_genl_cpu_caps *caps)
e4b1eb24ce5a696 Srinivas Pandruvada 2022-01-27  444  {
e4b1eb24ce5a696 Srinivas Pandruvada 2022-01-27  445  	struct param p = { .cpu_capabilities_count = count, .cpu_capabilities = caps };
e4b1eb24ce5a696 Srinivas Pandruvada 2022-01-27  446  
e4b1eb24ce5a696 Srinivas Pandruvada 2022-01-27  447  	return thermal_genl_send_event(THERMAL_GENL_EVENT_CPU_CAPABILITY_CHANGE, &p);
e4b1eb24ce5a696 Srinivas Pandruvada 2022-01-27  448  }
e4b1eb24ce5a696 Srinivas Pandruvada 2022-01-27  449  EXPORT_SYMBOL_GPL(thermal_genl_cpu_capability_event);
e4b1eb24ce5a696 Srinivas Pandruvada 2022-01-27  450  
1773572863c43a1 Daniel Lezcano      2024-10-22  451  int thermal_notify_threshold_add(const struct thermal_zone_device *tz,
1773572863c43a1 Daniel Lezcano      2024-10-22  452  				 int temperature, int direction)
1773572863c43a1 Daniel Lezcano      2024-10-22  453  {
1773572863c43a1 Daniel Lezcano      2024-10-22  454  	struct param p = { .tz_id = tz->id, .temp = temperature, .direction = direction };
1773572863c43a1 Daniel Lezcano      2024-10-22  455  
1773572863c43a1 Daniel Lezcano      2024-10-22  456  	return thermal_genl_send_event(THERMAL_GENL_EVENT_THRESHOLD_ADD, &p);
1773572863c43a1 Daniel Lezcano      2024-10-22  457  }
1773572863c43a1 Daniel Lezcano      2024-10-22  458  
1773572863c43a1 Daniel Lezcano      2024-10-22  459  int thermal_notify_threshold_delete(const struct thermal_zone_device *tz,
1773572863c43a1 Daniel Lezcano      2024-10-22  460  				    int temperature, int direction)
1773572863c43a1 Daniel Lezcano      2024-10-22  461  {
1773572863c43a1 Daniel Lezcano      2024-10-22  462  	struct param p = { .tz_id = tz->id, .temp = temperature, .direction = direction };
1773572863c43a1 Daniel Lezcano      2024-10-22  463  
1773572863c43a1 Daniel Lezcano      2024-10-22  464  	return thermal_genl_send_event(THERMAL_GENL_EVENT_THRESHOLD_DELETE, &p);
1773572863c43a1 Daniel Lezcano      2024-10-22  465  }
1773572863c43a1 Daniel Lezcano      2024-10-22  466  
1773572863c43a1 Daniel Lezcano      2024-10-22  467  int thermal_notify_threshold_flush(const struct thermal_zone_device *tz)
1773572863c43a1 Daniel Lezcano      2024-10-22  468  {
1773572863c43a1 Daniel Lezcano      2024-10-22  469  	struct param p = { .tz_id = tz->id };
1773572863c43a1 Daniel Lezcano      2024-10-22  470  
1773572863c43a1 Daniel Lezcano      2024-10-22  471  	return thermal_genl_send_event(THERMAL_GENL_EVENT_THRESHOLD_FLUSH, &p);
1773572863c43a1 Daniel Lezcano      2024-10-22  472  }
1773572863c43a1 Daniel Lezcano      2024-10-22  473  
1773572863c43a1 Daniel Lezcano      2024-10-22  474  int thermal_notify_threshold_down(const struct thermal_zone_device *tz)
1773572863c43a1 Daniel Lezcano      2024-10-22  475  {
1773572863c43a1 Daniel Lezcano      2024-10-22  476  	struct param p = { .tz_id = tz->id, .temp = tz->temperature, .prev_temp = tz->last_temperature };
1773572863c43a1 Daniel Lezcano      2024-10-22  477  
1773572863c43a1 Daniel Lezcano      2024-10-22  478  	return thermal_genl_send_event(THERMAL_GENL_EVENT_THRESHOLD_DOWN, &p);
1773572863c43a1 Daniel Lezcano      2024-10-22  479  }
1773572863c43a1 Daniel Lezcano      2024-10-22  480  
1773572863c43a1 Daniel Lezcano      2024-10-22  481  int thermal_notify_threshold_up(const struct thermal_zone_device *tz)
1773572863c43a1 Daniel Lezcano      2024-10-22  482  {
1773572863c43a1 Daniel Lezcano      2024-10-22  483  	struct param p = { .tz_id = tz->id, .temp = tz->temperature, .prev_temp = tz->last_temperature };
1773572863c43a1 Daniel Lezcano      2024-10-22  484  
1773572863c43a1 Daniel Lezcano      2024-10-22  485  	return thermal_genl_send_event(THERMAL_GENL_EVENT_THRESHOLD_UP, &p);
1773572863c43a1 Daniel Lezcano      2024-10-22  486  }
1773572863c43a1 Daniel Lezcano      2024-10-22  487  
1ce50e7d408ef2b Daniel Lezcano      2020-07-06  488  /*************************** Command encoding ********************************/
1ce50e7d408ef2b Daniel Lezcano      2020-07-06  489  
1ce50e7d408ef2b Daniel Lezcano      2020-07-06  490  static int __thermal_genl_cmd_tz_get_id(struct thermal_zone_device *tz,
1ce50e7d408ef2b Daniel Lezcano      2020-07-06  491  					void *data)
1ce50e7d408ef2b Daniel Lezcano      2020-07-06  492  {
1ce50e7d408ef2b Daniel Lezcano      2020-07-06  493  	struct sk_buff *msg = data;
1ce50e7d408ef2b Daniel Lezcano      2020-07-06  494  
1ce50e7d408ef2b Daniel Lezcano      2020-07-06  495  	if (nla_put_u32(msg, THERMAL_GENL_ATTR_TZ_ID, tz->id) ||
1ce50e7d408ef2b Daniel Lezcano      2020-07-06  496  	    nla_put_string(msg, THERMAL_GENL_ATTR_TZ_NAME, tz->type))
1ce50e7d408ef2b Daniel Lezcano      2020-07-06  497  		return -EMSGSIZE;
1ce50e7d408ef2b Daniel Lezcano      2020-07-06  498  
1ce50e7d408ef2b Daniel Lezcano      2020-07-06  499  	return 0;
1ce50e7d408ef2b Daniel Lezcano      2020-07-06  500  }
1ce50e7d408ef2b Daniel Lezcano      2020-07-06  501  
1ce50e7d408ef2b Daniel Lezcano      2020-07-06  502  static int thermal_genl_cmd_tz_get_id(struct param *p)
1ce50e7d408ef2b Daniel Lezcano      2020-07-06  503  {
1ce50e7d408ef2b Daniel Lezcano      2020-07-06  504  	struct sk_buff *msg = p->msg;
1ce50e7d408ef2b Daniel Lezcano      2020-07-06  505  	struct nlattr *start_tz;
1ce50e7d408ef2b Daniel Lezcano      2020-07-06  506  	int ret;
1ce50e7d408ef2b Daniel Lezcano      2020-07-06  507  
1ce50e7d408ef2b Daniel Lezcano      2020-07-06  508  	start_tz = nla_nest_start(msg, THERMAL_GENL_ATTR_TZ);
1ce50e7d408ef2b Daniel Lezcano      2020-07-06  509  	if (!start_tz)
1ce50e7d408ef2b Daniel Lezcano      2020-07-06  510  		return -EMSGSIZE;
1ce50e7d408ef2b Daniel Lezcano      2020-07-06  511  
1ce50e7d408ef2b Daniel Lezcano      2020-07-06  512  	ret = for_each_thermal_zone(__thermal_genl_cmd_tz_get_id, msg);
1ce50e7d408ef2b Daniel Lezcano      2020-07-06  513  	if (ret)
1ce50e7d408ef2b Daniel Lezcano      2020-07-06  514  		goto out_cancel_nest;
1ce50e7d408ef2b Daniel Lezcano      2020-07-06  515  
1ce50e7d408ef2b Daniel Lezcano      2020-07-06  516  	nla_nest_end(msg, start_tz);
1ce50e7d408ef2b Daniel Lezcano      2020-07-06  517  
1ce50e7d408ef2b Daniel Lezcano      2020-07-06  518  	return 0;
1ce50e7d408ef2b Daniel Lezcano      2020-07-06  519  
1ce50e7d408ef2b Daniel Lezcano      2020-07-06  520  out_cancel_nest:
1ce50e7d408ef2b Daniel Lezcano      2020-07-06  521  	nla_nest_cancel(msg, start_tz);
1ce50e7d408ef2b Daniel Lezcano      2020-07-06  522  
1ce50e7d408ef2b Daniel Lezcano      2020-07-06  523  	return ret;
1ce50e7d408ef2b Daniel Lezcano      2020-07-06  524  }
1ce50e7d408ef2b Daniel Lezcano      2020-07-06  525  
1ce50e7d408ef2b Daniel Lezcano      2020-07-06  526  static int thermal_genl_cmd_tz_get_trip(struct param *p)
1ce50e7d408ef2b Daniel Lezcano      2020-07-06  527  {
1ce50e7d408ef2b Daniel Lezcano      2020-07-06  528  	struct sk_buff *msg = p->msg;
daeeb032f42d066 Rafael J. Wysocki   2024-04-02  529  	const struct thermal_trip_desc *td;
1ce50e7d408ef2b Daniel Lezcano      2020-07-06  530  	struct nlattr *start_trip;
183b64132f9692b Rafael J. Wysocki   2023-12-04  531  	int id;
1ce50e7d408ef2b Daniel Lezcano      2020-07-06  532  
1ce50e7d408ef2b Daniel Lezcano      2020-07-06  533  	if (!p->attrs[THERMAL_GENL_ATTR_TZ_ID])
1ce50e7d408ef2b Daniel Lezcano      2020-07-06  534  		return -EINVAL;
1ce50e7d408ef2b Daniel Lezcano      2020-07-06  535  
1ce50e7d408ef2b Daniel Lezcano      2020-07-06  536  	id = nla_get_u32(p->attrs[THERMAL_GENL_ATTR_TZ_ID]);
1ce50e7d408ef2b Daniel Lezcano      2020-07-06  537  
a42a5839f400e92 Rafael J. Wysocki   2024-10-03  538  	CLASS(thermal_zone_get_by_id, tz)(id);
1ce50e7d408ef2b Daniel Lezcano      2020-07-06  539  	if (!tz)
1ce50e7d408ef2b Daniel Lezcano      2020-07-06  540  		return -EINVAL;
1ce50e7d408ef2b Daniel Lezcano      2020-07-06  541  
1ce50e7d408ef2b Daniel Lezcano      2020-07-06  542  	start_trip = nla_nest_start(msg, THERMAL_GENL_ATTR_TZ_TRIP);
1ce50e7d408ef2b Daniel Lezcano      2020-07-06  543  	if (!start_trip)
1ce50e7d408ef2b Daniel Lezcano      2020-07-06  544  		return -EMSGSIZE;
1ce50e7d408ef2b Daniel Lezcano      2020-07-06  545  
cba00d16a2b0b0c Rafael J. Wysocki   2024-10-11  546  	guard(thermal_zone)(tz);
1ce50e7d408ef2b Daniel Lezcano      2020-07-06  547  
daeeb032f42d066 Rafael J. Wysocki   2024-04-02  548  	for_each_trip_desc(tz, td) {
daeeb032f42d066 Rafael J. Wysocki   2024-04-02  549  		const struct thermal_trip *trip = &td->trip;
daeeb032f42d066 Rafael J. Wysocki   2024-04-02  550  
183b64132f9692b Rafael J. Wysocki   2023-12-04  551  		if (nla_put_u32(msg, THERMAL_GENL_ATTR_TZ_TRIP_ID,
183b64132f9692b Rafael J. Wysocki   2023-12-04  552  				thermal_zone_trip_id(tz, trip)) ||
183b64132f9692b Rafael J. Wysocki   2023-12-04  553  		    nla_put_u32(msg, THERMAL_GENL_ATTR_TZ_TRIP_TYPE, trip->type) ||
183b64132f9692b Rafael J. Wysocki   2023-12-04  554  		    nla_put_u32(msg, THERMAL_GENL_ATTR_TZ_TRIP_TEMP, trip->temperature) ||
183b64132f9692b Rafael J. Wysocki   2023-12-04  555  		    nla_put_u32(msg, THERMAL_GENL_ATTR_TZ_TRIP_HYST, trip->hysteresis))
cba00d16a2b0b0c Rafael J. Wysocki   2024-10-11  556  			return -EMSGSIZE;
1ce50e7d408ef2b Daniel Lezcano      2020-07-06  557  	}
1ce50e7d408ef2b Daniel Lezcano      2020-07-06  558  
1ce50e7d408ef2b Daniel Lezcano      2020-07-06  559  	nla_nest_end(msg, start_trip);
1ce50e7d408ef2b Daniel Lezcano      2020-07-06  560  
1ce50e7d408ef2b Daniel Lezcano      2020-07-06  561  	return 0;
1ce50e7d408ef2b Daniel Lezcano      2020-07-06  562  }
1ce50e7d408ef2b Daniel Lezcano      2020-07-06  563  
1ce50e7d408ef2b Daniel Lezcano      2020-07-06  564  static int thermal_genl_cmd_tz_get_temp(struct param *p)
1ce50e7d408ef2b Daniel Lezcano      2020-07-06  565  {
1ce50e7d408ef2b Daniel Lezcano      2020-07-06  566  	struct sk_buff *msg = p->msg;
1ce50e7d408ef2b Daniel Lezcano      2020-07-06  567  	int temp, ret, id;
1ce50e7d408ef2b Daniel Lezcano      2020-07-06  568  
1ce50e7d408ef2b Daniel Lezcano      2020-07-06  569  	if (!p->attrs[THERMAL_GENL_ATTR_TZ_ID])
1ce50e7d408ef2b Daniel Lezcano      2020-07-06  570  		return -EINVAL;
1ce50e7d408ef2b Daniel Lezcano      2020-07-06  571  
1ce50e7d408ef2b Daniel Lezcano      2020-07-06  572  	id = nla_get_u32(p->attrs[THERMAL_GENL_ATTR_TZ_ID]);
1ce50e7d408ef2b Daniel Lezcano      2020-07-06  573  
a42a5839f400e92 Rafael J. Wysocki   2024-10-03  574  	CLASS(thermal_zone_get_by_id, tz)(id);
1ce50e7d408ef2b Daniel Lezcano      2020-07-06  575  	if (!tz)
1ce50e7d408ef2b Daniel Lezcano      2020-07-06  576  		return -EINVAL;
1ce50e7d408ef2b Daniel Lezcano      2020-07-06  577  
1ce50e7d408ef2b Daniel Lezcano      2020-07-06  578  	ret = thermal_zone_get_temp(tz, &temp);
1ce50e7d408ef2b Daniel Lezcano      2020-07-06  579  	if (ret)
1ce50e7d408ef2b Daniel Lezcano      2020-07-06  580  		return ret;
1ce50e7d408ef2b Daniel Lezcano      2020-07-06  581  
1ce50e7d408ef2b Daniel Lezcano      2020-07-06  582  	if (nla_put_u32(msg, THERMAL_GENL_ATTR_TZ_ID, id) ||
1ce50e7d408ef2b Daniel Lezcano      2020-07-06  583  	    nla_put_u32(msg, THERMAL_GENL_ATTR_TZ_TEMP, temp))
1ce50e7d408ef2b Daniel Lezcano      2020-07-06  584  		return -EMSGSIZE;
1ce50e7d408ef2b Daniel Lezcano      2020-07-06  585  
1ce50e7d408ef2b Daniel Lezcano      2020-07-06  586  	return 0;
1ce50e7d408ef2b Daniel Lezcano      2020-07-06  587  }
1ce50e7d408ef2b Daniel Lezcano      2020-07-06  588  
1ce50e7d408ef2b Daniel Lezcano      2020-07-06  589  static int thermal_genl_cmd_tz_get_gov(struct param *p)
1ce50e7d408ef2b Daniel Lezcano      2020-07-06  590  {
1ce50e7d408ef2b Daniel Lezcano      2020-07-06  591  	struct sk_buff *msg = p->msg;
cba00d16a2b0b0c Rafael J. Wysocki   2024-10-11  592  	int id;
1ce50e7d408ef2b Daniel Lezcano      2020-07-06  593  
1ce50e7d408ef2b Daniel Lezcano      2020-07-06  594  	if (!p->attrs[THERMAL_GENL_ATTR_TZ_ID])
1ce50e7d408ef2b Daniel Lezcano      2020-07-06  595  		return -EINVAL;
1ce50e7d408ef2b Daniel Lezcano      2020-07-06  596  
1ce50e7d408ef2b Daniel Lezcano      2020-07-06  597  	id = nla_get_u32(p->attrs[THERMAL_GENL_ATTR_TZ_ID]);
1ce50e7d408ef2b Daniel Lezcano      2020-07-06  598  
a42a5839f400e92 Rafael J. Wysocki   2024-10-03  599  	CLASS(thermal_zone_get_by_id, tz)(id);
1ce50e7d408ef2b Daniel Lezcano      2020-07-06  600  	if (!tz)
1ce50e7d408ef2b Daniel Lezcano      2020-07-06  601  		return -EINVAL;
1ce50e7d408ef2b Daniel Lezcano      2020-07-06  602  
cba00d16a2b0b0c Rafael J. Wysocki   2024-10-11  603  	guard(thermal_zone)(tz);
1ce50e7d408ef2b Daniel Lezcano      2020-07-06  604  
1ce50e7d408ef2b Daniel Lezcano      2020-07-06  605  	if (nla_put_u32(msg, THERMAL_GENL_ATTR_TZ_ID, id) ||
1ce50e7d408ef2b Daniel Lezcano      2020-07-06  606  	    nla_put_string(msg, THERMAL_GENL_ATTR_TZ_GOV_NAME,
1ce50e7d408ef2b Daniel Lezcano      2020-07-06  607  			   tz->governor->name))
cba00d16a2b0b0c Rafael J. Wysocki   2024-10-11  608  		return -EMSGSIZE;
1ce50e7d408ef2b Daniel Lezcano      2020-07-06  609  
cba00d16a2b0b0c Rafael J. Wysocki   2024-10-11  610  	return 0;
1ce50e7d408ef2b Daniel Lezcano      2020-07-06  611  }
1ce50e7d408ef2b Daniel Lezcano      2020-07-06  612  
1ce50e7d408ef2b Daniel Lezcano      2020-07-06  613  static int __thermal_genl_cmd_cdev_get(struct thermal_cooling_device *cdev,
1ce50e7d408ef2b Daniel Lezcano      2020-07-06  614  				       void *data)
1ce50e7d408ef2b Daniel Lezcano      2020-07-06  615  {
1ce50e7d408ef2b Daniel Lezcano      2020-07-06  616  	struct sk_buff *msg = data;
1ce50e7d408ef2b Daniel Lezcano      2020-07-06  617  
1ce50e7d408ef2b Daniel Lezcano      2020-07-06  618  	if (nla_put_u32(msg, THERMAL_GENL_ATTR_CDEV_ID, cdev->id))
1ce50e7d408ef2b Daniel Lezcano      2020-07-06  619  		return -EMSGSIZE;
1ce50e7d408ef2b Daniel Lezcano      2020-07-06  620  
1ce50e7d408ef2b Daniel Lezcano      2020-07-06  621  	if (nla_put_string(msg, THERMAL_GENL_ATTR_CDEV_NAME, cdev->type))
1ce50e7d408ef2b Daniel Lezcano      2020-07-06  622  		return -EMSGSIZE;
1ce50e7d408ef2b Daniel Lezcano      2020-07-06  623  
1ce50e7d408ef2b Daniel Lezcano      2020-07-06  624  	return 0;
1ce50e7d408ef2b Daniel Lezcano      2020-07-06  625  }
1ce50e7d408ef2b Daniel Lezcano      2020-07-06  626  
1ce50e7d408ef2b Daniel Lezcano      2020-07-06  627  static int thermal_genl_cmd_cdev_get(struct param *p)
1ce50e7d408ef2b Daniel Lezcano      2020-07-06  628  {
1ce50e7d408ef2b Daniel Lezcano      2020-07-06  629  	struct sk_buff *msg = p->msg;
1ce50e7d408ef2b Daniel Lezcano      2020-07-06  630  	struct nlattr *start_cdev;
1ce50e7d408ef2b Daniel Lezcano      2020-07-06  631  	int ret;
1ce50e7d408ef2b Daniel Lezcano      2020-07-06  632  
1ce50e7d408ef2b Daniel Lezcano      2020-07-06  633  	start_cdev = nla_nest_start(msg, THERMAL_GENL_ATTR_CDEV);
1ce50e7d408ef2b Daniel Lezcano      2020-07-06  634  	if (!start_cdev)
1ce50e7d408ef2b Daniel Lezcano      2020-07-06  635  		return -EMSGSIZE;
1ce50e7d408ef2b Daniel Lezcano      2020-07-06  636  
1ce50e7d408ef2b Daniel Lezcano      2020-07-06  637  	ret = for_each_thermal_cooling_device(__thermal_genl_cmd_cdev_get, msg);
1ce50e7d408ef2b Daniel Lezcano      2020-07-06  638  	if (ret)
1ce50e7d408ef2b Daniel Lezcano      2020-07-06  639  		goto out_cancel_nest;
1ce50e7d408ef2b Daniel Lezcano      2020-07-06  640  
1ce50e7d408ef2b Daniel Lezcano      2020-07-06  641  	nla_nest_end(msg, start_cdev);
1ce50e7d408ef2b Daniel Lezcano      2020-07-06  642  
1ce50e7d408ef2b Daniel Lezcano      2020-07-06  643  	return 0;
1ce50e7d408ef2b Daniel Lezcano      2020-07-06  644  out_cancel_nest:
1ce50e7d408ef2b Daniel Lezcano      2020-07-06  645  	nla_nest_cancel(msg, start_cdev);
1ce50e7d408ef2b Daniel Lezcano      2020-07-06  646  
1ce50e7d408ef2b Daniel Lezcano      2020-07-06  647  	return ret;
1ce50e7d408ef2b Daniel Lezcano      2020-07-06  648  }
1ce50e7d408ef2b Daniel Lezcano      2020-07-06  649  
1773572863c43a1 Daniel Lezcano      2024-10-22  650  static int __thermal_genl_cmd_threshold_get(struct user_threshold *threshold, void *arg)
1773572863c43a1 Daniel Lezcano      2024-10-22  651  {
1773572863c43a1 Daniel Lezcano      2024-10-22  652  	struct sk_buff *msg = arg;
1773572863c43a1 Daniel Lezcano      2024-10-22  653  
1773572863c43a1 Daniel Lezcano      2024-10-22  654  	if (nla_put_u32(msg, THERMAL_GENL_ATTR_THRESHOLD_TEMP, threshold->temperature) ||
1773572863c43a1 Daniel Lezcano      2024-10-22  655  	    nla_put_u32(msg, THERMAL_GENL_ATTR_THRESHOLD_DIRECTION, threshold->direction))
1773572863c43a1 Daniel Lezcano      2024-10-22  656  		return -1;
1773572863c43a1 Daniel Lezcano      2024-10-22  657  
1773572863c43a1 Daniel Lezcano      2024-10-22  658  	return 0;
1773572863c43a1 Daniel Lezcano      2024-10-22  659  }
1773572863c43a1 Daniel Lezcano      2024-10-22  660  
1773572863c43a1 Daniel Lezcano      2024-10-22  661  static int thermal_genl_cmd_threshold_get(struct param *p)
1773572863c43a1 Daniel Lezcano      2024-10-22  662  {
1773572863c43a1 Daniel Lezcano      2024-10-22  663  	struct sk_buff *msg = p->msg;
1773572863c43a1 Daniel Lezcano      2024-10-22  664  	struct nlattr *start_trip;
1773572863c43a1 Daniel Lezcano      2024-10-22  665  	int id, ret;
1773572863c43a1 Daniel Lezcano      2024-10-22  666  
1773572863c43a1 Daniel Lezcano      2024-10-22  667  	if (!p->attrs[THERMAL_GENL_ATTR_TZ_ID])
1773572863c43a1 Daniel Lezcano      2024-10-22  668  		return -EINVAL;
1773572863c43a1 Daniel Lezcano      2024-10-22  669  
1773572863c43a1 Daniel Lezcano      2024-10-22  670  	id = nla_get_u32(p->attrs[THERMAL_GENL_ATTR_TZ_ID]);
1773572863c43a1 Daniel Lezcano      2024-10-22  671  
1773572863c43a1 Daniel Lezcano      2024-10-22  672  	CLASS(thermal_zone_get_by_id, tz)(id);
1773572863c43a1 Daniel Lezcano      2024-10-22  673  	if (!tz)
1773572863c43a1 Daniel Lezcano      2024-10-22  674  		return -EINVAL;
1773572863c43a1 Daniel Lezcano      2024-10-22  675  
1773572863c43a1 Daniel Lezcano      2024-10-22  676  	start_trip = nla_nest_start(msg, THERMAL_GENL_ATTR_THRESHOLD);
1773572863c43a1 Daniel Lezcano      2024-10-22  677  	if (!start_trip)
1773572863c43a1 Daniel Lezcano      2024-10-22  678  		return -EMSGSIZE;
1773572863c43a1 Daniel Lezcano      2024-10-22  679  
1773572863c43a1 Daniel Lezcano      2024-10-22  680  	ret = thermal_thresholds_for_each(tz, __thermal_genl_cmd_threshold_get, msg);
1773572863c43a1 Daniel Lezcano      2024-10-22  681  	if (ret)
1773572863c43a1 Daniel Lezcano      2024-10-22  682  		return -EMSGSIZE;
1773572863c43a1 Daniel Lezcano      2024-10-22  683  
1773572863c43a1 Daniel Lezcano      2024-10-22  684  	nla_nest_end(msg, start_trip);
1773572863c43a1 Daniel Lezcano      2024-10-22  685  
1773572863c43a1 Daniel Lezcano      2024-10-22  686  	return 0;
1773572863c43a1 Daniel Lezcano      2024-10-22  687  }
1773572863c43a1 Daniel Lezcano      2024-10-22  688  
1773572863c43a1 Daniel Lezcano      2024-10-22  689  static int thermal_genl_cmd_threshold_add(struct param *p)
1773572863c43a1 Daniel Lezcano      2024-10-22  690  {
1773572863c43a1 Daniel Lezcano      2024-10-22  691  	int id, temp, direction;
1773572863c43a1 Daniel Lezcano      2024-10-22  692  
1773572863c43a1 Daniel Lezcano      2024-10-22  693  	if (!capable(CAP_SYS_ADMIN))
1773572863c43a1 Daniel Lezcano      2024-10-22  694  		return -EPERM;
1773572863c43a1 Daniel Lezcano      2024-10-22  695  
1773572863c43a1 Daniel Lezcano      2024-10-22  696  	if (!p->attrs[THERMAL_GENL_ATTR_TZ_ID] ||
1773572863c43a1 Daniel Lezcano      2024-10-22  697  	    !p->attrs[THERMAL_GENL_ATTR_THRESHOLD_TEMP] ||
1773572863c43a1 Daniel Lezcano      2024-10-22  698  	    !p->attrs[THERMAL_GENL_ATTR_THRESHOLD_DIRECTION])
1773572863c43a1 Daniel Lezcano      2024-10-22  699  		return -EINVAL;
1773572863c43a1 Daniel Lezcano      2024-10-22  700  
1773572863c43a1 Daniel Lezcano      2024-10-22  701  	id = nla_get_u32(p->attrs[THERMAL_GENL_ATTR_TZ_ID]);
1773572863c43a1 Daniel Lezcano      2024-10-22  702  	temp = nla_get_u32(p->attrs[THERMAL_GENL_ATTR_THRESHOLD_TEMP]);
1773572863c43a1 Daniel Lezcano      2024-10-22  703  	direction = nla_get_u32(p->attrs[THERMAL_GENL_ATTR_THRESHOLD_DIRECTION]);
1773572863c43a1 Daniel Lezcano      2024-10-22  704  
1773572863c43a1 Daniel Lezcano      2024-10-22  705  	CLASS(thermal_zone_get_by_id, tz)(id);
1773572863c43a1 Daniel Lezcano      2024-10-22  706  	if (!tz)
1773572863c43a1 Daniel Lezcano      2024-10-22  707  		return -EINVAL;
1773572863c43a1 Daniel Lezcano      2024-10-22  708  
1773572863c43a1 Daniel Lezcano      2024-10-22  709  	guard(thermal_zone)(tz);
1773572863c43a1 Daniel Lezcano      2024-10-22  710  
1773572863c43a1 Daniel Lezcano      2024-10-22  711  	return thermal_thresholds_add(tz, temp, direction);
1773572863c43a1 Daniel Lezcano      2024-10-22  712  }
1773572863c43a1 Daniel Lezcano      2024-10-22  713  
1773572863c43a1 Daniel Lezcano      2024-10-22  714  static int thermal_genl_cmd_threshold_delete(struct param *p)
1773572863c43a1 Daniel Lezcano      2024-10-22  715  {
1773572863c43a1 Daniel Lezcano      2024-10-22  716  	int id, temp, direction;
1773572863c43a1 Daniel Lezcano      2024-10-22  717  
1773572863c43a1 Daniel Lezcano      2024-10-22  718  	if (!capable(CAP_SYS_ADMIN))
1773572863c43a1 Daniel Lezcano      2024-10-22  719  		return -EPERM;
1773572863c43a1 Daniel Lezcano      2024-10-22  720  
1773572863c43a1 Daniel Lezcano      2024-10-22  721  	if (!p->attrs[THERMAL_GENL_ATTR_TZ_ID] ||
1773572863c43a1 Daniel Lezcano      2024-10-22  722  	    !p->attrs[THERMAL_GENL_ATTR_THRESHOLD_TEMP] ||
1773572863c43a1 Daniel Lezcano      2024-10-22  723  	    !p->attrs[THERMAL_GENL_ATTR_THRESHOLD_DIRECTION])
1773572863c43a1 Daniel Lezcano      2024-10-22  724  		return -EINVAL;
1773572863c43a1 Daniel Lezcano      2024-10-22  725  
1773572863c43a1 Daniel Lezcano      2024-10-22  726  	id = nla_get_u32(p->attrs[THERMAL_GENL_ATTR_TZ_ID]);
1773572863c43a1 Daniel Lezcano      2024-10-22  727  	temp = nla_get_u32(p->attrs[THERMAL_GENL_ATTR_THRESHOLD_TEMP]);
1773572863c43a1 Daniel Lezcano      2024-10-22  728  	direction = nla_get_u32(p->attrs[THERMAL_GENL_ATTR_THRESHOLD_DIRECTION]);
1773572863c43a1 Daniel Lezcano      2024-10-22  729  
1773572863c43a1 Daniel Lezcano      2024-10-22  730  	CLASS(thermal_zone_get_by_id, tz)(id);
1773572863c43a1 Daniel Lezcano      2024-10-22  731  	if (!tz)
1773572863c43a1 Daniel Lezcano      2024-10-22  732  		return -EINVAL;
1773572863c43a1 Daniel Lezcano      2024-10-22  733  
1773572863c43a1 Daniel Lezcano      2024-10-22  734  	guard(thermal_zone)(tz);
1773572863c43a1 Daniel Lezcano      2024-10-22  735  
1773572863c43a1 Daniel Lezcano      2024-10-22  736  	return thermal_thresholds_delete(tz, temp, direction);
1773572863c43a1 Daniel Lezcano      2024-10-22  737  }
1773572863c43a1 Daniel Lezcano      2024-10-22  738  
1773572863c43a1 Daniel Lezcano      2024-10-22  739  static int thermal_genl_cmd_threshold_flush(struct param *p)
1773572863c43a1 Daniel Lezcano      2024-10-22  740  {
1773572863c43a1 Daniel Lezcano      2024-10-22  741  	int id;
1773572863c43a1 Daniel Lezcano      2024-10-22  742  
1773572863c43a1 Daniel Lezcano      2024-10-22  743  	if (!capable(CAP_SYS_ADMIN))
1773572863c43a1 Daniel Lezcano      2024-10-22  744  		return -EPERM;
1773572863c43a1 Daniel Lezcano      2024-10-22  745  
1773572863c43a1 Daniel Lezcano      2024-10-22  746  	if (!p->attrs[THERMAL_GENL_ATTR_TZ_ID])
1773572863c43a1 Daniel Lezcano      2024-10-22  747  		return -EINVAL;
1773572863c43a1 Daniel Lezcano      2024-10-22  748  
1773572863c43a1 Daniel Lezcano      2024-10-22  749  	id = nla_get_u32(p->attrs[THERMAL_GENL_ATTR_TZ_ID]);
1773572863c43a1 Daniel Lezcano      2024-10-22  750  
1773572863c43a1 Daniel Lezcano      2024-10-22  751  	CLASS(thermal_zone_get_by_id, tz)(id);
1773572863c43a1 Daniel Lezcano      2024-10-22  752  	if (!tz)
1773572863c43a1 Daniel Lezcano      2024-10-22  753  		return -EINVAL;
1773572863c43a1 Daniel Lezcano      2024-10-22  754  
1773572863c43a1 Daniel Lezcano      2024-10-22  755  	guard(thermal_zone)(tz);
1773572863c43a1 Daniel Lezcano      2024-10-22  756  
1773572863c43a1 Daniel Lezcano      2024-10-22  757  	thermal_thresholds_flush(tz);
1773572863c43a1 Daniel Lezcano      2024-10-22  758  
1773572863c43a1 Daniel Lezcano      2024-10-22  759  	return 0;
1773572863c43a1 Daniel Lezcano      2024-10-22  760  }
1773572863c43a1 Daniel Lezcano      2024-10-22  761  
1ce50e7d408ef2b Daniel Lezcano      2020-07-06  762  static cb_t cmd_cb[] = {
1ce50e7d408ef2b Daniel Lezcano      2020-07-06  763  	[THERMAL_GENL_CMD_TZ_GET_ID]		= thermal_genl_cmd_tz_get_id,
1ce50e7d408ef2b Daniel Lezcano      2020-07-06  764  	[THERMAL_GENL_CMD_TZ_GET_TRIP]		= thermal_genl_cmd_tz_get_trip,
1ce50e7d408ef2b Daniel Lezcano      2020-07-06  765  	[THERMAL_GENL_CMD_TZ_GET_TEMP]		= thermal_genl_cmd_tz_get_temp,
1ce50e7d408ef2b Daniel Lezcano      2020-07-06  766  	[THERMAL_GENL_CMD_TZ_GET_GOV]		= thermal_genl_cmd_tz_get_gov,
1ce50e7d408ef2b Daniel Lezcano      2020-07-06  767  	[THERMAL_GENL_CMD_CDEV_GET]		= thermal_genl_cmd_cdev_get,
1773572863c43a1 Daniel Lezcano      2024-10-22  768  	[THERMAL_GENL_CMD_THRESHOLD_GET]	= thermal_genl_cmd_threshold_get,
1773572863c43a1 Daniel Lezcano      2024-10-22  769  	[THERMAL_GENL_CMD_THRESHOLD_ADD]	= thermal_genl_cmd_threshold_add,
1773572863c43a1 Daniel Lezcano      2024-10-22  770  	[THERMAL_GENL_CMD_THRESHOLD_DELETE]	= thermal_genl_cmd_threshold_delete,
1773572863c43a1 Daniel Lezcano      2024-10-22  771  	[THERMAL_GENL_CMD_THRESHOLD_FLUSH]	= thermal_genl_cmd_threshold_flush,
1ce50e7d408ef2b Daniel Lezcano      2020-07-06  772  };
1ce50e7d408ef2b Daniel Lezcano      2020-07-06  773  
1ce50e7d408ef2b Daniel Lezcano      2020-07-06  774  static int thermal_genl_cmd_dumpit(struct sk_buff *skb,
1ce50e7d408ef2b Daniel Lezcano      2020-07-06  775  				   struct netlink_callback *cb)
1ce50e7d408ef2b Daniel Lezcano      2020-07-06  776  {
1ce50e7d408ef2b Daniel Lezcano      2020-07-06  777  	struct param p = { .msg = skb };
1ce50e7d408ef2b Daniel Lezcano      2020-07-06  778  	const struct genl_dumpit_info *info = genl_dumpit_info(cb);
0b588afdd16f9e0 Jakub Kicinski      2020-10-02  779  	int cmd = info->op.cmd;
52674f565718f18 Colin Ian King      2020-07-06  780  	int ret;
1ce50e7d408ef2b Daniel Lezcano      2020-07-06  781  	void *hdr;
1ce50e7d408ef2b Daniel Lezcano      2020-07-06  782  
afdaff3706918b7 Stanislaw Gruszka   2024-02-23  783  	hdr = genlmsg_put(skb, 0, 0, &thermal_genl_family, 0, cmd);
1ce50e7d408ef2b Daniel Lezcano      2020-07-06  784  	if (!hdr)
1ce50e7d408ef2b Daniel Lezcano      2020-07-06  785  		return -EMSGSIZE;
1ce50e7d408ef2b Daniel Lezcano      2020-07-06  786  
1ce50e7d408ef2b Daniel Lezcano      2020-07-06  787  	ret = cmd_cb[cmd](&p);
1ce50e7d408ef2b Daniel Lezcano      2020-07-06  788  	if (ret)
1ce50e7d408ef2b Daniel Lezcano      2020-07-06  789  		goto out_cancel_msg;
1ce50e7d408ef2b Daniel Lezcano      2020-07-06  790  
1ce50e7d408ef2b Daniel Lezcano      2020-07-06  791  	genlmsg_end(skb, hdr);
1ce50e7d408ef2b Daniel Lezcano      2020-07-06  792  
1ce50e7d408ef2b Daniel Lezcano      2020-07-06  793  	return 0;
1ce50e7d408ef2b Daniel Lezcano      2020-07-06  794  
1ce50e7d408ef2b Daniel Lezcano      2020-07-06  795  out_cancel_msg:
1ce50e7d408ef2b Daniel Lezcano      2020-07-06  796  	genlmsg_cancel(skb, hdr);
1ce50e7d408ef2b Daniel Lezcano      2020-07-06  797  
1ce50e7d408ef2b Daniel Lezcano      2020-07-06  798  	return ret;
1ce50e7d408ef2b Daniel Lezcano      2020-07-06  799  }
1ce50e7d408ef2b Daniel Lezcano      2020-07-06  800  
1ce50e7d408ef2b Daniel Lezcano      2020-07-06  801  static int thermal_genl_cmd_doit(struct sk_buff *skb,
1ce50e7d408ef2b Daniel Lezcano      2020-07-06  802  				 struct genl_info *info)
1ce50e7d408ef2b Daniel Lezcano      2020-07-06  803  {
1ce50e7d408ef2b Daniel Lezcano      2020-07-06  804  	struct param p = { .attrs = info->attrs };
1ce50e7d408ef2b Daniel Lezcano      2020-07-06  805  	struct sk_buff *msg;
1ce50e7d408ef2b Daniel Lezcano      2020-07-06  806  	void *hdr;
1ce50e7d408ef2b Daniel Lezcano      2020-07-06  807  	int cmd = info->genlhdr->cmd;
1ce50e7d408ef2b Daniel Lezcano      2020-07-06  808  	int ret = -EMSGSIZE;
1ce50e7d408ef2b Daniel Lezcano      2020-07-06  809  
1ce50e7d408ef2b Daniel Lezcano      2020-07-06  810  	msg = genlmsg_new(NLMSG_GOODSIZE, GFP_KERNEL);
1ce50e7d408ef2b Daniel Lezcano      2020-07-06  811  	if (!msg)
1ce50e7d408ef2b Daniel Lezcano      2020-07-06  812  		return -ENOMEM;
1ce50e7d408ef2b Daniel Lezcano      2020-07-06  813  	p.msg = msg;
1ce50e7d408ef2b Daniel Lezcano      2020-07-06  814  
afdaff3706918b7 Stanislaw Gruszka   2024-02-23  815  	hdr = genlmsg_put_reply(msg, info, &thermal_genl_family, 0, cmd);
1ce50e7d408ef2b Daniel Lezcano      2020-07-06  816  	if (!hdr)
1ce50e7d408ef2b Daniel Lezcano      2020-07-06  817  		goto out_free_msg;
1ce50e7d408ef2b Daniel Lezcano      2020-07-06  818  
1ce50e7d408ef2b Daniel Lezcano      2020-07-06  819  	ret = cmd_cb[cmd](&p);
1ce50e7d408ef2b Daniel Lezcano      2020-07-06  820  	if (ret)
1ce50e7d408ef2b Daniel Lezcano      2020-07-06  821  		goto out_cancel_msg;
1ce50e7d408ef2b Daniel Lezcano      2020-07-06  822  
1ce50e7d408ef2b Daniel Lezcano      2020-07-06  823  	genlmsg_end(msg, hdr);
1ce50e7d408ef2b Daniel Lezcano      2020-07-06  824  
1ce50e7d408ef2b Daniel Lezcano      2020-07-06  825  	return genlmsg_reply(msg, info);
1ce50e7d408ef2b Daniel Lezcano      2020-07-06  826  
1ce50e7d408ef2b Daniel Lezcano      2020-07-06  827  out_cancel_msg:
1ce50e7d408ef2b Daniel Lezcano      2020-07-06  828  	genlmsg_cancel(msg, hdr);
1ce50e7d408ef2b Daniel Lezcano      2020-07-06  829  out_free_msg:
1ce50e7d408ef2b Daniel Lezcano      2020-07-06  830  	nlmsg_free(msg);
1ce50e7d408ef2b Daniel Lezcano      2020-07-06  831  
1ce50e7d408ef2b Daniel Lezcano      2020-07-06  832  	return ret;
1ce50e7d408ef2b Daniel Lezcano      2020-07-06  833  }
1ce50e7d408ef2b Daniel Lezcano      2020-07-06  834  
cf580ad490514cc Stanislaw Gruszka   2024-02-23  835  static int thermal_genl_bind(int mcgrp)
cf580ad490514cc Stanislaw Gruszka   2024-02-23  836  {
cf580ad490514cc Stanislaw Gruszka   2024-02-23  837  	struct thermal_genl_notify n = { .mcgrp = mcgrp };
cf580ad490514cc Stanislaw Gruszka   2024-02-23  838  
cf580ad490514cc Stanislaw Gruszka   2024-02-23  839  	if (WARN_ON_ONCE(mcgrp > THERMAL_GENL_MAX_GROUP))
cf580ad490514cc Stanislaw Gruszka   2024-02-23  840  		return -EINVAL;
cf580ad490514cc Stanislaw Gruszka   2024-02-23  841  
cf580ad490514cc Stanislaw Gruszka   2024-02-23  842  	blocking_notifier_call_chain(&thermal_genl_chain, THERMAL_NOTIFY_BIND, &n);
cf580ad490514cc Stanislaw Gruszka   2024-02-23  843  	return 0;
cf580ad490514cc Stanislaw Gruszka   2024-02-23  844  }
cf580ad490514cc Stanislaw Gruszka   2024-02-23  845  
cf580ad490514cc Stanislaw Gruszka   2024-02-23  846  static void thermal_genl_unbind(int mcgrp)
cf580ad490514cc Stanislaw Gruszka   2024-02-23  847  {
cf580ad490514cc Stanislaw Gruszka   2024-02-23  848  	struct thermal_genl_notify n = { .mcgrp = mcgrp };
cf580ad490514cc Stanislaw Gruszka   2024-02-23  849  
cf580ad490514cc Stanislaw Gruszka   2024-02-23  850  	if (WARN_ON_ONCE(mcgrp > THERMAL_GENL_MAX_GROUP))
cf580ad490514cc Stanislaw Gruszka   2024-02-23  851  		return;
cf580ad490514cc Stanislaw Gruszka   2024-02-23  852  
cf580ad490514cc Stanislaw Gruszka   2024-02-23  853  	blocking_notifier_call_chain(&thermal_genl_chain, THERMAL_NOTIFY_UNBIND, &n);
cf580ad490514cc Stanislaw Gruszka   2024-02-23  854  }
cf580ad490514cc Stanislaw Gruszka   2024-02-23  855  
66a9b9287d2447a Jakub Kicinski      2020-10-02  856  static const struct genl_small_ops thermal_genl_ops[] = {
1ce50e7d408ef2b Daniel Lezcano      2020-07-06  857  	{
1ce50e7d408ef2b Daniel Lezcano      2020-07-06  858  		.cmd = THERMAL_GENL_CMD_TZ_GET_ID,
1ce50e7d408ef2b Daniel Lezcano      2020-07-06  859  		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
1ce50e7d408ef2b Daniel Lezcano      2020-07-06  860  		.dumpit = thermal_genl_cmd_dumpit,
1ce50e7d408ef2b Daniel Lezcano      2020-07-06  861  	},
1ce50e7d408ef2b Daniel Lezcano      2020-07-06  862  	{
1ce50e7d408ef2b Daniel Lezcano      2020-07-06  863  		.cmd = THERMAL_GENL_CMD_TZ_GET_TRIP,
1ce50e7d408ef2b Daniel Lezcano      2020-07-06  864  		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
1ce50e7d408ef2b Daniel Lezcano      2020-07-06  865  		.doit = thermal_genl_cmd_doit,
1ce50e7d408ef2b Daniel Lezcano      2020-07-06  866  	},
1ce50e7d408ef2b Daniel Lezcano      2020-07-06  867  	{
1ce50e7d408ef2b Daniel Lezcano      2020-07-06  868  		.cmd = THERMAL_GENL_CMD_TZ_GET_TEMP,
1ce50e7d408ef2b Daniel Lezcano      2020-07-06  869  		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
1ce50e7d408ef2b Daniel Lezcano      2020-07-06  870  		.doit = thermal_genl_cmd_doit,
1ce50e7d408ef2b Daniel Lezcano      2020-07-06  871  	},
1ce50e7d408ef2b Daniel Lezcano      2020-07-06  872  	{
1ce50e7d408ef2b Daniel Lezcano      2020-07-06  873  		.cmd = THERMAL_GENL_CMD_TZ_GET_GOV,
1ce50e7d408ef2b Daniel Lezcano      2020-07-06  874  		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
1ce50e7d408ef2b Daniel Lezcano      2020-07-06  875  		.doit = thermal_genl_cmd_doit,
1ce50e7d408ef2b Daniel Lezcano      2020-07-06  876  	},
1ce50e7d408ef2b Daniel Lezcano      2020-07-06  877  	{
1ce50e7d408ef2b Daniel Lezcano      2020-07-06  878  		.cmd = THERMAL_GENL_CMD_CDEV_GET,
1ce50e7d408ef2b Daniel Lezcano      2020-07-06  879  		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
1ce50e7d408ef2b Daniel Lezcano      2020-07-06  880  		.dumpit = thermal_genl_cmd_dumpit,
1ce50e7d408ef2b Daniel Lezcano      2020-07-06  881  	},
1773572863c43a1 Daniel Lezcano      2024-10-22  882  	{
1773572863c43a1 Daniel Lezcano      2024-10-22  883  		.cmd = THERMAL_GENL_CMD_THRESHOLD_GET,
1773572863c43a1 Daniel Lezcano      2024-10-22  884  		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
1773572863c43a1 Daniel Lezcano      2024-10-22  885  		.doit = thermal_genl_cmd_doit,
1773572863c43a1 Daniel Lezcano      2024-10-22  886  	},
1773572863c43a1 Daniel Lezcano      2024-10-22  887  	{
1773572863c43a1 Daniel Lezcano      2024-10-22  888  		.cmd = THERMAL_GENL_CMD_THRESHOLD_ADD,
1773572863c43a1 Daniel Lezcano      2024-10-22  889  		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
1773572863c43a1 Daniel Lezcano      2024-10-22  890  		.doit = thermal_genl_cmd_doit,
1773572863c43a1 Daniel Lezcano      2024-10-22  891  	},
1773572863c43a1 Daniel Lezcano      2024-10-22  892  	{
1773572863c43a1 Daniel Lezcano      2024-10-22  893  		.cmd = THERMAL_GENL_CMD_THRESHOLD_DELETE,
1773572863c43a1 Daniel Lezcano      2024-10-22  894  		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
1773572863c43a1 Daniel Lezcano      2024-10-22  895  		.doit = thermal_genl_cmd_doit,
1773572863c43a1 Daniel Lezcano      2024-10-22  896  	},
1773572863c43a1 Daniel Lezcano      2024-10-22  897  	{
1773572863c43a1 Daniel Lezcano      2024-10-22  898  		.cmd = THERMAL_GENL_CMD_THRESHOLD_FLUSH,
1773572863c43a1 Daniel Lezcano      2024-10-22  899  		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
1773572863c43a1 Daniel Lezcano      2024-10-22  900  		.doit = thermal_genl_cmd_doit,
1773572863c43a1 Daniel Lezcano      2024-10-22  901  	},
1ce50e7d408ef2b Daniel Lezcano      2020-07-06  902  };
1ce50e7d408ef2b Daniel Lezcano      2020-07-06  903  
afdaff3706918b7 Stanislaw Gruszka   2024-02-23  904  static struct genl_family thermal_genl_family __ro_after_init = {
1ce50e7d408ef2b Daniel Lezcano      2020-07-06  905  	.hdrsize	= 0,
1ce50e7d408ef2b Daniel Lezcano      2020-07-06  906  	.name		= THERMAL_GENL_FAMILY_NAME,
1ce50e7d408ef2b Daniel Lezcano      2020-07-06  907  	.version	= THERMAL_GENL_VERSION,
1ce50e7d408ef2b Daniel Lezcano      2020-07-06  908  	.maxattr	= THERMAL_GENL_ATTR_MAX,
1ce50e7d408ef2b Daniel Lezcano      2020-07-06  909  	.policy		= thermal_genl_policy,
cf580ad490514cc Stanislaw Gruszka   2024-02-23  910  	.bind		= thermal_genl_bind,
cf580ad490514cc Stanislaw Gruszka   2024-02-23  911  	.unbind		= thermal_genl_unbind,
66a9b9287d2447a Jakub Kicinski      2020-10-02  912  	.small_ops	= thermal_genl_ops,
66a9b9287d2447a Jakub Kicinski      2020-10-02  913  	.n_small_ops	= ARRAY_SIZE(thermal_genl_ops),
1773572863c43a1 Daniel Lezcano      2024-10-22  914  	.resv_start_op	= __THERMAL_GENL_CMD_MAX,
1ce50e7d408ef2b Daniel Lezcano      2020-07-06  915  	.mcgrps		= thermal_genl_mcgrps,
1ce50e7d408ef2b Daniel Lezcano      2020-07-06  916  	.n_mcgrps	= ARRAY_SIZE(thermal_genl_mcgrps),
1ce50e7d408ef2b Daniel Lezcano      2020-07-06  917  };
1ce50e7d408ef2b Daniel Lezcano      2020-07-06  918  
cf580ad490514cc Stanislaw Gruszka   2024-02-23  919  int thermal_genl_register_notifier(struct notifier_block *nb)
cf580ad490514cc Stanislaw Gruszka   2024-02-23  920  {
cf580ad490514cc Stanislaw Gruszka   2024-02-23  921  	return blocking_notifier_chain_register(&thermal_genl_chain, nb);
cf580ad490514cc Stanislaw Gruszka   2024-02-23  922  }
cf580ad490514cc Stanislaw Gruszka   2024-02-23  923  
cf580ad490514cc Stanislaw Gruszka   2024-02-23  924  int thermal_genl_unregister_notifier(struct notifier_block *nb)
cf580ad490514cc Stanislaw Gruszka   2024-02-23  925  {
cf580ad490514cc Stanislaw Gruszka   2024-02-23  926  	return blocking_notifier_chain_unregister(&thermal_genl_chain, nb);
cf580ad490514cc Stanislaw Gruszka   2024-02-23  927  }
cf580ad490514cc Stanislaw Gruszka   2024-02-23  928  
d2a89b52839597c Daniel Lezcano      2020-07-17  929  int __init thermal_netlink_init(void)
1ce50e7d408ef2b Daniel Lezcano      2020-07-06  930  {
afdaff3706918b7 Stanislaw Gruszka   2024-02-23  931  	return genl_register_family(&thermal_genl_family);
1ce50e7d408ef2b Daniel Lezcano      2020-07-06  932  }
58d1c9fd0e85991 Daniel Lezcano      2023-01-23  933  
58d1c9fd0e85991 Daniel Lezcano      2023-01-23  934  void __init thermal_netlink_exit(void)
58d1c9fd0e85991 Daniel Lezcano      2023-01-23  935  {
afdaff3706918b7 Stanislaw Gruszka   2024-02-23  936  	genl_unregister_family(&thermal_genl_family);
58d1c9fd0e85991 Daniel Lezcano      2023-01-23  937  }

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

