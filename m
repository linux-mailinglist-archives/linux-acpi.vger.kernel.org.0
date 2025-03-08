Return-Path: <linux-acpi+bounces-11973-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 89EC2A57BA0
	for <lists+linux-acpi@lfdr.de>; Sat,  8 Mar 2025 16:39:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 793213B175F
	for <lists+linux-acpi@lfdr.de>; Sat,  8 Mar 2025 15:39:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3F451E25F7;
	Sat,  8 Mar 2025 15:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RTnIlCFb"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 317021DE3C1;
	Sat,  8 Mar 2025 15:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741448378; cv=none; b=rxSaxEq7bctjnR98LnEtp8O66pnMrTlqqA2VizgUPRK25LJ/P8li/doMjvpC1/DCRwp1dxwgmq5jGlXxI76grOqdl0Dfd0S873fsPThy0Hnr09/SQqEJ/0ZhF7LXfZ8jEnFFM3UJ73cvrhKoo1MdWhMxyt6WckE9ojFjNIciJLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741448378; c=relaxed/simple;
	bh=NnLYHq2JqfXgkjMxar4JX+h2rE0kYUMKg8BAJhaoZow=;
	h=Date:From:To:Cc:Subject:Message-ID; b=s7S9yaLx6t/3vS9h/aaxZTlOYOE3T6EaQl/0EF3ggmt9Q4kF6RoSM7gLpxHCnR+NJmnzVbk5M2a629oscfzQqOEHwZObZ910JT8ylG1cl2f7PpSePnLJ74T3RWx6HqnjBPjcl+R8UBXF/TdoS894B9FFtJZP/OTSVPvBqt+bH0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RTnIlCFb; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741448377; x=1772984377;
  h=date:from:to:cc:subject:message-id;
  bh=NnLYHq2JqfXgkjMxar4JX+h2rE0kYUMKg8BAJhaoZow=;
  b=RTnIlCFbDlADS5elU4I1GNi3SAYSF4YyTmWYGZMnm76+lx11xieOS48M
   Oc1oMUdqTbITgpPDVi5+LtWyl3HWr7Wbl2kT8/046DGBPpDK9Ef1XM+gS
   OP9Qv7KWQ2Ilfx5/ToPStKG9+9Crm1k24bC0nvWps7Pd0mKhQFyY0/Fzo
   YNdeHADR4V8yylhXH5ns3A7t+LiX6s9oVmM4NuaNs+jB52vQz8VjkXO95
   LS0lkrNBAGftwRynqyPwxAt7eaexP/uqb2uYNjjKxMlsUkCqxDOGovyiT
   oMFAKpelXNzbtmBMf96C9h5xucEHDnDGRiXHkXhFXT8eI/xQhoVnyjIFe
   Q==;
X-CSE-ConnectionGUID: tnurJ9h7TFytIgbOq7ov6A==
X-CSE-MsgGUID: 9kXRA0pRSAqeaWbVdoP9Ug==
X-IronPort-AV: E=McAfee;i="6700,10204,11367"; a="41646909"
X-IronPort-AV: E=Sophos;i="6.14,232,1736841600"; 
   d="scan'208";a="41646909"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2025 07:39:35 -0800
X-CSE-ConnectionGUID: EZrm0kukRdigxAmvHGXS/Q==
X-CSE-MsgGUID: h5qHw7kDRw++uzYiNnME0w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="150527448"
Received: from lkp-server02.sh.intel.com (HELO a4747d147074) ([10.239.97.151])
  by fmviesa001.fm.intel.com with ESMTP; 08 Mar 2025 07:39:34 -0800
Received: from kbuild by a4747d147074 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tqwGx-00020O-2k;
	Sat, 08 Mar 2025 15:39:31 +0000
Date: Sat, 08 Mar 2025 23:38:26 +0800
From: kernel test robot <lkp@intel.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-acpi@vger.kernel.org, devel@acpica.org,
 linux-pm@vger.kernel.org
Subject: [rafael-pm:bleeding-edge] BUILD SUCCESS
 28b62127a1a108a1c841d16855ed1ed9b556439a
