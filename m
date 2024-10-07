Return-Path: <linux-acpi+bounces-8584-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68EB09930DA
	for <lists+linux-acpi@lfdr.de>; Mon,  7 Oct 2024 17:14:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 298832855E3
	for <lists+linux-acpi@lfdr.de>; Mon,  7 Oct 2024 15:14:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E8BE1EB25;
	Mon,  7 Oct 2024 15:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CAhEf3Tf"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54B5512E75;
	Mon,  7 Oct 2024 15:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728314062; cv=none; b=IqvI2sXKSuxx9X6Z0ZmhuIbg19TBfrzpPTd8I+HEplDgWwMyEOJggTuyqSoRxnMzJRd1Ce0aU+l/xwUPBaR4Cajtt8Am1Bh05V39P7EArPdqTxh8ngaNz35lR19lS+YcimSyCFTYB0KjEiPkmDkszr4toN3IKKes1gLP6Bg+zyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728314062; c=relaxed/simple;
	bh=TqeKSTkmYuz8/ogDXIfKuzBAEiohkOF1qh1YEuWkMaM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VDClUGWTdBZsxdgKVassCEiKqKniQV78/iK1frhz+R6jBOwtOtaXVlsi5B+TccFVAfiZW7NTIBL4h9X9O/5YwjXf83uBK7euQrhUQeGfWD1js2dBPCF3HIAvOazVtPp2rM5VhuZ7CRazbEiyNHclce5F7gOr3GB1YCSDCKV25xg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CAhEf3Tf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28698C4CEC7;
	Mon,  7 Oct 2024 15:14:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728314062;
	bh=TqeKSTkmYuz8/ogDXIfKuzBAEiohkOF1qh1YEuWkMaM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=CAhEf3Tf8T+pcs6kt12iyvFnnKmC/ZS8FoFbhFehNyRzd7E3r9iJzRbiEzRLmlCuk
	 QR8oBVu6krNq8GIudURR/fSqWl0zJd5T15vrgaqia532/5SR0H0lHwO7kiv+u+ZP7A
	 64urWTCqgSugLd9D/2Z2YZxOzPqYuxnSM9OEPhHVZBz4khfdQEU2XsgJvHzLDOmmWg
	 F6MFRSLnz+WLSPOzlwj+Z/bZ968HXifUPZzli71OlVnPoXhU5kJLTBGFaJelIxowC1
	 mee7ElQxIJpOl8LaQ2J8eYVqOhpqT9fdprA2aSqNHx9e57PBy1YSJzP6IobLAuybmc
	 gXQHob7fdpS/A==
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-3e0719668e8so1891040b6e.0;
        Mon, 07 Oct 2024 08:14:22 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVsSVJq4Q9Gkl84echfGF5C3ujho4tMDnxga1W0ZnfiBIo5En6iwWfmJVvCuVeknIubBuDMBO7jvDv4KOpL@vger.kernel.org, AJvYcCWXdWQ2OzU37f7uJz/0xokeJjHYiG2vUtWGN4cFGtamWUOauicKUUglvMESAPYYgVmODoNKUK8umGni@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/klpar5jpWdrRAxVULGFY2Zjh3iXGuVRVg3dHYkVEaYn7Qvim
	UBW7ouh80+jGtXVU0197RpyHhibPYTq2MGM2/g1rt9zyOCnym6+yi9y7wzJuIuUXdIISQQKYnpJ
	YMpMdkTSCFIJzeUrsEDmngviP8jw=
X-Google-Smtp-Source: AGHT+IHE5KAdHGiu1RbPlIqzlWBUCff/hwRvlLkJr3QZhY4Df1PNAqtvhI1VMRZMEpiRRs38dtvghLAp3yHe60XMGso=
X-Received: by 2002:a05:6808:1b0d:b0:3d6:2da2:2b4e with SMTP id
 5614622812f47-3e3c155850amr6957985b6e.14.1728314061439; Mon, 07 Oct 2024
 08:14:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240904-acpi-battery-cleanups-v1-0-a3bf74f22d40@weissschuh.net>
 <CAJZ5v0gAaMLrSyva_cZBxJpzAFM3Lb_SiuTxESjAmHJLxnThGA@mail.gmail.com> <8291a067-cd9c-4fcf-b32d-0064f3225836@t-8ch.de>
In-Reply-To: <8291a067-cd9c-4fcf-b32d-0064f3225836@t-8ch.de>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 7 Oct 2024 17:14:05 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0g0sDTnt63BaK2aFR3LppzckO92svrFAenkmQh=Mpxo2w@mail.gmail.com>
Message-ID: <CAJZ5v0g0sDTnt63BaK2aFR3LppzckO92svrFAenkmQh=Mpxo2w@mail.gmail.com>
Subject: Re: [PATCH 0/5] ACPI: battery: various cleanups
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 5, 2024 at 9:27=E2=80=AFAM Thomas Wei=C3=9Fschuh <linux@weisssc=
huh.net> wrote:
>
> Hi Rafael,
>
> On 2024-09-04 14:44:33+0200, Rafael J. Wysocki wrote:
> > On Wed, Sep 4, 2024 at 9:13=E2=80=AFAM Thomas Wei=C3=9Fschuh <linux@wei=
ssschuh.net> wrote:
> > >
> > > Signed-off-by: Thomas Wei=C3=9Fschuh <linux@weissschuh.net>
> > > ---
> > > Thomas Wei=C3=9Fschuh (5):
> > >       ACPI: battery: check result of register_pm_notifier()
> > >       ACPI: battery: allocate driver data through devm_ APIs
> > >       ACPI: battery: initialize mutexes through devm_ APIs
> > >       ACPI: battery: use DEFINE_SIMPLE_DEV_PM_OPS
> > >       ACPI: battery: install notify handler through ACPI core
> > >
> > >  drivers/acpi/battery.c | 41 +++++++++++-----------------------------=
-
> > >  1 file changed, 11 insertions(+), 30 deletions(-)
> > > ---
> >
> > Since it is a bit late in the cycle and this material does not appear
> > to be urgent, I'd prefer to defer it until 6.12-rc1 is out.
>
> 6.12-rc1 is out and other patches have been queued.
> Did this one fall through the cracks?

No, it didn't.

There were a couple of ACPI battery driver fixes I wanted to go in
before this series and they are in -rc2, so I'm going to apply it now.

Thanks!


>
>
> Thanks,
> Thomas

