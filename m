Return-Path: <linux-acpi+bounces-3824-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C7FA785F22F
	for <lists+linux-acpi@lfdr.de>; Thu, 22 Feb 2024 08:53:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 041F81C22CE5
	for <lists+linux-acpi@lfdr.de>; Thu, 22 Feb 2024 07:53:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC95F17BCA;
	Thu, 22 Feb 2024 07:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IWTI03Dk"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 012FA17BA2;
	Thu, 22 Feb 2024 07:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708588400; cv=none; b=Gg6CRxN9IjKF5CZxtQC2acLam5eHjWJwwDhIjzEp9KKr8nY4p65/Ge4FaXfhitZdQJacIr0OEulPC5BXjddOgmO6RW7RJd/FYh4S51pSYYo16z1eaORgBt2fmTWLAHLzeT04PkNepjFCNw9CyWt0I5vAMxDe6wUSRlNuy2/F/n8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708588400; c=relaxed/simple;
	bh=OpWra/EZ0f3kN02EXvLkRDc0JSylAvQfhUnApbno8/A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oAXtVmaBUKt49mbg5drNK+70TIVEfPZmi6SoNJfcKJSlN1+230UvjMYyHoV2Ph2syjw+YspspcnmmVPlJzF/1fA3tvconWBy9nTlYCktKjksz1MpOhQEjWXyQLt5+Yiq+vyBSjYrIoESk+iqsbZx4Cx4y26dpedeRqZ8OdBNk+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IWTI03Dk; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708588398; x=1740124398;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=OpWra/EZ0f3kN02EXvLkRDc0JSylAvQfhUnApbno8/A=;
  b=IWTI03DkcTC0OWi8OffuvmU+33TnqjE80qiv1rRqrXeXyH/q3n15KGJF
   ytlLQ0ntfE51oppiOkwse10tqPO3ZbpGFKWR117RBqfob91PLDFiD8Isc
   Y3/9VMOoYtUpLbr+CdZ+YxM7S3Fn3j/OiXe8ttOV37ppG38mq4pomRN34
   FTundkMIkfNSQuwgYxI9kTS5ECtrLmltrPDsFOs2r6hFlV3XiAQ9PrSK5
   bXRL+Aqv9212zS6ebqI3jBXu7LlgOBPZf5Y5qDyS0+2IBRDdUU8ltfDpd
   EgobgDT4VtgqMLooiHwt1HBS1WsR/p15VHBIDhVN8G8SO5Ieq/fp/zniv
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10991"; a="20228154"
X-IronPort-AV: E=Sophos;i="6.06,177,1705392000"; 
   d="scan'208";a="20228154"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2024 23:53:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10991"; a="827507925"
X-IronPort-AV: E=Sophos;i="6.06,177,1705392000"; 
   d="scan'208";a="827507925"
Received: from lkp-server02.sh.intel.com (HELO 3c78fa4d504c) ([10.239.97.151])
  by orsmga001.jf.intel.com with ESMTP; 21 Feb 2024 23:53:13 -0800
Received: from kbuild by 3c78fa4d504c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rd3qV-00065w-27;
	Thu, 22 Feb 2024 07:53:10 +0000
Date: Thu, 22 Feb 2024 15:49:42 +0800
From: kernel test robot <lkp@intel.com>
To: Ben Cheatham <Benjamin.Cheatham@amd.com>, dan.j.williams@intel.com,
	jonathan.cameron@huawei.com, rafael@kernel.org, james.morse@arm.com,
	tony.luck@intel.com, bp@alien8.de
Cc: oe-kbuild-all@lists.linux.dev, dave@stogolabs.net, dave.jiang@intel.com,
	alison.schofield@intel.com, vishal.l.verma@intel.com,
	ira.weiny@intel.com, linux-cxl@vger.kernel.org,
	linux-acpi@vger.kernel.org, benjamin.cheatham@amd.com
Subject: Re: [PATCH v13 2/4] EINJ: Add CXL error type support
Message-ID: <202402221559.7ZWbaUpL-lkp@intel.com>
References: <20240220221146.399209-3-Benjamin.Cheatham@amd.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240220221146.399209-3-Benjamin.Cheatham@amd.com>

Hi Ben,

kernel test robot noticed the following build errors:

[auto build test ERROR on rafael-pm/linux-next]
[also build test ERROR on linus/master v6.8-rc5 next-20240221]
[cannot apply to rafael-pm/acpi-bus rafael-pm/devprop]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Ben-Cheatham/EINJ-Migrate-to-a-platform-driver/20240221-061359
base:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git linux-next
patch link:    https://lore.kernel.org/r/20240220221146.399209-3-Benjamin.Cheatham%40amd.com
patch subject: [PATCH v13 2/4] EINJ: Add CXL error type support
config: i386-buildonly-randconfig-004-20240221 (https://download.01.org/0day-ci/archive/20240222/202402221559.7ZWbaUpL-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240222/202402221559.7ZWbaUpL-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202402221559.7ZWbaUpL-lkp@intel.com/

All errors (new ones prefixed by >>):

   ld: drivers/acpi/apei/einj-cxl.o: in function `einj_cxl_inject_error':
>> einj-cxl.c:(.text+0x166): undefined reference to `pci_find_host_bridge'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

