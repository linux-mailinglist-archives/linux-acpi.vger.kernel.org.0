Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 483CF64C4F9
	for <lists+linux-acpi@lfdr.de>; Wed, 14 Dec 2022 09:22:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237476AbiLNIWm (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 14 Dec 2022 03:22:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237358AbiLNIWl (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 14 Dec 2022 03:22:41 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38BC8E09;
        Wed, 14 Dec 2022 00:22:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1671006156; x=1702542156;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=XvjSGIwI6uZ3giOTW7DDN3LFDCRpWMKh6xRc0Vvr09c=;
  b=PelbsGgCvKHAQDN+NtwFeulrC7klaSI1CnuRoN45fW0wTc9xw921Mgi8
   Hd4RfhgRZaCqG/y+nFWnJSIDOioZxGEHCf7AzYtsdBGUp5szCtRj18Dvo
   qTX8iNL/ukn8sUbFkAvIOXi8vv3TVk4I5phOFxr0oZCDOnu2WHBWKD/GV
   I1NEPIC824xWqiVnUUknnvhDM4WDyqJXcnGhRtvIUphEZrAZ1mq/iG/70
   fUXX8W9uehDj1jSbsW0eDkc/r90A/GIFLeuQ9j6GsRjGTEOcmUvHFSj7f
   SZJJI0DqZ1fjo3HWnsmE3LWChP3Zh55qQgJ4JPizrMU9haRFSe1U8l1p+
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10560"; a="319486061"
X-IronPort-AV: E=Sophos;i="5.96,243,1665471600"; 
   d="scan'208";a="319486061"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2022 00:22:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10560"; a="679595094"
X-IronPort-AV: E=Sophos;i="5.96,243,1665471600"; 
   d="scan'208";a="679595094"
Received: from lkp-server01.sh.intel.com (HELO b5d47979f3ad) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 14 Dec 2022 00:21:48 -0800
Received: from kbuild by b5d47979f3ad with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1p5N1P-0005Jr-3A;
        Wed, 14 Dec 2022 08:21:48 +0000
Date:   Wed, 14 Dec 2022 16:21:00 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     linux-pm@vger.kernel.org, devel@acpica.org,
        linux-acpi@vger.kernel.org
Subject: [rafael-pm:bleeding-edge] BUILD SUCCESS
 caa56805aa4387838eba9fc5577a055b81c8433f
Message-ID: <6399876c.STsRZvSFPmL6uSP9%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
branch HEAD: caa56805aa4387838eba9fc5577a055b81c8433f  Merge branch 'thermal-next' into linux-next

elapsed time: 720m

configs tested: 86
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
um                             i386_defconfig
um                           x86_64_defconfig
powerpc                           allnoconfig
x86_64                              defconfig
alpha                             allnoconfig
m68k                             allyesconfig
i386                              allnoconfig
m68k                             allmodconfig
x86_64                               rhel-8.3
x86_64                        randconfig-a013
arc                              allyesconfig
x86_64                        randconfig-a011
arm                               allnoconfig
i386                                defconfig
arc                  randconfig-r043-20221213
alpha                            allyesconfig
arm                  randconfig-r046-20221213
arc                               allnoconfig
x86_64                        randconfig-a015
x86_64                           allyesconfig
x86_64                          rhel-8.3-rust
x86_64                          rhel-8.3-func
arm                                 defconfig
x86_64                           rhel-8.3-syz
i386                          randconfig-a001
i386                          randconfig-a003
x86_64                    rhel-8.3-kselftests
x86_64                         rhel-8.3-kunit
x86_64                           rhel-8.3-kvm
x86_64                           rhel-8.3-bpf
x86_64                        randconfig-a004
sh                               allmodconfig
x86_64                        randconfig-a002
ia64                             allmodconfig
i386                          randconfig-a005
x86_64                        randconfig-a006
mips                             allyesconfig
powerpc                          allmodconfig
i386                          randconfig-a014
i386                          randconfig-a012
i386                          randconfig-a016
i386                             allyesconfig
arm64                            allyesconfig
arm                              allyesconfig
x86_64                            allnoconfig
powerpc                         ps3_defconfig
m68k                          atari_defconfig
microblaze                          defconfig
sh                                  defconfig
mips                         rt305x_defconfig
m68k                       m5475evb_defconfig
riscv             nommu_k210_sdcard_defconfig
nios2                            alldefconfig
arc                                 defconfig
alpha                               defconfig
s390                             allmodconfig
s390                                defconfig
s390                             allyesconfig
riscv                             allnoconfig
i386                          randconfig-c001
arc                        nsimosci_defconfig
sh                          landisk_defconfig
arm                           h3600_defconfig
i386                          debian-10.3-kvm
i386                        debian-10.3-kunit
i386                         debian-10.3-func

clang tested configs:
hexagon              randconfig-r041-20221213
x86_64                        randconfig-a012
hexagon              randconfig-r045-20221213
x86_64                        randconfig-a014
x86_64                        randconfig-a016
riscv                randconfig-r042-20221213
s390                 randconfig-r044-20221213
i386                          randconfig-a002
x86_64                        randconfig-a001
x86_64                        randconfig-a003
i386                          randconfig-a006
i386                          randconfig-a004
x86_64                        randconfig-a005
i386                          randconfig-a013
i386                          randconfig-a011
i386                          randconfig-a015
s390                             alldefconfig
mips                        qi_lb60_defconfig
mips                           ip22_defconfig
powerpc                 mpc836x_mds_defconfig

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
