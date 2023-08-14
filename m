Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7147277C158
	for <lists+linux-acpi@lfdr.de>; Mon, 14 Aug 2023 22:14:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231901AbjHNUNf (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 14 Aug 2023 16:13:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229952AbjHNUNZ (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 14 Aug 2023 16:13:25 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 906C313E;
        Mon, 14 Aug 2023 13:13:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692044003; x=1723580003;
  h=date:from:to:cc:subject:message-id;
  bh=hqw5SfjEoG+z3rv5ZlFyo7lmRfDYcSlFwwV0692yl0c=;
  b=Y+h5IxFyzIbNUYnexnd/Ufjx6U5uuEy5CQFvAEW9gWL+HdapNjZ67H7H
   zkhj+zcCjQFJZxeXceEpz5eh259ogrNIQqa5PCO0arnlA0rn5d1Tna9zA
   P2ztP8C1ro2noIFkI8WXvtmfY8KT/o0Oz/tu9h8OJybQqq65b3EuFVaCD
   gN6EW6/dOuToLgVUX60DwwjSwWlB0CQyusk010bhR7B8j4SGO8toJwTNt
   5zO2CAInsbKFUp8fnB4T3w0pOPCwqDxzRvAQRU9hu5NzX7ZQvOh/6CbqE
   l9f53Dmtp8wDyXG/mgCuj468DkUOfnPOXezsnmaoRdEh7k+zfU2g9bvX9
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10802"; a="369604778"
X-IronPort-AV: E=Sophos;i="6.01,173,1684825200"; 
   d="scan'208";a="369604778"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2023 13:13:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10802"; a="683421919"
X-IronPort-AV: E=Sophos;i="6.01,173,1684825200"; 
   d="scan'208";a="683421919"
Received: from lkp-server02.sh.intel.com (HELO b5fb8d9e1ffc) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 14 Aug 2023 13:13:16 -0700
Received: from kbuild by b5fb8d9e1ffc with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qVdw3-0000OP-1c;
        Mon, 14 Aug 2023 20:13:10 +0000
Date:   Tue, 15 Aug 2023 04:12:24 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     linux-acpi@vger.kernel.org, devel@acpica.org,
        linux-pm@vger.kernel.org
Subject: [rafael-pm:bleeding-edge] BUILD SUCCESS
 dd86d4481e181c84b56d260878a59ea7931930f7
Message-ID: <202308150422.7eREQLcb-lkp@intel.com>
User-Agent: s-nail v14.9.24
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
branch HEAD: dd86d4481e181c84b56d260878a59ea7931930f7  Merge branch 'thermal/bleeding-edge' of ssh://gitolite.kernel.org/pub/scm/linux/kernel/git/thermal/linux into bleeding-edge

elapsed time: 720m

configs tested: 97
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r023-20230814   gcc  
alpha                randconfig-r035-20230814   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                  randconfig-r036-20230814   gcc  
arc                  randconfig-r043-20230814   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   gcc  
arm                  randconfig-r046-20230814   gcc  
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
arm64                randconfig-r006-20230814   gcc  
csky                                defconfig   gcc  
csky                 randconfig-r022-20230814   gcc  
hexagon              randconfig-r026-20230814   clang
hexagon              randconfig-r041-20230814   clang
hexagon              randconfig-r045-20230814   clang
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-r004-20230814   gcc  
i386         buildonly-randconfig-r005-20230814   gcc  
i386         buildonly-randconfig-r006-20230814   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                 randconfig-i001-20230814   gcc  
i386                 randconfig-i002-20230814   gcc  
i386                 randconfig-i003-20230814   gcc  
i386                 randconfig-i004-20230814   gcc  
i386                 randconfig-i005-20230814   gcc  
i386                 randconfig-i006-20230814   gcc  
i386                 randconfig-i011-20230814   clang
i386                 randconfig-i012-20230814   clang
i386                 randconfig-i013-20230814   clang
i386                 randconfig-i014-20230814   clang
i386                 randconfig-i015-20230814   clang
i386                 randconfig-i016-20230814   clang
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch            randconfig-r004-20230814   gcc  
m68k                             allmodconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                randconfig-r003-20230814   gcc  
openrisc             randconfig-r005-20230814   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc              randconfig-r021-20230814   clang
powerpc              randconfig-r024-20230814   clang
powerpc              randconfig-r031-20230814   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   gcc  
riscv                               defconfig   gcc  
riscv                randconfig-r042-20230814   clang
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r044-20230814   clang
sh                               allmodconfig   gcc  
sh                   randconfig-r032-20230814   gcc  
sh                   randconfig-r034-20230814   gcc  
sparc                            allyesconfig   gcc  
sparc                               defconfig   gcc  
sparc64              randconfig-r025-20230814   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   clang
um                                  defconfig   gcc  
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64       buildonly-randconfig-r001-20230814   gcc  
x86_64       buildonly-randconfig-r002-20230814   gcc  
x86_64       buildonly-randconfig-r003-20230814   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64               randconfig-r033-20230814   gcc  
x86_64               randconfig-x006-20230814   clang
x86_64               randconfig-x011-20230814   gcc  
x86_64               randconfig-x012-20230814   gcc  
x86_64               randconfig-x013-20230814   gcc  
x86_64               randconfig-x014-20230814   gcc  
x86_64               randconfig-x015-20230814   gcc  
x86_64               randconfig-x016-20230814   gcc  
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa               randconfig-r002-20230814   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
