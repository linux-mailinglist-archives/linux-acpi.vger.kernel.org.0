Return-Path: <linux-acpi+bounces-18694-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C6BE3C43850
	for <lists+linux-acpi@lfdr.de>; Sun, 09 Nov 2025 05:10:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 682DE4E02DA
	for <lists+linux-acpi@lfdr.de>; Sun,  9 Nov 2025 04:10:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27B9720013A;
	Sun,  9 Nov 2025 04:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hvEsrjst"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32A8EBA34;
	Sun,  9 Nov 2025 04:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762661438; cv=none; b=Bosogi4pR9lkZQPAsH3g1a0WMTOrjAPwgLNlqxNrI1isPKbqp2u8+y6tfK1HHlOJJmslWvf/gBMPCyq2pE4CtFC2wYvqBSwDe0EeygLQPkQ0G+xn1Bb3KjZxlICEt4ANo8dR8W5vN+jzvv1S1jtz0hw6yHtaJQ8gtiQKq1+4kMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762661438; c=relaxed/simple;
	bh=J3c9aIu00ysxUwCMR6R+RYh+sA9Jlld8OazAez6iKQw=;
	h=Date:From:To:Cc:Subject:Message-ID; b=g21xolu4bDoZDYof8KWaMM9M0XRyI4rjluwnFREKsWGI+aSvSZBVC4S9Xsk8HQpA/NcmFMuhSKFuKnbUFKjQUmiOCSprx1XCcTE9yO624zr7mHGojnq1uh8/PZDu+jDLwAT9EsSUCSTiwWs8mJJTUUDcVtOQ/T0XMMRZ1OLnP2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hvEsrjst; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762661436; x=1794197436;
  h=date:from:to:cc:subject:message-id;
  bh=J3c9aIu00ysxUwCMR6R+RYh+sA9Jlld8OazAez6iKQw=;
  b=hvEsrjstD/ZtFCTYv/rHKnnWVBvxmh4tuXSTlS7HzXicdG9RGJ5vtsBE
   uqGk/XGAjolXqjd3QHzH7XrraEbECURgYLzse5bzlariypogga9h2jyin
   d7MA+UGDdDjHVG8E0+rLou5oBol9OjE4/CPvPpexnrWozeTJS9qoQAZYw
   VrZLIz9NtMjYhSqU2+HjdpiQA3ubz8TEySX/DrBP2OTPV1C1mJ6BPgjGh
   EtaK7SBZwRTYkxlqPdxc4rrdi8HaM+74FyvBtvhv3rAhQxfplpO86HgZ2
   3MItFLlPaaCKOEy949gJw0Pq1PR7wT+H/zva1nXIvyuPkYb9IxIz/TOvy
   w==;
X-CSE-ConnectionGUID: W+Bk4v2OTSWJrTiWgJdrqQ==
X-CSE-MsgGUID: x+jYuEIZRwm+HcD7G8SHZQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11607"; a="64637582"
X-IronPort-AV: E=Sophos;i="6.19,291,1754982000"; 
   d="scan'208";a="64637582"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2025 20:10:36 -0800
X-CSE-ConnectionGUID: eD3eWDZVROSaWuarjc6X4w==
X-CSE-MsgGUID: Z0B5P32fSSipRQHC4AN8Xw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,291,1754982000"; 
   d="scan'208";a="188638422"
Received: from lkp-server01.sh.intel.com (HELO 6ef82f2de774) ([10.239.97.150])
  by fmviesa008.fm.intel.com with ESMTP; 08 Nov 2025 20:10:34 -0800
Received: from kbuild by 6ef82f2de774 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vHwl6-0001kp-1L;
	Sun, 09 Nov 2025 04:10:32 +0000
Date: Sun, 09 Nov 2025 12:09:38 +0800
From: kernel test robot <lkp@intel.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org
Subject: [rafael-pm:bleeding-edge] BUILD SUCCESS
 6030c3f9f689fd5e1f23e9cc721da9b55bf8fde0
Message-ID: <202511091232.8N3jdohr-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
branch HEAD: 6030c3f9f689fd5e1f23e9cc721da9b55bf8fde0  Merge branch 'testing' into bleeding-edge

elapsed time: 1843m

