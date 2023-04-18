Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 540BA6E59EC
	for <lists+linux-acpi@lfdr.de>; Tue, 18 Apr 2023 08:56:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230252AbjDRG4g (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 18 Apr 2023 02:56:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231136AbjDRG4a (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 18 Apr 2023 02:56:30 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27FB16A52;
        Mon, 17 Apr 2023 23:56:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681800965; x=1713336965;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=cxF13p8SCEtnlzosb7qH6VytQ/OvmdwB769JK2OzYAg=;
  b=BbmQ+zivQBU9BF5aghO9MXtCJSitIf8vVz3A6cZQr2NAV6f/vz1lMo5J
   WVQgdK3nbMe6bq03wbsMbL/x0S/MBdBBc+hBKT9UDaVX1u+6HviJVjdaB
   P6mCOgbQq5vMO+l//MT/FdG1m2+Ie1Ue/9j+CuAuBM0f9CaiBh8vEPxye
   PRCdh41s56ORDvh9wdsVIhucVECutkgUWbIQTVWkMpdgDEUetE4gSiHbm
   0QNc8SwIJGKK+kgzOCB079EXHJO8F3S4FNgdFNuHWO7Bt8dZ0RPy/lXJX
   RpDaj6c6VGqUJZU/0rgamXjxzXp+4npXJq4eH43Kimfx3zHbppN49nu2w
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10683"; a="325432671"
X-IronPort-AV: E=Sophos;i="5.99,206,1677571200"; 
   d="scan'208";a="325432671"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2023 23:55:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10683"; a="815096197"
X-IronPort-AV: E=Sophos;i="5.99,206,1677571200"; 
   d="scan'208";a="815096197"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 17 Apr 2023 23:55:24 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pofFL-000d4p-2b;
        Tue, 18 Apr 2023 06:55:23 +0000
Date:   Tue, 18 Apr 2023 14:55:11 +0800
From:   kernel test robot <lkp@intel.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Mark Brown <broonie@kernel.org>, linux-xfs@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org,
        intel-gfx@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        Linux Memory Management List <linux-mm@kvack.org>
Subject: [linux-next:master] BUILD REGRESSION
 4aa1da8d99724f6c0b762b58a71cee7c5e2e109b
Message-ID: <643e3ecf.IXV1BGGBUFf0iS6O%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git master
branch HEAD: 4aa1da8d99724f6c0b762b58a71cee7c5e2e109b  Add linux-next specific files for 20230417

Error/Warning reports:

https://lore.kernel.org/oe-kbuild-all/202304102354.Q4VOXGTE-lkp@intel.com

Error/Warning: (recently discovered and may have been fixed)

drivers/clk/clk-sp7021.c:316:8: warning: result of comparison of constant 18446744073709551615 with expression of type 'typeof (_Generic((_m), char: (unsigned char)0, unsigned char: (unsigned char)0, signed char: (unsigned char)0, unsigned short: (unsigned short)0, short: (unsigned short)0, unsigned int: (unsigned int)0, int: (unsigned int)0, unsigned long: (unsigned long)0, long: (unsigned long)0, unsigned long long: (unsigned long long)0, long long: (unsigned long long)0, default: (_m)))' (aka 'unsigned int') is always false [-Wtautological-constant-out-of-range-compare]
drivers/gpu/drm/amd/amdgpu/../display/dc/link/link_validation.c:351:13: warning: variable 'bw_needed' set but not used [-Wunused-but-set-variable]
drivers/gpu/drm/amd/amdgpu/../display/dc/link/link_validation.c:352:25: warning: variable 'link' set but not used [-Wunused-but-set-variable]
drivers/gpu/drm/i915/gt/uc/guc_capture_fwif.h:62: warning: wrong kernel-doc identifier on line:
drivers/gpu/drm/i915/i915_pmu.h:41: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
drivers/gpu/drm/i915/i915_request.h:176: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
drivers/gpu/drm/i915/i915_vma.h:145: warning: expecting prototype for i915_vma_offset(). Prototype was for i915_vma_size() instead
drivers/phy/mediatek/phy-mtk-hdmi-mt8195.c:298:6: warning: variable 'ret' is uninitialized when used here [-Wuninitialized]
nios2-linux-ld: phy-mtk-hdmi-mt8195.c:(.text+0x564): undefined reference to `__gesf2'
nios2-linux-ld: phy-mtk-hdmi-mt8195.c:(.text+0x584): undefined reference to `__ltsf2'
phy-mtk-hdmi-mt8195.c:(.text+0x550): undefined reference to `__floatunsisf'

Unverified Error/Warning (likely false positive, please contact us if interested):

drivers/acpi/property.c:985 acpi_data_prop_read_single() error: potentially dereferencing uninitialized 'obj'.
fs/xfs/scrub/refcount.c: xfs_mount.h is included more than once.
fs/xfs/scrub/refcount.c: xfs_trans_resv.h is included more than once.

Error/Warning ids grouped by kconfigs:

gcc_recent_errors
|-- alpha-allyesconfig
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-link-link_validation.c:warning:variable-bw_needed-set-but-not-used
|   `-- drivers-gpu-drm-amd-amdgpu-..-display-dc-link-link_validation.c:warning:variable-link-set-but-not-used
|-- arc-allyesconfig
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-link-link_validation.c:warning:variable-bw_needed-set-but-not-used
|   `-- drivers-gpu-drm-amd-amdgpu-..-display-dc-link-link_validation.c:warning:variable-link-set-but-not-used
|-- arm-allmodconfig
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-link-link_validation.c:warning:variable-bw_needed-set-but-not-used
|   `-- drivers-gpu-drm-amd-amdgpu-..-display-dc-link-link_validation.c:warning:variable-link-set-but-not-used
|-- arm-allyesconfig
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-link-link_validation.c:warning:variable-bw_needed-set-but-not-used
|   `-- drivers-gpu-drm-amd-amdgpu-..-display-dc-link-link_validation.c:warning:variable-link-set-but-not-used
|-- arm64-allyesconfig
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-link-link_validation.c:warning:variable-bw_needed-set-but-not-used
|   `-- drivers-gpu-drm-amd-amdgpu-..-display-dc-link-link_validation.c:warning:variable-link-set-but-not-used
|-- i386-allyesconfig
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-link-link_validation.c:warning:variable-bw_needed-set-but-not-used
|   `-- drivers-gpu-drm-amd-amdgpu-..-display-dc-link-link_validation.c:warning:variable-link-set-but-not-used
|-- i386-randconfig-m021-20230417
|   `-- drivers-acpi-property.c-acpi_data_prop_read_single()-error:potentially-dereferencing-uninitialized-obj-.
|-- ia64-allmodconfig
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-link-link_validation.c:warning:variable-bw_needed-set-but-not-used
|   `-- drivers-gpu-drm-amd-amdgpu-..-display-dc-link-link_validation.c:warning:variable-link-set-but-not-used
|-- ia64-randconfig-r002-20230416
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-link-link_validation.c:warning:variable-bw_needed-set-but-not-used
|   `-- drivers-gpu-drm-amd-amdgpu-..-display-dc-link-link_validation.c:warning:variable-link-set-but-not-used
|-- loongarch-allmodconfig
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-link-link_validation.c:warning:variable-bw_needed-set-but-not-used
|   `-- drivers-gpu-drm-amd-amdgpu-..-display-dc-link-link_validation.c:warning:variable-link-set-but-not-used
|-- loongarch-defconfig
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-link-link_validation.c:warning:variable-bw_needed-set-but-not-used
|   `-- drivers-gpu-drm-amd-amdgpu-..-display-dc-link-link_validation.c:warning:variable-link-set-but-not-used
|-- loongarch-randconfig-r015-20230411
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-link-link_validation.c:warning:variable-bw_needed-set-but-not-used
|   `-- drivers-gpu-drm-amd-amdgpu-..-display-dc-link-link_validation.c:warning:variable-link-set-but-not-used
|-- microblaze-randconfig-r001-20230416
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-link-link_validation.c:warning:variable-bw_needed-set-but-not-used
|   `-- drivers-gpu-drm-amd-amdgpu-..-display-dc-link-link_validation.c:warning:variable-link-set-but-not-used
|-- mips-allmodconfig
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-link-link_validation.c:warning:variable-bw_needed-set-but-not-used
|   `-- drivers-gpu-drm-amd-amdgpu-..-display-dc-link-link_validation.c:warning:variable-link-set-but-not-used
|-- mips-allyesconfig
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-link-link_validation.c:warning:variable-bw_needed-set-but-not-used
|   `-- drivers-gpu-drm-amd-amdgpu-..-display-dc-link-link_validation.c:warning:variable-link-set-but-not-used
|-- mips-randconfig-c032-20230416
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-link-link_validation.c:warning:variable-bw_needed-set-but-not-used
|   `-- drivers-gpu-drm-amd-amdgpu-..-display-dc-link-link_validation.c:warning:variable-link-set-but-not-used
|-- mips-randconfig-r015-20230417
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-link-link_validation.c:warning:variable-bw_needed-set-but-not-used
|   `-- drivers-gpu-drm-amd-amdgpu-..-display-dc-link-link_validation.c:warning:variable-link-set-but-not-used
|-- nios2-randconfig-r014-20230413
|   |-- nios2-linux-ld:phy-mtk-hdmi-mt8195.c:(.text):undefined-reference-to-__gesf2
|   |-- nios2-linux-ld:phy-mtk-hdmi-mt8195.c:(.text):undefined-reference-to-__ltsf2
|   `-- phy-mtk-hdmi-mt8195.c:(.text):undefined-reference-to-__floatunsisf
|-- powerpc-allmodconfig
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-link-link_validation.c:warning:variable-bw_needed-set-but-not-used
|   `-- drivers-gpu-drm-amd-amdgpu-..-display-dc-link-link_validation.c:warning:variable-link-set-but-not-used
|-- riscv-allmodconfig
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-link-link_validation.c:warning:variable-bw_needed-set-but-not-used
|   `-- drivers-gpu-drm-amd-amdgpu-..-display-dc-link-link_validation.c:warning:variable-link-set-but-not-used
|-- s390-allyesconfig
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-link-link_validation.c:warning:variable-bw_needed-set-but-not-used
|   `-- drivers-gpu-drm-amd-amdgpu-..-display-dc-link-link_validation.c:warning:variable-link-set-but-not-used
|-- sparc-allyesconfig
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-link-link_validation.c:warning:variable-bw_needed-set-but-not-used
|   `-- drivers-gpu-drm-amd-amdgpu-..-display-dc-link-link_validation.c:warning:variable-link-set-but-not-used
|-- sparc64-randconfig-r004-20230417
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-link-link_validation.c:warning:variable-bw_needed-set-but-not-used
|   `-- drivers-gpu-drm-amd-amdgpu-..-display-dc-link-link_validation.c:warning:variable-link-set-but-not-used
|-- x86_64-allnoconfig
|   |-- fs-xfs-scrub-refcount.c:xfs_mount.h-is-included-more-than-once.
|   `-- fs-xfs-scrub-refcount.c:xfs_trans_resv.h-is-included-more-than-once.
|-- x86_64-allyesconfig
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-link-link_validation.c:warning:variable-bw_needed-set-but-not-used
|   `-- drivers-gpu-drm-amd-amdgpu-..-display-dc-link-link_validation.c:warning:variable-link-set-but-not-used
`-- x86_64-randconfig-m001-20230417
    `-- drivers-acpi-property.c-acpi_data_prop_read_single()-error:potentially-dereferencing-uninitialized-obj-.
clang_recent_errors
|-- arm-randconfig-r022-20230416
|   `-- drivers-phy-mediatek-phy-mtk-hdmi-mt8195.c:warning:variable-ret-is-uninitialized-when-used-here
|-- arm-randconfig-r024-20230416
|   |-- drivers-clk-clk-sp7021.c:warning:result-of-comparison-of-constant-with-expression-of-type-typeof-(_Generic((_m)-char:(unsigned-char)-unsigned-char:(unsigned-char)-signed-char:(unsigned-char)-unsigned-
|   `-- drivers-phy-mediatek-phy-mtk-hdmi-mt8195.c:warning:variable-ret-is-uninitialized-when-used-here
|-- arm64-buildonly-randconfig-r005-20230416
|   `-- drivers-phy-mediatek-phy-mtk-hdmi-mt8195.c:warning:variable-ret-is-uninitialized-when-used-here
|-- powerpc-randconfig-r032-20230416
|   `-- drivers-phy-mediatek-phy-mtk-hdmi-mt8195.c:warning:variable-ret-is-uninitialized-when-used-here
|-- powerpc-randconfig-r033-20230416
|   `-- drivers-phy-mediatek-phy-mtk-hdmi-mt8195.c:warning:variable-ret-is-uninitialized-when-used-here
`-- x86_64-randconfig-a011-20230417
    |-- drivers-gpu-drm-i915-gt-uc-guc_capture_fwif.h:warning:wrong-kernel-doc-identifier-on-line:
    |-- drivers-gpu-drm-i915-i915_pmu.h:warning:This-comment-starts-with-but-isn-t-a-kernel-doc-comment.-Refer-Documentation-doc-guide-kernel-doc.rst
    |-- drivers-gpu-drm-i915-i915_request.h:warning:This-comment-starts-with-but-isn-t-a-kernel-doc-comment.-Refer-Documentation-doc-guide-kernel-doc.rst
    `-- drivers-gpu-drm-i915-i915_vma.h:warning:expecting-prototype-for-i915_vma_offset().-Prototype-was-for-i915_vma_size()-instead

elapsed time: 724m

configs tested: 143
configs skipped: 17

tested configs:
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r001-20230417   gcc  
alpha                randconfig-r016-20230415   gcc  
alpha                randconfig-r036-20230417   gcc  
arc                              allyesconfig   gcc  
arc          buildonly-randconfig-r001-20230417   gcc  
arc                                 defconfig   gcc  
arc                  randconfig-r034-20230417   gcc  
arc                  randconfig-r036-20230416   gcc  
arc                  randconfig-r043-20230416   gcc  
arc                  randconfig-r043-20230417   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   gcc  
arm                  randconfig-r012-20230413   gcc  
arm                  randconfig-r022-20230416   clang
arm                  randconfig-r024-20230416   clang
arm                  randconfig-r046-20230416   clang
arm                  randconfig-r046-20230417   gcc  
arm                           sama5_defconfig   gcc  
arm                        shmobile_defconfig   gcc  
arm64                            allyesconfig   gcc  
arm64        buildonly-randconfig-r005-20230416   clang
arm64        buildonly-randconfig-r005-20230417   gcc  
arm64                               defconfig   gcc  
arm64                randconfig-r031-20230417   gcc  
csky         buildonly-randconfig-r006-20230416   gcc  
csky                                defconfig   gcc  
csky                 randconfig-r025-20230416   gcc  
hexagon              randconfig-r012-20230411   clang
hexagon              randconfig-r014-20230415   clang
hexagon              randconfig-r032-20230417   clang
hexagon              randconfig-r041-20230416   clang
hexagon              randconfig-r041-20230417   clang
hexagon              randconfig-r045-20230416   clang
hexagon              randconfig-r045-20230417   clang
i386                             allyesconfig   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                 randconfig-a001-20230417   gcc  
i386                 randconfig-a002-20230417   gcc  
i386                 randconfig-a003-20230417   gcc  
i386                 randconfig-a004-20230417   gcc  
i386                 randconfig-a005-20230417   gcc  
i386                 randconfig-a006-20230417   gcc  
i386                 randconfig-a011-20230417   clang
i386                 randconfig-a012-20230417   clang
i386                 randconfig-a013-20230417   clang
i386                 randconfig-a014-20230417   clang
i386                 randconfig-a015-20230417   clang
i386                 randconfig-a016-20230417   clang
ia64                             allmodconfig   gcc  
ia64                                defconfig   gcc  
ia64                 randconfig-r002-20230416   gcc  
ia64                 randconfig-r016-20230411   gcc  
ia64                 randconfig-r024-20230417   gcc  
ia64                 randconfig-r033-20230417   gcc  
ia64                 randconfig-r035-20230416   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch            randconfig-r012-20230417   gcc  
loongarch            randconfig-r015-20230411   gcc  
loongarch            randconfig-r022-20230417   gcc  
m68k                             allmodconfig   gcc  
m68k         buildonly-randconfig-r003-20230416   gcc  
m68k         buildonly-randconfig-r006-20230417   gcc  
m68k                                defconfig   gcc  
m68k                 randconfig-r011-20230413   gcc  
microblaze           randconfig-r001-20230416   gcc  
microblaze           randconfig-r011-20230417   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips                  maltasmvp_eva_defconfig   gcc  
mips                 randconfig-r015-20230417   gcc  
mips                 randconfig-r026-20230417   gcc  
nios2        buildonly-randconfig-r003-20230417   gcc  
nios2                               defconfig   gcc  
nios2                randconfig-r012-20230415   gcc  
nios2                randconfig-r014-20230413   gcc  
nios2                randconfig-r014-20230417   gcc  
nios2                randconfig-r015-20230413   gcc  
nios2                randconfig-r015-20230415   gcc  
nios2                randconfig-r023-20230416   gcc  
openrisc             randconfig-r006-20230416   gcc  
openrisc             randconfig-r013-20230415   gcc  
openrisc             randconfig-r021-20230416   gcc  
parisc                              defconfig   gcc  
parisc               randconfig-r013-20230411   gcc  
parisc               randconfig-r026-20230416   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                        cell_defconfig   gcc  
powerpc              randconfig-r031-20230416   clang
powerpc              randconfig-r032-20230416   clang
powerpc              randconfig-r033-20230416   clang
powerpc              randconfig-r034-20230416   clang
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                               defconfig   gcc  
riscv                randconfig-r003-20230417   gcc  
riscv                randconfig-r035-20230417   gcc  
riscv                randconfig-r042-20230416   gcc  
riscv                randconfig-r042-20230417   clang
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390         buildonly-randconfig-r001-20230416   gcc  
s390         buildonly-randconfig-r002-20230416   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r013-20230413   clang
s390                 randconfig-r044-20230416   gcc  
s390                 randconfig-r044-20230417   clang
sh                               allmodconfig   gcc  
sh           buildonly-randconfig-r002-20230417   gcc  
sh           buildonly-randconfig-r004-20230416   gcc  
sh                        dreamcast_defconfig   gcc  
sparc                            alldefconfig   gcc  
sparc                               defconfig   gcc  
sparc64              randconfig-r004-20230417   gcc  
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64               randconfig-a001-20230417   gcc  
x86_64               randconfig-a002-20230417   gcc  
x86_64               randconfig-a003-20230417   gcc  
x86_64               randconfig-a004-20230417   gcc  
x86_64               randconfig-a005-20230417   gcc  
x86_64               randconfig-a006-20230417   gcc  
x86_64               randconfig-a011-20230417   clang
x86_64               randconfig-a012-20230417   clang
x86_64               randconfig-a013-20230417   clang
x86_64               randconfig-a014-20230417   clang
x86_64               randconfig-a015-20230417   clang
x86_64               randconfig-a016-20230417   clang
x86_64               randconfig-r016-20230417   clang
x86_64                               rhel-8.3   gcc  
xtensa               randconfig-r021-20230417   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
