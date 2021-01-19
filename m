Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6EA802FB46C
	for <lists+linux-acpi@lfdr.de>; Tue, 19 Jan 2021 09:43:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730056AbhASInK (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 19 Jan 2021 03:43:10 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:51517 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726044AbhASImp (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 19 Jan 2021 03:42:45 -0500
Received: from mail-lj1-f198.google.com ([209.85.208.198])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1l1maP-0003vn-EC
        for linux-acpi@vger.kernel.org; Tue, 19 Jan 2021 08:42:01 +0000
Received: by mail-lj1-f198.google.com with SMTP id k4so4745337ljb.1
        for <linux-acpi@vger.kernel.org>; Tue, 19 Jan 2021 00:42:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uAVGkZ8Ja5y8odt6rz9mT1H76UHS7kPapzXcB65KHNI=;
        b=DCRv0caIdVVrFb/m+4M25zwvfLSAWGmT3pCTsPHMJJSitQwnjniDtmBSqqgSsffVfD
         Ly4Rrj4zeLX93hBl4VFFLb0PqZ0+5rI+7iKffL/xqtIFA3d0l1umbFiu4DRsKry2lUYk
         yoLc27JZNc7kY9A+Vhj4LVnnL2LV1DsbCXYhOCImxwY4iUsyvpR3jQKQNYCPzSJOPgYh
         T5OoMTdVsDXAFuinU3E0Wc8+8n0pzOFhEn1Br+mK8f8FaEZi7/ZskTuVlsHXR8psP1+X
         ZkRYl58N72EIHKLCrADHvDVDFQxluN7qf0XtyqlG0kxSIYUx0e64R/zoIkf5FyxP5K5U
         FkZg==
X-Gm-Message-State: AOAM531fFCO9Y0ZQPp1zL1OfXpxKrWWO2IYCraHoQLHmKzQriCKreMuH
        f8opjRIFWg7a1jwx/9BUEevMKBWjTsigslkUmPYlSNhP7m9rqWkc18bo7aINDTG9tr2Cz2D5kYv
        qeWg90TWlrWBNcAxOMeowtuJLsNLTABJaApcP7mw3KPKjgzZeX1WHPlw=
X-Received: by 2002:ac2:561b:: with SMTP id v27mr1381683lfd.425.1611045720895;
        Tue, 19 Jan 2021 00:42:00 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyqjugoRrvtS9zUJau0D6+EsWghXpfBE/XsbWVRkfcXgQQOvDmb8Eb4uZpU/BhB2rkgTmyhylwJwJfL2FSu2xE=
X-Received: by 2002:ac2:561b:: with SMTP id v27mr1381672lfd.425.1611045720638;
 Tue, 19 Jan 2021 00:42:00 -0800 (PST)
MIME-Version: 1.0
References: <20210119081513.300938-1-kai.heng.feng@canonical.com> <YAaXz9Pg5x3DsCs3@kroah.com>
In-Reply-To: <YAaXz9Pg5x3DsCs3@kroah.com>
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
Date:   Tue, 19 Jan 2021 16:41:48 +0800
Message-ID: <CAAd53p7tdFiARtW1RXsjN8+OwRXWzMnok_rfKHDHCh-JSam3cQ@mail.gmail.com>
Subject: Re: [PATCH] ACPI / device_sysfs: Use OF_MODALIAS for "compatible" modalias
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        AceLan Kao <acelan.kao@canonical.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Len Brown <lenb@kernel.org>,
        "open list:ACPI" <linux-acpi@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, Jan 19, 2021 at 4:27 PM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Tue, Jan 19, 2021 at 04:15:13PM +0800, Kai-Heng Feng wrote:
> > Commit 8765c5ba1949 ("ACPI / scan: Rework modalias creation when
> > "compatible" is present") may create two "MODALIAS=" in uevent file if
> > conditions are met.
> >
> > This breaks systemd-udevd, which assumes each "key" in uevent file is
> > unique. The internal implementation of systemd-udevd overwrites the
> > first MODALIAS with the second one, so its kmod rule doesn't load driver
> > for the first MODALIAS.
> >
> > Right now it doesn't seem to have any user relies on the second
> > MODALIAS, so change it to OF_MODALIAS to workaround the issue.
> >
> > Reference: https://github.com/systemd/systemd/pull/18163
> > Fixes: 8765c5ba1949 ("ACPI / scan: Rework modalias creation when "compatible" is present")
> > Cc: AceLan Kao <acelan.kao@canonical.com>
> > Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
> > Cc: Mika Westerberg <mika.westerberg@linux.intel.com>,
> > Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> > ---
> >  drivers/acpi/device_sysfs.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/acpi/device_sysfs.c b/drivers/acpi/device_sysfs.c
> > index 96869f1538b9..c92b671cb816 100644
> > --- a/drivers/acpi/device_sysfs.c
> > +++ b/drivers/acpi/device_sysfs.c
> > @@ -260,7 +260,7 @@ int __acpi_device_uevent_modalias(struct acpi_device *adev,
> >       if (!adev->data.of_compatible)
> >               return 0;
> >
> > -     if (len > 0 && add_uevent_var(env, "MODALIAS="))
> > +     if (len > 0 && add_uevent_var(env, "OF_MODALIAS="))
>
> Who will use OF_MODALIAS and where have you documented it?

After this lands in mainline, I'll modify the pull request for systemd
to add a new rule for OF_MODALIAS.
I'll modify the comment on the function to document the change.

Kai-Heng

>
> thanks,
>
> greg k-h
