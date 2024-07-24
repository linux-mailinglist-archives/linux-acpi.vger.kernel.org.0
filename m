Return-Path: <linux-acpi+bounces-7045-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A895493AF64
	for <lists+linux-acpi@lfdr.de>; Wed, 24 Jul 2024 11:52:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 620A9283D4E
	for <lists+linux-acpi@lfdr.de>; Wed, 24 Jul 2024 09:52:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 491E214EC7F;
	Wed, 24 Jul 2024 09:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C0HrWOPV"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23B8F7C0B7
	for <linux-acpi@vger.kernel.org>; Wed, 24 Jul 2024 09:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721814737; cv=none; b=qkCy/F02zpUUKQ7k3RFKlGhnxdmbN1gdvMGk4rmY6gPwDdCA5xOddo45nSQFAUxq5dMfJI+dl5fsMBx8O7zWa7HivsUXf7abkRp2dXNWoUQ2WpbRXqPlemyMn8ZEap3MVOnj40MWZjv4dqM2d4A4vKcjtOnrzWtf1484S9vta1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721814737; c=relaxed/simple;
	bh=lT5B4Wp4VF01nRSYcl6S0BXXpYB7+GLxFDZJtLp9hD8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=H5v3ZdGeXuM7tIR3X48fEpTvFWbu6HXC8w01se1eWiRsYcIDPM7+fyecPP7DlXPfTYIJMJN6x6Wo16W1fj79vA117Gq3HlxRiGehxRxSNnAOastTfXOQvK33YOf/gVg3TI5JWchZEfCuY8naI/PF5AwXzl+46iZs61oqOtBjZes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C0HrWOPV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADA60C32782
	for <linux-acpi@vger.kernel.org>; Wed, 24 Jul 2024 09:52:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721814736;
	bh=lT5B4Wp4VF01nRSYcl6S0BXXpYB7+GLxFDZJtLp9hD8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=C0HrWOPVKEFeV5bXa1995Zz22XtaSb4VSYPdT40SXOrZs0brZXV2Gfo80K0wUyCHH
	 2FcwKCRcaTKk4BL2QWseO7iacQFrfMD9UEdOGr6i/htogiu6ShE1PH6rlrGlKGu9Ct
	 TqVaeAcEtfPmZxfS1YSVz6a0pAyc98CHA2VlrM4clhjfmgk5/BPoUX82+cpFYRs1J0
	 gBpD9P7RhrB0RojWpHTHUOis6rRaot0OaDdMJIlPj+Lz5s8Gbj2QHdC38atNUMnpyD
	 9O67ugz7BAymZtJwg3BRnpujZKuCGsmphaUEHeD3zXKu7zXtds2JxlGImKaKtQEAxm
	 9KnJaPIHP7F5Q==
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-5cf146a82a5so269041eaf.3
        for <linux-acpi@vger.kernel.org>; Wed, 24 Jul 2024 02:52:16 -0700 (PDT)
X-Gm-Message-State: AOJu0YzCFLiiyTt8w5zz6aqJeRS9RB3qk/gBuzd/4Zub+PzAj2Fze+6s
	6Nlvk8IuzjlTbipR/oQ+je79yI+rfdyGJi7/eXgsOBmXyC20ZomHporR+fQXMHlhpMKMgoWft0z
	ocdFrPAjHcXRU30rG0mv9sMU62mA=
X-Google-Smtp-Source: AGHT+IEDCuwT8n972+VcJob1u/W1zHa8j3mLE72UfZNOsZS5EmPW0SmlWhU8exXE3jMshXAeHNvnjf78GogTdFbcVWQ=
X-Received: by 2002:a4a:c685:0:b0:5cd:920:de44 with SMTP id
 006d021491bc7-5d564ef4967mr7635693eaf.2.1721814735864; Wed, 24 Jul 2024
 02:52:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAGnHSE=RyPK++UG0-wAtVKgeJxe0uzFYgLxm+RUOKKoQquW=Ow@mail.gmail.com>
In-Reply-To: <CAGnHSE=RyPK++UG0-wAtVKgeJxe0uzFYgLxm+RUOKKoQquW=Ow@mail.gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 24 Jul 2024 11:52:03 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0j7P5AV58276ZVN9ZA=R3jj0XMGdNgWAKQC8oGwAHt7dg@mail.gmail.com>
Message-ID: <CAJZ5v0j7P5AV58276ZVN9ZA=R3jj0XMGdNgWAKQC8oGwAHt7dg@mail.gmail.com>
Subject: Re: [Bug][Regression] non-stop ACPI ([\_SB.PC00.LPCB.HEC.TSR1]) and
 thermal zone error
To: Tom Yan <tom.ty89@gmail.com>
Cc: linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 24, 2024 at 7:42=E2=80=AFAM Tom Yan <tom.ty89@gmail.com> wrote:
>
> Up til 6.9.10, I would see these errors every boot *twice*:
>
> ACPI BIOS Error (bug): Could not resolve symbol
> [\_SB.PC00.LPCB.HEC.TSR1], AE_NOT_FOUND (20230628/psargs-330)
> ACPI Error: Aborting method \_SB.PC00.LPCB.H_EC.SEN1._TMP due to
> previous error (AE_NOT_FOUND) (20230628/psparse-529)
>
> (they do get occasionally repeated again)
>
> and these *once*:
>
> thermal thermal_zone2: failed to read out thermal zone (-5)
> thermal thermal_zone7: failed to read out thermal zone (-61)
>
> But since the distro I use (Arch) has moved on to 6.10, these are
> spammed *non-stop*:
>
> ACPI BIOS Error (bug): Could not resolve symbol
> [\_SB.PC00.LPCB.HEC.TSR1], AE_NOT_FOUND (20240322/psargs-330)
> ACPI Error: Aborting method \_SB.PC00.LPCB.H_EC.SEN1._TMP due to
> previous error (AE_NOT_FOUND) (20240322/psparse-529)
> thermal thermal_zone1: failed to read out thermal zone (-5)
>
> in the frequency of *three to four times per second*.
>
> For the record, this is now consecutively repeated 5 times every boot as =
well:
>
> thermal thermal_zone7: failed to read out thermal zone (-61)
>
> But at least this one would stop.

Well, sorry for the message flood.

It should be addressed by this series:

https://lore.kernel.org/linux-pm/2348857.ElGaqSPkdT@rjwysocki.net/

which is on its way to the mainline (both patches are needed).

With these patches applied, you'll still see several iterations of the
ACPI message that is printed every time the kernel attempts to get the
temperature for thermal_zone1, but then it will give up and disable
the thermal zone.

The problem is that the _TMP control method that should return the
temperature for this thermal zone is broken and it cannot work which
has been exposed by a recent kernel change.

I would appreciate letting me know if the patches above work for you.

Thanks!

