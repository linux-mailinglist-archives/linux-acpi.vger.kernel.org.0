Return-Path: <linux-acpi+bounces-14745-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD0BFAEA679
	for <lists+linux-acpi@lfdr.de>; Thu, 26 Jun 2025 21:31:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6F6B17B5214
	for <lists+linux-acpi@lfdr.de>; Thu, 26 Jun 2025 19:30:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50E3B253F3D;
	Thu, 26 Jun 2025 19:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qOoYamV8"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FA757263E;
	Thu, 26 Jun 2025 19:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750966285; cv=none; b=h/bJ+/hsW+O6AA9bk7cRtHmx0zRizf7d21Q/SqofasfkPIuH4qpiFO9korvLmiofL7TvlU3utw7YodWqN1VHgSV+IxCsGBN2v/oPTiJpyaRPMJjiNTweRKFKJdNpyOdjO3zeAKfSmvffDwmsAlHjP3psIqXGiAioOD22HtcGR18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750966285; c=relaxed/simple;
	bh=j+43sDHIIpuHFL3pwL4ZlbVpY5AE0nKYvezlRHVUvd8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lx5tmEH+xBvMVeU7FIIOMG1g6jx7UMVm9u6O+qlJu3Nmqcjx1qNLDCr3jhUoDj/vcoveuqZFh2TnwEgN8HrOFJJ00uAWNMYgQIXBnwBA6bJeJLnQQnu+1AIOdGO3nJeZFjqi3NSiSvuoP0nj8bCIuiTGehee+41MKWjBFThXvY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qOoYamV8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99FABC4CEEF;
	Thu, 26 Jun 2025 19:31:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750966284;
	bh=j+43sDHIIpuHFL3pwL4ZlbVpY5AE0nKYvezlRHVUvd8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=qOoYamV8GDdIg5dPF4uh73/F1WchKYBcTKEtjMYoc3XrKLtZbNvKG5LFe3yt5udWp
	 KEUySSrUDtYqQo/oOgaktDKclFAbETL6g1+w+jRvRrOfed1QiUWCrtm59f2FTI8Q8+
	 88NHMY+lnVsXQaPMPy3DjHQwiafv+L3nQ+iwp3RAQVaX46MWb8z3m/H8zBNOaMGHFo
	 d24gKdVHy2TUOBxpFyM5M4PlWift7htussS5NdKdir6GdRydCJmibbvs7FU73h6r5c
	 g+Nl/H3j39Odjn69ftdEmUR4jvCEbrUXLfYMgXy/6djgQIdtGfL+Lwt3K2RopPsLYS
	 CVrngP5PEzDUg==
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-61169c35f2aso418481eaf.2;
        Thu, 26 Jun 2025 12:31:24 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUFu9Ql1jtDGALjYWog87+ZIPfS8kVIZHfs+4iHvdsJVL4yVXvQYGFl88ocwB12bt8IVc4OYxTMwVMY@vger.kernel.org, AJvYcCV53tLFqa8G3CzapBfK5t6JJ5OzAQjjodxwCCqx3wAAOJ3yM4Ip/2uvOgU0qiGHlzGMK9p1J/2GxsxaE94=@vger.kernel.org, AJvYcCVAlH6EB0DUekFjo1m7X22JQVMU48hoZ8ffKdl+4JM39PUq6hv20joxMr41DcMehFUsynQqshs46ueUng==@vger.kernel.org, AJvYcCXSguLaCLXDa7xAySkFjR+ouAcJXvScMYYClF3D2Hv3z+Cm2QNot2rdH7i+fGqhgrdx15RZe8eznbJQBkT3@vger.kernel.org
X-Gm-Message-State: AOJu0Yzf0DW8KWnYgT75MIYgZocuaukGCWEb783bmZTC5Y9eNcLdFP+I
	+6beFAEhloVSKS96MT6aqVyb8JN89sCd8lq8qAJ/nkPlcTud7xhLS/yaV/aAVYxad47hOdLKZ8K
	b3VeEHs3go7aGqsvj2RDmk95GoaX7cQk=
X-Google-Smtp-Source: AGHT+IF2T/le5yxkGBi9UTwsV6GDXScYmNSJ+T5/OkG8dHRDATuY4qW0ZilnI6GrBKjbFhQJCM/MGeEvsmPm8VOrrwQ=
X-Received: by 2002:a05:6820:4c89:b0:611:a314:4e1a with SMTP id
 006d021491bc7-611b8f05073mr420851eaf.0.1750966283848; Thu, 26 Jun 2025
 12:31:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <23f30094-68cc-47fe-86e0-5289cb41e940@kernel.org>
 <rn2kp5tog2agvswva2ipqq2ytiqdcgccnocudsg6ckwfh4roei@provk2g6dita>
 <363c2b92-4bfc-4537-9fca-025eef09526f@kernel.org> <nxticocp26r5mmpkttritw76h5igw7bdpus6zaf5krkso2h5xy@wna6m2quekfi>
 <cbbf0caf-82ce-4427-9844-b11e0f5cacdb@kernel.org> <obpakvzyludc4jskqzyxf65dhqds7ie3jkbfsqdve32ouuaili@xvogkmwvbmbf>
 <284ea5c0-dca5-4e9e-a3e7-705eca794010@kernel.org> <vkau25ybcx3bcoa2jmxlukumunzii5h6em43anh6mmzk2kyiv7@kyych4kxc4zo>
 <0d71a686-da67-4686-8976-a17d0d1ca923@kernel.org> <CAJZ5v0gKUN1OdqAHnXNcFUAOfhpdRfa_o=L6TA2GZTpe1bMaNQ@mail.gmail.com>
 <exmgckzoakt2ncsdphqvymcadon7k6tl36a3zvrj2pv23dffps@znq23v3qbcm2>
