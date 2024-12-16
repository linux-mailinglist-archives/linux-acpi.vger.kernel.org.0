Return-Path: <linux-acpi+bounces-10149-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EFE5B9F39FC
	for <lists+linux-acpi@lfdr.de>; Mon, 16 Dec 2024 20:38:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A8F5B1885C1A
	for <lists+linux-acpi@lfdr.de>; Mon, 16 Dec 2024 19:38:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 529DA207656;
	Mon, 16 Dec 2024 19:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zww+pi3B"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D03B206263
	for <linux-acpi@vger.kernel.org>; Mon, 16 Dec 2024 19:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734377910; cv=none; b=TQ7W350JM+LHzNtB9/C3wLk0G4nF5rxoi+Wkl2jiYPJGEws+PZebwI4wmDiXx6eE0gmVi/kWTZnSF8RmNSutiq2Iab0i7kWZYHa/2H2eCg7oS5eyiryq5XC9xMPf8owwV1PytDP947Nh0uVR2s0JzUFKTR3YWsCD4DmNhLY9WMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734377910; c=relaxed/simple;
	bh=+dZxDPL8aCw/GvCJkbXcxyMH6APJipEyrtN09qf1cwI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Yl0VXCr9dbhcXc6R1aLM57RYWRG2FTF/XZwrDbnOMHCKAloXHXu9z9jwlEIvAivLUEoFbj4OKPhnxa0Q+ANQS6C898Mn6R+2UlaTU2G3CL5cPDE/V5ugNhuoCix+LmA0qaa2XpRFloWkTxR1uifTmIPMeWVYA4JnKt7X7X+VVqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zww+pi3B; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADB90C4CED4
	for <linux-acpi@vger.kernel.org>; Mon, 16 Dec 2024 19:38:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734377909;
	bh=+dZxDPL8aCw/GvCJkbXcxyMH6APJipEyrtN09qf1cwI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Zww+pi3B2emZlvtCIWIeUnF28tSUOj5Cx0RxVDR5+PIeTPzB0LqoAKxzo2q1KpNV7
	 ZGCoq1bjlhMzPsy8b2tJi0vexerUas9iYBHKNnKimGdT7vGiYYdfV4dwb7xbIZemIc
	 a3K1Mjl2AR6W17PPVTKL5MI+K1AWZCJAqVNvKBoXnr+Xmx7FBqzP8jaI8NIujde5m3
	 4UO6X7uJDjKiprUE+h3JJd4ycJPlTPpU47Z7kYyTtCkEYXn00MfzPIV6a3q8ijYKuU
	 KZvqiBvRHkygQl9QLnTvgx+c7cFyX5pG/8Q4llAe0uh1vjOlHyZvoReQPojpp61XxN
	 AOhnufFUaB3HA==
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-3eba347aa6fso2409327b6e.3
        for <linux-acpi@vger.kernel.org>; Mon, 16 Dec 2024 11:38:29 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXylCF79/ZBI3H5zwwdcc/6GnCCrUSmfGlBsbSEABJSjbLsmpBwsMwJ1MdB03RmJkc8AHycp18+Ydaz@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7lRNRR7+v6n1PSKl0gff393nvquFOHhl9O5XMsqLYgkmBZypo
	UH474e5JeOIZci0meyw+9oHnrukd3od8ZUod7KpgjmLueK1xNKPcbBWzF5416z6aJ/xGhMGJ3px
	4SNZ1DlsVVO5LUhOhR+zVQVqfVR8=
X-Google-Smtp-Source: AGHT+IG5s8aPzd4r1jE8TA79jBSVkfu1eKZK8VEhDSUkrgbODUbE2Ns3xHfNfpRi26tJZSSlMLIzlOsBLbPqpECnmKI=
X-Received: by 2002:a05:6808:1444:b0:3eb:6044:5a7e with SMTP id
 5614622812f47-3ebcb2b6496mr14971b6e.19.1734377909054; Mon, 16 Dec 2024
 11:38:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHGTsivNWhWMPnH-dDunoAH36GAxV97-xwaZ2Pi_YdpnpiLfnw@mail.gmail.com>
In-Reply-To: <CAHGTsivNWhWMPnH-dDunoAH36GAxV97-xwaZ2Pi_YdpnpiLfnw@mail.gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 16 Dec 2024 20:38:18 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0g0UNSEN5g_x3WbQZrK5+E1oqD4y-Bj+hWP4QmjE=wrnA@mail.gmail.com>
Message-ID: <CAJZ5v0g0UNSEN5g_x3WbQZrK5+E1oqD4y-Bj+hWP4QmjE=wrnA@mail.gmail.com>
Subject: Re: Proposal: Defaulting to s2idle on Lenovo E14
To: jack Bourke-Mckenna <jackbourkemckenna@gmail.com>
Cc: "rafael.j.wysocki@intel.com" <rafael.j.wysocki@intel.com>, linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 16, 2024 at 7:50=E2=80=AFPM jack Bourke-Mckenna
<jackbourkemckenna@gmail.com> wrote:
>
> Hi Rafael J. Wysocki and ACPI maintainers,
>
> I wanted to ask about improving Linux support for the Lenovo ThinkPad
> E14 Type 20RA. Right now, this laptop defaults to the "deep" sleep
> state (S3), but it has resume issues. On the other hand, "s2idle"
> works reliably, and users can enable it manually with the
> mem_sleep_default=3Ds2idle kernel parameter.
>
> Would it make sense to make a modification to the  ACP DMI table to
> set "s2idle" as the default sleep mode for this laptop? It seems like
> it would fix the suspend/resume problems out of the box without users
> needing to tweak anything manually(this was a huge pain to debug).

Yes, if it works.

> Does this seem like the right way to address the issue? I=E2=80=99m happy=
 to
> put together a patch and include logs showing the problem if you think
> it=E2=80=99s worth pursuing. Or is it likely to be ignored because the E1=
4 has
> a relatively small user base?

It won't be ignored, but if it is applied and some other users report
a problem with it, it will need to be reverted.

Thanks!

