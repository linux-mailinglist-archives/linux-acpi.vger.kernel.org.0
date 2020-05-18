Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 106091D735D
	for <lists+linux-acpi@lfdr.de>; Mon, 18 May 2020 10:59:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726526AbgERI7e (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 18 May 2020 04:59:34 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:42602 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726180AbgERI7d (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 18 May 2020 04:59:33 -0400
Received: by mail-ot1-f65.google.com with SMTP id z3so5745900otp.9;
        Mon, 18 May 2020 01:59:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HcC5d0dkGCVtIC0H6I2J3H5klgnWGhpsgSC2d3NhmtY=;
        b=dSe7x6Xn0/BmroqGeGszSIzWEqOWDMRGKr5R6+cSXqDzT9w5YGci0RMxs8wZhgU/Ww
         U+lWGTkdPWeHqcvV9ZwSsgSuG2gT1kuvxKyqcWGuMMmkuYmxX5etXrS0p8IduyJYp8db
         fTEaD7dZq5C2VCjLoyY4cv1WPSYOfyzn1hZtaG9YwZ18oXDXFvb8OWd+BAcJJCOm4PdK
         kwd/NPCvsraafwYZTyT+NTIG+Uwc/tGy0CcO8s5Q6rSbAiPvMUzJ3aNW9QN6JOpQL/3N
         G989r1evWT1lwwxyv0wbLCCXhVgGl2Yz05qmxD4yJAxg8IxQnRb+mxmgQ+cl5J5hJDcJ
         DNJw==
X-Gm-Message-State: AOAM531p+VO33VxRkjTBDKtNH1mwgiLV48J3GELhUOA6iW3moefGdXWO
        rPRh5oezuxvqMw+7+6gvIJ0tmPRsO4EptcNB7Gg=
X-Google-Smtp-Source: ABdhPJzHU/Z1F5YsgIDVwxzd5lXbIG4cpPdzQkCfjzP+lYB0PuTC/2UalzJ4qHxT8jZN0CA1Ix7+aLSUeVJU7LdzUGI=
X-Received: by 2002:a9d:3d05:: with SMTP id a5mr426572otc.262.1589792372469;
 Mon, 18 May 2020 01:59:32 -0700 (PDT)
MIME-Version: 1.0
References: <4502272.pByIgeXik9@kreacher>
In-Reply-To: <4502272.pByIgeXik9@kreacher>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 18 May 2020 10:59:17 +0200
Message-ID: <CAJZ5v0j6S+we7tHeV9TM30LS+TO3zWigACe0ZUFfWphg2FBBZQ@mail.gmail.com>
Subject: Re: [PATCH[RFT]] ACPI: EC: s2idle: Avoid flushing EC work when EC GPE
 is inactive
To:     Chris Chiu <chiu@endlessm.com>
Cc:     Linux ACPI <linux-acpi@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, May 14, 2020 at 12:10 PM Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> Flushing the EC work while suspended to idle when the EC GPE status
> is not set causes some EC wakeup events (notably power button and
> lid ones) to be missed after a series of spurious wakeups on the Dell
> XPS13 9360 in my office.
>
> If that happens, the machine cannot be woken up from suspend-to-idle
> by a power button press or lid status change and it needs to be woken
> up in some other way (eg. by a key press).
>
> Flushing the EC work only after successful dispatching the EC GPE,
> which means that its status has been set, avoids the issue, so change
> the code in question accordingly.
>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>
> Hi Chris,
>
> Please check if the key press wakeup still works on your system with this patch
> applied (on top of https://patchwork.kernel.org/patch/11538065/).

Hi Chris,

Since I haven't heard back from you and the problem at hand is a
regression on the machine where it happens, I'm going to push this
patch for merging.

If it causes the key press wakeup issue to reappear on your machine,
I'm afraid that we'll need to quirk it in the EC driver.

Thanks!

> ---
>  drivers/acpi/ec.c    |    6 +++++-
>  drivers/acpi/sleep.c |   15 ++++-----------
>  2 files changed, 9 insertions(+), 12 deletions(-)
>
> Index: linux-pm/drivers/acpi/ec.c
> ===================================================================
> --- linux-pm.orig/drivers/acpi/ec.c
> +++ linux-pm/drivers/acpi/ec.c
> @@ -2020,9 +2020,13 @@ bool acpi_ec_dispatch_gpe(void)
>          * to allow the caller to process events properly after that.
>          */
>         ret = acpi_dispatch_gpe(NULL, first_ec->gpe);
> -       if (ret == ACPI_INTERRUPT_HANDLED)
> +       if (ret == ACPI_INTERRUPT_HANDLED) {
>                 pm_pr_dbg("EC GPE dispatched\n");
>
> +               /* Flush the event and query workqueues. */
> +               acpi_ec_flush_work();
> +       }
> +
>         return false;
>  }
>  #endif /* CONFIG_PM_SLEEP */
> Index: linux-pm/drivers/acpi/sleep.c
> ===================================================================
> --- linux-pm.orig/drivers/acpi/sleep.c
> +++ linux-pm/drivers/acpi/sleep.c
> @@ -980,13 +980,6 @@ static int acpi_s2idle_prepare_late(void
>         return 0;
>  }
>
> -static void acpi_s2idle_sync(void)
> -{
> -       /* The EC driver uses special workqueues that need to be flushed. */
> -       acpi_ec_flush_work();
> -       acpi_os_wait_events_complete(); /* synchronize Notify handling */
> -}
> -
>  static bool acpi_s2idle_wake(void)
>  {
>         if (!acpi_sci_irq_valid())
> @@ -1018,7 +1011,7 @@ static bool acpi_s2idle_wake(void)
>                         return true;
>
>                 /*
> -                * Cancel the wakeup and process all pending events in case
> +                * Cancel the SCI wakeup and process all pending events in case
>                  * there are any wakeup ones in there.
>                  *
>                  * Note that if any non-EC GPEs are active at this point, the
> @@ -1026,8 +1019,7 @@ static bool acpi_s2idle_wake(void)
>                  * should be missed by canceling the wakeup here.
>                  */
>                 pm_system_cancel_wakeup();
> -
> -               acpi_s2idle_sync();
> +               acpi_os_wait_events_complete();
>
>                 /*
>                  * The SCI is in the "suspended" state now and it cannot produce
> @@ -1060,7 +1052,8 @@ static void acpi_s2idle_restore(void)
>          * of GPEs.
>          */
>         acpi_os_wait_events_complete(); /* synchronize GPE processing */
> -       acpi_s2idle_sync();
> +       acpi_ec_flush_work(); /* flush the EC driver's workqueues */
> +       acpi_os_wait_events_complete(); /* synchronize Notify handling */
>
>         s2idle_wakeup = false;
>
>
>
>
