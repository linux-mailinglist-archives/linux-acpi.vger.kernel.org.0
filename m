Return-Path: <linux-acpi+bounces-18504-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 231BCC32496
	for <lists+linux-acpi@lfdr.de>; Tue, 04 Nov 2025 18:19:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C6A2D4FB352
	for <lists+linux-acpi@lfdr.de>; Tue,  4 Nov 2025 17:13:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CCE63321DF;
	Tue,  4 Nov 2025 17:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="at8hMaJ/"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAFF3242D88;
	Tue,  4 Nov 2025 17:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762276391; cv=none; b=A9QOLep34O4WUMF3zy4DJ/gRSUvQWR/u4fzPy+fc4ESY+llZxTFulQGH+aF6t2qSNPFnXpUNPV6WmJ1Z/s2Rk4IXoVHSNhGm4oqyt2Iaf84bLcvXVwHqy0FA/jsKtrE4qen8p9LkE8Jn1uj7qaLE6Ckq5zGZdMh3+yU5W4v7XQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762276391; c=relaxed/simple;
	bh=S841mmLnQytJ8nDk6uNbUR9iM5uGSyOjCtvhqiNk+Wg=;
	h=Date:From:To:Cc:Subject:Message-ID; b=GhF+FCLayEEYDrvwXXFbD2aj3LHVEzr5EhYIdz09J3F/6fqx9VPSavaJPVtaFfG4ZGyd8JuUg49LcjamFAId7nUhrd7txtNdjrsBDAqeSj+EWcIaFZr3P9KfrZpKk67Tl3sc0oAyuBqoUpRczgCU/6ZGOUEnCBJ5Vjd0Hv2+76Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=at8hMaJ/; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762276389; x=1793812389;
  h=date:from:to:cc:subject:message-id;
  bh=S841mmLnQytJ8nDk6uNbUR9iM5uGSyOjCtvhqiNk+Wg=;
  b=at8hMaJ/xLOj9HUZrj35LZomEVdC5QTHoCk9RJbQBJGTJysyyrRZT/zV
   HdQURgMoCwHUy6QyKEXJ/nkTCMhYQTMi2TRb19waUkNL9sEzHNyhovf0/
   D3a/yH5/Y9wpQ+cwWlp/JlzbOGndfaI+cA2Gafqvv7iNETtrFCF5DoLPj
   soNgJR/9wZ6d5Le1pId41vXj8DAjZRQLNIzoUnIJCQKz5+IdijTGeUi8P
   7gXdJdZzMYbKm0+kGGFlSFUQmR0DZ7hyIZEDueGUcLSuO9Ifx+0zDe6FP
   YWDxSGWK9/gkGqTnzCwlMuC+0X364ReZ2MDcPsbZB+/1gt0HeDM1aUaS3
   Q==;
X-CSE-ConnectionGUID: i1loLnzlSYecWPOSs3PCaA==
X-CSE-MsgGUID: W7MVefAASfqLkcEhorgHnQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11603"; a="64409924"
X-IronPort-AV: E=Sophos;i="6.19,279,1754982000"; 
   d="scan'208";a="64409924"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2025 09:13:09 -0800
X-CSE-ConnectionGUID: hWQyivGhTniT5r/OfcmEOQ==
X-CSE-MsgGUID: SMvY5hFiTribPHvh4zSabg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,279,1754982000"; 
   d="scan'208";a="187941580"
Received: from lkp-server02.sh.intel.com (HELO 66d7546c76b2) ([10.239.97.151])
  by fmviesa010.fm.intel.com with ESMTP; 04 Nov 2025 09:13:07 -0800
Received: from kbuild by 66d7546c76b2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vGKaf-000ReZ-31;
	Tue, 04 Nov 2025 17:13:05 +0000
Date: Wed, 05 Nov 2025 01:05:05 +0800
From: kernel test robot <lkp@intel.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org
Subject: [rafael-pm:fixes] BUILD SUCCESS
 5de462be3b18753075122505f543bc68f4968270
Message-ID: <202511050100.eREjeCwJ-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git fixes
branch HEAD: 5de462be3b18753075122505f543bc68f4968270  Merge branches 'acpi-docs', 'acpi-cppc' and 'acpi-sbs' into fixes

elapsed time: 1459m

