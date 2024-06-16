Return-Path: <linux-acpi+bounces-6434-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 09428909BE3
	for <lists+linux-acpi@lfdr.de>; Sun, 16 Jun 2024 08:19:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD13A1C20CFE
	for <lists+linux-acpi@lfdr.de>; Sun, 16 Jun 2024 06:19:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F4F8163AA7;
	Sun, 16 Jun 2024 06:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LbQIclfW"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3253DA48;
	Sun, 16 Jun 2024 06:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718518767; cv=none; b=lFv7VudRA60iv9LL6Ukt6Oex8WmaJ6doWgMqSXeaiTcfqwn8AiIpHQULUbYUt68PVGz4VJ381Zay5iRkrNQYKA8YyKADOj6XhkrC2netPisawkoGvRXAKqBPgRke3S0CcMh77qyMfvkFF62sg4LrxevtWE+SSHyxD9IxwGaipc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718518767; c=relaxed/simple;
	bh=eR334SinLzQ+m0ceSXxW/09Jr39c6Kunxp9mKOIQGDc=;
	h=Date:From:To:Cc:Subject:Message-ID; b=e35tpPryHpdKVZd3N2IoD43XyR9WKTg/I9zc6sJPVRkbGcgjKzbduCycRpI6IJzKnHjvDMWL/Zh4gt9ZwoC7AdsBHoSUq973I+EnGMhYDX5PwShp2dVhrbPgZCPDNHQHDTqLNNjWVXF2c+58wiE20iub5x82oKdTh/Sq1cjXHHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LbQIclfW; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718518765; x=1750054765;
  h=date:from:to:cc:subject:message-id;
  bh=eR334SinLzQ+m0ceSXxW/09Jr39c6Kunxp9mKOIQGDc=;
  b=LbQIclfW+BQPfTaqn1Kbrs+S0FmftVBFyYBsTaY+Wu3w7jxEvpZsAkXC
   emOg+Hwtospx7romp1EM26Spe8QI/wNamr6C1EGd/6Y45uqbwnb0Jlahn
   16A7OyOVPNa58IT/9TSXDTGy1gWn10KAXWmgvNyWv1bI4DiMcsvsOkZ3V
   DzebwVk9wSlyVRJjrQgAgm8kVY7mEW2mHARC8dSN8paCB6bGauJq/Nkcl
   hyuVfjHWGd4jUqXw/NcxQJvkdnu0/jPjUL66rLVRREEaCLpl/n7mwUuPQ
   Z2SachYo7YA6CyGbFmgkXrBua87e/sIqftgdK9AmFdeTKE/Ezq+xeozQ8
   Q==;
X-CSE-ConnectionGUID: EanBU8BnQfql5rPNTQ2jfA==
X-CSE-MsgGUID: C6iV6OGzTee8tqGxN0Vdyg==
X-IronPort-AV: E=McAfee;i="6700,10204,11104"; a="15244096"
X-IronPort-AV: E=Sophos;i="6.08,241,1712646000"; 
   d="scan'208";a="15244096"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2024 23:19:24 -0700
X-CSE-ConnectionGUID: ymagtvh2Ruy91KT42bZOwg==
X-CSE-MsgGUID: 174ftz48T4iRW8TjF775VQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,241,1712646000"; 
   d="scan'208";a="40772400"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by fmviesa006.fm.intel.com with ESMTP; 15 Jun 2024 23:19:23 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sIjEX-00014H-0m;
	Sun, 16 Jun 2024 06:19:21 +0000
Date: Sun, 16 Jun 2024 14:18:38 +0800
From: kernel test robot <lkp@intel.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-acpi@vger.kernel.org, devel@acpica.org,
 linux-pm@vger.kernel.org
Subject: [rafael-pm:bleeding-edge] BUILD SUCCESS
 77f816ac2ebc44cb23e4581d78933ee5dd2876b4
Message-ID: <202406161435.TFgAvZdH-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
branch HEAD: 77f816ac2ebc44cb23e4581d78933ee5dd2876b4  Merge branch 'thermal-core-fixes' into bleeding-edge

elapsed time: 2161m

