Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76147576C3E
	for <lists+linux-acpi@lfdr.de>; Sat, 16 Jul 2022 08:32:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231874AbiGPGbq (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sat, 16 Jul 2022 02:31:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231657AbiGPGbc (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sat, 16 Jul 2022 02:31:32 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EF2F7C189;
        Fri, 15 Jul 2022 23:31:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657953064; x=1689489064;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=f1+wvjfXxGXpf3L37oJl18eujoMaSMdPMFUctu6Zo0A=;
  b=ND+lnoSj+7TqBX/jNkU3WRdq3d1zP7YABvouYYDwYG5q7aj38vsDBGT/
   KxEKVJ+QThStNDAfE3OrHfRyG7W7BOX0ScWHvhvvmNlr+GSUhEbcRLTF1
   Jf/8jLnJ72FCGDpInItw5yxDdr157MCEGd/iH/4gRJGoOoLlNR6h3fcpI
   oIMUbwmOrsIj9ALK8j8BB1udMMSTjji4YXHY/JKPgHXq9lwvJMM8l+q1h
   QRYJilrUF9uXuRrdjQKGtXIUYwE339Mv1z3VxAB6G8vq0NU8FPIs9iqO6
   E7UUcJS6d+vbxALMwHEAHUy99K54hPFHlIEnM6cUlxggnIR8bURW5VseW
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10409"; a="283520331"
X-IronPort-AV: E=Sophos;i="5.92,275,1650956400"; 
   d="scan'208";a="283520331"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2022 23:31:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,275,1650956400"; 
   d="scan'208";a="629360092"
Received: from lkp-server02.sh.intel.com (HELO ff137eb26ff1) ([10.239.97.151])
  by orsmga001.jf.intel.com with ESMTP; 15 Jul 2022 23:31:00 -0700
Received: from kbuild by ff137eb26ff1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1oCbKO-0001E0-8n;
        Sat, 16 Jul 2022 06:31:00 +0000
Date:   Sat, 16 Jul 2022 14:30:54 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     linux-pm@vger.kernel.org, devel@acpica.org,
        linux-acpi@vger.kernel.org
Subject: [rafael-pm:bleeding-edge] BUILD SUCCESS
 940a7197e7544d2c88df2826b84fc324dd54ba47
Message-ID: <62d25b1e.6LLu6+/fikrj8XaM%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
branch HEAD: 940a7197e7544d2c88df2826b84fc324dd54ba47  Merge branch 'acpi-video' into bleeding-edge

elapsed time: 721m

configs tested: 66
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm                              allyesconfig
arm64                            allyesconfig
powerpc                 mpc85xx_cds_defconfig
arm                        mvebu_v7_defconfig
parisc                generic-32bit_defconfig
mips                           jazz_defconfig
arm                          simpad_defconfig
arm                       multi_v4t_defconfig
ia64                             allmodconfig
alpha                             allnoconfig
arc                               allnoconfig
riscv                             allnoconfig
csky                              allnoconfig
m68k                             allmodconfig
arc                              allyesconfig
alpha                            allyesconfig
m68k                             allyesconfig
powerpc                           allnoconfig
powerpc                          allmodconfig
mips                             allyesconfig
sh                               allmodconfig
i386                                defconfig
i386                             allyesconfig
x86_64                        randconfig-a004
x86_64                        randconfig-a002
x86_64                        randconfig-a006
i386                          randconfig-a001
i386                          randconfig-a003
i386                          randconfig-a005
x86_64                        randconfig-a013
x86_64                        randconfig-a011
x86_64                        randconfig-a015
i386                          randconfig-a014
i386                          randconfig-a012
i386                          randconfig-a016
arc                  randconfig-r043-20220715
um                             i386_defconfig
um                           x86_64_defconfig
x86_64                          rhel-8.3-func
x86_64                    rhel-8.3-kselftests
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                           allyesconfig

clang tested configs:
arm                       versatile_defconfig
arm                          pcm027_defconfig
powerpc                      acadia_defconfig
powerpc                     mpc5200_defconfig
x86_64                        randconfig-a001
x86_64                        randconfig-a003
x86_64                        randconfig-a005
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
x86_64                        randconfig-a016
x86_64                        randconfig-a012
x86_64                        randconfig-a014
i386                          randconfig-a013
i386                          randconfig-a011
i386                          randconfig-a015
hexagon              randconfig-r045-20220715
hexagon              randconfig-r041-20220715
riscv                randconfig-r042-20220715
s390                 randconfig-r044-20220715

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
