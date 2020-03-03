Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CB25517701C
	for <lists+linux-acpi@lfdr.de>; Tue,  3 Mar 2020 08:29:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725840AbgCCH3k (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 3 Mar 2020 02:29:40 -0500
Received: from mail-vs1-f66.google.com ([209.85.217.66]:45744 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727340AbgCCH3k (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 3 Mar 2020 02:29:40 -0500
Received: by mail-vs1-f66.google.com with SMTP id m4so1695708vsa.12
        for <linux-acpi@vger.kernel.org>; Mon, 02 Mar 2020 23:29:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessm-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=FfJGP3VvelPHBu9uAoszVPyAW2vGFIv4G/uor0aD668=;
        b=wS4MKI86i7vYgDExykq5E/9nAFZP1oxRif7r7AX+nw2mR4pGHUdQ54RIYxqtwLwneY
         A5K//2Hg6Cq3gYj2GT5HQ0W+jiSbn7zSEO1wIHugA2IFFR6/VB0MtqnEPNnFUv1Ba4Qi
         QzriKcACmsM+4l1zZQ3CGfLph9nz1xKozupNGUKPucW+PneR3xFN4GWQNkmkRa+Nh+A7
         7w/0Lo2DjYpYQMtfVGLqq93RLdFd5x/80J4zmRxMW7jzhwB5ii3n33303mN4E59Be12d
         5RYNVbtl7KHRuKVP0TSN7NPLddqIHzO4qXp3eG6Ebm3QBU9IXP42ewCVg/UbsTrU+k1j
         X78Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=FfJGP3VvelPHBu9uAoszVPyAW2vGFIv4G/uor0aD668=;
        b=UojTMmSxnllUnK620Q9euitTwdnLhCUNFb7pSr5f0yXj3n1ovgmepHjXznhwWQ9nda
         KVMWx7QdA4IKV0PndgNxtiF+gEGh3rUkG0PWXT0oMDEeV7whdhUk5DzcolHGOyTkHSvt
         OircxH2IjTYLYsZB6CjT7QUcp3W4wDidtIFVJIDa2wz2GiWdcNJmIN23w8iP1Fa3bJdK
         EXqZP8aaQgE5IWZGbX/WwNMAQKsSwuvWALpLvanWVQB5z7ekFt2d1/xkPWPGuPP0IzLk
         3ShfnJTbEeOEkpP4VsHjqu7Z7qWXxd/d4G1+oTjjjPW/Z8goV0LqifkTZX8a6wJQZCrX
         FBLg==
X-Gm-Message-State: ANhLgQ19PL3BfbZVHYyhMk5SpxEstWG2f0Lny3AVV6hhRO67gXHnGtCY
        HbmDbL/ZOHFNUmjws7LgV+5spLm5r7JmdfaeM4/dAw==
X-Google-Smtp-Source: ADFU+vulPkBe+NP8hErcIC7CIaSa54wA7KvH3UVGqyZLPXVSP7bmLeyJKxNI+sys5rqmvRX9zk33gOx/WwmhWFhKvEk=
X-Received: by 2002:a05:6102:3205:: with SMTP id r5mr1609818vsf.206.1583220577377;
 Mon, 02 Mar 2020 23:29:37 -0800 (PST)
MIME-Version: 1.0
References: <2094703.CetWLLyMuz@kreacher> <CAD8Lp46VbG3b5NV54vmBFQH2YLY6wRngYv0oY2tiveovPRhiVw@mail.gmail.com>
 <CAPpJ_edfTg11QZs25MrThj2+FKUo2103rv7iYNzo=kr-jeg1MA@mail.gmail.com>
 <CAJZ5v0gB9yuVmPjJ_MvfT8aFpvP-X5JRsNfZn8+Mv5RwTednGg@mail.gmail.com> <CAJZ5v0imqwdmXzKayqs1kgHOb-mXrkr61uNxVka8J9bKca989Q@mail.gmail.com>
In-Reply-To: <CAJZ5v0imqwdmXzKayqs1kgHOb-mXrkr61uNxVka8J9bKca989Q@mail.gmail.com>
From:   Jian-Hong Pan <jian-hong@endlessm.com>
Date:   Tue, 3 Mar 2020 15:28:48 +0800
Message-ID: <CAPpJ_efvF0XzjevA1eL3BUJqBwxRTOPLcqWKN40Azj-n1AtjcA@mail.gmail.com>
Subject: Re: [PATCH 0/6] ACPI: EC: Updates related to initialization
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Daniel Drake <drake@endlessm.com>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Upstreaming Team <linux@endlessm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Rafael J. Wysocki <rafael@kernel.org> =E6=96=BC 2020=E5=B9=B43=E6=9C=882=E6=
=97=A5 =E9=80=B1=E4=B8=80 =E4=B8=8B=E5=8D=887:45=E5=AF=AB=E9=81=93=EF=BC=9A
>
> On Mon, Mar 2, 2020 at 11:38 AM Rafael J. Wysocki <rafael@kernel.org> wro=
te:
> >
> > On Mon, Mar 2, 2020 at 6:54 AM Jian-Hong Pan <jian-hong@endlessm.com> w=
rote:
> > >
> > > Daniel Drake <drake@endlessm.com> =E6=96=BC 2020=E5=B9=B42=E6=9C=8828=
=E6=97=A5 =E9=80=B1=E4=BA=94 =E4=B8=8B=E5=8D=885:43=E5=AF=AB=E9=81=93=EF=BC=
=9A
> > > >
> > > > On Thu, Feb 27, 2020 at 10:25 PM Rafael J. Wysocki <rjw@rjwysocki.n=
et> wrote:
> > > > > The purpose of this series of update of the ACPI EC driver is to =
make its
> > > > > initialization more straightforward.
> > > > >
> > > > > They fix a couple of issues, clean up some things, remove redunda=
nt code etc.
> > > > >
> > > > > Please refer to the changelogs of individual patches for details.
> > > > >
> > > > > For easier access, the series is available in the git branch at
> > > > >
> > > > >  git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.gi=
t \
> > > > >  acpi-ec-work
> > > > >
> > > > > on top of 5.6-rc3.
> > > >
> > > > Jian-Hong, can you please test this on Asus UX434DA?
> > > > Check if the screen brightness hotkeys are still working after thes=
e changes.
> > >
> > > Hi Rafael,
> > >
> > > Thanks for your patches, but we found an issue:
> > > The laptops like ASUS UX434DA's screen brightness hotkeys work before
> > > this patch series.  However, the hotkeys are failed with the patch
> > > "ACPI: EC: Unify handling of event handler installation failures".
> >
> > So I have modified the series to avoid the change that can possibly bre=
ak this.
> >
> > Can you please pull the new series from
> >
> >  git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
> >  acpi-ec-work
> >
> > (same branch) and retest?
>
> Note that the current top-most commit in that branch is
>
> 0957d98f50da ACPI: EC: Consolidate event handler installation code

I tested the commits in acpi-ec-work branch whose last commit is
0957d98f50da ("ACPI: EC: Consolidate event handler installation
code").  The screen brightness hotkeys are still failed with
0957d98f50da ("ACPI: EC: Consolidate event handler installation
code").

I tweak and add some debug messages:

diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
index 85f1fe8e208a..3887f427283c 100644
--- a/drivers/acpi/ec.c
+++ b/drivers/acpi/ec.c
@@ -1443,23 +1443,27 @@ static bool install_gpe_event_handler(struct
acpi_ec *ec)
        return true;
 }

-static bool install_gpio_irq_event_handler(struct acpi_ec *ec,
+static int install_gpio_irq_event_handler(struct acpi_ec *ec,
                                           struct acpi_device *device)
 {
        int irq, ret;

        /* ACPI reduced hardware platforms use a GpioInt specified in _CRS.=
 */
        irq =3D acpi_dev_gpio_irq_get(device, 0);
-       if (irq < 0)
-               return false;
+       if (irq < 0) {
+               pr_err("%s: acpi_dev_gpio_irq_get returns %d\n", __func__, =
irq);
+               return irq;
+       }

        ret =3D request_irq(irq, acpi_ec_irq_handler, IRQF_SHARED, "ACPI EC=
", ec);
-       if (ret < 0)
-               return false;
+       if (ret < 0) {
+               pr_err("%s: request_irq returns %d\n", __func__, ret);
+               return ret;
+       }

        ec->irq =3D irq;

-       return true;
+       return 0;
 }

 /**
@@ -1517,9 +1521,11 @@ static int ec_install_handlers(struct acpi_ec
*ec, struct acpi_device *device)
                         * fatal, because the EC can be polled for events.
                         */
                } else {
-                       ready =3D install_gpio_irq_event_handler(ec, device=
);
-                       if (!ready)
-                               return -ENXIO;
+                       pr_err("%s: install_gpio_irq_event_handler\n",
__func__);
+                       int ret =3D install_gpio_irq_event_handler(ec, devi=
ce);
+                       if (ret)
+                               return ret;
+                       ready =3D true;
                }
                if (ready) {
                        set_bit(EC_FLAGS_EVENT_HANDLER_INSTALLED, &ec->flag=
s);

The dmesg shows:

[    0.121117] ACPI: EC: ec_install_handlers: install_gpio_irq_event_handle=
r
[    0.121133] ACPI: EC: install_gpio_irq_event_handler:
acpi_dev_gpio_irq_get returns -517

Originally, ec_install_handlers() will return the returned value from
install_gpio_irq_event_handler() from acpi_dev_gpio_irq_get(), which
is -EPROBE_DEFER, instead of -ENXIO.  However, ec_install_handlers()
returns -ENXIO directly if install_gpio_irq_event_handler() returns
false in patch ("ACPI: EC: Consolidate event handler installation
code").  Here needs some modification.

Jian-Hong Pan
