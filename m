Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 154D044651F
	for <lists+linux-acpi@lfdr.de>; Fri,  5 Nov 2021 15:39:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233112AbhKEOmE (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 5 Nov 2021 10:42:04 -0400
Received: from mail-ot1-f48.google.com ([209.85.210.48]:39561 "EHLO
        mail-ot1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232865AbhKEOmE (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 5 Nov 2021 10:42:04 -0400
Received: by mail-ot1-f48.google.com with SMTP id c26-20020a9d615a000000b0055bf6efab46so5106349otk.6;
        Fri, 05 Nov 2021 07:39:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VTa1m+M0trWvovWd1u5XqKaD5cR/58XJc93gIZv2JIU=;
        b=t9m8ZkGOOjtugnTKXE3EgLwT9We6Xtu0HDHJ7RRsefBPGWlDPbdBEmxvOq8F7YCk2g
         seaRmRJew2ddbO81d7ZvTiDP7VsFGws2rMldtrn/YulP0FszYdRRF4inzqpDyWpyQ+oF
         Zmc1km1so3lLY6srmP13rHJbtHHrSCZTrIZxSNwoFl7LmLXIm1G+kciO987z3H86YwZG
         1Q4waSAEzMArZdYtYLWQVnHmF6E75ws7Qv8zQWsW3iMklSpvvuBHif3Ek44SIix6JcJj
         APZ4a++TTUy/kMHCQyqvYPUQYjk/3XgY2E6xslIVgsoSFvyeLvPnwVgHQzk2bV4Q51Cy
         pr7w==
X-Gm-Message-State: AOAM531BymkR77nQsKZeNGys5vHJ192O92pXXRTIjcbxYZWP1RYEWvle
        dLF0FONN88ExAqxxnjZtOuwEdG5IDoBWOLEwQZu016/T
X-Google-Smtp-Source: ABdhPJy+X17NfVBfLLcL6WVEJYs2fK1iJTS+86IZ46E7ixSdCOhWifsBUKtdUr3xdhTL4Olm7jipl9zFqmbyXWSaXEY=
X-Received: by 2002:a9d:a64:: with SMTP id 91mr38181170otg.198.1636123163940;
 Fri, 05 Nov 2021 07:39:23 -0700 (PDT)
MIME-Version: 1.0
References: <2606454.mvXUDI8C0e@kreacher> <11862743.O9o76ZdvQC@kreacher>
In-Reply-To: <11862743.O9o76ZdvQC@kreacher>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 5 Nov 2021 15:39:13 +0100
Message-ID: <CAJZ5v0i4QAmHszoKybD_TSHdkA6T+LE52DP7Bs_YUGo9NFmNDw@mail.gmail.com>
Subject: Re: [PATCH] ACPI: PM: Fix device wakeup power reference counting error
To:     Linux ACPI <linux-acpi@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, Nov 4, 2021 at 10:54 PM Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>
> On Thursday, November 4, 2021 6:21:51 PM CET Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > Fix a device wakeup power reference counting error introduced by
> > commit a2d7b2e004af ("ACPI: PM: Fix sharing of wakeup power
> > resources").
> >
> > Fixes: a2d7b2e004af ("ACPI: PM: Fix sharing of wakeup power resources")
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > ---
> >  drivers/acpi/power.c |    4 +---
> >  1 file changed, 1 insertion(+), 3 deletions(-)
> >
> > Index: linux-pm/drivers/acpi/power.c
> > ===================================================================
> > --- linux-pm.orig/drivers/acpi/power.c
> > +++ linux-pm/drivers/acpi/power.c
> > @@ -757,10 +757,8 @@ int acpi_disable_wakeup_device_power(str
> >
> >       mutex_lock(&acpi_device_lock);
> >
> > -     if (dev->wakeup.prepare_count > 1) {
> > +     if (dev->wakeup.prepare_count >= 1)
> >               dev->wakeup.prepare_count--;
> > -             goto out;
> > -     }
> >
> >       /* Do nothing if wakeup power has not been enabled for this device. */
> >       if (!dev->wakeup.prepare_count)
>
> This is still not good.  It should be something like the patch below, but I
> need to test that one.

Tested now, so applying as 5.16-rc material.

> ---
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Subject: [PATCH v2] ACPI: PM: Fix device wakeup power reference counting error
>
> Fix a device wakeup power reference counting error introduced by
> commit a2d7b2e004af ("ACPI: PM: Fix sharing of wakeup power
> resources").
>
> Fixes: a2d7b2e004af ("ACPI: PM: Fix sharing of wakeup power resources")
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>
> -> v2: Actually disable wakeup power when the reference count becomes zero.
>
> ---
>  drivers/acpi/power.c |    8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)
>
> Index: linux-pm/drivers/acpi/power.c
> ===================================================================
> --- linux-pm.orig/drivers/acpi/power.c
> +++ linux-pm/drivers/acpi/power.c
> @@ -757,13 +757,11 @@ int acpi_disable_wakeup_device_power(str
>
>         mutex_lock(&acpi_device_lock);
>
> -       if (dev->wakeup.prepare_count > 1) {
> -               dev->wakeup.prepare_count--;
> +       /* Do nothing if wakeup power has not been enabled for this device. */
> +       if (dev->wakeup.prepare_count <= 0)
>                 goto out;
> -       }
>
> -       /* Do nothing if wakeup power has not been enabled for this device. */
> -       if (!dev->wakeup.prepare_count)
> +       if (--dev->wakeup.prepare_count > 0)
>                 goto out;
>
>         err = acpi_device_sleep_wake(dev, 0, 0, 0);
>
>
>
>
