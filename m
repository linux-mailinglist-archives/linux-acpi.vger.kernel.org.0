Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0FEE48350F
	for <lists+linux-acpi@lfdr.de>; Mon,  3 Jan 2022 17:49:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234632AbiACQtS (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 3 Jan 2022 11:49:18 -0500
Received: from mail-qk1-f176.google.com ([209.85.222.176]:34439 "EHLO
        mail-qk1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231931AbiACQtS (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 3 Jan 2022 11:49:18 -0500
Received: by mail-qk1-f176.google.com with SMTP id b85so31846830qkc.1;
        Mon, 03 Jan 2022 08:49:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=P5XLm7blW/qx7b/luF97YrO03ortKkqhxYqNga2al/I=;
        b=Wubie3X2ZJBUOl+bNCZ+pjSbSFSHctBhosnSXd4zmXjST3jMu/EQnENNO9TlpfOnUj
         Fmbb3UzqW+tDo/7L7Zm7kZcPqmlsaEbyZEzKsJ8vYxpq9WAb7uWKfAWEm1Cb8XtKj3u2
         v8h8ReXGe/ZMNZmVq4dIaM2f9NmYGVgLme/yiTPGEDCA4NTb62htjlQwFcBb910OamCR
         6E9KdVWFJDv2LJWPpktYvtBPIJUeWW2J4iYBmHUqeUkI3XCFbvYlMIwjfFkMrhqEK9Op
         FeCB76kRlRXO81XKEJPoAkiP7tRoaLcEbynAjj03uE4QGSMTcwlwd4SGGuI05QruOWOt
         hibQ==
X-Gm-Message-State: AOAM530tbpVjTh3Eo+SqsZactDPDSa4V5Mq/eE8IthfU7KB7+Q4OyRNU
        HA1QbGf76ZcuAiAJe9WWjUIYqaHRI7eWj730i94uRN5yM8k=
X-Google-Smtp-Source: ABdhPJySwwd/GmduRwn9q0eTVHybZdJDmkL/qm2qBqrABak204hAqI2i6ykQIPjAdMpHP1Poca2hiKcpi1drsPpZbfk=
X-Received: by 2002:a05:620a:40d1:: with SMTP id g17mr33403308qko.621.1641228557684;
 Mon, 03 Jan 2022 08:49:17 -0800 (PST)
MIME-Version: 1.0
References: <61cc007a.mWwpG8hntz2tC9i6%lkp@intel.com> <BYAPR11MB32566B65A82D815C214720E487499@BYAPR11MB3256.namprd11.prod.outlook.com>
In-Reply-To: <BYAPR11MB32566B65A82D815C214720E487499@BYAPR11MB3256.namprd11.prod.outlook.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 3 Jan 2022 17:49:06 +0100
Message-ID: <CAJZ5v0gx70huuZ7tj_iMZR3ViFfzX9F2Zt4BxqcHk_9OdioP1Q@mail.gmail.com>
Subject: Re: [Devel] [rafael-pm:bleeding-edge] BUILD SUCCESS WITH WARNING 8d681a5245f0a5cfb20326b4f6578af1adb8676b
To:     "Moore, Robert" <robert.moore@intel.com>
Cc:     lkp <lkp@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "devel@acpica.org" <devel@acpica.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        Arnd Bergmann <arnd@kernel.org>
Content-Type: multipart/mixed; boundary="0000000000002dc0fb05d4b04d79"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

--0000000000002dc0fb05d4b04d79
Content-Type: text/plain; charset="UTF-8"

On Mon, Jan 3, 2022 at 4:57 PM Moore, Robert <robert.moore@intel.com> wrote:
>
> Are these new warnings, or legacy warnings?

They are new, but AFAICS they appear because an old macro,
ACPI_PTR_DIFF(), has been used for defining a new one,
ACPI_PTR_TO_PHYSADDR(), which is now triggering the old warning in a
new way.

I guess this could be addressed by applying the Arnd's patch at
https://patchwork.kernel.org/project/linux-acpi/patch/20210927121338.938994-1-arnd@kernel.org/
, but that's problematic for the upstream.

However, I'm wondering if we can do something like the attached patch instead.



> -----Original Message-----
> From: kernel test robot <lkp@intel.com>
> Sent: Tuesday, December 28, 2021 10:30 PM
> To: Rafael J. Wysocki <rjw@rjwysocki.net>
> Cc: linux-pm@vger.kernel.org; devel@acpica.org; linux-acpi@vger.kernel.org
> Subject: [Devel] [rafael-pm:bleeding-edge] BUILD SUCCESS WITH WARNING 8d681a5245f0a5cfb20326b4f6578af1adb8676b
>
> tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge branch HEAD: 8d681a5245f0a5cfb20326b4f6578af1adb8676b  Merge branch 'acpi-sysfs' into bleeding-edge
>
> Warning reports:
>
> https://lore.kernel.org/llvm/202112280907.gTYYYuB4-lkp@intel.com
>
> Warning in current branch:
>
> drivers/acpi/acpica/exregion.c:519:17: warning: performing pointer subtraction with a null pointer has undefined behavior [-Wnull-pointer-subtraction]
>
> Warning ids grouped by kconfigs:
>
> clang_recent_errors
> |-- i386-randconfig-a001-20211229
> |   `--
> |drivers-acpi-acpica-exregion.c:warning:performing-pointer-subtraction-w
> |ith-a-null-pointer-has-undefined-behavior
> |-- i386-randconfig-a002-20211229
> |   `--
> |drivers-acpi-acpica-exregion.c:warning:performing-pointer-subtraction-w
> |ith-a-null-pointer-has-undefined-behavior
> |-- i386-randconfig-a003-20211229
> |   `--
> |drivers-acpi-acpica-exregion.c:warning:performing-pointer-subtraction-w
> |ith-a-null-pointer-has-undefined-behavior
> |-- i386-randconfig-a004-20211229
> |   `--
> |drivers-acpi-acpica-exregion.c:warning:performing-pointer-subtraction-w
> |ith-a-null-pointer-has-undefined-behavior
> |-- i386-randconfig-a005-20211229
> |   `--
> |drivers-acpi-acpica-exregion.c:warning:performing-pointer-subtraction-w
> |ith-a-null-pointer-has-undefined-behavior
> |-- i386-randconfig-a006-20211229
> |   `--
> |drivers-acpi-acpica-exregion.c:warning:performing-pointer-subtraction-w
> |ith-a-null-pointer-has-undefined-behavior
> |-- i386-randconfig-a011-20211228
> |   `--
> |drivers-acpi-acpica-exregion.c:warning:performing-pointer-subtraction-w
> |ith-a-null-pointer-has-undefined-behavior
> |-- i386-randconfig-a012-20211228
> |   `--
> |drivers-acpi-acpica-exregion.c:warning:performing-pointer-subtraction-w
> |ith-a-null-pointer-has-undefined-behavior
> |-- i386-randconfig-a013-20211228
> |   `--
> |drivers-acpi-acpica-exregion.c:warning:performing-pointer-subtraction-w
> |ith-a-null-pointer-has-undefined-behavior
> |-- i386-randconfig-a014-20211228
> |   `--
> |drivers-acpi-acpica-exregion.c:warning:performing-pointer-subtraction-w
> |ith-a-null-pointer-has-undefined-behavior
> |-- i386-randconfig-a015-20211228
> |   `--
> |drivers-acpi-acpica-exregion.c:warning:performing-pointer-subtraction-w
> |ith-a-null-pointer-has-undefined-behavior
> |-- i386-randconfig-a016-20211228
> |   `--
> |drivers-acpi-acpica-exregion.c:warning:performing-pointer-subtraction-w
> |ith-a-null-pointer-has-undefined-behavior
> |-- x86_64-randconfig-a001-20211229
> |   `--
> |drivers-acpi-acpica-exregion.c:warning:performing-pointer-subtraction-w
> |ith-a-null-pointer-has-undefined-behavior
> |-- x86_64-randconfig-a002-20211229
> |   `--
> |drivers-acpi-acpica-exregion.c:warning:performing-pointer-subtraction-w
> |ith-a-null-pointer-has-undefined-behavior
> |-- x86_64-randconfig-a003-20211229
> |   `--
> |drivers-acpi-acpica-exregion.c:warning:performing-pointer-subtraction-w
> |ith-a-null-pointer-has-undefined-behavior
> |-- x86_64-randconfig-a004-20211229
> |   `--
> |drivers-acpi-acpica-exregion.c:warning:performing-pointer-subtraction-w
> |ith-a-null-pointer-has-undefined-behavior
> |-- x86_64-randconfig-a005-20211229
> |   `--
> |drivers-acpi-acpica-exregion.c:warning:performing-pointer-subtraction-w
> |ith-a-null-pointer-has-undefined-behavior
> |-- x86_64-randconfig-a006-20211229
> |   `--
> |drivers-acpi-acpica-exregion.c:warning:performing-pointer-subtraction-w
> |ith-a-null-pointer-has-undefined-behavior
> |-- x86_64-randconfig-a011-20211228
> |   `--
> |drivers-acpi-acpica-exregion.c:warning:performing-pointer-subtraction-w
> |ith-a-null-pointer-has-undefined-behavior
> |-- x86_64-randconfig-a012-20211228
> |   `--
> |drivers-acpi-acpica-exregion.c:warning:performing-pointer-subtraction-w
> |ith-a-null-pointer-has-undefined-behavior
> |-- x86_64-randconfig-a013-20211228
> |   `--
> |drivers-acpi-acpica-exregion.c:warning:performing-pointer-subtraction-w
> |ith-a-null-pointer-has-undefined-behavior
> |-- x86_64-randconfig-a014-20211228
> |   `--
> |drivers-acpi-acpica-exregion.c:warning:performing-pointer-subtraction-w
> |ith-a-null-pointer-has-undefined-behavior
> |-- x86_64-randconfig-a015-20211228
> |   `--
> |drivers-acpi-acpica-exregion.c:warning:performing-pointer-subtraction-w
> |ith-a-null-pointer-has-undefined-behavior
> |-- x86_64-randconfig-a016-20211228
> |   `--
> |drivers-acpi-acpica-exregion.c:warning:performing-pointer-subtraction-w
> |ith-a-null-pointer-has-undefined-behavior
> |-- x86_64-randconfig-r012-20211228
> |   `--
> |drivers-acpi-acpica-exregion.c:warning:performing-pointer-subtraction-w
> |ith-a-null-pointer-has-undefined-behavior
> `-- x86_64-randconfig-r024-20211228
>     `-- drivers-acpi-acpica-exregion.c:warning:performing-pointer-subtraction-with-a-null-pointer-has-undefined-behavior
>
> elapsed time: 725m
>
> configs tested: 104
> configs skipped: 3
>
> gcc tested configs:
> arm                              allyesconfig
> arm                              allmodconfig
> arm                                 defconfig
> arm64                               defconfig
> arm64                            allyesconfig
> i386                 randconfig-c001-20211228
> arm                           sama7_defconfig
> arc                        nsim_700_defconfig
> arm                            qcom_defconfig
> arm                          pxa3xx_defconfig
> powerpc                   bluestone_defconfig
> mips                      bmips_stb_defconfig
> arm                             ezx_defconfig
> sh                           se7343_defconfig
> powerpc                     skiroot_defconfig
> arm                         lpc18xx_defconfig
> arm                       imx_v6_v7_defconfig
> arm                          pxa910_defconfig
> powerpc                  mpc885_ads_defconfig
> powerpc                     pq2fads_defconfig
> arm                           sama5_defconfig
> arm                        shmobile_defconfig
> arc                    vdk_hs38_smp_defconfig
> csky                             alldefconfig
> riscv             nommu_k210_sdcard_defconfig
> arm                  randconfig-c002-20211229
> ia64                                defconfig
> ia64                             allmodconfig
> ia64                             allyesconfig
> m68k                             allmodconfig
> m68k                                defconfig
> m68k                             allyesconfig
> nds32                             allnoconfig
> nios2                               defconfig
> arc                              allyesconfig
> csky                                defconfig
> alpha                               defconfig
> nds32                               defconfig
> alpha                            allyesconfig
> nios2                            allyesconfig
> arc                                 defconfig
> sh                               allmodconfig
> h8300                            allyesconfig
> xtensa                           allyesconfig
> parisc                              defconfig
> s390                             allmodconfig
> parisc                           allyesconfig
> s390                                defconfig
> s390                             allyesconfig
> i386                             allyesconfig
> sparc                               defconfig
> i386                                defconfig
> i386                   debian-10.3-kselftests
> i386                              debian-10.3
> sparc                            allyesconfig
> mips                             allyesconfig
> mips                             allmodconfig
> powerpc                           allnoconfig
> powerpc                          allmodconfig
> powerpc                          allyesconfig
> arc                  randconfig-r043-20211228
> riscv                    nommu_k210_defconfig
> riscv                            allyesconfig
> riscv                    nommu_virt_defconfig
> riscv                             allnoconfig
> riscv                               defconfig
> riscv                          rv32_defconfig
> riscv                            allmodconfig
> um                           x86_64_defconfig
> um                             i386_defconfig
> x86_64                           allyesconfig
> x86_64                              defconfig
> x86_64                               rhel-8.3
> x86_64                          rhel-8.3-func
> x86_64                                  kexec
> x86_64                    rhel-8.3-kselftests
>
> clang tested configs:
> x86_64               randconfig-a001-20211229
> x86_64               randconfig-a003-20211229
> x86_64               randconfig-a004-20211229
> x86_64               randconfig-a002-20211229
> x86_64               randconfig-a005-20211229
> x86_64               randconfig-a006-20211229
> i386                 randconfig-a002-20211229
> i386                 randconfig-a003-20211229
> i386                 randconfig-a001-20211229
> i386                 randconfig-a005-20211229
> i386                 randconfig-a006-20211229
> i386                 randconfig-a004-20211229
> x86_64               randconfig-a013-20211228
> x86_64               randconfig-a012-20211228
> x86_64               randconfig-a011-20211228
> x86_64               randconfig-a016-20211228
> x86_64               randconfig-a015-20211228
> x86_64               randconfig-a014-20211228
> i386                 randconfig-a012-20211228
> i386                 randconfig-a011-20211228
> i386                 randconfig-a013-20211228
> i386                 randconfig-a016-20211228
> i386                 randconfig-a014-20211228
> i386                 randconfig-a015-20211228
> hexagon              randconfig-r041-20211228
> riscv                randconfig-r042-20211228
> s390                 randconfig-r044-20211228
> hexagon              randconfig-r045-20211228
>
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
> _______________________________________________
> Devel mailing list -- devel@acpica.org
> To unsubscribe send an email to devel-leave@acpica.org %(web_page_url)slistinfo%(cgiext)s/%(_internal_name)s

--0000000000002dc0fb05d4b04d79
Content-Type: text/x-patch; charset="US-ASCII"; name="acpica-build.patch"
Content-Disposition: attachment; filename="acpica-build.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_kxywsiy50>
X-Attachment-Id: f_kxywsiy50

LS0tCiBpbmNsdWRlL2FjcGkvYWN0eXBlcy5oICAgICAgICAgIHwgICAgNCArKysrCiBpbmNsdWRl
L2FjcGkvcGxhdGZvcm0vYWNsaW51eC5oIHwgICAgNSArKysrKwogMiBmaWxlcyBjaGFuZ2VkLCA5
IGluc2VydGlvbnMoKykKCkluZGV4OiBsaW51eC1wbS9pbmNsdWRlL2FjcGkvcGxhdGZvcm0vYWNs
aW51eC5oCj09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT0KLS0tIGxpbnV4LXBtLm9yaWcvaW5jbHVkZS9hY3BpL3BsYXRmb3Jt
L2FjbGludXguaAorKysgbGludXgtcG0vaW5jbHVkZS9hY3BpL3BsYXRmb3JtL2FjbGludXguaApA
QCAtMjEzLDQgKzIxMyw5IEBACiAKICNlbmRpZgkJCQkvKiBfX0tFUk5FTF9fICovCiAKKyNkZWZp
bmUgYWNwaV91aW50cHRyX3QJCXVpbnRwdHJfdAorCisjZGVmaW5lIEFDUElfVE9fSU5URUdFUihw
KQkoKHVpbnRwdHJfdCkocCkpCisjZGVmaW5lIEFDUElfT0ZGU0VUKGQsIGYpCW9mZnNldG9mKGQs
IGYpCisKICNlbmRpZgkJCQkvKiBfX0FDTElOVVhfSF9fICovCkluZGV4OiBsaW51eC1wbS9pbmNs
dWRlL2FjcGkvYWN0eXBlcy5oCj09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0KLS0tIGxpbnV4LXBtLm9yaWcvaW5jbHVkZS9h
Y3BpL2FjdHlwZXMuaAorKysgbGludXgtcG0vaW5jbHVkZS9hY3BpL2FjdHlwZXMuaApAQCAtNTA3
LDggKzUwNywxMiBAQCB0eXBlZGVmIHU2NCBhY3BpX2ludGVnZXI7CiAvKiBQb2ludGVyL0ludGVn
ZXIgdHlwZSBjb252ZXJzaW9ucyAqLwogCiAjZGVmaW5lIEFDUElfVE9fUE9JTlRFUihpKSAgICAg
ICAgICAgICAgQUNQSV9DQVNUX1BUUiAodm9pZCwgKGFjcGlfc2l6ZSkgKGkpKQorI2lmbmRlZiBB
Q1BJX1RPX0lOVEVHRVIKICNkZWZpbmUgQUNQSV9UT19JTlRFR0VSKHApICAgICAgICAgICAgICBB
Q1BJX1BUUl9ESUZGIChwLCAodm9pZCAqKSAwKQorI2VuZGlmCisjaWZuZGVmIEFDUElfT0ZGU0VU
CiAjZGVmaW5lIEFDUElfT0ZGU0VUKGQsIGYpICAgICAgICAgICAgICAgQUNQSV9QVFJfRElGRiAo
JigoKGQgKikgMCktPmYpLCAodm9pZCAqKSAwKQorI2VuZGlmCiAjZGVmaW5lIEFDUElfUFRSX1RP
X1BIWVNBRERSKGkpICAgICAgICAgQUNQSV9UT19JTlRFR0VSKGkpCiAKIC8qIE9wdGltaXphdGlv
bnMgZm9yIDQtY2hhcmFjdGVyICgzMi1iaXQpIGFjcGlfbmFtZSBtYW5pcHVsYXRpb24gKi8K
--0000000000002dc0fb05d4b04d79--
