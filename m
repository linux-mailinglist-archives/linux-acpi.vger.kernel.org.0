Return-Path: <linux-acpi+bounces-2325-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 86B8C80F5F6
	for <lists+linux-acpi@lfdr.de>; Tue, 12 Dec 2023 20:05:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F7E61F2163F
	for <lists+linux-acpi@lfdr.de>; Tue, 12 Dec 2023 19:05:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4065780047;
	Tue, 12 Dec 2023 19:05:26 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19310D2;
	Tue, 12 Dec 2023 11:05:23 -0800 (PST)
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-3b8652c0bd2so476252b6e.1;
        Tue, 12 Dec 2023 11:05:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702407909; x=1703012709;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=acI53ybdHT2Ybz8qt+m1BvwwM9zmui8Iu0a8RDnCHxk=;
        b=SlhSFn2bKYKv0v+sGQveSqnRWymzPtVFgumTRPWhI3qM8GAGQSeV19ZnSs4cp2+0ts
         qeH4PevC8r4pYuXZBZSqVCppEabeF6nTCyYenN2GUFtXBFot1h6rMGYPvNvq8Z1sfYc2
         LEMUU+vaD3YBifKYYM7lZ57HSg3cOQaXBMYULdGENtzjNYHF4AOWMfAT1J9c6W1aHeaf
         tp2ZXjpwjgB2YMFKGRzkugMjmvJZD7ZBIY3CkMu3uttxdT1EzfDvmOkJMtj+kr5egHmp
         UUildqRqlq0WSn5LFQIp350a2yEPUx1RbQaQSZ1/B6AO3JkEjsD0MaCXzqidzW+9G9hP
         nijw==
X-Gm-Message-State: AOJu0YwqwmO75MFah4O7lNoJTvDjxGK4H7SKQEoJBAol/PK6H8dQtmwI
	5zMmcDOxfzzntkcfLCcv+F52DrALHJHffy9QJgQ=
X-Google-Smtp-Source: AGHT+IHA5aPq73KlqjHsWJe8UGDHVApy8ClQPEGpXkcVl3Yaj8XAdN3OGN+Mn2ZiVnLPVAe8J1MXkUfUG6cgn1J2gsM=
X-Received: by 2002:a4a:a7c4:0:b0:590:6585:5c41 with SMTP id
 n4-20020a4aa7c4000000b0059065855c41mr10944482oom.0.1702407909102; Tue, 12 Dec
 2023 11:05:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <5737811.DvuYhMxLoT@kreacher> <cf055d45-8970-4657-ab86-d28636645c81@linaro.org>
 <CAJZ5v0ic_=2wvge1T7YmGe5icR5dPxrvKy2N4gXP+KMievobmA@mail.gmail.com>
In-Reply-To: <CAJZ5v0ic_=2wvge1T7YmGe5icR5dPxrvKy2N4gXP+KMievobmA@mail.gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 12 Dec 2023 20:04:58 +0100
Message-ID: <CAJZ5v0gkBZh42obB-g95T2DBFntYrnidjAeUoFN+e-CqGrSQCw@mail.gmail.com>
Subject: Re: [PATCH v1] thermal: trip: Send trip change notifications on all
 trip updates
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM <linux-pm@vger.kernel.org>, 
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Zhang Rui <rui.zhang@intel.com>, 
	Linux ACPI <linux-acpi@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Lukasz Luba <lukasz.luba@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 6, 2023 at 5:01=E2=80=AFPM Rafael J. Wysocki <rafael@kernel.org=
> wrote:
>
> Hi Daniel,
>
> On Wed, Dec 6, 2023 at 3:38=E2=80=AFPM Daniel Lezcano <daniel.lezcano@lin=
aro.org> wrote:
> >
> >
> > Hi Rafael,
> >
> > On 05/12/2023 20:18, Rafael J. Wysocki wrote:
> > > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > >
> > > The _store callbacks of the trip point temperature and hysteresis sys=
fs
> > > attributes invoke thermal_notify_tz_trip_change() to send a notificat=
ion
> > > regarding the trip point change, but when trip points are updated by =
the
> > > platform firmware, trip point change notifications are not sent.
> > >
> > > To make the behavior after a trip point change more consistent,
> > > modify all of the 3 places where trip point temperature is updated
> > > to use a new function called thermal_zone_set_trip_temp() for this
> > > purpose and make that function call thermal_notify_tz_trip_change().
> > >
> > > Note that trip point hysteresis can only be updated via sysfs and
> > > trip_point_hyst_store() calls thermal_notify_tz_trip_change() already=
,
> > > so this code path need not be changed.
> >
> > Why the ACPI driver is not calling thermal_zone_device_update() after
> > changing the trip point like the other drivers?
>
> It calls that function, but because it may update multiple trips in
> one go, it does that after all of the updates are done, via
> acpi_thermal_check_fn().
>
> > It would make sense to have the thermal framework to be notified about
> > this change and check if there is a trip violation, no ?
>
> It is notified as noted above, but not synchronously.

I believe that the question above has been answered, so are there any
other comments or concerns regarding this patch?

