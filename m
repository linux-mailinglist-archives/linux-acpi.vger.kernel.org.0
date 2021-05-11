Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C2EB37A5E7
	for <lists+linux-acpi@lfdr.de>; Tue, 11 May 2021 13:42:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231126AbhEKLnj (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 11 May 2021 07:43:39 -0400
Received: from mail-ot1-f49.google.com ([209.85.210.49]:43930 "EHLO
        mail-ot1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230501AbhEKLnj (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 11 May 2021 07:43:39 -0400
Received: by mail-ot1-f49.google.com with SMTP id u19-20020a0568302493b02902d61b0d29adso16436237ots.10;
        Tue, 11 May 2021 04:42:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5unhwIaxg64Ebdi8tWGMUtJFaf6iQZK6L3spfzCmCIY=;
        b=CxCGkNF3mp5ag1/tBdafzjMnGdFhPsWrtQ0+sElGs4rR92E8/oCazmFabUoq0Pmb3a
         Atm6QOIQQafm0BywQNIpazOqW/9h3EJ9P2HEC18uc5kGnigVFmMYtntvh69zER1EmJlF
         HsGi3PD/firVFAWdRHm5SCv7kk/X7xOL/nCOpcQRhb/+rQ7tsZFG4FEkok5fPymELJ9Y
         9aQS4lZPg9cTzs1UmJnX6of1tZfbseOaPo6xUEEfBvL8c4PU8errKbg8Rarqp6nstvgv
         DnbevLK3yoU9FoGWw+j4wa+sJJJzgewSLExhE+lrMtUNurHJgiVTlwe1luLw5+sTcGQ0
         KuUA==
X-Gm-Message-State: AOAM532IguipTF+SKcPIZ26hYowl6jJE6R8QcinD48KHmKidhYIkCr+r
        E1NX/ubTTjNxqiZfyOBEz0Rs6rOO1u+EtorXFtg=
X-Google-Smtp-Source: ABdhPJzFVTchCjDmnP+Sq3sU02RlxhGnOoZLDnUwPIJ6VCqdIvsysRKeYHyefWe7vAWqZ/TAF0X1ndNGYH43KfMpgnc=
X-Received: by 2002:a05:6830:55b:: with SMTP id l27mr25430146otb.260.1620733351311;
 Tue, 11 May 2021 04:42:31 -0700 (PDT)
MIME-Version: 1.0
References: <2607573.mvXUDI8C0e@kreacher> <44ec7350-38ee-b880-bcaf-fba5ddc288e9@redhat.com>
In-Reply-To: <44ec7350-38ee-b880-bcaf-fba5ddc288e9@redhat.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 11 May 2021 13:42:20 +0200
Message-ID: <CAJZ5v0jSDq8nZEeFUZc3arHHqWhUjDfmwPrJ69U=aO5-FB_7iA@mail.gmail.com>
Subject: Re: [PATCH] ACPI: scan: Rearrange dep_unmet initialization
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, May 11, 2021 at 1:24 PM Hans de Goede <hdegoede@redhat.com> wrote:
>
> Hi Rafael,
>
> On 5/10/21 7:53 PM, Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > The dep_unmet field in struct acpi_device is used to store the
> > number of unresolved _DEP dependencies (that is, operation region
> > dependencies for which there are no drivers present) for the ACPI
> > device object represented by it.
> >
> > That field is initialized to 1 for all ACPI device objects in
> > acpi_add_single_object(), via acpi_init_device_object(), so as to
> > avoid evaluating _STA prematurely for battery device objects in
> > acpi_scan_init_status(), and it is "fixed up" in acpi_bus_check_add()
> > after the acpi_add_single_object() called by it has returned.
> >
> > This is not particularly straightforward and causes dep_unmet to
> > remain 1 for device objects without dependencies created by invoking
> > acpi_add_single_object() directly, outside acpi_bus_check_add().
> >
> > For this reason, rearrange acpi_add_single_object() to initialize
> > dep_unmet completely before calling acpi_scan_init_status(), which
> > requires passing one extra bool argument to it, and update all of
> > its callers accordingly.
> >
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> Thanks, one small nitpick below.
>
> > ---
> >  drivers/acpi/scan.c |   62 +++++++++++++++++++++++++---------------------------
> >  1 file changed, 30 insertions(+), 32 deletions(-)
> >
> > Index: linux-pm/drivers/acpi/scan.c
> > ===================================================================
> > --- linux-pm.orig/drivers/acpi/scan.c
> > +++ linux-pm/drivers/acpi/scan.c
> > @@ -1670,8 +1670,22 @@ void acpi_init_device_object(struct acpi
> >       device_initialize(&device->dev);
> >       dev_set_uevent_suppress(&device->dev, true);
> >       acpi_init_coherency(device);
> > -     /* Assume there are unmet deps to start with. */
> > -     device->dep_unmet = 1;
> > +}
> > +
> > +static void acpi_scan_dep_init(struct acpi_device *adev)
> > +{
> > +     struct acpi_dep_data *dep;
> > +
> > +     adev->dep_unmet = 0;
>
> Now that we don't set dep_unmet to 1 in acpi_init_device_object()
> anymore this line is no longer necessary.

Right.

I'll drop it before applying the patch.

> dep_unmet is set to 0 by the kzalloc of the adev and we are already
> relying on that in the case where the dep_init parameter to
> acpi_add_single_object() is false.
>
> But if you want to keep this that is fine too, either way
> this patch looks good to me:
>
> Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Thank you!
