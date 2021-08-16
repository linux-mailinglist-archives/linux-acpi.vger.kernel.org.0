Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 211453EDB01
	for <lists+linux-acpi@lfdr.de>; Mon, 16 Aug 2021 18:33:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229742AbhHPQeO (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 16 Aug 2021 12:34:14 -0400
Received: from mail-oo1-f51.google.com ([209.85.161.51]:37438 "EHLO
        mail-oo1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbhHPQeN (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 16 Aug 2021 12:34:13 -0400
Received: by mail-oo1-f51.google.com with SMTP id l12-20020a4a94cc0000b02902618ad2ea55so5124583ooi.4;
        Mon, 16 Aug 2021 09:33:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Npl3687re0zAy93wFJYspXoC8QqmEW4jdOxZPs+XoC4=;
        b=krqCNjoBH61L5AoY8q3J9VzTE1xxkqmcHuMVvhi1OCBDO6X55LQTmHur8iG7pHIao8
         078C7Hc4/G392NG+UxRo8KnGwzo/QA+ZDIuX8OuVHQo83MbcOJPHwgw45YqjZP0vDwrr
         9GNjq7zMchiDXkfjmIBbvUL7Gb+sI06IKG1pCkGg2vW1IIuWWKLIcagIq4s5hyG53Rqz
         lah1/44dvYVJYMeD9dvtMxTcjAgiGsCQOd2/4uV6bdqLRYs9cQPtxDCWa0mG1+nzsxoT
         sRjbbupq0BNRqOMidjqDNDrIw6ksqDbfzvfep4h8ORiwhk3K/2Cm/L7nnooL6cjVd4Th
         yoZg==
X-Gm-Message-State: AOAM530jhTyWOUbYfovJfuvKzAxmPMuDxHWJDTDEOoQF135r0gGXIdjV
        LVmuxdjh4sK3yWceqcyajsD+Mrii2xvmt17T1s0=
X-Google-Smtp-Source: ABdhPJyNmdpZhvbLiwbhP5y0AF/iSTrNp8KtOFnnYyZispzdJaIqX2v7UYdzjAB7ghRee7nqyynwncMJCR6vrLbbzAo=
X-Received: by 2002:a4a:9c05:: with SMTP id y5mr12051396ooj.2.1629131621666;
 Mon, 16 Aug 2021 09:33:41 -0700 (PDT)
MIME-Version: 1.0
References: <20210816113007.88902-1-hdegoede@redhat.com>
In-Reply-To: <20210816113007.88902-1-hdegoede@redhat.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 16 Aug 2021 18:33:30 +0200
Message-ID: <CAJZ5v0jArWOehWeO16fhnOrJGLqoVyX0tSNtBKcFuqv6=rMB2Q@mail.gmail.com>
Subject: Re: [PATCH] ACPI: platform-profile: call sysfs_notify() from platform_profile_store()
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Mark Pearson <markpearson@lenovo.com>,
        Len Brown <lenb@kernel.org>, Andy Shevchenko <andy@kernel.org>,
        "Luke D . Jones" <luke@ljones.dev>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, Aug 16, 2021 at 1:30 PM Hans de Goede <hdegoede@redhat.com> wrote:
>
> Drivers like thinkpad_acpi and ideapad_laptop call the
> platform_profile_notify() helper when the profile is changed by hardware
> (the embedded-controller/EC) in response to an EC handled hotkey.
>
> This allows userspace to monitor for such changes by polling for POLLPRI
> on the platform_profile sysfs file. But the profile can also be changed
> underneath a userspace program monitoring it by anonther userspace program
> storing a new value.
>
> Add a sysfs_notify() call to platform_profile_store(), so that userspace
> programs monitoring for changes also get notified in this case.
>
> Also update the documentation to document that POLLPRI polling can be
> used to watch for changes.
>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
>  Documentation/ABI/testing/sysfs-platform_profile | 7 +++++++
>  drivers/acpi/platform_profile.c                  | 3 +++
>  2 files changed, 10 insertions(+)
>
> diff --git a/Documentation/ABI/testing/sysfs-platform_profile b/Documentation/ABI/testing/sysfs-platform_profile
> index dae9c8941905..baf1d125f9f8 100644
> --- a/Documentation/ABI/testing/sysfs-platform_profile
> +++ b/Documentation/ABI/testing/sysfs-platform_profile
> @@ -26,3 +26,10 @@ Contact:     Hans de Goede <hdegoede@redhat.com>
>  Description:   Reading this file gives the current selected profile for this
>                 device. Writing this file with one of the strings from
>                 platform_profile_choices changes the profile to the new value.
> +
> +               This file can be monitored for changes by polling for POLLPRI,
> +               POLLPRI will be signalled on any changes, independent of those
> +               changes coming from a userspace write; or coming from another
> +               source such as e.g. a hotkey triggered profile change handled
> +               either directly by the embedded-controller or fully handled
> +               inside the kernel.
> diff --git a/drivers/acpi/platform_profile.c b/drivers/acpi/platform_profile.c
> index dd2fbf38e414..d418462ab791 100644
> --- a/drivers/acpi/platform_profile.c
> +++ b/drivers/acpi/platform_profile.c
> @@ -106,6 +106,9 @@ static ssize_t platform_profile_store(struct device *dev,
>         }
>
>         err = cur_profile->profile_set(cur_profile, i);
> +       if (!err)
> +               sysfs_notify(acpi_kobj, NULL, "platform_profile");
> +
>         mutex_unlock(&profile_lock);
>         if (err)
>                 return err;
> --

Applied as 5.15 material, thanks!
