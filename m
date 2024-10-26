Return-Path: <linux-acpi+bounces-9010-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5248E9B1908
	for <lists+linux-acpi@lfdr.de>; Sat, 26 Oct 2024 17:17:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ACB26B2184B
	for <lists+linux-acpi@lfdr.de>; Sat, 26 Oct 2024 15:17:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 260BA225D9;
	Sat, 26 Oct 2024 15:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ALsw0TsX"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D9FC12E7F;
	Sat, 26 Oct 2024 15:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729955832; cv=none; b=XWvfuaGpYIKjBsYQn6dIonkQGpTMvKOrSisdZizVzdkBeVeOdWs2Du+37tDkhknfT5uSjsGNXEHXEgHhAH/LhwG61ktHqKtN7xoIZO6pcqVqAMDhEnOGHgAkGzA0AraCDzbU5brI9o6MsX0R0mjFND2kWkTdUZK6qnoAmnZqloE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729955832; c=relaxed/simple;
	bh=wNhHnodCWw2pwdQdDPQLkZ+wwFdyLP0ewG6lRLXxLuA=;
	h=Date:From:To:Cc:Subject:Message-ID; b=NLQw4F/XZy/vzLV9dbcM/9RasacKwRMvpL6IH8HbqWhL1cOJnym/r77a1qrRJiTb3lwKwvLEVm3i/XN3+9w9TDCwob7ZPExgT3GlPtKoGeBSQFbxEr9x4G2aMwcNpmU4vbFJdy2M15gH6UVH3127Okm/0XhXm3TARKSRORZx8b4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ALsw0TsX; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729955829; x=1761491829;
  h=date:from:to:cc:subject:message-id;
  bh=wNhHnodCWw2pwdQdDPQLkZ+wwFdyLP0ewG6lRLXxLuA=;
  b=ALsw0TsXhAsjRxhQuCa8DN5md4wPuRpwF9Z8zTFrbdHb95tMQT7ht1+A
   I4GQqezzZHnHPuQT5icB1c5y4X4zuemTPXI7844FWOVvO/q4BKbQ6FArl
   4r0hNUVuBJqQ1/KFNR1gI40u4wGyiAf6j8sMIEyRH2N99DPdTI99/Sfb9
   YYmkNGgZ/W8qxrfQFQRFC0ADw3hu9BP+5P1E7yKKLUkjZz2GViTH7y/bN
   usXf0rA3WvXsGeqA8i2sYhvauq1PehGdCXI5jlLSX6i/p7yv2eRTff59i
   foCSXJYArvt+p3sOCO9i5wWcwdMQ6zn7GIery/Oe61bxRH+9eIGvsuH4i
   Q==;
X-CSE-ConnectionGUID: sjyCoiy8QAaNwUxAzPM/RQ==
X-CSE-MsgGUID: 5wdse4JsTF2LmovMtffHZQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11237"; a="29714696"
X-IronPort-AV: E=Sophos;i="6.11,235,1725346800"; 
   d="scan'208";a="29714696"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2024 08:17:09 -0700
X-CSE-ConnectionGUID: lqmm6JYMQhGR16QurATbFQ==
X-CSE-MsgGUID: ElVIpgEYTguXioaTqp+XtQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,235,1725346800"; 
   d="scan'208";a="81656320"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by orviesa007.jf.intel.com with ESMTP; 26 Oct 2024 08:17:08 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t4iXJ-000ZlS-14;
	Sat, 26 Oct 2024 15:17:05 +0000
Date: Sat, 26 Oct 2024 23:16:40 +0800
From: kernel test robot <lkp@intel.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-acpi@vger.kernel.org, devel@acpica.org,
 linux-pm@vger.kernel.org
Subject: [rafael-pm:bleeding-edge] BUILD SUCCESS
 2b3b38c2c5409c57da4e4899070053ddbc88e51b
Message-ID: <202410262332.bmfh1zxF-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
branch HEAD: 2b3b38c2c5409c57da4e4899070053ddbc88e51b  Merge branch 'thermal/bleeding-edge' of ssh://gitolite.kernel.org/pub/scm/linux/kernel/git/thermal/linux into bleeding-edge

elapsed time: 1659m

