Return-Path: <linux-acpi+bounces-6469-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F8E290BABF
	for <lists+linux-acpi@lfdr.de>; Mon, 17 Jun 2024 21:20:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D4037B2296F
	for <lists+linux-acpi@lfdr.de>; Mon, 17 Jun 2024 19:20:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7746B1990CF;
	Mon, 17 Jun 2024 19:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tp9eY0fB"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 479F81990BB;
	Mon, 17 Jun 2024 19:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718652029; cv=none; b=e2wFKwpXRfOTLhbqhtDeaDKhtiQp6uDkUUsAyvYKvEECcsRUC4MnSsztjUZpyxmRz4cxal2GCBXLivKLqECRo8w/c9BOtK94NV+iBsVgdM0OiH0chwPlC5rFZHKautluTjRWGSnaudzYko2dmcorrIl19tZBpqsVX793xmxLgSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718652029; c=relaxed/simple;
	bh=UwJilHooTAwCtU+8RqLCGxT+YJhIEjdBQnPptCGsoR4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jsSpOQ2v40QlbysOPIZp/QFR0xi0/n5Tt9IzNFQz8mY33iWFShlAXT11hh1YyW4h+z6lAzYxvIMjMhRdMKzJ4pbzQ99nnjZNpNFFonKXUkFoz7HgPKmJoMs5MUiGhW3B5frKlPSp1Q4Ea0KaS9ytGpRAG0FVp8nIZ++EpxMJJ04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tp9eY0fB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2FD3C4AF1A;
	Mon, 17 Jun 2024 19:20:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718652028;
	bh=UwJilHooTAwCtU+8RqLCGxT+YJhIEjdBQnPptCGsoR4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Tp9eY0fB9SepeWw16Iti4JBWXcxiRfFhGQLIt73eC2PY2IinXxz13N9YV2cCCP5Kk
	 K0EqSl9mvIolQVc9xZ025XmZscofYirEEnPXPNGz9iH3H4iLc5Qa/iUTVWOpq3yt4N
	 /cc3DiazhkJ4ZaNsTpIVkdl/+1K8/RMgukOk7Sskery3GtNovOQvxuK+ASM5Z//qEK
	 Fj5LMiYcOUhp1gYLnv1UXdUto7Ni4QlACCG3vLT5I2/M4rT9+VlmyrxY/7ZWIHp80M
	 XipWmXEsUP8wlv/a/uz9XoQy79m24ss2iNIFR30nHQZqlgjHIBEPiNCCLceEmuGG6g
	 /oXu1WoAAmopw==
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-5bb10cfe7daso353336eaf.2;
        Mon, 17 Jun 2024 12:20:28 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUoRCLrRydwwQ3EIB+x8SLK3F5xfPBgvEb+erRTB9JG1DH4lQAOnkODh9jSCAR3EoenZEplUDHwG3Od/S7fMO32riKIYYDwn7UCkqzEZvcW35YM2wSjXQZtUsJppTlAJqRky8g/K8dOWQ==
X-Gm-Message-State: AOJu0YwMFM9D453Oi5Q2ZWTqNDqPPSrnUZ8S6/8a4rbrOorlJJAp9tSb
	WTwBDADRhm9P9M/bmBAiQ63Yn8rGDOipja0akToR/PoQKX1li3sx7/0mOSr6oinadXIX/DciO2h
	LkaSA7hITUN7NYByCWNJioY9aHuo=
X-Google-Smtp-Source: AGHT+IH2PQAmWZtFODds934xH9e6nUDn8Ctc7ggQgfjQk4t+2XxjLNgMOo6P4Vimpri98e0hjJt660/Tr4OiwxX4KUQ=
X-Received: by 2002:a4a:c482:0:b0:5bd:ad72:15d3 with SMTP id
 006d021491bc7-5bdadc0905fmr11187991eaf.1.1718652028237; Mon, 17 Jun 2024
 12:20:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240613-acpi-sysfs-groups-v1-0-665e0deb052a@weissschuh.net>
 <20240613-acpi-sysfs-groups-v1-1-665e0deb052a@weissschuh.net>
 <CAJZ5v0iHB1X7WM6Lg_-vr3Kzwp65yqjvHG9CA_X8vqFBFV_F_A@mail.gmail.com>
 <CAJZ5v0gmHPBS3LE+Eo8yJkvpuavBvip-1AEEEf9nxAp2gi_adQ@mail.gmail.com> <7c0d3358-eb1f-4c71-8a09-52b5e7668e36@t-8ch.de>
In-Reply-To: <7c0d3358-eb1f-4c71-8a09-52b5e7668e36@t-8ch.de>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 17 Jun 2024 21:20:17 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0h2wuYi0JuKGKBy2x3h71FO_n8FNAAd+9XXekHGA9d=3w@mail.gmail.com>
Message-ID: <CAJZ5v0h2wuYi0JuKGKBy2x3h71FO_n8FNAAd+9XXekHGA9d=3w@mail.gmail.com>
Subject: Re: [PATCH 1/5] ACPI: sysfs: convert utf-16 from _STR to utf-8 only once
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
	Robert Moore <robert.moore@intel.com>, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, acpica-devel@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 17, 2024 at 8:57=E2=80=AFPM Thomas Wei=C3=9Fschuh <linux@weisss=
chuh.net> wrote:
>
> On 2024-06-17 20:43:03+0000, Rafael J. Wysocki wrote:
> > On Mon, Jun 17, 2024 at 8:37=E2=80=AFPM Rafael J. Wysocki <rafael@kerne=
l.org> wrote:
> > >
> > > On Thu, Jun 13, 2024 at 10:15=E2=80=AFPM Thomas Wei=C3=9Fschuh <linux=
@weissschuh.net> wrote:
> > > >
> > > > The ACPI _STR method returns an UTF-16 string that is converted to =
utf-8
> > > > before printing it in sysfs.
> > > > Currently this conversion is performed every time the "description"
> > > > sysfs attribute is read, which is not necessary.
> > >
> > > Why is it a problem, though?
>
> It's not a real problem, mostly it made the following changes simpler.
>
> > > How many devices have _STR and how much of the time is it used?
> > >
> > > Hint: On the system I'm sitting in front of, the answer is 0 and neve=
r.
> >
> > This was actually factually incorrect, sorry.
> >
> > The correct answer is 12 out of 247 and very rarely (if at all).
> > Which doesn't really change the point IMO.
> >
> > > So Is it really worth adding an _STR string pointer to every struct a=
cpi_device?
>
> The string pointer replaces a 'union acpi_object *str_obj', so no new
> space is used.
> Also in case the device _STR is present the new code uses less memory, as
> it doesn't need the full union and stores utf-8 instead of utf-16.
> (Plus a few more cycles for the preemptive conversion)
>
> In case no _STR is present both CPU and memory costs are identical.

OK

> Anyways, I don't really care about this and can also try to drop this
> patch if you prefer.
> Or drop the 'union acpi_device *' from the struct completely at your
> preference.

No, this is fine as is, thanks.

