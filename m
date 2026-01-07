Return-Path: <linux-acpi+bounces-20036-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 91703D004D6
	for <lists+linux-acpi@lfdr.de>; Wed, 07 Jan 2026 23:26:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 774A330173B4
	for <lists+linux-acpi@lfdr.de>; Wed,  7 Jan 2026 22:26:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB9FB2882BB;
	Wed,  7 Jan 2026 22:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="F9XXCgPg"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27777227BB5;
	Wed,  7 Jan 2026 22:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767824766; cv=none; b=or2WH1u2xA999+w4fNIm/UBP1YW17OR7Bk+2B+rmbRUTgo/MLw3cCN0rJZpTWP8RLx41gcZyRXUv1jlrnKK2M53ST3ggfjXZKfD5rQx82dLfdlcsRgATyWExkqkLiRKaYHPJ83JU+Dh0MG/JY8rEmMv268bRZ30tyBR3CdllVLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767824766; c=relaxed/simple;
	bh=9hOqLeKQfUMSYkkpTVWyJSzNqwKSLw0uBLxQwep2krQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B4za5d3VEjBMCiX7lMeVLoGQiAkcrb23ZwQZQyWKFvv2Gv/gabkB4BLTAnr7LvURaS/PZ88xNeMyfjVqNCZ2qq0/MhokFHft6q8OzrhHR5Pizg5+6N83Ey3SwtcK5S5OPwpEBhe3N5LKFaxKaThi3127y06N0axciUGe9oWU38U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=F9XXCgPg; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1767824765; x=1799360765;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=9hOqLeKQfUMSYkkpTVWyJSzNqwKSLw0uBLxQwep2krQ=;
  b=F9XXCgPguSIVmWM42N3zuO/kn2lLWDInlWuNL4kMmMS2KhNwhXyZpv2F
   /onQNeCau//gJOJHgtuk7+k0UmxdHBbe2EameggVh8HocCkPNMLPxI7JM
   X4b5t5D3Vj1GUTz8GLfdrr4RY18y2K/KzgcLVqPKDEIMhEj/1NZ6uQY80
   e7mjyoFHMkbnNo6fRpI2GosxCQejFd28606EW8sFNyDEqUir4nE2AQIpx
   aUzPQy/wsr8IPOdtPavWO0l07zc8DVCVEwnRvvlbqqsnhY1kNrBwwW0dv
   hONl2e1BdTi7l2uEwWSZk5LO7865ED+pKW0MfGtKZFVMu6+ePrz3ZeJQC
   Q==;
X-CSE-ConnectionGUID: hjX5DlwJTs+yn1PTN81Xbg==
X-CSE-MsgGUID: Lf7Yys3qSkSrn1a4RBVxuA==
X-IronPort-AV: E=McAfee;i="6800,10657,11664"; a="91861176"
X-IronPort-AV: E=Sophos;i="6.21,209,1763452800"; 
   d="scan'208";a="91861176"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jan 2026 14:26:04 -0800
X-CSE-ConnectionGUID: yPETnroYRD6Zd3gHvp1mfA==
X-CSE-MsgGUID: Pv0S92j0SW2lMmeidoZfJA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,209,1763452800"; 
   d="scan'208";a="208103094"
Received: from igk-lkp-server01.igk.intel.com (HELO 92b2e8bd97aa) ([10.211.93.152])
  by orviesa005.jf.intel.com with ESMTP; 07 Jan 2026 14:26:02 -0800
Received: from kbuild by 92b2e8bd97aa with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vdbyZ-000000001d6-2Awd;
	Wed, 07 Jan 2026 22:25:59 +0000
Date: Wed, 7 Jan 2026 23:25:14 +0100
From: kernel test robot <lkp@intel.com>
To: Kartik Rajput <kkartik@nvidia.com>, lenb@kernel.org,
	sakari.ailus@linux.intel.com, mika.westerberg@linux.intel.com,
	andriy.shevchenko@linux.intel.com, thierry.reding@gmail.com,
	jonathanh@nvidia.com, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, Kartik Rajput <kkartik@nvidia.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH] ACPI: bus: Use OF match data for PRP0001 matched devices
Message-ID: <202601072317.QNoPkgyy-lkp@intel.com>
References: <20260107062453.10893-1-kkartik@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260107062453.10893-1-kkartik@nvidia.com>

Hi Kartik,

kernel test robot noticed the following build errors:

