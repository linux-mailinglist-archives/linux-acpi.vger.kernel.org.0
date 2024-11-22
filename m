Return-Path: <linux-acpi+bounces-9761-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76B0D9D6491
	for <lists+linux-acpi@lfdr.de>; Fri, 22 Nov 2024 20:27:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1134EB22036
	for <lists+linux-acpi@lfdr.de>; Fri, 22 Nov 2024 19:27:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 445361DF96A;
	Fri, 22 Nov 2024 19:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O54sxMbF"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FA0364A8F;
	Fri, 22 Nov 2024 19:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732303666; cv=none; b=g38kliOnTp5bjLr269E8gZBz5QLJQ9rPwhpOaJq2alUN8SHfiKQB6v13OR4sIAFuKbfCQCXMdj9Oqg8hwTJ1LTootFEK7ENEF1XWDxNsF0MMlsYl4excVfrBfjK8Mj14KbEnzSS8kUubvY51NUtyS/k7sQSeEnsAlqLJhU2C/vI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732303666; c=relaxed/simple;
	bh=yguWofAVWAk41J3X5cJbVOW9/dPsoPltgyhYgkTdtNs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TpgKJFREWffzdCHpNEpv6jj0YZel0/eead/zSzj4dHqjTUXutIyc2lnkFT/uEXFLWw0i7Sv7V+qm3MdePZtyC5oTuhZOW6YTRad9BFwub182mqmZJNpw6wQvDzzn252w4g/MsPCMQjJUp59wXq/HkKlYRXnXAp+ajLdrguIS7nQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O54sxMbF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC52AC4CED7;
	Fri, 22 Nov 2024 19:27:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732303665;
	bh=yguWofAVWAk41J3X5cJbVOW9/dPsoPltgyhYgkTdtNs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=O54sxMbFoHRVAVs7VcZotltbPtUm1VGWvNoUHw4DPg2ODwVYY6QkpQjXfXQ7misB+
	 nEJkikH25Ns40iQfM0Uqx4GYbnHXCOm9gRNgOZZHCbCqREAYXp09/TFt3YlCguevlr
	 fPotLZEBu5myYOx48RSuIQ8Nv1Dw3c7bPNsXAug7D9OK5opCGlRmo+6Y2hoav09tuF
	 CgLeh5qEVEI1LwvYWzjYB1dN+6kAg76xk6bkygmLhZnKWSyC/t/7viDYM/XAn7eogg
	 YMojhZe5+fe8GpVmTHmFavGU7DOyuCB4IZFHwD776ru0Ae17WlOLzbmmtd/x1kCvV5
	 ISelCto6yQe2A==
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-296994dd3bfso1642909fac.0;
        Fri, 22 Nov 2024 11:27:45 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVLJKQ260GdCYRS6uiAOH0WesXzBFAAx6r7tvieSHZNKxpgQTGN4VaocsbODZT3RUNm0j6s8CZRCws=@vger.kernel.org, AJvYcCWJb/X0vsy+pf9tD3l/3Km9MSUz29pWUjrk/L5CiBHxhD8Tngx5e2PhQLLuIX5k/wO0XE+LXnQrmgP4@vger.kernel.org, AJvYcCXtnPil95js2CklVPo9JysdSsXiw+ud0NuzO49uqQ+70rkBGeRZ427him6mI5iP4T+vmHPAsaEzADI7czrn@vger.kernel.org
X-Gm-Message-State: AOJu0YyFUoQIBwjeMyUBfby4FJ6LBpj7yj07o9XvkMtUtKPMP+3DMSKU
	c6Fe4+m58pIdfQ3w7Ts44N9ISgAYvOR0ZzYkooy7OwVJ8ID8hH/x5/K1vMxs9XfEdHH+xi+D55T
	HKo3tviSChDZTYm7VL29owr9KqI8=
