Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 313DB625AE3
	for <lists+linux-acpi@lfdr.de>; Fri, 11 Nov 2022 14:04:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233725AbiKKNER (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 11 Nov 2022 08:04:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233768AbiKKNEN (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 11 Nov 2022 08:04:13 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1176E6316A;
        Fri, 11 Nov 2022 05:04:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668171851; x=1699707851;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=YvAEa1CAVQQPhrVNtms+4ZsOo6mHPIuxnq68V1kAw90=;
  b=DF0cDeDV3faPlW1rq06OY0PgqeXgiLNtUfT7BLFmnl8Ulj4G6GZWdILo
   MBGgZ0IE+8+UaOQDzLXfNL26n5R9gRo56V3aJWUgNIHJzMBiLAGuoi406
   lm5TvkrnBhC+oPmlg2TSyOvnFd9BV6kbqypKTIE1zJmU2PJo41G5/Jti7
   YirQC/iy17qIU0/n8KfAhW2reOB6FgMtDvu8ayUOqs/8zHysVWasqMDyO
   3d6XseqtERHDy3GpMxoyO7jXfOeSolYTq8RAX1Stlw7hqN7Nk1iQZL/3M
   uxo8gqKq9BiNlKygWoUNCmMzEyY6ej9nK/fckz0U4nfMLpbqrbLLw7roG
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10527"; a="309218493"
X-IronPort-AV: E=Sophos;i="5.96,156,1665471600"; 
   d="scan'208";a="309218493"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2022 05:04:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10527"; a="780172454"
X-IronPort-AV: E=Sophos;i="5.96,156,1665471600"; 
   d="scan'208";a="780172454"
Received: from lkp-server01.sh.intel.com (HELO e783503266e8) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 11 Nov 2022 05:04:07 -0800
Received: from kbuild by e783503266e8 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1otThW-0003xF-2c;
        Fri, 11 Nov 2022 13:04:06 +0000
Date:   Fri, 11 Nov 2022 21:03:58 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     linux-pm@vger.kernel.org, devel@acpica.org,
        linux-acpi@vger.kernel.org
Subject: [rafael-pm:bleeding-edge] BUILD SUCCESS
 f9aff8dbe1e91b0e011ffd9065b79fe3980cd5f5
Message-ID: <636e483e.U+qW9J5m+lq5Cbbn%lkp@intel.com>
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
branch HEAD: f9aff8dbe1e91b0e011ffd9065b79fe3980cd5f5  Merge branch 'acpi-pm' into bleeding-edge

elapsed time: 1025m

configs tested: 56
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arc                               allnoconfig
um                             i386_defconfig
alpha                             allnoconfig
um                           x86_64_defconfig
i386                              allnoconfig
arm                               allnoconfig
i386                          randconfig-a001
i386                          randconfig-a003
i386                          randconfig-a005
arc                                 defconfig
x86_64                    rhel-8.3-kselftests
s390                             allmodconfig
x86_64                          rhel-8.3-func
alpha                               defconfig
s390                                defconfig
s390                             allyesconfig
powerpc                           allnoconfig
x86_64                              defconfig
ia64                             allmodconfig
x86_64                           allyesconfig
x86_64                               rhel-8.3
x86_64                        randconfig-a013
x86_64                        randconfig-a011
x86_64                           rhel-8.3-kvm
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit
x86_64                        randconfig-a015
x86_64                        randconfig-a004
x86_64                        randconfig-a002
sh                               allmodconfig
mips                             allyesconfig
alpha                            allyesconfig
i386                                defconfig
powerpc                          allmodconfig
arc                              allyesconfig
x86_64                        randconfig-a006
m68k                             allmodconfig
m68k                             allyesconfig
arc                  randconfig-r043-20221110
i386                             allyesconfig
arm                                 defconfig
arm64                            allyesconfig
arm                              allyesconfig

clang tested configs:
i386                          randconfig-a002
i386                          randconfig-a004
i386                          randconfig-a006
x86_64                        randconfig-a012
x86_64                        randconfig-a016
x86_64                        randconfig-a014
x86_64                        randconfig-a001
x86_64                        randconfig-a003
x86_64                        randconfig-a005
riscv                randconfig-r042-20221110
hexagon              randconfig-r041-20221110
hexagon              randconfig-r045-20221110
s390                 randconfig-r044-20221110

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
