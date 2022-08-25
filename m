Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2754C5A09BC
	for <lists+linux-acpi@lfdr.de>; Thu, 25 Aug 2022 09:17:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233749AbiHYHQe (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 25 Aug 2022 03:16:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236760AbiHYHQd (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 25 Aug 2022 03:16:33 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A6B5760E1;
        Thu, 25 Aug 2022 00:16:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661411792; x=1692947792;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=Nwp6Cji46dnwi4Sj4t8zoF/G6jVn4T/F1m727vVwp3g=;
  b=TZajrgNfOhhASr6eOMOuWUefuiz1v3ks2n89NZr1o0OT/KJSNfUyIcwh
   c7yjZjIY/oiBygXYmC9g5E44ld9vTjFQNDkKePtqCx/yGI+fQqcCye5/0
   7qcxuqM9s2twXU2cENfGZYoaVX/eGjr/OOKgTV1Q+8GstbDge70T/M7gK
   Xew6XfUty5waYmkFu/OBG0WlZxcmMll4arRCa/Pb6ygifP4ty0YuA8OtF
   FxBV9kKqIzOKICuClsMPBmxnlSxR2vvffABZJnWxPmpEk5cFoSqrXty24
   ljuS5oRt/UhrINQCv4aR6Ec/lSv6s4SPYCPG3L26YRZ9f30hJo3/w/DSW
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10449"; a="294947194"
X-IronPort-AV: E=Sophos;i="5.93,262,1654585200"; 
   d="scan'208";a="294947194"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2022 00:16:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,262,1654585200"; 
   d="scan'208";a="938218217"
Received: from lkp-server02.sh.intel.com (HELO 34e741d32628) ([10.239.97.151])
  by fmsmga005.fm.intel.com with ESMTP; 25 Aug 2022 00:16:30 -0700
Received: from kbuild by 34e741d32628 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oR76L-0001rq-2O;
        Thu, 25 Aug 2022 07:16:29 +0000
Date:   Thu, 25 Aug 2022 15:15:47 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     linux-pm@vger.kernel.org, devel@acpica.org,
        linux-acpi@vger.kernel.org
Subject: [rafael-pm:bleeding-edge] BUILD SUCCESS
 47c90d37e626efa4e7925e8e306993b9cbdada30
Message-ID: <630721a3.Ckrtddp0YFN/Y6zl%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
branch HEAD: 47c90d37e626efa4e7925e8e306993b9cbdada30  Merge branch 'acpi-dev' into bleeding-edge

elapsed time: 722m

configs tested: 64
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
um                             i386_defconfig
um                           x86_64_defconfig
x86_64                              defconfig
arc                              allyesconfig
alpha                            allyesconfig
i386                                defconfig
i386                          randconfig-a001
arc                  randconfig-r043-20220824
x86_64                               rhel-8.3
x86_64                           allyesconfig
i386                          randconfig-a003
i386                          randconfig-a014
riscv                randconfig-r042-20220824
x86_64                        randconfig-a013
x86_64                        randconfig-a011
m68k                             allmodconfig
powerpc                           allnoconfig
m68k                             allyesconfig
i386                          randconfig-a005
s390                 randconfig-r044-20220824
i386                          randconfig-a012
x86_64                        randconfig-a015
i386                          randconfig-a016
arm                                 defconfig
x86_64                        randconfig-a004
x86_64                        randconfig-a002
x86_64                        randconfig-a006
arm                              allyesconfig
arm64                            allyesconfig
i386                             allyesconfig
sh                               allmodconfig
mips                             allyesconfig
powerpc                          allmodconfig
x86_64                          rhel-8.3-func
x86_64                         rhel-8.3-kunit
x86_64                           rhel-8.3-kvm
x86_64                           rhel-8.3-syz
x86_64                    rhel-8.3-kselftests
loongarch                         allnoconfig
arc                                 defconfig
loongarch                           defconfig
alpha                               defconfig
s390                                defconfig
s390                             allmodconfig
s390                             allyesconfig
ia64                             allmodconfig
arc                               allnoconfig
alpha                             allnoconfig
riscv                             allnoconfig
csky                              allnoconfig

clang tested configs:
i386                          randconfig-a013
hexagon              randconfig-r041-20220824
i386                          randconfig-a011
x86_64                        randconfig-a012
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
hexagon              randconfig-r045-20220824
x86_64                        randconfig-a014
x86_64                        randconfig-a016
i386                          randconfig-a015
x86_64                        randconfig-a005
x86_64                        randconfig-a001
x86_64                        randconfig-a003

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
