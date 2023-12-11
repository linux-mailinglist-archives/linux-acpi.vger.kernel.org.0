Return-Path: <linux-acpi+bounces-2290-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC94480D26A
	for <lists+linux-acpi@lfdr.de>; Mon, 11 Dec 2023 17:42:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 08F2A1C21468
	for <lists+linux-acpi@lfdr.de>; Mon, 11 Dec 2023 16:42:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8703F3B785;
	Mon, 11 Dec 2023 16:42:18 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53ABBB3;
	Mon, 11 Dec 2023 08:42:15 -0800 (PST)
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-1ff010595f6so279162fac.1;
        Mon, 11 Dec 2023 08:42:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702312934; x=1702917734;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9WJcvJcL3yAkFCnOTaVPfSy6UlxoNxbtX+zUdQ6UhZE=;
        b=wAETMmGsD21TGzTwZS8rd3+MeAOKHSUmIfJEVA+uHl4L3Y6OuBjH5JiArcGdDpqSLD
         tJvwYUCdnuRxq3Uj1DSjCcT285dDDfz1CJ7TCQCAWZwxpjDFj6CRxlDhbSI41GDTjLHo
         MBPHt4s5QL8JbGqV2ShRVnUlp0vcoi5Mx6SWTeiqdy9HL6Wrz8jZk8V/iR+K2D2lxfeJ
         nE7dQY2WD35JnvnJZaCqvyz+tjngUGiA3AS5CJ/gTfo/xh14aDmCTufD52DVAC+RoM7a
         CQSuHrR32PefncgETcw0nK7tSZZZuCgXks/j4VocKLGauCcGyDp43ODNxhvpXuQmDTRq
         /7NA==
X-Gm-Message-State: AOJu0Yx9fQDA7Je4VANY54v3mIw+eGqBx28YQtI+sz5lZwRfnA9wW2qs
	2rml5Rw0DlXtOczY3LVyZJXjdTsZ7iM0vkCXE88=
X-Google-Smtp-Source: AGHT+IHh68sxJ+FCUbTjDIOHcbvFkIYZjXfMGw/e5bAa4u7owMb+DWXJ8eIWSmMsJ8+L//X997vIW3Il1smjTR0nX8I=
X-Received: by 2002:a05:6870:961d:b0:1fb:1576:ee66 with SMTP id
 d29-20020a056870961d00b001fb1576ee66mr8573877oaq.5.1702312934566; Mon, 11 Dec
 2023 08:42:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1880915.tdWV9SEqCh@kreacher> <13414639.uLZWGnKmhe@kreacher> <0a0d5dd4-6b7a-428b-8ef1-bb6aff76fb51@linaro.org>
In-Reply-To: <0a0d5dd4-6b7a-428b-8ef1-bb6aff76fb51@linaro.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 11 Dec 2023 17:42:03 +0100
Message-ID: <CAJZ5v0jebeWzUb-q-_xThRwZgUzaUfqS4YTGmsvbsOPrqFcYTQ@mail.gmail.com>
Subject: Re: [PATCH v1 1/3] thermal: core: Make thermal_zone_device_unregister()
 return after freeing the zone
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM <linux-pm@vger.kernel.org>, 
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Zhang Rui <rui.zhang@intel.com>, 
	Linux ACPI <linux-acpi@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Lukasz Luba <lukasz.luba@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 11, 2023 at 5:28=E2=80=AFPM Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
>
> On 08/12/2023 20:13, Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > Make thermal_zone_device_unregister() wait until all of the references
> > to the given thermal zone object have been dropped and free it before
> > returning.
> >
> > This guarantees that when thermal_zone_device_unregister() returns,
> > there is no leftover activity regarding the thermal zone in question
> > which is required by some of its callers (for instance, modular driver
> > code that wants to know when it is safe to let the module go away).
> >
> > Subsequently, this will allow some confusing device_is_registered()
> > checks to be dropped from the thermal sysfs and core code.
> >
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > ---
>
> Definitively agree on the change
>
> Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>

Thanks!

> Would it make sense to use kref_get/put ?

Why and where?

