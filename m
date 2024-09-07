Return-Path: <linux-acpi+bounces-8197-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5560396FFD9
	for <lists+linux-acpi@lfdr.de>; Sat,  7 Sep 2024 05:31:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 057FF2846BC
	for <lists+linux-acpi@lfdr.de>; Sat,  7 Sep 2024 03:31:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 720DF1BC4E;
	Sat,  7 Sep 2024 03:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="F0gXMJnC"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97489DDA6;
	Sat,  7 Sep 2024 03:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725679879; cv=none; b=Qazw7hQZaPSnIPGVDUIGCza40y0UBvSsYJ+vdtNn4npfC9zRdELM14w/yjXp2Bzk9nkL/oStxrRnQ2CybqG1OYbe3cmz01wwAma5/LVmwXSHfjuWY1NhWDBKpXMHBztBZx7w/TIBC5Ej9dyjWbgbEUsNm+6nLJ0XnAovj9iS/IY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725679879; c=relaxed/simple;
	bh=hEGaHKODjVXh1NimtLs72WsXNCmMTIIkMZXiMa9laZQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W2FH1gihx7uRgJC1O8slzvCyKarug9/GB9E5PxVNe+Y/fvKfUUtjhRpDiig2SErgFA/sFoVnrLtTTzlixsETCpGBJhZS5TB8yGeEsK+JD8DwaY/3DnNXmZtNtViwc/gNCf2QPPDeQ7EumVTs0g+hVXXepK2HcuKrSFdaBwduBHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=F0gXMJnC; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725679878; x=1757215878;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=hEGaHKODjVXh1NimtLs72WsXNCmMTIIkMZXiMa9laZQ=;
  b=F0gXMJnCYWTK9yNA6KuquFjKDE9J+lNMQDu6TXEMyiw5UF2umIGD9BPE
   ++76+d1cFKicnXtZdNrJ2GotDyYIynWi6aSWvoJQQ5DaXBdjWDx6lacAf
   +0t0Ek9eb6PdXx8aBilbr/yj40nGuKl+LWwLRSIhFYrpTflKhsoa+p/tG
   tEn22NskjPGFlOTkUiQ5+N89d6cES5iqcxzT14gwuanhmMZ1ZZP6Vh+Mo
   i3ao9o2vStkm6F1Ugl5dKodep+d3Ae/vFcbFzWqInpKOrk8aEBQ02m9SO
   V8P30CK0KIJ15/jQ6AkPF2/H3kNOacnjmEXPdWTnhh4ZZDbupM+h8mI16
   w==;
X-CSE-ConnectionGUID: CzYRDQAmQAyA+bOpC0SPQw==
X-CSE-MsgGUID: Bug3weRfSFeB8wSDQQ7P6Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11187"; a="35115597"
X-IronPort-AV: E=Sophos;i="6.10,209,1719903600"; 
   d="scan'208";a="35115597"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2024 20:31:17 -0700
X-CSE-ConnectionGUID: YcjMdzw1SKGwwAHhN3ztFg==
X-CSE-MsgGUID: aDYgvrRLQsGKPCVLdQexNg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,209,1719903600"; 
   d="scan'208";a="70928207"
Received: from lkp-server01.sh.intel.com (HELO 9c6b1c7d3b50) ([10.239.97.150])
  by orviesa003.jf.intel.com with ESMTP; 06 Sep 2024 20:31:14 -0700
Received: from kbuild by 9c6b1c7d3b50 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1smmAJ-000C5q-0J;
	Sat, 07 Sep 2024 03:31:11 +0000
Date: Sat, 7 Sep 2024 11:30:21 +0800
From: kernel test robot <lkp@intel.com>
To: KobaK <kobak@nvidia.com>, Matt Ochs <mochs@nvidia.com>,
	James Morse <james.morse@arm.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>
Cc: oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH V3] acpi/prmt: find block with specific type
Message-ID: <202409071110.LWdX8txQ-lkp@intel.com>
References: <20240905124950.512973-1-kobak@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240905124950.512973-1-kobak@nvidia.com>

