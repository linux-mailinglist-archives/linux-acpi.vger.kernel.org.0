Return-Path: <linux-acpi+bounces-1526-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F2C17EC8E3
	for <lists+linux-acpi@lfdr.de>; Wed, 15 Nov 2023 17:44:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC47328099A
	for <lists+linux-acpi@lfdr.de>; Wed, 15 Nov 2023 16:44:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 926683BB30
	for <lists+linux-acpi@lfdr.de>; Wed, 15 Nov 2023 16:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="DdTd3LI+"
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8C7533070
	for <linux-acpi@vger.kernel.org>; Wed, 15 Nov 2023 14:59:09 +0000 (UTC)
Received: from mail-vk1-xa2d.google.com (mail-vk1-xa2d.google.com [IPv6:2607:f8b0:4864:20::a2d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33C68AB
	for <linux-acpi@vger.kernel.org>; Wed, 15 Nov 2023 06:59:06 -0800 (PST)
Received: by mail-vk1-xa2d.google.com with SMTP id 71dfb90a1353d-4ac985ea4bbso3002254e0c.2
        for <linux-acpi@vger.kernel.org>; Wed, 15 Nov 2023 06:59:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1700060345; x=1700665145; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D3OrBniBax6aBFZKFMUfvMbREKJHYn5D4TcXhxSLl7M=;
        b=DdTd3LI+Yn65C+0h4rKSKCDaFeW8m7PPrmz1QPKfI3PEAZUKENGq+zi3oQJhGboMnd
         q2Auljshyc8h1RxhcDkSdFPxfFDB9hoN+GKTKrULuNnxjQ8qG9vHRFiglK+rklRjUa/k
         YvbARqaWQfNYxJKP3mOqcap/C1a22F6j6wehIMAAh1J209JMG1aOIrhtUx8d+26VDW1I
         9GYkNYWqTA3Er+bTOjYXGf86eIN6sWjycZFf7mbQI+x657s+phhzzwDMmVa/YTgNxd3d
         Wy5V3S6GEqu2vMIA5iaTxtnEw78ZE8Ni2AIrlcPO36Zec1SBLp6feJRAzlUpd9N2gzWM
         4esg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700060345; x=1700665145;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D3OrBniBax6aBFZKFMUfvMbREKJHYn5D4TcXhxSLl7M=;
        b=YoV3phqhNNUX8luvM28oaWg7S9zWjwmzna33OGM/KC+Zip3UubZ7mf0L493FpFQqKJ
         3sixIksE0GqBoCEXq6k7KcY/ned4fV0eWrnis0POuOdDAM+WRhxCDAv7bbN66ga8bg/y
         o0NvGfx4/8o7f7JSxZoJMkXSSbbpsgX8KE5mdQKw4/QFA9oaFOV+b7SUcZfqlg1abhOI
         eFxsxQ3iLI0Tz7/tMvPCDm6Y7lpZNXtWfdhXM7GwcO6Sbvb2y9eR6sWvJdSz7sXIFU74
         4DifYdMB8LDJ5c26wCMT3zWeMzawAJWpzVTgqtHWCaSDgHqaig3HeiNgMB4y7153ZP5C
         p1Yw==
X-Gm-Message-State: AOJu0YynBetp2nWt9lpuLgfO9PRTf3rakHTs/w5o1jQUsGF1+zqd4FZb
	G4YZRka401RWPCOHmsakWoFcJZ6J+XBs88gbze3B0A==
X-Google-Smtp-Source: AGHT+IHtSbrAOce7kh6Al+4OKo3Q8n54AV6TLGvDzbUXO/PGYI9Ce7LXQovvwPec+z3aHpZOCddDdLn/i88HYPXTykc=
X-Received: by 2002:ac5:c978:0:b0:4ab:fbff:a811 with SMTP id
 t24-20020ac5c978000000b004abfbffa811mr11781567vkm.14.1700060345256; Wed, 15
 Nov 2023 06:59:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231025184259.250588-1-andriy.shevchenko@linux.intel.com>
 <20231025184259.250588-2-andriy.shevchenko@linux.intel.com>
 <2023102624-moonshine-duller-3043@gregkh> <ZTpbMVSdKlOgLbwv@smile.fi.intel.com>
 <ZUPBVMdi3hcTyW2n@smile.fi.intel.com> <CAMRc=MeV9ZyOzuQFEE_duPTHYgfmr6UZU6bpjDPhrczZX4PHpg@mail.gmail.com>
In-Reply-To: <CAMRc=MeV9ZyOzuQFEE_duPTHYgfmr6UZU6bpjDPhrczZX4PHpg@mail.gmail.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Wed, 15 Nov 2023 15:58:54 +0100
Message-ID: <CAMRc=MdSpk_OszeDCyA5_Sp-w=sL9DHB2gGCOFP+FCiobm2cbA@mail.gmail.com>
Subject: Re: [PATCH v1 1/3] device property: Implement device_is_big_endian()
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-acpi@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>, 
	Daniel Scally <djrscally@gmail.com>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
	Sakari Ailus <sakari.ailus@linux.intel.com>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Rob Herring <robh+dt@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 3, 2023 at 10:08=E2=80=AFAM Bartosz Golaszewski <brgl@bgdev.pl>=
 wrote:
>
> On Thu, Nov 2, 2023 at 4:33=E2=80=AFPM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> >
> > On Thu, Oct 26, 2023 at 03:27:30PM +0300, Andy Shevchenko wrote:
> > > On Thu, Oct 26, 2023 at 07:25:35AM +0200, Greg Kroah-Hartman wrote:
> > > > On Wed, Oct 25, 2023 at 09:42:57PM +0300, Andy Shevchenko wrote:
> > > > > Some users want to use the struct device pointer to see if the
> > > > > device is big endian in terms of Open Firmware specifications,
> > > > > i.e. if it has a "big-endian" property, or if the kernel was
> > > > > compiled for BE *and* the device has a "native-endian" property.
> > > > >
> > > > > Provide inline helper for the users.
> > > >
> > > > Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > >
> > > Thank you, Greg.
> > >
> > > Bart, would it be still possible to take this into next?
> > > I would like to have at least this patch applied (with the first user=
)
> > > to allow conversion of others (I have some more users of new API).
> >
> > Okay, seems we missed v6.7 with this, can you then prepare an immutable
> > branch / tag with this, so other maintainers can pull in case it's need=
ed?
> > (I have something against tty already and perhaps something else, let's
> >  see.)
> >
>
> It arrived too late in the cycle, I needed to send my PR earlier this
> time as I was OoO this week.
>
> Bart

Greg, will you take this patch through your tree and provide me with
an immutable tag for this cycle?

Bart

