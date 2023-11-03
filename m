Return-Path: <linux-acpi+bounces-1176-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 303BD7E0191
	for <lists+linux-acpi@lfdr.de>; Fri,  3 Nov 2023 11:33:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 494CCB20981
	for <lists+linux-acpi@lfdr.de>; Fri,  3 Nov 2023 10:32:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7AF215497
	for <lists+linux-acpi@lfdr.de>; Fri,  3 Nov 2023 10:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="peVp3Sko"
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21B6B2D604
	for <linux-acpi@vger.kernel.org>; Fri,  3 Nov 2023 09:09:08 +0000 (UTC)
Received: from mail-vk1-xa2c.google.com (mail-vk1-xa2c.google.com [IPv6:2607:f8b0:4864:20::a2c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C334AA2
	for <linux-acpi@vger.kernel.org>; Fri,  3 Nov 2023 02:09:07 -0700 (PDT)
Received: by mail-vk1-xa2c.google.com with SMTP id 71dfb90a1353d-49ab0641e77so763564e0c.0
        for <linux-acpi@vger.kernel.org>; Fri, 03 Nov 2023 02:09:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1699002547; x=1699607347; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iZ+pK7HfT2/R2CHqNUxxdFop+H2f9lKl/kwZAHnUNCc=;
        b=peVp3SkoAlh8W2pFsRjsxwAJByWm5XMxfy7q/k/feck+DaefKy9kjEQgxXMFprv0tn
         aPeEdv9uhk4mbT/JkXcMPaO2xPtiPODHcj8B1zob+owyRosnx6QoOuxOBwu2GkpyZclo
         RnHVGYroa5B7+TT4gEnevwgDQRjrB5ReR3EOme1ipJUtAKJ7FCN+SoD/ITiqYU4T+zbg
         2C8XN4NzelAyBPOtj8OETwcfhLQZe6AJdGqUAuQ/Wt0gceAP1YraCPRr+1sx87rU8Rx4
         knfvb1Uh8RqgEki9wOeVXO3wsZEaHdEPOkU94E1S5MW642dp+aS5bTPHikRd2AZzjFjF
         UwJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699002547; x=1699607347;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iZ+pK7HfT2/R2CHqNUxxdFop+H2f9lKl/kwZAHnUNCc=;
        b=N4JYJZEmUD9AY93IFqhvoGyLcba6P22Obo4oAdNnl/rmcnFsY6vJSRisE0W9dJPlwe
         lPeeueiyXCqnEh7CubROWyXecWjCjnIh7BNq3uyeqM9x9MeYK3sSV5kDg+FNK6clcj/D
         ORDZJHOupSQXt/rT9tmdwLKAp5F203ABWIlXOwLyt+geW48Q8UyQgm4KzSz5hDuhLdbS
         CjzWI6869jqs9qDqkgG/1LY4Z5NmrVf17L11RqgRtlKcsPgrmihLpcLac4YCoGQ410MG
         CyRulgP5UDWDTP8wEtPBxoEtf4U7uaCrRPPQrIkexV4e0I/DFJb2ZIqI9Q+/4GYkQDZl
         ri4Q==
X-Gm-Message-State: AOJu0YyNJq2E2+Ek7kboIfE66Z5ukMN5WKReBwgVmBn7CqXMnV/9K2BE
	av1ozp/eG16e/YxdrkmIjc7yPm7VsxNIxW8DWA4iLw==
X-Google-Smtp-Source: AGHT+IHMP14aNnuPk/M9auTqU14X1reP20Ndq5FFB6ZsM/lAvTNnyVHqTdzd4iYuirkmf+ceV4tLz2fWcV0BuqJs+S4=
X-Received: by 2002:a1f:a6c9:0:b0:48f:8e3a:5b83 with SMTP id
 p192-20020a1fa6c9000000b0048f8e3a5b83mr18714917vke.14.1699002546868; Fri, 03
 Nov 2023 02:09:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231025184259.250588-1-andriy.shevchenko@linux.intel.com>
 <20231025184259.250588-2-andriy.shevchenko@linux.intel.com>
 <2023102624-moonshine-duller-3043@gregkh> <ZTpbMVSdKlOgLbwv@smile.fi.intel.com>
 <ZUPBVMdi3hcTyW2n@smile.fi.intel.com>
In-Reply-To: <ZUPBVMdi3hcTyW2n@smile.fi.intel.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Fri, 3 Nov 2023 10:08:56 +0100
Message-ID: <CAMRc=MeV9ZyOzuQFEE_duPTHYgfmr6UZU6bpjDPhrczZX4PHpg@mail.gmail.com>
Subject: Re: [PATCH v1 1/3] device property: Implement device_is_big_endian()
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, 
	Linus Walleij <linus.walleij@linaro.org>, Daniel Scally <djrscally@gmail.com>, 
	Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
	Sakari Ailus <sakari.ailus@linux.intel.com>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Rob Herring <robh+dt@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 2, 2023 at 4:33=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Thu, Oct 26, 2023 at 03:27:30PM +0300, Andy Shevchenko wrote:
> > On Thu, Oct 26, 2023 at 07:25:35AM +0200, Greg Kroah-Hartman wrote:
> > > On Wed, Oct 25, 2023 at 09:42:57PM +0300, Andy Shevchenko wrote:
> > > > Some users want to use the struct device pointer to see if the
> > > > device is big endian in terms of Open Firmware specifications,
> > > > i.e. if it has a "big-endian" property, or if the kernel was
> > > > compiled for BE *and* the device has a "native-endian" property.
> > > >
> > > > Provide inline helper for the users.
> > >
> > > Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> >
> > Thank you, Greg.
> >
> > Bart, would it be still possible to take this into next?
> > I would like to have at least this patch applied (with the first user)
> > to allow conversion of others (I have some more users of new API).
>
> Okay, seems we missed v6.7 with this, can you then prepare an immutable
> branch / tag with this, so other maintainers can pull in case it's needed=
?
> (I have something against tty already and perhaps something else, let's
>  see.)
>

It arrived too late in the cycle, I needed to send my PR earlier this
time as I was OoO this week.

Bart

