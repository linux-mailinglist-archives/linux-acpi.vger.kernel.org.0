Return-Path: <linux-acpi+bounces-21283-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mC2kJ7HBo2lSLwUAu9opvQ
	(envelope-from <linux-acpi+bounces-21283-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Sun, 01 Mar 2026 05:33:53 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CEE781CE847
	for <lists+linux-acpi@lfdr.de>; Sun, 01 Mar 2026 05:33:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 66868300C03F
	for <lists+linux-acpi@lfdr.de>; Sun,  1 Mar 2026 04:33:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81465308F07;
	Sun,  1 Mar 2026 04:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kYH2HNl3"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC00E1F09A5;
	Sun,  1 Mar 2026 04:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772339628; cv=none; b=hXff8ogRLIF1sKTf1DIPl54MnUjFyjb3jQE6xmJF131ESS13ggO4kf6OxzqcuZLi72Fj2/kzHO4TXf5VtbB98DXIp5aKN3YbqmtaZk7mo9yvdLUk9h9sIQplFK+MU6h9DgCTMEGK7eHB5D6vQmdrx1+jzfauLs+tojsLddIcUkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772339628; c=relaxed/simple;
	bh=b+BTQ1t/wN6cDUN+c7thBS95ZO9nwEHKGCTIhFrVjfE=;
	h=Date:From:To:Cc:Subject:Message-ID; b=suqFj34JEztCZ+Od3j+G+OOAaGh//qMhE4w1SEsgMnYOFN9I0OEJXmEht8MoNh0O+pHH62wzlAI4biS6QlJI/qnJ8/feE18eEGyFZuXcAbLwTZ7XgLF43Jq8KU6Kyg6O2XzQ7b6G5rU0+T+NfKheks1m2WarCkKbQ0Um8rhmOyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kYH2HNl3; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772339625; x=1803875625;
  h=date:from:to:cc:subject:message-id;
  bh=b+BTQ1t/wN6cDUN+c7thBS95ZO9nwEHKGCTIhFrVjfE=;
  b=kYH2HNl3lOQU7FhTo58o3ScFeQvBw4ijsiBeyZrBr8MoY+S3uZkBWho+
   kh8siXGtfU5q5n7zahmYoMBeF4xv6y+SW5Jyzyvxez4yo8EIIXixblwyY
   zOQokNQpWmk10xJTRIWSFb03nRXG8Dz2CkjIGyDPbLlT+4X97AKppaCzD
   RjOSZa9ehzkSwc8EajZSHvU19iEdHlCyJpT/6DmdMrl9ncilCdUuRWvQV
   RoO5zE///kFQ3mSYa9vIQ+lWKXgSJ9UnSg2JD2bgPcPTZd5DJ15J+hb4B
   tcjx83qddbGAWucOlW8eSinZBGzCuXpSHwAca1zd53TLDThkQeN8p8oiD
   A==;
X-CSE-ConnectionGUID: J0QNQW16TRKL0CP/DsYJ+A==
X-CSE-MsgGUID: HyayYW8CSGm/MubYWK9HOQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11715"; a="73567647"
X-IronPort-AV: E=Sophos;i="6.21,317,1763452800"; 
   d="scan'208";a="73567647"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2026 20:33:44 -0800
X-CSE-ConnectionGUID: xJn6Y+o2TQS+TiOK0g2m/w==
X-CSE-MsgGUID: ddrHTVqbQYeep+vjgoNrKQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,317,1763452800"; 
   d="scan'208";a="221918918"
Received: from lkp-server01.sh.intel.com (HELO 59784f1c7b2a) ([10.239.97.150])
  by fmviesa005.fm.intel.com with ESMTP; 28 Feb 2026 20:33:42 -0800
Received: from kbuild by 59784f1c7b2a with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vwYUt-000000001H9-3Wrc;
	Sun, 01 Mar 2026 04:33:39 +0000
Date: Sun, 01 Mar 2026 12:32:43 +0800
From: kernel test robot <lkp@intel.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org
Subject: [rafael-pm:bleeding-edge] BUILD SUCCESS
 55ef3af54b8a3841abba68b2d7f3a6253bbf0f64
Message-ID: <202603011235.gRSYojcK-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[intel.com:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21283-lists,linux-acpi=lfdr.de];
	RCPT_COUNT_THREE(0.00)[3];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lkp@intel.com,linux-acpi@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-acpi];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:mid,intel.com:dkim]
X-Rspamd-Queue-Id: CEE781CE847
X-Rspamd-Action: no action

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
branch HEAD: 55ef3af54b8a3841abba68b2d7f3a6253bbf0f64  Merge branch 'experimental/acpi-driver-conversion' into bleeding-edge

