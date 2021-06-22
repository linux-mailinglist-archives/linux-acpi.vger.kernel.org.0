Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 826553B05FC
	for <lists+linux-acpi@lfdr.de>; Tue, 22 Jun 2021 15:40:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229913AbhFVNmd (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 22 Jun 2021 09:42:33 -0400
Received: from mail-oo1-f42.google.com ([209.85.161.42]:40594 "EHLO
        mail-oo1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231334AbhFVNmc (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 22 Jun 2021 09:42:32 -0400
Received: by mail-oo1-f42.google.com with SMTP id k1-20020a0568200161b029024bef8a628bso57095ood.7;
        Tue, 22 Jun 2021 06:40:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=q4vbd9vVe1kJjDnrVB6nT7MJLsjNMvtXc5i6FfjWChM=;
        b=ZajxaPqvgOSa6Wq05Fy6mKfAIt5wxYsIw8elGmRoeNWvbQjln/29iPMSteQD2mrnQL
         sFJR0OCDuWrMiq2fr/Lh5tEihNYM6bbM5qTXpxWPQE72/QA2yEtiBhEDnrFPUyu3mpFv
         VouEZJizg6eLyvdMN34a50TMzrrI6xT1AqmCb+HT+I/T2QuT/8tlgaYvJG8elb/ZP6WR
         FwyqzqWJTwITD+s9oUDMUgJD0f2ltC2zOGitq28VRDp8IfT6/FHxetsMs9MaOstpxd6B
         1MstLRyCtdkPlALJ3FurihFYyew5SkPK//5FEEgth8TzHAjAcejpYXqhcUQfuR2/X6wE
         OpPA==
X-Gm-Message-State: AOAM5310SwC4efvxN2G6lufYTJCaSOP9ACwPWfNAt+pRvRCuPAyNyDkV
        UEayny/ZnLOV3PQ0YqXQtTH6Uis6fqDcCb6r6A4=
X-Google-Smtp-Source: ABdhPJyn01MjcWRQU6eyKA3kZgTfXdHZ8rlLBAMe5PBnS2ARnqsj0gqiz9/Db/7oBN6VslYJhYjVmR5I1CMDaPL7pwM=
X-Received: by 2002:a4a:5dc6:: with SMTP id w189mr3387528ooa.1.1624369216749;
 Tue, 22 Jun 2021 06:40:16 -0700 (PDT)
MIME-Version: 1.0
References: <YNEQjAzq6iWNgnBc@google.com>
In-Reply-To: <YNEQjAzq6iWNgnBc@google.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 22 Jun 2021 15:40:05 +0200
Message-ID: <CAJZ5v0jVzFWfNX-ujOz=A8SXyWGv_HC+YSVEzowSN+aU5aGiYw@mail.gmail.com>
Subject: Re: [PATCH] ACPI: PM: postpone bringing devices to D0 unless we need them
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, Jun 22, 2021 at 12:20 AM Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
>
> Currently ACPI power domain brings devices into D0 state in the "resume
> early" phase. Normally this does not cause any issues, as powering up
> happens quickly. However there are peripherals that have certain timing
> requirements for powering on, for example some models of Elan
> touchscreens need 300msec after powering up/releasing reset line before
> they can accept commands from the host. Such devices will dominate
> the time spent in early resume phase and cause increase in overall
> resume time as we wait for early resume to complete before we can
> proceed to the normal resume stage.
>
> There are ways for a driver to indicate that it can tolerate device
> being in the low power mode and that it knows how to power the device
> back up when resuming, bit that requires changes to individual drivers
> that may not really care about details of ACPI controlled power
> management.
>
> This change attempts to solve this issue at ACPI power domain level, by
> postponing powering up device until we get to the normal resume stage,
> unless there is early resume handler defined for the device, or device
> does not declare any resume handlers, in which case we continue powering
> up such devices early. This allows us to shave off several hundred
> milliseconds of resume time on affected systems.
>
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> ---
>  drivers/acpi/device_pm.c | 46 +++++++++++++++++++++++++++++++++++-----
>  1 file changed, 41 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/acpi/device_pm.c b/drivers/acpi/device_pm.c
> index 096153761ebc..00b412ccb2e0 100644
> --- a/drivers/acpi/device_pm.c
> +++ b/drivers/acpi/device_pm.c
> @@ -1131,17 +1131,52 @@ static int acpi_subsys_resume_noirq(struct device *dev)
>   *
>   * Use ACPI to put the given device into the full-power state and carry out the
>   * generic early resume procedure for it during system transition into the
> - * working state.
> + * working state, but only do that if device either defines early resume
> + * handler, or does not define power operations at all. Otherwise powering up
> + * of the device is postponed to the normal resume phase.
>   */
>  static int acpi_subsys_resume_early(struct device *dev)
>  {
> +       const struct dev_pm_ops *pm = dev->driver ? dev->driver->pm : NULL;
> +       struct acpi_device *adev = ACPI_COMPANION(dev);
>         int ret;
>
> -       if (dev_pm_skip_resume(dev))
> -               return 0;

The above doesn't need to be changed AFAICS.

> +       if (dev_pm_skip_resume(dev)) {
> +               ret = 0;
> +       } else if (!pm || pm->resume_early) {

This is rather tricky, but I don't see a particular reason why it wouldn't work.

> +               ret = acpi_dev_resume(dev);
> +               if (!ret)
> +                       ret = pm_generic_resume_early(dev);
> +       } else {
> +               if (adev)
> +                       acpi_device_wakeup_disable(adev);

This isn't necessary here.

> +
> +               dev_dbg(dev, "postponing D0 transition to normal resume stage\n");
> +               ret = 0;
> +       }
> +
> +       return ret;
> +}
> +
> +/**
> + * acpi_subsys_resume - Resume device using ACPI.
> + * @dev: Device to Resume.
> + *
> + * Use ACPI to put the given device into the full-power state if it has not been
> + * powered up during early resume phase, and carry out the generic resume
> + * procedure for it during system transition into the working state.
> + */
> +static int acpi_subsys_resume(struct device *dev)
> +{
> +       const struct dev_pm_ops *pm = dev->driver ? dev->driver->pm : NULL;
> +       int ret = 0;
> +
> +       if (!dev_pm_skip_resume(dev) && pm && !pm->resume_early) {
> +               dev_dbg(dev, "executing postponed D0 transition\n");
> +               ret = acpi_dev_resume(dev);
> +       }
>
> -       ret = acpi_dev_resume(dev);
> -       return ret ? ret : pm_generic_resume_early(dev);
> +       return ret ? ret : pm_generic_resume(dev);
>  }
>
>  /**
> @@ -1236,6 +1271,7 @@ static struct dev_pm_domain acpi_general_pm_domain = {
>                 .prepare = acpi_subsys_prepare,
>                 .complete = acpi_subsys_complete,
>                 .suspend = acpi_subsys_suspend,
> +               .resume = acpi_subsys_resume,
>                 .suspend_late = acpi_subsys_suspend_late,
>                 .suspend_noirq = acpi_subsys_suspend_noirq,
>                 .resume_noirq = acpi_subsys_resume_noirq,
> --
