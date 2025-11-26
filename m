Return-Path: <linux-acpi+bounces-19288-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C989C8AA5F
	for <lists+linux-acpi@lfdr.de>; Wed, 26 Nov 2025 16:31:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 20ECE4ECC3A
	for <lists+linux-acpi@lfdr.de>; Wed, 26 Nov 2025 15:30:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DE85334C23;
	Wed, 26 Nov 2025 15:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R5nHoSvf"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE2213346AC
	for <linux-acpi@vger.kernel.org>; Wed, 26 Nov 2025 15:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764171041; cv=none; b=VufaRsHqAkpcNcHjtQZmBOM7nLRkx2LvXFoDKFRNvMWCGTuVdK/Ymhejpn+oPDjv/zudwGVRjobwhFeWvLjYRzcMQWBHnyXIvdwU/wlei5iTfaOYhaa2c7CRT4nOrUTHwBdtCVoqRA6LkmwTwx4/9DBuG3LyHXHYKY3rRXBB3pk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764171041; c=relaxed/simple;
	bh=AL4+u4zGisiIpXIqMeyOJ5kI78V+xcnNC5TegiadrfI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qhm31q5eJr4cFQ+Tvtstza9+MpqrzvpZM6gZv2Ck2Ao1JXkNb0OFCvYYLGnLeN7NcHMTmDcTn+27QNbo1ABpH+GsutWS+2ZxhwCJ8dA+SdDFap6jfAXFDbz3TrndbmBdXKMHrnJ2ad7LuHw5llb7bb4upIepn1aw/d64WL4svJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R5nHoSvf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76F8FC16AAE
	for <linux-acpi@vger.kernel.org>; Wed, 26 Nov 2025 15:30:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764171041;
	bh=AL4+u4zGisiIpXIqMeyOJ5kI78V+xcnNC5TegiadrfI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=R5nHoSvf8AZweQmeLZn+A6e/74IR5jIQ6vKk6bVdKCLjN+RBKBEiz3S9yvAgdnedB
	 HgBP/wH+b9UA3GasdgNrM2xz+GxLjCYX/PT8cj4lBvGSYuIfXW3TbkqmuBMjxWLN8v
	 4HG7v+X6T7FR8ngMWGTZB05HRUqqdtsWnTsYAhrGOWrftIQx9ZcNFk87g+XhP7VaoT
	 OTNH4DE6nekhLpDVOkpp7a8aONg4gRMQJdkstQF2qaP0VUh514CzrMkNA8fBspCnsa
	 PIPuMdhqZH0Zsd5peo8j5aR8nOXpIwbDWYko8TE4SwxXk9BGCQJ/15TE2MZ6nl/Ga0
	 9B9f2s5XGF45A==
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-65752954c43so354962eaf.0
        for <linux-acpi@vger.kernel.org>; Wed, 26 Nov 2025 07:30:41 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCV7laIFYKTpfIQe/HlrD+Ha3HNeZyrRC0JZpGHVqBJYD6nSEaGLvz8j+UF8mf9gZyWOMiQxVIzjMI19@vger.kernel.org
X-Gm-Message-State: AOJu0YwOgAn4Cms5cMmPN/ZimFsHaY+uYXzwgvHGYY48GG9UHQtQaZeK
	FMkUXdfuOXDutVY9x8x/J864kFjOduyk8hf+94uUeFCbSjRsAd885YBlgA7mQWIumNK+yruVVR3
	g4v7xv6RAWaNMuIM6V4MsjMyb477OgeI=
X-Google-Smtp-Source: AGHT+IGdgnc6SytshH8C9GXCbSahgpEnJ+GZfNMhdcp21A3XBCQHu5NmiycJYyAduQQWHwEl4VAke90LbrY/kepUSe0=
X-Received: by 2002:a05:6820:4d08:b0:657:59a8:5611 with SMTP id
 006d021491bc7-65790cbb039mr7182529eaf.0.1764171040747; Wed, 26 Nov 2025
 07:30:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251125.182654.1292605389516841541.rene@exactco.de>
 <CAJZ5v0jiZCxHJCXMXjBtQuPZzDzJyjYwBXTkq5Girj05CwxoNA@mail.gmail.com> <20251126.162038.2015308014407369467.rene@exactco.de>
In-Reply-To: <20251126.162038.2015308014407369467.rene@exactco.de>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 26 Nov 2025 16:30:28 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0jghThGMLrQQPA8cYhD8pePXJDa71H4EJRx_as+YTHCDA@mail.gmail.com>
X-Gm-Features: AWmQ_bmNR8TsKP2-laV1Q1vuRFmMHANQNjFrilKdoaMfscNju2qJJ6t970n0KfU
Message-ID: <CAJZ5v0jghThGMLrQQPA8cYhD8pePXJDa71H4EJRx_as+YTHCDA@mail.gmail.com>
Subject: Re: [PATCH] ACPI: processor_core: fix map_x2apic_id for amd-pstate
To: =?UTF-8?Q?Ren=C3=A9_Rebe?= <rene@exactco.de>
Cc: rafael@kernel.org, linux-acpi@vger.kernel.org, ray.huang@amd.com, 
	bp@alien8.de, x86@kernel.org, tglx@linutronix.de, superm1@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 26, 2025 at 4:20=E2=80=AFPM Ren=C3=A9 Rebe <rene@exactco.de> wr=
ote:
>
> Hi,
>
> On Wed, 26 Nov 2025 13:19:30 +0100, "Rafael J. Wysocki" <rafael@kernel.or=
g> wrote:
>
> > In the first place, this is an x86 patch, so it would be good to CC
> > the x86 list (CCed now).
>
> Sorry I missed the list.
>
> > > Fix amd-pstate w/ x2apic on am4 by removing the device_declaration
> > > check in map_x2apic_id(), likewise.
> >
> > It looks like on your system Processor statements have been used for
> > declaring the CPUs in the ACPI namespace instead of processor device
> > objects (which should have been used).  CPU declarations via Processor
> > statements were deprecated in ACPI 6.0 that was released 10 years ago.
> > They should not be used any more in any contemporary platform
> > firmware.
>
> Yes, I know. I tried to contact Asus multiple times, but never
> received a reply nor did any BIOS update ever change this.
>
> I only wanted to finally sent upstream what we shipped for years.

Please add the above information to the changelog, it is relevant.

> > This change goes a bit too far because some acpi_id values are only
> > valid when the CPU is declared as a processor device.
> >
> > Does the attached patch also fix the issue?
>
> Yes, thanks. The only point of this -I guess- is to enforce vendors to
> use the right declaration for big server boards?

No, it's just not guaranteed to function properly if the number is
above 254 in the Processor statement declaration case.

> We better use <=3D 255 just in case?

No, it needs to be < 255.

> Will sent v2.

OK