elapsed time: 755m

configs tested: 255
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            alldefconfig    gcc-15.2.0
alpha                             allnoconfig    gcc-15.2.0
alpha                            allyesconfig    gcc-15.2.0
alpha                               defconfig    gcc-15.2.0
arc                              allmodconfig    clang-16
arc                              allmodconfig    gcc-15.2.0
arc                               allnoconfig    gcc-15.2.0
arc                              allyesconfig    clang-23
arc                          axs101_defconfig    clang-23
arc                                 defconfig    gcc-15.2.0
arc                        nsim_700_defconfig    gcc-15.2.0
arc                   randconfig-001-20260301    clang-23
arc                   randconfig-002-20260301    clang-23
arm                               allnoconfig    gcc-15.2.0
arm                              allyesconfig    clang-16
arm                              allyesconfig    gcc-15.2.0
arm                         bcm2835_defconfig    clang-23
arm                                 defconfig    gcc-15.2.0
arm                            hisi_defconfig    clang-23
arm                      jornada720_defconfig    clang-23
arm                   milbeaut_m10v_defconfig    gcc-15.2.0
arm                       multi_v4t_defconfig    clang-23
arm                       multi_v4t_defconfig    gcc-15.2.0
arm                        multi_v7_defconfig    clang-23
arm                        mvebu_v7_defconfig    gcc-15.2.0
arm                         nhk8815_defconfig    clang-23
arm                          pxa910_defconfig    clang-23
arm                            qcom_defconfig    clang-23
arm                   randconfig-001-20260301    clang-23
arm                   randconfig-002-20260301    clang-23
arm                   randconfig-003-20260301    clang-23
arm                   randconfig-004-20260301    clang-23
arm                        spear6xx_defconfig    gcc-15.2.0
arm                           stm32_defconfig    clang-23
arm                         vf610m4_defconfig    gcc-15.2.0
arm                    vt8500_v6_v7_defconfig    clang-23
arm                    vt8500_v6_v7_defconfig    gcc-15.2.0
arm64                            allmodconfig    clang-23
arm64                             allnoconfig    gcc-15.2.0
arm64                               defconfig    gcc-15.2.0
arm64                 randconfig-001-20260301    clang-16
arm64                 randconfig-001-20260301    gcc-9.5.0
arm64                 randconfig-002-20260301    gcc-10.5.0
arm64                 randconfig-002-20260301    gcc-9.5.0
arm64                 randconfig-003-20260301    clang-18
arm64                 randconfig-003-20260301    gcc-9.5.0
arm64                 randconfig-004-20260301    gcc-9.5.0
csky                             allmodconfig    gcc-15.2.0
csky                              allnoconfig    gcc-15.2.0
csky                                defconfig    gcc-15.2.0
csky                  randconfig-001-20260301    gcc-14.3.0
csky                  randconfig-001-20260301    gcc-9.5.0
csky                  randconfig-002-20260301    gcc-15.2.0
csky                  randconfig-002-20260301    gcc-9.5.0
hexagon                          allmodconfig    clang-17
hexagon                          allmodconfig    gcc-15.2.0
hexagon                           allnoconfig    gcc-15.2.0
hexagon                             defconfig    gcc-15.2.0
hexagon               randconfig-001-20260301    clang-18
hexagon               randconfig-001-20260301    clang-23
hexagon               randconfig-002-20260301    clang-18
hexagon               randconfig-002-20260301    clang-23
i386                             alldefconfig    clang-23
i386                             allmodconfig    clang-20
i386                              allnoconfig    gcc-15.2.0
i386                             allyesconfig    clang-20
i386                             allyesconfig    gcc-14
i386        buildonly-randconfig-001-20260301    gcc-14
i386        buildonly-randconfig-002-20260301    gcc-14
i386        buildonly-randconfig-003-20260301    gcc-14
i386        buildonly-randconfig-004-20260301    gcc-14
i386        buildonly-randconfig-005-20260301    gcc-14
i386        buildonly-randconfig-006-20260301    gcc-14
i386                                defconfig    gcc-15.2.0
i386                  randconfig-001-20260301    gcc-14
i386                  randconfig-002-20260301    gcc-14
i386                  randconfig-003-20260301    gcc-14
i386                  randconfig-004-20260301    gcc-14
i386                  randconfig-005-20260301    gcc-14
i386                  randconfig-006-20260301    gcc-12
i386                  randconfig-006-20260301    gcc-14
i386                  randconfig-007-20260301    gcc-14
i386                  randconfig-011-20260301    clang-20
i386                  randconfig-012-20260301    clang-20
i386                  randconfig-012-20260301    gcc-14
i386                  randconfig-013-20260301    clang-20
i386                  randconfig-014-20260301    clang-20
i386                  randconfig-015-20260301    clang-20
i386                  randconfig-016-20260301    clang-20
i386                  randconfig-017-20260301    clang-20
loongarch                        allmodconfig    clang-23
loongarch                         allnoconfig    gcc-15.2.0
loongarch                           defconfig    clang-19
loongarch                loongson32_defconfig    gcc-15.2.0
loongarch             randconfig-001-20260301    clang-23
loongarch             randconfig-001-20260301    gcc-15.2.0
loongarch             randconfig-002-20260301    clang-23
m68k                             allmodconfig    gcc-15.2.0
m68k                              allnoconfig    gcc-15.2.0
m68k                             allyesconfig    clang-16
m68k                             allyesconfig    gcc-15.2.0
m68k                         amcore_defconfig    gcc-15.2.0
m68k                          atari_defconfig    gcc-15.2.0
m68k                                defconfig    clang-19
m68k                       m5275evb_defconfig    gcc-15.2.0
m68k                        mvme147_defconfig    gcc-15.2.0
m68k                           sun3_defconfig    gcc-15.2.0
m68k                           virt_defconfig    clang-23
m68k                           virt_defconfig    gcc-15.2.0
microblaze                       alldefconfig    gcc-15.2.0
microblaze                        allnoconfig    gcc-15.2.0
microblaze                       allyesconfig    gcc-15.2.0
microblaze                          defconfig    clang-19
mips                             allmodconfig    gcc-15.2.0
mips                              allnoconfig    gcc-15.2.0
mips                             allyesconfig    gcc-15.2.0
mips                         db1xxx_defconfig    clang-23
mips                  decstation_64_defconfig    gcc-15.2.0
mips                       lemote2f_defconfig    clang-23
mips                    maltaup_xpa_defconfig    gcc-15.2.0
mips                        qi_lb60_defconfig    gcc-15.2.0
mips                       rbtx49xx_defconfig    gcc-15.2.0
mips                           rs90_defconfig    gcc-15.2.0
mips                        vocore2_defconfig    clang-23
nios2                         10m50_defconfig    gcc-15.2.0
nios2                            allmodconfig    clang-23
nios2                            allmodconfig    gcc-11.5.0
nios2                             allnoconfig    clang-23
nios2                               defconfig    clang-19
nios2                 randconfig-001-20260301    clang-23
nios2                 randconfig-001-20260301    gcc-8.5.0
nios2                 randconfig-002-20260301    clang-23
nios2                 randconfig-002-20260301    gcc-10.5.0
openrisc                         allmodconfig    clang-23
openrisc                         allmodconfig    gcc-15.2.0
openrisc                          allnoconfig    clang-23
openrisc                            defconfig    gcc-15.2.0
openrisc                 simple_smp_defconfig    clang-23
openrisc                       virt_defconfig    clang-23
parisc                           allmodconfig    gcc-15.2.0
parisc                            allnoconfig    clang-23
parisc                           allyesconfig    clang-19
parisc                           allyesconfig    gcc-15.2.0
parisc                              defconfig    gcc-15.2.0
parisc                randconfig-001-20260301    gcc-10.5.0
parisc                randconfig-002-20260301    gcc-10.5.0
parisc64                            defconfig    clang-19
powerpc                          allmodconfig    gcc-15.2.0
powerpc                           allnoconfig    clang-23
powerpc                   currituck_defconfig    gcc-15.2.0
powerpc                       ebony_defconfig    gcc-15.2.0
powerpc                     ep8248e_defconfig    gcc-15.2.0
powerpc                 mpc8315_rdb_defconfig    clang-23
powerpc               randconfig-001-20260301    gcc-10.5.0
powerpc               randconfig-002-20260301    gcc-10.5.0
powerpc                    sam440ep_defconfig    gcc-15.2.0
powerpc                     tqm5200_defconfig    clang-23
powerpc64             randconfig-001-20260301    gcc-10.5.0
powerpc64             randconfig-002-20260301    gcc-10.5.0
riscv                            allmodconfig    clang-23
riscv                             allnoconfig    clang-23
riscv                            allyesconfig    clang-16
riscv                               defconfig    gcc-15.2.0
riscv                 randconfig-001-20260301    gcc-8.5.0
riscv                 randconfig-002-20260301    gcc-8.5.0
s390                             allmodconfig    clang-18
s390                             allmodconfig    clang-19
s390                              allnoconfig    clang-23
s390                             allyesconfig    gcc-15.2.0
s390                                defconfig    gcc-15.2.0
s390                  randconfig-001-20260301    gcc-8.5.0
s390                  randconfig-002-20260301    gcc-8.5.0
sh                               allmodconfig    gcc-15.2.0
sh                                allnoconfig    clang-23
sh                               allyesconfig    clang-19
sh                               allyesconfig    gcc-15.2.0
sh                                  defconfig    gcc-14
sh                ecovec24-romimage_defconfig    gcc-15.2.0
sh                         ecovec24_defconfig    gcc-15.2.0
sh                        edosk7705_defconfig    gcc-15.2.0
sh                             espt_defconfig    gcc-15.2.0
sh                 kfr2r09-romimage_defconfig    clang-23
sh                          kfr2r09_defconfig    clang-23
sh                          kfr2r09_defconfig    gcc-15.2.0
sh                    randconfig-001-20260301    gcc-8.5.0
sh                    randconfig-002-20260301    gcc-8.5.0
sh                          sdk7786_defconfig    clang-23
sh                          sdk7786_defconfig    gcc-15.2.0
sh                           se7705_defconfig    gcc-15.2.0
sh                           se7721_defconfig    gcc-15.2.0
sh                           se7751_defconfig    gcc-15.2.0
sh                           se7780_defconfig    gcc-15.2.0
sh                        sh7757lcr_defconfig    gcc-15.2.0
sh                             shx3_defconfig    clang-23
sparc                             allnoconfig    clang-23
sparc                               defconfig    gcc-15.2.0
sparc                 randconfig-001-20260301    gcc-13.4.0
sparc                 randconfig-002-20260301    gcc-13.4.0
sparc64                          allmodconfig    clang-23
sparc64                             defconfig    gcc-14
sparc64               randconfig-001-20260301    gcc-13.4.0
sparc64               randconfig-002-20260301    gcc-13.4.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-23
um                               allyesconfig    gcc-14
um                               allyesconfig    gcc-15.2.0
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                    randconfig-001-20260301    gcc-13.4.0
um                    randconfig-002-20260301    gcc-13.4.0
um                           x86_64_defconfig    gcc-14
x86_64                           allmodconfig    clang-20
x86_64                            allnoconfig    clang-23
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20260301    clang-20
x86_64      buildonly-randconfig-002-20260301    clang-20
x86_64      buildonly-randconfig-003-20260301    clang-20
x86_64      buildonly-randconfig-004-20260301    clang-20
x86_64      buildonly-randconfig-005-20260301    clang-20
x86_64      buildonly-randconfig-006-20260301    clang-20
x86_64                              defconfig    gcc-14
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20260301    clang-20
x86_64                randconfig-002-20260301    clang-20
x86_64                randconfig-003-20260301    clang-20
x86_64                randconfig-004-20260301    clang-20
x86_64                randconfig-005-20260301    clang-20
x86_64                randconfig-006-20260301    clang-20
x86_64                randconfig-011-20260301    gcc-14
x86_64                randconfig-012-20260301    gcc-14
x86_64                randconfig-013-20260301    clang-20
x86_64                randconfig-013-20260301    gcc-14
x86_64                randconfig-014-20260301    gcc-14
x86_64                randconfig-015-20260301    clang-20
x86_64                randconfig-015-20260301    gcc-14
x86_64                randconfig-016-20260301    gcc-12
x86_64                randconfig-016-20260301    gcc-14
x86_64                randconfig-071-20260301    clang-20
x86_64                randconfig-072-20260301    clang-20
x86_64                randconfig-073-20260301    clang-20
x86_64                randconfig-074-20260301    clang-20
x86_64                randconfig-075-20260301    clang-20
x86_64                randconfig-076-20260301    clang-20
x86_64                               rhel-9.4    clang-20
x86_64                           rhel-9.4-bpf    gcc-14
x86_64                          rhel-9.4-func    clang-20
x86_64                    rhel-9.4-kselftests    clang-20
x86_64                         rhel-9.4-kunit    gcc-14
x86_64                           rhel-9.4-ltp    gcc-14
x86_64                          rhel-9.4-rust    clang-20
xtensa                           alldefconfig    gcc-15.2.0
xtensa                            allnoconfig    clang-23
xtensa                           allyesconfig    clang-23
xtensa                randconfig-001-20260301    gcc-13.4.0
xtensa                randconfig-002-20260301    gcc-13.4.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

