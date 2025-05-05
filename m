Return-Path: <linux-acpi+bounces-13453-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B471AA96DA
	for <lists+linux-acpi@lfdr.de>; Mon,  5 May 2025 17:04:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 06D933A50D9
	for <lists+linux-acpi@lfdr.de>; Mon,  5 May 2025 15:03:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7431258CE8;
	Mon,  5 May 2025 15:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W9hxJVUd"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2BC638DEC
	for <linux-acpi@vger.kernel.org>; Mon,  5 May 2025 15:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746457429; cv=none; b=WCPo3cl0ZxFfDo9EK9WSNjlivcoO02dQdAQsac2vc8Ss2Nbp9HDDsE8vszyFEFU6ia4D26RqWTJxycPz+87yglS2fb+tenlpHoJgsXxdGPviUW5sI4NPNOTzWN53r5eZb2qcQd3kQTh8j+dpZr4dZm9kc1Ys/d+MvVgPMc/4EW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746457429; c=relaxed/simple;
	bh=/fo1T16cZ4Kz2dqF3VSq7XwlVIai/nPEcIxIMCqo6qo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TwkzCnb16iSlvgLCKqs+ONMtZ1Zxe7ySydtz0tDYbNGXsov5mMI3CZ4oTXLXj81x8M47Vrdtx06qNF0LpgHU2SlbMDRkcu/MEZ4WdlDKsGNOXDMKL2IGSrN9yMsXgT9HFUcxFSzgioc0NqEv/Qgj/ncpZYQqcv11nMQp7T9aebU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W9hxJVUd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FA8CC4CEE4
	for <linux-acpi@vger.kernel.org>; Mon,  5 May 2025 15:03:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746457429;
	bh=/fo1T16cZ4Kz2dqF3VSq7XwlVIai/nPEcIxIMCqo6qo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=W9hxJVUdn8/N5fRaMel9K8Rrk/rUHA/+wotiNc9Iw/nVcbm9m5zEgkVUvY4lTcv3G
	 4sNxLd/vqMpnAB3FdknhT1Qp+n5UtXF4iCU/vtA1reGp3Bh5AUIXP54+juIcZN4F3D
	 Rh+REL29rkCOvu6QURCTA93W8Y8KR69Aj9MXF+3nCX58CPFQVAOZ5VNkFFywxy02hq
	 01Wk52JD3OAE2C4R4b5a69oawK/8+zW7p1LwHbmPlllraPj+Mmw0uCpdKk0DcOXhOa
	 3ru1Z/+0Wk9KWcEi3MnbQywKysXEgn8biuzcTHmyCll+0H1R7qJp2EuS6AgWjLfuDB
	 bWa6O+Dwh7g3w==
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-6064207317eso2525547eaf.1
        for <linux-acpi@vger.kernel.org>; Mon, 05 May 2025 08:03:49 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUWedCi6Z0Uxc1KYSRxNuThbzseJ1H9bOdEhOEtgP+wCRBksnGbqXB+tTJrfYqFaDXVsILnvi6mCCgF@vger.kernel.org
X-Gm-Message-State: AOJu0YynHP4EX6Eq3ayVv0K3J3Cv2ifppwGckIYnO2uuaJDQbbhQJA6y
	8txYxCSuIGmY84xfIf5exC/1jptxbOFkQ527NT6tsOLb9U1rUfgewgjk7LpTydR3kw6sW1bGZIQ
	F4JkWg/CrgHRRy/A4v1+ur4Y6EII=
X-Google-Smtp-Source: AGHT+IH3aJIBOWtVx8iaaTjmeY7PXZL1fn/xyjFf6e6Qj9hGY9hEOljLB5MgyLyHrxB5HpbuCSUW3K9u130O0agzUy4=
X-Received: by 2002:a05:6870:1648:b0:2c2:3ae9:5b9c with SMTP id
 586e51a60fabf-2dae825bff0mr4470570fac.2.1746457428567; Mon, 05 May 2025
 08:03:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250415212740.2371758-1-superm1@kernel.org> <54cbc6d5-1102-45f4-8b71-97bccd717416@kernel.org>
In-Reply-To: <54cbc6d5-1102-45f4-8b71-97bccd717416@kernel.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 5 May 2025 17:03:36 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0jdR1agmiFaPyGjrSoozCBot4tW8MV_diPDfXrOURvPww@mail.gmail.com>
X-Gm-Features: ATxdqUHIaTPsUAPU2jj4HPgsyU8WaKrNrk4DBWytt7rvjKavh5q2J-goekByYhg
Message-ID: <CAJZ5v0jdR1agmiFaPyGjrSoozCBot4tW8MV_diPDfXrOURvPww@mail.gmail.com>
Subject: Re: [PATCH] ACPI: Enable CONFIG_ACPI_DEBUG by default
To: Mario Limonciello <superm1@kernel.org>
Cc: rafael@kernel.org, linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 5, 2025 at 4:58=E2=80=AFPM Mario Limonciello <superm1@kernel.or=
g> wrote:
>
> On 4/15/2025 4:27 PM, Mario Limonciello wrote:
> > From: Mario Limonciello <mario.limonciello@amd.com>
> >
> > CONFIG_ACPI_DEBUG can be helpful for getting debug messages on OEM
> > systems to identify a BIOS bug.  It's a relatively small size increase
> > to turn it on by default (50kb) and that saves asking people to enable
> > it when an issue comes up because it wasn't in defconfig.
> >
> > Enable it by default.
> >
> > Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>
> Rafael,
>
> Any thoughts on this?  Especially in seeing Ingo trying to modernize
> more of the defconfig [1]?
>
> [1]
> https://lore.kernel.org/lkml/20250505110946.1095363-1-mingo@kernel.org/#t

I'm not sure if this is a good idea TBH.

The risk is that people will start reporting issues that have been
there already, but now they become visible due to enabling ACPI_DEBUG
by default.

> > ---
> >   drivers/acpi/Kconfig | 1 +
> >   1 file changed, 1 insertion(+)
> >
> > diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
> > index 7f10aa38269d2..cb190686499b9 100644
> > --- a/drivers/acpi/Kconfig
> > +++ b/drivers/acpi/Kconfig
> > @@ -394,6 +394,7 @@ config ACPI_TABLE_OVERRIDE_VIA_BUILTIN_INITRD
> >
> >   config ACPI_DEBUG
> >       bool "Debug Statements"
> > +     default y
> >       help
> >         The ACPI subsystem can produce debug output.  Saying Y enables =
this
> >         output and increases the kernel size by around 50K.
>

