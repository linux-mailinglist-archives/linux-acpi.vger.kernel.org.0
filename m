Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8A2F3A9EAE
	for <lists+linux-acpi@lfdr.de>; Wed, 16 Jun 2021 17:12:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234491AbhFPPOr (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 16 Jun 2021 11:14:47 -0400
Received: from mail-ot1-f42.google.com ([209.85.210.42]:36656 "EHLO
        mail-ot1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234547AbhFPPOn (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 16 Jun 2021 11:14:43 -0400
Received: by mail-ot1-f42.google.com with SMTP id h24-20020a9d64180000b029036edcf8f9a6so2829084otl.3;
        Wed, 16 Jun 2021 08:12:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lC2NeqII1gOHZUp/j/9qgc6w3CU2D970PqUKrQ/mFLU=;
        b=lJQzPdoyJEj8bztOgqHx5oMpIe4pnQs8/YM6N7dWTLsFgfnR6sr5XKwLzNzIxQBKm5
         eo+5yUZVx5k2OFnUiRuBjD/392IUVNcs7ZR/oplr+mijYLg3EHPA11JaBeZQsXV9dBJR
         gS+OYOKFEzS3G1Xi7tPQGgXH9jWSCRdp3vnQvXDaPY55ATBlCHlKIYBRMn5sIgJL5fto
         rRrWjwRIEutJag6MothDj9sZaZZN2iMqhKyK/USUrk7lXRCMKvWfV0nJqlxw9o5Np7oJ
         WIbyTnm2vDFy8sS62cTywkdXIhpnUsJ1VUeRD+VJPlxh7w4SWg/Nkg3y8y2MuIyxf2sG
         wmXA==
X-Gm-Message-State: AOAM532yHs3A3l+nITs8+kmDUWjTnkX+gGgAL/YsLeSFBFBN8S42WZ2E
        XSvIHfVk8hEX2Gx6VzgG3hTGKmR/Cfa8g75saKM=
X-Google-Smtp-Source: ABdhPJwTcWoUKlmdSeCFjAAb7mGsMmkwf1IFcCiW7T+oKlXk5BNafaGfJbJHX6C0H2swC46Xsap40vgmYbL0rLiTk1k=
X-Received: by 2002:a9d:3e53:: with SMTP id h19mr345488otg.260.1623856356561;
 Wed, 16 Jun 2021 08:12:36 -0700 (PDT)
MIME-Version: 1.0
References: <3140195.44csPzL39Z@kreacher> <7272740.EvYhyI6sBW@kreacher> <0cd3a0b5-f656-2b4f-b5bc-67680bc80603@redhat.com>
In-Reply-To: <0cd3a0b5-f656-2b4f-b5bc-67680bc80603@redhat.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 16 Jun 2021 17:12:25 +0200
Message-ID: <CAJZ5v0hVLGqCV85m3cYxsuWS_4jBww54VJ9YTogPy_Tha8VUDA@mail.gmail.com>
Subject: Re: [PATCH 3/5] ACPI: scan: Fix device object rescan in acpi_scan_clear_dep()
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, Jun 16, 2021 at 4:48 PM Hans de Goede <hdegoede@redhat.com> wrote:
>
> Hi,
>
> On 6/16/21 4:23 PM, Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > In general, acpi_bus_attach() can only be run safely under
> > acpi_scan_lock, but that lock cannot be acquired under
> > acpi_dep_list_lock, so make acpi_scan_clear_dep() schedule deferred
> > execution of acpi_bus_attach() under acpi_scan_lock instead of
> > calling it directly.
> >
> > This also fixes a possible race between acpi_scan_clear_dep() and
> > device removal that might cause a device object that went away to
> > be accessed, because acpi_scan_clear_dep() is changed to acquire
> > a reference on the consumer device object.
> >
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > ---
> >  drivers/acpi/scan.c |   50 +++++++++++++++++++++++++++++++++++++++++++++-----
> >  1 file changed, 45 insertions(+), 5 deletions(-)
> >
> > Index: linux-pm/drivers/acpi/scan.c
> > ===================================================================
> > --- linux-pm.orig/drivers/acpi/scan.c
> > +++ linux-pm/drivers/acpi/scan.c
> > @@ -2115,16 +2115,56 @@ static int acpi_dev_get_first_consumer_d
> >       return 0;
> >  }
> >
> > -static int acpi_scan_clear_dep(struct acpi_dep_data *dep, void *data)
> > -{
> > +struct acpi_scan_clear_dep_work {
> > +     struct work_struct work;
> >       struct acpi_device *adev;
> > +};
> > +
> > +static void acpi_scan_clear_dep_fn(struct work_struct *work)
> > +{
> > +     struct acpi_scan_clear_dep_work *cdw;
> > +
> > +     cdw = container_of(work, struct acpi_scan_clear_dep_work, work);
> >
> > -     acpi_bus_get_device(dep->consumer, &adev);
> > +     acpi_scan_lock_acquire();
> > +     acpi_bus_attach(cdw->adev, true);
> > +     acpi_scan_lock_release();
> > +
> > +     acpi_dev_put(cdw->adev);
> > +     kfree(cdw);
> > +}
> > +
> > +static bool acpi_scan_clear_dep_queue(struct acpi_device *adev)
> > +{
> > +     struct acpi_scan_clear_dep_work *cdw;
> > +
> > +     if (adev->dep_unmet)
> > +             return false;
> > +
> > +     cdw = kmalloc(sizeof(*cdw), GFP_KERNEL);
> > +     if (!cdw)
> > +             return false;
> > +
> > +     cdw->adev = adev;
> > +     INIT_WORK(&cdw->work, acpi_scan_clear_dep_fn);
> > +     /*
> > +      * Since the work function may block on the lock until the entire
> > +      * initial enumeration of devices is complete, put it into the unbound
> > +      * workqueue.
> > +      */
> > +     queue_work(system_unbound_wq, &cdw->work);
>
> Hmm, I'm a bit worried about this. Even with the system_unbound_wq
> some code may expect at least some progress being made with processing
> works during the initial enumeration. OTOH this does run pretty early on.
>
> Still I wonder if it would not be better to create + use our own workqueue
> for this ?
>
> I guess we can always do this if we run into issues later...

Exactly my thought.

> With that said / otherwise the patch looks good to me:
>
> Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Thanks!
