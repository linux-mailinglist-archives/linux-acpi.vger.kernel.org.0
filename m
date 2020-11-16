Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 374632B45BB
	for <lists+linux-acpi@lfdr.de>; Mon, 16 Nov 2020 15:20:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729510AbgKPOUB (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 16 Nov 2020 09:20:01 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:45944 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729332AbgKPOUB (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 16 Nov 2020 09:20:01 -0500
Received: by mail-ot1-f67.google.com with SMTP id k3so16106928otp.12;
        Mon, 16 Nov 2020 06:20:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iUL4X0QC5X4rwfec/D+B+5Eqb0N/KHvq33dDfdJFA/A=;
        b=CyiObyLCeEMudZXdCqrwCd9gFRr/I2nA6yX10UHTgNt1dRSlO65og2lU6/2A3Q5Lfp
         EKLCeO7lZVPMqzmTMmIrMafbNDARHQTSkWC2ytduPLZFXDZsYce0L9Kkxx4LgWnGJ3il
         vbHmG6Vf3l5otIQB5iM7G4cYxRuasbtlBPzJqyZwFuBwR+G+USb0fjbrPnGIrHhBgVOF
         SOeLPVvaR6H/JevTr7jCaPuyVlf7OcHnx7qrui0LFw90Gy+PBGy/0XTq7DEuJmXGl8xJ
         gz+FUvHjB7ptKzkjstj8erSdJr4x+EO/MIJHrCDecgJBXztDIj4TTxoc8Wj5BzIpn/3m
         oGmQ==
X-Gm-Message-State: AOAM530tFX7J9+8hygcoVOkErKlJNWWVQ6hJLckgvOVJGrk7YezT6Mne
        JhxqiP9wgll59MsL3VAWsxzfITNpiqJUyJubFsOLVW+8
X-Google-Smtp-Source: ABdhPJx6L/QMZAEOb7KoU6nuCvoLI6S9z5PKJFtclTFZ7TM9ScZvGVR6pBLiESb+JufOkO/BWacMZm5WIgmMnRIp9Eg=
X-Received: by 2002:a9d:16f:: with SMTP id 102mr11227592otu.206.1605536400406;
 Mon, 16 Nov 2020 06:20:00 -0800 (PST)
MIME-Version: 1.0
References: <20201110235201.76981-1-linux@roeck-us.net>
In-Reply-To: <20201110235201.76981-1-linux@roeck-us.net>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 16 Nov 2020 15:19:43 +0100
Message-ID: <CAJZ5v0j_FCn=G0tUhBnYTtcxE-GL-LDyq9fOa8Dk4WV7uXBHcg@mail.gmail.com>
Subject: Re: [PATCH] ACPI: fan: Initialize performance state sysfs attribute
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Zhang Rui <rui.zhang@intel.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, Nov 11, 2020 at 12:52 AM Guenter Roeck <linux@roeck-us.net> wrote:
>
> The following warning is reported if lock debugging is enabled.
>
> DEBUG_LOCKS_WARN_ON(1)
> WARNING: CPU: 1 PID: 1 at kernel/locking/lockdep.c:4617 lockdep_init_map_waits+0x141/0x222
> ...
> Call Trace:
>  __kernfs_create_file+0x7a/0xd8
>  sysfs_add_file_mode_ns+0x135/0x189
>  sysfs_create_file_ns+0x70/0xa0
>  acpi_fan_probe+0x547/0x621
>  platform_drv_probe+0x67/0x8b
>  ...
>
> Dynamically allocated sysfs attributes need to be initialized to avoid
> the warning.
>
> Fixes: d19e470b6605 ("ACPI: fan: Expose fan performance state information")
> Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
>  drivers/acpi/fan.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/acpi/fan.c b/drivers/acpi/fan.c
> index 62873388b24f..9cbe58e394d0 100644
> --- a/drivers/acpi/fan.c
> +++ b/drivers/acpi/fan.c
> @@ -351,6 +351,7 @@ static int acpi_fan_get_fps(struct acpi_device *device)
>                 struct acpi_fan_fps *fps = &fan->fps[i];
>
>                 snprintf(fps->name, ACPI_FPS_NAME_LEN, "state%d", i);
> +               sysfs_attr_init(&fps->dev_attr.attr);
>                 fps->dev_attr.show = show_state;
>                 fps->dev_attr.store = NULL;
>                 fps->dev_attr.attr.name = fps->name;
> --

Applied as 5.11 material, thanks!
