Return-Path: <linux-acpi+bounces-14765-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1558CAEB51E
	for <lists+linux-acpi@lfdr.de>; Fri, 27 Jun 2025 12:38:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E10221886E4A
	for <lists+linux-acpi@lfdr.de>; Fri, 27 Jun 2025 10:36:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEA0F260580;
	Fri, 27 Jun 2025 10:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SQ7JVzZp"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D0FC218EB7;
	Fri, 27 Jun 2025 10:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751020581; cv=none; b=hpLsalo4M4EQ4dYD0bCtjBZdRVLxXrCPkd+f9USfv2Wlsyl2gcciLn2pyMv8YJ16ZMa2y1lfweCyDHnBQDgRA4qrqaPXPyWqGQGRhexOmcisLp4vJsOIEk9p2vvvtSTCHllrNGjoVY9szj4NPtkWuqtoev6D5j1/iYtqfc5jFZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751020581; c=relaxed/simple;
	bh=kO3872BVzA02twHz/sfwpKmHU+07ZekQm+EfNqZ0pF0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o3mhKmNYSBuy3WqCSTCvBKFpFvowEosGCcXDNnpVP9lX2ayMMSZFbBB5XhDRhUNUqEb5ewOAgjTiU+GxInM0XVcAzL4Zv5KRNsU+vZJxFajuvAGYwdKczI5JPvynrUYZhBBoQECs0VVLvGPtilY35cyCyGY/pGltmcCn7BGdhmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SQ7JVzZp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31C2AC4CEE3;
	Fri, 27 Jun 2025 10:36:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751020581;
	bh=kO3872BVzA02twHz/sfwpKmHU+07ZekQm+EfNqZ0pF0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=SQ7JVzZphl/F+DcZ2pCUWODg8XFaiB5ol4vBa+nlXUwCibD4NJsXeH6rCu3/JCgcB
	 ltigztharDmY43s2dgmFiJu6OuMCVHGscNQcjVWgbTp4/gd6iSDptnkxFazNXIxjRf
	 2D45xPZRd4FY/7lKoOMsKQyjd2fXuIGM/VKE+gJP0AXKvo7/wp92PjqRWE7XltY/Fn
	 2QZARnsJMi5lPy0odx2V1cg61x+FynTg9UqdEa030YmGB72TN+cw1ovM4rLOFAV9Ki
	 OkiJhryWxgAw71AT7yKWqoDEbLEIAjSxM5+J/in88DM+SloSD4VKg9JDVnKqESZFw2
	 hgyZ7raqzoQMA==
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-407aac76036so1216046b6e.1;
        Fri, 27 Jun 2025 03:36:21 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVIVf3xI47kuzS83q/DqQ4RZuXpc3DLklVaCoh4GnG8RNb1VsMlfPRQYSaVkD2FidVCWjZVXUlhnQsSyg==@vger.kernel.org, AJvYcCVwV3g61mg+HU4VErx9q1NMvHZ9auhxLaxbtAyCfMhx2ih6dCr1wnWwBuKXwo5Da3yQkJL+IeLdlx7V@vger.kernel.org, AJvYcCWAg8xjeZNTkz4g2o2EA/u70I5TUmdb4y+MtaDlxDxQGumpVGVzfel/TL2ECclvW2rRC2wldltAlNXhVJ0=@vger.kernel.org, AJvYcCXholl0Ja3C9XPdYEgronvlkmXpflXufROeQrl7agBOMDbPFzZvDLNhTTPvkmpLVvpgo1u1SuT2hpD3JWxL@vger.kernel.org
X-Gm-Message-State: AOJu0YykdrFTi6aaGxDVy7rVkxONNcvQjkkRP7r3qPz9Xxe2NADPMlYQ
	R8VBw6Ik2QQotefEyc9NiIW5pXzWtO/sS9bX0e1gW37A90/p1y4UQrW3rq0pPNYQOvXX6FKJf+X
	fBAT7r0XLEnYmtu3VcN/dkkKreTctuv8=
X-Google-Smtp-Source: AGHT+IEPLCCHKzTYLnBFG79n5+ueesNFsLXqdjZKx+8LwesqcPzYaes+O6ZfjNjAPyDfBVNjPvHhLVKn/PzciG8HJ9I=
X-Received: by 2002:a05:6820:4b95:b0:611:b1c7:23f with SMTP id
 006d021491bc7-611b912ea1bmr1492281eaf.0.1751020580470; Fri, 27 Jun 2025
 03:36:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <363c2b92-4bfc-4537-9fca-025eef09526f@kernel.org>
 <nxticocp26r5mmpkttritw76h5igw7bdpus6zaf5krkso2h5xy@wna6m2quekfi>
 <cbbf0caf-82ce-4427-9844-b11e0f5cacdb@kernel.org> <obpakvzyludc4jskqzyxf65dhqds7ie3jkbfsqdve32ouuaili@xvogkmwvbmbf>
 <284ea5c0-dca5-4e9e-a3e7-705eca794010@kernel.org> <vkau25ybcx3bcoa2jmxlukumunzii5h6em43anh6mmzk2kyiv7@kyych4kxc4zo>
 <0d71a686-da67-4686-8976-a17d0d1ca923@kernel.org> <CAJZ5v0gKUN1OdqAHnXNcFUAOfhpdRfa_o=L6TA2GZTpe1bMaNQ@mail.gmail.com>
 <exmgckzoakt2ncsdphqvymcadon7k6tl36a3zvrj2pv23dffps@znq23v3qbcm2>
 <CAJZ5v0j3ZyuEqSKQ+3K8M3BwPCxn5Z6KOwjyjt4cJW6HfxjPDw@mail.gmail.com> <hyvpl4gvxc6h2r3itfofjduwb3vpobyo7a7z6g3zapzscqtafh@ixsd4amyljva>
