Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F7D132EBE2
	for <lists+linux-acpi@lfdr.de>; Fri,  5 Mar 2021 14:07:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230122AbhCENHV (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 5 Mar 2021 08:07:21 -0500
Received: from mail-oi1-f182.google.com ([209.85.167.182]:37345 "EHLO
        mail-oi1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230039AbhCENHG (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 5 Mar 2021 08:07:06 -0500
Received: by mail-oi1-f182.google.com with SMTP id l133so2427374oib.4;
        Fri, 05 Mar 2021 05:07:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7Ncgpy86VIPDXOvYFhowhdF2HbajJjddT/60denWMAU=;
        b=f2IKy3nFrzVgGn2YZl3J5myb7+DKi5GU4qP4oWz2FK1r5CRZ1mCsdkU5hUkhrvA3Cm
         Ux2mE3+WR3vQ+TDKQUTcNSEvkqPJpF7KfO5rSyVRJQPjQYUqQiPIL0UnDJkxMipfQv+R
         8nSvLe10A0NYVftNHUdDg6NdNViQ3tEQaIuOxtyTUwDp7wetP6CCQ2acD3H/MbPOGEKy
         HEm0EX3cbCU+0BV+BN/1/6CvjxvaXkrzHPgJgfru+5s5I7EZ1A86mZETZukWeJABjDY+
         j8npPhMPmrMwR3/4mcdtPRFaLWtawJDzqtknPY1iVzL8uztUuLDyuc4FBykgwMEh71HH
         38+w==
X-Gm-Message-State: AOAM531UKVu3r449HlYo4tJTVxhs7BJzy9mTXzMGQd2BMEp7aaILpSnQ
        VsxnvQ/82gHDjJ9FpZn0+l/ujPYmGWkJHIwR0i0=
X-Google-Smtp-Source: ABdhPJy56cSu8xf1HRMzkKd0Oqd6yMXKfEO0s7qGcoVgm0ykUxmt7LBd6ncH3P1VoJWwUOaaCgf0OHzVt82mnwJWu3M=
X-Received: by 2002:aca:3d85:: with SMTP id k127mr7278645oia.157.1614949626158;
 Fri, 05 Mar 2021 05:07:06 -0800 (PST)
MIME-Version: 1.0
References: <6041a2ff.18V+4AiVF2xWzVE+%lkp@intel.com> <YEIkhnfEMINzlZHH@smile.fi.intel.com>
In-Reply-To: <YEIkhnfEMINzlZHH@smile.fi.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 5 Mar 2021 14:06:54 +0100
Message-ID: <CAJZ5v0idCJBQkDfN8GuUt3YqzBjcMZ4EACPogm=+LyihYRhwcA@mail.gmail.com>
Subject: Re: [BUILD REGRESSION] LAST PATCH: gpiolib: Reuse device's fwnode to
 create IRQ domain
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     kernel test robot <lkp@intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Marc Zyngier <maz@kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, Mar 5, 2021 at 1:31 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Fri, Mar 05, 2021 at 11:18:23AM +0800, kernel test robot wrote:
> > url:    https://github.com/0day-ci/linux/commits/Andy-Shevchenko/gpiolib-switch-to-fwnode-in-the-core/20210304-230747
> > base:   https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git e749df1bbd23f4472082210650514548d8a39e9b
> >
> > [If your patch is applied to the wrong git tree, kindly drop us a note.
> > And when submitting patch, we suggest to use '--base' as documented in
> > https://git-scm.com/docs/git-format-patch]
> >
> >
> > Error/Warning in current branch:
> >
> > drivers/gpio/gpiolib.c:3672:24: warning: passing argument 1 of 'is_acpi_node' discards 'const' qualifier from pointer target type [-Wdiscarded-qualifiers]
> > drivers/gpio/gpiolib.c:3675:24: warning: passing argument 1 of 'is_acpi_node' discards 'const' qualifier from pointer target type [-Wdiscarded-qualifiers]
> > drivers/gpio/gpiolib.c:3686:24: error: passing 'const struct fwnode_handle *' to parameter of type 'struct fwnode_handle *' discards qualifiers [-Werror,-Wincompatible-pointer-types-discards-qualifiers]
> > drivers/gpio/gpiolib.c:3686:24: warning: passing argument 1 of 'is_acpi_node' discards 'const' qualifier from pointer target type [-Wdiscarded-qualifiers]
>
> Yeah, yeah. The fix should be in Rafael's tree.
>
> Rafael, can you submit it as material for v5.12-rcX, please?

What exactly do you want me to submit for 5.12-rc and why is it urgent?

> > Error/Warning ids grouped by kconfigs:
> >
> > gcc_recent_errors
> > |-- alpha-allmodconfig
> > |   `-- drivers-gpio-gpiolib.c:warning:passing-argument-of-is_acpi_node-discards-const-qualifier-from-pointer-target-type
> > |-- alpha-allyesconfig
> > |   `-- drivers-gpio-gpiolib.c:warning:passing-argument-of-is_acpi_node-discards-const-qualifier-from-pointer-target-type
> > |-- arc-allyesconfig
> > |   `-- drivers-gpio-gpiolib.c:warning:passing-argument-of-is_acpi_node-discards-const-qualifier-from-pointer-target-type
> > |-- arc-randconfig-r016-20210304
> > |   `-- drivers-gpio-gpiolib.c:warning:passing-argument-of-is_acpi_node-discards-const-qualifier-from-pointer-target-type
> > |-- arc-randconfig-r026-20210304
> > |   `-- drivers-gpio-gpiolib.c:warning:passing-argument-of-is_acpi_node-discards-const-qualifier-from-pointer-target-type
> > |-- arc-randconfig-s031-20210304
> > |   |-- drivers-gpio-gpiolib.c:sparse:sparse:incorrect-type-in-argument-(different-modifiers)-expected-struct-fwnode_handle-fwnode-got-struct-fwnode_handle-const-fwnode
> > |   `-- drivers-gpio-gpiolib.c:warning:passing-argument-of-is_acpi_node-discards-const-qualifier-from-pointer-target-type
> > |-- arm-allmodconfig
> > |   `-- drivers-gpio-gpiolib.c:warning:passing-argument-of-is_acpi_node-discards-const-qualifier-from-pointer-target-type
> > |-- arm-allyesconfig
> > |   `-- drivers-gpio-gpiolib.c:warning:passing-argument-of-is_acpi_node-discards-const-qualifier-from-pointer-target-type
> > |-- arm-colibri_pxa270_defconfig
> > |   `-- drivers-gpio-gpiolib.c:warning:passing-argument-of-is_acpi_node-discards-const-qualifier-from-pointer-target-type
> > |-- arm-defconfig
> > |   `-- drivers-gpio-gpiolib.c:warning:passing-argument-of-is_acpi_node-discards-const-qualifier-from-pointer-target-type
> > |-- arm-imx_v4_v5_defconfig
> > |   `-- drivers-gpio-gpiolib.c:warning:passing-argument-of-is_acpi_node-discards-const-qualifier-from-pointer-target-type
> > |-- arm-randconfig-c003-20210304
> > |   `-- drivers-gpio-gpiolib.c:warning:passing-argument-of-is_acpi_node-discards-const-qualifier-from-pointer-target-type
> > |-- arm-randconfig-p002-20210304
> > |   `-- drivers-gpio-gpiolib.c:warning:passing-argument-of-is_acpi_node-discards-const-qualifier-from-pointer-target-type
> > |-- arm-randconfig-r022-20210304
> > |   `-- drivers-gpio-gpiolib.c:warning:passing-argument-of-is_acpi_node-discards-const-qualifier-from-pointer-target-type
> > |-- arm-randconfig-r025-20210304
> > |   `-- drivers-gpio-gpiolib.c:warning:passing-argument-of-is_acpi_node-discards-const-qualifier-from-pointer-target-type
> > |-- h8300-allyesconfig
> > |   `-- drivers-gpio-gpiolib.c:warning:passing-argument-of-is_acpi_node-discards-const-qualifier-from-pointer-target-type
> > |-- h8300-randconfig-r016-20210304
> > |   `-- drivers-gpio-gpiolib.c:warning:passing-argument-of-is_acpi_node-discards-const-qualifier-from-pointer-target-type
> > |-- h8300-randconfig-s031-20210304
> > |   |-- drivers-gpio-gpiolib.c:sparse:sparse:incorrect-type-in-argument-(different-modifiers)-expected-struct-fwnode_handle-fwnode-got-struct-fwnode_handle-const-fwnode
> > |   `-- drivers-gpio-gpiolib.c:warning:passing-argument-of-is_acpi_node-discards-const-qualifier-from-pointer-target-type
> > |-- m68k-allmodconfig
> > |   `-- drivers-gpio-gpiolib.c:warning:passing-argument-of-is_acpi_node-discards-const-qualifier-from-pointer-target-type
> > |-- m68k-allyesconfig
> > |   `-- drivers-gpio-gpiolib.c:warning:passing-argument-of-is_acpi_node-discards-const-qualifier-from-pointer-target-type
> > |-- m68k-randconfig-m031-20210304
> > |   `-- drivers-gpio-gpiolib.c:warning:passing-argument-of-is_acpi_node-discards-const-qualifier-from-pointer-target-type
> > |-- m68k-randconfig-r005-20210304
> > |   `-- drivers-gpio-gpiolib.c:warning:passing-argument-of-is_acpi_node-discards-const-qualifier-from-pointer-target-type
> > |-- microblaze-randconfig-m031-20210304
> > |   `-- drivers-gpio-gpiolib.c:warning:passing-argument-of-is_acpi_node-discards-const-qualifier-from-pointer-target-type
> > |-- microblaze-randconfig-r011-20210304
> > |   `-- drivers-gpio-gpiolib.c:warning:passing-argument-of-is_acpi_node-discards-const-qualifier-from-pointer-target-type
> > |-- microblaze-randconfig-r015-20210304
> > |   `-- drivers-gpio-gpiolib.c:warning:passing-argument-of-is_acpi_node-discards-const-qualifier-from-pointer-target-type
> > |-- microblaze-randconfig-r025-20210304
> > |   `-- drivers-gpio-gpiolib.c:warning:passing-argument-of-is_acpi_node-discards-const-qualifier-from-pointer-target-type
> > |-- microblaze-randconfig-s032-20210304
> > |   |-- drivers-gpio-gpiolib.c:sparse:sparse:incorrect-type-in-argument-(different-modifiers)-expected-struct-fwnode_handle-fwnode-got-struct-fwnode_handle-const-fwnode
> > |   `-- drivers-gpio-gpiolib.c:warning:passing-argument-of-is_acpi_node-discards-const-qualifier-from-pointer-target-type
> > |-- mips-allmodconfig
> > |   `-- drivers-gpio-gpiolib.c:warning:passing-argument-of-is_acpi_node-discards-const-qualifier-from-pointer-target-type
> > |-- mips-allyesconfig
> > |   `-- drivers-gpio-gpiolib.c:warning:passing-argument-of-is_acpi_node-discards-const-qualifier-from-pointer-target-type
> > |-- mips-cu1830-neo_defconfig
> > |   `-- drivers-gpio-gpiolib.c:warning:passing-argument-of-is_acpi_node-discards-const-qualifier-from-pointer-target-type
> > |-- mips-randconfig-m031-20210304
> > |   `-- drivers-gpio-gpiolib.c:warning:passing-argument-of-is_acpi_node-discards-const-qualifier-from-pointer-target-type
> > |-- mips-randconfig-r024-20210304
> > |   `-- drivers-gpio-gpiolib.c:warning:passing-argument-of-is_acpi_node-discards-const-qualifier-from-pointer-target-type
> > |-- nds32-allyesconfig
> > |   `-- drivers-gpio-gpiolib.c:warning:passing-argument-of-is_acpi_node-discards-const-qualifier-from-pointer-target-type
> > |-- nds32-randconfig-m031-20210304
> > |   `-- drivers-gpio-gpiolib.c:warning:passing-argument-of-is_acpi_node-discards-const-qualifier-from-pointer-target-type
> > |-- nds32-randconfig-r024-20210304
> > |   `-- drivers-gpio-gpiolib.c:warning:passing-argument-of-is_acpi_node-discards-const-qualifier-from-pointer-target-type
> > |-- nds32-randconfig-r031-20210304
> > |   `-- drivers-gpio-gpiolib.c:warning:passing-argument-of-is_acpi_node-discards-const-qualifier-from-pointer-target-type
> > |-- nds32-randconfig-r035-20210304
> > |   `-- drivers-gpio-gpiolib.c:warning:passing-argument-of-is_acpi_node-discards-const-qualifier-from-pointer-target-type
> > |-- nios2-allyesconfig
> > |   `-- drivers-gpio-gpiolib.c:warning:passing-argument-of-is_acpi_node-discards-const-qualifier-from-pointer-target-type
> > |-- nios2-randconfig-r013-20210304
> > |   `-- drivers-gpio-gpiolib.c:warning:passing-argument-of-is_acpi_node-discards-const-qualifier-from-pointer-target-type
> > |-- nios2-randconfig-r023-20210304
> > |   `-- drivers-gpio-gpiolib.c:warning:passing-argument-of-is_acpi_node-discards-const-qualifier-from-pointer-target-type
> > |-- openrisc-allmodconfig
> > |   `-- drivers-gpio-gpiolib.c:warning:passing-argument-of-is_acpi_node-discards-const-qualifier-from-pointer-target-type
> > |-- openrisc-allnoconfig
> > |   `-- drivers-gpio-gpiolib.c:warning:passing-argument-of-is_acpi_node-discards-const-qualifier-from-pointer-target-type
> > |-- parisc-allyesconfig
> > |   `-- drivers-gpio-gpiolib.c:warning:passing-argument-of-is_acpi_node-discards-const-qualifier-from-pointer-target-type
> > |-- parisc-randconfig-r031-20210304
> > |   `-- drivers-gpio-gpiolib.c:warning:passing-argument-of-is_acpi_node-discards-const-qualifier-from-pointer-target-type
> > |-- parisc-randconfig-r036-20210304
> > |   `-- drivers-gpio-gpiolib.c:warning:passing-argument-of-is_acpi_node-discards-const-qualifier-from-pointer-target-type
> > |-- powerpc-allmodconfig
> > |   `-- drivers-gpio-gpiolib.c:warning:passing-argument-of-is_acpi_node-discards-const-qualifier-from-pointer-target-type
> > |-- powerpc-allyesconfig
> > |   `-- drivers-gpio-gpiolib.c:warning:passing-argument-of-is_acpi_node-discards-const-qualifier-from-pointer-target-type
> > |-- powerpc-stx_gp3_defconfig
> > |   `-- drivers-gpio-gpiolib.c:warning:passing-argument-of-is_acpi_node-discards-const-qualifier-from-pointer-target-type
> > |-- powerpc64-randconfig-r032-20210304
> > |   `-- drivers-gpio-gpiolib.c:warning:passing-argument-of-is_acpi_node-discards-const-qualifier-from-pointer-target-type
> > |-- powerpc64-randconfig-r033-20210304
> > |   `-- drivers-gpio-gpiolib.c:warning:passing-argument-of-is_acpi_node-discards-const-qualifier-from-pointer-target-type
> > |-- riscv-allmodconfig
> > |   `-- drivers-gpio-gpiolib.c:warning:passing-argument-of-is_acpi_node-discards-const-qualifier-from-pointer-target-type
> > |-- riscv-allyesconfig
> > |   `-- drivers-gpio-gpiolib.c:warning:passing-argument-of-is_acpi_node-discards-const-qualifier-from-pointer-target-type
> > |-- riscv-defconfig
> > |   `-- drivers-gpio-gpiolib.c:warning:passing-argument-of-is_acpi_node-discards-const-qualifier-from-pointer-target-type
> > |-- riscv-nommu_k210_defconfig
> > |   `-- drivers-gpio-gpiolib.c:warning:passing-argument-of-is_acpi_node-discards-const-qualifier-from-pointer-target-type
> > |-- riscv-nommu_k210_sdcard_defconfig
> > |   `-- drivers-gpio-gpiolib.c:warning:passing-argument-of-is_acpi_node-discards-const-qualifier-from-pointer-target-type
> > |-- riscv-randconfig-r002-20210304
> > |   `-- drivers-gpio-gpiolib.c:warning:passing-argument-of-is_acpi_node-discards-const-qualifier-from-pointer-target-type
> > |-- s390-allmodconfig
> > |   `-- drivers-gpio-gpiolib.c:warning:passing-argument-of-is_acpi_node-discards-const-qualifier-from-pointer-target-type
> > |-- s390-allyesconfig
> > |   `-- drivers-gpio-gpiolib.c:warning:passing-argument-of-is_acpi_node-discards-const-qualifier-from-pointer-target-type
> > |-- s390-randconfig-p001-20210304
> > |   `-- drivers-gpio-gpiolib.c:warning:passing-argument-of-is_acpi_node-discards-const-qualifier-from-pointer-target-type
> > |-- s390-randconfig-s032-20210304
> > |   |-- drivers-gpio-gpiolib.c:sparse:sparse:incorrect-type-in-argument-(different-modifiers)-expected-struct-fwnode_handle-fwnode-got-struct-fwnode_handle-const-fwnode
> > |   `-- drivers-gpio-gpiolib.c:warning:passing-argument-of-is_acpi_node-discards-const-qualifier-from-pointer-target-type
> > |-- sh-allmodconfig
> > |   `-- drivers-gpio-gpiolib.c:warning:passing-argument-of-is_acpi_node-discards-const-qualifier-from-pointer-target-type
> > |-- sh-magicpanelr2_defconfig
> > |   `-- drivers-gpio-gpiolib.c:warning:passing-argument-of-is_acpi_node-discards-const-qualifier-from-pointer-target-type
> > |-- sh-randconfig-r013-20210304
> > |   `-- drivers-gpio-gpiolib.c:warning:passing-argument-of-is_acpi_node-discards-const-qualifier-from-pointer-target-type
> > |-- sh-randconfig-r034-20210304
> > |   `-- drivers-gpio-gpiolib.c:warning:passing-argument-of-is_acpi_node-discards-const-qualifier-from-pointer-target-type
> > |-- sparc-allyesconfig
> > |   `-- drivers-gpio-gpiolib.c:warning:passing-argument-of-is_acpi_node-discards-const-qualifier-from-pointer-target-type
> > |-- sparc-randconfig-r003-20210304
> > |   `-- drivers-gpio-gpiolib.c:warning:passing-argument-of-is_acpi_node-discards-const-qualifier-from-pointer-target-type
> > |-- sparc64-randconfig-r033-20210304
> > |   `-- drivers-gpio-gpiolib.c:warning:passing-argument-of-is_acpi_node-discards-const-qualifier-from-pointer-target-type
> > |-- xtensa-allyesconfig
> > |   `-- drivers-gpio-gpiolib.c:warning:passing-argument-of-is_acpi_node-discards-const-qualifier-from-pointer-target-type
> > `-- xtensa-randconfig-s032-20210304
> >     |-- drivers-gpio-gpiolib.c:sparse:sparse:incorrect-type-in-argument-(different-modifiers)-expected-struct-fwnode_handle-fwnode-got-struct-fwnode_handle-const-fwnode
> >     `-- drivers-gpio-gpiolib.c:warning:passing-argument-of-is_acpi_node-discards-const-qualifier-from-pointer-target-type
> >
> > clang_recent_errors
> > `-- arm64-randconfig-r022-20210304
> >     `-- drivers-gpio-gpiolib.c:error:passing-const-struct-fwnode_handle-to-parameter-of-type-struct-fwnode_handle-discards-qualifiers-Werror-Wincompatible-pointer-types-discards-qualifiers
> >
> > elapsed time: 720m
> >
> > configs tested: 111
> > configs skipped: 2
> >
> > gcc tested configs:
> > arm                                 defconfig
> > arm64                            allyesconfig
> > arm                              allyesconfig
> > arm                              allmodconfig
> > arm64                               defconfig
> > sh                 kfr2r09-romimage_defconfig
> > xtensa                    xip_kc705_defconfig
> > powerpc                    mvme5100_defconfig
> > m68k                        m5307c3_defconfig
> > sh                ecovec24-romimage_defconfig
> > sparc64                          alldefconfig
> > arm                            dove_defconfig
> > arm                       multi_v4t_defconfig
> > openrisc                         alldefconfig
> > sh                               j2_defconfig
> > m68k                            mac_defconfig
> > powerpc                       maple_defconfig
> > mips                     cu1830-neo_defconfig
> > powerpc                 linkstation_defconfig
> > x86_64                              defconfig
> > arm                  colibri_pxa270_defconfig
> > xtensa                           alldefconfig
> > powerpc                     tqm5200_defconfig
> > openrisc                            defconfig
> > sh                           se7712_defconfig
> > mips                          ath79_defconfig
> > arm                           viper_defconfig
> > arm                       imx_v4_v5_defconfig
> > xtensa                       common_defconfig
> > powerpc                     stx_gp3_defconfig
> > sh                        edosk7705_defconfig
> > sh                     magicpanelr2_defconfig
> > ia64                        generic_defconfig
> > riscv             nommu_k210_sdcard_defconfig
> > mips                      maltasmvp_defconfig
> > xtensa                           allyesconfig
> > powerpc                     pseries_defconfig
> > h8300                               defconfig
> > riscv                          rv32_defconfig
> > powerpc                  iss476-smp_defconfig
> > arm                    vt8500_v6_v7_defconfig
> > sh                           se7750_defconfig
> > sh                          polaris_defconfig
> > powerpc                        fsp2_defconfig
> > ia64                             allmodconfig
> > ia64                                defconfig
> > ia64                             allyesconfig
> > m68k                             allmodconfig
> > m68k                                defconfig
> > m68k                             allyesconfig
> > nios2                               defconfig
> > arc                              allyesconfig
> > nds32                             allnoconfig
> > nds32                               defconfig
> > nios2                            allyesconfig
> > csky                                defconfig
> > alpha                               defconfig
> > alpha                            allyesconfig
> > h8300                            allyesconfig
> > arc                                 defconfig
> > sh                               allmodconfig
> > parisc                              defconfig
> > s390                             allyesconfig
> > s390                             allmodconfig
> > parisc                           allyesconfig
> > s390                                defconfig
> > i386                             allyesconfig
> > sparc                            allyesconfig
> > sparc                               defconfig
> > i386                               tinyconfig
> > i386                                defconfig
> > mips                             allyesconfig
> > mips                             allmodconfig
> > powerpc                          allyesconfig
> > powerpc                          allmodconfig
> > powerpc                           allnoconfig
> > x86_64               randconfig-a006-20210304
> > x86_64               randconfig-a001-20210304
> > x86_64               randconfig-a004-20210304
> > x86_64               randconfig-a005-20210304
> > x86_64               randconfig-a002-20210304
> > x86_64               randconfig-a003-20210304
> > i386                 randconfig-a005-20210304
> > i386                 randconfig-a003-20210304
> > i386                 randconfig-a002-20210304
> > i386                 randconfig-a004-20210304
> > i386                 randconfig-a006-20210304
> > i386                 randconfig-a001-20210304
> > i386                 randconfig-a016-20210304
> > i386                 randconfig-a012-20210304
> > i386                 randconfig-a013-20210304
> > i386                 randconfig-a014-20210304
> > i386                 randconfig-a011-20210304
> > i386                 randconfig-a015-20210304
> > riscv                    nommu_k210_defconfig
> > riscv                            allyesconfig
> > riscv                    nommu_virt_defconfig
> > riscv                             allnoconfig
> > riscv                               defconfig
> > riscv                            allmodconfig
> > x86_64                           allyesconfig
> > x86_64                    rhel-7.6-kselftests
> > x86_64                               rhel-8.3
> > x86_64                      rhel-8.3-kbuiltin
> > x86_64                                  kexec
> >
> > clang tested configs:
> > x86_64               randconfig-a013-20210304
> > x86_64               randconfig-a016-20210304
> > x86_64               randconfig-a015-20210304
> > x86_64               randconfig-a014-20210304
> > x86_64               randconfig-a012-20210304
> > x86_64               randconfig-a011-20210304
> >
> > ---
> > 0-DAY CI Kernel Test Service, Intel Corporation
> > https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
>
> --
> With Best Regards,
> Andy Shevchenko
>
>