Hi KobaK,

kernel test robot noticed the following build warnings:

[auto build test WARNING on rafael-pm/linux-next]
[also build test WARNING on rafael-pm/bleeding-edge linus/master v6.11-rc6 next-20240906]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/KobaK/acpi-prmt-find-block-with-specific-type/20240905-205316
base:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git linux-next
patch link:    https://lore.kernel.org/r/20240905124950.512973-1-kobak%40nvidia.com
patch subject: [PATCH V3] acpi/prmt: find block with specific type
config: x86_64-defconfig (https://download.01.org/0day-ci/archive/20240907/202409071110.LWdX8txQ-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-12) 11.3.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240907/202409071110.LWdX8txQ-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202409071110.LWdX8txQ-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from include/linux/kernel.h:31,
                    from drivers/acpi/prmt.c:17:
   drivers/acpi/prmt.c: In function 'acpi_parse_prmt':
>> include/linux/kern_levels.h:5:25: warning: format '%d' expects argument of type 'int', but argument 2 has type 'u64' {aka 'long long unsigned int'} [-Wformat=]
       5 | #define KERN_SOH        "\001"          /* ASCII Start Of Header */
         |                         ^~~~~~
   include/linux/printk.h:437:25: note: in definition of macro 'printk_index_wrap'
     437 |                 _p_func(_fmt, ##__VA_ARGS__);                           \
         |                         ^~~~
   include/linux/printk.h:518:9: note: in expansion of macro 'printk'
     518 |         printk(KERN_WARNING pr_fmt(fmt), ##__VA_ARGS__)
         |         ^~~~~~
   include/linux/kern_levels.h:12:25: note: in expansion of macro 'KERN_SOH'
      12 | #define KERN_WARNING    KERN_SOH "4"    /* warning conditions */
         |                         ^~~~~~~~
   include/linux/printk.h:518:16: note: in expansion of macro 'KERN_WARNING'
     518 |         printk(KERN_WARNING pr_fmt(fmt), ##__VA_ARGS__)
         |                ^~~~~~~~~~~~
   drivers/acpi/prmt.c:161:25: note: in expansion of macro 'pr_warn'
     161 |                         pr_warn(
         |                         ^~~~~~~
>> include/linux/kern_levels.h:5:25: warning: format '%llx' expects a matching 'long long unsigned int' argument [-Wformat=]
       5 | #define KERN_SOH        "\001"          /* ASCII Start Of Header */
         |                         ^~~~~~
   include/linux/printk.h:437:25: note: in definition of macro 'printk_index_wrap'
     437 |                 _p_func(_fmt, ##__VA_ARGS__);                           \
         |                         ^~~~
   include/linux/printk.h:518:9: note: in expansion of macro 'printk'
     518 |         printk(KERN_WARNING pr_fmt(fmt), ##__VA_ARGS__)
         |         ^~~~~~
   include/linux/kern_levels.h:12:25: note: in expansion of macro 'KERN_SOH'
      12 | #define KERN_WARNING    KERN_SOH "4"    /* warning conditions */
         |                         ^~~~~~~~
   include/linux/printk.h:518:16: note: in expansion of macro 'KERN_WARNING'
     518 |         printk(KERN_WARNING pr_fmt(fmt), ##__VA_ARGS__)
         |                ^~~~~~~~~~~~
   drivers/acpi/prmt.c:161:25: note: in expansion of macro 'pr_warn'
     161 |                         pr_warn(
         |                         ^~~~~~~


vim +5 include/linux/kern_levels.h

314ba3520e513a Joe Perches 2012-07-30  4  
04d2c8c83d0e3a Joe Perches 2012-07-30 @5  #define KERN_SOH	"\001"		/* ASCII Start Of Header */
04d2c8c83d0e3a Joe Perches 2012-07-30  6  #define KERN_SOH_ASCII	'\001'
04d2c8c83d0e3a Joe Perches 2012-07-30  7  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

