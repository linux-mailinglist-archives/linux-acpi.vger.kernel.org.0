Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7881D157A85
	for <lists+linux-acpi@lfdr.de>; Mon, 10 Feb 2020 14:23:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728925AbgBJNXY (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 10 Feb 2020 08:23:24 -0500
Received: from mail.skyhub.de ([5.9.137.197]:56132 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731174AbgBJNXO (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 10 Feb 2020 08:23:14 -0500
Received: from zn.tnic (p200300EC2F05D400003D91F82A1CB847.dip0.t-ipconnect.de [IPv6:2003:ec:2f05:d400:3d:91f8:2a1c:b847])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 5DAE91EC0CDA;
        Mon, 10 Feb 2020 14:23:12 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1581340992;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:references;
        bh=MxK6YxXtn7AkeAP6FIIc+JPTrx/o46P5GVwQtFnKuDY=;
        b=SzF4pWodrioCWRoVi85Wve8HkAg8YFuZQKveNRZ+JtKQxH/YE9inW8bnLtM7FyX+8/H4g1
        E8KrDPV25pTaw1hYADDS8NXxRRuqvWR2gEYl1rSct8+j2Rf0vL1X8TC99UxdAK9GeWB0Eb
        mw01hhOG7eYLq53HxGS4cFArtYCJJ+Y=
Date:   Mon, 10 Feb 2020 14:23:04 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     linux-acpi@vger.kernel.org, x86-ml <x86@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Subject: cpuhp lockdep splat
Message-ID: <20200210132304.GB29627@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Rafael,

does this ring any bells?

5.6-rc1 with tip/master from today, I'm doing some hotplug stressing,
hunting for another issue when I got this:

[  759.654555] ======================================================
[  759.654639] WARNING: possible circular locking dependency detected
[  759.654727] 5.6.0-rc1+ #1 Not tainted
[  759.654801] ------------------------------------------------------
[  759.654885] cpuhp/1/14 is trying to acquire lock:
[  759.654964] ffff8883cc907a40 ((work_completion)(&wfc.work)){+.+.}, at: __flush_work+0x512/0x830
[  759.655073] 
               but task is already holding lock:
[  759.655155] ffffffff83a9da80 (cpuidle_lock){+.+.}, at: cpuidle_pause_and_lock+0x13/0x20
[  759.655256] 
               which lock already depends on the new lock.

[  759.655346] 
               the existing dependency chain (in reverse order) is:
[  759.655463] 
               -> #3 (cpuidle_lock){+.+.}:
[  759.655608]        __mutex_lock+0x136/0x1320
[  759.655714]        cpuidle_pause_and_lock+0x13/0x20
[  759.655825]        acpi_processor_hotplug+0xfc/0x1c0
[  759.655932]        acpi_soft_cpu_online+0x113/0x190
[  759.656041]        cpuhp_invoke_callback+0x19c/0x1500
[  759.656149]        cpuhp_thread_fun+0x375/0x6d0
[  759.656256]        smpboot_thread_fn+0x52f/0x900
[  759.656362]        kthread+0x324/0x420
[  759.656466]        ret_from_fork+0x27/0x50
[  759.656568] 
               -> #2 (cpuhp_state-up){+.+.}:
[  759.656709]        cpuhp_thread_fun+0x2f5/0x6d0
[  759.656815]        smpboot_thread_fn+0x52f/0x900
[  759.656920]        kthread+0x324/0x420
[  759.657023]        ret_from_fork+0x27/0x50
[  759.657125] 
               -> #1 (cpu_hotplug_lock.rw_sem){++++}:
[  759.657268]        cpus_read_lock+0x43/0xe0
[  759.657373]        alloc_workqueue+0x7e8/0xc40
[  759.657481]        scsi_host_alloc+0xc61/0x1030
[  759.657589]        ata_scsi_add_hosts+0x2e6/0x580
[  759.657696]        ata_host_register+0x356/0x600
[  759.657803]        ahci_init_one+0x150a/0x1c30
[  759.657910]        local_pci_probe+0xe9/0x1a0
[  759.658015]        work_for_cpu_fn+0x51/0xa0
[  759.658120]        process_one_work+0x79b/0x13f0
[  759.658227]        worker_thread+0x54b/0xbd0
[  759.658331]        kthread+0x324/0x420
[  759.658434]        ret_from_fork+0x27/0x50
[  759.658535] 
               -> #0 ((work_completion)(&wfc.work)){+.+.}:
[  759.658683]        __lock_acquire+0x2122/0x3ae0
[  759.658788]        lock_acquire+0x132/0x360
[  759.658892]        __flush_work+0x535/0x830
[  759.658997]        work_on_cpu+0xc9/0xf0
[  759.659102]        acpi_processor_ffh_cstate_probe+0x18a/0x3f0
[  759.659215]        acpi_processor_evaluate_cst+0x638/0x8a0
[  759.659325]        acpi_processor_get_power_info+0xb0/0xdc0
[  759.659434]        acpi_processor_hotplug+0x10c/0x1c0
[  759.659542]        acpi_soft_cpu_online+0x113/0x190
[  759.659649]        cpuhp_invoke_callback+0x19c/0x1500
[  759.659756]        cpuhp_thread_fun+0x375/0x6d0
[  759.659862]        smpboot_thread_fn+0x52f/0x900
[  759.659967]        kthread+0x324/0x420
[  759.660070]        ret_from_fork+0x27/0x50
[  759.660172] 
               other info that might help us debug this:

[  759.660344] Chain exists of:
                 (work_completion)(&wfc.work) --> cpuhp_state-up --> cpuidle_lock

[  759.660562]  Possible unsafe locking scenario:

[  759.660699]        CPU0                    CPU1
[  759.660802]        ----                    ----
[  759.660905]   lock(cpuidle_lock);
[  759.661006]                                lock(cpuhp_state-up);
[  759.661117]                                lock(cpuidle_lock);
[  759.661227]   lock((work_completion)(&wfc.work));
[  759.661333] 
                *** DEADLOCK ***

[  759.661498] 3 locks held by cpuhp/1/14:
[  759.661600]  #0: ffffffff8369a2f0 (cpu_hotplug_lock.rw_sem){++++}, at: cpuhp_thread_fun+0xac/0x6d0
[  759.661755]  #1: ffffffff8369a4c0 (cpuhp_state-up){+.+.}, at: cpuhp_thread_fun+0xac/0x6d0
[  759.661907]  #2: ffffffff83a9da80 (cpuidle_lock){+.+.}, at: cpuidle_pause_and_lock+0x13/0x20
[  759.662061] 
               stack backtrace:
[  759.662196] CPU: 1 PID: 14 Comm: cpuhp/1 Not tainted 5.6.0-rc1+ #1
[  759.662308] Hardware name: GIGABYTE MZ01-CE1-00/MZ01-CE1-00, BIOS F02 08/29/2018
[  759.662452] Call Trace:
[  759.662559]  dump_stack+0x96/0xe0
[  759.662663]  check_noncircular+0x329/0x3f0
[  759.662770]  ? print_circular_bug.isra.41+0x200/0x200
[  759.662884]  ? mark_lock+0xe6/0x11e0
[  759.662990]  ? rcu_read_lock_bh_held+0xa0/0xa0
[  759.663098]  __lock_acquire+0x2122/0x3ae0
[  759.663208]  ? lock_downgrade+0x6c0/0x6c0
[  759.663314]  ? lockdep_hardirqs_on+0x5c0/0x5c0
[  759.663424]  ? ___preempt_schedule_notrace+0x16/0x35
[  759.663535]  lock_acquire+0x132/0x360
[  759.663640]  ? __flush_work+0x512/0x830
[  759.663748]  __flush_work+0x535/0x830
[  759.663851]  ? __flush_work+0x512/0x830
[  759.663957]  ? queue_delayed_work_on+0xb0/0xb0
[  759.664063]  ? mark_lock+0xe6/0x11e0
[  759.664170]  ? mark_held_locks+0xb0/0x110
[  759.664275]  ? queue_work_on+0x7e/0xa0
[  759.664380]  ? lockdep_hardirqs_on+0x388/0x5c0
[  759.664489]  work_on_cpu+0xc9/0xf0
[  759.664592]  ? flush_delayed_work+0xb0/0xb0
[  759.664698]  ? __exit_umh+0x2f0/0x2f0
[  759.664802]  ? acpi_processor_ffh_cstate_probe+0x3f0/0x3f0
[  759.664915]  ? acpi_processor_get_lpi_info+0xdf/0x320
[  759.665024]  acpi_processor_ffh_cstate_probe+0x18a/0x3f0
[  759.665136]  acpi_processor_evaluate_cst+0x638/0x8a0
[  759.665248]  ? mark_held_locks+0xb0/0x110
[  759.665353]  ? acpi_processor_claim_cst_control+0x100/0x100
[  759.665465]  ? quarantine_put+0xc0/0x160
[  759.665570]  ? lockdep_hardirqs_on+0x388/0x5c0
[  759.665681]  ? __kasan_slab_free+0x141/0x180
[  759.665791]  acpi_processor_get_power_info+0xb0/0xdc0
[  759.665905]  acpi_processor_hotplug+0x10c/0x1c0
[  759.666013]  acpi_soft_cpu_online+0x113/0x190
[  759.666120]  ? acpi_processor_start+0x80/0x80
[  759.666226]  ? lockdep_hardirqs_on+0x5c0/0x5c0
[  759.666335]  ? acpi_processor_start+0x80/0x80
[  759.667805]  cpuhp_invoke_callback+0x19c/0x1500
[  759.667914]  ? cpuhp_thread_fun+0xac/0x6d0
[  759.668022]  cpuhp_thread_fun+0x375/0x6d0
[  759.668126]  ? cpuhp_thread_fun+0xac/0x6d0
[  759.668231]  ? __kthread_parkme+0xc3/0x190
[  759.668336]  ? __cpuhp_state_remove_instance+0x4f0/0x4f0
[  759.668446]  ? smpboot_thread_fn+0x9e/0x900
[  759.668550]  smpboot_thread_fn+0x52f/0x900
[  759.668657]  ? smpboot_register_percpu_thread+0x380/0x380
[  759.668769]  ? __kthread_parkme+0xc3/0x190
[  759.668875]  ? smpboot_register_percpu_thread+0x380/0x380
[  759.668985]  kthread+0x324/0x420
[  759.669087]  ? kthread_create_on_node+0xa0/0xa0
[  759.669195]  ret_from_fork+0x27/0x50
[  759.669386] ACPI: \_PR_.C002: Found 2 idle states
[  759.676775] smpboot: Booting Node 0 Processor 10 APIC 0x11


-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
