Return-Path: <linux-acpi+bounces-13783-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 49538ABB03D
	for <lists+linux-acpi@lfdr.de>; Sun, 18 May 2025 14:38:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F3EAE3BA00A
	for <lists+linux-acpi@lfdr.de>; Sun, 18 May 2025 12:38:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C018212FB7;
	Sun, 18 May 2025 12:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Bd4ajHOR"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF56315E8B;
	Sun, 18 May 2025 12:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747571914; cv=none; b=usKqVJPN55M59L2T4/97sca3S5td42e7tTrps6psWQMeKCluC+cwd95tQadhgZGzKLnndAM3JV9AE45gZaNJiZmfLys9UIMOmOnT6Ai1CEhvnwe3uPqvoQgDwZmWRZ7v1b56cBu2PS02sXZuh7XNpn6CJiwRG6UQQsLbOZ5oa6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747571914; c=relaxed/simple;
	bh=PoyuPg5e2LU/+nVt9+qZ5GK2kKH6IQI8uCwbW3k0Avg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e32w3xSl3D+JlOEGIqsknbDnMUCChYBoAz5EiEXVUjsa0jGpzi7BzaE+R17oXy2vvEhID+HU9BcsUjVpTJ2i1Hp5CBldbkjV4OsjAXND50L/PBv1vK3XqnvRyAS5+JAhs/KC5KNnfW5xAlH1NxESfhRSp3HAmWlDs30tkOCpALU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Bd4ajHOR; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747571911; x=1779107911;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=PoyuPg5e2LU/+nVt9+qZ5GK2kKH6IQI8uCwbW3k0Avg=;
  b=Bd4ajHORb5zh7ouk3qk6kHfPtoF+FI20U2aRM1asA/6yB4HAOqZVWtVT
   /hmjIUkIj8rfZjs/GQ5gcrQTqZBmSBKA/FPcLLvMzrghz6PgVhN4bWqpx
   gJvy/ceDlazjkPFBHjfxzZoXL488r9jsGUTzXAK7vWgl9S1ODoqqzYL8Z
   CNdxVaXQN9D8ydL8l7CBhcudKjGOLTjXHD67uPRUc3R/gFTlMshVyX1Ln
   Uk37sLLyLFu6obVqHVeCQakz7MRYA9L37vgV5doX1m871tfr7kc4TL5+r
   ZTTT2cik2g4NlKHCphjUMLW9XhroRzPhKObk9lWCAYqezBbdyoQGzFS4b
   g==;
X-CSE-ConnectionGUID: GRlTzs++Qp6Ei01ZL207Gw==
X-CSE-MsgGUID: OYsPGuwzQ3Krbo0dYyCoBA==
X-IronPort-AV: E=McAfee;i="6700,10204,11436"; a="49180167"
X-IronPort-AV: E=Sophos;i="6.15,298,1739865600"; 
   d="scan'208";a="49180167"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2025 05:38:31 -0700
X-CSE-ConnectionGUID: M+m2/Jz9Tlu/ErvWTLKXtw==
X-CSE-MsgGUID: 7cNYVkumQkmgrQGQChpJ8g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,298,1739865600"; 
   d="scan'208";a="139029180"
Received: from lkp-server01.sh.intel.com (HELO 1992f890471c) ([10.239.97.150])
  by orviesa006.jf.intel.com with ESMTP; 18 May 2025 05:38:28 -0700
Received: from kbuild by 1992f890471c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uGdHe-000KnX-09;
	Sun, 18 May 2025 12:38:26 +0000
Date: Sun, 18 May 2025 20:38:02 +0800
From: kernel test robot <lkp@intel.com>
To: Janne Grunau via B4 Relay <devnull+j.jannau.net@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>, Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-input@vger.kernel.org, linux-acpi@vger.kernel.org,
	Janne Grunau <j@jannau.net>
Subject: Re: [PATCH 1/2] ACPI: platform_profile: Stub platform_profile_cycle
Message-ID: <202505182014.8Vkd2piH-lkp@intel.com>
References: <20250518-hid_lenovo_acpi_dependency-v1-1-afdb93b5d1a6@jannau.net>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250518-hid_lenovo_acpi_dependency-v1-1-afdb93b5d1a6@jannau.net>

Hi Janne,

kernel test robot noticed the following build errors:

[auto build test ERROR on 0af2f6be1b4281385b618cb86ad946eded089ac8]

