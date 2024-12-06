Return-Path: <linux-acpi+bounces-9983-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D45B79E649B
	for <lists+linux-acpi@lfdr.de>; Fri,  6 Dec 2024 04:12:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C37D01885635
	for <lists+linux-acpi@lfdr.de>; Fri,  6 Dec 2024 03:11:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DA9618E361;
	Fri,  6 Dec 2024 03:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GQOm8d8v"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5E2618FC81;
	Fri,  6 Dec 2024 03:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733454704; cv=none; b=L45yWADfSOmPD8BPJrCSygNg3P+ZTEwQanAssBLe7YDbN5eovRQehSS5Tvxrt6ne9MJRxiUpj0xRCTe2zFi5V9aVkd6oRCfrrKG8MYsMnvFCK18wPRS9QBfn6H3YnB/u7rginGWVyd0vz9Zhk7/CyJZ2pA79MITnRuP41qqcmQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733454704; c=relaxed/simple;
	bh=KEXoYBWFuGfczmXXqwmh2W0p479mENK9Jw6E6ADQazY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jtthFv7MVeMYz7oERDESNa4ZUKSDuJCegsW3OI3olNpJmyjbQG37xUHsYaFt1jxokpdkTloSfOgjFV/Fou5f8eXQwDPRcO71D4cvsBL8yHYfEacpdaEBq89DweLVFwn03Ph6GxwaezSPCIfMnLGlLECexWh9oSks1PqvthmftlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GQOm8d8v; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733454701; x=1764990701;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=KEXoYBWFuGfczmXXqwmh2W0p479mENK9Jw6E6ADQazY=;
  b=GQOm8d8vas4+fMS0gPZwz6Dj7RZuge//WfvyiT+tCSyR6m19H7+KB21i
   GGjsmW0DR32l8wNhrvjexryOx8Eef4+sLo/AHaVuGoQyr+3jFUarxXMll
   Q+1GoY/rHT6R/sjtbPvMUfQQ2xI76XgYV0p/usvETN5MPu/ZrzKKxv97I
   CeeHB4FxlYK42lYlhATEURsfQNFKxe5AmIcZExqnajPosURParNFIfAog
   dvNpYQNAhdI/71vAKYfG7lBxWJm3/hWlqbjXC4VpaNoqoUUH0qmHnDVfo
   54KdlW9VxPhxTfb53U4wWqk1+zz6uxYvDaNYhfBKAEFdRAuCbN9TtJs+Z
   w==;
X-CSE-ConnectionGUID: dDKUWSpeR4Wj8mC+bfzu+Q==
X-CSE-MsgGUID: 2hKjMf7cSACKr8Z+DdewKA==
X-IronPort-AV: E=McAfee;i="6700,10204,11277"; a="33945831"
X-IronPort-AV: E=Sophos;i="6.12,212,1728975600"; 
   d="scan'208";a="33945831"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2024 19:11:41 -0800
X-CSE-ConnectionGUID: sQ+gxZrTSEio+Y9CgWHQCw==
X-CSE-MsgGUID: lgtGaKRZQya0y25WG6uOXQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,212,1728975600"; 
   d="scan'208";a="125118662"
Received: from lkp-server01.sh.intel.com (HELO 82a3f569d0cb) ([10.239.97.150])
  by orviesa002.jf.intel.com with ESMTP; 05 Dec 2024 19:11:36 -0800
Received: from kbuild by 82a3f569d0cb with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tJOkf-0000eX-1W;
	Fri, 06 Dec 2024 03:11:33 +0000
Date: Fri, 6 Dec 2024 11:10:51 +0800
From: kernel test robot <lkp@intel.com>
To: Zaid Alali <zaidal@os.amperecomputing.com>, rafael@kernel.org,
	lenb@kernel.org, james.morse@arm.com, tony.luck@intel.com,
	bp@alien8.de, robert.moore@intel.com, dan.j.williams@intel.com,
	Jonathan.Cameron@huawei.com, Benjamin.Cheatham@amd.com,
	Avadhut.Naik@amd.com, viro@zeniv.linux.org.uk, arnd@arndb.de,
	ira.weiny@intel.com, dave.jiang@intel.com,
	sthanneeru.opensrc@micron.com, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org, acpica-devel@lists.linux.dev
Cc: oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH v2 5/9] ACPI: APEI: EINJ: Enable the discovery of EINJv2
 capabilities
Message-ID: <202412061056.fk2xNw7W-lkp@intel.com>
References: <20241205211854.43215-6-zaidal@os.amperecomputing.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241205211854.43215-6-zaidal@os.amperecomputing.com>

Hi Zaid,

kernel test robot noticed the following build warnings:

[auto build test WARNING on rafael-pm/linux-next]
[also build test WARNING on rafael-pm/bleeding-edge linus/master v6.13-rc1 next-20241205]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Zaid-Alali/ACPICA-Update-values-to-hex-to-follow-ACPI-specs/20241206-052420
base:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git linux-next
patch link:    https://lore.kernel.org/r/20241205211854.43215-6-zaidal%40os.amperecomputing.com
patch subject: [PATCH v2 5/9] ACPI: APEI: EINJ: Enable the discovery of EINJv2 capabilities
config: arm64-randconfig-002-20241206 (https://download.01.org/0day-ci/archive/20241206/202412061056.fk2xNw7W-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241206/202412061056.fk2xNw7W-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202412061056.fk2xNw7W-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/acpi/apei/einj-core.c: In function 'error_type_set':
>> drivers/acpi/apei/einj-core.c:728:35: warning: argument to 'sizeof' in 'memset' call is the same expression as the destination; did you mean to provide an explicit length? [-Wsizeof-pointer-memaccess]
     728 |         memset(einj_buf, 0, sizeof(einj_buf));
         |                                   ^


vim +728 drivers/acpi/apei/einj-core.c

   721	
   722	static ssize_t error_type_set(struct file *file, const char __user *buf,
   723					size_t count, loff_t *ppos)
   724	{
   725		int rc;
   726		u64 val;
   727	
 > 728		memset(einj_buf, 0, sizeof(einj_buf));
   729		if (copy_from_user(einj_buf, buf, count))
   730			return -EFAULT;
   731	
   732		if (strncmp(einj_buf, "V2_", 3) == 0) {
   733			if (!sscanf(einj_buf, "V2_%llx", &val))
   734				return -EINVAL;
   735		} else
   736			if (!sscanf(einj_buf, "%llx", &val))
   737				return -EINVAL;
   738	
   739		rc = einj_validate_error_type(val);
   740		if (rc)
   741			return rc;
   742	
   743		error_type = val;
   744	
   745		return count;
   746	}
   747	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

