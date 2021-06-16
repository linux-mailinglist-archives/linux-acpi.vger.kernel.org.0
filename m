Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2ED73A9ED2
	for <lists+linux-acpi@lfdr.de>; Wed, 16 Jun 2021 17:19:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234537AbhFPPVf (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 16 Jun 2021 11:21:35 -0400
Received: from mail-ot1-f54.google.com ([209.85.210.54]:44754 "EHLO
        mail-ot1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234002AbhFPPVe (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 16 Jun 2021 11:21:34 -0400
Received: by mail-ot1-f54.google.com with SMTP id q5-20020a9d66450000b02903f18d65089fso2812811otm.11;
        Wed, 16 Jun 2021 08:19:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9PStG9qnxE4mCRKeuZ4Hjo4vuxLzzhgd7NzpNwUxLZY=;
        b=OD9uRvfCBwej2llJRB5GO/pl6zD2bp8+Amnn+5DFSy7R6JyxazpP9mbaxVhLdu7hRV
         E5LE0rYKxfx8ZNPrAuesb5+xZoZyut0KxHb4lxU0UjnLvbFwu3g9BqDUfLC43ub8cyKq
         RK15WnZ+SEoCQeqaU0eoC2iyDtuqMbnNDH9ZWadXRiahQwvmm47YnkAe/Dk19waZ5vQL
         akF+zIlkcAxTQdHm3YXmxjWdzHS4mzfj0wO80/M8f1+r69KtW7D3bIPJKE+SV95h1FMZ
         n+wNmxs6f5CYLHRbzMFUpDk1e5MGVk0f12rlkURwZ118kyrp/hPxo76J7vwz5n5wygO5
         MT3w==
X-Gm-Message-State: AOAM530Izv+T0zSIyDhtzb6c3hHK3E4I64ppgp2UFLp6brufOgOus330
        2ZyNqdiATSx+TrCqT98CNFBoUz/wG4y8VAVXxAcNsZwB
X-Google-Smtp-Source: ABdhPJycyNud+D4pGA1h7FJTM0h1ssAgqMzXG+REazS6DfYXBA0DC8MnOvc0vXFJmIIVcGJ4fbVeO2PH1pTE0nVP5p8=
X-Received: by 2002:a9d:3e53:: with SMTP id h19mr373877otg.260.1623856768366;
 Wed, 16 Jun 2021 08:19:28 -0700 (PDT)
MIME-Version: 1.0
References: <3140195.44csPzL39Z@kreacher> <3070024.5fSG56mABF@kreacher> <a691eab8-51bb-0965-9d17-63d438c43490@redhat.com>
In-Reply-To: <a691eab8-51bb-0965-9d17-63d438c43490@redhat.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 16 Jun 2021 17:19:16 +0200
Message-ID: <CAJZ5v0hC2Q4M455X4FQ-Z6tzdFkcUgMH_qPHDVV=4O0OcTpBkg@mail.gmail.com>
Subject: Re: [PATCH 5/5] ACPI: scan: Fix race related to dropping dependencies
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, Jun 16, 2021 at 4:55 PM Hans de Goede <hdegoede@redhat.com> wrote:
>
> Hi,
>
> On 6/16/21 4:25 PM, Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > If acpi_add_single_object() runs concurrently with respect to
> > acpi_scan_clear_dep() which deletes a dependencies list entry where
> > the device being added is the consumer, the device's dep_unmet
> > counter may not be updated to reflect that change.
> >
> > Namely, if the dependencies list entry is deleted right after
> > calling acpi_scan_dep_init() and before calling acpi_device_add(),
> > acpi_scan_clear_dep() will not find the device object corresponding
> > to the consumer device ACPI handle and it will not update its
> > dep_unmet counter to reflect the deletion of the list entry.
> > Consequently, the dep_unmet counter of the device will never
> > become zero going forward which may prevent it from being
> > completely enumerated.
> >
> > To address this problem, modify acpi_add_single_object() to run
> > acpi_tie_acpi_dev(), to attach the ACPI device object created by it
> > to the corresponding ACPI namespace node, under acpi_dep_list_lock
> > along with acpi_scan_dep_init() whenever the latter is called.
> >
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > ---
> >  drivers/acpi/scan.c |   46 +++++++++++++++++++++++++++++++++-------------
> >  1 file changed, 33 insertions(+), 13 deletions(-)
> >
> > Index: linux-pm/drivers/acpi/scan.c
> > ===================================================================
> > --- linux-pm.orig/drivers/acpi/scan.c
> > +++ linux-pm/drivers/acpi/scan.c
> > @@ -657,16 +657,12 @@ static int acpi_tie_acpi_dev(struct acpi
> >       return 0;
> >  }
> >
> > -int acpi_device_add(struct acpi_device *device,
> > -                 void (*release)(struct device *))
> > +int __acpi_device_add(struct acpi_device *device,
> > +                   void (*release)(struct device *))
> >  {
> >       struct acpi_device_bus_id *acpi_device_bus_id;
> >       int result;
> >
> > -     result = acpi_tie_acpi_dev(device);
> > -     if (result)
> > -             return result;
> > -
> >       /*
> >        * Linkage
> >        * -------
> > @@ -755,6 +751,17 @@ err_unlock:
> >       return result;
> >  }
> >
> > +int acpi_device_add(struct acpi_device *adev, void (*release)(struct device *))
> > +{
> > +     int ret;
> > +
> > +     ret = acpi_tie_acpi_dev(adev);
> > +     if (ret)
> > +             return ret;
> > +
> > +     return __acpi_device_add(adev, release);
> > +}
> > +
> >  /* --------------------------------------------------------------------------
> >                                   Device Enumeration
> >     -------------------------------------------------------------------------- */
> > @@ -1681,14 +1688,10 @@ static void acpi_scan_dep_init(struct ac
> >  {
> >       struct acpi_dep_data *dep;
> >
> > -     mutex_lock(&acpi_dep_list_lock);
> > -
> >       list_for_each_entry(dep, &acpi_dep_list, node) {
> >               if (dep->consumer == adev->handle)
> >                       adev->dep_unmet++;
> >       }
> > -
> > -     mutex_unlock(&acpi_dep_list_lock);
> >  }
> >
> >  void acpi_device_add_finalize(struct acpi_device *device)
> > @@ -1707,6 +1710,7 @@ static int acpi_add_single_object(struct
> >                                 acpi_handle handle, int type, bool dep_init)
> >  {
> >       struct acpi_device *device;
> > +     bool release_dep_lock = false;
> >       int result;
> >
> >       device = kzalloc(sizeof(struct acpi_device), GFP_KERNEL);
> > @@ -1720,16 +1724,32 @@ static int acpi_add_single_object(struct
> >        * this must be done before the get power-/wakeup_dev-flags calls.
> >        */
> >       if (type == ACPI_BUS_TYPE_DEVICE || type == ACPI_BUS_TYPE_PROCESSOR) {
> > -             if (dep_init)
> > +             if (dep_init) {
> > +                     mutex_lock(&acpi_dep_list_lock);
> > +                     /*
> > +                      * Hold the lock until the acpi_tie_acpi_dev() call
> > +                      * below to prevent concurrent acpi_scan_clear_dep()
> > +                      * from deleting a dependency list entry without
> > +                      * updating dep_unmet for the device.
> > +                      */
> > +                     release_dep_lock = true;
> >                       acpi_scan_dep_init(device);
> > -
> > +             }
> >               acpi_scan_init_status(device);
> >       }
> >
> >       acpi_bus_get_power_flags(device);
> >       acpi_bus_get_wakeup_device_flags(device);
> >
> > -     result = acpi_device_add(device, acpi_device_release);
> > +     result = acpi_tie_acpi_dev(device);
> > +
> > +     if (release_dep_lock)
> > +             mutex_unlock(&acpi_dep_list_lock);
> > +
> > +     if (result)
>
> AFAICT you are missing a "acpi_device_release(&device->dev);"
> call in the error-exit path here, causing a mem-leak.

Indeed.

I'll send a v2 of this patch alone to fix this issue.

> Otherwise this looks good, with the above fixed this is:
>
> Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Thanks!
