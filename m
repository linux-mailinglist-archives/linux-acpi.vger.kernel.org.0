Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C58266AA4F
	for <lists+linux-acpi@lfdr.de>; Sat, 14 Jan 2023 10:06:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229787AbjANJGi (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sat, 14 Jan 2023 04:06:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229620AbjANJGh (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sat, 14 Jan 2023 04:06:37 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3569259E6;
        Sat, 14 Jan 2023 01:06:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673687196; x=1705223196;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=w+bh/JTScrGi2k5GFuTgWKil04N/ZfVZFC2I5q32xlE=;
  b=ADMRDHBswjvqogWffdL63mh/eZYVvnfEDhtcn/deVNxLRepBGHj1I8cQ
   HG9ziujqUZ8ME5osGavklPeM7QCgBYPmxhOBcDDgfwBXQFOS1ULus6nZW
   22ihgLaliHdEqqz4wEINypdWJ0JXmqIelQHyhtJsvN+QplnEsCkCEXHea
   oARxs32s/74pFufUdi1U5EynG2Cdz2mp4mnwwbeZIgz/1IcN+VBdSGi2w
   HkX04sQHQS+LBJowt/CUs3kGpZ4yfi8qMDioA9qjg5UESPeW3RqYzyzo3
   avOiiGvd7XU3MKIL8RlSaDbyIyy804IZJmswSnDi3iewuqLZnxgSEPJYr
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10589"; a="303875858"
X-IronPort-AV: E=Sophos;i="5.97,216,1669104000"; 
   d="scan'208";a="303875858"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2023 01:06:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10589"; a="651775179"
X-IronPort-AV: E=Sophos;i="5.97,216,1669104000"; 
   d="scan'208";a="651775179"
Received: from lkp-server02.sh.intel.com (HELO f1920e93ebb5) ([10.239.97.151])
  by orsmga007.jf.intel.com with ESMTP; 14 Jan 2023 01:06:33 -0800
Received: from kbuild by f1920e93ebb5 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pGcUi-000Bxb-2T;
        Sat, 14 Jan 2023 09:06:32 +0000
Date:   Sat, 14 Jan 2023 17:05:55 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     linux-pm@vger.kernel.org, devel@acpica.org,
        linux-acpi@vger.kernel.org
Subject: [rafael-pm:bleeding-edge] BUILD SUCCESS
 c7b1de870ff7fcb5652bc776a42630b07374b09d
Message-ID: <63c27073.OSK/WBzbTUDR2ZMn%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
branch HEAD: c7b1de870ff7fcb5652bc776a42630b07374b09d  Merge branch 'pm-cpuidle' into bleeding-edge

elapsed time: 721m

configs tested: 71
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
x86_64                            allnoconfig
arc                                 defconfig
alpha                               defconfig
s390                             allmodconfig
s390                                defconfig
um                             i386_defconfig
um                           x86_64_defconfig
i386                              allnoconfig
i386                                defconfig
alpha                             allnoconfig
arm                               allnoconfig
x86_64                           rhel-8.3-syz
arc                               allnoconfig
x86_64                           rhel-8.3-kvm
x86_64                           rhel-8.3-bpf
powerpc                           allnoconfig
x86_64                         rhel-8.3-kunit
ia64                             allmodconfig
s390                             allyesconfig
x86_64                        randconfig-a013
arc                  randconfig-r043-20230112
x86_64                        randconfig-a011
s390                 randconfig-r044-20230112
i386                          randconfig-a001
i386                          randconfig-a003
x86_64                        randconfig-a015
x86_64                    rhel-8.3-kselftests
sh                               allmodconfig
riscv                randconfig-r042-20230112
mips                             allyesconfig
m68k                             allyesconfig
i386                          randconfig-a005
x86_64                          rhel-8.3-func
m68k                             allmodconfig
arc                              allyesconfig
alpha                            allyesconfig
powerpc                          allmodconfig
x86_64                              defconfig
x86_64                               rhel-8.3
arm                                 defconfig
i386                          randconfig-a014
i386                             allyesconfig
x86_64                        randconfig-a004
x86_64                        randconfig-a002
i386                          randconfig-a012
i386                          randconfig-a016
x86_64                        randconfig-a006
x86_64                           allyesconfig
arm64                            allyesconfig
arm                              allyesconfig
openrisc                         alldefconfig
mips                 decstation_r4k_defconfig
sh                          urquell_defconfig
powerpc                       maple_defconfig
arm64                               defconfig

clang tested configs:
arm                  randconfig-r046-20230112
x86_64                          rhel-8.3-rust
hexagon              randconfig-r041-20230112
x86_64                        randconfig-a012
hexagon              randconfig-r045-20230112
i386                          randconfig-a002
x86_64                        randconfig-a014
i386                          randconfig-a004
x86_64                        randconfig-a016
i386                          randconfig-a006
i386                          randconfig-a013
i386                          randconfig-a011
x86_64                        randconfig-a001
x86_64                        randconfig-a003
i386                          randconfig-a015
x86_64                        randconfig-a005

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