In-Reply-To: <hyvpl4gvxc6h2r3itfofjduwb3vpobyo7a7z6g3zapzscqtafh@ixsd4amyljva>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 27 Jun 2025 12:36:07 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0i20Qjxw=GAc-PTHL8U5kq-zsDR2fWcp9dbrkF6PbRBqw@mail.gmail.com>
X-Gm-Features: Ac12FXzNSwYReMMR0zsZk6Mer1g6ucUqMElqdVkF9OF_k1D4_YYY3bAYiHJyoF8
Message-ID: <CAJZ5v0i20Qjxw=GAc-PTHL8U5kq-zsDR2fWcp9dbrkF6PbRBqw@mail.gmail.com>
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

On Thu, Jun 26, 2025 at 9:40=E2=80=AFPM Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
>
> On Thu, Jun 26, 2025 at 09:31:12PM +0200, Rafael J. Wysocki wrote:
> > On Thu, Jun 26, 2025 at 9:28=E2=80=AFPM Dmitry Torokhov
> > <dmitry.torokhov@gmail.com> wrote:
> > >
> > > On Thu, Jun 26, 2025 at 09:18:56PM +0200, Rafael J. Wysocki wrote:
> > > > On Thu, Jun 26, 2025 at 9:16=E2=80=AFPM Hans de Goede <hansg@kernel=
.org> wrote:
> > > > >
> > > > > Hi,
> > > > >
> > > > > On 26-Jun-25 21:14, Dmitry Torokhov wrote:
> > > > > > On Thu, Jun 26, 2025 at 08:57:30PM +0200, Hans de Goede wrote:
> > > > > >> Hi,
> > > > > >>
> > > > > >> On 26-Jun-25 20:48, Dmitry Torokhov wrote:
> > > > > >>> On Thu, Jun 26, 2025 at 01:20:54PM -0500, Mario Limonciello w=
rote:
> > > [...]
> > > > > >>>> I want to note this driver works quite differently than how =
ACPI power
> > > > > >>>> button does.
> > > > > >>>>
> > > > > >>>> You can see in acpi_button_notify() that the "keypress" is o=
nly forwarded
> > > > > >>>> when not suspended [1].  Otherwise it's just wakeup event (w=
hich is what my
> > > > > >>>> patch was modeling).
> > > > > >>>>
> > > > > >>>> https://github.com/torvalds/linux/blob/v6.16-rc3/drivers/acp=
i/button.c#L461
> > > > > >>>> [1]
> > > > > >>>
> > > > > >>> If you check acpi_button_resume() you will see that the event=
s are sent
> > > > > >>> from there. Except that for some reason they chose to use KEY=
_WAKEUP and
> > > > > >>> not KEY_POWER, oh well. Unlike acpi button driver gpio_keys i=
s used on
> > > > > >>> multiple other platforms.
> > > > > >>
> > > > > >> Interesting, but the ACPI button code presumably only does thi=
s on resume
> > > > > >> for a normal press while the system is awake it does use KEY_P=
OWER, right ?
> > > > > >
> > > > > > Yes. It is unclear to me why they chose to mangle the event on =
wakeup,
> > > > > > it does not seem to be captured in the email discussions or in =
the patch
> > > > > > description.
> > > > >
> > > > > I assume they did this to avoid the immediate re-suspend on wakeu=
p by
> > > > > power-button issue. GNOME has a workaround for this, but I assume=
 that
> > > > > some userspace desktop environments are still going to have a pro=
blem
> > > > > with this.
> > > >
> > > > It was done for this reason IIRC, but it should have been documente=
d
> > > > more thoroughly.
> > >
> > > I assert that it should not have been done and instead dealt with in
> > > userspace. There are numerous drivers in the kernel emitting
> > > KEY_POWER. Let userspace decide how to handle this, what keys to igno=
re,
> > > what keys to process and when.
> >
> > Please see my last message in this thread (just sent) and see the
> > changelog of commit 16f70feaabe9 ("ACPI: button: trigger wakeup key
> > events").
> >
> > This appears to be about cases when no event would be signaled to user
> > space at all (power button wakeup from ACPI S3).
>
> Ahh, in S3 we do not know if we've been woken up with Sleep or Power
> button, right? So we can not send the "right" event code and use
> "neutral" KEY_WAKEUP for both. Is this right?

Yes, it is, AFAICS.