url:    https://github.com/intel-lab-lkp/linux/commits/Janne-Grunau-via-B4-Relay/ACPI-platform_profile-Stub-platform_profile_cycle/20250518-182021
base:   0af2f6be1b4281385b618cb86ad946eded089ac8
patch link:    https://lore.kernel.org/r/20250518-hid_lenovo_acpi_dependency-v1-1-afdb93b5d1a6%40jannau.net
patch subject: [PATCH 1/2] ACPI: platform_profile: Stub platform_profile_cycle
config: x86_64-buildonly-randconfig-005-20250518 (https://download.01.org/0day-ci/archive/20250518/202505182014.8Vkd2piH-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250518/202505182014.8Vkd2piH-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202505182014.8Vkd2piH-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/acpi/platform_profile.c:493:5: error: redefinition of 'platform_profile_cycle'
     493 | int platform_profile_cycle(void)
         |     ^~~~~~~~~~~~~~~~~~~~~~
   In file included from drivers/acpi/platform_profile.c:12:
   include/linux/platform_profile.h:64:19: note: previous definition of 'platform_profile_cycle' with type 'int(void)'
      64 | static inline int platform_profile_cycle(void)
         |                   ^~~~~~~~~~~~~~~~~~~~~~


vim +/platform_profile_cycle +493 drivers/acpi/platform_profile.c

a2ff95e018f1d2 Mark Pearson      2020-12-29  487  
ee7f3e2b4942e3 Kurt Borja        2025-01-15  488  /**
ee7f3e2b4942e3 Kurt Borja        2025-01-15  489   * platform_profile_cycle - Cycles profiles available on all registered class devices
ee7f3e2b4942e3 Kurt Borja        2025-01-15  490   *
ee7f3e2b4942e3 Kurt Borja        2025-01-15  491   * Return: 0 on success, -errno on failure
ee7f3e2b4942e3 Kurt Borja        2025-01-15  492   */
ba95eb44676d68 Gergo Koteles     2024-04-08 @493  int platform_profile_cycle(void)
ba95eb44676d68 Gergo Koteles     2024-04-08  494  {
778b94d7ac17b5 Mario Limonciello 2025-02-28  495  	struct aggregate_choices_data data = {
778b94d7ac17b5 Mario Limonciello 2025-02-28  496  		.aggregate = { [0 ... BITS_TO_LONGS(PLATFORM_PROFILE_LAST) - 1] = ~0UL },
778b94d7ac17b5 Mario Limonciello 2025-02-28  497  		.count = 0,
778b94d7ac17b5 Mario Limonciello 2025-02-28  498  	};
70246f89c55fb1 Mario Limonciello 2024-12-05  499  	enum platform_profile_option next = PLATFORM_PROFILE_LAST;
70246f89c55fb1 Mario Limonciello 2024-12-05  500  	enum platform_profile_option profile = PLATFORM_PROFILE_LAST;
ba95eb44676d68 Gergo Koteles     2024-04-08  501  	int err;
ba95eb44676d68 Gergo Koteles     2024-04-08  502  
1f3ac55c2e65af Mario Limonciello 2024-12-05  503  	scoped_cond_guard(mutex_intr, return -ERESTARTSYS, &profile_lock) {
70246f89c55fb1 Mario Limonciello 2024-12-05  504  		err = class_for_each_device(&platform_profile_class, NULL,
70246f89c55fb1 Mario Limonciello 2024-12-05  505  					    &profile, _aggregate_profiles);
70246f89c55fb1 Mario Limonciello 2024-12-05  506  		if (err)
70246f89c55fb1 Mario Limonciello 2024-12-05  507  			return err;
ba95eb44676d68 Gergo Koteles     2024-04-08  508  
70246f89c55fb1 Mario Limonciello 2024-12-05  509  		if (profile == PLATFORM_PROFILE_CUSTOM ||
70246f89c55fb1 Mario Limonciello 2024-12-05  510  		    profile == PLATFORM_PROFILE_LAST)
70246f89c55fb1 Mario Limonciello 2024-12-05  511  			return -EINVAL;
70246f89c55fb1 Mario Limonciello 2024-12-05  512  
70246f89c55fb1 Mario Limonciello 2024-12-05  513  		err = class_for_each_device(&platform_profile_class, NULL,
778b94d7ac17b5 Mario Limonciello 2025-02-28  514  					    &data, _aggregate_choices);
1f3ac55c2e65af Mario Limonciello 2024-12-05  515  		if (err)
ba95eb44676d68 Gergo Koteles     2024-04-08  516  			return err;
ba95eb44676d68 Gergo Koteles     2024-04-08  517  
70246f89c55fb1 Mario Limonciello 2024-12-05  518  		/* never iterate into a custom if all drivers supported it */
778b94d7ac17b5 Mario Limonciello 2025-02-28  519  		clear_bit(PLATFORM_PROFILE_CUSTOM, data.aggregate);
70246f89c55fb1 Mario Limonciello 2024-12-05  520  
778b94d7ac17b5 Mario Limonciello 2025-02-28  521  		next = find_next_bit_wrap(data.aggregate,
70246f89c55fb1 Mario Limonciello 2024-12-05  522  					  PLATFORM_PROFILE_LAST,
ba95eb44676d68 Gergo Koteles     2024-04-08  523  					  profile + 1);
ba95eb44676d68 Gergo Koteles     2024-04-08  524  
70246f89c55fb1 Mario Limonciello 2024-12-05  525  		err = class_for_each_device(&platform_profile_class, NULL, &next,
70246f89c55fb1 Mario Limonciello 2024-12-05  526  					    _store_and_notify);
ba95eb44676d68 Gergo Koteles     2024-04-08  527  
1f3ac55c2e65af Mario Limonciello 2024-12-05  528  		if (err)
1f3ac55c2e65af Mario Limonciello 2024-12-05  529  			return err;
1f3ac55c2e65af Mario Limonciello 2024-12-05  530  	}
ba95eb44676d68 Gergo Koteles     2024-04-08  531  
ba95eb44676d68 Gergo Koteles     2024-04-08  532  	sysfs_notify(acpi_kobj, NULL, "platform_profile");
ba95eb44676d68 Gergo Koteles     2024-04-08  533  
1f3ac55c2e65af Mario Limonciello 2024-12-05  534  	return 0;
ba95eb44676d68 Gergo Koteles     2024-04-08  535  }
ba95eb44676d68 Gergo Koteles     2024-04-08  536  EXPORT_SYMBOL_GPL(platform_profile_cycle);
ba95eb44676d68 Gergo Koteles     2024-04-08  537  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

