Return-Path: <linux-acpi+bounces-19995-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 54F08CFD96E
	for <lists+linux-acpi@lfdr.de>; Wed, 07 Jan 2026 13:17:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3CEF4300E010
	for <lists+linux-acpi@lfdr.de>; Wed,  7 Jan 2026 12:14:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C55330CD85;
	Wed,  7 Jan 2026 12:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="INQYmICi"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 579F92EACEE
	for <linux-acpi@vger.kernel.org>; Wed,  7 Jan 2026 12:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767788089; cv=none; b=ITL+9vFeNooqzuBIUZaXqeBaeqbYw30T/RaQKTjMjZQV6oE3xuYNeCxargWrTfQjK1i6XXxAhAlcnX4ik0yqguFj9/BWfTWEbGFPDcx1Ku1uqN6+A5zz/RdoEjwPt/PLUeGqu6Jj5HbBlxQwm3L+lhYvPOrs4DK43dgV29PiteY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767788089; c=relaxed/simple;
	bh=R6NG5lJEQ8lMDs99NZnoSraWFaMN3KKFPc3wKZJMmRk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=e/GBZ+uUYiHYoePEkrPS7cE9kKIbPrMPZSwQDZ0KXrbXJtfRJC64c1lT6zbqnqlpCDSMD1pUwCcC2vJ/1ags/cuGRhhlFW/qXIJYXGmfd6KrIwMXA5BeVjNmikNExWEevQYctdMayjnRtFhrovkqmLqU6hgMJrSMuKZZ5oYN2fk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=INQYmICi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17277C4CEF7
	for <linux-acpi@vger.kernel.org>; Wed,  7 Jan 2026 12:14:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767788089;
	bh=R6NG5lJEQ8lMDs99NZnoSraWFaMN3KKFPc3wKZJMmRk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=INQYmICipylQxs+C59lMzeYYix0bMu2bcFIowP6dk8TBmQgvuoyAKd8ef7hBaCcu7
	 3YcZ30M3dNdiELMd9v57M/IB08u05NzDV0kCERtFuK+gaEf9yfY9gV9xvUfDWjA0Nk
	 WJ480QiqKE5QBnisGoeIZbI/l4BlGZeUiPsneWhQPGb6EH6cezTRHiaKpdCiKgIIGj
	 RCxyct8hmDIrmjxiGrI4lazj1pMnUTZI7eTO+SlLqTMRexpe213Gnr+RSW4eoRnxaN
	 bvRgRKwfZtB4eHCNcPhFmaAVjoOBwP7LjwHDjFhEIfiTJbVQzlftS0KGR3BULo9tpr
	 ZzmI8R8leNtlw==
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-65d0441b6feso1215140eaf.1
        for <linux-acpi@vger.kernel.org>; Wed, 07 Jan 2026 04:14:49 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUOlDQaKzz5Crv+EN/nirt7cf9KSYDKla4wH8n1FI5qHzFXyFjYHglpRWJCOXa6FUlZBiyM1aVTP0Vg@vger.kernel.org
X-Gm-Message-State: AOJu0YzkfP+OrHB5LCa1ZOrJprYW1VNmQ+YYteviMuA7tNh14+ypItZu
	iJbTNYMYjUBbnKHc+dYEicpD93DelW6uKt+JIqgOhiksznoxzg0bYn2jPv6aJdei7gLcn3CK5On
	MN6vI2ZjSbQ7gzYc4/xV4rmeND+wBJA0=
X-Google-Smtp-Source: AGHT+IEYGr57xBFxtjTLHXynW++EPc/6gFKE5ArUM1UmGgpdl0Yul1DdwjxReJHut3xklLgkEUiJe3WOQk3U+AGIDlM=
X-Received: by 2002:a05:6820:2298:b0:65b:3c3b:69a8 with SMTP id
 006d021491bc7-65f55082767mr908359eaf.44.1767788087976; Wed, 07 Jan 2026
 04:14:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2396510.ElGaqSPkdT@rafael.j.wysocki> <DFHK7ZS7H7LJ.1POCUDPSLC3CP@kernel.org>
In-Reply-To: <DFHK7ZS7H7LJ.1POCUDPSLC3CP@kernel.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 7 Jan 2026 13:14:35 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0gDXSdAy9wJYUc_yyHD-Y_tPk0eVzWTyMLe7uHm30_Ncw@mail.gmail.com>
X-Gm-Features: AQt7F2rlgVvCwdODjdcRFyu1z_vpGd2ZB_ft-gACB2jfk1R38mumdCy3KxWprHQ
Message-ID: <CAJZ5v0gDXSdAy9wJYUc_yyHD-Y_tPk0eVzWTyMLe7uHm30_Ncw@mail.gmail.com>
Subject: Re: [PATCH v2] ACPI: Documentation: driver-api: Disapprove of using
 ACPI drivers
To: Danilo Krummrich <dakr@kernel.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Linux ACPI <linux-acpi@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Bjorn Helgaas <helgaas@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Hans de Goede <hansg@kernel.org>, 
	Linux Documentation <linux-doc@vger.kernel.org>, 
	Mika Westerberg <mika.westerberg@linux.intel.com>, Zhang Rui <rui.zhang@intel.com>, 
	Armin Wolf <w_armin@gmx.de>, Ilpo Jarvinen <ilpo.jarvinen@linux.intel.com>, 
	Mario Limonciello <mario.limonciello@amd.com>, Randy Dunlap <rdunlap@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 6, 2026 at 3:01=E2=80=AFPM Danilo Krummrich <dakr@kernel.org> w=
rote:
>
> On Tue Jan 6, 2026 at 1:27 PM CET, Rafael J. Wysocki wrote:
> > +This means that it really should never be necessary to bind a driver d=
irectly to
> > +an ACPI device node because there is a "proper" device object represen=
ting the
> > +corresponding piece of hardware that can be bound to by a "proper" dri=
ver using
> > +the given ACPI device node as the device's ACPI companion.  Thus, in p=
rinciple,
> > +there is no reason to use ACPI drivers and if they all were replaced w=
ith other
> > +driver types (for example, platform drivers), some code could be dropp=
ed and
> > +some complexity would go away.
>
> I think it would be good to explicitly encourage people to convert existi=
ng
> drivers (maybe even list some of those) and rephrase the last sentence to=
 list
> what exact infrastructure, complexity, etc. can go away once that happene=
d.

I can rephrase the last sentence, but the purpose of this document is
to explain the motivation for the change rather than to make a call to
action.

> I think this would make it more likely to receive some contributions towa=
rds
> this goal.

I have prototype driver conversion patches for almost 50% of the cases
right now and I'm expecting to have them for all of the cases by the
end of the current development cycle, so I'm not sure how much there
is to gain.

I want people to not be surprised when they see those patches though.