Message-ID: <202503082320.JJWguJjS-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
branch HEAD: 28b62127a1a108a1c841d16855ed1ed9b556439a  Merge branch 'acpi-pm' into bleeding-edge

elapsed time: 1451m

configs tested: 65
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                           allyesconfig    gcc-14.2.0
arc                  randconfig-001-20250308    gcc-13.2.0
arc                  randconfig-002-20250308    gcc-13.2.0
arm                  randconfig-001-20250308    gcc-14.2.0
arm                  randconfig-002-20250308    gcc-14.2.0
arm                  randconfig-003-20250308    gcc-14.2.0
arm                  randconfig-004-20250308    gcc-14.2.0
arm64                randconfig-001-20250308    gcc-14.2.0
arm64                randconfig-002-20250308    gcc-14.2.0
arm64                randconfig-003-20250308    clang-16
arm64                randconfig-004-20250308    gcc-14.2.0
csky                 randconfig-001-20250308    gcc-14.2.0
csky                 randconfig-002-20250308    gcc-14.2.0
hexagon                         allmodconfig    clang-21
hexagon                         allyesconfig    clang-18
hexagon              randconfig-001-20250308    clang-19
hexagon              randconfig-002-20250308    clang-21
i386       buildonly-randconfig-001-20250308    gcc-12
i386       buildonly-randconfig-002-20250308    gcc-11
i386       buildonly-randconfig-003-20250308    clang-19
i386       buildonly-randconfig-004-20250308    clang-19
i386       buildonly-randconfig-005-20250308    clang-19
i386       buildonly-randconfig-006-20250308    gcc-12
loongarch            randconfig-001-20250308    gcc-14.2.0
loongarch            randconfig-002-20250308    gcc-14.2.0
nios2                randconfig-001-20250308    gcc-14.2.0
nios2                randconfig-002-20250308    gcc-14.2.0
openrisc                         allnoconfig    gcc-14.2.0
parisc                           allnoconfig    gcc-14.2.0
parisc               randconfig-001-20250308    gcc-14.2.0
parisc               randconfig-002-20250308    gcc-14.2.0
powerpc                          allnoconfig    gcc-14.2.0
powerpc              randconfig-001-20250308    clang-18
powerpc              randconfig-002-20250308    gcc-14.2.0
powerpc              randconfig-003-20250308    gcc-14.2.0
powerpc64            randconfig-001-20250308    gcc-14.2.0
powerpc64            randconfig-003-20250308    clang-21
riscv                            allnoconfig    gcc-14.2.0
riscv                randconfig-001-20250308    clang-21
riscv                randconfig-002-20250308    gcc-14.2.0
s390                            allmodconfig    clang-19
s390                             allnoconfig    clang-15
s390                            allyesconfig    gcc-14.2.0
s390                 randconfig-001-20250308    clang-19
s390                 randconfig-002-20250308    clang-17
sh                              allmodconfig    gcc-14.2.0
sh                              allyesconfig    gcc-14.2.0
sh                   randconfig-001-20250308    gcc-14.2.0
sh                   randconfig-002-20250308    gcc-14.2.0
sparc                           allmodconfig    gcc-14.2.0
sparc                randconfig-001-20250308    gcc-14.2.0
sparc                randconfig-002-20250308    gcc-14.2.0
sparc64              randconfig-001-20250308    gcc-14.2.0
sparc64              randconfig-002-20250308    gcc-14.2.0
um                               allnoconfig    clang-18
um                   randconfig-001-20250308    gcc-12
um                   randconfig-002-20250308    gcc-12
x86_64     buildonly-randconfig-001-20250308    gcc-12
x86_64     buildonly-randconfig-002-20250308    clang-19
x86_64     buildonly-randconfig-003-20250308    gcc-12
x86_64     buildonly-randconfig-004-20250308    clang-19
x86_64     buildonly-randconfig-005-20250308    clang-19
x86_64     buildonly-randconfig-006-20250308    clang-19
xtensa               randconfig-001-20250308    gcc-14.2.0
xtensa               randconfig-002-20250308    gcc-14.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

