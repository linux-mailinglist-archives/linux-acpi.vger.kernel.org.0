Return-Path: <linux-acpi+bounces-1246-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29DE27E1963
	for <lists+linux-acpi@lfdr.de>; Mon,  6 Nov 2023 05:33:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CEF542812A2
	for <lists+linux-acpi@lfdr.de>; Mon,  6 Nov 2023 04:33:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8616C2F3D
	for <lists+linux-acpi@lfdr.de>; Mon,  6 Nov 2023 04:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gdLqwnBf"
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C45F567E
	for <linux-acpi@vger.kernel.org>; Mon,  6 Nov 2023 04:27:03 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADE97BF
	for <linux-acpi@vger.kernel.org>; Sun,  5 Nov 2023 20:27:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699244821; x=1730780821;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=KDrF/+rw6iKfX/7yKWQ82hCRdFDXfTxMoCTrnLiI4HY=;
  b=gdLqwnBf9glkhXc23Fs8Xgi/oK4M12YKdOYFAe7CLjt1jp0WT31l2Hk0
   KgWdmoCgpWG2OmrWP2p2Q2BeKt/133DVr4+3DE9zSB7CA81DNVU+fa8/s
   EmjdGM/mFdQle4h0g2yKOKTd9vTejurjAr6fBhuaILsHypaJcBLud/JX2
   7iAh3TO+OpSj47bPg/Y6hcAosrnz27ZltuXp6Z6fLpnLuahIrJ/fVE2gQ
   LwfY16OhgfOkAEvYPaVq8c8GS8HymDfT6qUc/5j4sTXBprzEpOBZ742qo
   qS0TJrpWqwSdB6ISk1mGzeksvQsoCfNnghGd7qtgpzi/UUXVJsHIoEozx
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10885"; a="2114490"
X-IronPort-AV: E=Sophos;i="6.03,280,1694761200"; 
   d="scan'208";a="2114490"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2023 20:27:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10885"; a="765833994"
X-IronPort-AV: E=Sophos;i="6.03,280,1694761200"; 
   d="scan'208";a="765833994"
Received: from lkp-server01.sh.intel.com (HELO 17d9e85e5079) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 05 Nov 2023 20:26:59 -0800
Received: from kbuild by 17d9e85e5079 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1qzrCT-00066U-0u;
	Mon, 06 Nov 2023 04:26:57 +0000
Date: Mon, 6 Nov 2023 12:26:02 +0800
From: kernel test robot <lkp@intel.com>
To: Vicki Pfau <vi@endrift.com>, "Rafael J . Wysocki" <rafael@kernel.org>,
	linux-acpi@vger.kernel.org, Len Brown <lenb@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, Vicki Pfau <vi@endrift.com>
Subject: Re: [PATCH v2] ACPI: utils: Make acpi_handle_list dynamically
 allocated
Message-ID: <202311061141.kEqwdu4M-lkp@intel.com>
References: <20230927201725.2339488-1-vi@endrift.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230927201725.2339488-1-vi@endrift.com>

Hi Vicki,

kernel test robot noticed the following build warnings:

