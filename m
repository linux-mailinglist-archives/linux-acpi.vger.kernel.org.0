Return-Path: <linux-acpi+bounces-12932-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 17284A83768
	for <lists+linux-acpi@lfdr.de>; Thu, 10 Apr 2025 05:53:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0074719E3285
	for <lists+linux-acpi@lfdr.de>; Thu, 10 Apr 2025 03:53:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 609BA1F0E50;
	Thu, 10 Apr 2025 03:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YwOcuUOp"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D759BA2E;
	Thu, 10 Apr 2025 03:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744257168; cv=none; b=JWDmnyT20WAnJ7WU/Jy4PUOgp3mVjAKApKVxJ2xF+ubfZEBRWIGFpnDbkGNqnXAUoRmNuo0BLrLFTGy3AHK2hns7wY3Vg7RK5eu/vRvwxhogLY347WGqSOwbGrc2/YfuYfFjuyvLkohKPlg2Gro4j6eO/7w0AXslpbAH2QDLCl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744257168; c=relaxed/simple;
	bh=A5/gT1Io+FjLH1NAuQckHXozz8RZRaLNgZHmXQJCPcM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=XPoGMO4a/H4fmOthWOR2wni18ArGI5zEfzjqn/MMyY3QdRcFbcZtficroBJXRE6/cq0Q2uKTuC0IJZFLrfppit83DaL5LBU0DL2S57Cy0z+FqBA5StmQ0OaZGd7nZSjqwH5qQYnrfCH5XxLqCOCqZ8l0Ax0QpY9o73Gjpdn/4Sk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YwOcuUOp; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744257166; x=1775793166;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=A5/gT1Io+FjLH1NAuQckHXozz8RZRaLNgZHmXQJCPcM=;
  b=YwOcuUOp4k1kortz7V882pm2jwM/IfgqkOdxhyolNY71xBrW+RMkgIdq
   u4To4x8Nvz3bEju3E3cUrmYbtPZLQoEI9LKn367HkqJ40mA5lz7oWkRzU
   TDE6wqErgAExrRSCHlw5RmpZhXX9kv8mR9zdoxkaepLE396gWn3HYcXQI
   7oe6tEiXh2zu3YJzC3uZuZO6FgPEqzeU0KRvQLEYTp8pp9pIZHdaJNiIB
   d5XQaAjjQ0qTZ75OyRKK/cIh8euzW+QuAUSNrwOVFnZ2iqZeKcA4rybgZ
   ERtyKjmO4msPYV5zB+RPR1nK10GCek3on1y85PvJPe8fzWDhUtDo/oalk
   w==;
X-CSE-ConnectionGUID: KifBUOsoQiehHC+AJrS1xQ==
X-CSE-MsgGUID: 4tDePKohTyiKdRO2fmLt+g==
X-IronPort-AV: E=McAfee;i="6700,10204,11399"; a="45645433"
X-IronPort-AV: E=Sophos;i="6.15,201,1739865600"; 
   d="scan'208";a="45645433"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2025 20:52:46 -0700
X-CSE-ConnectionGUID: mTzQ1ISrTXO0z2i+TsWkMQ==
X-CSE-MsgGUID: if2eRd8TRAy6LAeG7bwLRQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,201,1739865600"; 
   d="scan'208";a="128518544"
Received: from lkp-server01.sh.intel.com (HELO b207828170a5) ([10.239.97.150])
  by orviesa009.jf.intel.com with ESMTP; 09 Apr 2025 20:52:43 -0700
Received: from kbuild by b207828170a5 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1u2iy0-0009ZX-2B;
	Thu, 10 Apr 2025 03:52:40 +0000
Date: Thu, 10 Apr 2025 11:51:46 +0800
From: kernel test robot <lkp@intel.com>
To: Zhang Rui <rui.zhang@intel.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-acpi@vger.kernel.org,
	devel@acpica.org, linux-pm@vger.kernel.org,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [rafael-pm:bleeding-edge 44/56]
 drivers/acpi/processor_idle.c:464:22: warning: unused variable 'i'
