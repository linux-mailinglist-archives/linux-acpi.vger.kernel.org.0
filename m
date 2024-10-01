Return-Path: <linux-acpi+bounces-8507-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C9C298BBC9
	for <lists+linux-acpi@lfdr.de>; Tue,  1 Oct 2024 14:07:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D547F282978
	for <lists+linux-acpi@lfdr.de>; Tue,  1 Oct 2024 12:07:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3D031BFDF8;
	Tue,  1 Oct 2024 12:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Vo4Qo/QH"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 022C41A0AEA;
	Tue,  1 Oct 2024 12:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727784437; cv=none; b=hsbVM/86n13/PssLU1z5wyCpKaSEetUAPiZ8XSwqrdOHCDlp71GCHnbVZ8ekjBdVAQw0Ih//fxpxVZcqwDJBWi6uNQMPsl3H4gqReihKpO7yNHQJdFjbmTpe6XcQ4IzQH0aNTk6Kc+SPB5zTdFnOMFfCihg/1Xt/uU2lZk4lAhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727784437; c=relaxed/simple;
	bh=m32IPg1F64LrJlPTaN8VpNoGb6ayweBEY3UPjNhYuQo=;
	h=Date:From:To:Cc:Subject:Message-ID; b=crsctZ22fBsH9H+LATm0PJvf8/WVx+AqTlPpZAwRWwwnGx71Klk3VAeOzLieArZKyPv2KafHNXjKTV+Eohkd5yQKXTAO2Q4jevJe+jZYK7rHGi8tWiV/RqOuKSV2QzwVBF34EiFOxrNIzQ/QJ65h3BJq7kdKq9nygSYvetXGnV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Vo4Qo/QH; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727784436; x=1759320436;
  h=date:from:to:cc:subject:message-id;
  bh=m32IPg1F64LrJlPTaN8VpNoGb6ayweBEY3UPjNhYuQo=;
  b=Vo4Qo/QHa59oQMwVts/Foorwv85wS0eKUQ4jmrAr83GyJvh6mwmMe/wi
   mTHPkh169WisBdYwodRtjCcP6cNJzJk+YTZk/1BN+hVLToUkB2r9KSbxp
   BjigvX4acf/meis93S56RQZlp82Pp8s+sq8rOFgmIPyd96qCBhReEeSSZ
   N+/t6UewduFQIgzYLDUkDF1+lvIxJwtxS1razVcTVgeLYucMUqmge00/T
   Re8jUNBzHp1Hr8UZs+co5RME6U7iA4uX3uTo4ip73mKHOPlNtEz2YOzSp
   0CuAnE8oeWo9xx5j2jdrn9XP2+7Kk55yZA0E9/lJ2GpNlSqVllEJDz+sx
   g==;
X-CSE-ConnectionGUID: L8yOkSNfSjOMKod1efbTZQ==
X-CSE-MsgGUID: zuVz81V7S56Ibovm5uJSog==
X-IronPort-AV: E=McAfee;i="6700,10204,11212"; a="26869675"
X-IronPort-AV: E=Sophos;i="6.11,167,1725346800"; 
   d="scan'208";a="26869675"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2024 05:07:16 -0700
X-CSE-ConnectionGUID: ER0Gl+ZrTuSU3jX3uPTOUQ==
X-CSE-MsgGUID: jXaMUJJXT9OKNqEXQ+RBqQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,167,1725346800"; 
   d="scan'208";a="73898875"
Received: from lkp-server01.sh.intel.com (HELO 53e96f405c61) ([10.239.97.150])
  by orviesa006.jf.intel.com with ESMTP; 01 Oct 2024 05:07:14 -0700
Received: from kbuild by 53e96f405c61 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1svbep-000Qej-2L;
	Tue, 01 Oct 2024 12:07:11 +0000
Date: Tue, 01 Oct 2024 20:06:43 +0800
From: kernel test robot <lkp@intel.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-acpi@vger.kernel.org, devel@acpica.org,
 linux-pm@vger.kernel.org
Subject: [rafael-pm:bleeding-edge] BUILD SUCCESS
 5d00f37f89de7067d67e60d2d148e43a7860f067
Message-ID: <202410012037.iYgwvZq2-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
branch HEAD: 5d00f37f89de7067d67e60d2d148e43a7860f067  Merge branch 'acpi-resource' into bleeding-edge

elapsed time: 1022m

