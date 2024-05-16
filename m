Return-Path: <linux-acpi+bounces-5856-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A44A08C72F9
	for <lists+linux-acpi@lfdr.de>; Thu, 16 May 2024 10:37:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3D8A5B22664
	for <lists+linux-acpi@lfdr.de>; Thu, 16 May 2024 08:37:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1691133401;
	Thu, 16 May 2024 08:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rcAZH9kv"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A83C66D1AF;
	Thu, 16 May 2024 08:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715848642; cv=none; b=Yap7F89nPGgu2KUb9u4dRA1JJbFbIvhqCwlgiz6hVIoHBgOos+mR/YQHCVokMWiA9Ysinhxdy6GwOAxXLVGj2MeP1gDoXrn/38aP2NSu0s4e2dktk1W3+xXLI7xDJn+7Syus+ZmQWz1nU/QM5C26rLLJNLEPvjQKeOFgZlZPOTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715848642; c=relaxed/simple;
	bh=T33zBUgNEcsAzHk0mLYF9iCN1qabeKB1opEAFm1TzHs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EvxJXb0Hgq8+bHWYRvrEO7VT+ITUB3qhSdJlaOJ6d2BtKxhjSIK43AmgykNE7F6MrPYik0ItsDOEUUdo8tiTK6hjh2W5bfylGSvR/rS2y857866UlwLAwpxlI6hTJtyOf6ldOmrS5mY8MJHExeW7+N7sqbkWm9IaWpNwfdwKZTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rcAZH9kv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87045C32786;
	Thu, 16 May 2024 08:37:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715848642;
	bh=T33zBUgNEcsAzHk0mLYF9iCN1qabeKB1opEAFm1TzHs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=rcAZH9kvGgZooC4cL1BXNJ3vZfF1sfxToMhVB/sbrDKc8JUL1YMH9GY7b/AaI4EgX
	 FJAsRoBHbA95z2zIKQdns4Ill7IqdazmbSZqA+7JBMlkcR00zn/HyqOK8toiXyQJe4
	 +wL2dreAbBdUT9VckxX0SrrR/r/mmy6/cxoc8dsWJMc/z8R/Ilmcb2EpqouCPr6WWv
	 e0Iant8smctaX8boDyojJHMomoL/FU2/G5XgXxzhMUyFiXbVCdVMPJ1i2cV1VZOPwQ
	 bjoAHF47D+Hn2otOHO3kmGWmbqcGYM90kMvZ+//wt9hjXhD9krvhLFX7Twx3Yag5xc
	 YIDfGVgBpbqzQ==
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-3c992e5c821so1280076b6e.2;
        Thu, 16 May 2024 01:37:22 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVzFH5yqvZ5TwWJENJ4aWbHCNrl/GJSa4aEIK/Hyxz0M/zUFWByaDQEGE26VQIMQAyXb9L4eqiezOw21JmpxezbOakAH9G8+yEaUuSoxbHi2GoEabDf9HrzMxNobBCqANROKW/7vOzXXQ==
X-Gm-Message-State: AOJu0Yy3nerYwSmYRcQCFWScRMHkaXTpoYO3c972mrc1p2OAukpweDoT
	X3SkjOp8go4uNTzyP64bwKM7jk77Ek0BqDszgJvlw0rf6Cmt/HI0uehW+3c+HH7kHYLqq2RbrRT
	TqiVxo008k9V8uvFL65aF59W7l3A=
X-Google-Smtp-Source: AGHT+IHu7wLVYbn10Mc7E1o/4BDoFnp+0du3C5+ILremNc0dFyZZxOL8b+hKRATK57zmhP5ypmJg/dsUy4VeDM1uSO4=
X-Received: by 2002:a05:6870:ac23:b0:239:d0ff:f428 with SMTP id
 586e51a60fabf-241723001cemr21138319fac.0.1715848641637; Thu, 16 May 2024
 01:37:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <12437901.O9o76ZdvQC@kreacher> <5161bd95-d51e-49cc-bcbd-523fbb747e4b@redhat.com>
In-Reply-To: <5161bd95-d51e-49cc-bcbd-523fbb747e4b@redhat.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 16 May 2024 10:37:09 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0gf-oLcjT8dxnpjAyVfpUep5ST2mHDJy2dySBGCJwjMxg@mail.gmail.com>
Message-ID: <CAJZ5v0gf-oLcjT8dxnpjAyVfpUep5ST2mHDJy2dySBGCJwjMxg@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] ACPI: EC: Install EC address space handler at the
 namespace root
To: Hans de Goede <hdegoede@redhat.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux ACPI <linux-acpi@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Mario Limonciello <mario.limonciello@amd.com>, Armin Wolf <w_armin@gmx.de>, 
	Heikki Krogerus <heikki.krogerus@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 16, 2024 at 10:35=E2=80=AFAM Hans de Goede <hdegoede@redhat.com=
> wrote:
>
> Hi,
>
> On 5/15/24 9:39 PM, Rafael J. Wysocki wrote:
> > Hi Everyone,
> >
> > This is an update of
> >
> > https://lore.kernel.org/linux-acpi/5787281.DvuYhMxLoT@kreacher/
> >
> > which was a follow up for the discussion in:
> >
> > https://lore.kernel.org/linux-acpi/CAJZ5v0hiXdv08PRcop7oSYqgr_g5rwzRTj7=
HgdNCCGjXeV44zA@mail.gmail.com/T/#t
> >
> > Patch [1/2] has been updated to avoid possible issues related to
> > systems with defective platform firmware and patch [2/2] is a resend
> > with a couple of tags added.
>
> Thanks, the series looks good to me:
>
> Reviewed-by: Hans de Goede <hdegoede@redhat.com>
>
> for the series.
>
> I assume you are going to send this in as a fix for 6.10 ?

Yes, I am.

> In that case feel free to merge both patches through the
> linux-pm tree.

Thank you!

