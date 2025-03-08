Return-Path: <linux-acpi+bounces-11972-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3257A5795C
	for <lists+linux-acpi@lfdr.de>; Sat,  8 Mar 2025 09:56:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1BBC017025C
	for <lists+linux-acpi@lfdr.de>; Sat,  8 Mar 2025 08:56:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A33241AA78E;
	Sat,  8 Mar 2025 08:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SXR/I6AU"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 989F51A2632;
	Sat,  8 Mar 2025 08:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741424171; cv=none; b=vAfCXhce5LeXuzlC7dDJ/OGVvOAOBrznfxPCTP43r86kmlYmz831xnc5cISiraP9R6PpGVKoMkhs1k4fkistE1x62ZgEE/wns2IT2VmLIWj96rPiNxz5BoXIgx444dGl5zMQUrphEfmhgF3r2TemU1bpZ2R+E1pRbwa9qm+9KoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741424171; c=relaxed/simple;
	bh=4VgkYCgoYtsqJcDFHrQ8pnLz9wmKnHdijePp6ttEMMg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kiywBP3HZEsAp1w5z4qaDImAz0ezRNUg06KG8rS1KDbgf/b8Pv9pl6kaJhRV7VLHuyTvrQeJDtdAInW/nO3D4QwzQx2D3RLSqAt1JJU4u5Sn8PUmlNn35zoQ+EELkjWAGoCTlKYruQzTXMXV/crbks4m9wLXEjLYXe0UJ20n4iM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SXR/I6AU; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741424170; x=1772960170;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=4VgkYCgoYtsqJcDFHrQ8pnLz9wmKnHdijePp6ttEMMg=;
  b=SXR/I6AUsknINmcsyqQqUrYfU+GvZDDACFmYYt5Bm+RIPMg2EaEOCJIu
   I/j4+7iB6rVYDRYbJSJeeF2FS2jInuh9OR9mIwtAWILKBn5jvJmmzc902
   16whSqTnZJHs3QMBAUxIbmENw+d1Is2Rbt7fs94EzvqmKh2hKWGewD4TA
   nkfz8N8f+ue4osqHB+Loflpri7+eFu7P4aPVewyDtBNGgdjkXic7TiEul
   GQWDNWMtt6o4H7C0xXS+sKE9i0+88wR9Ow1/x6MJrZYmy5VeYqcq2hvT1
   5qRp/hs04Q7B9CytGjC7mKtdqs2p15tGMgjs7rRBw8WRHpaKyzgLWwqOx
   g==;
X-CSE-ConnectionGUID: dSK93mgKTMK+y1/sXuItKQ==
X-CSE-MsgGUID: C59SCixJSOi55E6YgCfdIA==
X-IronPort-AV: E=McAfee;i="6700,10204,11366"; a="46395427"
X-IronPort-AV: E=Sophos;i="6.14,231,1736841600"; 
   d="scan'208";a="46395427"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2025 00:56:09 -0800
X-CSE-ConnectionGUID: prOlML3uTkWwaENRbOkvzQ==
X-CSE-MsgGUID: 4N6N18olTjev+4xijpH3ag==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="120434605"
Received: from lkp-server02.sh.intel.com (HELO a4747d147074) ([10.239.97.151])
  by orviesa008.jf.intel.com with ESMTP; 08 Mar 2025 00:56:04 -0800
Received: from kbuild by a4747d147074 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tqpyU-0001jE-0K;
	Sat, 08 Mar 2025 08:56:02 +0000
Date: Sat, 8 Mar 2025 16:55:04 +0800
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
Subject: Re: [PATCH v4 3/9] ACPI: APEI: EINJ: Fix kernel test robot sparse
 warning
Message-ID: <202503081600.JxR875hh-lkp@intel.com>
References: <20250306234810.75511-4-zaidal@os.amperecomputing.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250306234810.75511-4-zaidal@os.amperecomputing.com>

Hi Zaid,

kernel test robot noticed the following build warnings:

