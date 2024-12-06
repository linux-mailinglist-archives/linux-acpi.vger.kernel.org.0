Return-Path: <linux-acpi+bounces-10008-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB1049E668A
	for <lists+linux-acpi@lfdr.de>; Fri,  6 Dec 2024 05:55:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 82C9128243C
	for <lists+linux-acpi@lfdr.de>; Fri,  6 Dec 2024 04:55:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB95D193063;
	Fri,  6 Dec 2024 04:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VJrw1aoU"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13ADC28FD;
	Fri,  6 Dec 2024 04:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733460952; cv=none; b=Mh+9smrvL8LScJ1Y8q6hyj1JCx2oYkTEcmTcKZtOs3xDRPOm4mbOvPbAeZXaIjjy1iifvZL0yx94hUU3MENW7jlxj3MKP9ZgZDJE/+D7QuoRKPf9AD1lmN9gnF9XEhcy+oKe0vfpZCRbCmvFTTXoyLtdDTk+vGsX/dDPzfbpwcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733460952; c=relaxed/simple;
	bh=AmLWblXxxrtbKW+nU/XBqH+Po3pZ7cYVz5x5QTefPso=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V8TaVc/bD7iXSpTtAy7gUll6LsqP7AVZqOahlLsEoiupeiCOkDIxZjB1GZAKYiT06+Z7xS0Q9TF4848zsLGhtjJVFJzF6SCYFlp/j1N5G/pzHX7/Ckt7AAaLd9KmcXlnYeKiqAX8FjRYjLeo7vVJxZ1Nqo8faH/w+/NnlhRalAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VJrw1aoU; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733460950; x=1764996950;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=AmLWblXxxrtbKW+nU/XBqH+Po3pZ7cYVz5x5QTefPso=;
  b=VJrw1aoUUN339RAP8sB+TXs+QrpadzoTFUH0yPngW0zN/SFfhjACZ1Lc
   JqUnjDaz0Q1wzGy8Ist+RQ9g0rDrp7ttcAjuwf93ecImeGuJQQt2IRnKX
   gzWBxJAwaFqyjphKTJJiNZfcgH6Iwx4a9AY1PyBJp42Rfsv9gLE+/ETjR
   REJNx/uQd+Z3d5ctLmBT6NpuFHqTX8cRQ0A0lLH3J9gghJQSpaQNJTUT0
   wIvqcRpxnDeyBl2+eeVxpjX48mT4Rn7Ph3OPyCGL63uS60w+fYRNOUL0u
   soLA29h8hCRiMCmYHmHFPY0bSe3v7EXp/mr8NGubockmdsZrTe/2hdGyA
   A==;
X-CSE-ConnectionGUID: QIoprJMoQN+a+bKWaQRKwg==
X-CSE-MsgGUID: Y5LHS6RKRtGqXdA9ECy8rA==
X-IronPort-AV: E=McAfee;i="6700,10204,11277"; a="56296859"
X-IronPort-AV: E=Sophos;i="6.12,212,1728975600"; 
   d="scan'208";a="56296859"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2024 20:55:50 -0800
X-CSE-ConnectionGUID: V0ByfAr8Rbm8yd//5J+6Rg==
X-CSE-MsgGUID: qMY21bOjTaSKQohmsjCShw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,212,1728975600"; 
   d="scan'208";a="125205266"
Received: from lkp-server01.sh.intel.com (HELO 82a3f569d0cb) ([10.239.97.150])
  by fmviesa001.fm.intel.com with ESMTP; 05 Dec 2024 20:55:44 -0800
Received: from kbuild by 82a3f569d0cb with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tJQNS-0000i7-0t;
	Fri, 06 Dec 2024 04:55:42 +0000
Date: Fri, 6 Dec 2024 12:54:51 +0800
From: kernel test robot <lkp@intel.com>
To: Zaid Alali <zaidal@os.amperecomputing.com>, rafael@kernel.org,
	lenb@kernel.org, james.morse@arm.com, tony.luck@intel.com,
	bp@alien8.de, robert.moore@intel.com, dan.j.williams@intel.com,
	Jonathan.Cameron@huawei.com, Benjamin.Cheatham@amd.com,
	Avadhut.Naik@amd.com, viro@zeniv.linux.org.uk, arnd@arndb.de,
	ira.weiny@intel.com, dave.jiang@intel.com,
	sthanneeru.opensrc@micron.com, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org, acpica-devel@lists.linux.dev
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH v2 5/9] ACPI: APEI: EINJ: Enable the discovery of EINJv2
 capabilities
Message-ID: <202412061210.H6R0JvCL-lkp@intel.com>
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
config: i386-buildonly-randconfig-005-20241206 (https://download.01.org/0day-ci/archive/20241206/202412061210.H6R0JvCL-lkp@intel.com/config)
compiler: clang version 19.1.3 (https://github.com/llvm/llvm-project ab51eccf88f5321e7c60591c5546b254b6afab99)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241206/202412061210.H6R0JvCL-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202412061210.H6R0JvCL-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from drivers/acpi/apei/einj-core.c:23:
   In file included from include/linux/mm.h:2223:
   include/linux/vmstat.h:518:36: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
     518 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
         |                               ~~~~~~~~~~~ ^ ~~~
   drivers/acpi/apei/einj-core.c:342:6: warning: variable 'p' is used uninitialized whenever 'if' condition is true [-Wsometimes-uninitialized]
     342 |         if (!r) {
         |             ^~
   drivers/acpi/apei/einj-core.c:440:6: note: uninitialized use occurs here
     440 |         if (p)
         |             ^
   drivers/acpi/apei/einj-core.c:342:2: note: remove the 'if' if its condition is always false
     342 |         if (!r) {
         |         ^~~~~~~~~
     343 |                 pr_err("Can not request [mem %#010llx-%#010llx] for Trigger table\n",
         |                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     344 |                        (unsigned long long)trigger_paddr,
         |                        ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     345 |                        (unsigned long long)trigger_paddr +
         |                        ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     346 |                             sizeof(*trigger_tab) - 1);
         |                             ~~~~~~~~~~~~~~~~~~~~~~~~~~
     347 |                 goto out;
         |                 ~~~~~~~~~
     348 |         }
         |         ~
   drivers/acpi/apei/einj-core.c:338:17: note: initialize the variable 'p' to silence this warning
     338 |         void __iomem *p;
         |                        ^
         |                         = NULL
>> drivers/acpi/apei/einj-core.c:728:29: warning: 'memset' call operates on objects of type 'char' while the size is based on a different type 'char *' [-Wsizeof-pointer-memaccess]
     728 |         memset(einj_buf, 0, sizeof(einj_buf));
         |                ~~~~~~~~            ^~~~~~~~
   drivers/acpi/apei/einj-core.c:728:29: note: did you mean to provide an explicit length?
     728 |         memset(einj_buf, 0, sizeof(einj_buf));
         |                                    ^~~~~~~~
   3 warnings generated.


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