configs tested: 101
configs skipped: 1

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.1.0
arc                               allnoconfig    gcc-15.1.0
arc                   randconfig-001-20251104    gcc-12.5.0
arc                   randconfig-002-20251104    gcc-9.5.0
arm                               allnoconfig    clang-22
arm                   randconfig-001-20251104    gcc-14.3.0
arm                   randconfig-002-20251104    gcc-10.5.0
arm                   randconfig-003-20251104    clang-22
arm                   randconfig-004-20251104    gcc-8.5.0
arm64                             allnoconfig    gcc-15.1.0
arm64                            allyesconfig    gcc-15.1.0
csky                             allmodconfig    gcc-15.1.0
csky                              allnoconfig    gcc-15.1.0
csky                             allyesconfig    gcc-15.1.0
hexagon                           allnoconfig    clang-22
hexagon               randconfig-001-20251104    clang-22
hexagon               randconfig-002-20251104    clang-16
i386                              allnoconfig    gcc-14
i386        buildonly-randconfig-001-20251104    gcc-14
i386        buildonly-randconfig-002-20251104    clang-20
i386        buildonly-randconfig-003-20251104    gcc-12
i386        buildonly-randconfig-004-20251104    gcc-14
i386        buildonly-randconfig-005-20251104    gcc-12
i386        buildonly-randconfig-006-20251104    gcc-14
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-22
loongarch                        allyesconfig    gcc-15.1.0
loongarch             randconfig-001-20251104    gcc-15.1.0
loongarch             randconfig-002-20251104    clang-22
m68k                             allmodconfig    clang-19
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    clang-19
microblaze                       allmodconfig    clang-19
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    clang-19
mips                             allmodconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
mips                             allyesconfig    gcc-15.1.0
nios2                            allmodconfig    clang-22
nios2                             allnoconfig    gcc-11.5.0
nios2                            allyesconfig    clang-22
nios2                 randconfig-001-20251104    gcc-8.5.0
nios2                 randconfig-002-20251104    gcc-11.5.0
openrisc                         allmodconfig    clang-22
openrisc                          allnoconfig    gcc-15.1.0
openrisc                         allyesconfig    gcc-15.1.0
parisc                           allmodconfig    gcc-15.1.0
parisc                            allnoconfig    gcc-15.1.0
parisc                           allyesconfig    gcc-15.1.0
parisc                randconfig-001-20251104    gcc-8.5.0
parisc                randconfig-002-20251104    gcc-15.1.0
powerpc                          allmodconfig    gcc-15.1.0
powerpc                           allnoconfig    gcc-15.1.0
powerpc                          allyesconfig    gcc-15.1.0
powerpc               randconfig-001-20251104    gcc-15.1.0
powerpc               randconfig-002-20251104    clang-22
powerpc64             randconfig-001-20251104    clang-22
riscv                            allmodconfig    gcc-15.1.0
riscv                             allnoconfig    gcc-15.1.0
riscv                            allyesconfig    gcc-15.1.0
riscv                 randconfig-002-20251104    gcc-8.5.0
s390                             allmodconfig    gcc-15.1.0
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.1.0
s390                  randconfig-001-20251104    clang-22
s390                  randconfig-002-20251104    clang-22
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                                  defconfig    gcc-15.1.0
sh                    randconfig-001-20251104    gcc-13.4.0
sh                    randconfig-002-20251104    gcc-11.5.0
sparc                            allmodconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                            allyesconfig    clang-22
sparc                 randconfig-001-20251104    gcc-13.4.0
sparc                 randconfig-002-20251104    gcc-12.5.0
sparc64                          allmodconfig    clang-22
sparc64                          allyesconfig    clang-22
sparc64                             defconfig    clang-20
sparc64               randconfig-001-20251104    gcc-8.5.0
sparc64               randconfig-002-20251104    clang-22
um                                allnoconfig    clang-22
um                                  defconfig    clang-22
um                             i386_defconfig    gcc-14
um                    randconfig-001-20251104    clang-22
um                    randconfig-002-20251104    clang-22
um                           x86_64_defconfig    clang-22
x86_64                            allnoconfig    clang-20
x86_64                              defconfig    gcc-14
x86_64                                  kexec    clang-20
x86_64                               rhel-9.4    clang-20
x86_64                           rhel-9.4-bpf    gcc-14
x86_64                          rhel-9.4-func    clang-20
x86_64                    rhel-9.4-kselftests    clang-20
x86_64                         rhel-9.4-kunit    gcc-14
x86_64                           rhel-9.4-ltp    gcc-14
xtensa                            allnoconfig    gcc-15.1.0
xtensa                           allyesconfig    clang-22
xtensa                randconfig-001-20251104    gcc-13.4.0
xtensa                randconfig-002-20251104    gcc-11.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

