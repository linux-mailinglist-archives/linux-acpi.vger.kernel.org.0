Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 946456E8CE0
	for <lists+linux-acpi@lfdr.de>; Thu, 20 Apr 2023 10:34:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234440AbjDTIev (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 20 Apr 2023 04:34:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234333AbjDTIeu (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 20 Apr 2023 04:34:50 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE31544B9;
        Thu, 20 Apr 2023 01:34:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681979676; x=1713515676;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=ZGv0L529q98voH1fbcNCSpvZnqgMKbsbJDSUtIJrtxQ=;
  b=ijMhiywOYlyEwrFublBat2ZFYorxGaHs57U316NiuCgtXwM8+VUQihCx
   KrheoUiDjGKvslCgLV91ZMjtsKkMJgbP4nh3GxirVV2FhlsjU4fvXHZwh
   4R2bRPvzkVSB3ljnB0UC/5NvmBYQ+WwDyNblfM3zYJm7UPaqSg7COZ9YB
   FZLSiYA254JkGQKqo4Ru57zQQsvwBJIEOu+yqv+RgFWF3sf/dO6CFzHGV
   tlZdlO3lZWzbu0OWHNtn53Z4Dq/AHiwzHDPahgh+oj95CSVmES3SO1oKC
   rfyqJ980OOtysN50dwqAWKlTMkbbm8iZ730c/v2J/MHRnEWZMzzUAfc0B
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10685"; a="344429251"
X-IronPort-AV: E=Sophos;i="5.99,212,1677571200"; 
   d="scan'208";a="344429251"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2023 01:34:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10685"; a="694394406"
X-IronPort-AV: E=Sophos;i="5.99,212,1677571200"; 
   d="scan'208";a="694394406"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 20 Apr 2023 01:34:33 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1ppPkO-000fdC-1J;
        Thu, 20 Apr 2023 08:34:32 +0000
Date:   Thu, 20 Apr 2023 16:33:37 +0800
From:   kernel test robot <lkp@intel.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Mark Brown <broonie@kernel.org>, op-tee@lists.trustedfirmware.org,
        linux-xfs@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org,
        intel-gfx@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        Linux Memory Management List <linux-mm@kvack.org>
Subject: [linux-next:master] BUILD REGRESSION
 3cdbc01c40e34c57697f8934f2727a88551696be
Message-ID: <6440f8e1.DHft6gojVbeQoyZh%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git master
branch HEAD: 3cdbc01c40e34c57697f8934f2727a88551696be  Add linux-next specific files for 20230419

Error/Warning reports:

https://lore.kernel.org/oe-kbuild-all/202304102354.Q4VOXGTE-lkp@intel.com
https://lore.kernel.org/oe-kbuild-all/202304200812.6UqNDVZy-lkp@intel.com
https://lore.kernel.org/oe-kbuild-all/202304201027.2upm4i0C-lkp@intel.com
https://lore.kernel.org/oe-kbuild-all/202304201216.YgbKeHUJ-lkp@intel.com

Error/Warning: (recently discovered and may have been fixed)

drivers/gpu/drm/amd/amdgpu/../display/dc/dc_dmub_srv.c:184:19: warning: variable 'dmub' set but not used [-Wunused-but-set-variable]
drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dmub_abm.c:138:15: warning: variable 'feature_support' set but not used [-Wunused-but-set-variable]
drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dmub_abm_lcd.c:124:14: warning: no previous prototype for function 'dmub_abm_get_current_backlight' [-Wmissing-prototypes]
drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dmub_abm_lcd.c:135:14: warning: no previous prototype for function 'dmub_abm_get_target_backlight' [-Wmissing-prototypes]
drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dmub_abm_lcd.c:146:6: warning: no previous prototype for function 'dmub_abm_set_level' [-Wmissing-prototypes]
drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dmub_abm_lcd.c:167:6: warning: no previous prototype for function 'dmub_abm_set_ambient_level' [-Wmissing-prototypes]
drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dmub_abm_lcd.c:189:6: warning: no previous prototype for function 'dmub_abm_init_config' [-Wmissing-prototypes]
drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dmub_abm_lcd.c:221:6: warning: no previous prototype for function 'dmub_abm_set_pause' [-Wmissing-prototypes]
drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dmub_abm_lcd.c:241:6: warning: no previous prototype for function 'dmub_abm_set_pipe' [-Wmissing-prototypes]
drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dmub_abm_lcd.c:263:6: warning: no previous prototype for function 'dmub_abm_set_backlight_level' [-Wmissing-prototypes]
drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dmub_abm_lcd.c:83:6: warning: no previous prototype for function 'dmub_abm_init' [-Wmissing-prototypes]
drivers/gpu/drm/amd/amdgpu/../display/dc/link/link_validation.c:351:13: warning: variable 'bw_needed' set but not used [-Wunused-but-set-variable]
drivers/gpu/drm/amd/amdgpu/../display/dc/link/link_validation.c:352:25: warning: variable 'link' set but not used [-Wunused-but-set-variable]
drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c:451:16: warning: variable 'j' set but not used [-Wunused-but-set-variable]
drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c:1049:6: warning: no previous prototype for 'gfx_v9_4_3_disable_gpa_mode' [-Wmissing-prototypes]
drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c:1049:6: warning: no previous prototype for function 'gfx_v9_4_3_disable_gpa_mode' [-Wmissing-prototypes]
drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c:1072:6: warning: no previous prototype for 'gfx_v9_4_3_disable_gpa_mode' [-Wmissing-prototypes]
drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c:48:38: warning: unused variable 'golden_settings_gc_9_4_3' [-Wunused-const-variable]
drivers/gpu/drm/i915/gt/uc/guc_capture_fwif.h:62: warning: wrong kernel-doc identifier on line:
drivers/gpu/drm/i915/i915_pmu.h:41: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
drivers/gpu/drm/i915/i915_request.h:176: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
drivers/gpu/drm/i915/i915_vma.h:145: warning: expecting prototype for i915_vma_offset(). Prototype was for i915_vma_size() instead
drivers/phy/mediatek/phy-mtk-hdmi-mt8195.c:298:6: warning: variable 'ret' is uninitialized when used here [-Wuninitialized]
ld.lld: error: .btf.vmlinux.bin.o: unknown file type
phy-mtk-hdmi-mt8195.c:(.text+0x2e2): undefined reference to `__floatundidf'
phy-mtk-hdmi-mt8195.c:(.text+0x2f4): undefined reference to `__ltdf2'
phy-mtk-hdmi-mt8195.c:(.text+0x344): undefined reference to `__gedf2'
riscv64-linux-ld: phy-mtk-hdmi-mt8195.c:(.text+0x312): undefined reference to `__gedf2'
riscv64-linux-ld: phy-mtk-hdmi-mt8195.c:(.text+0x32c): undefined reference to `__ltdf2'

Unverified Error/Warning (likely false positive, please contact us if interested):

drivers/acpi/property.c:985 acpi_data_prop_read_single() error: potentially dereferencing uninitialized 'obj'.
drivers/firmware/smccc/smccc.c:20:21: sparse: sparse: symbol 'smccc_soc_id_version' was not declared. Should it be static?
drivers/firmware/smccc/smccc.c:21:21: sparse: sparse: symbol 'smccc_soc_id_revision' was not declared. Should it be static?
drivers/phy/mediatek/phy-mtk-hdmi-mt8195.c:240 mtk_hdmi_pll_calc() warn: impossible condition '(tmds_clk < 1.483500e+02 * 1000000) => (0.000000e+00-1.844674e+19 < -1.786711e-113)'
drivers/phy/mediatek/phy-mtk-hdmi-mt8195.c:242 mtk_hdmi_pll_calc() warn: always true condition '(tmds_clk >= 1.483500e+02 * 1000000) => (0-u64max >= -1.786711e-113)'
drivers/phy/mediatek/phy-mtk-hdmi-mt8195.c:242 mtk_hdmi_pll_calc() warn: impossible condition '(tmds_clk < 2.967000e+02 * 1000000) => (0.000000e+00-1.844674e+19 < -4.419080e+60)'
drivers/phy/mediatek/phy-mtk-hdmi-mt8195.c:244 mtk_hdmi_pll_calc() warn: always true condition '(tmds_clk >= 2.967000e+02 * 1000000) => (0-u64max >= -4.419080e+60)'
drivers/phy/mediatek/phy-mtk-hdmi-mt8195.c:298 mtk_hdmi_pll_calc() error: uninitialized symbol 'ret'.
drivers/phy/mediatek/phy-mtk-hdmi-mt8195.c:331 mtk_hdmi_pll_drv_setting() warn: always true condition '(pixel_clk >= 7.417500e+01 * 1000000) => (0-u32max >= -7.223985e-287)'
drivers/phy/mediatek/phy-mtk-hdmi-mt8195.c:336 mtk_hdmi_pll_drv_setting() warn: impossible condition '(pixel_clk < 7.417500e+01 * 1000000) => (0.000000e+00-4.294967e+09 < -7.223985e-287)'
drivers/tee/optee/smc_abi.c:1021 irq_handler() error: uninitialized symbol 'value_valid'.
drivers/tee/optee/smc_abi.c:1028 irq_handler() error: uninitialized symbol 'value_pending'.
fs/xfs/scrub/refcount.c: xfs_mount.h is included more than once.
fs/xfs/scrub/refcount.c: xfs_trans_resv.h is included more than once.

Error/Warning ids grouped by kconfigs:

gcc_recent_errors
|-- alpha-allyesconfig
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-link-link_validation.c:warning:variable-bw_needed-set-but-not-used
|   `-- drivers-gpu-drm-amd-amdgpu-..-display-dc-link-link_validation.c:warning:variable-link-set-but-not-used
|-- alpha-randconfig-r001-20230420
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-link-link_validation.c:warning:variable-bw_needed-set-but-not-used
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-link-link_validation.c:warning:variable-link-set-but-not-used
|   `-- drivers-gpu-drm-amd-amdgpu-amdgpu_gfx.c:warning:variable-j-set-but-not-used
|-- alpha-randconfig-r023-20230420
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-link-link_validation.c:warning:variable-bw_needed-set-but-not-used
|   `-- drivers-gpu-drm-amd-amdgpu-..-display-dc-link-link_validation.c:warning:variable-link-set-but-not-used
|-- arc-allyesconfig
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-link-link_validation.c:warning:variable-bw_needed-set-but-not-used
|   `-- drivers-gpu-drm-amd-amdgpu-..-display-dc-link-link_validation.c:warning:variable-link-set-but-not-used
|-- arc-buildonly-randconfig-r004-20230419
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-link-link_validation.c:warning:variable-bw_needed-set-but-not-used
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-link-link_validation.c:warning:variable-link-set-but-not-used
|   `-- drivers-gpu-drm-amd-amdgpu-amdgpu_gfx.c:warning:variable-j-set-but-not-used
|-- arc-randconfig-r043-20230420
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
|-- arm64-randconfig-m041-20230419
|   |-- drivers-tee-optee-smc_abi.c-irq_handler()-error:uninitialized-symbol-value_pending-.
|   `-- drivers-tee-optee-smc_abi.c-irq_handler()-error:uninitialized-symbol-value_valid-.
|-- arm64-randconfig-r003-20230417
|   `-- drivers-gpu-drm-amd-amdgpu-amdgpu_gfx.c:warning:variable-j-set-but-not-used
|-- arm64-randconfig-s031-20230416
|   |-- drivers-firmware-smccc-smccc.c:sparse:sparse:symbol-smccc_soc_id_revision-was-not-declared.-Should-it-be-static
|   `-- drivers-firmware-smccc-smccc.c:sparse:sparse:symbol-smccc_soc_id_version-was-not-declared.-Should-it-be-static
|-- csky-randconfig-m041-20230419
|   |-- drivers-phy-mediatek-phy-mtk-hdmi-mt8195.c-mtk_hdmi_pll_calc()-error:uninitialized-symbol-ret-.
|   |-- drivers-phy-mediatek-phy-mtk-hdmi-mt8195.c-mtk_hdmi_pll_calc()-warn:always-true-condition-(tmds_clk-.483500e-)-(-u64max-.786711e-)
|   |-- drivers-phy-mediatek-phy-mtk-hdmi-mt8195.c-mtk_hdmi_pll_calc()-warn:always-true-condition-(tmds_clk-.967000e-)-(-u64max-.419080e-)
|   |-- drivers-phy-mediatek-phy-mtk-hdmi-mt8195.c-mtk_hdmi_pll_calc()-warn:impossible-condition-(tmds_clk-.483500e-)-(.000000e-.844674e-.786711e-)
|   |-- drivers-phy-mediatek-phy-mtk-hdmi-mt8195.c-mtk_hdmi_pll_calc()-warn:impossible-condition-(tmds_clk-.967000e-)-(.000000e-.844674e-.419080e-)
|   |-- drivers-phy-mediatek-phy-mtk-hdmi-mt8195.c-mtk_hdmi_pll_drv_setting()-warn:always-true-condition-(pixel_clk-.417500e-)-(-u32max-.223985e-)
|   `-- drivers-phy-mediatek-phy-mtk-hdmi-mt8195.c-mtk_hdmi_pll_drv_setting()-warn:impossible-condition-(pixel_clk-.417500e-)-(.000000e-.294967e-.223985e-)
|-- csky-randconfig-r024-20230417
|   `-- drivers-gpu-drm-amd-amdgpu-amdgpu_gfx.c:warning:variable-j-set-but-not-used
|-- i386-allyesconfig
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-link-link_validation.c:warning:variable-bw_needed-set-but-not-used
|   `-- drivers-gpu-drm-amd-amdgpu-..-display-dc-link-link_validation.c:warning:variable-link-set-but-not-used
|-- i386-randconfig-m021-20230417
|   `-- drivers-acpi-property.c-acpi_data_prop_read_single()-error:potentially-dereferencing-uninitialized-obj-.
|-- ia64-allmodconfig
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-link-link_validation.c:warning:variable-bw_needed-set-but-not-used
|   `-- drivers-gpu-drm-amd-amdgpu-..-display-dc-link-link_validation.c:warning:variable-link-set-but-not-used
|-- ia64-randconfig-r034-20230416
|   |-- drivers-gpu-drm-amd-amdgpu-amdgpu_gfx.c:warning:variable-j-set-but-not-used
|   `-- drivers-gpu-drm-amd-amdgpu-gfx_v9_4_3.c:warning:no-previous-prototype-for-gfx_v9_4_3_disable_gpa_mode
|-- ia64-randconfig-s043-20230416
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-link-link_validation.c:warning:variable-bw_needed-set-but-not-used
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-link-link_validation.c:warning:variable-link-set-but-not-used
|   |-- drivers-gpu-drm-amd-amdgpu-amdgpu_gfx.c:warning:variable-j-set-but-not-used
|   `-- drivers-gpu-drm-amd-amdgpu-gfx_v9_4_3.c:warning:no-previous-prototype-for-gfx_v9_4_3_disable_gpa_mode
|-- loongarch-allmodconfig
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-link-link_validation.c:warning:variable-bw_needed-set-but-not-used
|   `-- drivers-gpu-drm-amd-amdgpu-..-display-dc-link-link_validation.c:warning:variable-link-set-but-not-used
|-- loongarch-defconfig
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-link-link_validation.c:warning:variable-bw_needed-set-but-not-used
|   `-- drivers-gpu-drm-amd-amdgpu-..-display-dc-link-link_validation.c:warning:variable-link-set-but-not-used
|-- microblaze-randconfig-m041-20230416
|   |-- drivers-gpu-drm-amd-amdgpu-amdgpu_gfx.c:warning:variable-j-set-but-not-used
|   `-- drivers-gpu-drm-amd-amdgpu-gfx_v9_4_3.c:warning:no-previous-prototype-for-gfx_v9_4_3_disable_gpa_mode
|-- microblaze-randconfig-r004-20230420
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-link-link_validation.c:warning:variable-bw_needed-set-but-not-used
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-link-link_validation.c:warning:variable-link-set-but-not-used
|   `-- drivers-gpu-drm-amd-amdgpu-amdgpu_gfx.c:warning:variable-j-set-but-not-used
|-- mips-allmodconfig
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-link-link_validation.c:warning:variable-bw_needed-set-but-not-used
|   `-- drivers-gpu-drm-amd-amdgpu-..-display-dc-link-link_validation.c:warning:variable-link-set-but-not-used
|-- mips-allyesconfig
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-link-link_validation.c:warning:variable-bw_needed-set-but-not-used
|   `-- drivers-gpu-drm-amd-amdgpu-..-display-dc-link-link_validation.c:warning:variable-link-set-but-not-used
|-- mips-randconfig-c003-20230420
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-link-link_validation.c:warning:variable-bw_needed-set-but-not-used
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-link-link_validation.c:warning:variable-link-set-but-not-used
|   |-- drivers-gpu-drm-amd-amdgpu-amdgpu_gfx.c:warning:variable-j-set-but-not-used
|   `-- drivers-gpu-drm-amd-amdgpu-gfx_v9_4_3.c:warning:no-previous-prototype-for-gfx_v9_4_3_disable_gpa_mode
|-- mips-randconfig-s041-20230416
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-dce-dmub_abm_lcd.c:sparse:sparse:cast-truncates-bits-from-constant-value-(ffff-becomes-ff)
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-link-link_validation.c:warning:variable-bw_needed-set-but-not-used
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-link-link_validation.c:warning:variable-link-set-but-not-used
|   `-- drivers-gpu-drm-amd-amdgpu-amdgpu_gfx.c:warning:variable-j-set-but-not-used
|-- openrisc-randconfig-c003-20230416
|   `-- drivers-gpu-drm-amd-amdgpu-amdgpu_gfx.c:warning:variable-j-set-but-not-used
|-- parisc-buildonly-randconfig-r003-20230419
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-link-link_validation.c:warning:variable-bw_needed-set-but-not-used
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-link-link_validation.c:warning:variable-link-set-but-not-used
|   `-- drivers-gpu-drm-amd-amdgpu-amdgpu_gfx.c:warning:variable-j-set-but-not-used
|-- powerpc-allmodconfig
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-link-link_validation.c:warning:variable-bw_needed-set-but-not-used
|   `-- drivers-gpu-drm-amd-amdgpu-..-display-dc-link-link_validation.c:warning:variable-link-set-but-not-used
|-- riscv-allmodconfig
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-link-link_validation.c:warning:variable-bw_needed-set-but-not-used
|   `-- drivers-gpu-drm-amd-amdgpu-..-display-dc-link-link_validation.c:warning:variable-link-set-but-not-used
|-- riscv-randconfig-r016-20230416
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-link-link_validation.c:warning:variable-bw_needed-set-but-not-used
|   `-- drivers-gpu-drm-amd-amdgpu-..-display-dc-link-link_validation.c:warning:variable-link-set-but-not-used
|-- riscv-randconfig-s052-20230416
|   |-- drivers-gpu-drm-amd-amdgpu-amdgpu_gfx.c:warning:variable-j-set-but-not-used
|   |-- drivers-gpu-drm-amd-amdgpu-gfx_v9_4_3.c:warning:no-previous-prototype-for-gfx_v9_4_3_disable_gpa_mode
|   |-- phy-mtk-hdmi-mt8195.c:(.text):undefined-reference-to-__floatundidf
|   |-- phy-mtk-hdmi-mt8195.c:(.text):undefined-reference-to-__gedf2
|   |-- phy-mtk-hdmi-mt8195.c:(.text):undefined-reference-to-__ltdf2
|   |-- riscv64-linux-ld:phy-mtk-hdmi-mt8195.c:(.text):undefined-reference-to-__gedf2
|   `-- riscv64-linux-ld:phy-mtk-hdmi-mt8195.c:(.text):undefined-reference-to-__ltdf2
|-- s390-allyesconfig
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-link-link_validation.c:warning:variable-bw_needed-set-but-not-used
|   `-- drivers-gpu-drm-amd-amdgpu-..-display-dc-link-link_validation.c:warning:variable-link-set-but-not-used
|-- sparc-allmodconfig
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-link-link_validation.c:warning:variable-bw_needed-set-but-not-used
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-link-link_validation.c:warning:variable-link-set-but-not-used
|   |-- drivers-gpu-drm-amd-amdgpu-amdgpu_gfx.c:warning:variable-j-set-but-not-used
|   `-- drivers-gpu-drm-amd-amdgpu-gfx_v9_4_3.c:warning:no-previous-prototype-for-gfx_v9_4_3_disable_gpa_mode
|-- sparc64-randconfig-s053-20230416
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-link-link_validation.c:warning:variable-bw_needed-set-but-not-used
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-link-link_validation.c:warning:variable-link-set-but-not-used
|   |-- drivers-gpu-drm-amd-amdgpu-amdgpu_gfx.c:warning:variable-j-set-but-not-used
|   `-- drivers-gpu-drm-amd-amdgpu-gfx_v9_4_3.c:warning:no-previous-prototype-for-gfx_v9_4_3_disable_gpa_mode
|-- x86_64-allnoconfig
|   |-- fs-xfs-scrub-refcount.c:xfs_mount.h-is-included-more-than-once.
|   `-- fs-xfs-scrub-refcount.c:xfs_trans_resv.h-is-included-more-than-once.
|-- x86_64-allyesconfig
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-link-link_validation.c:warning:variable-bw_needed-set-but-not-used
|   `-- drivers-gpu-drm-amd-amdgpu-..-display-dc-link-link_validation.c:warning:variable-link-set-but-not-used
`-- x86_64-randconfig-m001-20230417
    `-- drivers-acpi-property.c-acpi_data_prop_read_single()-error:potentially-dereferencing-uninitialized-obj-.
clang_recent_errors
|-- arm64-buildonly-randconfig-r005-20230416
|   `-- drivers-phy-mediatek-phy-mtk-hdmi-mt8195.c:warning:variable-ret-is-uninitialized-when-used-here
|-- arm64-randconfig-r015-20230417
|   `-- drivers-phy-mediatek-phy-mtk-hdmi-mt8195.c:warning:variable-ret-is-uninitialized-when-used-here
|-- arm64-randconfig-r036-20230416
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-dc_dmub_srv.c:warning:variable-dmub-set-but-not-used
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-dce-dmub_abm.c:warning:variable-feature_support-set-but-not-used
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-dce-dmub_abm_lcd.c:warning:no-previous-prototype-for-function-dmub_abm_get_current_backlight
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-dce-dmub_abm_lcd.c:warning:no-previous-prototype-for-function-dmub_abm_get_target_backlight
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-dce-dmub_abm_lcd.c:warning:no-previous-prototype-for-function-dmub_abm_init
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-dce-dmub_abm_lcd.c:warning:no-previous-prototype-for-function-dmub_abm_init_config
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-dce-dmub_abm_lcd.c:warning:no-previous-prototype-for-function-dmub_abm_set_ambient_level
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-dce-dmub_abm_lcd.c:warning:no-previous-prototype-for-function-dmub_abm_set_backlight_level
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-dce-dmub_abm_lcd.c:warning:no-previous-prototype-for-function-dmub_abm_set_level
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-dce-dmub_abm_lcd.c:warning:no-previous-prototype-for-function-dmub_abm_set_pause
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-dce-dmub_abm_lcd.c:warning:no-previous-prototype-for-function-dmub_abm_set_pipe
|   |-- drivers-gpu-drm-amd-amdgpu-gfx_v9_4_3.c:warning:no-previous-prototype-for-function-gfx_v9_4_3_disable_gpa_mode
|   `-- drivers-gpu-drm-amd-amdgpu-gfx_v9_4_3.c:warning:unused-variable-golden_settings_gc_9_4_3
|-- hexagon-randconfig-r023-20230417
|   `-- ld.lld:error:.btf.vmlinux.bin.o:unknown-file-type
|-- hexagon-randconfig-r045-20230420
|   `-- drivers-phy-mediatek-phy-mtk-hdmi-mt8195.c:warning:variable-ret-is-uninitialized-when-used-here
|-- mips-randconfig-r021-20230420
|   `-- drivers-phy-mediatek-phy-mtk-hdmi-mt8195.c:warning:variable-ret-is-uninitialized-when-used-here
|-- riscv-buildonly-randconfig-r006-20230419
|   `-- drivers-phy-mediatek-phy-mtk-hdmi-mt8195.c:warning:variable-ret-is-uninitialized-when-used-here
|-- riscv-randconfig-r032-20230416
|   `-- drivers-phy-mediatek-phy-mtk-hdmi-mt8195.c:warning:variable-ret-is-uninitialized-when-used-here
`-- x86_64-randconfig-a011-20230417
    |-- drivers-gpu-drm-i915-gt-uc-guc_capture_fwif.h:warning:wrong-kernel-doc-identifier-on-line:
    |-- drivers-gpu-drm-i915-i915_pmu.h:warning:This-comment-starts-with-but-isn-t-a-kernel-doc-comment.-Refer-Documentation-doc-guide-kernel-doc.rst
    |-- drivers-gpu-drm-i915-i915_request.h:warning:This-comment-starts-with-but-isn-t-a-kernel-doc-comment.-Refer-Documentation-doc-guide-kernel-doc.rst
    `-- drivers-gpu-drm-i915-i915_vma.h:warning:expecting-prototype-for-i915_vma_offset().-Prototype-was-for-i915_vma_size()-instead

elapsed time: 734m

configs tested: 190
configs skipped: 20

tested configs:
alpha                            allyesconfig   gcc  
alpha        buildonly-randconfig-r005-20230417   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r001-20230416   gcc  
alpha                randconfig-r001-20230420   gcc  
alpha                randconfig-r003-20230416   gcc  
alpha                randconfig-r013-20230416   gcc  
alpha                randconfig-r023-20230420   gcc  
arc                              allyesconfig   gcc  
arc          buildonly-randconfig-r002-20230418   gcc  
arc          buildonly-randconfig-r004-20230417   gcc  
arc          buildonly-randconfig-r004-20230419   gcc  
arc          buildonly-randconfig-r006-20230416   gcc  
arc                                 defconfig   gcc  
arc                  randconfig-r043-20230416   gcc  
arc                  randconfig-r043-20230417   gcc  
arc                  randconfig-r043-20230419   gcc  
arc                  randconfig-r043-20230420   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                         at91_dt_defconfig   gcc  
arm                                 defconfig   gcc  
arm                          ep93xx_defconfig   clang
arm                            hisi_defconfig   gcc  
arm                        keystone_defconfig   gcc  
arm                           omap1_defconfig   clang
arm                  randconfig-r006-20230416   gcc  
arm                  randconfig-r046-20230416   clang
arm                  randconfig-r046-20230417   gcc  
arm                  randconfig-r046-20230419   gcc  
arm                  randconfig-r046-20230420   clang
arm                           tegra_defconfig   gcc  
arm64                            allyesconfig   gcc  
arm64        buildonly-randconfig-r004-20230418   clang
arm64        buildonly-randconfig-r005-20230416   clang
arm64        buildonly-randconfig-r005-20230419   gcc  
arm64                               defconfig   gcc  
arm64                randconfig-r003-20230417   gcc  
arm64                randconfig-r015-20230417   clang
arm64                randconfig-r036-20230416   clang
csky         buildonly-randconfig-r004-20230416   gcc  
csky         buildonly-randconfig-r006-20230418   gcc  
csky                                defconfig   gcc  
csky                 randconfig-r024-20230417   gcc  
csky                 randconfig-r025-20230416   gcc  
csky                 randconfig-r026-20230420   gcc  
hexagon              randconfig-r005-20230417   clang
hexagon              randconfig-r012-20230417   clang
hexagon              randconfig-r016-20230417   clang
hexagon              randconfig-r023-20230417   clang
hexagon              randconfig-r031-20230418   clang
hexagon              randconfig-r035-20230416   clang
hexagon              randconfig-r041-20230416   clang
hexagon              randconfig-r041-20230417   clang
hexagon              randconfig-r041-20230419   clang
hexagon              randconfig-r041-20230420   clang
hexagon              randconfig-r045-20230416   clang
hexagon              randconfig-r045-20230417   clang
hexagon              randconfig-r045-20230419   clang
hexagon              randconfig-r045-20230420   clang
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
i386                 randconfig-r006-20230417   gcc  
ia64                             allmodconfig   gcc  
ia64                                defconfig   gcc  
ia64                 randconfig-r022-20230416   gcc  
ia64                 randconfig-r022-20230417   gcc  
ia64                 randconfig-r026-20230416   gcc  
ia64                 randconfig-r034-20230416   gcc  
ia64                 randconfig-r036-20230418   gcc  
ia64                            zx1_defconfig   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
m68k                             allmodconfig   gcc  
m68k                          atari_defconfig   gcc  
m68k                                defconfig   gcc  
m68k                        m5272c3_defconfig   gcc  
microblaze   buildonly-randconfig-r003-20230418   gcc  
microblaze           randconfig-r004-20230420   gcc  
microblaze           randconfig-r021-20230417   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips                         cobalt_defconfig   gcc  
mips                  decstation_64_defconfig   gcc  
mips                malta_qemu_32r6_defconfig   clang
mips                        omega2p_defconfig   clang
mips                 randconfig-r012-20230416   clang
mips                 randconfig-r014-20230417   gcc  
mips                 randconfig-r021-20230420   clang
mips                 randconfig-r034-20230418   gcc  
nios2        buildonly-randconfig-r006-20230417   gcc  
nios2                               defconfig   gcc  
nios2                randconfig-r002-20230417   gcc  
nios2                randconfig-r025-20230417   gcc  
openrisc     buildonly-randconfig-r001-20230418   gcc  
openrisc     buildonly-randconfig-r002-20230416   gcc  
openrisc             randconfig-r011-20230417   gcc  
parisc       buildonly-randconfig-r002-20230417   gcc  
parisc       buildonly-randconfig-r003-20230419   gcc  
parisc                              defconfig   gcc  
parisc               randconfig-r021-20230416   gcc  
parisc               randconfig-r023-20230416   gcc  
parisc               randconfig-r024-20230416   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                      cm5200_defconfig   gcc  
powerpc                    gamecube_defconfig   clang
powerpc                    klondike_defconfig   gcc  
powerpc                      makalu_defconfig   gcc  
powerpc                mpc7448_hpc2_defconfig   gcc  
powerpc                     rainier_defconfig   gcc  
powerpc                     redwood_defconfig   gcc  
powerpc                     skiroot_defconfig   clang
powerpc                     taishan_defconfig   gcc  
powerpc                         wii_defconfig   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv        buildonly-randconfig-r003-20230416   gcc  
riscv        buildonly-randconfig-r003-20230417   clang
riscv        buildonly-randconfig-r006-20230419   clang
riscv                               defconfig   gcc  
riscv                randconfig-r005-20230416   clang
riscv                randconfig-r016-20230416   gcc  
riscv                randconfig-r032-20230416   clang
riscv                randconfig-r032-20230418   clang
riscv                randconfig-r042-20230416   gcc  
riscv                randconfig-r042-20230417   clang
riscv                randconfig-r042-20230419   clang
riscv                randconfig-r042-20230420   gcc  
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r002-20230420   clang
s390                 randconfig-r003-20230420   clang
s390                 randconfig-r044-20230416   gcc  
s390                 randconfig-r044-20230417   clang
s390                 randconfig-r044-20230419   clang
s390                 randconfig-r044-20230420   gcc  
sh                               allmodconfig   gcc  
sh           buildonly-randconfig-r001-20230416   gcc  
sh                         ecovec24_defconfig   gcc  
sh                          r7785rp_defconfig   gcc  
sh                   randconfig-r004-20230417   gcc  
sh                   randconfig-r011-20230416   gcc  
sh                          rsk7264_defconfig   gcc  
sparc                               defconfig   gcc  
sparc                       sparc32_defconfig   gcc  
sparc64      buildonly-randconfig-r002-20230419   gcc  
sparc64              randconfig-r026-20230417   gcc  
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
x86_64                           rhel-8.3-bpf   gcc  
x86_64                         rhel-8.3-kunit   gcc  
x86_64                           rhel-8.3-kvm   gcc  
x86_64                           rhel-8.3-syz   gcc  
x86_64                               rhel-8.3   gcc  
xtensa               randconfig-r015-20230416   gcc  
xtensa                    smp_lx200_defconfig   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
