Return-Path: <linux-acpi+bounces-15240-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 39438B0B0F5
	for <lists+linux-acpi@lfdr.de>; Sat, 19 Jul 2025 18:57:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 702813BD84F
	for <lists+linux-acpi@lfdr.de>; Sat, 19 Jul 2025 16:57:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAFE3220F29;
	Sat, 19 Jul 2025 16:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eE5Z+zeJ"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D32820B80A;
	Sat, 19 Jul 2025 16:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752944262; cv=none; b=ZgR/KXRbzLipLUfVQMJSG5KMtOet1RwyeZdvJaNf66d6BqDkTcnuQIRM2PnsMT08C4+KM8JLuXUOTjmHADIoJ4ORKXT2GZKKlw/Oc8R1oULYxIU6UalLxrGSr5W+OoKuiLSibr1vxAQZftQoMr8TrwSJwWFhHBPU9JthA6mm4Fk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752944262; c=relaxed/simple;
	bh=IqIQNUzmsFKNMuX6ZUyl2Blli6THQnw1yXSl+ZE8nGg=;
	h=Date:From:To:Cc:Subject:Message-ID; b=fecCFT7z/UKjGgS5j3PlrnHjoW+ZVu/M9yW/Z53gOiXEuAjAC1s4/QVjmdyx2zE0d1DrvNySTS9mnf/1R5d/AAnM+k2nsy3i/uzyrX38qma5yuC4VX8ZWo4wdCUaKIHEi5casE+ChWbQeXzDlfjNLmSfg0Ug1e4jMJrXyZs7x+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eE5Z+zeJ; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752944261; x=1784480261;
  h=date:from:to:cc:subject:message-id;
  bh=IqIQNUzmsFKNMuX6ZUyl2Blli6THQnw1yXSl+ZE8nGg=;
  b=eE5Z+zeJ6HQqCLcbIHCy8G0NoiKszU4B+RPL7a3Jrp+e9bEoRnpWsGFJ
   rlptNzvaIU3TVgvyIsQ104bzSo4HeWyBfSlJI2Qakyw0tav+FzrbJSG5M
   TU5zshYj1mp5Gy8KeKhn40Pi0dPowjnLWa1Qse+K11U5B1hArUF+Kycwn
   vApKdavsRdWr1q9dbMHxGHn+pNbd74FIiO7plopSFMSYNFx+utWWpdAOl
   4ACk0r51ysGzENISQdLtYJW5w8SerE6EtMtmeoB+kW9+Jr1zMx1EU4zZi
   O6gtVnKcwXou4p98GzIOaQPypxpFwtcGBWGU8nYOwDkmU02rOfhyMqedP
   Q==;
X-CSE-ConnectionGUID: MdXzov3ERrSfurNsyNMjQQ==
X-CSE-MsgGUID: t3cnivopReylroQINSl+jQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11497"; a="55094421"
X-IronPort-AV: E=Sophos;i="6.16,324,1744095600"; 
   d="scan'208";a="55094421"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jul 2025 09:57:40 -0700
X-CSE-ConnectionGUID: /Wn4JqhvQASiLD7oe92w/A==
X-CSE-MsgGUID: OtLR9tWtSMKmQpBMDZ/Tkw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,324,1744095600"; 
   d="scan'208";a="158127643"
Received: from lkp-server01.sh.intel.com (HELO 9ee84586c615) ([10.239.97.150])
  by fmviesa007.fm.intel.com with ESMTP; 19 Jul 2025 09:57:39 -0700
Received: from kbuild by 9ee84586c615 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1udAsS-000Fdw-2s;
	Sat, 19 Jul 2025 16:57:36 +0000
Date: Sun, 20 Jul 2025 00:57:18 +0800
From: kernel test robot <lkp@intel.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-acpi@vger.kernel.org, devel@acpica.org,
 linux-pm@vger.kernel.org
Subject: [rafael-pm:bleeding-edge] BUILD SUCCESS
 dfb7659050ceed4ded91729e45f2fc464eb59aa0
Message-ID: <202507200006.uJXr6eeX-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
branch HEAD: dfb7659050ceed4ded91729e45f2fc464eb59aa0  Merge branch 'pm-sleep' into linux-next

elapsed time: 1444m