configs tested: 103
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                       allnoconfig    gcc-14.1.0
alpha                      allyesconfig    clang-20
alpha                         defconfig    gcc-14.1.0
arc                        allmodconfig    clang-20
arc                         allnoconfig    gcc-14.1.0
arc                        allyesconfig    clang-20
arc                    axs103_defconfig    gcc-14.1.0
arc                           defconfig    gcc-14.1.0
arm                        allmodconfig    clang-20
arm                         allnoconfig    gcc-14.1.0
arm                        allyesconfig    clang-20
arm                    collie_defconfig    gcc-14.1.0
arm               davinci_all_defconfig    gcc-14.1.0
arm                           defconfig    gcc-14.1.0
arm                   lpc18xx_defconfig    gcc-14.1.0
arm                 versatile_defconfig    gcc-14.1.0
arm64                      allmodconfig    clang-20
arm64                       allnoconfig    gcc-14.1.0
arm64                         defconfig    gcc-14.1.0
csky                        allnoconfig    gcc-14.1.0
csky                          defconfig    gcc-14.1.0
hexagon                    allmodconfig    clang-20
hexagon                     allnoconfig    gcc-14.1.0
hexagon                    allyesconfig    clang-20
hexagon                       defconfig    gcc-14.1.0
i386                       allmodconfig    clang-18
i386                        allnoconfig    clang-18
i386                       allyesconfig    clang-18
i386                          defconfig    clang-18
loongarch                  allmodconfig    gcc-14.1.0
loongarch                   allnoconfig    gcc-14.1.0
loongarch                     defconfig    gcc-14.1.0
m68k                       allmodconfig    gcc-14.1.0
m68k                        allnoconfig    gcc-14.1.0
m68k                       allyesconfig    gcc-14.1.0
m68k                          defconfig    gcc-14.1.0
microblaze                 allmodconfig    gcc-14.1.0
microblaze                  allnoconfig    gcc-14.1.0
microblaze                 allyesconfig    gcc-14.1.0
microblaze                    defconfig    gcc-14.1.0
mips                        allnoconfig    gcc-14.1.0
mips                   db1xxx_defconfig    gcc-14.1.0
mips                     rs90_defconfig    gcc-14.1.0
nios2                       allnoconfig    gcc-14.1.0
nios2                         defconfig    gcc-14.1.0
openrisc                    allnoconfig    clang-20
openrisc                    allnoconfig    gcc-14.1.0
openrisc                   allyesconfig    gcc-14.1.0
openrisc                      defconfig    gcc-12
openrisc            or1klitex_defconfig    gcc-14.1.0
parisc                     allmodconfig    gcc-14.1.0
parisc                      allnoconfig    clang-20
parisc                      allnoconfig    gcc-14.1.0
parisc                     allyesconfig    gcc-14.1.0
parisc                        defconfig    gcc-12
parisc64                      defconfig    gcc-14.1.0
powerpc                    allmodconfig    gcc-14.1.0
powerpc                     allnoconfig    clang-20
powerpc                     allnoconfig    gcc-14.1.0
powerpc                    allyesconfig    clang-20
powerpc                    allyesconfig    gcc-14.1.0
powerpc           canyonlands_defconfig    gcc-14.1.0
powerpc                  cell_defconfig    gcc-14.1.0
powerpc                  fsp2_defconfig    gcc-14.1.0
powerpc         mpc834x_itxgp_defconfig    gcc-14.1.0
powerpc                   wii_defconfig    gcc-14.1.0
riscv                      allmodconfig    clang-20
riscv                      allmodconfig    gcc-14.1.0
riscv                       allnoconfig    clang-20
riscv                       allnoconfig    gcc-14.1.0
riscv                      allyesconfig    clang-20
riscv                      allyesconfig    gcc-14.1.0
riscv                         defconfig    gcc-12
s390                       allmodconfig    clang-20
s390                       allmodconfig    gcc-14.1.0
s390                        allnoconfig    clang-20
s390                       allyesconfig    gcc-14.1.0
s390                          defconfig    gcc-12
sh                         alldefconfig    gcc-14.1.0
sh                         allmodconfig    gcc-14.1.0
sh                          allnoconfig    gcc-14.1.0
sh                         allyesconfig    gcc-14.1.0
sh                            defconfig    gcc-12
sh          ecovec24-romimage_defconfig    gcc-14.1.0
sh                      titan_defconfig    gcc-14.1.0
sh                        ul2_defconfig    gcc-14.1.0
sparc                      allmodconfig    gcc-14.1.0
sparc64                       defconfig    gcc-12
um                         allmodconfig    clang-20
um                          allnoconfig    clang-17
um                          allnoconfig    clang-20
um                         allyesconfig    clang-20
um                            defconfig    gcc-12
um                       i386_defconfig    gcc-12
um                     x86_64_defconfig    gcc-12
x86_64                      allnoconfig    clang-18
x86_64                     allyesconfig    clang-18
x86_64                        defconfig    clang-18
x86_64                            kexec    clang-18
x86_64                            kexec    gcc-12
x86_64                         rhel-8.3    gcc-12
x86_64                    rhel-8.3-rust    clang-18
xtensa                      allnoconfig    gcc-14.1.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

