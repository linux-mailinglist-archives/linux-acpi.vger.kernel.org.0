Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3ACBC66593A
	for <lists+linux-acpi@lfdr.de>; Wed, 11 Jan 2023 11:43:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233116AbjAKKnK (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 11 Jan 2023 05:43:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231979AbjAKKnI (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 11 Jan 2023 05:43:08 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB07426DC;
        Wed, 11 Jan 2023 02:43:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673433787; x=1704969787;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=hbTE3mtmtPLjfx/z0S1cWEQoEQFuxh5WzqxpU3KYFO0=;
  b=dehngBonNIDrQZyqKr4LWLTp5zaOsRX3+QWiITvNS9gl/VTKf7UZI6fn
   M6KfOyCpdV98gioQEv16l/3I1iU3j7eVQNK4NgUF7KbwPT8Ra2/N22jGb
   4cGtgLgCxbPDwiTvDP4dFqmN05zk/2qFF50NDtXEQ+mhbplDJGUioJGE/
   zg9RAflNl+RhXFwgoiQZ15e36ujDQRC6zPGpyOQ4nsW0MAq1p12Sk7KRF
   BhngXhG4k/pT4W7bgwWjc7y9WvJJNWnpahdvVGJff95crdR83KPs0El74
   8E7zyONto2JumtmSVY5ROPnUcIOJz+JwshMlEKU/wTXZnJC3ccSMKCVN2
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10586"; a="323447929"
X-IronPort-AV: E=Sophos;i="5.96,315,1665471600"; 
   d="scan'208";a="323447929"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2023 02:43:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10586"; a="746110376"
X-IronPort-AV: E=Sophos;i="5.96,315,1665471600"; 
   d="scan'208";a="746110376"
Received: from lkp-server02.sh.intel.com (HELO f1920e93ebb5) ([10.239.97.151])
  by FMSMGA003.fm.intel.com with ESMTP; 11 Jan 2023 02:43:05 -0800
Received: from kbuild by f1920e93ebb5 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pFYZV-000927-17;
        Wed, 11 Jan 2023 10:43:05 +0000
Date:   Wed, 11 Jan 2023 18:42:33 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     linux-pm@vger.kernel.org, devel@acpica.org,
        linux-acpi@vger.kernel.org
Subject: [rafael-pm:bleeding-edge] BUILD SUCCESS
 60bbd3eb0af043a2c9f7309e6ce5fc573ee0e171
Message-ID: <63be9299.aULZ0NLJnbOCdI8f%lkp@intel.com>
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
branch HEAD: 60bbd3eb0af043a2c9f7309e6ce5fc573ee0e171  Merge branch 'pm-cpuidle' into bleeding-edge

elapsed time: 729m

configs tested: 67
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
alpha                             allnoconfig
i386                              allnoconfig
arc                               allnoconfig
arm                               allnoconfig
m68k                             allmodconfig
alpha                            allyesconfig
arc                                 defconfig
m68k                             allyesconfig
s390                             allmodconfig
powerpc                           allnoconfig
arc                              allyesconfig
alpha                               defconfig
s390                                defconfig
s390                             allyesconfig
x86_64                            allnoconfig
sh                               allmodconfig
mips                             allyesconfig
powerpc                          allmodconfig
arc                  randconfig-r043-20230110
i386                                defconfig
s390                 randconfig-r044-20230110
riscv                randconfig-r042-20230110
x86_64                              defconfig
x86_64                        randconfig-a004
um                             i386_defconfig
x86_64                        randconfig-a002
um                           x86_64_defconfig
x86_64                               rhel-8.3
x86_64                        randconfig-a006
ia64                             allmodconfig
i386                          randconfig-a001
i386                          randconfig-a003
x86_64                          rhel-8.3-func
x86_64                           rhel-8.3-bpf
x86_64                           rhel-8.3-syz
x86_64                    rhel-8.3-kselftests
x86_64                         rhel-8.3-kunit
x86_64                           rhel-8.3-kvm
i386                          randconfig-a005
x86_64                           allyesconfig
i386                             allyesconfig
x86_64                        randconfig-a013
x86_64                        randconfig-a011
x86_64                        randconfig-a015
i386                          randconfig-a014
i386                          randconfig-a012
i386                          randconfig-a016
arm                                 defconfig
riscv                             allnoconfig
arm64                            allyesconfig
arm                              allyesconfig

clang tested configs:
hexagon              randconfig-r041-20230110
arm                  randconfig-r046-20230110
hexagon              randconfig-r045-20230110
x86_64                        randconfig-a001
x86_64                        randconfig-a003
x86_64                        randconfig-a005
x86_64                          rhel-8.3-rust
i386                          randconfig-a002
i386                          randconfig-a004
i386                          randconfig-a006
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
i386                          randconfig-a013
i386                          randconfig-a011
i386                          randconfig-a015

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