X-Google-Smtp-Source: AGHT+IGB8hg7lTSwwMDovfIEQoAKW7Y09+fDewSPgzj/Id1opr5d05VkEngC9LnrhggJ31OIWfQcA8qPRZWvSPigA44=
X-Received: by 2002:a05:6870:46a2:b0:296:cdee:f7de with SMTP id
 586e51a60fabf-29720c33a6fmr4725047fac.21.1732303665039; Fri, 22 Nov 2024
 11:27:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <5839859.DvuYhMxLoT@rjwysocki.net> <e7ac7561-f9ff-406a-b2d7-6d9e31ed6e98@amd.com>
In-Reply-To: <e7ac7561-f9ff-406a-b2d7-6d9e31ed6e98@amd.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 22 Nov 2024 20:27:32 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0jTxBt8+bc+EgUZmE84N+Vok_aM16D8HyLQUv=BSoqRCw@mail.gmail.com>
Message-ID: <CAJZ5v0jTxBt8+bc+EgUZmE84N+Vok_aM16D8HyLQUv=BSoqRCw@mail.gmail.com>
Subject: Re: [RFC/RFT][PATCH v0.1] ACPI: OSL: Use usleep_range() in acpi_os_sleep()
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux ACPI <linux-acpi@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, 
	Len Brown <len.brown@intel.com>, Arjan van de Ven <arjan@linux.intel.com>, 
	Pierre Gondois <pierre.gondois@arm.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Hans de Goede <hdegoede@redhat.com>, "Gautham R. Shenoy" <gautham.shenoy@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 21, 2024 at 11:27=E2=80=AFPM Mario Limonciello
<mario.limonciello@amd.com> wrote:
>
> On 11/21/2024 07:15, Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > As stated by Len in [1], the extra delay added by msleep() to the
> > sleep time value passed to it can be significant, roughly between
> > 1.5 ns on systems with HZ =3D 1000 and as much as 15 ms on systems with
> > HZ =3D 100, which is hardly acceptable, at least for small sleep time
> > values.
> >
> > Address this by using usleep_range() in acpi_os_sleep() instead of
> > msleep().  For short sleep times this is a no-brainer, but even for
> > long sleeps usleep_range() should be preferred because timer wheel
> > timers are optimized for cancellation before they expire and this
> > particular timer is not going to be canceled.
> >
> > Add at least 50 us on top of the requested sleep time in case the
> > timer can be subject to coalescing, which is consistent with what's
> > done in user space in this context [2], but for sleeps longer than 5 ms
> > use 1% of the requested sleep time for this purpose.
> >
> > The rationale here is that longer sleeps don't need that much of a time=
r
> > precision as a rule and making the timer a more likely candidate for
> > coalescing in these cases is generally desirable.  It starts at 5 ms so
> > that the delta between the requested sleep time and the effective
> > deadline is a contiuous function of the former.
> >
> > Link: https://lore.kernel.org/linux-pm/c7db7e804c453629c116d508558eaf46=
477a2d73.1731708405.git.len.brown@intel.com/ [1]
> > Link: https://lore.kernel.org/linux-pm/CAJvTdK=3DQ1kwWA6Wxn8Zcf0OicDEk6=
cHYFAvQVizgA47mXu63+g@mail.gmail.com/ [2]
> > Reported-by: Len Brown <lenb@kernel.org>
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> You probably should also pick up this tag from the earlier version.
>
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=3D216263

Good point.

> > ---
> >
> > This is a follow-up to the discussion started by [1] above and since
> > the beginning of it I have changed my mind a bit, as you can see.
> >
> > Given Arjan's feedback, I've concluded that using usleep_range() for
> > all sleep values is the right choice and that some slack should be
> > used there.  I've taken 50 us as the minimum value of it because that's
> > what is used in user space FWICT and I'm not convinced that shorter
> > values would be suitable here.
> >
> > The other part, using 1% of the sleep time as the slack for longer
> > sleeps, is likely more controversial.  It is roughly based on the
> > observation that if one timer interrupt is sufficient for something,
> > then using two of them will be wasteful even if this is just somewhat.
> >
> > Anyway, please let me know what you think.  I'd rather do whatever
> > the majority of you are comfortable with.
>
> Generally I'm fine with this.
>
> I'm about to head on US holiday, but I will forward this to folks that
> aren't and get some testing input on it to bring back later when I'm back=
.

Thanks!

