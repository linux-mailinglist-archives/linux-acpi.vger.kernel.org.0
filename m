Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1143165B9CE
	for <lists+linux-acpi@lfdr.de>; Tue,  3 Jan 2023 04:37:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236758AbjACDhv (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 2 Jan 2023 22:37:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236695AbjACDhS (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 2 Jan 2023 22:37:18 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C39036462;
        Mon,  2 Jan 2023 19:37:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1672717037; x=1704253037;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=UVOSnjHEDH7RljVhHC2x1p2UT3THPMRt2zUip+BrgE0=;
  b=M2UtC+vJGx5OhCtDdG5gK68Ub/vbM0hpg8xWOqE3DwVD2+Ol7no+4ijk
   giqIxAgTCpwWWB47oWlYrt5QsKjW6mocaUotfVNALiGR4G7FmDBASSZgC
   02KSlvpEhtLk/gF2ypcGmRhfBh1mqoJBqamTEOu8X3aFZmvZRE9PGrhHF
   LFtPHSqM4au9ZBaZ2zFun0erfA4moHL2bufia3T0ZxxD+k0yG1pCRapsw
   PP/Wbyvh4G2FHtY5JHDiy1TgQO/2p6cvhK3MbJqRZ8OgkIxARg3jH3ELC
   gN5gsjIoEAbJImW0tIhMEd1/isfbd7hnqy1BKg6uEfry2tgDoQpZFKkfS
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10578"; a="383874093"
X-IronPort-AV: E=Sophos;i="5.96,295,1665471600"; 
   d="scan'208";a="383874093"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jan 2023 19:37:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10578"; a="723120720"
X-IronPort-AV: E=Sophos;i="5.96,295,1665471600"; 
   d="scan'208";a="723120720"
Received: from lkp-server01.sh.intel.com (HELO b5d47979f3ad) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 02 Jan 2023 19:37:15 -0800
Received: from kbuild by b5d47979f3ad with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pCY70-000Rjc-2e;
        Tue, 03 Jan 2023 03:37:14 +0000
Date:   Tue, 03 Jan 2023 11:37:05 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     linux-pm@vger.kernel.org, devel@acpica.org,
        linux-acpi@vger.kernel.org
Subject: [rafael-pm:bleeding-edge] BUILD SUCCESS
 2804f848d8e3541dc77038a8d9b0b3385e93495f
Message-ID: <63b3a2e1.GfqZj6xUXXQU7iyR%lkp@intel.com>
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
branch HEAD: 2804f848d8e3541dc77038a8d9b0b3385e93495f  Merge branch 'thermal-intel-next' into linux-next

elapsed time: 721m

configs tested: 73
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
alpha                             allnoconfig
i386                              allnoconfig
arm                               allnoconfig
arc                               allnoconfig
powerpc                           allnoconfig
um                             i386_defconfig
arc                                 defconfig
um                           x86_64_defconfig
m68k                             allmodconfig
alpha                               defconfig
alpha                            allyesconfig
m68k                             allyesconfig
arc                              allyesconfig
x86_64                              defconfig
s390                             allmodconfig
sh                               allmodconfig
i386                                defconfig
x86_64               randconfig-a003-20230102
s390                                defconfig
x86_64               randconfig-a001-20230102
powerpc                          allmodconfig
mips                             allyesconfig
x86_64                               rhel-8.3
x86_64               randconfig-a004-20230102
i386                 randconfig-a004-20230102
x86_64               randconfig-a002-20230102
i386                 randconfig-a003-20230102
i386                 randconfig-a001-20230102
x86_64                           rhel-8.3-kvm
s390                             allyesconfig
arm                                 defconfig
i386                 randconfig-a002-20230102
i386                             allyesconfig
x86_64               randconfig-a005-20230102
i386                 randconfig-a005-20230102
x86_64               randconfig-a006-20230102
x86_64                           rhel-8.3-bpf
i386                 randconfig-a006-20230102
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit
x86_64                           allyesconfig
x86_64                    rhel-8.3-kselftests
x86_64                          rhel-8.3-func
ia64                             allmodconfig
arm64                            allyesconfig
arm                              allyesconfig
riscv                randconfig-r042-20230101
s390                 randconfig-r044-20230101
arc                  randconfig-r043-20230102
arm                  randconfig-r046-20230102
arc                  randconfig-r043-20230101
x86_64                            allnoconfig
riscv                             allnoconfig

clang tested configs:
i386                 randconfig-a013-20230102
i386                 randconfig-a012-20230102
i386                 randconfig-a011-20230102
i386                 randconfig-a014-20230102
i386                 randconfig-a015-20230102
i386                 randconfig-a016-20230102
x86_64                          rhel-8.3-rust
hexagon              randconfig-r041-20230102
x86_64               randconfig-a011-20230102
x86_64               randconfig-a014-20230102
s390                 randconfig-r044-20230102
hexagon              randconfig-r045-20230101
x86_64               randconfig-a012-20230102
hexagon              randconfig-r045-20230102
x86_64               randconfig-a013-20230102
x86_64               randconfig-a015-20230102
x86_64               randconfig-a016-20230102
arm                  randconfig-r046-20230101
riscv                randconfig-r042-20230102
hexagon              randconfig-r041-20230101

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
