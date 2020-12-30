Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07DE72E79F3
	for <lists+linux-acpi@lfdr.de>; Wed, 30 Dec 2020 15:27:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726144AbgL3O0y (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 30 Dec 2020 09:26:54 -0500
Received: from mail-ot1-f41.google.com ([209.85.210.41]:35172 "EHLO
        mail-ot1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725814AbgL3O0x (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 30 Dec 2020 09:26:53 -0500
Received: by mail-ot1-f41.google.com with SMTP id i6so15503800otr.2;
        Wed, 30 Dec 2020 06:26:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fVwOdSg4kFV8PqFz9oWIuUkZshE6KT51XDsvu3Y+Dpc=;
        b=OWAQF7ES3Q56vq71QtPosz3qPTPlvgtQd8gRBwaaXdcqFZv3VGTuIRGL7g6IKunA21
         wLzeofYa9bgHrKg+LzQjRJVLqtRk4xwKDqidhPOH8X9j5qwN8p41UVOeBNIsE2AB5+ud
         cyWNjm8hzo51eaHQOn3jxwvQZjEpWCiLpSdp3Km9vb6U0IN0gaP5kIFvQ/HLq2d77W1I
         qZ8vBw5djov0XwxFiUVPKZ/yrEDj6/sLM/LHAkc46nnala5zK5YdCHgCT2hlKuUBheHB
         8dmdnfa+FAx9sHUM8OwzzvUELp61XPxCABCjptRwrQ45RV+gHaLUPaYdMed4FNDKYxvk
         /H+g==
X-Gm-Message-State: AOAM533CFv1dBmxOBUuKaaaOy1ucbNNW3sjUNS6wS/m6xoNea7htYMGB
        SMiSoealhEbcL2hKt5Abqo7pEsMS3FtJUnfUZM5QCgeC
X-Google-Smtp-Source: ABdhPJz27bxNRw0xI3mjSSm1Gd1rRzvwNq7eHGFYp/Xi3QBVX5FZT+xA17gB4C0XSguyTb3pzB7hX2UOUPWg0r616Eg=
X-Received: by 2002:a9d:745a:: with SMTP id p26mr40228278otk.206.1609338370359;
 Wed, 30 Dec 2020 06:26:10 -0800 (PST)
MIME-Version: 1.0
References: <5fec0d86.i0RjnNeExICZGSu7%lkp@intel.com>
In-Reply-To: <5fec0d86.i0RjnNeExICZGSu7%lkp@intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 30 Dec 2020 15:25:59 +0100
Message-ID: <CAJZ5v0gN3NfWyAHA7At=1ZG90vCJbDoUzF5ts2_t3GmunSbrMQ@mail.gmail.com>
Subject: Re: [pm:bleeding-edge] BUILD REGRESSION 0c7a6fd3a0e835b0158a1f52176f5d3858fac110
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Daniel,

On Wed, Dec 30, 2020 at 6:19 AM kernel test robot <lkp@intel.com> wrote:
>
> tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git  bleeding-edge
> branch HEAD: 0c7a6fd3a0e835b0158a1f52176f5d3858fac110  Merge branch 'pm-cpuidle-next' into bleeding-edge
>
> Error/Warning reports:
>
> https://lore.kernel.org/linux-acpi/202012180806.uUcdy2LC-lkp@intel.com
> https://lore.kernel.org/linux-acpi/202012271352.JvNDF17O-lkp@intel.com
> https://lore.kernel.org/linux-acpi/202012280239.stlWMtr3-lkp@intel.com
> https://lore.kernel.org/linux-acpi/202012280249.nrNm8Jn3-lkp@intel.com
>
> Error/Warning in current branch:
>
> drivers/acpi/platform_profile.c:147:24: warning: address of array 'pprof->choices' will always evaluate to 'true' [-Wpointer-bool-conversion]
> drivers/acpi/x86/s2idle.c:108:30: warning: variable 'info' set but not used [-Wunused-but-set-variable]
> drivers/acpi/x86/s2idle.c:138:25: warning: variable 'obj_new' set but not used [-Wunused-but-set-variable]
> dtpm.c:(.text+0x24c): undefined reference to `__udivdi3'
> dtpm.c:(.text+0x2a4): undefined reference to `__udivdi3'
> dtpm.c:(.text+0x3bc): undefined reference to `__udivdi3'
> dtpm.c:(.text+0x514): undefined reference to `__aeabi_uldivmod'
> dtpm.c:(.text+0x52d): undefined reference to `__udivdi3'

The above build issues come from the DTPM patches.

I was about to send a pull request including those patches later
today, but it looks like that would be premature.

Can you have a look at this, please?

> Error/Warning ids grouped by kconfigs:
>
> gcc_recent_errors
> |-- arm-allmodconfig
> |   `-- dtpm.c:(.text):undefined-reference-to-__aeabi_uldivmod
> |-- arm-allyesconfig
> |   `-- dtpm.c:(.text):undefined-reference-to-__aeabi_uldivmod
> |-- h8300-allmodconfig
> |   `-- dtpm.c:(.text):undefined-reference-to-__udivdi3
> |-- h8300-allyesconfig
> |   `-- dtpm.c:(.text):undefined-reference-to-__udivdi3
> |-- i386-allyesconfig
> |   `-- dtpm.c:(.text):undefined-reference-to-__udivdi3
> |-- i386-randconfig-a006-20201229
> |   |-- drivers-acpi-x86-s2idle.c:warning:variable-info-set-but-not-used
> |   `-- drivers-acpi-x86-s2idle.c:warning:variable-obj_new-set-but-not-used
> |-- i386-randconfig-r002-20201229
> |   |-- drivers-acpi-x86-s2idle.c:warning:variable-info-set-but-not-used
> |   `-- drivers-acpi-x86-s2idle.c:warning:variable-obj_new-set-but-not-used
> |-- i386-randconfig-s001-20201229
> |   |-- drivers-acpi-x86-s2idle.c:warning:variable-info-set-but-not-used
> |   `-- drivers-acpi-x86-s2idle.c:warning:variable-obj_new-set-but-not-used
> |-- m68k-allmodconfig
> |   `-- dtpm.c:(.text):undefined-reference-to-__udivdi3
> |-- m68k-allyesconfig
> |   `-- dtpm.c:(.text):undefined-reference-to-__udivdi3
> |-- sh-allmodconfig
> |   `-- dtpm.c:(.text):undefined-reference-to-__udivdi3
> |-- x86_64-randconfig-a002-20201229
> |   |-- drivers-acpi-x86-s2idle.c:warning:variable-info-set-but-not-used
> |   `-- drivers-acpi-x86-s2idle.c:warning:variable-obj_new-set-but-not-used
> |-- x86_64-randconfig-a004-20201229
> |   |-- drivers-acpi-x86-s2idle.c:warning:variable-info-set-but-not-used
> |   `-- drivers-acpi-x86-s2idle.c:warning:variable-obj_new-set-but-not-used
> `-- x86_64-randconfig-s021-20201229
>     |-- drivers-acpi-x86-s2idle.c:warning:variable-info-set-but-not-used
>     `-- drivers-acpi-x86-s2idle.c:warning:variable-obj_new-set-but-not-used
>
> clang_recent_errors
> |-- x86_64-randconfig-a011-20201229
> |   `-- drivers-acpi-platform_profile.c:warning:address-of-array-pprof-choices-will-always-evaluate-to-true
> |-- x86_64-randconfig-a012-20201229
> |   `-- drivers-acpi-platform_profile.c:warning:address-of-array-pprof-choices-will-always-evaluate-to-true
> |-- x86_64-randconfig-a013-20201229
> |   `-- drivers-acpi-platform_profile.c:warning:address-of-array-pprof-choices-will-always-evaluate-to-true
> |-- x86_64-randconfig-a014-20201229
> |   `-- drivers-acpi-platform_profile.c:warning:address-of-array-pprof-choices-will-always-evaluate-to-true
> |-- x86_64-randconfig-a015-20201229
> |   `-- drivers-acpi-platform_profile.c:warning:address-of-array-pprof-choices-will-always-evaluate-to-true
> `-- x86_64-randconfig-a016-20201229
>     `-- drivers-acpi-platform_profile.c:warning:address-of-array-pprof-choices-will-always-evaluate-to-true
>
> elapsed time: 724m
>
> configs tested: 95
> configs skipped: 2
>
> gcc tested configs:
> arm                                 defconfig
> arm64                            allyesconfig
> arm64                               defconfig
> arm                              allyesconfig
> arm                              allmodconfig
> sh                           se7619_defconfig
> sh                        sh7785lcr_defconfig
> arm                        trizeps4_defconfig
> mips                        workpad_defconfig
> um                           x86_64_defconfig
> mips                     cu1000-neo_defconfig
> m68k                          sun3x_defconfig
> mips                        bcm47xx_defconfig
> arm                            mps2_defconfig
> mips                         tb0287_defconfig
> s390                          debug_defconfig
> arm                           sama5_defconfig
> arm                         s3c2410_defconfig
> arm                         lpc18xx_defconfig
> sh                         microdev_defconfig
> arm                         s5pv210_defconfig
> mips                         tb0226_defconfig
> arm                          pxa910_defconfig
> c6x                        evmc6474_defconfig
> ia64                             allmodconfig
> ia64                                defconfig
> ia64                             allyesconfig
> m68k                             allmodconfig
> m68k                                defconfig
> m68k                             allyesconfig
> nios2                               defconfig
> arc                              allyesconfig
> nds32                             allnoconfig
> c6x                              allyesconfig
> nds32                               defconfig
> nios2                            allyesconfig
> csky                                defconfig
> alpha                               defconfig
> alpha                            allyesconfig
> xtensa                           allyesconfig
> h8300                            allyesconfig
> arc                                 defconfig
> sh                               allmodconfig
> parisc                              defconfig
> s390                             allyesconfig
> parisc                           allyesconfig
> s390                                defconfig
> i386                             allyesconfig
> sparc                            allyesconfig
> sparc                               defconfig
> i386                               tinyconfig
> i386                                defconfig
> mips                             allyesconfig
> mips                             allmodconfig
> powerpc                          allyesconfig
> powerpc                          allmodconfig
> powerpc                           allnoconfig
> x86_64               randconfig-a001-20201229
> x86_64               randconfig-a006-20201229
> x86_64               randconfig-a002-20201229
> x86_64               randconfig-a004-20201229
> x86_64               randconfig-a003-20201229
> x86_64               randconfig-a005-20201229
> i386                 randconfig-a002-20201229
> i386                 randconfig-a005-20201229
> i386                 randconfig-a004-20201229
> i386                 randconfig-a006-20201229
> i386                 randconfig-a003-20201229
> i386                 randconfig-a001-20201229
> i386                 randconfig-a014-20201229
> i386                 randconfig-a012-20201229
> i386                 randconfig-a011-20201229
> i386                 randconfig-a016-20201229
> i386                 randconfig-a015-20201229
> i386                 randconfig-a013-20201229
> riscv                    nommu_k210_defconfig
> riscv                            allyesconfig
> riscv                    nommu_virt_defconfig
> riscv                             allnoconfig
> riscv                               defconfig
> riscv                          rv32_defconfig
> riscv                            allmodconfig
> x86_64                                   rhel
> x86_64                           allyesconfig
> x86_64                    rhel-7.6-kselftests
> x86_64                              defconfig
> x86_64                               rhel-8.3
> x86_64                      rhel-8.3-kbuiltin
> x86_64                                  kexec
>
> clang tested configs:
> x86_64               randconfig-a014-20201229
> x86_64               randconfig-a015-20201229
> x86_64               randconfig-a016-20201229
> x86_64               randconfig-a012-20201229
> x86_64               randconfig-a011-20201229
> x86_64               randconfig-a013-20201229
>
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
