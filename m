Return-Path: <linux-acpi+bounces-12238-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DA295A60F32
	for <lists+linux-acpi@lfdr.de>; Fri, 14 Mar 2025 11:40:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C9481189FC0F
	for <lists+linux-acpi@lfdr.de>; Fri, 14 Mar 2025 10:40:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AD8A1FA166;
	Fri, 14 Mar 2025 10:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Su4qZL8q"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 047F61F8EF7
	for <linux-acpi@vger.kernel.org>; Fri, 14 Mar 2025 10:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741948836; cv=none; b=rMYiRGRBJ/RQXfUtPWhLVvOGVKdIJJsZWwcWlR8pGJWxb4KOZn+lxA/44IS5nR8TzecEerCyVZbokxcoN0Bbbw3+klyFOUVFs3e8UFDUu3kx5gnNiobhJaeUJ+IL+Fs5UtXN41HB73hRNvs5R69M6IZskz5O87FfARbLj3cP6EQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741948836; c=relaxed/simple;
	bh=xch7e8LPim/yqidNWA6H8YE/y5EjKG5Qvztbk60pA2Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LuQ5X8c7thpwOQ06nYj58HASa5QUT6gJL/LcLagyi5TUm3ABccGmlG1s81Js0KONVzLR1ci/QvsH6Q3Sg3s8uuO7/oUnVHv/39amdPbBH4Hn2Xmv8Oy69i+5LA/+2vQe2F6kR0f9E206nYSf7b6FtVfQ7ucZ0uHYTkgLnRQWF5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Su4qZL8q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CC5CC4CEE3
	for <linux-acpi@vger.kernel.org>; Fri, 14 Mar 2025 10:40:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741948835;
	bh=xch7e8LPim/yqidNWA6H8YE/y5EjKG5Qvztbk60pA2Y=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Su4qZL8qhKJFLWJxtffTh8W0fNoa7J5IKjXDxF3TbPBEWq11tsyYb15zzxSwt5vpr
	 v8SJjzPFG//u0C9uRqw9FES7P6Sc/qHIKKSpJubRZDrE3CinObp+dvX71+Q1ZfGfLn
	 Z57kpidFgkDzty/MVkVfmFYi74Ikvp9TtXYwupXE8bD6Ck3FVlKGRCliZ4HbsvjukK
	 djFoQptedLnrhMmQCXvAbKxjIShxLENkDaQK31kydunFhtQRXWBrEE4VEMcL0eSk/6
	 A+uQXr8HWTsK9CyeEfTlxNk+7x2IzmbQj1I6JB5053c1tV6R8+ppmm1SFqKVMkEi6U
	 f1P6kxOdC+QEw==
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-2a88c7fabdeso1465519fac.1
        for <linux-acpi@vger.kernel.org>; Fri, 14 Mar 2025 03:40:35 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWqf7u6JyMOFtL8gAFwVPrcgnANDaTprOPlIjte9b1uKXwHsiDD10guGka0KWUccnC78ANnPS9GKYBA@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7auJKF8HyaJWTtsONtyIwPR4E7qN4Yoo3bQ/LXFwmjXo2oMVM
	HrHIeoQyJDc5/wRgbbkaNzPQKeh4v1y/wxLxwkSYMzF3P3n+o6x75oWVAXBRawvAi4/UNYaNsLz
	B3Fujdxdpgpe/xzncGTmFQZjA8DI=
X-Google-Smtp-Source: AGHT+IG4NEpHNQGZ9oR/1ppGV/ZINmbIETR7/eDgOXyKEZUsgEYHkFx4aZBoEFh24UeygrpOVDluDVwzRlXn0ZUs7A4=
X-Received: by 2002:a05:6870:f725:b0:297:24ad:402f with SMTP id
 586e51a60fabf-2c690f4f362mr924182fac.12.1741948834668; Fri, 14 Mar 2025
 03:40:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <90e6da7b-a2b2-4ff3-bb04-f39b1f6c5e70@app.fastmail.com>
 <CAJZ5v0jH99jkZrsE-Ne---FwPcaOSThL+TEL0BP_w+QXaKng0g@mail.gmail.com> <9fb371c9-420d-4d45-9b6d-d213f87064d6@app.fastmail.com>
In-Reply-To: <9fb371c9-420d-4d45-9b6d-d213f87064d6@app.fastmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 14 Mar 2025 11:40:22 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0hZ6MoOqE-8LsZvABsA3d+DoL5Akis+w+GMNo3VOw+xmw@mail.gmail.com>
X-Gm-Features: AQ5f1JoAsWHgHx9AbowkSm8nahsaFVGfucK5TxTsY_YItWd600FqWv8ji_Gqh0A
Message-ID: <CAJZ5v0hZ6MoOqE-8LsZvABsA3d+DoL5Akis+w+GMNo3VOw+xmw@mail.gmail.com>
Subject: Re: 6.14.0-rc debug kernel is slow, kacpi_notify high cpu usage
To: Chris Murphy <chris@colorremedies.com>
Cc: Rafael Wysocki <rafael@kernel.org>, linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 14, 2025 at 4:50=E2=80=AFAM Chris Murphy <chris@colorremedies.c=
om> wrote:
>
>
>
> On Thu, Mar 13, 2025, at 9:35 AM, Rafael J. Wysocki wrote:
> > On Thu, Mar 13, 2025 at 5:12=E2=80=AFAM Chris Murphy <chris@colorremedi=
es.com> wrote:
> >>
> >> Four kacpi_notify kernel threads are continuously using CPU, makes the=
 laptop warm,
> >> fans run continuosly. This is a Fedora debug kernel, it's not intended=
 for production.
> >> But I'm wondering if this performance hit is expected and if it's wort=
h it (for kernel developers).
> >
> > No and no.
>
> Is it a firmware or kernel bug? Any other info I should provide?

It may not be a bug.

Additional computational overhead related to debug options may
increase power and temperature which would increase the rate at which
events are generated which would increase the overhead and so on.

> I updated the firmware to the latest firmware, but the behavior is unchan=
ged. I'm not sure what
> kernel config might be responsible for this, so I'm not sure what to sugg=
est to the kernel team
> to make the performance hit go away.

It's hard to say, something that would add overhead to the processing
of firmware events.

> > kacpi_notify is only used for Notify() processing which only happens
> > when there are events signaled by the platform firmware.  Like battery
> > or thermal events, for example.
>
> It seems to happen more often than not, happens with AC power connected o=
r not.

I would look at the counters in /sys/firmware/acpi/interrupts and
compare the debug case with the non-debug one.  If the counters
generally grow faster in the debug case, more events are signaled and
that would be the reason for the increased load.

Then you can try to figure out which events are involved in this (but
ACPI tables inspection would be necessary I think).

