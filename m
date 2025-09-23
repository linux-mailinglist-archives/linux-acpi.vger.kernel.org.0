Return-Path: <linux-acpi+bounces-17227-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8648AB95BB2
	for <lists+linux-acpi@lfdr.de>; Tue, 23 Sep 2025 13:49:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1E4407A65C3
	for <lists+linux-acpi@lfdr.de>; Tue, 23 Sep 2025 11:47:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14EAA3218BD;
	Tue, 23 Sep 2025 11:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="APaVLgO2"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3ADD2F2907
	for <linux-acpi@vger.kernel.org>; Tue, 23 Sep 2025 11:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758628145; cv=none; b=cCbFCH3B6zW2vTJOokak5Df1+vWkGIEg6v/sgJ7L6LYVwOnUMxbU/Op3Mj0cqPbz1G+7nMVvnp4DAVgXwXGWU10EzQvMd7FAoxnbbLRiGrMMUpo0lXbdjk2owdRrV4t8A3bGiLkFbdr83AIuRtgk425yPUk+M6GIj70Dtubc8Ac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758628145; c=relaxed/simple;
	bh=LeTffhmL5eXDF230VugNOxznoEp6WHagf82tpaU5yK0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y5dnxhdP8wj2EbIxmX2sBqwxy61OSjtiMsBXBYGElkpmVSIssRRAm5/6ksZzoOYMSAdbrd8KyQYzNW/FwnMxGOQCafccOacUoSsoe8KtTBCdRRvILgm8CjnZ0jhZT/w59QubK8MI7cu0+PLRGGBg+yDXOYmaG4qgqO70rAzrFVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=APaVLgO2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BFD7C19422
	for <linux-acpi@vger.kernel.org>; Tue, 23 Sep 2025 11:49:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758628144;
	bh=LeTffhmL5eXDF230VugNOxznoEp6WHagf82tpaU5yK0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=APaVLgO27iHAW4huFC3BrcYbuWlaU1N2RKi92xzhj/XAbtqqtYz5NNDecQ2LH2dAW
	 clpn31a7RpYuaVutuyFA70e0JvWFVpFcuUQ3QdMIftE4gH3RBT7lQG4qM7zuFMLa2n
	 cR5GIz8yt3TqGDGU6wFrUqt8Q3FZgyqSFOrXbmRPjWNyMq+XMZ7BA2MgpjdE62Asii
	 26TmY5ma+LInmUI2mtmIiAwZH2NDoMntJh0IKfhMZr28Ko03KLjeZQl78BMhwadk1b
	 Ul2QmFz1zuKIKM1TSuKxHabnhomYIzn3Tv/sz98RWAiPFSQEeVglERlnf6I34abavZ
	 109PmM8BaMCwg==
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-757a43dbed1so4425364a34.2
        for <linux-acpi@vger.kernel.org>; Tue, 23 Sep 2025 04:49:04 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVBBSiy7SiMklGIRm46WJ4BYAwf1X3nX8tcaRcP0h4YHkM5BAVecHbjkpWiUxtBPAvAbL5klJol8r3t@vger.kernel.org
X-Gm-Message-State: AOJu0YxY1CBRqIIqHNJu6HWgBV0pOEUpeugs0R5KvXwYNUOmDQOf9br4
	QnOWTRzp3EAv5UFeLAVgzk/zGBeUoPZs/XAM9R3BlNysWT04HYnJBp6pDPXNaMN9vRPbZDvBsCr
	FKRfH2al7wzga4E0pVQcH/UkAPvJRqwM=
X-Google-Smtp-Source: AGHT+IHSlt8NcTczP8RicHCoFUnPUg4PpZC7XOsi+TsQzJXvBzNG6oDWCtz23COLpZWLOlU66fN7JJ0Juqrvzio/tYE=
X-Received: by 2002:a05:6808:17a3:b0:43f:2aad:65cf with SMTP id
 5614622812f47-43f2d29d5a0mr967541b6e.8.1758628143830; Tue, 23 Sep 2025
 04:49:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250914111211.1570889-1-luogf2025@163.com> <20250923023854.158108-1-luogf2025@163.com>