[auto build test ERROR on rafael-pm/linux-next]
[also build test ERROR on rafael-pm/bleeding-edge westeri-thunderbolt/next linus/master v6.19-rc4 next-20260107]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Kartik-Rajput/ACPI-bus-Use-OF-match-data-for-PRP0001-matched-devices/20260107-142543
base:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git linux-next
patch link:    https://lore.kernel.org/r/20260107062453.10893-1-kkartik%40nvidia.com
patch subject: [PATCH] ACPI: bus: Use OF match data for PRP0001 matched devices
config: x86_64-rhel-9.4 (https://download.01.org/0day-ci/archive/20260107/202601072317.QNoPkgyy-lkp@intel.com/config)
compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260107/202601072317.QNoPkgyy-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202601072317.QNoPkgyy-lkp@intel.com/

All error/warnings (new ones prefixed by >>):

   drivers/acpi/bus.c: In function 'acpi_device_get_match_data':
>> drivers/acpi/bus.c:1034:28: error: expected identifier or '(' before '=' token
    1034 |         struct acpi_device = ACPI_COMPANION(dev);
         |                            ^
   In file included from include/linux/acpi.h:38,
                    from drivers/acpi/bus.c:19:
>> include/acpi/acpi_bus.h:531:10: error: expected statement before ')' token
     531 |         })
         |          ^
   include/linux/acpi.h:58:41: note: in expansion of macro 'to_acpi_device_node'
      58 | #define ACPI_COMPANION(dev)             to_acpi_device_node((dev)->fwnode)
         |                                         ^~~~~~~~~~~~~~~~~~~
   drivers/acpi/bus.c:1034:30: note: in expansion of macro 'ACPI_COMPANION'
    1034 |         struct acpi_device = ACPI_COMPANION(dev);
         |                              ^~~~~~~~~~~~~~
>> drivers/acpi/bus.c:1036:60: error: 'adev' undeclared (first use in this function); did you mean 'dev'?
    1036 |         if (!strcmp(ACPI_DT_NAMESPACE_HID, acpi_device_hid(adev))
         |                                                            ^~~~
         |                                                            dev
   drivers/acpi/bus.c:1036:60: note: each undeclared identifier is reported only once for each function it appears in
>> drivers/acpi/bus.c:1036:66: error: expected ')' before 'return'
    1036 |         if (!strcmp(ACPI_DT_NAMESPACE_HID, acpi_device_hid(adev))
         |            ~                                                     ^
         |                                                                  )
    1037 |                 return acpi_of_device_get_match_data(dev);
         |                 ~~~~~~                                            
>> drivers/acpi/bus.c:1044:1: error: expected expression before '}' token
    1044 | }
         | ^
>> drivers/acpi/bus.c:1033:38: warning: unused variable 'match' [-Wunused-variable]
    1033 |         const struct acpi_device_id *match;
         |                                      ^~~~~
>> drivers/acpi/bus.c:1032:38: warning: unused variable 'acpi_ids' [-Wunused-variable]
    1032 |         const struct acpi_device_id *acpi_ids = dev->driver->acpi_match_table;
         |                                      ^~~~~~~~
>> drivers/acpi/bus.c:1044:1: warning: control reaches end of non-void function [-Wreturn-type]
    1044 | }
         | ^
   drivers/acpi/bus.c: At top level:
>> drivers/acpi/bus.c:1019:20: warning: 'acpi_of_device_get_match_data' defined but not used [-Wunused-function]
    1019 | static const void *acpi_of_device_get_match_data(const struct device *dev)
         |                    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~


vim +1034 drivers/acpi/bus.c

  1018	
> 1019	static const void *acpi_of_device_get_match_data(const struct device *dev)
  1020	{
  1021		struct acpi_device *adev = ACPI_COMPANION(dev);
  1022		const struct of_device_id *match = NULL;
  1023	
  1024		if (!acpi_of_match_device(adev, dev->driver->of_match_table, &match))
  1025			return NULL;
  1026	
  1027		return match->data;
  1028	}
  1029	
  1030	const void *acpi_device_get_match_data(const struct device *dev)
  1031	{
> 1032		const struct acpi_device_id *acpi_ids = dev->driver->acpi_match_table;
> 1033		const struct acpi_device_id *match;
> 1034		struct acpi_device = ACPI_COMPANION(dev);
  1035	
> 1036		if (!strcmp(ACPI_DT_NAMESPACE_HID, acpi_device_hid(adev))
  1037			return acpi_of_device_get_match_data(dev);
  1038	
  1039		match = acpi_match_device(acpi_ids, dev);
  1040		if (!match)
  1041			return NULL;
  1042	
  1043		return (const void *)match->driver_data;
> 1044	}
  1045	EXPORT_SYMBOL_GPL(acpi_device_get_match_data);
  1046	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