Message-ID: <202504101132.pgiDBR2Q-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Zhang,

FYI, the error/warning was bisected to this commit, please ignore it if it's irrelevant.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
head:   655d33f14d6cebcf46e422bcb9d225d791bba42f
commit: 8ea9d119e7c666b6d87697af1b69193354c865d1 [44/56] ACPI: processor: idle: Remove redundant pr->power.count assignment
config: i386-buildonly-randconfig-003-20250409 (https://download.01.org/0day-ci/archive/20250410/202504101132.pgiDBR2Q-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-12) 11.3.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250410/202504101132.pgiDBR2Q-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202504101132.pgiDBR2Q-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/acpi/processor_idle.c: In function 'acpi_processor_get_cstate_info':
>> drivers/acpi/processor_idle.c:464:22: warning: unused variable 'i' [-Wunused-variable]
     464 |         unsigned int i;
         |                      ^


vim +/i +464 drivers/acpi/processor_idle.c

^1da177e4c3f415 Linus Torvalds      2005-04-16  461  
a36a7fecfe60717 Sudeep Holla        2016-07-21  462  static int acpi_processor_get_cstate_info(struct acpi_processor *pr)
^1da177e4c3f415 Linus Torvalds      2005-04-16  463  {
^1da177e4c3f415 Linus Torvalds      2005-04-16 @464  	unsigned int i;
^1da177e4c3f415 Linus Torvalds      2005-04-16  465  	int result;
^1da177e4c3f415 Linus Torvalds      2005-04-16  466  
^1da177e4c3f415 Linus Torvalds      2005-04-16  467  
^1da177e4c3f415 Linus Torvalds      2005-04-16  468  	/* NOTE: the idle thread may not be running while calling
^1da177e4c3f415 Linus Torvalds      2005-04-16  469  	 * this function */
^1da177e4c3f415 Linus Torvalds      2005-04-16  470  
991528d73486679 Venkatesh Pallipadi 2006-09-25  471  	/* Zero initialize all the C-states info. */
991528d73486679 Venkatesh Pallipadi 2006-09-25  472  	memset(pr->power.states, 0, sizeof(pr->power.states));
991528d73486679 Venkatesh Pallipadi 2006-09-25  473  
^1da177e4c3f415 Linus Torvalds      2005-04-16  474  	result = acpi_processor_get_power_info_cst(pr);
6d93c64803a5fea Venkatesh Pallipadi 2005-09-15  475  	if (result == -ENODEV)
c5a114f1fb2d3c5 Darrick J. Wong     2006-10-19  476  		result = acpi_processor_get_power_info_fadt(pr);
6d93c64803a5fea Venkatesh Pallipadi 2005-09-15  477  
991528d73486679 Venkatesh Pallipadi 2006-09-25  478  	if (result)
991528d73486679 Venkatesh Pallipadi 2006-09-25  479  		return result;
991528d73486679 Venkatesh Pallipadi 2006-09-25  480  
991528d73486679 Venkatesh Pallipadi 2006-09-25  481  	acpi_processor_get_power_info_default(pr);
991528d73486679 Venkatesh Pallipadi 2006-09-25  482  
cf82478840188f8 Janosch Machowinski 2005-08-20  483  	pr->power.count = acpi_processor_power_verify(pr);
8fa2f8bd6ad10ec Zhang Rui           2025-04-09  484  	pr->flags.power = 1;
^1da177e4c3f415 Linus Torvalds      2005-04-16  485  
d550d98d3317378 Patrick Mochel      2006-06-27  486  	return 0;
^1da177e4c3f415 Linus Torvalds      2005-04-16  487  }
^1da177e4c3f415 Linus Torvalds      2005-04-16  488  

:::::: The code at line 464 was first introduced by commit
:::::: 1da177e4c3f41524e886b7f1b8a0c1fc7321cac2 Linux-2.6.12-rc2

:::::: TO: Linus Torvalds <torvalds@ppc970.osdl.org>
:::::: CC: Linus Torvalds <torvalds@ppc970.osdl.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

