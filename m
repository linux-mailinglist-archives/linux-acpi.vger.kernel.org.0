Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B24F32D1195
	for <lists+linux-acpi@lfdr.de>; Mon,  7 Dec 2020 14:15:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725881AbgLGNPJ (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 7 Dec 2020 08:15:09 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:46694 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726007AbgLGNPJ (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 7 Dec 2020 08:15:09 -0500
Received: by mail-oi1-f194.google.com with SMTP id k2so15295635oic.13;
        Mon, 07 Dec 2020 05:14:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=s6MWkWXGonlQB+AtEO8xx9v7vK3wSSHws2hVIkSBy6A=;
        b=NBD9lEMKVr4OE0d9E8crWSebQjFwl662KvmS4RjCWDIK4oOsqXz6eM3PjIH5cBSJOo
         P2IDm/nQrJVyMiSSQA9fDiQTeoTSdcoueJxxsjihB1/g5RvD438d2eHS3Q+JxA7OW5II
         r/iya3Mh9UVu3cwz0k2A9GU9k/CHWDLFWHDOy2nlh9wjS1/pbOU7PrylJddeH8M482yw
         HDBnOobV59N5zkHNxfutDEDh5D4vP/1rdi6pk1VLMImoi5LaNFS7h/IKAGJR+4yZoOg+
         x0lAirQ3J3gfLgFKx+PL04Inl2roNA25iSgOddBF9EDeOzcXccGaRgv4QLcuAcb2oN+b
         0Ojw==
X-Gm-Message-State: AOAM530BBa3TmZk/lpuB5O2EJG6AEhNaochhUNCyq0kSam5NH1A/rvjM
        1MNAnPtQq2zRQfczZCPY/mMsg/D+VaFyU4NljoM=
X-Google-Smtp-Source: ABdhPJwCP3xS8uVENTrgNk1lY4pwdaX5cMg2CwSMsWVSXZBicYluNvHKxfjaSvTl7rm5CM4aWTDC+wya4mI+cAe1xbg=
X-Received: by 2002:aca:5197:: with SMTP id f145mr3709504oib.71.1607346868278;
 Mon, 07 Dec 2020 05:14:28 -0800 (PST)
MIME-Version: 1.0
References: <20201204182545.8322-1-pierre-louis.bossart@linux.intel.com>
In-Reply-To: <20201204182545.8322-1-pierre-louis.bossart@linux.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 7 Dec 2020 14:14:11 +0100
Message-ID: <CAJZ5v0hPBwynaTVmD-2_wpv87f5_DLEz1Bc4Qx8aUgunrRRn-g@mail.gmail.com>
Subject: Re: [PATCH] ACPI: fan: fix warning with CONFIG_DEBUG_LOCK_ALLOC
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Zhang Rui <rui.zhang@intel.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        "open list:ACPI FAN DRIVER" <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, Dec 4, 2020 at 7:27 PM Pierre-Louis Bossart
<pierre-louis.bossart@linux.intel.com> wrote:
>
> On a TigerLake device with CONFIG_DEBUG_LOCK_ALLOC the following
> warning is thrown:
>
> [   13.784413] BUG: key ffff88810ea5a080 has not been registered!
> [   13.784722] DEBUG_LOCKS_WARN_ON(1)
> [   13.784737] WARNING: CPU: 2 PID: 1 at kernel/locking/lockdep.c:4623
> lockdep_init_map_waits+0x25e/0x310
> [   13.787831] Call Trace:
> [   13.787902]  __kernfs_create_file+0xa5/0x180
> [   13.788016]  sysfs_add_file_mode_ns+0x120/0x270
> [   13.788138]  sysfs_create_file_ns+0xcd/0x120
> [   13.788256]  ? sysfs_add_file_mode_ns+0x270/0x270
> [   13.788381]  ? fan_get_max_state+0x70/0x70
> [   13.788491]  ? sort_r+0x1a5/0x200
> [   13.788579]  acpi_fan_probe+0x63b/0x7a0
>
> Dynamically-allocated attributes need to be initialized to make
> lockdep happy, see include/linux/sysfs.h
>
> Fixes: d19e470b6605c ('ACPI: fan: Expose fan performance state information')
> Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> ---
>  drivers/acpi/fan.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/acpi/fan.c b/drivers/acpi/fan.c
> index 66c3983f0ccc..9cab806298ff 100644
> --- a/drivers/acpi/fan.c
> +++ b/drivers/acpi/fan.c
> @@ -357,6 +357,7 @@ static int acpi_fan_get_fps(struct acpi_device *device)
>                 fps->dev_attr.store = NULL;
>                 fps->dev_attr.attr.name = fps->name;
>                 fps->dev_attr.attr.mode = 0444;
> +               sysfs_attr_init(&fps->dev_attr.attr);
>                 status = sysfs_create_file(&device->dev.kobj, &fps->dev_attr.attr);
>                 if (status) {
>                         int j;
> --

This has been fixed in the mainline already AFAICS, by commit
7dc7a8b04f3d ("ACPI: fan: Initialize performance state sysfs
attribute").
