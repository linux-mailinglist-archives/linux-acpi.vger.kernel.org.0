Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 111A649C48
	for <lists+linux-acpi@lfdr.de>; Tue, 18 Jun 2019 10:44:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729123AbfFRIoz (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 18 Jun 2019 04:44:55 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:45652 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726330AbfFRIoz (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 18 Jun 2019 04:44:55 -0400
Received: by mail-ot1-f65.google.com with SMTP id x21so13195995otq.12
        for <linux-acpi@vger.kernel.org>; Tue, 18 Jun 2019 01:44:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=s+eB30TpXEI+6me9NwAv3QSf3QTAU79iv/+7LAE+dMs=;
        b=sDB8k0DNatKfHz2ex/wRhL6DPk47SdI8wuO6JaoD8B7Hh6cPBG3QarrTcduztC+kCa
         XH2H0XxGuZD6D6+vD3AkzaTWCkCkSxRHDEHrL4Kbj48Wyy76veXxch7FIOt8FGwxMUcn
         V3U/GJKME3Z82VbYcPsJns5lavjPci20CGmDAodn94BS+bd35LfTVBuMtJFAHMw+y5ZE
         +OWsGciIcduoyOv3rC/slOAxf69NDep00i1vuaPe+e5wmUO054sgOwTLYTLgJ0sH+2ZU
         exD1cH1D8DXEoY7vX+msillLeMUqCzAB4/3CX9S0xZGpSOB3GXpRH5DUczBOsZzN2S/2
         Gqfw==
X-Gm-Message-State: APjAAAVxJd6jXZwZZM8NSuCWD94/z5vqiyO1zjO/zzTlHh6VC35KaZyu
        lXoPt28Myv1rLlYOCnvoWh1nJO2JpBBA3L7xo8o=
X-Google-Smtp-Source: APXvYqzptE31oM13sXKOU1GHo3qZuF9QtSOffdlUy2wFo/0rlfS2uy1RSlcoj9Cr/ciSFLOafRPg7d6Q9x0RTsS+jQc=
X-Received: by 2002:a9d:4b0b:: with SMTP id q11mr63606457otf.69.1560847493925;
 Tue, 18 Jun 2019 01:44:53 -0700 (PDT)
MIME-Version: 1.0
References: <20190526202750.4614-1-shaunak.saha@intel.com> <2151762.asltZFE8WJ@kreacher>
In-Reply-To: <2151762.asltZFE8WJ@kreacher>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 18 Jun 2019 10:44:43 +0200
Message-ID: <CAJZ5v0iHRzC=ewqUTa_VUdJ2NOztnP+hDYBeJLtfDydArPkkeA@mail.gmail.com>
Subject: Re: drivers/acpi: Change the lpit function call flow
To:     Mario Limonciello <mario_limonciello@dell.com>
Cc:     Shaunak Saha <shaunak.saha@intel.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, Jun 13, 2019 at 11:37 PM Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>
> On Sunday, May 26, 2019 10:27:50 PM CEST Shaunak Saha wrote:
> > In the present implementation sleep function was getting called in
> > acpi_s2idle_prepare and as all the devices may not have suspended
> > at that stage e.g. if we are telling ec about the S0ix then calling early
> > can cause ec reply wrongly interpreted as spurious wake events.
> > Here we call it at much later stage in acpi_s2idle_sync. As per the
> > specification the entry _DSM function may be invoked when the OS state has
> > reached sufficient criteria for processor idle state entry matching
> > Entry Trigger defined in LPIT to be interpreted as a request for the
> > platform to enter a Low Power S0 Idle (LPI) state. Here we are checking if
> > the we reached the minimum D-State defined in the constraint function of
> > the LPIT _DSM method before calling the sleep entry function. Also not
> > checking for constraint in acpi_s2idle_wake anymore and also changed the
> > acpi info loglevel to debug in lpi_check_constraint.
>
> This patch does three different things, two of which are questionable and
> one is done incorrectly.
>
> First off, aborting system suspend because S0ix constraints are not met is
> a non-starter.  The kernel really cannot refuse to suspend the system for
> that reason (and diagnostics can be done after resume anyway).
>
> Second, according to my knowledge, it is not a bug to invoke the
> ACPI_LPS0_ENTRY _DSM when the constraints are not met.  Do you
> actually know about any platforms where that may cause real problems
> to occur?
>
> Finally, it is too late to invoke that _DSM from acpi_s2idle_sync(), because
> that is called after leaving S0ix and resuming some devices.
>
> I can believe the claim that invoking the ACPI_LPS0_ENTRY _DSM in
> acpi_s2idle_prepare() may be too early and it may confuse the EC, say,
> but I'm not sure why the ACPI_LPS0_SCREEN_OFF _DSM would be
> affected by that too.
>
> So overall, the patch below may actually work,

On my Dell XPS13 9360 it clearly makes things worse by causing the EC
to generate spurious wakeup events all the time, so I'm afraid that
this like of reasoning is misguided overall.

> but not the $subject one
> (if evaluating the ACPI_LPS0_ENTRY _DSM when the constraints are not
> met is *really* problematic, it may be necessary to add the check
> for that on top of it).
>
> ---
>  drivers/acpi/sleep.c    |   13 +++++++++----
>  include/linux/suspend.h |    1 +
>  kernel/power/suspend.c  |    8 ++++++--
>  3 files changed, 16 insertions(+), 6 deletions(-)
>
> Index: linux-pm/drivers/acpi/sleep.c
> ===================================================================
> --- linux-pm.orig/drivers/acpi/sleep.c
> +++ linux-pm/drivers/acpi/sleep.c
> @@ -967,8 +967,6 @@ static int acpi_s2idle_prepare(void)
>  {
>         if (lps0_device_handle) {
>                 acpi_sleep_run_lps0_dsm(ACPI_LPS0_SCREEN_OFF);
> -               acpi_sleep_run_lps0_dsm(ACPI_LPS0_ENTRY);
> -
>                 acpi_ec_set_gpe_wake_mask(ACPI_GPE_ENABLE);
>         }
>
> @@ -983,6 +981,12 @@ static int acpi_s2idle_prepare(void)
>         return 0;
>  }
>
> +static void acpi_s2idle_sleep(void)
> +{
> +       if (lps0_device_handle)
> +               acpi_sleep_run_lps0_dsm(ACPI_LPS0_ENTRY);
> +}
> +
>  static void acpi_s2idle_wake(void)
>  {
>         if (!lps0_device_handle)
> @@ -1007,6 +1011,8 @@ static void acpi_s2idle_wake(void)
>                  */
>                 acpi_ec_dispatch_gpe();
>         }
> +
> +       acpi_sleep_run_lps0_dsm(ACPI_LPS0_EXIT);
>  }
>
>  static void acpi_s2idle_sync(void)
> @@ -1034,8 +1040,6 @@ static void acpi_s2idle_restore(void)
>
>         if (lps0_device_handle) {
>                 acpi_ec_set_gpe_wake_mask(ACPI_GPE_DISABLE);
> -
> -               acpi_sleep_run_lps0_dsm(ACPI_LPS0_EXIT);
>                 acpi_sleep_run_lps0_dsm(ACPI_LPS0_SCREEN_ON);
>         }
>  }
> @@ -1049,6 +1053,7 @@ static void acpi_s2idle_end(void)
>  static const struct platform_s2idle_ops acpi_s2idle_ops = {
>         .begin = acpi_s2idle_begin,
>         .prepare = acpi_s2idle_prepare,
> +       .sleep = acpi_s2idle_sleep,
>         .wake = acpi_s2idle_wake,
>         .sync = acpi_s2idle_sync,
>         .restore = acpi_s2idle_restore,
> Index: linux-pm/include/linux/suspend.h
> ===================================================================
> --- linux-pm.orig/include/linux/suspend.h
> +++ linux-pm/include/linux/suspend.h
> @@ -190,6 +190,7 @@ struct platform_suspend_ops {
>  struct platform_s2idle_ops {
>         int (*begin)(void);
>         int (*prepare)(void);
> +       void (*sleep)(void);
>         void (*wake)(void);
>         void (*sync)(void);
>         void (*restore)(void);
> Index: linux-pm/kernel/power/suspend.c
> ===================================================================
> --- linux-pm.orig/kernel/power/suspend.c
> +++ linux-pm/kernel/power/suspend.c
> @@ -136,10 +136,14 @@ static void s2idle_loop(void)
>                  * so prevent them from terminating the loop right away.
>                  */
>                 error = dpm_noirq_suspend_devices(PMSG_SUSPEND);
> -               if (!error)
> +               if (!error) {
> +                       if (s2idle_ops && s2idle_ops->sleep)
> +                               s2idle_ops->sleep();
> +
>                         s2idle_enter();
> -               else if (error == -EBUSY && pm_wakeup_pending())
> +               } else if (error == -EBUSY && pm_wakeup_pending()) {
>                         error = 0;
> +               }
>
>                 if (!error && s2idle_ops && s2idle_ops->wake)
>                         s2idle_ops->wake();
>
>
>
