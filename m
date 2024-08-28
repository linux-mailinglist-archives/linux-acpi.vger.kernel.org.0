Return-Path: <linux-acpi+bounces-7915-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 468A1961E2A
	for <lists+linux-acpi@lfdr.de>; Wed, 28 Aug 2024 07:23:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 793BC1C22B8A
	for <lists+linux-acpi@lfdr.de>; Wed, 28 Aug 2024 05:23:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C25D14A09C;
	Wed, 28 Aug 2024 05:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="l3Nx994D"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36CC913D899;
	Wed, 28 Aug 2024 05:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724822625; cv=none; b=g1sv9Gg71KozUF6bMFUR2aH+OP1CVqBbAoRnoivTfsndTZTKinamX/zQa7JLO9SJTCqHC14vHMkVHnIQ2XS20j//03trNoQ5ZRAKt+UgzYDdx0B3aAK6OXLBeCDBcRXlInGudf7yEnkyzpOYZisDUIofOShoViMKC0aGq8oHxwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724822625; c=relaxed/simple;
	bh=C04IUcgAQYXb4PaQAsKdtLf+ko61JC4L+wwKID87HDE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sSVGEezrkG1p4K6s9ptu36OLRXMMzw8mBH9Krjy1Dxl6cYV9gi7uuiE7LWapaeZXUfkS04qyQ4fNW+AWx6JyBpA/QcVLdnd409PB+QwJ+H5en5eMt1bX3iDEvkYOaMcli9QGR0cBvOtqCX7q1euaj8kUCy9IMJ7AcYypk5MwXEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=l3Nx994D; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724822622; x=1756358622;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=C04IUcgAQYXb4PaQAsKdtLf+ko61JC4L+wwKID87HDE=;
  b=l3Nx994DUV9f2KUJ+54Y1cKWk7SeZrPfYGeaHXEeal+LEvrZ6m5K5G9T
   ELoh+sPIWwXJpDhGLieE8S9zKFWg9opqQDAhGqAhDilrcm+YKKLSvDy65
   QhUqXzMDOQh2Ik+C7SlHzGseYmmH+Rql4zIc1tpkUSG9fx8HOh60Hsu8P
   NvPN3ht+KPbrZvVU9AAejMluANP68VG6JwT4+LmC/NdHT929OfngpBLy+
   ZmPJJzD2THpExpFDMjSv+n3oFblt0SV1AsT0a0EYcwHmYaaUqexL848f2
   /bKoqa39K/PeSq0m0ey2WeJXw/wKz7dnuQY0KI6LdJFAXW2UPIboQRyMo
   g==;
X-CSE-ConnectionGUID: N4neh+9AR7KjhYkS31Q5bA==
X-CSE-MsgGUID: uUc4UAItTvK3xVB8MuuYmQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11177"; a="23511291"
X-IronPort-AV: E=Sophos;i="6.10,181,1719903600"; 
   d="scan'208";a="23511291"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2024 22:23:41 -0700
X-CSE-ConnectionGUID: Q/L/LQjvSO+4WcjnN0eIfQ==
X-CSE-MsgGUID: suXxhsg6Q5u7pm4DopJMTQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,181,1719903600"; 
   d="scan'208";a="63447068"
Received: from lkp-server01.sh.intel.com (HELO 9a732dc145d3) ([10.239.97.150])
  by orviesa006.jf.intel.com with ESMTP; 27 Aug 2024 22:23:39 -0700
Received: from kbuild by 9a732dc145d3 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sjB9c-000KVm-1O;
	Wed, 28 Aug 2024 05:23:36 +0000
Date: Wed, 28 Aug 2024 13:23:29 +0800
From: kernel test robot <lkp@intel.com>
To: Mario Limonciello <superm1@kernel.org>, Borislav Petkov <bp@alien8.de>,
	"Gautham R . Shenoy" <gautham.shenoy@amd.com>,
	Perry Yuan <perry.yuan@amd.com>
Cc: oe-kbuild-all@lists.linux.dev,
	"(maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT))" <x86@kernel.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	"(open list:X86 ARCHITECTURE (32-BIT AND 64-BIT))" <linux-kernel@vger.kernel.org>,
	linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org,
	Mario Limonciello <mario.limonciello@amd.com>
Subject: Re: [PATCH 1/8] x86/amd: Move amd_get_highest_perf() from amd.c to
 cppc.c
Message-ID: <202408281228.SdvJBD9o-lkp@intel.com>
References: <20240826211358.2694603-2-superm1@kernel.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240826211358.2694603-2-superm1@kernel.org>

Hi Mario,

kernel test robot noticed the following build errors:

[auto build test ERROR on rafael-pm/linux-next]
[also build test ERROR on rafael-pm/bleeding-edge tip/x86/core tip/master linus/master v6.11-rc5 next-20240827]
[cannot apply to tip/auto-latest]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Mario-Limonciello/x86-amd-Move-amd_get_highest_perf-from-amd-c-to-cppc-c/20240827-051648
base:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git linux-next
patch link:    https://lore.kernel.org/r/20240826211358.2694603-2-superm1%40kernel.org
patch subject: [PATCH 1/8] x86/amd: Move amd_get_highest_perf() from amd.c to cppc.c
config: x86_64-randconfig-074-20240828 (https://download.01.org/0day-ci/archive/20240828/202408281228.SdvJBD9o-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240828/202408281228.SdvJBD9o-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202408281228.SdvJBD9o-lkp@intel.com/

All errors (new ones prefixed by >>):

>> arch/x86/kernel/acpi/cppc.c:120:5: error: redefinition of 'amd_get_highest_perf'
     120 | u32 amd_get_highest_perf(void)
         |     ^~~~~~~~~~~~~~~~~~~~
   In file included from arch/x86/include/asm/cpufeature.h:5,
                    from arch/x86/include/asm/thread_info.h:59,
                    from include/linux/thread_info.h:60,
                    from include/linux/spinlock.h:60,
                    from include/linux/mmzone.h:8,
                    from include/linux/gfp.h:7,
                    from include/linux/slab.h:16,
                    from include/linux/resource_ext.h:11,
                    from include/linux/acpi.h:13,
                    from include/acpi/cppc_acpi.h:13,
                    from arch/x86/kernel/acpi/cppc.c:7:
   arch/x86/include/asm/processor.h:708:19: note: previous definition of 'amd_get_highest_perf' with type 'u32(void)' {aka 'unsigned int(void)'}
     708 | static inline u32 amd_get_highest_perf(void)            { return 0; }
         |                   ^~~~~~~~~~~~~~~~~~~~


vim +/amd_get_highest_perf +120 arch/x86/kernel/acpi/cppc.c

   119	
 > 120	u32 amd_get_highest_perf(void)

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

