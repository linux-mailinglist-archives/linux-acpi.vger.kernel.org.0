Return-Path: <linux-acpi+bounces-17207-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D697BB926F7
	for <lists+linux-acpi@lfdr.de>; Mon, 22 Sep 2025 19:30:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 897802A6EA4
	for <lists+linux-acpi@lfdr.de>; Mon, 22 Sep 2025 17:30:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAA1B3148C0;
	Mon, 22 Sep 2025 17:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j0SWwhqk"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95A023148AE
	for <linux-acpi@vger.kernel.org>; Mon, 22 Sep 2025 17:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758562201; cv=none; b=dqzWJV6KdsLoN/HROT3ehP/SP55k0HGvXmKIHpQVY5VefljSeDQqzjvaAwAxRmTg1Squ47bvKiT8kj37yfJdyMVmk2vPtcgiPLco05bBSC1a7maDXtJNJlQ0h1oVhQLi6kXdWfo2ie2qiP93ES3u1aFjKZyNonjDxbc4n+jh9GQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758562201; c=relaxed/simple;
	bh=6Al3E7s3Z6hFm5b5miLNSVz7j/KaGcZvja7S18tPyjw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=G6NYBxX1RW8ZexEyuWepU/XvsEBt6u2kLU15H2YWrtkRcf6joAoZl0rw1zCk5PfWObo7SQF4Cz1QwnVZMy1NeZTjEYanXH5xlJw/T2s00RI0c6NdsiBra1O4qwyy7BOXt8LNFukktYl+GIn0D2OmkLGE/mEjKwT8+WnF3+yW04Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j0SWwhqk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C295C19425
	for <linux-acpi@vger.kernel.org>; Mon, 22 Sep 2025 17:30:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758562201;
	bh=6Al3E7s3Z6hFm5b5miLNSVz7j/KaGcZvja7S18tPyjw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=j0SWwhqkn2wV3+GqZRF1oxn0XPse+AybzVLpzvHjh6TW6ulfU7/Qvr8bD5Bpm3Pcy
	 nGojWjlw/RYcKpBCGmNYaYS4Pl87VGpvNy6ee3oPbmTL6y7brkx33JzS3ZtHaxNSiA
	 XxJFgSmStmkEQ0eh01oH3cNAJQJflrfnnNoNyFRNPujtn4ylqzTKLEWQqqLG/2YiVs
	 qy/iiWQ6NS7DMnRugFXhh2vqSaClJOBSYupAlxIU+OWk9frOZRkUFq8/q/GaqV2T4i
	 NclUVepp1Bu+4lQcoNvTTkUk/DaVdHgCojAON94uQFxFn8RFKqfblR68rZUmdUC6Qp
	 8r8wWQS5xis/w==
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-43d2da52291so2292197b6e.1
        for <linux-acpi@vger.kernel.org>; Mon, 22 Sep 2025 10:30:01 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUqv2Lg+indQwxHvR4DTC8JdwCgfdK9ZARdK//AT+nqMlvNJk6z5wAxwRsVFp+Ihi7D6cE5ugS4Jhmv@vger.kernel.org
X-Gm-Message-State: AOJu0YzIJppQUvJFkA028Wqy8WPTsO21mf4HsDMAdl9XViBAJPhtUlDA
	ehLXrLjohKuFwXE6uszVc0GXNJOwzhxVd1n81iwjhMekNIZwOOgXWtinIgiJ/znikPojMPr2EYW
	umfXAdUQi+Uj5+ziNzQIFt50F7HO3sHw=
X-Google-Smtp-Source: AGHT+IFlrx8L8oqv9pz//Cs5oDAAIyPzryy+k3Au3ytXII69jPuj4eAQDd6pEEPz5O0zDJRs+VoNeAs0c86wAgaW6f8=
X-Received: by 2002:a05:6808:4f4f:b0:43f:2500:6536 with SMTP id
 5614622812f47-43f25007375mr835643b6e.21.1758562199811; Mon, 22 Sep 2025
 10:29:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250918135549.1075-1-luogf2025@163.com>
In-Reply-To: <20250918135549.1075-1-luogf2025@163.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 22 Sep 2025 19:29:48 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0hN52GMte2dCx1u=i_MSuLFMt+2-HYdg+nmU73U9WptDQ@mail.gmail.com>
X-Gm-Features: AS18NWCGCiHo7Ollt8aSlvAfGn5khT1Z3En1BLf_7-RqYiBBZh4-a20CF_5qNNc
Message-ID: <CAJZ5v0hN52GMte2dCx1u=i_MSuLFMt+2-HYdg+nmU73U9WptDQ@mail.gmail.com>
Subject: Re: [PATCH v6] ACPI: battery: prevent sysfs_add_battery re-entry on
 rapid events
