Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40F0129FE3B
	for <lists+linux-acpi@lfdr.de>; Fri, 30 Oct 2020 08:09:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725823AbgJ3HJ0 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-acpi@lfdr.de>); Fri, 30 Oct 2020 03:09:26 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:58415 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725832AbgJ3HJ0 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 30 Oct 2020 03:09:26 -0400
Received: from mail-pg1-f198.google.com ([209.85.215.198])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1kYOXM-0007jr-2g
        for linux-acpi@vger.kernel.org; Fri, 30 Oct 2020 07:09:24 +0000
Received: by mail-pg1-f198.google.com with SMTP id 33so3996759pgt.9
        for <linux-acpi@vger.kernel.org>; Fri, 30 Oct 2020 00:09:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=Xw8H3Bfn3AE6g1u4Mk5g1UKRNC8P7Hx1s9VXg3Ta4d4=;
        b=FWsUiJvjLYVgW6cBJ4peMu7hoXUchsDAYWChBM5CGTZhgRBi1xbJeLWajzmZdZyulG
         kEGyD/y+gtPkeSGpIiptXWvEynAUSxOeT1ohOTVDfdXxfLV992E1XWCVTB+eWGsnwCYx
         xfP/taPEVqe368HV9jumYWSDsxa+OUMfAG0sDDjBOdd7nZSGhd329FYzYCjCK3LTSsts
         jNB2+Y+7kkqIw34Xn/3umBWXUicycL1M8IHxICD6d4D7jeG9tYmjzWRXukItn8mW6Xml
         9zzutY8G3WMThXV1An5oiDDSK8+X5IrKvXFF7N3e8VTJ/ATUsKCkbrS1Y42erUTmrbeN
         13hg==
X-Gm-Message-State: AOAM530NJ4aSdZ0QqIbQBbJz4IQmDKexTmr74St3eW/+bBaUociw8Y5B
        Tvvjri+2I/BdkbW0ugdC08hpBP9FTo6aovVIepuBXiUvLT7+g52XvPMZVha9bbGtGyOxXEVPh8K
        BSr3dVxolf3E7szK5rDigNjYfXR2LJTo/p0pD0Xg=
X-Received: by 2002:a63:af02:: with SMTP id w2mr992666pge.339.1604041762241;
        Fri, 30 Oct 2020 00:09:22 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxsMwRrn6Sp8qNtcQGjp/1tNXjqyZk4sqMOpa7T/8iYOmtXLw3vJoBE2xuu0MgnLorsI8hAbw==
X-Received: by 2002:a63:af02:: with SMTP id w2mr992648pge.339.1604041762026;
        Fri, 30 Oct 2020 00:09:22 -0700 (PDT)
Received: from [192.168.1.208] (220-133-187-190.HINET-IP.hinet.net. [220.133.187.190])
        by smtp.gmail.com with ESMTPSA id e11sm4894259pfl.58.2020.10.30.00.09.19
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 30 Oct 2020 00:09:21 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.4\))
Subject: Re: [PATCH] PM / reboot: Use S5 for reboot
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
In-Reply-To: <20201030070659.16948-1-kai.heng.feng@canonical.com>
Date:   Fri, 30 Oct 2020 15:09:17 +0800
Cc:     "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>,
        linux-acpi@vger.kernel.org, Petr Mladek <pmladek@suse.com>,
        Mike Rapoport <rppt@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Kees Cook <keescook@chromium.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: 8BIT
Message-Id: <45641823-1866-4FF5-9A1C-BFF61A66FCE3@canonical.com>
References: <20201030070659.16948-1-kai.heng.feng@canonical.com>
To:     Hans de Goede <hdegoede@redhat.com>
X-Mailer: Apple Mail (2.3608.120.23.2.4)
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Hans,

> On Oct 30, 2020, at 15:06, Kai-Heng Feng <kai.heng.feng@canonical.com> wrote:
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

I wonder if this can also solve "HID: i2c-hid: Put ACPI enumerated devices in D3 on shutdown" fixed.

Kai-Heng

> 
> [1] https://docs.microsoft.com/en-us/windows/win32/power/system-power-states
> 
> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> ---
> kernel/reboot.c | 2 ++
> 1 file changed, 2 insertions(+)
> 
> diff --git a/kernel/reboot.c b/kernel/reboot.c
> index e7b78d5ae1ab..7e5aa1f78693 100644
> --- a/kernel/reboot.c
> +++ b/kernel/reboot.c
> @@ -244,6 +244,8 @@ void migrate_to_reboot_cpu(void)
> void kernel_restart(char *cmd)
> {
> 	kernel_restart_prepare(cmd);
> +	if (pm_power_off_prepare)
> +		pm_power_off_prepare();
> 	migrate_to_reboot_cpu();
> 	syscore_shutdown();
> 	if (!cmd)
> -- 
> 2.17.1
> 

