Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CB222123B88
	for <lists+linux-acpi@lfdr.de>; Wed, 18 Dec 2019 01:27:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726143AbfLRA1O (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 17 Dec 2019 19:27:14 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:38083 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726072AbfLRA1N (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 17 Dec 2019 19:27:13 -0500
Received: by mail-pg1-f193.google.com with SMTP id a33so233027pgm.5
        for <linux-acpi@vger.kernel.org>; Tue, 17 Dec 2019 16:27:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=BFXApGmRkhQpvaskns+MYsUGeJAvRbw4AFVVvUYReag=;
        b=GRiti984LUxfKCq50KQnHHG0dEKBlHAGOYYCssx+Om3VfpgywUaIo6yWyD7ZJ+YL/n
         seZBlMUa/hemAD8qy2PBZgsZcZpzHJAvp0g83MFPvHamV37vLTNaHY6IKNnxFa0DW1cC
         wuHuG5WqMmUj5McsKcwNADfGOb2a/VkqpIn1NdrSoNB+cgoUttoMRD5Kiv6YewYsRkAB
         9hzFOc2lL681vmURuQ+1brV1GP0fPRvEYGv+NnUSeeF/zr39amsooWlh2HPbH5UZX4N0
         vvH4Ik08cCyq2m6+Jkic4mBekWrG5nj+eN1oCwNAIi+I9/32td9cXSZKy9oVbzRdyOJ7
         CJ9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=BFXApGmRkhQpvaskns+MYsUGeJAvRbw4AFVVvUYReag=;
        b=jB3UqrBRXT6L2ZJMKManL4lQjQkHw9uJu7yNeXXubvqmVgVkOEhZ92ASxfXt29kOS2
         52+CW8rb6jeHaeMmXLrES2RFIkopsMg7p7gHbaT95PU17Tvdv/qZc6dvKt6/Ya4ygCOE
         6C7qhuTtHj5uoAETZYX4wq3tbjBAiMv81De+zjVlL17j6+Sl073uzSc2HTmnGBb7JPn2
         BoxsP17gNsbz6p13xgnNZvwzerLaPKnAaF4qExj31E9GJBqtX1JstDTDWfjnBa16/z0S
         t9z6ojyPX+AVlIn2JkD/OA1GWfEPimSLFsoH3wBT86Yi4/dQyu+R95jGajjlCPv3t+DM
         pRIA==
X-Gm-Message-State: APjAAAU/BEEoQ0GMmuPvhLO5Wxqv27FWH5miJaFdlHyYm51ZCyVxgeF9
        Cz9m0UTwpZPEtgfOAsDIsCg=
X-Google-Smtp-Source: APXvYqwxUKKOAiYy8gJs7GYhGqP55FPXMu4vnBnTX3/mfYBhvr8dugQ1vvrFO6lHeXiw9PqnlK505w==
X-Received: by 2002:a62:1a09:: with SMTP id a9mr616210pfa.64.1576628832140;
        Tue, 17 Dec 2019 16:27:12 -0800 (PST)
Received: from dtor-ws ([2620:15c:202:201:3adc:b08c:7acc:b325])
        by smtp.gmail.com with ESMTPSA id q15sm172546pgi.55.2019.12.17.16.27.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2019 16:27:11 -0800 (PST)
Date:   Tue, 17 Dec 2019 16:27:09 -0800
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Linux ACPI <linux-acpi@vger.kernel.org>
Subject: Re: Fwd: [pm:bleeding-edge] BUILD REGRESSION
 208501f6808a1dc0205904ed84cac99da01bbf70
Message-ID: <20191218002709.GA8314@dtor-ws>
References: <1860961.FledB3ecnK@kreacher>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1860961.FledB3ecnK@kreacher>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Rafael,

On Fri, Dec 13, 2019 at 11:14:16AM +0100, Rafael J. Wysocki wrote:
> Hi Dmitry,
> 
> Unfortunately, this report was sent directly to me without any CCs to
> mailing lists.
> 
> This is a tree with the v9 of the last patch from the software nodes series
> merged.

I tried fetching your linux-pm tree, but it does not contain the commit
Kbuild referenced. But you must be testing with an old version of tests
because I see the largest frame at 600 bytes, not the 2.5-3K as in your
logs:

dtor@dtor-ws:~/kernel/linux-next (swnode-refs-v9)$ make CFLAGS_KERNEL=-Wframe-larger-than=512
drivers/base/test/property-entry-test.o
  CALL    scripts/checksyscalls.sh
  CALL    scripts/atomic/check-atomics.sh
  DESCEND  objtool
  CC      drivers/base/test/property-entry-test.o
drivers/base/test/property-entry-test.c: In function ‘pe_test_uint_arrays’:
drivers/base/test/property-entry-test.c:214:1: warning: the frame size of 600 bytes is larger than 512 bytes [-Wframe-larger-than=]
 }

Could you please try the 0-day on your tree again?

Thanks.

> 
> Cheers,
> Rafael

> Date: Tue, 10 Dec 2019 13:18:25 +0800
> From: kbuild test robot <lkp@intel.com>
> To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> Subject: [pm:bleeding-edge] BUILD REGRESSION
>  208501f6808a1dc0205904ed84cac99da01bbf70
> 
> tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git  bleeding-edge
> branch HEAD: 208501f6808a1dc0205904ed84cac99da01bbf70  Merge branch 'acpi-pm' into bleeding-edge
> 
> Regressions in current branch:
> 
> drivers/base/test/property-entry-test.c:214:1: warning: the frame size of 2784 bytes is larger than 2048 bytes [-Wframe-larger-than=]
> drivers/base/test/property-entry-test.c:214:1: warning: the frame size of 3128 bytes is larger than 2048 bytes [-Wframe-larger-than=]
> drivers/base/test/property-entry-test.c:214:1: warning: the frame size of 3136 bytes is larger than 2048 bytes [-Wframe-larger-than=]
> 
> Error ids grouped by kconfigs:
> 
> recent_errors
> |-- arm-allmodconfig
> |   `-- drivers-base-test-property-entry-test.c:warning:the-frame-size-of-bytes-is-larger-than-bytes
> |-- i386-allmodconfig
> |   `-- drivers-base-test-property-entry-test.c:warning:the-frame-size-of-bytes-is-larger-than-bytes
> `-- mips-allmodconfig
>     `-- drivers-base-test-property-entry-test.c:warning:the-frame-size-of-bytes-is-larger-than-bytes
> 
> elapsed time: 352m
> 
> configs tested: 98
> 
> xtensa                       common_defconfig
> openrisc                    or1ksim_defconfig
> nios2                         3c120_defconfig
> xtensa                          iss_defconfig
> c6x                        evmc6678_defconfig
> c6x                              allyesconfig
> nios2                         10m50_defconfig
> openrisc                 simple_smp_defconfig
> arm                         at91_dt_defconfig
> arm64                               defconfig
> arm                        multi_v5_defconfig
> arm64                            allyesconfig
> arm                               allnoconfig
> arm                           efm32_defconfig
> arm                           sunxi_defconfig
> arm64                             allnoconfig
> arm64                            allmodconfig
> arm                          exynos_defconfig
> arm                        shmobile_defconfig
> arm                        multi_v7_defconfig
> sh                               allmodconfig
> sh                          rsk7269_defconfig
> sh                  sh7785lcr_32bit_defconfig
> sh                                allnoconfig
> sh                            titan_defconfig
> s390                              allnoconfig
> s390                          debug_defconfig
> s390                             allmodconfig
> s390                                defconfig
> arm                              allmodconfig
> i386                              allnoconfig
> i386                                defconfig
> i386                             alldefconfig
> parisc                        c3000_defconfig
> parisc                         b180_defconfig
> parisc                              defconfig
> parisc                            allnoconfig
> um                           x86_64_defconfig
> um                             i386_defconfig
> um                                  defconfig
> ia64                             allmodconfig
> ia64                              allnoconfig
> ia64                                defconfig
> ia64                             alldefconfig
> sparc64                          allmodconfig
> sparc                               defconfig
> sparc64                           allnoconfig
> sparc64                             defconfig
> arc                  randconfig-a001-20191210
> ia64                 randconfig-a001-20191210
> sparc                randconfig-a001-20191210
> arm64                randconfig-a001-20191210
> arm                  randconfig-a001-20191210
> x86_64                                    lkp
> x86_64                                   rhel
> x86_64                               rhel-7.6
> x86_64                              fedora-25
> x86_64                                  kexec
> m68k                          multi_defconfig
> m68k                       m5475evb_defconfig
> h8300                    h8300h-sim_defconfig
> h8300                     edosk2674_defconfig
> m68k                           sun3_defconfig
> h8300                       h8s-sim_defconfig
> m68k                             allmodconfig
> riscv                             allnoconfig
> riscv                               defconfig
> nds32                               defconfig
> alpha                               defconfig
> csky                                defconfig
> nds32                             allnoconfig
> sh                   randconfig-a001-20191209
> csky                 randconfig-a001-20191209
> s390                 randconfig-a001-20191209
> xtensa               randconfig-a001-20191209
> openrisc             randconfig-a001-20191209
> i386                 randconfig-d001-20191209
> x86_64               randconfig-d001-20191209
> i386                 randconfig-d002-20191209
> x86_64               randconfig-d003-20191209
> i386                 randconfig-d003-20191209
> x86_64               randconfig-d002-20191209
> arc                              allyesconfig
> microblaze                    nommu_defconfig
> microblaze                      mmu_defconfig
> arc                                 defconfig
> powerpc                           allnoconfig
> mips                             allmodconfig
> mips                           32r2_defconfig
> mips                      malta_kvm_defconfig
> mips                         64r6el_defconfig
> mips                              allnoconfig
> mips                      fuloong2e_defconfig
> c6x                  randconfig-a001-20191209
> sparc64              randconfig-a001-20191209
> h8300                randconfig-a001-20191209
> microblaze           randconfig-a001-20191209
> nios2                randconfig-a001-20191209
> 
> ---
> 0-DAY kernel test infrastructure                 Open Source Technology Center
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org Intel Corporation


-- 
Dmitry
