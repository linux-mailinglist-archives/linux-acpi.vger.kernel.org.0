Return-Path: <linux-acpi+bounces-4278-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DD208795E3
	for <lists+linux-acpi@lfdr.de>; Tue, 12 Mar 2024 15:17:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2797F1F23AD2
	for <lists+linux-acpi@lfdr.de>; Tue, 12 Mar 2024 14:17:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10FA158AD4;
	Tue, 12 Mar 2024 14:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YHh3Xnaq"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86D0E57307;
	Tue, 12 Mar 2024 14:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710253062; cv=none; b=A1cOGhsvbN8zXZ6Ak3YN4kj0y6HPml4/5wEVuPdAfk6j3OL/WsAhooBmK1gg14uamF31+Nnf2/5sJkP/kh4zylNeiNxzXGnMM2y0oLJOzeRnSXZlCZEZmDasjW9cKslNoyDkye2drc3AKCdX/CCHtg+Z5wU1t4vj4hXHLEuFrG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710253062; c=relaxed/simple;
	bh=XoAwf9+kEnAUGF56LAReX+Da1CDiFMk4mBryFYNhyhI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KvfcpzcjG1sU7nANNFFwvKfzqU2FFjM97L/r4wT6hDdRVlEw98+z+fvY9ft7sQVhVs3/UrlY/W4FZ9QL4briD9uV1KkLwMyS4hEr2qA8WrQtGWyD9kv4bXWHcCMmlgZ3LgQHScGbm40r5ONl2cIzqYby9dGJ/TvXRr+P9V//8vM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YHh3Xnaq; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710253059; x=1741789059;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=XoAwf9+kEnAUGF56LAReX+Da1CDiFMk4mBryFYNhyhI=;
  b=YHh3Xnaq8BYPzBxBybjgYp1LfLWETk6ccMXfsghQWw94IaIhnjTdT5ch
   0XRG1li3y9wt4T48FIULWcvNmXY+CMEZXABLdBQiL1jdTNwQRwpGSM2jq
   S04BRLLxq1idRmyaWrkUPwA6sjU7WPllozi0z9a3PZcdbLVf3AcVRn/Xn
   OF8dXCyo5wIAnQZCHS+UByDWLZTO+LmQ+uGLVW0ozNOYZAscRmA2YpYU3
   frHlcnwfylJvoUruGhXCppy1gGhROcqWkBz+N7MqtNb/aXXoLn+6U+rzS
   PL1Zkg4fhx9LjBYcVuL8oKEBAxsnXKbAnxDVB3Yqg5GItPUDYzklQk/er
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11010"; a="30400912"
X-IronPort-AV: E=Sophos;i="6.07,119,1708416000"; 
   d="scan'208";a="30400912"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2024 07:17:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,119,1708416000"; 
   d="scan'208";a="16123852"
Received: from lkp-server01.sh.intel.com (HELO b21307750695) ([10.239.97.150])
  by fmviesa003.fm.intel.com with ESMTP; 12 Mar 2024 07:17:34 -0700
Received: from kbuild by b21307750695 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rk2wd-000ABb-0O;
	Tue, 12 Mar 2024 14:17:31 +0000
Date: Tue, 12 Mar 2024 22:16:50 +0800
From: kernel test robot <lkp@intel.com>
To: Ben Cheatham <Benjamin.Cheatham@amd.com>, dan.j.williams@intel.com,
	jonathan.cameron@huawei.com, rafael@kernel.org, james.morse@arm.com,
	tony.luck@intel.com, bp@alien8.de
Cc: oe-kbuild-all@lists.linux.dev, dave@stogolabs.net, dave.jiang@intel.com,
	alison.schofield@intel.com, vishal.l.verma@intel.com,
	ira.weiny@intel.com, linux-cxl@vger.kernel.org,
	linux-acpi@vger.kernel.org, benjamin.cheatham@amd.com
Subject: Re: [PATCH v15 2/4] EINJ: Add CXL error type support
Message-ID: <202403122225.k6RQAbBI-lkp@intel.com>
References: <20240311142508.31717-3-Benjamin.Cheatham@amd.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240311142508.31717-3-Benjamin.Cheatham@amd.com>

Hi Ben,

kernel test robot noticed the following build errors:

[auto build test ERROR on rafael-pm/linux-next]
[also build test ERROR on linus/master v6.8 next-20240312]
[cannot apply to rafael-pm/acpi-bus rafael-pm/devprop]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Ben-Cheatham/EINJ-Migrate-to-a-platform-driver/20240311-222800
base:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git linux-next
patch link:    https://lore.kernel.org/r/20240311142508.31717-3-Benjamin.Cheatham%40amd.com
patch subject: [PATCH v15 2/4] EINJ: Add CXL error type support
config: arm64-randconfig-001-20240312 (https://download.01.org/0day-ci/archive/20240312/202403122225.k6RQAbBI-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240312/202403122225.k6RQAbBI-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202403122225.k6RQAbBI-lkp@intel.com/

All errors (new ones prefixed by >>):

   aarch64-linux-ld: Unexpected GOT/PLT entries detected!
   aarch64-linux-ld: Unexpected run-time procedure linkages detected!
   aarch64-linux-ld: drivers/acpi/apei/einj-cxl.o: in function `einj_cxl_inject_error':
>> einj-cxl.c:(.text+0x2b4): undefined reference to `pci_find_host_bridge'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

