Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6CDDF34E4A6
	for <lists+linux-acpi@lfdr.de>; Tue, 30 Mar 2021 11:44:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231434AbhC3Jnr (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 30 Mar 2021 05:43:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:31568 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231616AbhC3Jnd (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 30 Mar 2021 05:43:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1617097412;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=g6WYQfr2zYY7caL+uqTK6vngT15vqF+k7JyRicFrFTM=;
        b=SY8zFmLrD9abCFDhDwhPxTNUh/g6tpCv1GBZTAnHvSlCgmgooic821uGWLA7GGtMoJhVD/
        GDON1Kt3ugicKn8g9aST/1SzdaNVvlsqcpypqD9T1f9FvUXx6SI3fEXUdKewQPVDNwQOlq
        ECFyOcK20U5KE7DROmIYjv2yHvU9xts=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-429-X4vngHXOM0G_uI75SnYUcQ-1; Tue, 30 Mar 2021 05:43:24 -0400
X-MC-Unique: X4vngHXOM0G_uI75SnYUcQ-1
Received: by mail-ed1-f70.google.com with SMTP id f9so9909464edd.13
        for <linux-acpi@vger.kernel.org>; Tue, 30 Mar 2021 02:43:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=g6WYQfr2zYY7caL+uqTK6vngT15vqF+k7JyRicFrFTM=;
        b=AJ/QVHBwHhYlgX4EQW76JAx5N7BT8EsRFOpsdkkgidEqrdNgI2yNO8F2XX4iEQDDxL
         W9NmrRwJH91v1rxhc8CwI5pTKMUR4xXwYHYlvdpSYAdFpXCrkU4VFLDT87/MLtLEIN2u
         5zwQ4YeVkbWU3ZRSgUziFy9KAKTFVu0qPt4tdhoGXFxQ1vq2eS89Frc+o5mVoJ/sLaLv
         KP/aPAKy1a1PB/J01Mj/OMgSI9R5ZXNUxrVhyWpSvOkhBpyMQK+dsU/K7zxjm8ws66Dz
         0k9zi3gCk9u/6uOQDQWWIJWOSx7dIdem+vCHPG6IneYSOKN7thVA4e3VeP9I68rmxEMQ
         QNmA==
X-Gm-Message-State: AOAM533Opjptk4iz+3gq9pPfVK/ufHKACeXqNJ+/jN0/l0lMiv1WIu0v
        f9iiZChUivzQa0FAiMEV1SjKJbsqZ2RoWoBFu0oarGd2TN+2DskBmcxC+Cn/hbvimlTwG7ZVVWB
        R+RUQ6jNzdnX3iOseoLF5Ag==
X-Received: by 2002:a05:6402:5113:: with SMTP id m19mr33248384edd.78.1617097403542;
        Tue, 30 Mar 2021 02:43:23 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz4a/x0IoycE52tHgn4H7FB5BUvgYw6VInMN/z0rYUeu6ZJUK6HgT0mpOxvUyCDXbVPzrp3bQ==
X-Received: by 2002:a05:6402:5113:: with SMTP id m19mr33248375edd.78.1617097403386;
        Tue, 30 Mar 2021 02:43:23 -0700 (PDT)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id f9sm10626380edq.43.2021.03.30.02.43.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Mar 2021 02:43:22 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     kernel test robot <lkp@intel.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     kbuild-all@lists.01.org, clang-built-linux@googlegroups.com,
        linux-acpi@vger.kernel.org, devel@acpica.org,
        linux-pm@vger.kernel.org
Subject: Re: [pm:bleeding-edge 47/48] drivers/acpi/processor_idle.c:548:7:
 error: implicit declaration of function 'wakeup_cpu0'
In-Reply-To: <202103300806.BOpYVHTe-lkp@intel.com>
References: <202103300806.BOpYVHTe-lkp@intel.com>
Date:   Tue, 30 Mar 2021 11:43:22 +0200
Message-ID: <87sg4d9dtx.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

kernel test robot <lkp@intel.com> writes:

> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
> head:   a70fdf61936ab0200d31bebea4b44bb67454ce07
> commit: 5f5e49e999acd8556e694e841d63226d21e409d9 [47/48] ACPI: processor: Fix CPU0 wakeup in acpi_idle_play_dead()
> config: x86_64-randconfig-a013-20210329 (attached as .config)
> compiler: clang version 13.0.0 (https://github.com/llvm/llvm-project 2a28d1d3b7bf2062288b46af34e33ccc543a99fa)
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # install x86_64 cross compiling tool for clang build
>         # apt-get install binutils-x86-64-linux-gnu
>         # https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git/commit/?id=5f5e49e999acd8556e694e841d63226d21e409d9
>         git remote add pm https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git
>         git fetch --no-tags pm bleeding-edge
>         git checkout 5f5e49e999acd8556e694e841d63226d21e409d9
>         # save the attached .config to linux build tree
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross ARCH=x86_64 
>
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
>
> All errors (new ones prefixed by >>):
>
>>> drivers/acpi/processor_idle.c:548:7: error: implicit declaration of function 'wakeup_cpu0' [-Werror,-Wimplicit-function-declaration]
>                    if (wakeup_cpu0())
>                        ^

Sigh,

This one is under CONFIG_SMP in arch/x86/include/asm/smp.h

>>> drivers/acpi/processor_idle.c:549:4: error: implicit declaration of function 'start_cpu0' [-Werror,-Wimplicit-function-declaration]
>                            start_cpu0();

This one is under CONFIG_HOTPLUG_CPU0 (which obviously depends on
CONFIG_SMP)

I think we can put the whole block under #ifdef CONFIG_HOTPLUG_CPU0 as
it makes zero sense otherwise. I'll send a follow-up patch.

>                            ^
>    drivers/acpi/processor_idle.c:1103:12: warning: no previous prototype for function 'acpi_processor_ffh_lpi_probe' [-Wmissing-prototypes]
>    int __weak acpi_processor_ffh_lpi_probe(unsigned int cpu)
>               ^
>    drivers/acpi/processor_idle.c:1103:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
>    int __weak acpi_processor_ffh_lpi_probe(unsigned int cpu)
>    ^
>    static 
>    drivers/acpi/processor_idle.c:1108:12: warning: no previous prototype for function 'acpi_processor_ffh_lpi_enter' [-Wmissing-prototypes]
>    int __weak acpi_processor_ffh_lpi_enter(struct acpi_lpi_state *lpi)
>               ^
>    drivers/acpi/processor_idle.c:1108:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
>    int __weak acpi_processor_ffh_lpi_enter(struct acpi_lpi_state *lpi)
>    ^
>    static 
>    2 warnings and 2 errors generated.
>
>
> vim +/wakeup_cpu0 +548 drivers/acpi/processor_idle.c
>
>    524	
>    525	/**
>    526	 * acpi_idle_play_dead - enters an ACPI state for long-term idle (i.e. off-lining)
>    527	 * @dev: the target CPU
>    528	 * @index: the index of suggested state
>    529	 */
>    530	static int acpi_idle_play_dead(struct cpuidle_device *dev, int index)
>    531	{
>    532		struct acpi_processor_cx *cx = per_cpu(acpi_cstate[index], dev->cpu);
>    533	
>    534		ACPI_FLUSH_CPU_CACHE();
>    535	
>    536		while (1) {
>    537	
>    538			if (cx->entry_method == ACPI_CSTATE_HALT)
>    539				safe_halt();
>    540			else if (cx->entry_method == ACPI_CSTATE_SYSTEMIO) {
>    541				inb(cx->address);
>    542				wait_for_freeze();
>    543			} else
>    544				return -ENODEV;
>    545	
>    546	#ifdef CONFIG_X86
>    547			/* If NMI wants to wake up CPU0, start CPU0. */
>  > 548			if (wakeup_cpu0())
>  > 549				start_cpu0();
>    550	#endif
>    551		}
>    552	
>    553		/* Never reached */
>    554		return 0;
>    555	}
>    556	
>
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

-- 
Vitaly

