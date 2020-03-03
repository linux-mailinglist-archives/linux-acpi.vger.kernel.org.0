Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F2A4717720F
	for <lists+linux-acpi@lfdr.de>; Tue,  3 Mar 2020 10:10:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728037AbgCCJKM convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-acpi@lfdr.de>); Tue, 3 Mar 2020 04:10:12 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:40365 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728031AbgCCJKM (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 3 Mar 2020 04:10:12 -0500
Received: by mail-ot1-f68.google.com with SMTP id x19so2274046otp.7;
        Tue, 03 Mar 2020 01:10:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=5ic/CV5iEBANwAlsxrIRMOAxvyvHS1HnvZnEEB3hD4E=;
        b=V++44Y6yVshBDXpDbtDXCdPw4P8ZLTab7yFUDHG2OMkP3xaOAj6zh8BVY5yZx2f17T
         DP4UbWDCKRRIde8KZjjuYgtvf5o5OMF2KTF+lOFpdAxwy6QyQOqYYEkryOCX8/JvzYDe
         fQUi6UHyq1J7QL2bcmvWGSXeziu5RpCPbYNkPP4Ksn02olfX3BeY8ndvQCXIimASj10N
         GBjnZxWbbDju5R/MeCFJ47OyVnL6ntt47od0W3EhItyEfJ+7DMWDwOuIb7J6/4NMEZWz
         6eM8opB8Uwmie0Uyzd9q2IFs1rcRMV6KC0Twac81qpc71kcBl5wJcNaHqJPEwsB++YZX
         OBfg==
X-Gm-Message-State: ANhLgQ32qgKenX6SfxypI2rCb1cwtrz72b9sgswLonwDE+qcpEfranHu
        +YrpRY9VDlZDrONNJ05vhjBSuFUvYsCTzJ2qtds=
X-Google-Smtp-Source: ADFU+vtvc21TQ88o8cq33ZI/McdFOfkzAwNNnQBYQAMvdqPpoE0wsM1THs9YPiszbWJKs1E7ZSUY482+hucO4cZf3pk=
X-Received: by 2002:a9d:7653:: with SMTP id o19mr2537029otl.118.1583226611337;
 Tue, 03 Mar 2020 01:10:11 -0800 (PST)
MIME-Version: 1.0
References: <2094703.CetWLLyMuz@kreacher> <CAD8Lp46VbG3b5NV54vmBFQH2YLY6wRngYv0oY2tiveovPRhiVw@mail.gmail.com>
 <CAPpJ_edfTg11QZs25MrThj2+FKUo2103rv7iYNzo=kr-jeg1MA@mail.gmail.com>
 <CAJZ5v0gB9yuVmPjJ_MvfT8aFpvP-X5JRsNfZn8+Mv5RwTednGg@mail.gmail.com>
 <CAJZ5v0imqwdmXzKayqs1kgHOb-mXrkr61uNxVka8J9bKca989Q@mail.gmail.com> <CAPpJ_efvF0XzjevA1eL3BUJqBwxRTOPLcqWKN40Azj-n1AtjcA@mail.gmail.com>
In-Reply-To: <CAPpJ_efvF0XzjevA1eL3BUJqBwxRTOPLcqWKN40Azj-n1AtjcA@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 3 Mar 2020 10:09:59 +0100
Message-ID: <CAJZ5v0hie79+jG+3h4t5Q8r0M7E37HY-7i8ijg8DpvS0RXZSiQ@mail.gmail.com>
Subject: Re: [PATCH 0/6] ACPI: EC: Updates related to initialization
To:     Jian-Hong Pan <jian-hong@endlessm.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Daniel Drake <drake@endlessm.com>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Upstreaming Team <linux@endlessm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, Mar 3, 2020 at 8:29 AM Jian-Hong Pan <jian-hong@endlessm.com> wrote:
>
> Rafael J. Wysocki <rafael@kernel.org> 於 2020年3月2日 週一 下午7:45寫道：
> >
> > On Mon, Mar 2, 2020 at 11:38 AM Rafael J. Wysocki <rafael@kernel.org> wrote:
> > >
> > > On Mon, Mar 2, 2020 at 6:54 AM Jian-Hong Pan <jian-hong@endlessm.com> wrote:
> > > >
> > > > Daniel Drake <drake@endlessm.com> 於 2020年2月28日 週五 下午5:43寫道：
> > > > >
> > > > > On Thu, Feb 27, 2020 at 10:25 PM Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> > > > > > The purpose of this series of update of the ACPI EC driver is to make its
> > > > > > initialization more straightforward.
> > > > > >
> > > > > > They fix a couple of issues, clean up some things, remove redundant code etc.
> > > > > >
> > > > > > Please refer to the changelogs of individual patches for details.
> > > > > >
> > > > > > For easier access, the series is available in the git branch at
> > > > > >
> > > > > >  git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
> > > > > >  acpi-ec-work
> > > > > >
> > > > > > on top of 5.6-rc3.
> > > > >
> > > > > Jian-Hong, can you please test this on Asus UX434DA?
> > > > > Check if the screen brightness hotkeys are still working after these changes.
> > > >
> > > > Hi Rafael,
> > > >
> > > > Thanks for your patches, but we found an issue:
> > > > The laptops like ASUS UX434DA's screen brightness hotkeys work before
> > > > this patch series.  However, the hotkeys are failed with the patch
> > > > "ACPI: EC: Unify handling of event handler installation failures".
> > >
> > > So I have modified the series to avoid the change that can possibly break this.
> > >
> > > Can you please pull the new series from
> > >
> > >  git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
> > >  acpi-ec-work
> > >
> > > (same branch) and retest?
> >
> > Note that the current top-most commit in that branch is
> >
> > 0957d98f50da ACPI: EC: Consolidate event handler installation code
>
> I tested the commits in acpi-ec-work branch whose last commit is
> 0957d98f50da ("ACPI: EC: Consolidate event handler installation
> code").  The screen brightness hotkeys are still failed with
> 0957d98f50da ("ACPI: EC: Consolidate event handler installation
> code").
>
> I tweak and add some debug messages:
>
> diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
> index 85f1fe8e208a..3887f427283c 100644
> --- a/drivers/acpi/ec.c
> +++ b/drivers/acpi/ec.c
> @@ -1443,23 +1443,27 @@ static bool install_gpe_event_handler(struct
> acpi_ec *ec)
>         return true;
>  }
>
> -static bool install_gpio_irq_event_handler(struct acpi_ec *ec,
> +static int install_gpio_irq_event_handler(struct acpi_ec *ec,
>                                            struct acpi_device *device)
>  {
>         int irq, ret;
>
>         /* ACPI reduced hardware platforms use a GpioInt specified in _CRS. */
>         irq = acpi_dev_gpio_irq_get(device, 0);
> -       if (irq < 0)
> -               return false;
> +       if (irq < 0) {
> +               pr_err("%s: acpi_dev_gpio_irq_get returns %d\n", __func__, irq);
> +               return irq;
> +       }
>
>         ret = request_irq(irq, acpi_ec_irq_handler, IRQF_SHARED, "ACPI EC", ec);
> -       if (ret < 0)
> -               return false;
> +       if (ret < 0) {
> +               pr_err("%s: request_irq returns %d\n", __func__, ret);
> +               return ret;
> +       }
>
>         ec->irq = irq;
>
> -       return true;
> +       return 0;
>  }
>
>  /**
> @@ -1517,9 +1521,11 @@ static int ec_install_handlers(struct acpi_ec
> *ec, struct acpi_device *device)
>                          * fatal, because the EC can be polled for events.
>                          */
>                 } else {
> -                       ready = install_gpio_irq_event_handler(ec, device);
> -                       if (!ready)
> -                               return -ENXIO;
> +                       pr_err("%s: install_gpio_irq_event_handler\n",
> __func__);
> +                       int ret = install_gpio_irq_event_handler(ec, device);
> +                       if (ret)
> +                               return ret;
> +                       ready = true;
>                 }
>                 if (ready) {
>                         set_bit(EC_FLAGS_EVENT_HANDLER_INSTALLED, &ec->flags);
>
> The dmesg shows:
>
> [    0.121117] ACPI: EC: ec_install_handlers: install_gpio_irq_event_handler
> [    0.121133] ACPI: EC: install_gpio_irq_event_handler:
> acpi_dev_gpio_irq_get returns -517
>
> Originally, ec_install_handlers() will return the returned value from
> install_gpio_irq_event_handler() from acpi_dev_gpio_irq_get(), which
> is -EPROBE_DEFER, instead of -ENXIO.  However, ec_install_handlers()
> returns -ENXIO directly if install_gpio_irq_event_handler() returns
> false in patch ("ACPI: EC: Consolidate event handler installation
> code").  Here needs some modification.

Thanks, I forgot about the -EPROBE_DEFER case.