configs tested: 109
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.1.0
arc                               allnoconfig    gcc-15.1.0
arc                        nsimosci_defconfig    gcc-15.1.0
arc                   randconfig-001-20251108    gcc-12.5.0
arc                   randconfig-002-20251108    gcc-8.5.0
arc                           tb10x_defconfig    gcc-15.1.0
arm                               allnoconfig    clang-22
arm                            qcom_defconfig    clang-22
arm                   randconfig-001-20251108    gcc-14.3.0
arm                   randconfig-002-20251108    gcc-15.1.0
arm                   randconfig-003-20251108    clang-22
arm                   randconfig-004-20251108    gcc-10.5.0
arm64                             allnoconfig    gcc-15.1.0
arm64                 randconfig-001-20251109    gcc-15.1.0
arm64                 randconfig-002-20251109    gcc-12.5.0
arm64                 randconfig-003-20251109    clang-19
arm64                 randconfig-004-20251109    gcc-8.5.0
csky                              allnoconfig    gcc-15.1.0
csky                  randconfig-001-20251109    gcc-14.3.0
csky                  randconfig-002-20251109    gcc-11.5.0
hexagon                           allnoconfig    clang-22
hexagon               randconfig-001-20251108    clang-22
hexagon               randconfig-002-20251108    clang-22
i386                             alldefconfig    gcc-14
i386                              allnoconfig    gcc-14
i386        buildonly-randconfig-001-20251109    gcc-14
i386        buildonly-randconfig-002-20251109    gcc-13
i386        buildonly-randconfig-003-20251109    clang-20
i386        buildonly-randconfig-004-20251109    clang-20
i386        buildonly-randconfig-005-20251109    clang-20
i386        buildonly-randconfig-006-20251109    clang-20
i386                  randconfig-001-20251109    clang-20
i386                  randconfig-002-20251109    gcc-14
i386                  randconfig-003-20251109    clang-20
i386                  randconfig-004-20251109    clang-20
i386                  randconfig-005-20251109    gcc-14
i386                  randconfig-006-20251109    clang-20
i386                  randconfig-007-20251109    clang-20
loongarch                         allnoconfig    clang-22
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20251108    gcc-12.5.0
loongarch             randconfig-002-20251108    gcc-12.5.0
m68k                              allnoconfig    gcc-15.1.0
m68k                                defconfig    gcc-15.1.0
m68k                        m5272c3_defconfig    gcc-15.1.0
m68k                        m5307c3_defconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                          defconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    gcc-11.5.0
nios2                 randconfig-001-20251108    gcc-8.5.0
nios2                 randconfig-002-20251108    gcc-9.5.0
openrisc                          allnoconfig    gcc-15.1.0
openrisc                            defconfig    gcc-15.1.0
parisc                            allnoconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20251108    gcc-8.5.0
parisc                randconfig-002-20251108    gcc-8.5.0
parisc64                            defconfig    gcc-15.1.0
powerpc                           allnoconfig    gcc-15.1.0
powerpc               randconfig-001-20251108    gcc-8.5.0
powerpc               randconfig-002-20251108    gcc-9.5.0
powerpc64             randconfig-001-20251108    gcc-8.5.0
powerpc64             randconfig-002-20251108    gcc-8.5.0
riscv                             allnoconfig    gcc-15.1.0
riscv                 randconfig-001-20251108    clang-19
riscv                 randconfig-002-20251108    gcc-12.5.0
s390                              allnoconfig    clang-22
s390                  randconfig-001-20251108    clang-22
s390                  randconfig-002-20251108    gcc-8.5.0
sh                                allnoconfig    gcc-15.1.0
sh                                  defconfig    gcc-15.1.0
sh                    randconfig-001-20251108    gcc-15.1.0
sh                    randconfig-002-20251108    gcc-13.4.0
sh                          sdk7780_defconfig    gcc-15.1.0
sh                           se7722_defconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                 randconfig-001-20251109    gcc-8.5.0
sparc                 randconfig-002-20251109    gcc-15.1.0
sparc64                             defconfig    clang-20
sparc64               randconfig-001-20251109    gcc-8.5.0
sparc64               randconfig-002-20251109    gcc-14.3.0
um                                allnoconfig    clang-22
um                                  defconfig    clang-22
um                             i386_defconfig    gcc-14
um                    randconfig-001-20251109    gcc-13
um                           x86_64_defconfig    clang-22
x86_64                            allnoconfig    clang-20
x86_64      buildonly-randconfig-001-20251109    clang-20
x86_64      buildonly-randconfig-002-20251109    gcc-14
x86_64      buildonly-randconfig-003-20251109    clang-20
x86_64      buildonly-randconfig-004-20251109    clang-20
x86_64      buildonly-randconfig-005-20251109    clang-20
x86_64      buildonly-randconfig-006-20251109    clang-20
x86_64                              defconfig    gcc-14
x86_64                randconfig-011-20251109    gcc-14
x86_64                randconfig-012-20251109    clang-20
x86_64                randconfig-013-20251109    gcc-14
x86_64                randconfig-014-20251109    clang-20
x86_64                randconfig-015-20251109    clang-20
x86_64                randconfig-016-20251109    clang-20
x86_64                randconfig-071-20251109    clang-20
x86_64                randconfig-072-20251109    clang-20
x86_64                randconfig-073-20251109    gcc-14
x86_64                randconfig-074-20251109    clang-20
x86_64                randconfig-075-20251109    gcc-14
x86_64                randconfig-076-20251109    clang-20
xtensa                            allnoconfig    gcc-15.1.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

