Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8BCC89763A
	for <lists+linux-acpi@lfdr.de>; Wed, 21 Aug 2019 11:32:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726827AbfHUJbF (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 21 Aug 2019 05:31:05 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:39008 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725283AbfHUJbF (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 21 Aug 2019 05:31:05 -0400
Received: by mail-oi1-f193.google.com with SMTP id 16so1089160oiq.6;
        Wed, 21 Aug 2019 02:31:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/WIAml8JDcSIGDQFwUc/Q+oT5zHDcgjSrvToRRg1g9U=;
        b=C0p/OjiwXgVzPbYtTWI5qWcaixCr8XQuyQxTylViWFYofv9YtVFGVT7j0hMTbRiRQO
         bcG/czIGRgDfhbLtyYzl6ZL5N5oX/x0Dcecta6SIXYmYlwz6r7BYORNTeuyqq03/ncVj
         MgBYeCJ7WVHMClM+er8epWOVJJyfQyvx/l/nftLs9jFlQJyZupWSsQgg0Mzv8K9ADhDR
         O3WMrrTLvBR4c2j1r9OIsuNYXcZ8zMB3o3P1ZtpK31xZc7GZLTg2aB54qWcSCfSNfbcM
         lUU2ZaWi/uuOr13fG8K9cEfCSnccgwydb8KnYufwxCJYvfSxpXxgKhq6Y3M/bcipNYKB
         QoCA==
X-Gm-Message-State: APjAAAV2g02j56N9a6MToplRwg9aRLI8heooRF1ijeHqm1Ecdh1AxiHe
        2fUvTJOgMXMh31pKIQ/EQgLPGbPUg2lydqyTFPk=
X-Google-Smtp-Source: APXvYqwTmbc1aFTYKWNhZR7Cxpux76gzmQImJQAIEnRyMWfTr9HJVP4pNSCW3fFvlI5UFKZrUApSzX5FdXteyLrCz64=
X-Received: by 2002:aca:ab56:: with SMTP id u83mr3128312oie.57.1566379863524;
 Wed, 21 Aug 2019 02:31:03 -0700 (PDT)
MIME-Version: 1.0
References: <2671465.Ihf76VL9xe@kreacher> <20190821091927.GV30120@smile.fi.intel.com>
In-Reply-To: <20190821091927.GV30120@smile.fi.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 21 Aug 2019 11:30:51 +0200
Message-ID: <CAJZ5v0iRH_2QDvZy+14Z_ws_05jjrrfUdoqKB6sFaJjD3Z1bow@mail.gmail.com>
Subject: Re: [PATCH] ACPI: PM: s2idle: Always set up EC GPE for system wakeup
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Kristian Klausen <kristian@klausen.dk>,
        Platform Driver <platform-driver-x86@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, Aug 21, 2019 at 11:19 AM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Wed, Aug 21, 2019 at 10:06:09AM +0200, Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > Commit 10a08fd65ec1 ("ACPI: PM: Set up EC GPE for system wakeup from
> > drivers that need it") assumed that the EC GPE would only need to be
> > set up for system wakeup if either the intel-hid or the intel-vbtn
> > driver was in use, but that turns out to be incorrect.  In particular,
> > on ASUS Zenbook UX430UNR/i7-8550U, if the EC GPE is not enabled while
> > suspended, the system cannot be woken up by opening the lid or
> > pressing a key, and that machine doesn't use any of the drivers
> > mentioned above.
> >
> > For this reason, always set up the EC GPE for system wakeup from
> > suspend-to-idle by setting and clearing its wake mask in the ACPI
> > suspend-to-idle callbacks.
>
> Acked-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>
> Couple of minor comments below.
>
> > Fixes: 10a08fd65ec1 ("ACPI: PM: Set up EC GPE for system wakeup from drivers that need it")
> > Reported-by: Kristian Klausen <kristian@klausen.dk>
> > Tested-by: Kristian Klausen <kristian@klausen.dk>
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > ---
> >
> > Commit 10a08fd65ec1 is present in linux-next.
> >
> > ---
> >  drivers/acpi/ec.c                 |    1 -
> >  drivers/acpi/sleep.c              |   15 +++++++++++++--
> >  drivers/platform/x86/intel-hid.c  |    5 +----
> >  drivers/platform/x86/intel-vbtn.c |    5 +----
> >  4 files changed, 15 insertions(+), 11 deletions(-)
> >
> > Index: linux-pm/drivers/acpi/sleep.c
> > ===================================================================
> > --- linux-pm.orig/drivers/acpi/sleep.c
> > +++ linux-pm/drivers/acpi/sleep.c
> > @@ -938,6 +938,13 @@ static int lps0_device_attach(struct acp
> >       if (mem_sleep_default > PM_SUSPEND_MEM && !acpi_sleep_default_s3)
> >               mem_sleep_current = PM_SUSPEND_TO_IDLE;
> >
> > +     /*
> > +      * Some LPS0 systems, like ASUS Zenbook UX430UNR/i7-8550U, require the
> > +      * EC GPE to be enabled while suspended for certain wakeup devices to
> > +      * work, so mark it as wakeup-capable.
> > +      */
> > +     acpi_ec_mark_gpe_for_wake();
> > +
> >       return 0;
> >  }
> >
> > @@ -954,8 +961,10 @@ static int acpi_s2idle_begin(void)
> >
> >  static int acpi_s2idle_prepare(void)
> >  {
> > -     if (acpi_sci_irq_valid())
> > +     if (acpi_sci_irq_valid()) {
> >               enable_irq_wake(acpi_sci_irq);
> > +             acpi_ec_set_gpe_wake_mask(ACPI_GPE_ENABLE);
> > +     }
> >
> >       acpi_enable_wakeup_devices(ACPI_STATE_S0);
> >
> > @@ -1034,8 +1043,10 @@ static void acpi_s2idle_restore(void)
> >
> >       acpi_disable_wakeup_devices(ACPI_STATE_S0);
> >
> > -     if (acpi_sci_irq_valid())
> > +     if (acpi_sci_irq_valid()) {
> > +             acpi_ec_set_gpe_wake_mask(ACPI_GPE_DISABLE);
> >               disable_irq_wake(acpi_sci_irq);
> > +     }
> >  }
> >
> >  static void acpi_s2idle_end(void)
> > Index: linux-pm/drivers/platform/x86/intel-hid.c
> > ===================================================================
> > --- linux-pm.orig/drivers/platform/x86/intel-hid.c
> > +++ linux-pm/drivers/platform/x86/intel-hid.c
> > @@ -257,7 +257,6 @@ static int intel_hid_pm_prepare(struct d
> >               struct intel_hid_priv *priv = dev_get_drvdata(device);
> >
> >               priv->wakeup_mode = true;
> > -             acpi_ec_set_gpe_wake_mask(ACPI_GPE_ENABLE);
> >       }
> >       return 0;
> >  }
> > @@ -266,10 +265,8 @@ static void intel_hid_pm_complete(struct
> >  {
> >       struct intel_hid_priv *priv = dev_get_drvdata(device);
> >
> > -     if (priv->wakeup_mode) {
> > -             acpi_ec_set_gpe_wake_mask(ACPI_GPE_DISABLE);
>
> > +     if (priv->wakeup_mode)
>
> But this now seems does not add any value and we can assign unconditionally.

Indeed.

I'll send a v2 shortly.

Thanks!


>
> >               priv->wakeup_mode = false;
> > -     }
> >  }
> >
> >  static int intel_hid_pl_suspend_handler(struct device *device)
> > Index: linux-pm/drivers/platform/x86/intel-vbtn.c
> > ===================================================================
> > --- linux-pm.orig/drivers/platform/x86/intel-vbtn.c
> > +++ linux-pm/drivers/platform/x86/intel-vbtn.c
> > @@ -205,7 +205,6 @@ static int intel_vbtn_pm_prepare(struct
> >               struct intel_vbtn_priv *priv = dev_get_drvdata(dev);
> >
> >               priv->wakeup_mode = true;
> > -             acpi_ec_set_gpe_wake_mask(ACPI_GPE_ENABLE);
> >       }
> >       return 0;
> >  }
> > @@ -214,10 +213,8 @@ static void intel_vbtn_pm_complete(struc
> >  {
> >       struct intel_vbtn_priv *priv = dev_get_drvdata(dev);
> >
> > -     if (priv->wakeup_mode) {
> > -             acpi_ec_set_gpe_wake_mask(ACPI_GPE_DISABLE);
>
> > +     if (priv->wakeup_mode)
>
> Ditto.
>
> >               priv->wakeup_mode = false;
> > -     }
> >  }
> >
> >  static int intel_vbtn_pm_resume(struct device *dev)
> > Index: linux-pm/drivers/acpi/ec.c
> > ===================================================================
> > --- linux-pm.orig/drivers/acpi/ec.c
> > +++ linux-pm/drivers/acpi/ec.c
> > @@ -1970,7 +1970,6 @@ void acpi_ec_set_gpe_wake_mask(u8 action
> >       if (pm_suspend_no_platform() && first_ec && !ec_no_wakeup)
> >               acpi_set_gpe_wake_mask(NULL, first_ec->gpe, action);
> >  }
> > -EXPORT_SYMBOL_GPL(acpi_ec_set_gpe_wake_mask);
> >
> >  bool acpi_ec_dispatch_gpe(void)
> >  {
>
> --
> With Best Regards,
> Andy Shevchenko
>
>
