Return-Path: <linux-acpi+bounces-19735-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F0C4ECD33B9
	for <lists+linux-acpi@lfdr.de>; Sat, 20 Dec 2025 17:42:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BF50E300955F
	for <lists+linux-acpi@lfdr.de>; Sat, 20 Dec 2025 16:42:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04EB630C635;
	Sat, 20 Dec 2025 16:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Pqs5G2mV"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 376B1267B92;
	Sat, 20 Dec 2025 16:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766248950; cv=none; b=jl1EE2DPxMXbj7p7NFI2KgqwesnCU9vATkNqhOmXiFW3XsRPv1KL3yiLh0j072PznoqywCSQv93usUX5Mm+8Fg4EBxioGDbgOuij9GBTynpFumZftD57IkR+wqEj9wb/QN92zlZpVPb/xvFUu6iYMtLxft+K1+oEHMc/KT9B9m4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766248950; c=relaxed/simple;
	bh=UKq/YKhdCfvwv8fxPQ2c+bvnJLltn0AWOmEr4EYaDGE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f84DLmrg7GAg3OaY2CR3o5loXuBbJrO7EbR1mLLjkmM4xx+nTQ7kxzmmAV8Zx2DazWYTT6+cYTaANWcZ16MdGcWaDjA6mQOGUUXz5Ulg6hXGlQ1CvQ/kei95pm3HVoBpB6RbsWnn/dUAyGK2Xx5HK/kYNrz9nU9AMqICzVBOrvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Pqs5G2mV; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1766248949; x=1797784949;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=UKq/YKhdCfvwv8fxPQ2c+bvnJLltn0AWOmEr4EYaDGE=;
  b=Pqs5G2mVEfQDMXlYwHgqr1HBXrGZZz78kDTC3Wynz8OeQtpe8ZYV4G9l
   cUwHi6lcNa3CJvfgEwqDDoRlB64AeZoKRI9vluNxVo/D8PVSHS2c+UOMg
   5UW29vnv+h2jaeiDXQq8E6ZM0ZSaUFjEA3Ueb8YvpxL0BntXC3grgptxw
   5+xOJOSq9WOS2k3y68UTuwiZbJSjYt+cX2MTYg+gA9GkywEfqA1WPgliB
   xkNr2kRsGp0BTWInlwfSSiAUvxeE87QhDc/DlV+heON8G7qugVdFXtUw/
   6q2+MPen06GZzTbmN633WonsCL1BVmQzFayhhdHRMd337nZGiNUc75D6T
   A==;
X-CSE-ConnectionGUID: ClK4BbeHTV2Zi1w81PgVBw==
X-CSE-MsgGUID: NxxgkyH2QZmNWeACsJlSrQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11648"; a="85764590"
X-IronPort-AV: E=Sophos;i="6.21,164,1763452800"; 
   d="scan'208";a="85764590"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Dec 2025 08:42:29 -0800
X-CSE-ConnectionGUID: 8712+kArTMieRGw7RtjfXw==
X-CSE-MsgGUID: YWhwKq7rRjqiflXSjEQIrA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,164,1763452800"; 
   d="scan'208";a="199170423"
Received: from lkp-server01.sh.intel.com (HELO 0d09efa1b85f) ([10.239.97.150])
  by orviesa008.jf.intel.com with ESMTP; 20 Dec 2025 08:42:26 -0800
Received: from kbuild by 0d09efa1b85f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vX02B-000000004tF-2oj0;
	Sat, 20 Dec 2025 16:42:23 +0000