To: GuangFei Luo <luogf2025@163.com>
Cc: rafael@kernel.org, michal.wilczynski@intel.com, dan.carpenter@linaro.org, 
	lenb@kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org, lkp@intel.com, sre@kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 18, 2025 at 3:56=E2=80=AFPM GuangFei Luo <luogf2025@163.com> wr=
ote:
>
> When removing and reinserting the laptop battery, ACPI can trigger
> two notifications in quick succession:
>   - ACPI_BATTERY_NOTIFY_STATUS (0x80)
>   - ACPI_BATTERY_NOTIFY_INFO   (0x81)
>
> Both notifications call acpi_battery_update(). Because the events
> happen very close in time, sysfs_add_battery() can be re-entered
> before battery->bat is set, causing a duplicate sysfs entry error.
>
> When the ACPI battery driver uses
> acpi_dev_install_notify_handler() to register acpi_battery_notify,
> the callback may be triggered twice in a very short period of time.
>
> This patch ensures that sysfs_add_battery() is not re-entered
> when battery->bat is already non-NULL, preventing the duplicate
> sysfs creation and stabilizing battery hotplug handling.
>
> [  476.117945] sysfs: cannot create duplicate filename '/devices/LNXSYSTM=
:00/LNXSYBUS:00/PNP0C0A:00/power_supply/BAT1'
> [  476.118896] CPU: 1 UID: 0 PID: 185 Comm: kworker/1:4 Kdump: loaded Not=
 tainted 6.12.38+deb13-amd64 #1  Debian 6.12.38-1
> [  476.118903] Hardware name: Gateway          NV44             /SJV40-MV=
        , BIOS V1.3121 04/08/2009
> [  476.118906] Workqueue: kacpi_notify acpi_os_execute_deferred
> [  476.118917] Call Trace:
> [  476.118922]  <TASK>
> [  476.118929]  dump_stack_lvl+0x5d/0x80
> [  476.118938]  sysfs_warn_dup.cold+0x17/0x23
> [  476.118943]  sysfs_create_dir_ns+0xce/0xe0
> [  476.118952]  kobject_add_internal+0xba/0x250
> [  476.118959]  kobject_add+0x96/0xc0
> [  476.118964]  ? get_device_parent+0xde/0x1e0
> [  476.118970]  device_add+0xe2/0x870
> [  476.118975]  __power_supply_register.part.0+0x20f/0x3f0
> [  476.118981]  ? wake_up_q+0x4e/0x90
> [  476.118990]  sysfs_add_battery+0xa4/0x1d0 [battery]
> [  476.118998]  acpi_battery_update+0x19e/0x290 [battery]
> [  476.119002]  acpi_battery_notify+0x50/0x120 [battery]
> [  476.119006]  acpi_ev_notify_dispatch+0x49/0x70
> [  476.119012]  acpi_os_execute_deferred+0x1a/0x30
> [  476.119015]  process_one_work+0x177/0x330
> [  476.119022]  worker_thread+0x251/0x390
> [  476.119026]  ? __pfx_worker_thread+0x10/0x10
> [  476.119030]  kthread+0xd2/0x100
> [  476.119033]  ? __pfx_kthread+0x10/0x10
> [  476.119035]  ret_from_fork+0x34/0x50
> [  476.119040]  ? __pfx_kthread+0x10/0x10
> [  476.119042]  ret_from_fork_asm+0x1a/0x30
> [  476.119049]  </TASK>
> [  476.142552] kobject: kobject_add_internal failed for BAT1 with -EEXIST=
, don't try to register things with the same name in the same directory.
> [  476.415022] ata1.00: unexpected _GTF length (8)
> [  476.428076] sd 0:0:0:0: [sda] Starting disk
> [  476.835035] ata1.00: unexpected _GTF length (8)
> [  476.839720] ata1.00: configured for UDMA/133
> [  491.328831] sysfs: cannot create duplicate filename '/devices/LNXSYSTM=
:00/LNXSYBUS:00/PNP0C0A:00/power_supply/BAT1'
> [  491.329720] CPU: 1 UID: 0 PID: 185 Comm: kworker/1:4 Kdump: loaded Not=
 tainted 6.12.38+deb13-amd64 #1  Debian 6.12.38-1
> [  491.329727] Hardware name: Gateway          NV44             /SJV40-MV=
        , BIOS V1.3121 04/08/2009
