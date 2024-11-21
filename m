Return-Path: <linux-acpi+bounces-9718-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A31A69D52F0
	for <lists+linux-acpi@lfdr.de>; Thu, 21 Nov 2024 19:57:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4FFAD1F21040
	for <lists+linux-acpi@lfdr.de>; Thu, 21 Nov 2024 18:57:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 145A91DF241;
	Thu, 21 Nov 2024 18:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wl4dlbvG"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C642F1DEFEC;
	Thu, 21 Nov 2024 18:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732215207; cv=none; b=WrgJFFXY+1jiYWRFEDnK7GoeW8++V/FvW0tYUD5Q8Ow9I4TZZT1cJP6WEV3riwqwsTUHRvbrjkNdSLbXWRDHipebBX6iflLs2f3h1fK9YJ0U8L3CZsLrTNBAWMBl02dG8Y7KyarAOtuAfLmIRYx4ajiG2Tio7gXTId5ZHJPPuuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732215207; c=relaxed/simple;
	bh=ISjpz16tj0pMaPVTqGRXpMKXe6yrcURvmS2MCnWb4ak=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DrIfKvnriPKcBQl4A0bvrIDIBTvdlVeL3wuc5ZnleuA9Qh9nisJmdg9Cggus2DT1bDMi3rYA1N6MpJoi9I8bWc7mKPxCfaIxQXZ2vg+8FmzzMaX0s/PcmJI8RpiQCgGMqtB8NgKd9mAqD3SPwoR3Ukst/nF3uC/Olnrm1S/NkVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wl4dlbvG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A904C4CED9;
	Thu, 21 Nov 2024 18:53:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732215207;
	bh=ISjpz16tj0pMaPVTqGRXpMKXe6yrcURvmS2MCnWb4ak=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Wl4dlbvGX2EJFcT1EWHmY5379pwIIfTV3DqZUSlbZ7j449cvDyfoD8MPEJqP7YjzR
	 ufepeqa9dpnItOD5t0FS7Yy2GH0BsP7ALyk0/ZnlwK3K3KfGXOdAtUMvBgdtvaAqoY
	 0QtWm7NahlsH7aqouRvFM5jLzwz8EZi6CuiQljXNnhom/9veYzAFDmfRBmTJ7A5znW
	 Na/tMTCs84XE+ele45Ivc2OvU2jiSmk2fIE3sipT6Wk7pC0iTLBMeox5ZveOAfx5VA
	 M4Y7fvkiLUz7Vqbd6XvtlSCIIphlRwFBMsiAGiI0Lc5KZBCR1WG5axt59NhI4tcHAd
	 RElHNodDUMuGQ==
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-29645a83b1bso800435fac.1;
        Thu, 21 Nov 2024 10:53:27 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUCPVgh0BVDFUqpsfr2IHRUKGRtGilRCBLxqZV6tzOhiDn3FM/+bZnZ3OPTIY+/Qd2TAyUR0XnaOkc=@vger.kernel.org, AJvYcCVsQ5c4OC0uDHE+ufMZqubU2dN2CV/ZzkJhmB0AtkbYMZvaas74ZuLCe64nZ77V0jLc1ZDZI1oaNIXq@vger.kernel.org, AJvYcCXQkJA0xvJQA5uroJZuUk06qaEm1CCGrmPIBkBWO2EL4cWW3HrV2CVpvLMj23zemZs6xYyu05X8hvf8FfzZ@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3JQeCRGq5PWPFYfXiRBbUcrUuatSaTxO3hpnogH2yuUg44OBM
	H8P3SuNPCDrmF9HY0/nVIFSS2WeF3eV25V0sZ6h1VLUzSdTc1MCSjoFVbhuyW8TqkeWdorTCLxd
	nlRuT4CwO3mNfqBPUTd6VAbVlBzk=
X-Google-Smtp-Source: AGHT+IH6JQQDAWOq0KJApgEVmyvmkM5BYck8OWF+z5HxxudO9rCrA2umFvpP9kP8iaqImRdQHBtzEOxj0VtzzlfZpi0=
X-Received: by 2002:a05:6870:218d:b0:284:ff51:58ad with SMTP id
 586e51a60fabf-296d9fb2cf8mr9632663fac.27.1732215206334; Thu, 21 Nov 2024
 10:53:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <5839859.DvuYhMxLoT@rjwysocki.net> <c6315bb7-2943-4693-899b-da65cfecc7a6@redhat.com>
In-Reply-To: <c6315bb7-2943-4693-899b-da65cfecc7a6@redhat.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 21 Nov 2024 19:53:15 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0jvFD5ObM4iT7zT0G-VWZ7kR2_D0d=vmcBmausNv71hEA@mail.gmail.com>
Message-ID: <CAJZ5v0jvFD5ObM4iT7zT0G-VWZ7kR2_D0d=vmcBmausNv71hEA@mail.gmail.com>
Subject: Re: [RFC/RFT][PATCH v0.1] ACPI: OSL: Use usleep_range() in acpi_os_sleep()
To: Hans de Goede <hdegoede@redhat.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux ACPI <linux-acpi@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, 
	Len Brown <len.brown@intel.com>, Arjan van de Ven <arjan@linux.intel.com>, 
	Pierre Gondois <pierre.gondois@arm.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Mario Limonciello <mario.limonciello@amd.com>, "Gautham R. Shenoy" <gautham.shenoy@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 21, 2024 at 7:39=E2=80=AFPM Hans de Goede <hdegoede@redhat.com>=
 wrote:
>
> Hi,
>
> On 21-Nov-24 2:15 PM, Rafael J. Wysocki wrote:
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
> I know it is a bit early for this, but the patch looks good to me, so:
>
> Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Thank you!

