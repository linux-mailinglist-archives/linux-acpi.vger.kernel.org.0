Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5E2168984C
	for <lists+linux-acpi@lfdr.de>; Fri,  3 Feb 2023 13:10:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232100AbjBCMKw (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 3 Feb 2023 07:10:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231994AbjBCMKv (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 3 Feb 2023 07:10:51 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A4139DCBE;
        Fri,  3 Feb 2023 04:10:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675426219; x=1706962219;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=oUlufCSy0q1oH8hxnHPu6Oh0s0KdHEqCnBfy46cJ3as=;
  b=gRa0sy3MsH04vJVhKpQwpawDcNj83hZeEYSinMzo5NMXpW3jGsz/E+vN
   wo+liSU/91QnP4A2ZSyZmLLO3gTLXpgS6BxGVUnyO7HK8/4X6FsIWC7Wu
   8f4jufoBKGnHtfF7k8KuEEhz0//uv1l92gv3hPMH4J/Ibho09QDItqVib
   gmUy54I3uVO6gWwko4wBeZOOieftd0WZ5N5Cxf4zM/UA7z+gWTsctkEex
   OuW8C2rL0eUdwEvgFIs3GpIiugDk0qVsi6osT5290hLZ3whSN6oQhHGf8
   +iq7q8GS84qLJrP0EegDrXyZbbZDptSaEfnWKtbzdETKSIT7Tz+ivnl1R
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10609"; a="326430258"
X-IronPort-AV: E=Sophos;i="5.97,270,1669104000"; 
   d="scan'208";a="326430258"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2023 04:10:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10609"; a="659078496"
X-IronPort-AV: E=Sophos;i="5.97,270,1669104000"; 
   d="scan'208";a="659078496"
Received: from lkp-server01.sh.intel.com (HELO 4455601a8d94) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 03 Feb 2023 04:09:58 -0800
Received: from kbuild by 4455601a8d94 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pNutC-0000T1-0f;
        Fri, 03 Feb 2023 12:09:58 +0000
Date:   Fri, 03 Feb 2023 20:09:09 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     linux-pm@vger.kernel.org, devel@acpica.org,
        linux-acpi@vger.kernel.org
Subject: [rafael-pm:bleeding-edge] BUILD SUCCESS WITH WARNING
 dcb17d36bed40f2ab07d6ffb318a5277b6c3378d
Message-ID: <63dcf965.BFq6EeNh5tPZEqSO%lkp@intel.com>
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
branch HEAD: dcb17d36bed40f2ab07d6ffb318a5277b6c3378d  Merge branch 'pm-tools' into bleeding-edge

Warning reports:

https://lore.kernel.org/oe-kbuild-all/202302031854.dRaSdTg4-lkp@intel.com

Warning: (recently discovered and may have been fixed)

kismet: WARNING: unmet direct dependencies detected for IDLE_INJECT when selected by INTEL_POWERCLAMP

Warning ids grouped by kconfigs:

gcc_recent_errors
`-- x86_64-allnoconfig
    `-- kismet:WARNING:unmet-direct-dependencies-detected-for-IDLE_INJECT-when-selected-by-INTEL_POWERCLAMP

elapsed time: 920m

configs tested: 67
configs skipped: 2

gcc tested configs:
x86_64                            allnoconfig
powerpc                           allnoconfig
um                           x86_64_defconfig
um                             i386_defconfig
arc                                 defconfig
s390                             allmodconfig
x86_64                        randconfig-a006
x86_64                              defconfig
alpha                               defconfig
x86_64                        randconfig-a002
alpha                             allnoconfig
i386                              allnoconfig
arm                               allnoconfig
arc                               allnoconfig
x86_64                        randconfig-a004
s390                                defconfig
sh                               allmodconfig
x86_64                               rhel-8.3
mips                             allyesconfig
i386                          randconfig-a001
s390                             allyesconfig
i386                          randconfig-a003
i386                          randconfig-a005
x86_64                           allyesconfig
m68k                             allyesconfig
m68k                             allmodconfig
arc                              allyesconfig
alpha                            allyesconfig
ia64                             allmodconfig
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit
x86_64                           rhel-8.3-kvm
x86_64                           rhel-8.3-bpf
x86_64                    rhel-8.3-kselftests
x86_64                          rhel-8.3-func
arc                  randconfig-r043-20230202
s390                 randconfig-r044-20230202
riscv                randconfig-r042-20230202
x86_64                        randconfig-a013
x86_64                        randconfig-a011
i386                          randconfig-a014
i386                          randconfig-a012
i386                          randconfig-a016
x86_64                        randconfig-a015
i386                                defconfig
i386                             allyesconfig
riscv                             allnoconfig
powerpc                          allmodconfig
arm                                 defconfig
arm                              allyesconfig
arm64                            allyesconfig

clang tested configs:
x86_64                        randconfig-a001
x86_64                        randconfig-a003
x86_64                        randconfig-a005
i386                          randconfig-a002
i386                          randconfig-a004
i386                          randconfig-a006
x86_64                          rhel-8.3-rust
arm                  randconfig-r046-20230202
hexagon              randconfig-r045-20230202
hexagon              randconfig-r041-20230202
x86_64                        randconfig-a012
i386                          randconfig-a013
i386                          randconfig-a011
i386                          randconfig-a015
x86_64                        randconfig-a016
x86_64                        randconfig-a014

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
