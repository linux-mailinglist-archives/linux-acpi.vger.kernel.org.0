Return-Path: <linux-acpi+bounces-13243-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CEBAA9B8C3
	for <lists+linux-acpi@lfdr.de>; Thu, 24 Apr 2025 22:07:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5681446846A
	for <lists+linux-acpi@lfdr.de>; Thu, 24 Apr 2025 20:07:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 418ED1F3FC2;
	Thu, 24 Apr 2025 20:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H0qocti7"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11CD71F1506;
	Thu, 24 Apr 2025 20:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745525249; cv=none; b=mGssooqlfDDseOP68uTaQsHiPTowKOs69aKEMT6Te8FYY+YO/+FgqP5vB8YKzX8yBKREXyHiIuwCdAsHDXkTZZEHXPf3o8iz/CEI55VxOQEiK4Vx/5xGuYSDMlUPLUYY6YCmTkPXmxe2LL4JQD0eadLZ8RMvzejSG9HCQIg1fw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745525249; c=relaxed/simple;
	bh=BPlGUdAvgy5fBp3EvTahCBC87J07KFgQ28UtMg7GY4Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IYXMP+8HGGBuz83npg13zZ7G4/+mnoTBYrDUEOGMDL7YNgdBrryDyz/9BvwcAIMDiTkd4DDLGnrXFa41ARX0H+JG9e63rHRtZEcdoYQ7pjR88A+CaNMrYzALFUQphWMEVq8UrrY2FvEQcWYhgl+hIbZ8NtmjRVORNOIE6zMa4CQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H0qocti7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D47AFC4CEEE;
	Thu, 24 Apr 2025 20:07:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745525248;
	bh=BPlGUdAvgy5fBp3EvTahCBC87J07KFgQ28UtMg7GY4Q=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=H0qocti7sESBvC3NbB3e+klkIbndIr+8q6xfCBqtqFXRJRAjL7RcnCBG+taYxUzMx
	 oNwZoBwNN3qVDhPofh78J2m2w1/Gotw/OsxBVTSUNE1she0FbMPtXPCF6JL2KVn5gI
	 AGm6JAbVsPKpP9TVmc+KA8uDCh9DS8NDePsQVfkwgqZIJi9OPYzIC9kl/EFapYkDXp
	 oCyjaYMySZjI3s/1OCplnJZszZcMwhy7Y2/M2ROSzQRZdBoMU/Y5yAScpFls3k0Qtk
	 YGUfnQ6DAzTcyKJT0IuNecVhOl76bOesntsmzYO66u+nMJe3ghwwtRuH9617pm4LiH
	 wAkLU3OgAJ09A==
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-2d4f832069cso631999fac.0;
        Thu, 24 Apr 2025 13:07:28 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVkmQcC/Chnuc8Kk6P1BN+ls7F+B5wVG/GYug+wlifUYPUtGrXEhGP/WlvYzymvJbr6gQxK7sCmGUc5@vger.kernel.org, AJvYcCX4mtaIpjaj3Dp87lRvr6tm9bVyaYP+SFT7mpRnb/coAfcij6uWUyKh6UxPbNkB278K/b4HU1jtnSrbp+9k@vger.kernel.org, AJvYcCXjqEumN9lzFOD0LsVmfsWyZm7pTHQtsHeIQgz/hWSteIbDhX9gghcvL6afZJDBtAYV9XDY7p//spewig==@vger.kernel.org
X-Gm-Message-State: AOJu0YwOAqhQyVjiWqv+2aA4pdkqXTFOytLtgHIHvEpgOcK+tK/ecEVD
	eWpGwOXfbrpTJd+L2CQkM6Hwl8PTCxGpraucOE7o1xTuTD0BIkm45xNE9eBd2rFH0QBKfuOcbJ3
	RRIoYm0CXFiSNFzg8KReo6B1Z20E=
X-Google-Smtp-Source: AGHT+IHMFH/3VMozmSuKcnowp+L6a8+y0WbFfnuXRwz4lHBlZiYm4u90Z/rVueWp58hplBY85ZfYJ4k9+ZHu/7CSjq4=
X-Received: by 2002:a05:6870:e99a:b0:2d4:d9d6:c8cf with SMTP id
 586e51a60fabf-2d99415a073mr815306fac.5.1745525248167; Thu, 24 Apr 2025
 13:07:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250414203551.779320-1-superm1@kernel.org> <CACRpkdaHru55wo5MdVsRKRbfPS9Hv3vGxgXNi8eXGvAOQzyDww@mail.gmail.com>
 <CAJZ5v0h_Qc2xukPMmwHr-E1HvMwSoLT4TM96aV0e9QKfeRSGGQ@mail.gmail.com>
In-Reply-To: <CAJZ5v0h_Qc2xukPMmwHr-E1HvMwSoLT4TM96aV0e9QKfeRSGGQ@mail.gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 24 Apr 2025 22:07:16 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0iGsjCtbbXm8XaHw8qRe_4KJ2TNO1pDGhmL-aYB4r1Xqg@mail.gmail.com>
X-Gm-Features: ATxdqUEMlCRABQ_ekM-JpQbzSWUWfAd4aod57r5gz-oZxKr8LeISYBOouRgjTM4
Message-ID: <CAJZ5v0iGsjCtbbXm8XaHw8qRe_4KJ2TNO1pDGhmL-aYB4r1Xqg@mail.gmail.com>
Subject: Re: [PATCH v2] pinctrl: amd: Fix use of undeclared identifier 'pinctrl_amd_s2idle_dev_ops'
To: Mario Limonciello <superm1@kernel.org>
Cc: Linus Walleij <linus.walleij@linaro.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, 
	"open list:PIN CONTROL SUBSYSTEM" <linux-gpio@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>, 
	linux-acpi@vger.kernel.org, Basavaraj Natikar <Basavaraj.Natikar@amd.com>, 
	Shyam Sundar S K <Shyam-sundar.S-k@amd.com>, Mario Limonciello <mario.limonciello@amd.com>, 
	kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 15, 2025 at 3:37=E2=80=AFPM Rafael J. Wysocki <rafael@kernel.or=
g> wrote:
>
> On Tue, Apr 15, 2025 at 3:34=E2=80=AFPM Linus Walleij <linus.walleij@lina=
ro.org> wrote:
> >
> > On Mon, Apr 14, 2025 at 10:35=E2=80=AFPM Mario Limonciello <superm1@ker=
nel.org> wrote:
> >
> > > From: Mario Limonciello <mario.limonciello@amd.com>
> > >
> > > `pinctrl_amd_s2idle_dev_ops` is hidden under both `CONFIG_ACPI` and
> > > `CONFIG_PM_SLEEP` so the functions that use it need the same scope.
> > >
> > > Adjust checks to look for both, and while updating make it CONFIG_SUS=
PEND
> > > instead as that's what the acpi header uses.
> > >
> > > Reported-by: kernel test robot <lkp@intel.com>
> > > Closes: https://lore.kernel.org/oe-kbuild-all/202504100420.88UPkUTU-l=
kp@intel.com/
> > > Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> > > ---
> > > v2:
> > >  Use CONFIG_SUSPEND instead of CONFIG_PM_SLEEP
> >
> > This seems to be based on the previous fixes merged by Rafael?
> >
> > Do I need to rebase on -rc2 or something to merge this patch?
> >
> > Or can Rafael queue this too?
>
> I can.
>
> > In that case:
> > Acked-by: Linus Walleij <linus.walleij@linaro.org>

Applied as 6.16 material, thanks!