configs tested: 108
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.1.0
alpha                            allyesconfig    gcc-13.3.0
arc                               allnoconfig    gcc-14.1.0
arc                   randconfig-001-20241026    gcc-13.2.0
arc                   randconfig-002-20241026    gcc-13.2.0
arm                               allnoconfig    gcc-14.1.0
arm                   randconfig-001-20241026    gcc-14.1.0
arm                   randconfig-002-20241026    clang-20
arm                   randconfig-003-20241026    gcc-14.1.0
arm                   randconfig-004-20241026    gcc-14.1.0
arm64                             allnoconfig    gcc-14.1.0
arm64                 randconfig-001-20241026    gcc-14.1.0
arm64                 randconfig-002-20241026    clang-20
arm64                 randconfig-003-20241026    clang-20
arm64                 randconfig-004-20241026    gcc-14.1.0
csky                              allnoconfig    gcc-14.1.0
csky                  randconfig-001-20241026    gcc-14.1.0
csky                  randconfig-002-20241026    gcc-14.1.0
hexagon                          allmodconfig    clang-20
hexagon                           allnoconfig    gcc-14.1.0
hexagon                          allyesconfig    clang-20
hexagon               randconfig-001-20241026    clang-20
hexagon               randconfig-002-20241026    clang-17
i386                             allmodconfig    clang-19
i386                             allmodconfig    gcc-12
i386                              allnoconfig    clang-19
i386                              allnoconfig    gcc-12
i386                             allyesconfig    clang-19
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20241026    clang-19
i386        buildonly-randconfig-002-20241026    clang-19
i386        buildonly-randconfig-003-20241026    gcc-12
i386        buildonly-randconfig-004-20241026    clang-19
i386        buildonly-randconfig-005-20241026    gcc-12
i386        buildonly-randconfig-006-20241026    clang-19
i386                                defconfig    clang-19
i386                  randconfig-001-20241026    clang-19
i386                  randconfig-002-20241026    clang-19
i386                  randconfig-003-20241026    clang-19
i386                  randconfig-004-20241026    gcc-12
i386                  randconfig-005-20241026    clang-19
i386                  randconfig-006-20241026    clang-19
i386                  randconfig-011-20241026    gcc-12
loongarch                        allmodconfig    gcc-14.1.0
loongarch                         allnoconfig    gcc-14.1.0
loongarch             randconfig-001-20241026    gcc-14.1.0
loongarch             randconfig-002-20241026    gcc-14.1.0
m68k                             allmodconfig    gcc-14.1.0
m68k                              allnoconfig    gcc-14.1.0
m68k                             allyesconfig    gcc-14.1.0
microblaze                        allnoconfig    gcc-14.1.0
mips                              allnoconfig    gcc-14.1.0
nios2                             allnoconfig    gcc-14.1.0
nios2                 randconfig-001-20241026    gcc-14.1.0
nios2                 randconfig-002-20241026    gcc-14.1.0
openrisc                          allnoconfig    clang-20
openrisc                          allnoconfig    gcc-14.1.0
openrisc                            defconfig    gcc-12
parisc                            allnoconfig    clang-20
parisc                            allnoconfig    gcc-14.1.0
parisc                              defconfig    gcc-12
parisc                randconfig-001-20241026    gcc-14.1.0
parisc                randconfig-002-20241026    gcc-14.1.0
powerpc                           allnoconfig    clang-20
powerpc                           allnoconfig    gcc-14.1.0
powerpc               randconfig-001-20241026    gcc-14.1.0
powerpc               randconfig-002-20241026    gcc-14.1.0
powerpc               randconfig-003-20241026    clang-20
powerpc64             randconfig-001-20241026    clang-20
powerpc64             randconfig-002-20241026    clang-20
powerpc64             randconfig-003-20241026    gcc-14.1.0
riscv                             allnoconfig    clang-20
riscv                             allnoconfig    gcc-14.1.0
riscv                               defconfig    gcc-12
riscv                 randconfig-001-20241026    gcc-14.1.0
riscv                 randconfig-002-20241026    clang-20
s390                             allmodconfig    clang-20
s390                              allnoconfig    clang-20
s390                             allyesconfig    gcc-14.1.0
s390                                defconfig    gcc-12
s390                  randconfig-001-20241026    gcc-14.1.0
s390                  randconfig-002-20241026    gcc-14.1.0
sh                               allmodconfig    gcc-14.1.0
sh                                allnoconfig    gcc-14.1.0
sh                               allyesconfig    gcc-14.1.0
sh                                  defconfig    gcc-12
sh                    randconfig-001-20241026    gcc-14.1.0
sh                    randconfig-002-20241026    gcc-14.1.0
sparc                            allmodconfig    gcc-14.1.0
sparc64                             defconfig    gcc-12
sparc64               randconfig-001-20241026    gcc-14.1.0
sparc64               randconfig-002-20241026    gcc-14.1.0
um                                allnoconfig    clang-17
um                                allnoconfig    clang-20
um                                  defconfig    gcc-12
um                             i386_defconfig    gcc-12
um                    randconfig-001-20241026    clang-20
um                    randconfig-002-20241026    clang-20
um                           x86_64_defconfig    gcc-12
x86_64                            allnoconfig    clang-19
x86_64                           allyesconfig    clang-19
x86_64                              defconfig    clang-19
x86_64                              defconfig    gcc-11
x86_64                                  kexec    clang-19
x86_64                               rhel-8.3    gcc-12
xtensa                            allnoconfig    gcc-14.1.0
xtensa                randconfig-001-20241026    gcc-14.1.0
xtensa                randconfig-002-20241026    gcc-14.1.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