[auto build test WARNING on rafael-pm/linux-next]
[also build test WARNING on rafael-pm/bleeding-edge linus/master v6.14-rc5 next-20250307]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Zaid-Alali/ACPICA-Update-values-to-hex-to-follow-ACPI-specs/20250307-075155
base:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git linux-next
patch link:    https://lore.kernel.org/r/20250306234810.75511-4-zaidal%40os.amperecomputing.com
patch subject: [PATCH v4 3/9] ACPI: APEI: EINJ: Fix kernel test robot sparse warning
config: i386-randconfig-063-20250308 (https://download.01.org/0day-ci/archive/20250308/202503081600.JxR875hh-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250308/202503081600.JxR875hh-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202503081600.JxR875hh-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/acpi/apei/einj-core.c:265:32: sparse: sparse: incorrect type in return expression (different address spaces) @@     expected void * @@     got void [noderef] __iomem *[assigned] p @@
   drivers/acpi/apei/einj-core.c:265:32: sparse:     expected void *
   drivers/acpi/apei/einj-core.c:265:32: sparse:     got void [noderef] __iomem *[assigned] p
   drivers/acpi/apei/einj-core.c:280:24: sparse: sparse: incorrect type in return expression (different address spaces) @@     expected void * @@     got void [noderef] __iomem *[assigned] p @@
   drivers/acpi/apei/einj-core.c:280:24: sparse:     expected void *
   drivers/acpi/apei/einj-core.c:280:24: sparse:     got void [noderef] __iomem *[assigned] p
>> drivers/acpi/apei/einj-core.c:824:20: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __iomem *static [toplevel] einj_param @@     got void * @@
   drivers/acpi/apei/einj-core.c:824:20: sparse:     expected void [noderef] __iomem *static [toplevel] einj_param
   drivers/acpi/apei/einj-core.c:824:20: sparse:     got void *

vim +265 drivers/acpi/apei/einj-core.c

   235	
   236	static void *einj_get_parameter_address(void)
   237	{
   238		int i;
   239		u64 pa_v4 = 0, pa_v5 = 0;
   240		struct acpi_whea_header *entry;
   241	
   242		entry = EINJ_TAB_ENTRY(einj_tab);
   243		for (i = 0; i < einj_tab->entries; i++) {
   244			if (entry->action == ACPI_EINJ_SET_ERROR_TYPE &&
   245			    entry->instruction == ACPI_EINJ_WRITE_REGISTER &&
   246			    entry->register_region.space_id ==
   247			    ACPI_ADR_SPACE_SYSTEM_MEMORY)
   248				pa_v4 = get_unaligned(&entry->register_region.address);
   249			if (entry->action == ACPI_EINJ_SET_ERROR_TYPE_WITH_ADDRESS &&
   250			    entry->instruction == ACPI_EINJ_WRITE_REGISTER &&
   251			    entry->register_region.space_id ==
   252			    ACPI_ADR_SPACE_SYSTEM_MEMORY)
   253				pa_v5 = get_unaligned(&entry->register_region.address);
   254			entry++;
   255		}
   256		if (pa_v5) {
   257			struct set_error_type_with_address v5param;
   258			void __iomem *p;
   259	
   260			p = acpi_os_map_iomem(pa_v5, sizeof(v5param));
   261			if (p) {
   262				memcpy_fromio(&v5param, p, sizeof(v5param));
   263				acpi5 = 1;
   264				check_vendor_extension(pa_v5, &v5param);
 > 265				return p;
   266			}
   267		}
   268		if (param_extension && pa_v4) {
   269			struct einj_parameter v4param;
   270			void __iomem *p;
   271	
   272			p = acpi_os_map_iomem(pa_v4, sizeof(v4param));
   273			if (!p)
   274				return NULL;
   275			memcpy_fromio(&v4param, p, sizeof(v4param));
   276			if (v4param.reserved1 || v4param.reserved2) {
   277				acpi_os_unmap_iomem(p, sizeof(v4param));
   278				return NULL;
   279			}
   280			return p;
   281		}
   282	
   283		return NULL;
   284	}
   285	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