Date: Sun, 21 Dec 2025 00:41:47 +0800
From: kernel test robot <lkp@intel.com>
To: Haoxiang Li <lihaoxiang@isrc.iscas.ac.cn>, rafael@kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] PNP: add put_device() in pnpbios_init()
Message-ID: <202512210013.9DqxXceY-lkp@intel.com>
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
config: i386-randconfig-004-20251219 (https://download.01.org/0day-ci/archive/20251221/202512210013.9DqxXceY-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251221/202512210013.9DqxXceY-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202512210013.9DqxXceY-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/pnp/pnpbios/core.c:90:13: warning: variable 'value' set but not used [-Wunused-but-set-variable]
      90 |         int i = 0, value;
         |                    ^
>> drivers/pnp/pnpbios/core.c:542:3: error: expected expression
     542 |                 printk(KERN_ERR
         |                 ^
   include/linux/printk.h:512:26: note: expanded from macro 'printk'
     512 | #define printk(fmt, ...) printk_index_wrap(_printk, fmt, ##__VA_ARGS__)
         |                          ^
   include/linux/printk.h:482:3: note: expanded from macro 'printk_index_wrap'
     482 |         ({                                                              \
         |          ^
   1 warning and 1 error generated.


vim +542 drivers/pnp/pnpbios/core.c

^1da177e4c3f41 Linus Torvalds 2005-04-16  522  
^1da177e4c3f41 Linus Torvalds 2005-04-16  523  	/* scan the system for pnpbios support */
^1da177e4c3f41 Linus Torvalds 2005-04-16  524  	if (!pnpbios_probe_system())
^1da177e4c3f41 Linus Torvalds 2005-04-16  525  		return -ENODEV;
^1da177e4c3f41 Linus Torvalds 2005-04-16  526  
^1da177e4c3f41 Linus Torvalds 2005-04-16  527  	/* make preparations for bios calls */
^1da177e4c3f41 Linus Torvalds 2005-04-16  528  	pnpbios_calls_init(pnp_bios_install);
^1da177e4c3f41 Linus Torvalds 2005-04-16  529  
^1da177e4c3f41 Linus Torvalds 2005-04-16  530  	/* read the node info */
^1da177e4c3f41 Linus Torvalds 2005-04-16  531  	ret = pnp_bios_dev_node_info(&node_info);
^1da177e4c3f41 Linus Torvalds 2005-04-16  532  	if (ret) {
9dd78466c956ac Bjorn Helgaas  2007-07-26  533  		printk(KERN_ERR
9dd78466c956ac Bjorn Helgaas  2007-07-26  534  		       "PnPBIOS: Unable to get node info.  Aborting.\n");
^1da177e4c3f41 Linus Torvalds 2005-04-16  535  		return ret;
^1da177e4c3f41 Linus Torvalds 2005-04-16  536  	}
^1da177e4c3f41 Linus Torvalds 2005-04-16  537  
^1da177e4c3f41 Linus Torvalds 2005-04-16  538  	/* register with the pnp layer */
^1da177e4c3f41 Linus Torvalds 2005-04-16  539  	ret = pnp_register_protocol(&pnpbios_protocol);
^1da177e4c3f41 Linus Torvalds 2005-04-16  540  	if (ret) {
72a4fc1c3483e8 Haoxiang Li    2025-12-18  541  		put_device(&pnpbios_protocol.dev)
9dd78466c956ac Bjorn Helgaas  2007-07-26 @542  		printk(KERN_ERR
9dd78466c956ac Bjorn Helgaas  2007-07-26  543  		       "PnPBIOS: Unable to register driver.  Aborting.\n");
^1da177e4c3f41 Linus Torvalds 2005-04-16  544  		return ret;
^1da177e4c3f41 Linus Torvalds 2005-04-16  545  	}
^1da177e4c3f41 Linus Torvalds 2005-04-16  546  
^1da177e4c3f41 Linus Torvalds 2005-04-16  547  	/* start the proc interface */
^1da177e4c3f41 Linus Torvalds 2005-04-16  548  	ret = pnpbios_proc_init();
^1da177e4c3f41 Linus Torvalds 2005-04-16  549  	if (ret)
^1da177e4c3f41 Linus Torvalds 2005-04-16  550  		printk(KERN_ERR "PnPBIOS: Failed to create proc interface.\n");
^1da177e4c3f41 Linus Torvalds 2005-04-16  551  
^1da177e4c3f41 Linus Torvalds 2005-04-16  552  	/* scan for pnpbios devices */
^1da177e4c3f41 Linus Torvalds 2005-04-16  553  	build_devlist();
^1da177e4c3f41 Linus Torvalds 2005-04-16  554  
8f81dd149806bc Bjorn Helgaas  2007-05-08  555  	pnp_platform_devices = 1;
^1da177e4c3f41 Linus Torvalds 2005-04-16  556  	return 0;
^1da177e4c3f41 Linus Torvalds 2005-04-16  557  }
^1da177e4c3f41 Linus Torvalds 2005-04-16  558  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

