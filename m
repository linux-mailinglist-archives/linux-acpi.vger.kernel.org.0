Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EAB16414E9
	for <lists+linux-acpi@lfdr.de>; Sat,  3 Dec 2022 09:22:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231465AbiLCIWz (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sat, 3 Dec 2022 03:22:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230422AbiLCIWu (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sat, 3 Dec 2022 03:22:50 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F020ECE35;
        Sat,  3 Dec 2022 00:22:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670055767; x=1701591767;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=/7ZmB/olwIpq9rajt/gYdYYv/t7DoHBJPtGGxWjh20o=;
  b=aBbVEcZ8oG6z8xuYCZgiP3PqbDe3nwQWPIbVSIPajAR3L3jnE/Etc0qz
   jaGSLfuRcUcLLM5JT7kiDGC22GQ+k8NMIH+QB5Kn/JslWcXxjQsVLV2N/
   ijXwtrTLITyN+WForA8embMwAOkKUYEaRec4h0J2MfS3d+DDqwHLZn8Gz
   d/ruSZKJQ00JYkLu1sXF39BLJwHGoBVoacLOJ7ggYDoSpskiGl1YeDi/B
   FTJ1GHRKf8PN2+FX6185NXU/4fNyyfnbVhQpwNU/uvcdY9QaYG8am54LY
   T9GzkqvHtW1fbCmGrqxXEng2qHRhB+MlYeF+ypjXLE8p6JDl+enjDGWRH
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10549"; a="313745977"
X-IronPort-AV: E=Sophos;i="5.96,214,1665471600"; 
   d="scan'208";a="313745977"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2022 00:22:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10549"; a="819679510"
X-IronPort-AV: E=Sophos;i="5.96,214,1665471600"; 
   d="scan'208";a="819679510"
Received: from lkp-server01.sh.intel.com (HELO 64a2d449c951) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 03 Dec 2022 00:22:44 -0800
Received: from kbuild by 64a2d449c951 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1p1NnH-000EPC-1e;
        Sat, 03 Dec 2022 08:22:43 +0000
Date:   Sat, 03 Dec 2022 16:22:20 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     linux-pm@vger.kernel.org, devel@acpica.org,
        linux-acpi@vger.kernel.org
Subject: [rafael-pm:bleeding-edge] BUILD SUCCESS
 edef46079c571f859ca90f29c76d3bb568060652
Message-ID: <638b073c.bV7W6uIVAVN4Zxr+%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
branch HEAD: edef46079c571f859ca90f29c76d3bb568060652  Merge branch 'powercap' into bleeding-edge

elapsed time: 720m

configs tested: 61
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arc                                 defconfig
s390                             allmodconfig
alpha                               defconfig
s390                                defconfig
um                             i386_defconfig
um                           x86_64_defconfig
s390                             allyesconfig
powerpc                           allnoconfig
mips                             allyesconfig
powerpc                          allmodconfig
x86_64                    rhel-8.3-kselftests
x86_64                          rhel-8.3-func
sh                               allmodconfig
arc                               allnoconfig
alpha                             allnoconfig
i386                              allnoconfig
arm                               allnoconfig
x86_64                              defconfig
m68k                             allyesconfig
m68k                             allmodconfig
x86_64                           rhel-8.3-syz
arc                              allyesconfig
x86_64                         rhel-8.3-kunit
alpha                            allyesconfig
x86_64                           rhel-8.3-kvm
i386                                defconfig
x86_64                        randconfig-a004
x86_64                        randconfig-a002
x86_64                               rhel-8.3
arc                  randconfig-r043-20221201
x86_64                        randconfig-a006
i386                          randconfig-a001
riscv                randconfig-r042-20221201
x86_64                        randconfig-a013
i386                          randconfig-a003
x86_64                        randconfig-a011
x86_64                           allyesconfig
s390                 randconfig-r044-20221201
x86_64                        randconfig-a015
i386                          randconfig-a005
i386                          randconfig-a014
i386                             allyesconfig
i386                          randconfig-a012
i386                          randconfig-a016
arm                                 defconfig
arm64                            allyesconfig
arm                              allyesconfig

clang tested configs:
x86_64                        randconfig-a001
x86_64                        randconfig-a003
hexagon              randconfig-r041-20221201
x86_64                        randconfig-a014
x86_64                        randconfig-a005
i386                          randconfig-a013
x86_64                        randconfig-a012
i386                          randconfig-a002
hexagon              randconfig-r045-20221201
i386                          randconfig-a004
x86_64                        randconfig-a016
i386                          randconfig-a011
i386                          randconfig-a015
i386                          randconfig-a006

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
