Return-Path: <linux-acpi+bounces-19736-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 984E4CD3745
	for <lists+linux-acpi@lfdr.de>; Sat, 20 Dec 2025 22:05:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 04957300E151
	for <lists+linux-acpi@lfdr.de>; Sat, 20 Dec 2025 21:05:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76F242DA75F;
	Sat, 20 Dec 2025 21:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Y5qn5VqM"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B181126C384;
	Sat, 20 Dec 2025 21:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766264748; cv=none; b=GxScoTfkFunYboU1PolyDuFnrzS5FgRy4WmIp7ewwycIUFdxmaD2fArICGA8i/8sJ0JkM2o55TofAYbSYsh3FTfn4tyApM2LW7JCA7+rI4292Ru+9aOnK1ph/MFFLH312oaY3RdLn1TVdaJN8Pbhb6lTep7ZKaaHDeAPs3jyEbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766264748; c=relaxed/simple;
	bh=wa+v52Li3qRacGPhfk7l8xyCaQD+bSWOz9EQOM/HaU4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ep+uDaPxKUoHCq3xY9vCvINtOirwW5+WCVoGi4GnuSuysC3Qg3q3fOkyZMZ99Yfz0/2gNN0C5o3qKTajRu3/SM0vFf+M3kOD2n84GbaiWkmkCpN83BBX4qunEqrk0gtuxB3MKbNSARszS4GOYPjTitSKNkMMRfOk3yGsxO8EuxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Y5qn5VqM; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1766264747; x=1797800747;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=wa+v52Li3qRacGPhfk7l8xyCaQD+bSWOz9EQOM/HaU4=;
  b=Y5qn5VqMKxbRcByPw4NPqy+5mDfEgeuw6xZ/VBDW2wWL0WlTQBwzYA8d
   xV0dK4XjXM2JVpAfRS8Fpb/XhHXnz7kEqQBYspk+q5DpBZy6iQcoJWg/H
   QL0zmkahPQnKR3pkP+0QAuIJyzOvzmZajhhmkbftX9eBgUcwsG+LACYx5
   EcgEGOzXR/g1gN+X1UIHeWqgLvOR42V/m8JabbCqG6GOWGIPT3xb+J6HU
   Y5lch2iOqLDsOrC1hOWzquCrsH0XyTHIiMlLc2pAnsdjtZq9WmcTCvVcJ
   mvWUq/tRm+J07Dd1LOY9gTMpvIEphYlKM/rv+LzECNBdW8zVATNihYooS
   g==;
X-CSE-ConnectionGUID: BhmbINIxS8+b78QsFI7Pnw==
X-CSE-MsgGUID: nBX1cfGVSsCO+lZVt7LBRw==
X-IronPort-AV: E=McAfee;i="6800,10657,11648"; a="67180704"
X-IronPort-AV: E=Sophos;i="6.21,164,1763452800"; 
   d="scan'208";a="67180704"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Dec 2025 13:05:46 -0800
X-CSE-ConnectionGUID: AxXQ3QDXStSUIQbHLkspYQ==
X-CSE-MsgGUID: kSn/eufzRP2VgsFe3FOtvg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,164,1763452800"; 
   d="scan'208";a="199688317"
Received: from lkp-server01.sh.intel.com (HELO 0d09efa1b85f) ([10.239.97.150])
  by fmviesa009.fm.intel.com with ESMTP; 20 Dec 2025 13:05:44 -0800
Received: from kbuild by 0d09efa1b85f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vX490-0000000058H-0pSz;
	Sat, 20 Dec 2025 21:05:42 +0000
Date: Sun, 21 Dec 2025 05:05:31 +0800
From: kernel test robot <lkp@intel.com>
To: Haoxiang Li <lihaoxiang@isrc.iscas.ac.cn>, rafael@kernel.org
Cc: oe-kbuild-all@lists.linux.dev, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] PNP: add put_device() in pnpbios_init()
Message-ID: <202512210401.KjSlGMtG-lkp@intel.com>
References: <20251218081955.548521-1-lihaoxiang@isrc.iscas.ac.cn>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251218081955.548521-1-lihaoxiang@isrc.iscas.ac.cn>

Hi Haoxiang,

kernel test robot noticed the following build errors:

[auto build test ERROR on linus/master]
[also build test ERROR on v6.19-rc1 next-20251219]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Haoxiang-Li/PNP-add-put_device-in-pnpbios_init/20251218-162345
base:   linus/master
patch link:    https://lore.kernel.org/r/20251218081955.548521-1-lihaoxiang%40isrc.iscas.ac.cn
patch subject: [PATCH] PNP: add put_device() in pnpbios_init()
config: i386-allmodconfig (https://download.01.org/0day-ci/archive/20251221/202512210401.KjSlGMtG-lkp@intel.com/config)
compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251221/202512210401.KjSlGMtG-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202512210401.KjSlGMtG-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/pnp/pnpbios/core.c: In function 'pnp_dock_event':
   drivers/pnp/pnpbios/core.c:90:20: warning: variable 'value' set but not used [-Wunused-but-set-variable]
      90 |         int i = 0, value;
         |                    ^~~~~
   In file included from include/asm-generic/bug.h:31,
                    from arch/x86/include/asm/bug.h:193,
                    from arch/x86/include/asm/alternative.h:9,
                    from arch/x86/include/asm/barrier.h:5,
                    from include/asm-generic/bitops/generic-non-atomic.h:7,
                    from include/linux/bitops.h:28,
                    from include/linux/kernel.h:23,
                    from drivers/pnp/pnpbios/core.c:38:
   drivers/pnp/pnpbios/core.c: In function 'pnpbios_init':
>> include/linux/printk.h:482:10: error: expected expression before '{' token
     482 |         ({                                                              \
         |          ^
   include/linux/printk.h:512:26: note: in expansion of macro 'printk_index_wrap'
     512 | #define printk(fmt, ...) printk_index_wrap(_printk, fmt, ##__VA_ARGS__)
         |                          ^~~~~~~~~~~~~~~~~
   drivers/pnp/pnpbios/core.c:542:17: note: in expansion of macro 'printk'
     542 |                 printk(KERN_ERR
         |                 ^~~~~~
>> drivers/pnp/pnpbios/core.c:541:17: error: called object is not a function or function pointer
     541 |                 put_device(&pnpbios_protocol.dev)
         |                 ^~~~~~~~~~


vim +541 drivers/pnp/pnpbios/core.c

   522	
   523		/* scan the system for pnpbios support */
   524		if (!pnpbios_probe_system())
   525			return -ENODEV;
   526	
   527		/* make preparations for bios calls */
   528		pnpbios_calls_init(pnp_bios_install);
   529	
   530		/* read the node info */
   531		ret = pnp_bios_dev_node_info(&node_info);
   532		if (ret) {
   533			printk(KERN_ERR
   534			       "PnPBIOS: Unable to get node info.  Aborting.\n");
   535			return ret;
   536		}
   537	
   538		/* register with the pnp layer */
   539		ret = pnp_register_protocol(&pnpbios_protocol);
   540		if (ret) {
 > 541			put_device(&pnpbios_protocol.dev)
   542			printk(KERN_ERR
   543			       "PnPBIOS: Unable to register driver.  Aborting.\n");
   544			return ret;
   545		}
   546	
   547		/* start the proc interface */
   548		ret = pnpbios_proc_init();
   549		if (ret)
   550			printk(KERN_ERR "PnPBIOS: Failed to create proc interface.\n");
   551	
   552		/* scan for pnpbios devices */
   553		build_devlist();
   554	
   555		pnp_platform_devices = 1;
   556		return 0;
   557	}
   558	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

