Return-Path: <linux-acpi+bounces-4567-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EBE0E891FCB
	for <lists+linux-acpi@lfdr.de>; Fri, 29 Mar 2024 16:11:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A55F428947A
	for <lists+linux-acpi@lfdr.de>; Fri, 29 Mar 2024 15:11:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5D7D148311;
	Fri, 29 Mar 2024 14:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nrJt+Y8Z"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7D601482FD;
	Fri, 29 Mar 2024 14:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711721697; cv=none; b=abl+dWsnXU7r6Kau76dl+TNu8TmVJK0jE8DVYK/DcIY7VdrOKNeoZWCdzSy289O3850CZvtIQl5VvaEkraoygSHKh1VUMeFetDZB2EOKYn7K47oXz8kjMMvE2XufGDUNAzjL+CDebHVjDiwZEiQnBpDjuO55w5nEwqLdC+PGCNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711721697; c=relaxed/simple;
	bh=pj1mTlDrDGST+H80OnmhHk4hz5HIPNduSuVF66YCGOU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=F/j27rgIIG78CbDR7v2HC5Pypo+kShX/h7cPKZcdqcSymP9wjTggqsRt4qM9D9JYrOM4myvD/w5kzufv2fezrVSMBnfdhTCc8Zx5Q8iEGRygJEvzsh1EWHEMT37gBY1izjx9zuorhVuVWwlqlMBo7DdP/gSfYAPJEvd8owTIlZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nrJt+Y8Z; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711721696; x=1743257696;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=pj1mTlDrDGST+H80OnmhHk4hz5HIPNduSuVF66YCGOU=;
  b=nrJt+Y8ZOW8+UedNlg49kNILStjDaFTbM4hw50pK5nOynP5zyYthU6Pv
   ZzAT8oQhGdfu6KsRqgP4Y1aEDmIquAc33DpMK5BWBEq4pLrntAf4Z5+9z
   WKc0actUbF7ICI+gvkJU5uUuyhNfPRUu1hUCiSyuWNpVPsHe+xTKzLncM
   DKo/urKz4hi2Fg/1yCbuELpBSURphPuM9w/Xm2a2Ld+uYBc6xz/bxrm7U
   HVeKFKIp250HYazO/LhMCC/8PE+7QpsH8bW8n8NETukjpfJ7A87H/Ny3e
   2E3QdyrH6eXS62fOrEg6W95llkWB0ZMR3At5h6HaT+owQbTihFERoMGZ6
   Q==;
X-CSE-ConnectionGUID: kL5JTmjZSQe367TuRRF5ew==
X-CSE-MsgGUID: QTt/+1VkSvKgsNngBM0IPQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11028"; a="6848056"
X-IronPort-AV: E=Sophos;i="6.07,165,1708416000"; 
   d="scan'208";a="6848056"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2024 07:14:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,165,1708416000"; 
   d="scan'208";a="21695007"
Received: from lkp-server01.sh.intel.com (HELO be39aa325d23) ([10.239.97.150])
  by orviesa005.jf.intel.com with ESMTP; 29 Mar 2024 07:14:53 -0700
Received: from kbuild by be39aa325d23 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rqD0L-0003Fc-2o;
	Fri, 29 Mar 2024 14:14:49 +0000
Date: Fri, 29 Mar 2024 22:13:59 +0800
From: kernel test robot <lkp@intel.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: oe-kbuild-all@lists.linux.dev, linux-acpi@vger.kernel.org,
	devel@acpica.org, linux-pm@vger.kernel.org
Subject: [rafael-pm:intel_pstate-testing 13/14]
 arch/x86/kernel/smpboot.c:129:1: sparse: sparse: symbol
 '__pcpu_scope_arch_cpu_scale' was not declared. Should it be static?
Message-ID: <202403292251.KAvVZtwd-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git intel_pstate-testing
head:   9e188470f00d32c31b5be6f701ed94e6cce3a195
commit: fbc05ec06cbf10eb71658eb41582c0df7098b95b [13/14] x86/sched: Add basic support for CPU capacity scaling
config: i386-randconfig-061-20240329 (https://download.01.org/0day-ci/archive/20240329/202403292251.KAvVZtwd-lkp@intel.com/config)
compiler: clang version 17.0.6 (https://github.com/llvm/llvm-project 6009708b4367171ccdbf4b5905cb6a803753fe18)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240329/202403292251.KAvVZtwd-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202403292251.KAvVZtwd-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> arch/x86/kernel/smpboot.c:129:1: sparse: sparse: symbol '__pcpu_scope_arch_cpu_scale' was not declared. Should it be static?
   arch/x86/kernel/smpboot.c: note: in included file (through include/linux/mmzone.h, include/linux/topology.h, include/linux/sched/topology.h, ...):
   include/linux/page-flags.h:242:46: sparse: sparse: self-comparison always evaluates to false
   include/linux/page-flags.h:242:46: sparse: sparse: self-comparison always evaluates to false
   arch/x86/kernel/smpboot.c: note: in included file (through arch/x86/include/asm/mmu_context.h, include/linux/mmu_context.h, include/linux/cpuset.h):
   arch/x86/include/asm/desc.h:54:16: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] __percpu *__vpp_verify @@     got struct gdt_page * @@
   arch/x86/include/asm/desc.h:54:16: sparse:     expected void const [noderef] __percpu *__vpp_verify
   arch/x86/include/asm/desc.h:54:16: sparse:     got struct gdt_page *

vim +/__pcpu_scope_arch_cpu_scale +129 arch/x86/kernel/smpboot.c

   127	
   128	/* CPU capacity scaling support */
 > 129	DEFINE_PER_CPU(unsigned long, arch_cpu_scale) = SCHED_CAPACITY_SCALE;
   130	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

