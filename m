Return-Path: <linux-acpi+bounces-8538-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C6A2998E1EF
	for <lists+linux-acpi@lfdr.de>; Wed,  2 Oct 2024 19:54:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E69A1F20F74
	for <lists+linux-acpi@lfdr.de>; Wed,  2 Oct 2024 17:54:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F084B1D1752;
	Wed,  2 Oct 2024 17:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Sy6ZzNLy"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0D701D0F76;
	Wed,  2 Oct 2024 17:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727891686; cv=none; b=VPU3NJgbMfptxtFoabfRqji3Q53wfI1ZwiLWD1dInY9kUm+vW89C2v1Eq7tzBFDkyusD5sRRP4KBJlaJdcgufH7d/Bi6rxSgoPjZT65krAc5L9WZA7UfL1xElhgMOgGPdgOI/29+Apzjuyb7SR6UdfECAxoTneZQ1R1pHvm3z5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727891686; c=relaxed/simple;
	bh=7xDaKAd1Gk5ssNXKOGyvSeaQWuYxbSNB3jGW+izMmto=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=liJU31rDPcDmbF9N1nqYNwSoiy02Lg9pHMHzu8Y59bOs19s6lPM0umwgJ/avf0F4lXwbzFIkyLfL4laRPc7baPjuz0bqHFKOCx7UAoy99+qSX8yhLLpl1NOGffhIyFn7AYTetfzcPwUO8V5WS1eiPlOjp2CubRyy3J6cJnTzRYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Sy6ZzNLy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FD61C4CECF;
	Wed,  2 Oct 2024 17:54:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727891686;
	bh=7xDaKAd1Gk5ssNXKOGyvSeaQWuYxbSNB3jGW+izMmto=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Sy6ZzNLyja0QjqHb08UM+9Zj4lJ4ZpsIFpaoC9ma4QFh6xObnQyTQ2cOKO6xftaHu
	 G2i8v843jMvuPXMeZy0VcybZNpgVIF6zqIIkJ9BQbavq9clpfrW219cfpibNvL2zab
	 BjDuI2Z6riKqBieAAvsHcrGRanQJMU8izVVxTS+0hUa+ROS8bLeO8GLOItJiiXdWCl
	 H5HUY5/sZN4PP/+ICIq7I5UGlQokq5cPbgeI2HVwIto3SDj0A43l61I8S+WZwMFeTG
	 LB69YUQXK9UAp4RLpFaShXLUz+6+ajYtN+2RdsDlEcVy59wsBxenvCZKU/cvgikaJI
	 GjwwENzfO3xBg==
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-3e2a1049688so98265b6e.1;
        Wed, 02 Oct 2024 10:54:46 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVeIGVbNIgEK+jJBaQ6dtANKZdd09y/sqBQaZ9da4IaAKilVWyKkwuiKdljnqZl1TEF8DPbzZbcAFbeeAaJ@vger.kernel.org, AJvYcCXB7lcbZvjuxeTFXK/QbNWj4sMi5b+zYhXIUm+giwjQZM9GJvz7pPPVr8V6MyzPMQ/HqgT23bthbOFB@vger.kernel.org, AJvYcCXCFX1674XY9z3nlm7eTCnUGZ/qxNVxSAzs1AowWhGAxNKgpYiHv7Kw++YCMW58YUHD3kC2grd4O+HD74UQ1duyOBynFw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxzg8cbcXq/z78IzcAYbBZyvcywJjXR5iFxPgvC4tS7tiBcumde
	ogSup2BHe9IkVUvwHz/NKHeXDaAE3xutG8uoXvM4qwmwWsT0D3Q5eLjA4NmjHEjU211JGMhjIfn
	Hc2bZZbr6uyln4ZtvZBEKwQCkO0A=
X-Google-Smtp-Source: AGHT+IH0x7D7yugauhSHfUysPtt+dv8bueCHystfbujU+k/MkyvcAwGsTbJ81jp5J2eKcRYHCASyi5qvri65ar78iks=
X-Received: by 2002:a05:6808:3006:b0:3e0:3d6c:116d with SMTP id
 5614622812f47-3e3b4125dbbmr2813601b6e.26.1727891685683; Wed, 02 Oct 2024
 10:54:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241001212835.341788-1-W_Armin@gmx.de> <20241001212835.341788-3-W_Armin@gmx.de>
 <CAJZ5v0gSYp5Umo-wsKvQ2Nff7YZ=_3-4bzG3TnKqMpHvxCmR5g@mail.gmail.com>
 <ab75a39e-94e2-4b1a-9406-e05ebc816b03@redhat.com> <CAJZ5v0jDFpzKRv=M=6nmyYON6FtEnCsO9K86HO9jKDraAXTYAg@mail.gmail.com>
In-Reply-To: <CAJZ5v0jDFpzKRv=M=6nmyYON6FtEnCsO9K86HO9jKDraAXTYAg@mail.gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 2 Oct 2024 19:54:34 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0jZtgYMwCyNJ8oW8bWiS-MAa5-WnUbzc1FgMR9tt43mmQ@mail.gmail.com>
Message-ID: <CAJZ5v0jZtgYMwCyNJ8oW8bWiS-MAa5-WnUbzc1FgMR9tt43mmQ@mail.gmail.com>
Subject: Re: [PATCH RESEND v3 2/3] ACPI: battery: Fix possible crash when
 unregistering a battery hook
To: Hans de Goede <hdegoede@redhat.com>, Armin Wolf <w_armin@gmx.de>
Cc: pali@kernel.org, dilinger@queued.net, lenb@kernel.org, 
	ilpo.jarvinen@linux.intel.com, platform-driver-x86@vger.kernel.org, 
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 2, 2024 at 2:54=E2=80=AFPM Rafael J. Wysocki <rafael@kernel.org=
> wrote:
>
> On Wed, Oct 2, 2024 at 2:35=E2=80=AFPM Hans de Goede <hdegoede@redhat.com=
> wrote:
> >
> > Hi,
> >
> > On 2-Oct-24 2:08 PM, Rafael J. Wysocki wrote:
> > > On Tue, Oct 1, 2024 at 11:28=E2=80=AFPM Armin Wolf <W_Armin@gmx.de> w=
rote:
> > >>
> > >> When a battery hook returns an error when adding a new battery, then
> > >> the battery hook is automatically unregistered.
> > >> However the battery hook provider cannot know that, so it will later
> > >> call battery_hook_unregister() on the already unregistered battery
> > >> hook, resulting in a crash.
> > >>
> > >> Fix this by using the list head to mark already unregistered battery
> > >> hooks as already being unregistered so that they can be ignored by
> > >> battery_hook_unregister().
> > >>
> > >> Fixes: fa93854f7a7e ("battery: Add the battery hooking API")
> > >> Signed-off-by: Armin Wolf <W_Armin@gmx.de>
> > >
> > > Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > >
> > > Hans, are you going to take this series or should I apply it?
> >
> > AFAICT the patches don't really depend on each other,
>
> OK
>
> > so my plan was that you take patches 1-2 and I take patch 3 as a fix fo=
r
> > 6.12-rc# .
> >
> > Does that work for you ?
>
> Yes, it does, thanks!

Now queued up for 6.12-rc along with the [1/3], thanks!

