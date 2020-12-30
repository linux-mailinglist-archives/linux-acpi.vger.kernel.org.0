Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60D0B2E7A0E
	for <lists+linux-acpi@lfdr.de>; Wed, 30 Dec 2020 15:54:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726290AbgL3OyQ (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 30 Dec 2020 09:54:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726277AbgL3OyP (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 30 Dec 2020 09:54:15 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FD5CC061799
        for <linux-acpi@vger.kernel.org>; Wed, 30 Dec 2020 06:53:35 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id g185so4925373wmf.3
        for <linux-acpi@vger.kernel.org>; Wed, 30 Dec 2020 06:53:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=qtF7atT9/XTnUP957GKheyYGv9hTR/lrp7SvyY96rSY=;
        b=N41qKgoqG5ahYcONbZ/ezPo9/OX8L4hPhCKc6rNbP5CDFzpRBjYugbxoJuCexWAScx
         LrlKwtu9miF12ys4DlM57ZwRj6XhoG8GWMTYib+hr6+NgyaUpVnvcdOEqVpgh+r2yZRt
         Gx/Fkf6juMDK8c58+qO+sr/DoXOWLUGslmuaqV35mE1a1LlPDIJ3MEdUDp7qdxmuJwxr
         pzhQQTHwl/bRt5VDdEnNiJ6p9bSGhNVlai10vorxMCZjBnPaoPTiQ2gcy3xLw0Is5Bmb
         1mMuNHi+PbkTy/rI6hTvXV0cO8FSbMjr2DgUHMA3PzPZDbeOemI03pOJs6jUy3GpsTHn
         3Xgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=qtF7atT9/XTnUP957GKheyYGv9hTR/lrp7SvyY96rSY=;
        b=mAgyi0IQZl+iJF3Osdg4jUpo7tFYOI5Ky7Ruv9u+7LpfugAgO0nEweNBylPFpcwtDe
         gWXmeroHGIbLmTKVpmV8HMRdlfBXLHzQQCCqgeuzOZ+A0SntL725Fn50cEewuKfjDf0o
         aTz/PYgcXgK0AtNypXxODG9gmdMCe3ATcQflcfP58HZoEu+LQfC1U33fV5xg61o8UcQF
         jXPJizbJ4KEtYGxKIetWTQuwLrz0wIRuDUNAwq7BHOGzr6e/V4kqB9ibJ8oZu4/R7nzK
         UNcYuxjgbDGyWtnChr40s6/Oh90VEAlTQKAz/UXuJpJfazjETUwfvLhIsntp8w1yKa6t
         0ZTg==
X-Gm-Message-State: AOAM530ptCYuPDMrBmtIrQOpKw8OoDb5OZcG7ZUMKDs5FbbRGEquiOXr
        q66mSNN6o1SvMBoKbgXsKOM5EA==
X-Google-Smtp-Source: ABdhPJxZS9Pn6Mx7P3MR8m9TEu+Gv1CJ20aQES0lxwy67+84BRCzEIwcY2RCW/Xmphg+Ama65GVtng==
X-Received: by 2002:a05:600c:274d:: with SMTP id 13mr7971073wmw.77.1609340014026;
        Wed, 30 Dec 2020 06:53:34 -0800 (PST)
Received: from [192.168.0.41] (lns-bzn-59-82-252-148-164.adsl.proxad.net. [82.252.148.164])
        by smtp.googlemail.com with ESMTPSA id n189sm7806210wmf.20.2020.12.30.06.53.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Dec 2020 06:53:33 -0800 (PST)
Subject: Re: [pm:bleeding-edge] BUILD REGRESSION
 0c7a6fd3a0e835b0158a1f52176f5d3858fac110
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        kernel test robot <lkp@intel.com>
References: <5fec0d86.i0RjnNeExICZGSu7%lkp@intel.com>
 <CAJZ5v0gN3NfWyAHA7At=1ZG90vCJbDoUzF5ts2_t3GmunSbrMQ@mail.gmail.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <c796df50-5086-f5dd-e9c8-9ca5e80f8bdf@linaro.org>
Date:   Wed, 30 Dec 2020 15:53:32 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAJZ5v0gN3NfWyAHA7At=1ZG90vCJbDoUzF5ts2_t3GmunSbrMQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 30/12/2020 15:25, Rafael J. Wysocki wrote:
> Hi Daniel,
> 
> On Wed, Dec 30, 2020 at 6:19 AM kernel test robot <lkp@intel.com> wrote:
>>
>> tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git  bleeding-edge
>> branch HEAD: 0c7a6fd3a0e835b0158a1f52176f5d3858fac110  Merge branch 'pm-cpuidle-next' into bleeding-edge
>>
>> Error/Warning reports:
>>
>> https://lore.kernel.org/linux-acpi/202012180806.uUcdy2LC-lkp@intel.com
>> https://lore.kernel.org/linux-acpi/202012271352.JvNDF17O-lkp@intel.com
>> https://lore.kernel.org/linux-acpi/202012280239.stlWMtr3-lkp@intel.com
>> https://lore.kernel.org/linux-acpi/202012280249.nrNm8Jn3-lkp@intel.com
>>
>> Error/Warning in current branch:
>>
>> drivers/acpi/platform_profile.c:147:24: warning: address of array 'pprof->choices' will always evaluate to 'true' [-Wpointer-bool-conversion]
>> drivers/acpi/x86/s2idle.c:108:30: warning: variable 'info' set but not used [-Wunused-but-set-variable]
>> drivers/acpi/x86/s2idle.c:138:25: warning: variable 'obj_new' set but not used [-Wunused-but-set-variable]
>> dtpm.c:(.text+0x24c): undefined reference to `__udivdi3'
>> dtpm.c:(.text+0x2a4): undefined reference to `__udivdi3'
>> dtpm.c:(.text+0x3bc): undefined reference to `__udivdi3'
>> dtpm.c:(.text+0x514): undefined reference to `__aeabi_uldivmod'
>> dtpm.c:(.text+0x52d): undefined reference to `__udivdi3'
> 
> The above build issues come from the DTPM patches.
> 
> I was about to send a pull request including those patches later
> today, but it looks like that would be premature.
> 
> Can you have a look at this, please?

I've a patch to fix it. I'm currently testing it.




>> Error/Warning ids grouped by kconfigs:
>>
>> gcc_recent_errors
>> |-- arm-allmodconfig
>> |   `-- dtpm.c:(.text):undefined-reference-to-__aeabi_uldivmod
>> |-- arm-allyesconfig
>> |   `-- dtpm.c:(.text):undefined-reference-to-__aeabi_uldivmod
>> |-- h8300-allmodconfig
>> |   `-- dtpm.c:(.text):undefined-reference-to-__udivdi3
>> |-- h8300-allyesconfig
>> |   `-- dtpm.c:(.text):undefined-reference-to-__udivdi3
>> |-- i386-allyesconfig
>> |   `-- dtpm.c:(.text):undefined-reference-to-__udivdi3
>> |-- i386-randconfig-a006-20201229
>> |   |-- drivers-acpi-x86-s2idle.c:warning:variable-info-set-but-not-used
>> |   `-- drivers-acpi-x86-s2idle.c:warning:variable-obj_new-set-but-not-used
>> |-- i386-randconfig-r002-20201229
>> |   |-- drivers-acpi-x86-s2idle.c:warning:variable-info-set-but-not-used
>> |   `-- drivers-acpi-x86-s2idle.c:warning:variable-obj_new-set-but-not-used
>> |-- i386-randconfig-s001-20201229
>> |   |-- drivers-acpi-x86-s2idle.c:warning:variable-info-set-but-not-used
>> |   `-- drivers-acpi-x86-s2idle.c:warning:variable-obj_new-set-but-not-used
>> |-- m68k-allmodconfig
>> |   `-- dtpm.c:(.text):undefined-reference-to-__udivdi3
>> |-- m68k-allyesconfig
>> |   `-- dtpm.c:(.text):undefined-reference-to-__udivdi3
>> |-- sh-allmodconfig
>> |   `-- dtpm.c:(.text):undefined-reference-to-__udivdi3
>> |-- x86_64-randconfig-a002-20201229
>> |   |-- drivers-acpi-x86-s2idle.c:warning:variable-info-set-but-not-used
>> |   `-- drivers-acpi-x86-s2idle.c:warning:variable-obj_new-set-but-not-used
>> |-- x86_64-randconfig-a004-20201229
>> |   |-- drivers-acpi-x86-s2idle.c:warning:variable-info-set-but-not-used
>> |   `-- drivers-acpi-x86-s2idle.c:warning:variable-obj_new-set-but-not-used
>> `-- x86_64-randconfig-s021-20201229
>>     |-- drivers-acpi-x86-s2idle.c:warning:variable-info-set-but-not-used
>>     `-- drivers-acpi-x86-s2idle.c:warning:variable-obj_new-set-but-not-used
>>
>> clang_recent_errors
>> |-- x86_64-randconfig-a011-20201229
>> |   `-- drivers-acpi-platform_profile.c:warning:address-of-array-pprof-choices-will-always-evaluate-to-true
>> |-- x86_64-randconfig-a012-20201229
>> |   `-- drivers-acpi-platform_profile.c:warning:address-of-array-pprof-choices-will-always-evaluate-to-true
>> |-- x86_64-randconfig-a013-20201229
>> |   `-- drivers-acpi-platform_profile.c:warning:address-of-array-pprof-choices-will-always-evaluate-to-true
>> |-- x86_64-randconfig-a014-20201229
>> |   `-- drivers-acpi-platform_profile.c:warning:address-of-array-pprof-choices-will-always-evaluate-to-true
>> |-- x86_64-randconfig-a015-20201229
>> |   `-- drivers-acpi-platform_profile.c:warning:address-of-array-pprof-choices-will-always-evaluate-to-true
>> `-- x86_64-randconfig-a016-20201229
>>     `-- drivers-acpi-platform_profile.c:warning:address-of-array-pprof-choices-will-always-evaluate-to-true
>>
>> elapsed time: 724m
>>
>> configs tested: 95
>> configs skipped: 2
>>
>> gcc tested configs:
>> arm                                 defconfig
>> arm64                            allyesconfig
>> arm64                               defconfig
>> arm                              allyesconfig
>> arm                              allmodconfig
>> sh                           se7619_defconfig
>> sh                        sh7785lcr_defconfig
>> arm                        trizeps4_defconfig
>> mips                        workpad_defconfig
>> um                           x86_64_defconfig
>> mips                     cu1000-neo_defconfig
>> m68k                          sun3x_defconfig
>> mips                        bcm47xx_defconfig
>> arm                            mps2_defconfig
>> mips                         tb0287_defconfig
>> s390                          debug_defconfig
>> arm                           sama5_defconfig
>> arm                         s3c2410_defconfig
>> arm                         lpc18xx_defconfig
>> sh                         microdev_defconfig
>> arm                         s5pv210_defconfig
>> mips                         tb0226_defconfig
>> arm                          pxa910_defconfig
>> c6x                        evmc6474_defconfig
>> ia64                             allmodconfig
>> ia64                                defconfig
>> ia64                             allyesconfig
>> m68k                             allmodconfig
>> m68k                                defconfig
>> m68k                             allyesconfig
>> nios2                               defconfig
>> arc                              allyesconfig
>> nds32                             allnoconfig
>> c6x                              allyesconfig
>> nds32                               defconfig
>> nios2                            allyesconfig
>> csky                                defconfig
>> alpha                               defconfig
>> alpha                            allyesconfig
>> xtensa                           allyesconfig
>> h8300                            allyesconfig
>> arc                                 defconfig
>> sh                               allmodconfig
>> parisc                              defconfig
>> s390                             allyesconfig
>> parisc                           allyesconfig
>> s390                                defconfig
>> i386                             allyesconfig
>> sparc                            allyesconfig
>> sparc                               defconfig
>> i386                               tinyconfig
>> i386                                defconfig
>> mips                             allyesconfig
>> mips                             allmodconfig
>> powerpc                          allyesconfig
>> powerpc                          allmodconfig
>> powerpc                           allnoconfig
>> x86_64               randconfig-a001-20201229
>> x86_64               randconfig-a006-20201229
>> x86_64               randconfig-a002-20201229
>> x86_64               randconfig-a004-20201229
>> x86_64               randconfig-a003-20201229
>> x86_64               randconfig-a005-20201229
>> i386                 randconfig-a002-20201229
>> i386                 randconfig-a005-20201229
>> i386                 randconfig-a004-20201229
>> i386                 randconfig-a006-20201229
>> i386                 randconfig-a003-20201229
>> i386                 randconfig-a001-20201229
>> i386                 randconfig-a014-20201229
>> i386                 randconfig-a012-20201229
>> i386                 randconfig-a011-20201229
>> i386                 randconfig-a016-20201229
>> i386                 randconfig-a015-20201229
>> i386                 randconfig-a013-20201229
>> riscv                    nommu_k210_defconfig
>> riscv                            allyesconfig
>> riscv                    nommu_virt_defconfig
>> riscv                             allnoconfig
>> riscv                               defconfig
>> riscv                          rv32_defconfig
>> riscv                            allmodconfig
>> x86_64                                   rhel
>> x86_64                           allyesconfig
>> x86_64                    rhel-7.6-kselftests
>> x86_64                              defconfig
>> x86_64                               rhel-8.3
>> x86_64                      rhel-8.3-kbuiltin
>> x86_64                                  kexec
>>
>> clang tested configs:
>> x86_64               randconfig-a014-20201229
>> x86_64               randconfig-a015-20201229
>> x86_64               randconfig-a016-20201229
>> x86_64               randconfig-a012-20201229
>> x86_64               randconfig-a011-20201229
>> x86_64               randconfig-a013-20201229
>>
>> ---
>> 0-DAY CI Kernel Test Service, Intel Corporation
>> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
