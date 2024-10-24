Return-Path: <linux-acpi+bounces-8948-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 073129ADF41
	for <lists+linux-acpi@lfdr.de>; Thu, 24 Oct 2024 10:34:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B4C81284504
	for <lists+linux-acpi@lfdr.de>; Thu, 24 Oct 2024 08:34:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3925A1B0F16;
	Thu, 24 Oct 2024 08:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="L9IvI8YI"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74817189BB3;
	Thu, 24 Oct 2024 08:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729758831; cv=none; b=FyVYtQ/Aoc6DDYWK77I9AJBgbfXYBhv0Uv7YKYRU+RwFWuJloSLAzS9XFS3CmLO4HvxErd2GVjfcL6FBldf5FNjCtJxO+TeAIMcRutyWczrAFSGvP/JVcqfQRgh9YAWcHMTXT7SUMsfVmAoQEOseqBbxMRMEY3pSdpNuBDYgwDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729758831; c=relaxed/simple;
	bh=440a4UowBscCj5x5jCi7O4w9UQNiUsfEUJpOX9n3XQI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XEyyfdykVXexZH0sh4DT1T4zJBKrFjPJfG0Cpzg5dTTI7SZCQgjs1LJ3AKbXi3f4i41czUcMFzj7XIamBQUo4mDrIsh7SIrp+ti0qGdFC9OLi6TMHOaWSWhrDTJzGrdMayyDJUHl+ZBqmynTjUMaCdYmJs8I5SV3UY8CDdfTCHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=L9IvI8YI; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729758828; x=1761294828;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=440a4UowBscCj5x5jCi7O4w9UQNiUsfEUJpOX9n3XQI=;
  b=L9IvI8YIk3VVoue076fVFQtURhv60QGp2mHmaRF2MlHWgcRqMG8GGPHy
   wBB2P6yVVjsZCk9iwbLQ+Xq1dbmw7gYTQhANOe/7s5pHQAAm6YJ0y1A2g
   xLdFZPAe5E9m8NYFXLnem8gplMho7qHIP+UsRqX27s1eqnyjecDW4733q
   UJZ+r03ThEDjFcrwqhZS+3sOx8k3XdRrL0+/DfrYnvnrR9xJPkXu0g+pG
   ZK13mdPyo9QVIr4kW+PPPeI7VymLC/dIW+vBRcywLoX7vSISgzZjGLh2s
   VnFl6qR661+UkzaeivX+2SqC/crRTPSSiCDQOS2b0WChxniTH6p5W9Jkl
   Q==;
X-CSE-ConnectionGUID: zW+nLrvHT6mIzP+ezejPTA==
X-CSE-MsgGUID: FDWESXfVQHWUFxPAE0/BdA==
X-IronPort-AV: E=McAfee;i="6700,10204,11234"; a="40768682"
X-IronPort-AV: E=Sophos;i="6.11,228,1725346800"; 
   d="scan'208";a="40768682"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2024 01:33:47 -0700
X-CSE-ConnectionGUID: DRmIii6WQkOK83fLyDLxhQ==
X-CSE-MsgGUID: hI6GWyVHQXytlid2aGlJeQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,228,1725346800"; 
   d="scan'208";a="85075578"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by fmviesa005.fm.intel.com with ESMTP; 24 Oct 2024 01:33:43 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t3tHo-000WA4-0X;
	Thu, 24 Oct 2024 08:33:40 +0000
Date: Thu, 24 Oct 2024 16:33:04 +0800
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
Subject: Re: [PATCH 7/8] ACPI: APEI: EINJ: Enable EINJv2 error injections
Message-ID: <202410241620.oApALow5-lkp@intel.com>
References: <20241022213429.1561784-8-zaidal@os.amperecomputing.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241022213429.1561784-8-zaidal@os.amperecomputing.com>

Hi Zaid,

kernel test robot noticed the following build warnings:

