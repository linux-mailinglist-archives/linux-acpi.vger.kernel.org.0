Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51D80634228
	for <lists+linux-acpi@lfdr.de>; Tue, 22 Nov 2022 18:05:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232021AbiKVRF2 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 22 Nov 2022 12:05:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231773AbiKVRF1 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 22 Nov 2022 12:05:27 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4C7E78D5D;
        Tue, 22 Nov 2022 09:05:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669136726; x=1700672726;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=ImYkCv+Af8B4fVtMyM7Lv9I7TcUDYLsd7y3k+uIQxjA=;
  b=MeZX5S/A651sHiGK0vCrEwsJY+0rU0XrCvr+u1hTxLOqqiX1yOrOWFk7
   JCIJ4fVuJLRDZt1rbI7AhcCSKQJbTpb561EipoMws4fNC5//TYhNwkjud
   8p/T0PcNAh5fDVMO48fZYuBTCa6nScRN1f0DO6iywuByx0bPyHIDMJ09I
   hOgKjbF2ATwKuFEjrHr9PG/qIrtj29hGjDhG3gbKTQx+IMO0hdQEhTp1K
   TqjT4hoFF8F+gdvbhkX5rSpIICjhPzBZWYFq+63FmxRXZD+grRvHCSHNb
   IAA+LPSBN8KWcFwXG7XsSK8FsstBj1bGQsLObwjLbN65TBIF5Ur9MY3qY
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10539"; a="400151656"
X-IronPort-AV: E=Sophos;i="5.96,184,1665471600"; 
   d="scan'208";a="400151656"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2022 09:05:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10539"; a="705032665"
X-IronPort-AV: E=Sophos;i="5.96,184,1665471600"; 
   d="scan'208";a="705032665"
Received: from lkp-server01.sh.intel.com (HELO 64a2d449c951) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 22 Nov 2022 09:05:24 -0800
Received: from kbuild by 64a2d449c951 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oxWi4-0001gJ-0M;
        Tue, 22 Nov 2022 17:05:24 +0000
Date:   Wed, 23 Nov 2022 01:04:31 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     linux-pm@vger.kernel.org, devel@acpica.org,
        linux-acpi@vger.kernel.org
Subject: [rafael-pm:bleeding-edge] BUILD SUCCESS
 2ec4cb0b42757f5296c01360badc48525eff99b2
Message-ID: <637d011f.aAlSe2uB44XGF9sM%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
branch HEAD: 2ec4cb0b42757f5296c01360badc48525eff99b2  Merge branch 'pm-cpufreq-fixes' into bleeding-edge

elapsed time: 1287m

configs tested: 72
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arc                               allnoconfig
alpha                             allnoconfig
i386                              allnoconfig
arm                               allnoconfig
arc                                 defconfig
um                             i386_defconfig
um                           x86_64_defconfig
s390                             allmodconfig
alpha                               defconfig
s390                                defconfig
s390                             allyesconfig
x86_64                          rhel-8.3-func
x86_64                    rhel-8.3-kselftests
ia64                             allmodconfig
powerpc                           allnoconfig
mips                             allyesconfig
i386                 randconfig-a011-20221121
i386                 randconfig-a013-20221121
i386                 randconfig-a012-20221121
i386                 randconfig-a014-20221121
sh                               allmodconfig
i386                 randconfig-a016-20221121
i386                 randconfig-a015-20221121
x86_64                           rhel-8.3-syz
x86_64                           rhel-8.3-kvm
x86_64                         rhel-8.3-kunit
arc                  randconfig-r043-20221120
riscv                randconfig-r042-20221121
arc                  randconfig-r043-20221121
x86_64               randconfig-a012-20221121
x86_64               randconfig-a011-20221121
i386                                defconfig
s390                 randconfig-r044-20221121
x86_64               randconfig-a015-20221121
x86_64               randconfig-a013-20221121
x86_64               randconfig-a014-20221121
x86_64               randconfig-a016-20221121
i386                             allyesconfig
m68k                             allyesconfig
m68k                             allmodconfig
arc                              allyesconfig
alpha                            allyesconfig
arm                                 defconfig
arm64                            allyesconfig
x86_64                              defconfig
arm                              allyesconfig
powerpc                          allmodconfig
arm                           stm32_defconfig
m68k                          multi_defconfig
x86_64                           allyesconfig
x86_64                               rhel-8.3

clang tested configs:
hexagon              randconfig-r041-20221120
hexagon              randconfig-r041-20221121
hexagon              randconfig-r045-20221120
hexagon              randconfig-r045-20221121
riscv                randconfig-r042-20221120
s390                 randconfig-r044-20221120
i386                 randconfig-a004-20221121
i386                 randconfig-a001-20221121
i386                 randconfig-a003-20221121
i386                 randconfig-a002-20221121
x86_64               randconfig-a004-20221121
x86_64               randconfig-a001-20221121
x86_64               randconfig-a003-20221121
x86_64               randconfig-a002-20221121
i386                 randconfig-a005-20221121
x86_64               randconfig-a006-20221121
x86_64               randconfig-a005-20221121
i386                 randconfig-a006-20221121
arm                          pcm027_defconfig
mips                          rm200_defconfig
mips                          ath79_defconfig

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
