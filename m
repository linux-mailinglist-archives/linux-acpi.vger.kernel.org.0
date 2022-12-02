Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 029B964045B
	for <lists+linux-acpi@lfdr.de>; Fri,  2 Dec 2022 11:18:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232995AbiLBKSs (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 2 Dec 2022 05:18:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232745AbiLBKSn (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 2 Dec 2022 05:18:43 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E02C2CBA4B;
        Fri,  2 Dec 2022 02:18:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669976322; x=1701512322;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=xpBx1C4ebkHy1XecBYDMs78ys2LZ2wSf9uKxFIcWeCw=;
  b=k1PkaJiLbqouGNIz3zQrGRN1Kry2eLufSB8wC08s2eE3AcAB6q3y5VY5
   q9UrbHxrnYEZ4UtoqAEgChc4pF/kObe8H98sbQ7lpSdHKKCCl78rVL7kv
   PnMH75cvgDz9PKh1yEE69cjl87sQU8s4QE16i6wNP1MPpTvhBJD5e4BxD
   WQnzaDmYgSMoptjruNCKxYVnJ5Vg/O/MREFn0BjNh9KJrPQI2CBMJnXa5
   xfAoz18qJxdZ+fx5SESueu18YykhqLKm/8HKUxLZH/lZtux5cbe+Rh7x/
   1IiPbrJuzNyGr/ef2b2pDguqvKFA0peYpj8HSR1HTZvtffZVDKlB78vEn
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10548"; a="342861422"
X-IronPort-AV: E=Sophos;i="5.96,212,1665471600"; 
   d="scan'208";a="342861422"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2022 02:18:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10548"; a="890100169"
X-IronPort-AV: E=Sophos;i="5.96,212,1665471600"; 
   d="scan'208";a="890100169"
Received: from lkp-server01.sh.intel.com (HELO 64a2d449c951) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 02 Dec 2022 02:18:09 -0800
Received: from kbuild by 64a2d449c951 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1p137Q-000DXf-2b;
        Fri, 02 Dec 2022 10:18:08 +0000
Date:   Fri, 02 Dec 2022 18:17:27 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     linux-pm@vger.kernel.org, devel@acpica.org,
        linux-acpi@vger.kernel.org
Subject: [rafael-pm:bleeding-edge] BUILD SUCCESS
 aa570d791b81a37c7abb47547a2ea81f9c544667
Message-ID: <6389d0b7.oTaArbIJopAKdLAq%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
branch HEAD: aa570d791b81a37c7abb47547a2ea81f9c544667  Merge branch 'pm-sleep' into bleeding-edge

elapsed time: 825m

configs tested: 62
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
powerpc                           allnoconfig
arc                                 defconfig
s390                             allmodconfig
x86_64                    rhel-8.3-kselftests
alpha                               defconfig
x86_64                          rhel-8.3-func
um                             i386_defconfig
s390                                defconfig
um                           x86_64_defconfig
sh                               allmodconfig
s390                             allyesconfig
alpha                            allyesconfig
m68k                             allyesconfig
m68k                             allmodconfig
ia64                             allmodconfig
arc                              allyesconfig
mips                             allyesconfig
arc                               allnoconfig
alpha                             allnoconfig
i386                              allnoconfig
arm                               allnoconfig
powerpc                          allmodconfig
x86_64                        randconfig-a013
x86_64                        randconfig-a011
arc                  randconfig-r043-20221201
s390                 randconfig-r044-20221201
x86_64                        randconfig-a015
riscv                randconfig-r042-20221201
x86_64                              defconfig
x86_64                               rhel-8.3
i386                          randconfig-a001
i386                          randconfig-a003
x86_64                           allyesconfig
i386                          randconfig-a005
i386                          randconfig-a014
i386                          randconfig-a012
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit
i386                          randconfig-a016
x86_64                           rhel-8.3-kvm
i386                                defconfig
i386                             allyesconfig
x86_64                        randconfig-a004
x86_64                        randconfig-a002
x86_64                        randconfig-a006
arm                                 defconfig
arm64                            allyesconfig
arm                              allyesconfig

clang tested configs:
x86_64                        randconfig-a014
x86_64                        randconfig-a012
hexagon              randconfig-r045-20221201
x86_64                        randconfig-a016
hexagon              randconfig-r041-20221201
i386                          randconfig-a002
i386                          randconfig-a004
i386                          randconfig-a006
i386                          randconfig-a013
i386                          randconfig-a011
i386                          randconfig-a015
x86_64                        randconfig-a001
x86_64                        randconfig-a003
x86_64                        randconfig-a005

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
