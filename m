Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C74060ECEA
	for <lists+linux-acpi@lfdr.de>; Thu, 27 Oct 2022 02:18:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233540AbiJ0ASZ (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 26 Oct 2022 20:18:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233790AbiJ0ASY (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 26 Oct 2022 20:18:24 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3022AC96CF;
        Wed, 26 Oct 2022 17:18:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666829904; x=1698365904;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=oB6nTDCMqGB4bl603Y+aNjuJYpKdztso9dayg7OlEFk=;
  b=DFmReBYMh5B2EubJ+g1paD0HAlOFgidR6FCsRnIAL/UrW/FgbEwDznoh
   H59J1Ri2SJrI+orHOcu077Mi2Z666JN7ZEMnYrrVeHSNdZburcAUmHRFj
   LJsF55+9cfHJNZen+rBZrCEnQsr+FVnDWDH2sl1g7kVZxUi0GjxeukalR
   MunoqcmlFHdliGQS0fZMhtEN4Xb86CICd2ATkvZnugF5TZj5I49zR2Rkd
   9WARYPkl0wbGcQ4KHRnmh9K4vHDuGjpJUuZtqfMFqnQB1dcB0Be13Lsg6
   0o1e9x+GzXZXyD0sVYo3bfNJsIhbSsZiF9FB6G2SxMcXU+zojsA8T5f09
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10512"; a="288490084"
X-IronPort-AV: E=Sophos;i="5.95,215,1661842800"; 
   d="scan'208";a="288490084"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2022 17:18:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10512"; a="663414342"
X-IronPort-AV: E=Sophos;i="5.95,215,1661842800"; 
   d="scan'208";a="663414342"
Received: from lkp-server02.sh.intel.com (HELO b6d29c1a0365) ([10.239.97.151])
  by orsmga008.jf.intel.com with ESMTP; 26 Oct 2022 17:18:22 -0700
Received: from kbuild by b6d29c1a0365 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1onqbF-00081D-1M;
        Thu, 27 Oct 2022 00:18:21 +0000
Date:   Thu, 27 Oct 2022 08:18:14 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     linux-pm@vger.kernel.org, devel@acpica.org,
        linux-acpi@vger.kernel.org
Subject: [rafael-pm:bleeding-edge] BUILD SUCCESS
 1de66fcb380ec2ea6ad56911061c65ba1928a94c
Message-ID: <6359ce46.UUtBc51qx8f6Watx%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
branch HEAD: 1de66fcb380ec2ea6ad56911061c65ba1928a94c  Merge branch 'acpi-scan' into bleeding-edge

elapsed time: 721m

configs tested: 62
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arc                                 defconfig
arc                               allnoconfig
alpha                               defconfig
powerpc                           allnoconfig
alpha                             allnoconfig
riscv                             allnoconfig
csky                              allnoconfig
um                             i386_defconfig
um                           x86_64_defconfig
x86_64                              defconfig
s390                                defconfig
x86_64                               rhel-8.3
x86_64                           allyesconfig
s390                             allmodconfig
i386                          randconfig-a001
i386                          randconfig-a003
i386                          randconfig-a005
sh                               allmodconfig
s390                             allyesconfig
mips                             allyesconfig
powerpc                          allmodconfig
i386                                defconfig
riscv                randconfig-r042-20221026
x86_64                          rhel-8.3-func
arc                  randconfig-r043-20221026
ia64                             allmodconfig
s390                 randconfig-r044-20221026
x86_64                    rhel-8.3-kselftests
arm                                 defconfig
i386                             allyesconfig
x86_64                        randconfig-a004
x86_64                        randconfig-a013
arm64                            allyesconfig
x86_64                        randconfig-a011
arm                              allyesconfig
i386                          randconfig-a014
m68k                             allmodconfig
x86_64                        randconfig-a002
x86_64                        randconfig-a015
arc                              allyesconfig
i386                          randconfig-a012
i386                          randconfig-a016
alpha                            allyesconfig
x86_64                        randconfig-a006
m68k                             allyesconfig
x86_64                         rhel-8.3-kunit
x86_64                           rhel-8.3-kvm
x86_64                           rhel-8.3-syz

clang tested configs:
i386                          randconfig-a002
i386                          randconfig-a004
i386                          randconfig-a006
hexagon              randconfig-r041-20221026
hexagon              randconfig-r045-20221026
i386                          randconfig-a013
x86_64                        randconfig-a012
i386                          randconfig-a011
x86_64                        randconfig-a005
x86_64                        randconfig-a001
x86_64                        randconfig-a014
i386                          randconfig-a015
x86_64                        randconfig-a016
x86_64                        randconfig-a003

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
