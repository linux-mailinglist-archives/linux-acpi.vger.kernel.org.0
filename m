Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 436EA2FA6A0
	for <lists+linux-acpi@lfdr.de>; Mon, 18 Jan 2021 17:47:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393262AbhARQrT (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 18 Jan 2021 11:47:19 -0500
Received: from mail-oo1-f43.google.com ([209.85.161.43]:39064 "EHLO
        mail-oo1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405630AbhARPRO (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 18 Jan 2021 10:17:14 -0500
Received: by mail-oo1-f43.google.com with SMTP id k9so4167751oop.6;
        Mon, 18 Jan 2021 07:16:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=O9KoYS9I3JZhQXoL3Y7lBSI29uwk71QCwYJQjM0zds4=;
        b=Gv+dZAQCtfqscYkbSfIT1D5WiQeiFcJV7zOxJkUQkG2skN0hhjDq9wZd6sC9UsPeC5
         Brh8F2O9hsH2Pc7Y+QA5JHD2gu6kjQYO6Xp8+p+HT9e++lunIGqeS7bpT/JIxmHVIj5L
         4bwaigxSYOEeXrreFL+nLf6fLihy2pesExpAohbAs5mIJ453comnXjmWbbLghoB/A+s8
         3ewd/e4SAZXc1Nx4ufMRPmg8FYcfcJSs3V8zcV1TjpCmF4xlziY0ltHP7iZdF8a3r0GT
         C7wl2L5N6+N5YMaDm1iWnz7c10rQdvQ/KktLYNCPaS3W6DI4WzvjoHJSrlNrCCnTGiCx
         2jtQ==
X-Gm-Message-State: AOAM530wODb+Z/vN9iGyn4E378x4uVvAojYmsHqgPPZLNGPECIwIlBnY
        aSG/6omz4R/0N5wbT7cby0F3VKqGcdLQ0Vm0q3g=
X-Google-Smtp-Source: ABdhPJzSs9pAdM6RXdyMlqWV7jr1YoxXgEPZ922fBgS4HB4AXfAUUwiehZl04ZR5WmKL4oyxP4CKNdu2O2tIzepNQhc=
X-Received: by 2002:a4a:bf14:: with SMTP id r20mr17407117oop.2.1610982992723;
 Mon, 18 Jan 2021 07:16:32 -0800 (PST)
MIME-Version: 1.0
References: <3494203.VBaj39JGmp@kreacher> <2999734.9HhbEeWEHR@kreacher> <8218eff4-6629-ac20-ec3f-a66aad445bb6@redhat.com>
In-Reply-To: <8218eff4-6629-ac20-ec3f-a66aad445bb6@redhat.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 18 Jan 2021 16:16:16 +0100
Message-ID: <CAJZ5v0hv2FX2wtuwu9Jd1zZiGut9kUzQvCH5vXLMyFpqvvYOkA@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] ACPI: scan: Rearrange memory allocation in acpi_device_add()
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Sat, Jan 16, 2021 at 1:37 PM Hans de Goede <hdegoede@redhat.com> wrote:
>
> Hi,
>
> On 1/14/21 7:46 PM, Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > The upfront allocation of new_bus_id is done to avoid allocating
> > memory under acpi_device_lock, but it doesn't really help,
> > because (1) it leads to many unnecessary memory allocations for
> > _ADR devices, (2) kstrdup_const() is run under that lock anyway and
> > (3) it complicates the code.
> >
> > Rearrange acpi_device_add() to allocate memory for a new struct
> > acpi_device_bus_id instance only when necessary, eliminate a redundant
> > local variable from it and reduce the number of labels in there.
> >
> > No intentional functional impact.
> >
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > ---
> >  drivers/acpi/scan.c |   57 +++++++++++++++++++++++-----------------------------
> >  1 file changed, 26 insertions(+), 31 deletions(-)
> >
> > Index: linux-pm/drivers/acpi/scan.c
> > ===================================================================
> > --- linux-pm.orig/drivers/acpi/scan.c
> > +++ linux-pm/drivers/acpi/scan.c
> > @@ -621,12 +621,23 @@ void acpi_bus_put_acpi_device(struct acp
> >       put_device(&adev->dev);
> >  }
> >
> > +static struct acpi_device_bus_id *acpi_device_bus_id_match(const char *dev_id)
> > +{
> > +     struct acpi_device_bus_id *acpi_device_bus_id;
> > +
> > +     /* Find suitable bus_id and instance number in acpi_bus_id_list. */
> > +     list_for_each_entry(acpi_device_bus_id, &acpi_bus_id_list, node) {
> > +             if (!strcmp(acpi_device_bus_id->bus_id, dev_id))
> > +                     return acpi_device_bus_id;
> > +     }
> > +     return NULL;
> > +}
> > +
> >  int acpi_device_add(struct acpi_device *device,
> >                   void (*release)(struct device *))
> >  {
> > +     struct acpi_device_bus_id *acpi_device_bus_id;
> >       int result;
> > -     struct acpi_device_bus_id *acpi_device_bus_id, *new_bus_id;
> > -     int found = 0;
> >
> >       if (device->handle) {
> >               acpi_status status;
> > @@ -652,38 +663,26 @@ int acpi_device_add(struct acpi_device *
> >       INIT_LIST_HEAD(&device->del_list);
> >       mutex_init(&device->physical_node_lock);
> >
> > -     new_bus_id = kzalloc(sizeof(struct acpi_device_bus_id), GFP_KERNEL);
> > -     if (!new_bus_id) {
> > -             pr_err(PREFIX "Memory allocation error\n");
> > -             result = -ENOMEM;
> > -             goto err_detach;
> > -     }
> > -
> >       mutex_lock(&acpi_device_lock);
> > -     /*
> > -      * Find suitable bus_id and instance number in acpi_bus_id_list
> > -      * If failed, create one and link it into acpi_bus_id_list
> > -      */
> > -     list_for_each_entry(acpi_device_bus_id, &acpi_bus_id_list, node) {
> > -             if (!strcmp(acpi_device_bus_id->bus_id,
> > -                         acpi_device_hid(device))) {
> > -                     acpi_device_bus_id->instance_no++;
> > -                     found = 1;
> > -                     kfree(new_bus_id);
> > -                     break;
> > +
> > +     acpi_device_bus_id = acpi_device_bus_id_match(acpi_device_hid(device));
> > +     if (acpi_device_bus_id) {
> > +             acpi_device_bus_id->instance_no++;
> > +     } else {
> > +             acpi_device_bus_id = kzalloc(sizeof(*acpi_device_bus_id),
> > +                                          GFP_KERNEL);
> > +             if (!acpi_device_bus_id) {
> > +                     result = -ENOMEM;
> > +                     goto err_unlock;
> >               }
> > -     }
> > -     if (!found) {
> > -             acpi_device_bus_id = new_bus_id;
> >               acpi_device_bus_id->bus_id =
> >                       kstrdup_const(acpi_device_hid(device), GFP_KERNEL);
> >               if (!acpi_device_bus_id->bus_id) {
> > -                     pr_err(PREFIX "Memory allocation error for bus id\n");
> > +                     kfree(acpi_device_bus_id);
> >                       result = -ENOMEM;
> > -                     goto err_free_new_bus_id;
> > +                     goto err_unlock;
> >               }
>
> When I have cases like this, where 2 mallocs are necessary I typically do it like this:
>
>         const char *bus_id;
>
>         ...
>
>         } else {
>                 acpi_device_bus_id = kzalloc(sizeof(*acpi_device_bus_id),
>                                              GFP_KERNEL);
>                 bus_id = kstrdup_const(acpi_device_hid(device), GFP_KERNEL);
>                 if (!acpi_device_bus_id || !bus_id) {
>                         kfree(acpi_device_bus_id);
>                         kfree(bus_id);
>                         result = -ENOMEM;
>                         goto err_unlock;
>                 }
>                 acpi_device_bus_id->bus_id = bus_id;
>                 list_add_tail(&acpi_device_bus_id->node, &acpi_bus_id_list);
>         }
>
>         ...
>
> So that there is only one if / 1 error-handling path for both mallocs.
> I personally find this a bit cleaner.

Yes, that looks better.

Let me do it this way, but I won't resend the patch if you don't mind.

> Either way, with or without this change, the patch looks good to me:
>
> Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Thanks!
