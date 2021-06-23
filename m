Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 748463B1F9F
	for <lists+linux-acpi@lfdr.de>; Wed, 23 Jun 2021 19:37:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229688AbhFWRjY (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 23 Jun 2021 13:39:24 -0400
Received: from mail-oo1-f43.google.com ([209.85.161.43]:42508 "EHLO
        mail-oo1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbhFWRjY (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 23 Jun 2021 13:39:24 -0400
Received: by mail-oo1-f43.google.com with SMTP id n20-20020a4abd140000b029024b43f59314so912586oop.9;
        Wed, 23 Jun 2021 10:37:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3melYO0wZCMRg7XHkx/hptxaOoEYV4eau0N+U+gvijA=;
        b=m5SZMR7jEi3cKnKd9OovfhjBO0Ab6lteNtTGGA/OZ/zCps1yvEc2F+odrZ1h1sBAxn
         dEDYFlWxqhcNeVDT4WL742HhWKgQknOew249oNVZiR0YDdCxpqPYe3YDKM1fzrHokHDG
         zq5A8wCsR9PUDfxu9kH92aXUoccjMVlnTs93LAsFQ576caneVXjGlcma+poUblZjR7go
         9Gi1aUhZPdSO58vSsVCNYqG1hYLY4OZMjYxi5ehOSS4UMJ3kIcuntFUW8Y5ejcy32nug
         0mWSXHlGM5eSzqL4Y9YQZQu52bgx+KJLmcnnD1t8v5x8hLvnBS2TLgIzPxbNndnEVJHI
         0wvA==
X-Gm-Message-State: AOAM532nEXafg07g97oN9Oia8V+JIK/VEBUTauPQ1Jjveqenw+wa4+Fh
        /xTFRGnR88a/t3mQFsYbU/yNnpKNp3hGIL64SOA=
X-Google-Smtp-Source: ABdhPJyy84IZQYogTvfFfev6mmMHPVE7Tcr8qSTbweBXX1S44/guPsvT4MVoyUyWoGtLg+sCwk9h/PDS6j3vS4K29FY=
X-Received: by 2002:a4a:5285:: with SMTP id d127mr805018oob.2.1624469825723;
 Wed, 23 Jun 2021 10:37:05 -0700 (PDT)
MIME-Version: 1.0
References: <YNJYm34h3Z9yfm+k@google.com>
In-Reply-To: <YNJYm34h3Z9yfm+k@google.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 23 Jun 2021 19:36:54 +0200
Message-ID: <CAJZ5v0icHp=a2OgM8ptisvC0U1NbzXVXxRHw1ZhMPHWn6dKtUg@mail.gmail.com>
Subject: Re: [PATCH v2] ACPI: PM: postpone bringing devices to D0 unless we
 need them
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, Jun 22, 2021 at 11:39 PM Dmitry Torokhov
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
>
> v2:
>
> - do not call acpi_device_wakeup_disable() in early resume when
>   we postponing transition to D0, do it all in normal resume phase
>   (Rafael's feedback)
>
> - reduce patch noise in acpi_subsys_resume_early() per Rafael's
>   comments

Applied as 5.14 material, thanks!

>  drivers/acpi/device_pm.c | 32 +++++++++++++++++++++++++++++++-
>  1 file changed, 31 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/acpi/device_pm.c b/drivers/acpi/device_pm.c
> index 096153761ebc..8afa66bdb3ce 100644
> --- a/drivers/acpi/device_pm.c
> +++ b/drivers/acpi/device_pm.c
> @@ -1131,19 +1131,48 @@ static int acpi_subsys_resume_noirq(struct device *dev)
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
>         int ret;
>
>         if (dev_pm_skip_resume(dev))
>                 return 0;
>
> +       if (pm && !pm->resume_early) {
> +               dev_dbg(dev, "postponing D0 transition to normal resume stage\n");
> +               return 0;
> +       }
> +
>         ret = acpi_dev_resume(dev);
>         return ret ? ret : pm_generic_resume_early(dev);
>  }
>
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
> +
> +       return ret ? ret : pm_generic_resume(dev);
> +}
> +
>  /**
>   * acpi_subsys_freeze - Run the device driver's freeze callback.
>   * @dev: Device to handle.
> @@ -1236,6 +1265,7 @@ static struct dev_pm_domain acpi_general_pm_domain = {
>                 .prepare = acpi_subsys_prepare,
>                 .complete = acpi_subsys_complete,
>                 .suspend = acpi_subsys_suspend,
> +               .resume = acpi_subsys_resume,
>                 .suspend_late = acpi_subsys_suspend_late,
>                 .suspend_noirq = acpi_subsys_suspend_noirq,
>                 .resume_noirq = acpi_subsys_resume_noirq,
> --
> 2.32.0.288.g62a8d224e6-goog
>
>
> --
> Dmitry