In-Reply-To: <20250923023854.158108-1-luogf2025@163.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 23 Sep 2025 13:48:52 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0guEkbMuMjS=aQRQdiiyUG_hxgu0imBX0kgho2womB0Hw@mail.gmail.com>
X-Gm-Features: AS18NWCmosPgZ9p5jz32fvxqns84CfmBL88HcUN3JKAzB1wqCJ12KSRAmkJoA94
Message-ID: <CAJZ5v0guEkbMuMjS=aQRQdiiyUG_hxgu0imBX0kgho2womB0Hw@mail.gmail.com>
Subject: Re: [PATCH v6] ACPI: battery: prevent sysfs_add_battery re-entry on
 rapid events
To: GuangFei Luo <luogf2025@163.com>
Cc: rafael@kernel.org, dan.carpenter@linaro.org, lenb@kernel.org, 
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org, lkp@intel.com, sre@kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 23, 2025 at 4:39=E2=80=AFAM GuangFei Luo <luogf2025@163.com> wr=
ote:
>
> From: Guofeng Luo <luogf2025@163.com>
>
> >On Thu, Sep 18, 2025 at 3:56=E2=80=AFPM GuangFei Luo <luogf2025@163.com>=
 wrote:
> >>
> >> When removing and reinserting the laptop battery, ACPI can trigger
> >> two notifications in quick succession:
> >>   - ACPI_BATTERY_NOTIFY_STATUS (0x80)
> >>   - ACPI_BATTERY_NOTIFY_INFO   (0x81)
> >>
> >> Both notifications call acpi_battery_update(). Because the events
> >> happen very close in time, sysfs_add_battery() can be re-entered
> >> before battery->bat is set, causing a duplicate sysfs entry error.
> >>
> >> When the ACPI battery driver uses
> >> acpi_dev_install_notify_handler() to register acpi_battery_notify,
> >> the callback may be triggered twice in a very short period of time.
> >>
> >> This patch ensures that sysfs_add_battery() is not re-entered
> >> when battery->bat is already non-NULL, preventing the duplicate
> >> sysfs creation and stabilizing battery hotplug handling.
> >>
> >> [  476.117945] sysfs: cannot create duplicate filename '/devices/LNXSY=
STM:00/LNXSYBUS:00/PNP0C0A:00/power_supply/BAT1'
> >> [  476.118896] CPU: 1 UID: 0 PID: 185 Comm: kworker/1:4 Kdump: loaded =
Not tainted 6.12.38+deb13-amd64 #1  Debian 6.12.38-1
> >> [  476.118903] Hardware name: Gateway          NV44             /SJV40=
-MV        , BIOS V1.3121 04/08/2009
> >> [  476.118906] Workqueue: kacpi_notify acpi_os_execute_deferred
> >> [  476.118917] Call Trace:
> >> [  476.118922]  <TASK>
> >> [  476.118929]  dump_stack_lvl+0x5d/0x80
> >> [  476.118938]  sysfs_warn_dup.cold+0x17/0x23
> >> [  476.118943]  sysfs_create_dir_ns+0xce/0xe0
> >> [  476.118952]  kobject_add_internal+0xba/0x250
> >> [  476.118959]  kobject_add+0x96/0xc0
> >> [  476.118964]  ? get_device_parent+0xde/0x1e0
> >> [  476.118970]  device_add+0xe2/0x870
> >> [  476.118975]  __power_supply_register.part.0+0x20f/0x3f0
> >> [  476.118981]  ? wake_up_q+0x4e/0x90
> >> [  476.118990]  sysfs_add_battery+0xa4/0x1d0 [battery]
> >> [  476.118998]  acpi_battery_update+0x19e/0x290 [battery]
> >> [  476.119002]  acpi_battery_notify+0x50/0x120 [battery]
> >> [  476.119006]  acpi_ev_notify_dispatch+0x49/0x70
> >> [  476.119012]  acpi_os_execute_deferred+0x1a/0x30
> >> [  476.119015]  process_one_work+0x177/0x330
> >> [  476.119022]  worker_thread+0x251/0x390
> >> [  476.119026]  ? __pfx_worker_thread+0x10/0x10
> >> [  476.119030]  kthread+0xd2/0x100
> >> [  476.119033]  ? __pfx_kthread+0x10/0x10
> >> [  476.119035]  ret_from_fork+0x34/0x50
> >> [  476.119040]  ? __pfx_kthread+0x10/0x10
> >> [  476.119042]  ret_from_fork_asm+0x1a/0x30
> >> [  476.119049]  </TASK>
> >> [  476.142552] kobject: kobject_add_internal failed for BAT1 with -EEX=
IST, don't try to register things with the same name in the same directory.
> >> [  476.415022] ata1.00: unexpected _GTF length (8)
> >> [  476.428076] sd 0:0:0:0: [sda] Starting disk
> >> [  476.835035] ata1.00: unexpected _GTF length (8)
> >> [  476.839720] ata1.00: configured for UDMA/133
> >> [  491.328831] sysfs: cannot create duplicate filename '/devices/LNXSY=
STM:00/LNXSYBUS:00/PNP0C0A:00/power_supply/BAT1'
> >> [  491.329720] CPU: 1 UID: 0 PID: 185 Comm: kworker/1:4 Kdump: loaded =
Not tainted 6.12.38+deb13-amd64 #1  Debian 6.12.38-1
> >> [  491.329727] Hardware name: Gateway          NV44             /SJV40=
-MV        , BIOS V1.3121 04/08/2009
> >> [  491.329731] Workqueue: kacpi_notify acpi_os_execute_deferred
> >> [  491.329741] Call Trace:
> >> [  491.329745]  <TASK>
> >> [  491.329751]  dump_stack_lvl+0x5d/0x80
> >> [  491.329758]  sysfs_warn_dup.cold+0x17/0x23
> >> [  491.329762]  sysfs_create_dir_ns+0xce/0xe0
> >> [  491.329770]  kobject_add_internal+0xba/0x250
> >> [  491.329775]  kobject_add+0x96/0xc0
> >> [  491.329779]  ? get_device_parent+0xde/0x1e0
> >> [  491.329784]  device_add+0xe2/0x870
> >> [  491.329790]  __power_supply_register.part.0+0x20f/0x3f0
> >> [  491.329797]  sysfs_add_battery+0xa4/0x1d0 [battery]
> >> [  491.329805]  acpi_battery_update+0x19e/0x290 [battery]
> >> [  491.329809]  acpi_battery_notify+0x50/0x120 [battery]
> >> [  491.329812]  acpi_ev_notify_dispatch+0x49/0x70
> >> [  491.329817]  acpi_os_execute_deferred+0x1a/0x30
> >> [  491.329820]  process_one_work+0x177/0x330
> >> [  491.329826]  worker_thread+0x251/0x390
> >> [  491.329830]  ? __pfx_worker_thread+0x10/0x10
> >> [  491.329833]  kthread+0xd2/0x100
> >> [  491.329836]  ? __pfx_kthread+0x10/0x10
> >> [  491.329838]  ret_from_fork+0x34/0x50
> >> [  491.329842]  ? __pfx_kthread+0x10/0x10
> >> [  491.329844]  ret_from_fork_asm+0x1a/0x30
> >> [  491.329850]  </TASK>
> >> [  491.329855] kobject: kobject_add_internal failed for BAT1 with -EEX=
IST, don't try to register things with the same name in the same directory.
> >>
> >> Fixes: 10666251554c ("ACPI: battery: Install Notify() handler directly=
")
> >> Signed-off-by: GuangFei Luo <luogf2025@163.com>
> >> Cc: stable@vger.kernel.org
> >> ---
> >> v6:
> >>   - Update Fixes tag: point to commit 10666251554c ("ACPI: battery: In=
stall
> >>     Notify() handler directly"), which introduced the sysfs_add_batter=
y()
> >>     re-entry issue when acpi_battery_notify is registered via
> >>     acpi_dev_install_notify_handler(). The problem does not occur with
> >>     acpi_bus_register_driver().
> >>
> >> v5:
> >>   - Move changelog above the '---' line as per submission guidelines.
> >>
> >> v4:
> >>   - Uses guard(mutex) for battery->sysfs_lock in sysfs_add_battery().
> >>   - Since sysfs_add_battery() now handles the battery->bat check with
> >>     proper locking,the extra if (!battery->bat) check at the call site
> >>     has become redundant.
> >>
> >> v3:
> >>   - Modified the earlier approach: since sysfs_add_battery() is invoke=
d
> >>     from multiple places, the most reliable way is to add the lock ins=
ide
> >>     the function itself.
> >>   - sysfs_remove_battery() had a similar race issue in the past, which=
 was
> >>     fixed by adding a lock as well. Reference:
> >>     https://lore.kernel.org/all/9c921c22a7f33397a6774d7fa076db9b6a0fd6=
69
> >>         .1312318300.git.len.brown@intel.com/
> >>
> >> v2:
> >>  - Fix missing mutex_unlock in acpi_battery_update()
> >>    (Reported-by: kernel test robot)
> >>
> >> v1:
> >>  - Initial patch to handle race when hotplugging battery, preventing
> >>    duplicate sysfs entries.
> >> ---
> >>  drivers/acpi/battery.c | 20 +++++++++++---------
> >>  1 file changed, 11 insertions(+), 9 deletions(-)
> >>
> >> diff --git a/drivers/acpi/battery.c b/drivers/acpi/battery.c
> >> index 6905b56bf3e4..20d68f3e881f 100644
> >> --- a/drivers/acpi/battery.c
> >> +++ b/drivers/acpi/battery.c
> >> @@ -850,6 +850,10 @@ static void __exit battery_hook_exit(void)
> >>
> >>  static int sysfs_add_battery(struct acpi_battery *battery)
> >>  {
> >> +       guard(mutex)(&battery->sysfs_lock);
> >> +       if (battery->bat)
> >> +               return 0;
> >> +
> >>         struct power_supply_config psy_cfg =3D {
> >>                 .drv_data =3D battery,
> >>                 .attr_grp =3D acpi_battery_groups,
> >> @@ -1026,11 +1030,9 @@ static int acpi_battery_update(struct acpi_batt=
ery *battery, bool resume)
> >>                 return result;
> >>         acpi_battery_quirks(battery);
> >>
> >> -       if (!battery->bat) {
> >> -               result =3D sysfs_add_battery(battery);
> >> -               if (result)
> >> -                       return result;
> >> -       }
> >> +       result =3D sysfs_add_battery(battery);
> >> +       if (result)
> >> +               return result;
> >>
> >>         /*
> >>          * Wakeup the system if battery is critical low
> >> @@ -1112,12 +1114,12 @@ static int battery_notify(struct notifier_bloc=
k *nb,
> >>                         result =3D acpi_battery_get_info(battery);
> >>                         if (result)
> >>                                 return result;
> >> -
> >> -                       result =3D sysfs_add_battery(battery);
> >> -                       if (result)
> >> -                               return result;
> >>                 }
> >>
> >> +               result =3D sysfs_add_battery(battery);
> >> +               if (result)
> >> +                       return result;
> >> +
> >
> >Why is this change necessary?
> Hi Rafael,
>
> In the previous code:
>
>         if (battery->bat) {
>                 acpi_battery_refresh(battery);
>         } else {
>                 result =3D acpi_battery_get_info(battery);
>                 if (result)
>                         return result;
>
>                 result =3D sysfs_add_battery(battery);
>                 if (result)
>                         return result;
>         }
>
> the `if (!battery->bat)` check was done at the call site.  However,
> this check is not atomic: two threads can both see `battery->bat =3D=3D N=
ULL`
> and then call `sysfs_add_battery()` concurrently, leading to duplicate
> sysfs registration and `-EEXIST` errors.
>
> By moving the check and mutex into `sysfs_add_battery()`, the race is
> handled atomically.  All call sites can now invoke it unconditionally,
> and the function itself will no-op if the battery is already registered.
> This avoids duplicated `if (!battery->bat)` logic and ensures consistent
> protection everywhere.

Since the lock is acquired in sysfs_add_battery(), the race is
addressed regardless of the change in question.  The only difference
is when the previous battery->bat check passes (that is, battery->bat
is not NULL to start with), and if battery->bat becomes NULL between
the two checks, the entire section of the code checking battery->bat
needs to go under the lock.

I think that all battery->bat accesses need to be done under the lock
now, don't they?