[auto build test WARNING on linus/master]
[also build test WARNING on v6.6]
[cannot apply to rafael-pm/linux-next next-20231106]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Vicki-Pfau/ACPI-utils-Make-acpi_handle_list-dynamically-allocated/20230928-043202
base:   linus/master
patch link:    https://lore.kernel.org/r/20230927201725.2339488-1-vi%40endrift.com
patch subject: [PATCH v2] ACPI: utils: Make acpi_handle_list dynamically allocated
config: x86_64-randconfig-123-20230930 (https://download.01.org/0day-ci/archive/20231106/202311061141.kEqwdu4M-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231106/202311061141.kEqwdu4M-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311061141.kEqwdu4M-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/acpi/thermal.c:310:54: sparse: sparse: incompatible types for operation (!=):
>> drivers/acpi/thermal.c:310:54: sparse:    unsigned int *
>> drivers/acpi/thermal.c:310:54: sparse:    unsigned int [addressable] [usertype] count
   drivers/acpi/thermal.c:377:64: sparse: sparse: incompatible types for operation (!=):
   drivers/acpi/thermal.c:377:64: sparse:    unsigned int *
   drivers/acpi/thermal.c:377:64: sparse:    unsigned int [addressable] [usertype] count

vim +310 drivers/acpi/thermal.c

   190	
   191	static void __acpi_thermal_trips_update(struct acpi_thermal *tz, int flag)
   192	{
   193		acpi_status status;
   194		unsigned long long tmp;
   195		struct acpi_handle_list devices;
   196		bool valid = false;
   197		int i;
   198	
   199		/* Critical Shutdown */
   200		if (flag & ACPI_TRIPS_CRITICAL) {
   201			status = acpi_evaluate_integer(tz->device->handle, "_CRT", NULL, &tmp);
   202			tz->trips.critical.temperature = tmp;
   203			/*
   204			 * Treat freezing temperatures as invalid as well; some
   205			 * BIOSes return really low values and cause reboots at startup.
   206			 * Below zero (Celsius) values clearly aren't right for sure..
   207			 * ... so lets discard those as invalid.
   208			 */
   209			if (ACPI_FAILURE(status)) {
   210				tz->trips.critical.valid = false;
   211				acpi_handle_debug(tz->device->handle,
   212						  "No critical threshold\n");
   213			} else if (tmp <= 2732) {
   214				pr_info(FW_BUG "Invalid critical threshold (%llu)\n", tmp);
   215				tz->trips.critical.valid = false;
   216			} else {
   217				tz->trips.critical.valid = true;
   218				acpi_handle_debug(tz->device->handle,
   219						  "Found critical threshold [%lu]\n",
   220						  tz->trips.critical.temperature);
   221			}
   222			if (tz->trips.critical.valid) {
   223				if (crt == -1) {
   224					tz->trips.critical.valid = false;
   225				} else if (crt > 0) {
   226					unsigned long crt_k = celsius_to_deci_kelvin(crt);
   227	
   228					/*
   229					 * Allow override critical threshold
   230					 */
   231					if (crt_k > tz->trips.critical.temperature)
   232						pr_info("Critical threshold %d C\n", crt);
   233	
   234					tz->trips.critical.temperature = crt_k;
   235				}
   236			}
   237		}
   238	
   239		/* Critical Sleep (optional) */
   240		if (flag & ACPI_TRIPS_HOT) {
   241			status = acpi_evaluate_integer(tz->device->handle, "_HOT", NULL, &tmp);
   242			if (ACPI_FAILURE(status)) {
   243				tz->trips.hot.valid = false;
   244				acpi_handle_debug(tz->device->handle,
   245						  "No hot threshold\n");
   246			} else {
   247				tz->trips.hot.temperature = tmp;
   248				tz->trips.hot.valid = true;
   249				acpi_handle_debug(tz->device->handle,
   250						  "Found hot threshold [%lu]\n",
   251						  tz->trips.hot.temperature);
   252			}
   253		}
   254	
   255		/* Passive (optional) */
   256		if (((flag & ACPI_TRIPS_PASSIVE) && tz->trips.passive.trip.valid) ||
   257		    flag == ACPI_TRIPS_INIT) {
   258			valid = tz->trips.passive.trip.valid;
   259			if (psv == -1) {
   260				status = AE_SUPPORT;
   261			} else if (psv > 0) {
   262				tmp = celsius_to_deci_kelvin(psv);
   263				status = AE_OK;
   264			} else {
   265				status = acpi_evaluate_integer(tz->device->handle,
   266							       "_PSV", NULL, &tmp);
   267			}
   268	
   269			if (ACPI_FAILURE(status)) {
   270				tz->trips.passive.trip.valid = false;
   271			} else {
   272				tz->trips.passive.trip.temperature = tmp;
   273				tz->trips.passive.trip.valid = true;
   274				if (flag == ACPI_TRIPS_INIT) {
   275					status = acpi_evaluate_integer(tz->device->handle,
   276								       "_TC1", NULL, &tmp);
   277					if (ACPI_FAILURE(status))
   278						tz->trips.passive.trip.valid = false;
   279					else
   280						tz->trips.passive.tc1 = tmp;
   281	
   282					status = acpi_evaluate_integer(tz->device->handle,
   283								       "_TC2", NULL, &tmp);
   284					if (ACPI_FAILURE(status))
   285						tz->trips.passive.trip.valid = false;
   286					else
   287						tz->trips.passive.tc2 = tmp;
   288	
   289					status = acpi_evaluate_integer(tz->device->handle,
   290								       "_TSP", NULL, &tmp);
   291					if (ACPI_FAILURE(status))
   292						tz->trips.passive.trip.valid = false;
   293					else
   294						tz->trips.passive.tsp = tmp;
   295				}
   296			}
   297		}
   298		if ((flag & ACPI_TRIPS_DEVICES) && tz->trips.passive.trip.valid) {
   299			memset(&devices, 0, sizeof(struct acpi_handle_list));
   300			status = acpi_evaluate_reference(tz->device->handle, "_PSL",
   301							 NULL, &devices);
   302			if (ACPI_FAILURE(status)) {
   303				acpi_handle_info(tz->device->handle,
   304						 "Invalid passive threshold\n");
   305				tz->trips.passive.trip.valid = false;
   306			} else {
   307				tz->trips.passive.trip.valid = true;
   308			}
   309	
 > 310			if (&tz->trips.passive.devices.count != devices.count ||
   311				   memcmp(tz->trips.passive.devices.handles,
   312				   devices.handles, sizeof(acpi_handle) * devices.count)) {
   313				kfree(tz->trips.passive.devices.handles);
   314				memcpy(&tz->trips.passive.devices, &devices,
   315				       sizeof(struct acpi_handle_list));
   316				ACPI_THERMAL_TRIPS_EXCEPTION(flag, tz, "device");
   317			}
   318		}
   319		if ((flag & ACPI_TRIPS_PASSIVE) || (flag & ACPI_TRIPS_DEVICES)) {
   320			if (valid != tz->trips.passive.trip.valid)
   321				ACPI_THERMAL_TRIPS_EXCEPTION(flag, tz, "state");
   322		}
   323	
   324		/* Active (optional) */
   325		for (i = 0; i < ACPI_THERMAL_MAX_ACTIVE; i++) {
   326			char name[5] = { '_', 'A', 'C', ('0' + i), '\0' };
   327			valid = tz->trips.active[i].trip.valid;
   328	
   329			if (act == -1)
   330				break; /* disable all active trip points */
   331	
   332			if (flag == ACPI_TRIPS_INIT || ((flag & ACPI_TRIPS_ACTIVE) &&
   333			    tz->trips.active[i].trip.valid)) {
   334				status = acpi_evaluate_integer(tz->device->handle,
   335							       name, NULL, &tmp);
   336				if (ACPI_FAILURE(status)) {
   337					tz->trips.active[i].trip.valid = false;
   338					if (i == 0)
   339						break;
   340	
   341					if (act <= 0)
   342						break;
   343	
   344					if (i == 1)
   345						tz->trips.active[0].trip.temperature =
   346								celsius_to_deci_kelvin(act);
   347					else
   348						/*
   349						 * Don't allow override higher than
   350						 * the next higher trip point
   351						 */
   352						tz->trips.active[i-1].trip.temperature =
   353							min_t(unsigned long,
   354							      tz->trips.active[i-2].trip.temperature,
   355							      celsius_to_deci_kelvin(act));
   356	
   357					break;
   358				} else {
   359					tz->trips.active[i].trip.temperature = tmp;
   360					tz->trips.active[i].trip.valid = true;
   361				}
   362			}
   363	
   364			name[2] = 'L';
   365			if ((flag & ACPI_TRIPS_DEVICES) && tz->trips.active[i].trip.valid) {
   366				memset(&devices, 0, sizeof(struct acpi_handle_list));
   367				status = acpi_evaluate_reference(tz->device->handle,
   368								 name, NULL, &devices);
   369				if (ACPI_FAILURE(status)) {
   370					acpi_handle_info(tz->device->handle,
   371							 "Invalid active%d threshold\n", i);
   372					tz->trips.active[i].trip.valid = false;
   373				} else {
   374					tz->trips.active[i].trip.valid = true;
   375				}
   376	
   377				if (&tz->trips.active[i].devices.count != devices.count ||
   378					   memcmp(tz->trips.active[i].devices.handles,
   379					   devices.handles, sizeof(acpi_handle) * devices.count)) {
   380					kfree(tz->trips.active[i].devices.handles);
   381					memcpy(&tz->trips.active[i].devices, &devices,
   382					       sizeof(struct acpi_handle_list));
   383					ACPI_THERMAL_TRIPS_EXCEPTION(flag, tz, "device");
   384				}
   385			}
   386			if ((flag & ACPI_TRIPS_ACTIVE) || (flag & ACPI_TRIPS_DEVICES))
   387				if (valid != tz->trips.active[i].trip.valid)
   388					ACPI_THERMAL_TRIPS_EXCEPTION(flag, tz, "state");
   389	
   390			if (!tz->trips.active[i].trip.valid)
   391				break;
   392		}
   393	
   394		if (flag & ACPI_TRIPS_DEVICES) {
   395			memset(&devices, 0, sizeof(devices));
   396			status = acpi_evaluate_reference(tz->device->handle, "_TZD",
   397							 NULL, &devices);
   398			if (ACPI_SUCCESS(status) && (tz->devices.count != devices.count ||
   399			    memcmp(tz->devices.handles, devices.handles,
   400			    sizeof(acpi_handle) * devices.count))) {
   401				kfree(tz->devices.handles);
   402				tz->devices = devices;
   403				ACPI_THERMAL_TRIPS_EXCEPTION(flag, tz, "device");
   404			}
   405		}
   406	}
   407	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