[auto build test WARNING on rafael-pm/linux-next]
[also build test WARNING on rafael-pm/bleeding-edge linus/master v6.12-rc4 next-20241024]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Zaid-Alali/ACPICA-Update-values-to-hex-to-follow-ACPI-specs/20241023-054034
base:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git linux-next
patch link:    https://lore.kernel.org/r/20241022213429.1561784-8-zaidal%40os.amperecomputing.com
patch subject: [PATCH 7/8] ACPI: APEI: EINJ: Enable EINJv2 error injections
config: x86_64-randconfig-121-20241024 (https://download.01.org/0day-ci/archive/20241024/202410241620.oApALow5-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241024/202410241620.oApALow5-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202410241620.oApALow5-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
   drivers/acpi/apei/einj-core.c:261:11: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct vendor_error_type_extension *v @@     got void [noderef] __iomem * @@
   drivers/acpi/apei/einj-core.c:261:11: sparse:     expected struct vendor_error_type_extension *v
   drivers/acpi/apei/einj-core.c:261:11: sparse:     got void [noderef] __iomem *
   drivers/acpi/apei/einj-core.c:270:29: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void [noderef] __iomem *virt @@     got struct vendor_error_type_extension *v @@
   drivers/acpi/apei/einj-core.c:270:29: sparse:     expected void [noderef] __iomem *virt
   drivers/acpi/apei/einj-core.c:270:29: sparse:     got struct vendor_error_type_extension *v
   drivers/acpi/apei/einj-core.c:296:25: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct set_error_type_with_address *v5param @@     got void [noderef] __iomem * @@
   drivers/acpi/apei/einj-core.c:296:25: sparse:     expected struct set_error_type_with_address *v5param
   drivers/acpi/apei/einj-core.c:296:25: sparse:     got void [noderef] __iomem *
>> drivers/acpi/apei/einj-core.c:306:53: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void [noderef] __iomem *virt @@     got struct set_error_type_with_address *v5param @@
   drivers/acpi/apei/einj-core.c:306:53: sparse:     expected void [noderef] __iomem *virt
   drivers/acpi/apei/einj-core.c:306:53: sparse:     got struct set_error_type_with_address *v5param
   drivers/acpi/apei/einj-core.c:307:41: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct set_error_type_with_address *v5param @@     got void [noderef] __iomem * @@
   drivers/acpi/apei/einj-core.c:307:41: sparse:     expected struct set_error_type_with_address *v5param
   drivers/acpi/apei/einj-core.c:307:41: sparse:     got void [noderef] __iomem *
   drivers/acpi/apei/einj-core.c:316:25: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct einj_parameter *v4param @@     got void [noderef] __iomem * @@
   drivers/acpi/apei/einj-core.c:316:25: sparse:     expected struct einj_parameter *v4param
   drivers/acpi/apei/einj-core.c:316:25: sparse:     got void [noderef] __iomem *
   drivers/acpi/apei/einj-core.c:320:45: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void [noderef] __iomem *virt @@     got struct einj_parameter *v4param @@
   drivers/acpi/apei/einj-core.c:320:45: sparse:     expected void [noderef] __iomem *virt
   drivers/acpi/apei/einj-core.c:320:45: sparse:     got struct einj_parameter *v4param
   drivers/acpi/apei/einj-core.c:387:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct acpi_einj_trigger *trigger_tab @@     got void [noderef] __iomem * @@
   drivers/acpi/apei/einj-core.c:387:21: sparse:     expected struct acpi_einj_trigger *trigger_tab
   drivers/acpi/apei/einj-core.c:387:21: sparse:     got void [noderef] __iomem *
   drivers/acpi/apei/einj-core.c:413:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got struct acpi_einj_trigger *trigger_tab @@
   drivers/acpi/apei/einj-core.c:413:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/acpi/apei/einj-core.c:413:17: sparse:     got struct acpi_einj_trigger *trigger_tab
   drivers/acpi/apei/einj-core.c:414:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct acpi_einj_trigger *trigger_tab @@     got void [noderef] __iomem * @@
   drivers/acpi/apei/einj-core.c:414:21: sparse:     expected struct acpi_einj_trigger *trigger_tab
   drivers/acpi/apei/einj-core.c:414:21: sparse:     got void [noderef] __iomem *
   drivers/acpi/apei/einj-core.c:477:25: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got struct acpi_einj_trigger *trigger_tab @@
   drivers/acpi/apei/einj-core.c:477:25: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/acpi/apei/einj-core.c:477:25: sparse:     got struct acpi_einj_trigger *trigger_tab
   drivers/acpi/apei/einj-core.c:983:37: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void [noderef] __iomem *virt @@     got void *static [assigned] [toplevel] einj_param @@
   drivers/acpi/apei/einj-core.c:983:37: sparse:     expected void [noderef] __iomem *virt
   drivers/acpi/apei/einj-core.c:983:37: sparse:     got void *static [assigned] [toplevel] einj_param

vim +306 drivers/acpi/apei/einj-core.c

   272	
   273	static void *einj_get_parameter_address(void)
   274	{
   275		int i;
   276		u64 pa_v4 = 0, pa_v5 = 0;
   277		struct acpi_whea_header *entry;
   278	
   279		entry = EINJ_TAB_ENTRY(einj_tab);
   280		for (i = 0; i < einj_tab->entries; i++) {
   281			if (entry->action == ACPI_EINJ_SET_ERROR_TYPE &&
   282			    entry->instruction == ACPI_EINJ_WRITE_REGISTER &&
   283			    entry->register_region.space_id ==
   284			    ACPI_ADR_SPACE_SYSTEM_MEMORY)
   285				pa_v4 = get_unaligned(&entry->register_region.address);
   286			if (entry->action == ACPI_EINJ_SET_ERROR_TYPE_WITH_ADDRESS &&
   287			    entry->instruction == ACPI_EINJ_WRITE_REGISTER &&
   288			    entry->register_region.space_id ==
   289			    ACPI_ADR_SPACE_SYSTEM_MEMORY)
   290				pa_v5 = get_unaligned(&entry->register_region.address);
   291			entry++;
   292		}
   293		if (pa_v5) {
   294			struct set_error_type_with_address *v5param;
   295	
   296			v5param = acpi_os_map_iomem(pa_v5, sizeof(*v5param));
   297			if (v5param) {
   298				int offset, len;
   299	
   300				acpi5 = 1;
   301				check_vendor_extension(pa_v5, v5param);
   302				if (available_error_type & ACPI65_EINJV2_SUPP) {
   303					len = v5param->einjv2_struct.length;
   304					offset = offsetof(struct einjv2_extension_struct, component_arr);
   305					nr_components = (len - offset) / 32;
 > 306					acpi_os_unmap_iomem(v5param, sizeof(*v5param));
   307					v5param = acpi_os_map_iomem(pa_v5, sizeof(*v5param) + (
   308						(nr_components) * sizeof(struct syndrome_array)));
   309				}
   310				return v5param;
   311			}
   312		}
   313		if (param_extension && pa_v4) {
   314			struct einj_parameter *v4param;
   315	
   316			v4param = acpi_os_map_iomem(pa_v4, sizeof(*v4param));
   317			if (!v4param)
   318				return NULL;
   319			if (v4param->reserved1 || v4param->reserved2) {
   320				acpi_os_unmap_iomem(v4param, sizeof(*v4param));
   321				return NULL;
   322			}
   323			return v4param;
   324		}
   325	
   326		return NULL;
   327	}
   328	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

