Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1D2542AD06
	for <lists+linux-acpi@lfdr.de>; Tue, 12 Oct 2021 21:11:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232648AbhJLTN3 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 12 Oct 2021 15:13:29 -0400
Received: from mail-ot1-f47.google.com ([209.85.210.47]:39539 "EHLO
        mail-ot1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231886AbhJLTN2 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 12 Oct 2021 15:13:28 -0400
Received: by mail-ot1-f47.google.com with SMTP id k2-20020a056830168200b0054e523d242aso618389otr.6;
        Tue, 12 Oct 2021 12:11:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UsdaTdlqInk/Db+RELmJSVFeuk7KGQ8SYughWLnehY8=;
        b=zeF1M07uZ8koHB8p8h4k4Af9rpsS7JfPitcYjb4dJizDs9kwcfTb6SIg1cjkj8xeoo
         Cm/UONhKNolje1c0RBuxt6ATGTqlN6fGSyX6pMURacipxG5coD/I2i2j48Drho/ITQ/M
         geJrpgW8zQLyjF6f8le34r0FJ85p6ffUtJ6OgMw0J0tYwD3FmStWzPV2kU5gcMX2ed2Z
         uJ8Wg7Mv2MbUmtgrVZ6EZGcNgPV+qFQAMgRN/4Vt6EB7CrXdCSetvpZdPUVyz/q5sV3k
         pJtta2ZEF8Kxb/x6J/MfsnF3CU3Ui6H+rfD9JyPWAYJ8Z16tOqhO22fbsVaWa0bH1JGZ
         EOog==
X-Gm-Message-State: AOAM530fRqCRX744roWP+N2vwVYC5wujpE0+4HpyyHDN/vebkZUAX+ed
        0+8fs1PkZwOVGes5jnN1QLKpsj5PBtHbtINluxw=
X-Google-Smtp-Source: ABdhPJytCGKquuZUCLHcTR60tHiVx+DiBYKNCYYXZyFiFB2yU1k6CxzHrr7FAo+69ScbY5+qP7A2HHxC8Gc+p27Jylg=
X-Received: by 2002:a05:6830:1af0:: with SMTP id c16mr14677399otd.16.1634065886475;
 Tue, 12 Oct 2021 12:11:26 -0700 (PDT)
MIME-Version: 1.0
References: <4369779.LvFx2qVVIh@kreacher> <3089655.5fSG56mABF@kreacher> <e15036b7-b41f-a5cf-b8a6-b1b9023197cd@gmail.com>
In-Reply-To: <e15036b7-b41f-a5cf-b8a6-b1b9023197cd@gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 12 Oct 2021 21:11:15 +0200
Message-ID: <CAJZ5v0hmvRDZjs6y4q8CuMdP6iu5cOcQ3KLJQm4kD5aNvt4pHw@mail.gmail.com>
Subject: Re: [PATCH v1 5/7] surface: surface3_power: Use ACPI_COMPANION() directly
To:     Maximilian Luz <luzmaximilian@gmail.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <mgross@linux.intel.com>,
        Platform Driver <platform-driver-x86@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, Oct 12, 2021 at 8:21 PM Maximilian Luz <luzmaximilian@gmail.com> wrote:
>
> On 10/12/21 19:46, Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rafael@kernel.org>
> >
> > The ACPI_HANDLE() macro is a wrapper arond the ACPI_COMPANION()
> > macro and the ACPI handle produced by the former comes from the
> > ACPI device object produced by the latter, so it is way more
> > straightforward to evaluate the latter directly instead of passing
> > the handle produced by the former to acpi_bus_get_device().
> >
> > Modify mshw0011_notify() accordingly (no intentional functional
> > impact).
> >
> > Signed-off-by: Rafael J. Wysocki <rafael@kernel.org>
>
> Looks mostly good to me, small comment/question inline.
>
> > ---
> >   drivers/platform/surface/surface3_power.c |    9 ++++-----
> >   1 file changed, 4 insertions(+), 5 deletions(-)
> >
> > Index: linux-pm/drivers/platform/surface/surface3_power.c
> > ===================================================================
> > --- linux-pm.orig/drivers/platform/surface/surface3_power.c
> > +++ linux-pm/drivers/platform/surface/surface3_power.c
> > @@ -160,15 +160,14 @@ mshw0011_notify(struct mshw0011_data *cd
> >   {
> >       union acpi_object *obj;
> >       struct acpi_device *adev;
> > -     acpi_handle handle;
> >       unsigned int i;
> >
> > -     handle = ACPI_HANDLE(&cdata->adp1->dev);
> > -     if (!handle || acpi_bus_get_device(handle, &adev))
> > +     adev = ACPI_COMPANION(&cdata->adp1->dev);
> > +     if (!adev)
> >               return -ENODEV;
>
> Do we need to get the ACPI device (adev) here? To me it looks like only
> its handle is actually used so why not keep ACPI_HANDLE() and remove the
> acpi_bus_get_device() call instead?

It actually doesn't really matter, but you're right,
acpi_bus_get_device() is simply redundant here, so ACPI_HANDLE() is
sufficient.

I'll send a v2 of this one.

> >
> > -     obj = acpi_evaluate_dsm_typed(handle, &mshw0011_guid, arg1, arg2, NULL,
> > -                                   ACPI_TYPE_BUFFER);
> > +     obj = acpi_evaluate_dsm_typed(adev->handle, &mshw0011_guid, arg1, arg2,
> > +                                   NULL, ACPI_TYPE_BUFFER);
> >       if (!obj) {
> >               dev_err(&cdata->adp1->dev, "device _DSM execution failed\n");
> >               return -ENODEV;
> >
> >
> >
>
> Regards,
> Max
