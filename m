Return-Path: <linux-acpi+bounces-10011-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4D1F9E7A53
	for <lists+linux-acpi@lfdr.de>; Fri,  6 Dec 2024 22:03:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 604D2284B2A
	for <lists+linux-acpi@lfdr.de>; Fri,  6 Dec 2024 21:03:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 768C01F3D27;
	Fri,  6 Dec 2024 21:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nnis4g0A"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A90BD1C3C18;
	Fri,  6 Dec 2024 21:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733519006; cv=none; b=d/PpMLT3NwD0zYTim4B8uffJs0JCw4WKRn/6k2IwEl1xqEb9MKBKGaLrorDf5wuS5eVn9G1mJEpaarbZ93NmyzO+ygpWWcqoI9z8HY3jTZwZJ2LSGAOvqk9AkY48QDwxxDGXpcd7oh3tekOXdoxexcJEj2pyqEun/tLmv6Wfw8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733519006; c=relaxed/simple;
	bh=rjYe+1mTHx2nCmLqd3cmIWfysX4E1LYaiuujOJeiI6E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fwj8Oc+008r5UauOByV2vTtjzkyzcFW4QngkkCGEYjrFTCSSkQ2A6pTOyNeABvB4GVQIbktCu27z9PyosnciTI9F72Ma2/Cd1QMOr+2/8CWSlwdjvTzgaLs/phWCjw0VFcVkeOJrXPIfS5JGirQ7lf3F0MsMkSnf9Lhft7rD7BM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nnis4g0A; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733519005; x=1765055005;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=rjYe+1mTHx2nCmLqd3cmIWfysX4E1LYaiuujOJeiI6E=;
  b=nnis4g0Awp80RXkdPPH8wgQN1FbpDsoGxknMkf72MLK3FcBmd6JcQrnk
   T2WslOwP/V7aw2hW0Hh0gjYhyh4QEzlzK9/40s5rOzCrGs7K03A/MjS4I
   taVrmqOGDuFAEU6+gY5LrAY+TWYZzPiPhY0BgXxvSuQ9mud5AvnIl2eLx
   Jj4M23BKy9/yuCMo1Xget2Vrz27zUvzYpr3+9D2jZ6xfmHZupThAfaDj+
   gphWN2Avn08aGuqdzRKKPi5sxMnQyreAu7KjDB/ucypYHdoTqComdEKOC
   Qc8rK84NP5ks4cgf0bck6AnlhJ/0rbBm6LoImxUViModFONm2mO9qExPM
   A==;
X-CSE-ConnectionGUID: c0cxSqSyT5SRllVGlujyMw==
X-CSE-MsgGUID: D2Kt/jQFTuuPbDp5XB3h+Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11278"; a="33233818"
X-IronPort-AV: E=Sophos;i="6.12,214,1728975600"; 
   d="scan'208";a="33233818"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2024 13:03:24 -0800
X-CSE-ConnectionGUID: P11hVv+GRmOT2rr69RHaUg==
X-CSE-MsgGUID: Rl6xV7T1RHG+DT2T+/YfCA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,214,1728975600"; 
   d="scan'208";a="125344723"
Received: from lkp-server01.sh.intel.com (HELO 82a3f569d0cb) ([10.239.97.150])
  by orviesa002.jf.intel.com with ESMTP; 06 Dec 2024 13:03:20 -0800
Received: from kbuild by 82a3f569d0cb with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tJfTo-0002Fx-2P;
	Fri, 06 Dec 2024 21:03:16 +0000
Date: Sat, 7 Dec 2024 05:02:20 +0800
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
Message-ID: <202412070418.9pHXTR91-lkp@intel.com>
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
[also build test WARNING on rafael-pm/bleeding-edge linus/master v6.13-rc1 next-20241206]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Zaid-Alali/ACPICA-Update-values-to-hex-to-follow-ACPI-specs/20241206-052420
base:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git linux-next
patch link:    https://lore.kernel.org/r/20241205211854.43215-6-zaidal%40os.amperecomputing.com
patch subject: [PATCH v2 5/9] ACPI: APEI: EINJ: Enable the discovery of EINJv2 capabilities
config: x86_64-randconfig-101-20241206 (https://download.01.org/0day-ci/archive/20241207/202412070418.9pHXTR91-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202412070418.9pHXTR91-lkp@intel.com/

cocci warnings: (new ones prefixed by >>)
>> drivers/acpi/apei/einj-core.c:728:21-27: ERROR: application of sizeof to pointer

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

