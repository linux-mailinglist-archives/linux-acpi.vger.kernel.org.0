Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DA132ADDAA
	for <lists+linux-acpi@lfdr.de>; Tue, 10 Nov 2020 19:02:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730786AbgKJSCa (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 10 Nov 2020 13:02:30 -0500
Received: from mail-oo1-f68.google.com ([209.85.161.68]:37772 "EHLO
        mail-oo1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730760AbgKJSCa (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 10 Nov 2020 13:02:30 -0500
Received: by mail-oo1-f68.google.com with SMTP id t10so86889oon.4;
        Tue, 10 Nov 2020 10:02:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=a7bBakPnEgsRSxQE7/dsfPHRj6TDBLQdRIFwKNFk3Lg=;
        b=ri5ZIRe7CCRJIOvgYfI9zJmzTkswKVBpI+20HWinp9edeKxDCBauvT7SGBCVok9jSI
         9x/Vnu/ps7beTW5GFo0PI6jxGVanIlUJ/bEoeoMZvnWid3dFY3XhOni6eb3gwvnyEVdC
         Ox41D2b3/d1Ob8vvkyCvVJMhuPEmEPoO9SfZRZuJOi16inqcXQl+IyDXTot+Lz+yVHDM
         rqkB6Gi7HlNvY9wXldJ8z/PDtpg8Q45rgCKvvWTinte7CYRuI7ibU3J14RoVsKpAaVcM
         E2K5hhg5+UUdg+lSb6fNgBcXDOHldMGhbWSFA1V6XfrmUz14q3d9cOoCAQn32UVAOBGb
         4euA==
X-Gm-Message-State: AOAM531dISEkiI4h/5tnHRv0FLwmGS20J7FIQt9oy87yw9xeO4xGi3yj
        VDshsfUgfFCoM8mrqnVhRupbC4DZXS08EKu8T0Sso2Uf
X-Google-Smtp-Source: ABdhPJw1pxewSH2J2VBZP6s08/qov1XlMFKLLcj9YKwKQ/HM8kQ8zCNYrq5ldX3l3DDWNQWpL1X3qmNtqih2c2iwZto=
X-Received: by 2002:a4a:e80b:: with SMTP id b11mr14320057oob.1.1605031349208;
 Tue, 10 Nov 2020 10:02:29 -0800 (PST)
MIME-Version: 1.0
References: <20201030070659.16948-1-kai.heng.feng@canonical.com>
In-Reply-To: <20201030070659.16948-1-kai.heng.feng@canonical.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 10 Nov 2020 19:02:18 +0100
Message-ID: <CAJZ5v0j_bv1t5krP98_-epm+z9usW3ZmteaTGwtyjo+wBFu6Kw@mail.gmail.com>
Subject: Re: [PATCH] PM / reboot: Use S5 for reboot
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc:     Rafael Wysocki <rafael.j.wysocki@intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Petr Mladek <pmladek@suse.com>,
        Mike Rapoport <rppt@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Kees Cook <keescook@chromium.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, Oct 30, 2020 at 8:07 AM Kai-Heng Feng
<kai.heng.feng@canonical.com> wrote:
>
> After reboot, it's not possible to use hotkeys to enter BIOS setup and
> boot menu on some HP laptops.
>
> BIOS folks identified the root cause is the missing _PTS call, and BIOS
> is expecting _PTS to do proper reset.
>
> Using S5 for reboot is default behavior under Windows, "A full shutdown
> (S5) occurs when a system restart is requested" [1], so let's do the
> same here.
>
> [1] https://docs.microsoft.com/en-us/windows/win32/power/system-power-states
>
> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> ---
>  kernel/reboot.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/kernel/reboot.c b/kernel/reboot.c
> index e7b78d5ae1ab..7e5aa1f78693 100644
> --- a/kernel/reboot.c
> +++ b/kernel/reboot.c
> @@ -244,6 +244,8 @@ void migrate_to_reboot_cpu(void)
>  void kernel_restart(char *cmd)
>  {
>         kernel_restart_prepare(cmd);
> +       if (pm_power_off_prepare)
> +               pm_power_off_prepare();
>         migrate_to_reboot_cpu();
>         syscore_shutdown();
>         if (!cmd)
> --

Applied as 5.11 material with a minor edit in the subject, thanks!
