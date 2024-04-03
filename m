Return-Path: <linux-acpi+bounces-4632-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CB7E897925
	for <lists+linux-acpi@lfdr.de>; Wed,  3 Apr 2024 21:41:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2262A288AE5
	for <lists+linux-acpi@lfdr.de>; Wed,  3 Apr 2024 19:41:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D76EA155720;
	Wed,  3 Apr 2024 19:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Qhe3HXDA"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFD2F155316;
	Wed,  3 Apr 2024 19:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712173278; cv=none; b=gUGIXWlhKrHr27gycp0hGAgDPVs/UMwDYDy9/S8lsbaJhubIA4o1aQzvacwAwhlTPcu+vgPhacqqaVsiCc0cf+AHyYTpFoETNRZI93mtrLok/fGM9koqk3gC/b4bhs1pKRIYFq35S2THW0FUznS35fWSYbcM1ZwH5QUwmHtpeIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712173278; c=relaxed/simple;
	bh=yFkQfuzZTJdoNsPnecCMz4y1YNFx3yiN7JzywwM0XFo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=lTuCBvJchfnCCYEFevL4D8p++i+dnHMCIoQorcofEVXbJFU+jV2O3I7q5CQUF0xzdysuTLqZ6vd3Zc36GCqul/Nwh4eKoGyXykRso0U0/9WRWUJnL8tjD36Xf2JB3u6bPDEyUpXTxlV/SiWSAtmUvQ3RsT+uiFt24sUWFIHA+Qw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Qhe3HXDA; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712173276; x=1743709276;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=yFkQfuzZTJdoNsPnecCMz4y1YNFx3yiN7JzywwM0XFo=;
  b=Qhe3HXDAP38TgIbiNn/rnWcgYmsvAmFuZb0YxaZLTBsvy02DB79ChbWD
   bPSqLRv0YI5ggU+g8dEluoWnW7OHqppLA+/8WQ4kT9r1FDQwOJm1Ow6LU
   UowhqOTA+tEtSXMC7rc/6bbKqsVUq8WDhy/X1e5cvZKqv/jHav4fRfGxu
   /tZ+my5qxUEAs/Skhu5luL7rXLW8N08E/Q++d+haqU+7FXOzkOVXXIAm+
   TYjwHTZV5cOUdWheiZnE6VJena1lHCfmkSUBG1H+H7qAOVw8LcZAVoZBO
   LfcHtFOWXyy9GsWrBUjuBDv+O2Qe+eKvS2ub0vxjMjku7duV9Dk3OiZ1Z
   A==;
X-CSE-ConnectionGUID: VB/d9ANFREuC3o9xNMLEfA==
X-CSE-MsgGUID: lmY2ue9jSEupjc7UDZGSww==
X-IronPort-AV: E=McAfee;i="6600,9927,11033"; a="7618109"
X-IronPort-AV: E=Sophos;i="6.07,177,1708416000"; 
   d="scan'208";a="7618109"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2024 12:41:13 -0700
X-CSE-ConnectionGUID: fayLiIPfQoSSJLwK2vzxqA==
X-CSE-MsgGUID: e6nq0fcUTRixmKKJrcLV0w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,177,1708416000"; 
   d="scan'208";a="19147944"
Received: from lkp-server01.sh.intel.com (HELO e61807b1d151) ([10.239.97.150])
  by orviesa008.jf.intel.com with ESMTP; 03 Apr 2024 12:41:11 -0700
Received: from kbuild by e61807b1d151 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rs6Ts-0000Am-2x;
	Wed, 03 Apr 2024 19:41:08 +0000
Date: Thu, 4 Apr 2024 03:40:16 +0800
From: kernel test robot <lkp@intel.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: oe-kbuild-all@lists.linux.dev, linux-acpi@vger.kernel.org,
	devel@acpica.org, linux-pm@vger.kernel.org
Subject: [rafael-pm:thermal-core-testing 2/6]
 drivers/thermal/./thermal_trace_ipa.h:27:36: error: invalid use of undefined
 type 'struct thermal_zone_device'