configs tested: 99
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
arc                   randconfig-001-20240615   gcc-13.2.0
arc                   randconfig-002-20240615   gcc-13.2.0
arm                   randconfig-001-20240615   clang-19
arm                   randconfig-002-20240615   clang-19
arm                   randconfig-003-20240615   gcc-13.2.0
arm                   randconfig-004-20240615   gcc-13.2.0
arm64                 randconfig-001-20240615   clang-19
arm64                 randconfig-002-20240615   gcc-13.2.0
arm64                 randconfig-003-20240615   clang-17
arm64                 randconfig-004-20240615   gcc-13.2.0
csky                  randconfig-001-20240615   gcc-13.2.0
csky                  randconfig-002-20240615   gcc-13.2.0
hexagon               randconfig-001-20240615   clang-19
hexagon               randconfig-002-20240615   clang-19
i386         buildonly-randconfig-001-20240615   clang-18
i386         buildonly-randconfig-002-20240615   gcc-9
i386         buildonly-randconfig-003-20240615   gcc-7
i386         buildonly-randconfig-004-20240615   clang-18
i386         buildonly-randconfig-005-20240615   clang-18
i386         buildonly-randconfig-006-20240615   gcc-13
i386                  randconfig-001-20240615   clang-18
i386                  randconfig-002-20240615   gcc-13
i386                  randconfig-004-20240615   clang-18
i386                  randconfig-005-20240615   clang-18
i386                  randconfig-006-20240615   clang-18
i386                  randconfig-011-20240615   clang-18
i386                  randconfig-012-20240615   gcc-12
i386                  randconfig-013-20240615   gcc-13
i386                  randconfig-014-20240615   clang-18
i386                  randconfig-015-20240615   clang-18
i386                  randconfig-016-20240615   gcc-13
loongarch             randconfig-001-20240615   gcc-13.2.0
loongarch             randconfig-002-20240615   gcc-13.2.0
nios2                 randconfig-001-20240615   gcc-13.2.0
nios2                 randconfig-002-20240615   gcc-13.2.0
openrisc                          allnoconfig   gcc-13.2.0
openrisc                            defconfig   gcc-13.2.0
parisc                            allnoconfig   gcc-13.2.0
parisc                              defconfig   gcc-13.2.0
parisc                randconfig-001-20240615   gcc-13.2.0
parisc                randconfig-002-20240615   gcc-13.2.0
parisc64                            defconfig   gcc-13.2.0
powerpc                           allnoconfig   gcc-13.2.0
powerpc               randconfig-001-20240615   clang-19
powerpc               randconfig-002-20240615   clang-19
powerpc               randconfig-003-20240615   clang-19
powerpc64             randconfig-001-20240615   clang-19
powerpc64             randconfig-002-20240615   clang-19
powerpc64             randconfig-003-20240615   clang-19
riscv                             allnoconfig   gcc-13.2.0
riscv                               defconfig   clang-19
riscv                 randconfig-001-20240615   clang-19
riscv                 randconfig-002-20240615   gcc-13.2.0
s390                              allnoconfig   clang-19
s390                                defconfig   clang-19
s390                  randconfig-001-20240615   clang-16
s390                  randconfig-002-20240615   clang-19
sh                                allnoconfig   gcc-13.2.0
sh                                  defconfig   gcc-13.2.0
sh                    randconfig-001-20240615   gcc-13.2.0
sh                    randconfig-002-20240615   gcc-13.2.0
sparc                             allnoconfig   gcc-13.2.0
sparc                               defconfig   gcc-13.2.0
sparc64                             defconfig   gcc-13.2.0
sparc64               randconfig-001-20240615   gcc-13.2.0
sparc64               randconfig-002-20240615   gcc-13.2.0
um                                allnoconfig   clang-17
um                                  defconfig   clang-19
um                             i386_defconfig   gcc-13
um                    randconfig-001-20240615   gcc-7
um                    randconfig-002-20240615   gcc-11
um                           x86_64_defconfig   clang-15
x86_64       buildonly-randconfig-001-20240615   gcc-9
x86_64       buildonly-randconfig-002-20240615   clang-18
x86_64       buildonly-randconfig-003-20240615   clang-18
x86_64       buildonly-randconfig-004-20240615   clang-18
x86_64       buildonly-randconfig-005-20240615   gcc-9
x86_64       buildonly-randconfig-006-20240615   clang-18
x86_64                randconfig-001-20240615   gcc-13
x86_64                randconfig-002-20240615   gcc-8
x86_64                randconfig-003-20240615   gcc-13
x86_64                randconfig-004-20240615   gcc-13
x86_64                randconfig-005-20240615   gcc-13
x86_64                randconfig-006-20240615   gcc-8
x86_64                randconfig-011-20240615   clang-18
x86_64                randconfig-012-20240615   gcc-13
x86_64                randconfig-013-20240615   clang-18
x86_64                randconfig-014-20240615   clang-18
x86_64                randconfig-015-20240615   clang-18
x86_64                randconfig-016-20240615   clang-18
x86_64                randconfig-071-20240615   clang-18
x86_64                randconfig-072-20240615   clang-18
x86_64                randconfig-073-20240615   gcc-7
x86_64                randconfig-074-20240615   gcc-13
x86_64                randconfig-075-20240615   clang-18
x86_64                randconfig-076-20240615   gcc-13
xtensa                            allnoconfig   gcc-13.2.0
xtensa                randconfig-001-20240615   gcc-13.2.0
xtensa                randconfig-002-20240615   gcc-13.2.0

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