In-Reply-To: <exmgckzoakt2ncsdphqvymcadon7k6tl36a3zvrj2pv23dffps@znq23v3qbcm2>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 26 Jun 2025 21:31:12 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0j3ZyuEqSKQ+3K8M3BwPCxn5Z6KOwjyjt4cJW6HfxjPDw@mail.gmail.com>
X-Gm-Features: Ac12FXzvcoS-sIgpHR-9SrsnNJt3Cwrq50dV_nsuZ0ePcECjdio6neiFbBNzyrE
Message-ID: <CAJZ5v0j3ZyuEqSKQ+3K8M3BwPCxn5Z6KOwjyjt4cJW6HfxjPDw@mail.gmail.com>
Subject: Re: [PATCH v3 4/4] Input: Don't send fake button presses to wake system
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Hans de Goede <hansg@kernel.org>, 
	Mario Limonciello <superm1@kernel.org>, Mika Westerberg <westeri@kernel.org>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Linus Walleij <linus.walleij@linaro.org>, Bartosz Golaszewski <brgl@bgdev.pl>, 
	"open list:GPIO ACPI SUPPORT" <linux-gpio@vger.kernel.org>, 
	"open list:GPIO ACPI SUPPORT" <linux-acpi@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>, 
	"open list:INPUT (KEYBOARD, MOUSE, JOYSTICK, TOUCHSCREEN)..." <linux-input@vger.kernel.org>, Mario Limonciello <mario.limonciello@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 26, 2025 at 9:28=E2=80=AFPM Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
>
> On Thu, Jun 26, 2025 at 09:18:56PM +0200, Rafael J. Wysocki wrote:
> > On Thu, Jun 26, 2025 at 9:16=E2=80=AFPM Hans de Goede <hansg@kernel.org=
> wrote:
> > >
> > > Hi,
> > >
> > > On 26-Jun-25 21:14, Dmitry Torokhov wrote:
> > > > On Thu, Jun 26, 2025 at 08:57:30PM +0200, Hans de Goede wrote:
> > > >> Hi,
> > > >>
> > > >> On 26-Jun-25 20:48, Dmitry Torokhov wrote:
> > > >>> On Thu, Jun 26, 2025 at 01:20:54PM -0500, Mario Limonciello wrote=
:
> [...]
> > > >>>> I want to note this driver works quite differently than how ACPI=
 power
> > > >>>> button does.
> > > >>>>
> > > >>>> You can see in acpi_button_notify() that the "keypress" is only =
forwarded
> > > >>>> when not suspended [1].  Otherwise it's just wakeup event (which=
 is what my
> > > >>>> patch was modeling).
> > > >>>>
> > > >>>> https://github.com/torvalds/linux/blob/v6.16-rc3/drivers/acpi/bu=
tton.c#L461
> > > >>>> [1]
> > > >>>
> > > >>> If you check acpi_button_resume() you will see that the events ar=
e sent
> > > >>> from there. Except that for some reason they chose to use KEY_WAK=
EUP and
> > > >>> not KEY_POWER, oh well. Unlike acpi button driver gpio_keys is us=
ed on
> > > >>> multiple other platforms.
> > > >>
> > > >> Interesting, but the ACPI button code presumably only does this on=
 resume
> > > >> for a normal press while the system is awake it does use KEY_POWER=
, right ?
> > > >
> > > > Yes. It is unclear to me why they chose to mangle the event on wake=
up,
> > > > it does not seem to be captured in the email discussions or in the =
patch
> > > > description.
> > >
> > > I assume they did this to avoid the immediate re-suspend on wakeup by
> > > power-button issue. GNOME has a workaround for this, but I assume tha=
t
> > > some userspace desktop environments are still going to have a problem
> > > with this.
> >
> > It was done for this reason IIRC, but it should have been documented
> > more thoroughly.
>
> I assert that it should not have been done and instead dealt with in
> userspace. There are numerous drivers in the kernel emitting
> KEY_POWER. Let userspace decide how to handle this, what keys to ignore,
> what keys to process and when.

Please see my last message in this thread (just sent) and see the
changelog of commit 16f70feaabe9 ("ACPI: button: trigger wakeup key
events").

This appears to be about cases when no event would be signaled to user
space at all (power button wakeup from ACPI S3).

