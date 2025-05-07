Return-Path: <linux-acpi+bounces-13566-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B3903AADDC2
	for <lists+linux-acpi@lfdr.de>; Wed,  7 May 2025 13:52:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD96B1887290
	for <lists+linux-acpi@lfdr.de>; Wed,  7 May 2025 11:52:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86E87233145;
	Wed,  7 May 2025 11:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uAF7Hdro"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6199E21882F
	for <linux-acpi@vger.kernel.org>; Wed,  7 May 2025 11:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746618730; cv=none; b=XjCjm64HlohRRmSgqmijKigeRe9+W35pj5XcFHrFz9I8gZ2O1+i/Ej+AU8AD/e9jsDNgizKhIqZbSr2DQZxnJH6nl/M8h/V1sS4ZNcDZ0c0TqrlGDHUpl+uL21lokMtqT/v/UFobrFvAs8mfCjU0caeBYkbPcNdSjURviQBZa5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746618730; c=relaxed/simple;
	bh=p+oo/AJVG4gIS3t7a732o2X2ARn1jLjwvm2N9+AV4tA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cwTjeJcvE4AFtrKTkf1OZLvBbWD5L9w2rZ1dsq2dSw/q4B22RPie5xy0XHoU9wJEG9nGkNay2xrJRtSFTFEloJw5u5jgDkOofgObQd2eb15hNtHT/MiWKiycIVHk+4LaZ2AnBfusZ/PHk4y/qLkHZJQIy1IYjw8icK4OMgcveIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uAF7Hdro; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43A76C4CEF1
	for <linux-acpi@vger.kernel.org>; Wed,  7 May 2025 11:52:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746618730;
	bh=p+oo/AJVG4gIS3t7a732o2X2ARn1jLjwvm2N9+AV4tA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=uAF7Hdro+saK+SPaTo6sNzImR6rrEdfYd60xyLrAP9n7qOVuqrxoJRFPY1TkxoouL
	 ZsNiRsqi3zXA1qORNcxXgS1Y8XpZOUOcX3n4UPTM4dcfOEvE6dgzpAXFbBKkhI5ugm
	 96yVUPIsRRetJADR2AFWH0r/vlvDjDzLMwIQV/t4dsAMgnJ0T4oeH3DfAoqDRosBAu
	 hKCtIADXab3H2VrIJMsr+/vFXM4UQSTGu7z2hn5Jg0OPMpsPl53ngK9kVPkW96/SV8
	 90qEiKCEEeU+wNDGQayRXzpS67EtsBbssudHpxChP76oX6pBTL47BcrnCazWVllClS
	 EEeP1C90/1pAg==
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-3feaedb531dso1530998b6e.3
        for <linux-acpi@vger.kernel.org>; Wed, 07 May 2025 04:52:10 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVmd2Vu3WWD+PItYif0ouHeBdNRNJQ0vwLBW/tMZp1R2p2h+2VEx7WLRf2Lprq8lj08ZJRK3QeKDbGd@vger.kernel.org
X-Gm-Message-State: AOJu0Yxze9Rtd2Qood7aZCenq/Nlb+gVEUjSlPzCECASXr8Vc3Oka600
	zgE2DOuf1iEXuPZZeQhLA0iKK6+iyMiUR25ND+GR5OX2MB5QSv3BjBUwHhO1lRkStzlrLkQswHL
	DY2OaTe46jiYKeorNpPhyT/lwIXM=
X-Google-Smtp-Source: AGHT+IHw9lK7RRagqP4+1xWvZdMePWmiWjPbvdrn8nWisL7Yfpa0RJcJwZNyCzYVRRyxqL2/h7qNQvvm6fB3vDDKpj8=
X-Received: by 2002:a05:6808:1804:b0:403:3e86:ab4c with SMTP id
 5614622812f47-4036f0d561fmr1740762b6e.39.1746618729579; Wed, 07 May 2025
 04:52:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250507035124.28071-1-yangyicong@huawei.com> <20250507-devout-mysterious-jackal-e50e00@sudeepholla>
 <CAJZ5v0iWJQnwamT0mP=A_wtAbRkguhxcvbMnm+b2chAET7=sGA@mail.gmail.com> <20250507-venomous-feathered-skink-77ea16@sudeepholla>
In-Reply-To: <20250507-venomous-feathered-skink-77ea16@sudeepholla>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 7 May 2025 13:51:58 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0hyxCE3NWcCgKkut2_pJGO-Pyt27GdhMK0ZUZ-MJ6dudQ@mail.gmail.com>
X-Gm-Features: ATxdqUHNOgmyNM_cmsmfCSLlNBg5ZgOKY6SUjSykcrunRRbY8DERRO8V35VZhf4
Message-ID: <CAJZ5v0hyxCE3NWcCgKkut2_pJGO-Pyt27GdhMK0ZUZ-MJ6dudQ@mail.gmail.com>
Subject: Re: [PATCH] ACPI: PPTT: Fix table length check when parsing processor nodes
To: Sudeep Holla <sudeep.holla@arm.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Yicong Yang <yangyicong@huawei.com>, lenb@kernel.org, 
	linux-acpi@vger.kernel.org, jmeurin@google.com, jeremy.linton@arm.com, 
	jonathan.cameron@huawei.com, zhanjie9@hisilicon.com, prime.zeng@hisilicon.com, 
	yangyicong@hisilicon.com, linuxarm@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 7, 2025 at 1:47=E2=80=AFPM Sudeep Holla <sudeep.holla@arm.com> =
wrote:
>
> On Wed, May 07, 2025 at 01:44:26PM +0200, Rafael J. Wysocki wrote:
> > On Wed, May 7, 2025 at 1:40=E2=80=AFPM Sudeep Holla <sudeep.holla@arm.c=
om> wrote:
> > >
> > > On Wed, May 07, 2025 at 11:51:24AM +0800, Yicong Yang wrote:
> > > > From: Yicong Yang <yangyicong@hisilicon.com>
> > > >
> > > > Below error is met on my board and QEMU VM on SMT or non-SMT machin=
e:
> > > >   ACPI PPTT: PPTT table found, but unable to locate core 31 (31)
> > > >
> > > > This is because the processor node is found by iterating the PPTT
> > > > table under condition (for both acpi_find_processor_node() and
> > > > acpi_pptt_leaf_node()):
> > > >   while (entry + proc_sz < table_end)
> > > >     [parse the processor node]
> > > >
> > > > If the last processor node is happened to be the last node in the
> > > > PPTT table, above condition will always be false since
> > > > entry + proc_sz =3D=3D table_end. Thus the last CPU is not parsed.
> > > > Fix the loop condition to resolve the issue.
> > > >
> > > > This issue is exposed by [1] but the root cause is explained above.
> > > > Before [1] entry + proc_sz is always smaller than table_end.
> > > >
> > >
> > > Another thread [1]  with similar patch.
> >
> > OK, so is this a correct fix?
>
> While it may fix the issue on the surface, I just want to be sure there
> are no other issues with the PPTT table presented from the firmware.
> I will asked some questions on that thread before I can agree on the solu=
tion.

Yeah, it looks like table_end points to the last byte of the table
instead of pointing to the first byte after the end of the table.