Message-ID: <202404040355.vMDBmRgN-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git thermal-core-testing
head:   a89f1989a5e97c0ca6a1e355500e2659f64707c5
commit: 9396b9d5d714caf9b54037b49877bfa441cb292c [2/6] thermal: core: Make struct thermal_zone_device definition internal
config: arm-allyesconfig (https://download.01.org/0day-ci/archive/20240404/202404040355.vMDBmRgN-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240404/202404040355.vMDBmRgN-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202404040355.vMDBmRgN-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from include/trace/define_trace.h:102,
                    from drivers/thermal/thermal_trace_ipa.h:102,
                    from drivers/thermal/gov_power_allocator.c:15:
   drivers/thermal/./thermal_trace_ipa.h: In function 'trace_event_raw_event_thermal_power_allocator':
>> drivers/thermal/./thermal_trace_ipa.h:27:36: error: invalid use of undefined type 'struct thermal_zone_device'
      27 |                 __entry->tz_id = tz->id;
         |                                    ^~
   include/trace/trace_events.h:402:11: note: in definition of macro 'DECLARE_EVENT_CLASS'
     402 |         { assign; }                                                     \
         |           ^~~~~~
   include/trace/trace_events.h:44:30: note: in expansion of macro 'PARAMS'
      44 |                              PARAMS(assign),                   \
         |                              ^~~~~~
   drivers/thermal/./thermal_trace_ipa.h:10:1: note: in expansion of macro 'TRACE_EVENT'
      10 | TRACE_EVENT(thermal_power_allocator,
         | ^~~~~~~~~~~
   drivers/thermal/./thermal_trace_ipa.h:26:9: note: in expansion of macro 'TP_fast_assign'
      26 |         TP_fast_assign(
         |         ^~~~~~~~~~~~~~
   drivers/thermal/./thermal_trace_ipa.h: In function 'trace_event_raw_event_thermal_power_actor':
   drivers/thermal/./thermal_trace_ipa.h:55:36: error: invalid use of undefined type 'struct thermal_zone_device'
      55 |                 __entry->tz_id = tz->id;
         |                                    ^~
   include/trace/trace_events.h:402:11: note: in definition of macro 'DECLARE_EVENT_CLASS'
     402 |         { assign; }                                                     \
         |           ^~~~~~
   include/trace/trace_events.h:44:30: note: in expansion of macro 'PARAMS'
      44 |                              PARAMS(assign),                   \
         |                              ^~~~~~
   drivers/thermal/./thermal_trace_ipa.h:44:1: note: in expansion of macro 'TRACE_EVENT'
      44 | TRACE_EVENT(thermal_power_actor,
         | ^~~~~~~~~~~
   drivers/thermal/./thermal_trace_ipa.h:54:9: note: in expansion of macro 'TP_fast_assign'
      54 |         TP_fast_assign(
         |         ^~~~~~~~~~~~~~
   drivers/thermal/./thermal_trace_ipa.h: In function 'trace_event_raw_event_thermal_power_allocator_pid':
   drivers/thermal/./thermal_trace_ipa.h:80:36: error: invalid use of undefined type 'struct thermal_zone_device'
      80 |                 __entry->tz_id = tz->id;
         |                                    ^~
   include/trace/trace_events.h:402:11: note: in definition of macro 'DECLARE_EVENT_CLASS'
     402 |         { assign; }                                                     \
         |           ^~~~~~
   include/trace/trace_events.h:44:30: note: in expansion of macro 'PARAMS'
      44 |                              PARAMS(assign),                   \
         |                              ^~~~~~
   drivers/thermal/./thermal_trace_ipa.h:66:1: note: in expansion of macro 'TRACE_EVENT'
      66 | TRACE_EVENT(thermal_power_allocator_pid,
         | ^~~~~~~~~~~
   drivers/thermal/./thermal_trace_ipa.h:79:9: note: in expansion of macro 'TP_fast_assign'
      79 |         TP_fast_assign(
         |         ^~~~~~~~~~~~~~
   In file included from include/trace/define_trace.h:103:
   drivers/thermal/./thermal_trace_ipa.h: In function 'perf_trace_thermal_power_allocator':
>> drivers/thermal/./thermal_trace_ipa.h:27:36: error: invalid use of undefined type 'struct thermal_zone_device'
      27 |                 __entry->tz_id = tz->id;
         |                                    ^~
   include/trace/perf.h:51:11: note: in definition of macro 'DECLARE_EVENT_CLASS'
      51 |         { assign; }                                                     \
         |           ^~~~~~
   include/trace/trace_events.h:44:30: note: in expansion of macro 'PARAMS'
      44 |                              PARAMS(assign),                   \
         |                              ^~~~~~
   drivers/thermal/./thermal_trace_ipa.h:10:1: note: in expansion of macro 'TRACE_EVENT'
      10 | TRACE_EVENT(thermal_power_allocator,
         | ^~~~~~~~~~~
   drivers/thermal/./thermal_trace_ipa.h:26:9: note: in expansion of macro 'TP_fast_assign'
      26 |         TP_fast_assign(
         |         ^~~~~~~~~~~~~~
   drivers/thermal/./thermal_trace_ipa.h: In function 'perf_trace_thermal_power_actor':
   drivers/thermal/./thermal_trace_ipa.h:55:36: error: invalid use of undefined type 'struct thermal_zone_device'
      55 |                 __entry->tz_id = tz->id;
         |                                    ^~
   include/trace/perf.h:51:11: note: in definition of macro 'DECLARE_EVENT_CLASS'
      51 |         { assign; }                                                     \
         |           ^~~~~~
   include/trace/trace_events.h:44:30: note: in expansion of macro 'PARAMS'
      44 |                              PARAMS(assign),                   \
         |                              ^~~~~~
   drivers/thermal/./thermal_trace_ipa.h:44:1: note: in expansion of macro 'TRACE_EVENT'
      44 | TRACE_EVENT(thermal_power_actor,
         | ^~~~~~~~~~~
   drivers/thermal/./thermal_trace_ipa.h:54:9: note: in expansion of macro 'TP_fast_assign'
      54 |         TP_fast_assign(
         |         ^~~~~~~~~~~~~~
   drivers/thermal/./thermal_trace_ipa.h: In function 'perf_trace_thermal_power_allocator_pid':
   drivers/thermal/./thermal_trace_ipa.h:80:36: error: invalid use of undefined type 'struct thermal_zone_device'
      80 |                 __entry->tz_id = tz->id;
         |                                    ^~
   include/trace/perf.h:51:11: note: in definition of macro 'DECLARE_EVENT_CLASS'
      51 |         { assign; }                                                     \
         |           ^~~~~~
   include/trace/trace_events.h:44:30: note: in expansion of macro 'PARAMS'
      44 |                              PARAMS(assign),                   \
         |                              ^~~~~~
   drivers/thermal/./thermal_trace_ipa.h:66:1: note: in expansion of macro 'TRACE_EVENT'
      66 | TRACE_EVENT(thermal_power_allocator_pid,
         | ^~~~~~~~~~~
   drivers/thermal/./thermal_trace_ipa.h:79:9: note: in expansion of macro 'TP_fast_assign'
      79 |         TP_fast_assign(
         |         ^~~~~~~~~~~~~~


vim +27 drivers/thermal/./thermal_trace_ipa.h

6828a4711f994b include/trace/events/thermal_power_allocator.h Javi Merino  2015-03-02   9  
6828a4711f994b include/trace/events/thermal_power_allocator.h Javi Merino  2015-03-02  10  TRACE_EVENT(thermal_power_allocator,
792c3dc08ddcf2 drivers/thermal/thermal_trace_ipa.h            Lukasz Luba  2023-12-20  11  	TP_PROTO(struct thermal_zone_device *tz, u32 total_req_power,
792c3dc08ddcf2 drivers/thermal/thermal_trace_ipa.h            Lukasz Luba  2023-12-20  12  		 u32 total_granted_power, int num_actors, u32 power_range,
792c3dc08ddcf2 drivers/thermal/thermal_trace_ipa.h            Lukasz Luba  2023-12-20  13  		 u32 max_allocatable_power, int current_temp, s32 delta_temp),
792c3dc08ddcf2 drivers/thermal/thermal_trace_ipa.h            Lukasz Luba  2023-12-20  14  	TP_ARGS(tz, total_req_power, total_granted_power, num_actors,
792c3dc08ddcf2 drivers/thermal/thermal_trace_ipa.h            Lukasz Luba  2023-12-20  15  		power_range, max_allocatable_power, current_temp, delta_temp),
6828a4711f994b include/trace/events/thermal_power_allocator.h Javi Merino  2015-03-02  16  	TP_STRUCT__entry(
6828a4711f994b include/trace/events/thermal_power_allocator.h Javi Merino  2015-03-02  17  		__field(int,           tz_id          )
6828a4711f994b include/trace/events/thermal_power_allocator.h Javi Merino  2015-03-02  18  		__field(u32,           total_req_power          )
6828a4711f994b include/trace/events/thermal_power_allocator.h Javi Merino  2015-03-02  19  		__field(u32,           total_granted_power      )
6828a4711f994b include/trace/events/thermal_power_allocator.h Javi Merino  2015-03-02  20  		__field(size_t,        num_actors               )
6828a4711f994b include/trace/events/thermal_power_allocator.h Javi Merino  2015-03-02  21  		__field(u32,           power_range              )
6828a4711f994b include/trace/events/thermal_power_allocator.h Javi Merino  2015-03-02  22  		__field(u32,           max_allocatable_power    )
17e8351a77397e include/trace/events/thermal_power_allocator.h Sascha Hauer 2015-07-24  23  		__field(int,           current_temp             )
6828a4711f994b include/trace/events/thermal_power_allocator.h Javi Merino  2015-03-02  24  		__field(s32,           delta_temp               )
6828a4711f994b include/trace/events/thermal_power_allocator.h Javi Merino  2015-03-02  25  	),
6828a4711f994b include/trace/events/thermal_power_allocator.h Javi Merino  2015-03-02  26  	TP_fast_assign(
6828a4711f994b include/trace/events/thermal_power_allocator.h Javi Merino  2015-03-02 @27  		__entry->tz_id = tz->id;
6828a4711f994b include/trace/events/thermal_power_allocator.h Javi Merino  2015-03-02  28  		__entry->total_req_power = total_req_power;
6828a4711f994b include/trace/events/thermal_power_allocator.h Javi Merino  2015-03-02  29  		__entry->total_granted_power = total_granted_power;
6828a4711f994b include/trace/events/thermal_power_allocator.h Javi Merino  2015-03-02  30  		__entry->num_actors = num_actors;
6828a4711f994b include/trace/events/thermal_power_allocator.h Javi Merino  2015-03-02  31  		__entry->power_range = power_range;
6828a4711f994b include/trace/events/thermal_power_allocator.h Javi Merino  2015-03-02  32  		__entry->max_allocatable_power = max_allocatable_power;
6828a4711f994b include/trace/events/thermal_power_allocator.h Javi Merino  2015-03-02  33  		__entry->current_temp = current_temp;
6828a4711f994b include/trace/events/thermal_power_allocator.h Javi Merino  2015-03-02  34  		__entry->delta_temp = delta_temp;
6828a4711f994b include/trace/events/thermal_power_allocator.h Javi Merino  2015-03-02  35  	),
6828a4711f994b include/trace/events/thermal_power_allocator.h Javi Merino  2015-03-02  36  
792c3dc08ddcf2 drivers/thermal/thermal_trace_ipa.h            Lukasz Luba  2023-12-20  37  	TP_printk("thermal_zone_id=%d total_req_power=%u total_granted_power=%u power_range=%u max_allocatable_power=%u current_temperature=%d delta_temperature=%d",
792c3dc08ddcf2 drivers/thermal/thermal_trace_ipa.h            Lukasz Luba  2023-12-20  38  		__entry->tz_id,	__entry->total_req_power,
6828a4711f994b include/trace/events/thermal_power_allocator.h Javi Merino  2015-03-02  39  		__entry->total_granted_power, __entry->power_range,
6828a4711f994b include/trace/events/thermal_power_allocator.h Javi Merino  2015-03-02  40  		__entry->max_allocatable_power, __entry->current_temp,
6828a4711f994b include/trace/events/thermal_power_allocator.h Javi Merino  2015-03-02  41  		__entry->delta_temp)
6828a4711f994b include/trace/events/thermal_power_allocator.h Javi Merino  2015-03-02  42  );
6828a4711f994b include/trace/events/thermal_power_allocator.h Javi Merino  2015-03-02  43  

:::::: The code at line 27 was first introduced by commit
:::::: 6828a4711f994bbd9d3fd27b7a541217fc37b341 thermal: add trace events to the power allocator governor

:::::: TO: Javi Merino <javi.merino@arm.com>
:::::: CC: Eduardo Valentin <edubezval@gmail.com>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

