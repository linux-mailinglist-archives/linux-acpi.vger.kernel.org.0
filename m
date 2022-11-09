Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B1906224EF
	for <lists+linux-acpi@lfdr.de>; Wed,  9 Nov 2022 08:54:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229926AbiKIHy2 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 9 Nov 2022 02:54:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229835AbiKIHy2 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 9 Nov 2022 02:54:28 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73FB817AAD;
        Tue,  8 Nov 2022 23:54:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667980467; x=1699516467;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=EjbvDXzCAPy4PPStQFS7jCDChpVKJsIgL3HwdVUHOVU=;
  b=FXzdKDpeMgi2nnlVatE5Sb7zb/lGix/wR4CHTx5nHEsg40KK3WiurPfS
   1+zGQ9PFz00baqDjBQ21KFgQBUYC/dZ9M6rhNqSxjKrr3PnrKgT7Fkv6e
   GM8M2+kiXeH/JsFD582AxJnD0tc81Ff6zPq4/tcVrNKCsLwZze2hYzUa1
   tna3l0lDkQBZSPp245MgcZS//fdg62gKpBCuSBInGbejOLn6X3OaaFFSd
   4Nao41696sHx1XBvpXe2KkNPIcytYZOTOrQ6Frhd011sU60Rl4lpHJMM1
   L/ESTpqm86Tbi6EswziL3p0CQGlLCWVmZ3x+mzPzXSipEVOzZyhNNe2vG
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10525"; a="375192373"
X-IronPort-AV: E=Sophos;i="5.96,149,1665471600"; 
   d="scan'208";a="375192373"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2022 23:54:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10525"; a="614592452"
X-IronPort-AV: E=Sophos;i="5.96,149,1665471600"; 
   d="scan'208";a="614592452"
Received: from lkp-server01.sh.intel.com (HELO e783503266e8) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 08 Nov 2022 23:54:24 -0800
Received: from kbuild by e783503266e8 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1osfui-0001Eu-0h;
        Wed, 09 Nov 2022 07:54:24 +0000
Date:   Wed, 09 Nov 2022 15:53:53 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     linux-pm@vger.kernel.org, devel@acpica.org,
        linux-acpi@vger.kernel.org
Subject: [rafael-pm:bleeding-edge] BUILD SUCCESS
 7a241ce8159780b955ecef5d12178e5f884864e4
Message-ID: <636b5c91.P8R3IYVW8ykrSS0F%lkp@intel.com>
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
branch HEAD: 7a241ce8159780b955ecef5d12178e5f884864e4  Merge branch 'acpica' into bleeding-edge

elapsed time: 723m

configs tested: 63
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
alpha                               defconfig
x86_64                          rhel-8.3-func
s390                                defconfig
um                           x86_64_defconfig
x86_64                    rhel-8.3-kselftests
s390                             allmodconfig
arc                  randconfig-r043-20221108
s390                 randconfig-r044-20221108
riscv                randconfig-r042-20221108
powerpc                           allnoconfig
powerpc                          allmodconfig
mips                             allyesconfig
s390                             allyesconfig
x86_64                        randconfig-a004
x86_64                        randconfig-a002
sh                               allmodconfig
x86_64                        randconfig-a006
ia64                             allmodconfig
x86_64                        randconfig-a013
x86_64                        randconfig-a011
i386                                defconfig
i386                          randconfig-a001
i386                          randconfig-a003
i386                          randconfig-a005
x86_64                        randconfig-a015
x86_64                               rhel-8.3
x86_64                              defconfig
i386                          randconfig-a012
alpha                            allyesconfig
i386                          randconfig-a014
arc                              allyesconfig
i386                          randconfig-a016
m68k                             allmodconfig
i386                             allyesconfig
m68k                             allyesconfig
x86_64                           allyesconfig
arm                                 defconfig
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit
x86_64                           rhel-8.3-kvm
arm64                            allyesconfig
arm                              allyesconfig
x86_64                            allnoconfig

clang tested configs:
hexagon              randconfig-r045-20221108
hexagon              randconfig-r041-20221108
x86_64                        randconfig-a001
x86_64                        randconfig-a003
x86_64                        randconfig-a005
x86_64                        randconfig-a012
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
x86_64                        randconfig-a016
x86_64                        randconfig-a014
i386                          randconfig-a011
i386                          randconfig-a013
i386                          randconfig-a015

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