configs tested: 103
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.1.0
alpha                            allyesconfig    gcc-15.1.0
arc                              allmodconfig    gcc-15.1.0
arc                               allnoconfig    gcc-15.1.0
arc                              allyesconfig    gcc-15.1.0
arc                         haps_hs_defconfig    gcc-15.1.0
arc                   randconfig-001-20250719    gcc-14.3.0
arc                   randconfig-002-20250719    gcc-15.1.0
arm                              allmodconfig    gcc-15.1.0
arm                               allnoconfig    clang-21
arm                              allyesconfig    gcc-15.1.0
arm                   randconfig-001-20250719    gcc-14.3.0
arm                   randconfig-002-20250719    clang-21
arm                   randconfig-003-20250719    clang-21
arm                   randconfig-004-20250719    clang-16
arm                         socfpga_defconfig    gcc-15.1.0
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-15.1.0
arm64                 randconfig-001-20250719    clang-20
arm64                 randconfig-002-20250719    clang-18
arm64                 randconfig-003-20250719    gcc-15.1.0
arm64                 randconfig-004-20250719    clang-20
csky                             alldefconfig    gcc-15.1.0
csky                              allnoconfig    gcc-15.1.0
csky                  randconfig-001-20250719    gcc-15.1.0
csky                  randconfig-002-20250719    gcc-11.5.0
hexagon                          allmodconfig    clang-17
hexagon                           allnoconfig    clang-21
hexagon                          allyesconfig    clang-21
hexagon               randconfig-001-20250719    clang-21
hexagon               randconfig-002-20250719    clang-21
i386        buildonly-randconfig-001-20250719    clang-20
i386        buildonly-randconfig-002-20250719    gcc-12
i386        buildonly-randconfig-003-20250719    gcc-12
i386        buildonly-randconfig-004-20250719    clang-20
i386        buildonly-randconfig-005-20250719    clang-20
i386        buildonly-randconfig-006-20250719    clang-20
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-21
loongarch             randconfig-001-20250719    clang-18
loongarch             randconfig-002-20250719    gcc-15.1.0
m68k                             allmodconfig    gcc-15.1.0
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    gcc-15.1.0
microblaze                       allmodconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    gcc-15.1.0
microblaze                          defconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    gcc-11.5.0
nios2                 randconfig-001-20250719    gcc-11.5.0
nios2                 randconfig-002-20250719    gcc-8.5.0
openrisc                          allnoconfig    gcc-15.1.0
parisc                            allnoconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20250719    gcc-8.5.0
parisc                randconfig-002-20250719    gcc-8.5.0
parisc64                            defconfig    gcc-15.1.0
powerpc                           allnoconfig    gcc-15.1.0
powerpc                      katmai_defconfig    clang-21
powerpc               randconfig-001-20250719    clang-19
powerpc               randconfig-002-20250719    gcc-10.5.0
powerpc               randconfig-003-20250719    gcc-12.5.0
powerpc64             randconfig-001-20250719    gcc-8.5.0
powerpc64             randconfig-002-20250719    clang-21
powerpc64             randconfig-003-20250719    gcc-10.5.0
riscv                             allnoconfig    gcc-15.1.0
riscv                 randconfig-001-20250719    clang-21
riscv                 randconfig-002-20250719    clang-21
s390                             allmodconfig    clang-18
s390                              allnoconfig    clang-21
s390                             allyesconfig    gcc-15.1.0
s390                  randconfig-001-20250719    gcc-9.5.0
s390                  randconfig-002-20250719    gcc-9.5.0
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                    randconfig-001-20250719    gcc-13.4.0
sh                    randconfig-002-20250719    gcc-15.1.0
sparc                            allmodconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                               defconfig    gcc-15.1.0
sparc                 randconfig-001-20250719    gcc-15.1.0
sparc                 randconfig-002-20250719    gcc-15.1.0
sparc64               randconfig-001-20250719    gcc-9.5.0
sparc64               randconfig-002-20250719    gcc-9.5.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-21
um                               allyesconfig    gcc-12
um                    randconfig-001-20250719    clang-16
um                    randconfig-002-20250719    clang-21
x86_64                            allnoconfig    clang-20
x86_64      buildonly-randconfig-001-20250719    clang-20
x86_64      buildonly-randconfig-002-20250719    clang-20
x86_64      buildonly-randconfig-003-20250719    clang-20
x86_64      buildonly-randconfig-004-20250719    gcc-12
x86_64      buildonly-randconfig-005-20250719    clang-20
x86_64      buildonly-randconfig-006-20250719    gcc-12
x86_64                              defconfig    gcc-11
xtensa                            allnoconfig    gcc-15.1.0
xtensa                randconfig-001-20250719    gcc-14.3.0
xtensa                randconfig-002-20250719    gcc-8.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