> [  491.329731] Workqueue: kacpi_notify acpi_os_execute_deferred
> [  491.329741] Call Trace:
> [  491.329745]  <TASK>
> [  491.329751]  dump_stack_lvl+0x5d/0x80
> [  491.329758]  sysfs_warn_dup.cold+0x17/0x23
> [  491.329762]  sysfs_create_dir_ns+0xce/0xe0
> [  491.329770]  kobject_add_internal+0xba/0x250
> [  491.329775]  kobject_add+0x96/0xc0
> [  491.329779]  ? get_device_parent+0xde/0x1e0
> [  491.329784]  device_add+0xe2/0x870
> [  491.329790]  __power_supply_register.part.0+0x20f/0x3f0
> [  491.329797]  sysfs_add_battery+0xa4/0x1d0 [battery]
> [  491.329805]  acpi_battery_update+0x19e/0x290 [battery]
> [  491.329809]  acpi_battery_notify+0x50/0x120 [battery]
> [  491.329812]  acpi_ev_notify_dispatch+0x49/0x70
> [  491.329817]  acpi_os_execute_deferred+0x1a/0x30
> [  491.329820]  process_one_work+0x177/0x330
> [  491.329826]  worker_thread+0x251/0x390
> [  491.329830]  ? __pfx_worker_thread+0x10/0x10
> [  491.329833]  kthread+0xd2/0x100
> [  491.329836]  ? __pfx_kthread+0x10/0x10
> [  491.329838]  ret_from_fork+0x34/0x50
> [  491.329842]  ? __pfx_kthread+0x10/0x10
> [  491.329844]  ret_from_fork_asm+0x1a/0x30
> [  491.329850]  </TASK>
> [  491.329855] kobject: kobject_add_internal failed for BAT1 with -EEXIST=
, don't try to register things with the same name in the same directory.
>
> Fixes: 10666251554c ("ACPI: battery: Install Notify() handler directly")
> Signed-off-by: GuangFei Luo <luogf2025@163.com>
> Cc: stable@vger.kernel.org
> ---
> v6:
>   - Update Fixes tag: point to commit 10666251554c ("ACPI: battery: Insta=
ll
>     Notify() handler directly"), which introduced the sysfs_add_battery()
>     re-entry issue when acpi_battery_notify is registered via
>     acpi_dev_install_notify_handler(). The problem does not occur with
>     acpi_bus_register_driver().
>
> v5:
>   - Move changelog above the '---' line as per submission guidelines.
>
> v4:
>   - Uses guard(mutex) for battery->sysfs_lock in sysfs_add_battery().
>   - Since sysfs_add_battery() now handles the battery->bat check with
>     proper locking,the extra if (!battery->bat) check at the call site
>     has become redundant.
>
> v3:
>   - Modified the earlier approach: since sysfs_add_battery() is invoked
>     from multiple places, the most reliable way is to add the lock inside
>     the function itself.
>   - sysfs_remove_battery() had a similar race issue in the past, which wa=
s
>     fixed by adding a lock as well. Reference:
>     https://lore.kernel.org/all/9c921c22a7f33397a6774d7fa076db9b6a0fd669
>         .1312318300.git.len.brown@intel.com/
>
> v2:
>  - Fix missing mutex_unlock in acpi_battery_update()
>    (Reported-by: kernel test robot)
>
> v1:
>  - Initial patch to handle race when hotplugging battery, preventing
>    duplicate sysfs entries.
> ---
>  drivers/acpi/battery.c | 20 +++++++++++---------
>  1 file changed, 11 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/acpi/battery.c b/drivers/acpi/battery.c
> index 6905b56bf3e4..20d68f3e881f 100644
> --- a/drivers/acpi/battery.c
> +++ b/drivers/acpi/battery.c
> @@ -850,6 +850,10 @@ static void __exit battery_hook_exit(void)
>
>  static int sysfs_add_battery(struct acpi_battery *battery)
>  {
> +       guard(mutex)(&battery->sysfs_lock);
> +       if (battery->bat)
> +               return 0;
> +
>         struct power_supply_config psy_cfg =3D {
>                 .drv_data =3D battery,
>                 .attr_grp =3D acpi_battery_groups,
> @@ -1026,11 +1030,9 @@ static int acpi_battery_update(struct acpi_battery=
 *battery, bool resume)
>                 return result;
>         acpi_battery_quirks(battery);
>
> -       if (!battery->bat) {
> -               result =3D sysfs_add_battery(battery);
> -               if (result)
> -                       return result;
> -       }
> +       result =3D sysfs_add_battery(battery);
> +       if (result)
> +               return result;
>
>         /*
>          * Wakeup the system if battery is critical low
> @@ -1112,12 +1114,12 @@ static int battery_notify(struct notifier_block *=
nb,
>                         result =3D acpi_battery_get_info(battery);
>                         if (result)
>                                 return result;
> -
> -                       result =3D sysfs_add_battery(battery);
> -                       if (result)
> -                               return result;
>                 }
>
> +               result =3D sysfs_add_battery(battery);
> +               if (result)
> +                       return result;
> +

Why is this change necessary?

>                 acpi_battery_init_alarm(battery);
>                 acpi_battery_get_state(battery);
>                 break;
> --

