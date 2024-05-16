Return-Path: <linux-acpi+bounces-5863-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 087DD8C748D
	for <lists+linux-acpi@lfdr.de>; Thu, 16 May 2024 12:21:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B5D3F285C54
	for <lists+linux-acpi@lfdr.de>; Thu, 16 May 2024 10:21:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73AF6143C52;
	Thu, 16 May 2024 10:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uhjANRDC"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4950B143754;
	Thu, 16 May 2024 10:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715854899; cv=none; b=EyBYbELwrLOqB0TvZcPrM6RYcYyqZJnC5UgrTVX0iGF9aJlZvkg9j0+Sm24L9D41frXWHan9Ws0J06eq9b8oyA/VwwpD/YAf7e1bu1bKR5qjX1M5UM32VPjX+P2PQcosEqLYHicQ7leWARGmjTKLiY8O3Jy8c1galNHiAiIwdr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715854899; c=relaxed/simple;
	bh=jl7IMtgEPzBKL5CPg7t4BVUmG2ehe9JU4HSBiI77hjk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lXIOdSqwc1w8gfuEj9KcvMwktbMwbySvqybyB+OTfqmz/W9p3OP4Wp/0vxZ2Viyn8QjXSYwyst8TqSdE/vDG3B2XY4D68+VNqLoyR2lC6oW1X14fjYO/Am86xQ7xPY/lJ+FptL4p75t6bzKa2IpbaZFR6dzHbI2XmsGbhpFLoV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uhjANRDC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF6D1C32789;
	Thu, 16 May 2024 10:21:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715854898;
	bh=jl7IMtgEPzBKL5CPg7t4BVUmG2ehe9JU4HSBiI77hjk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=uhjANRDCJ2ATp7JfsX+Ft9DAxHszd1esLr3C3f3/nWEXtZO0Bby9jOk77SAYfDkT5
	 2eNRNhl1UZ0hh9fY2UjGAFcdLYgBXar11eXgdWNHDKXDYoTidxl1JrcA291O4xtVoL
	 lCR2t+ZOBUo5pCJe7vkKo61p9cScOYLnTVgaiimxnYR7qR1OPeBKROWo8U/RNx6uGN
	 EPL3ggy3ga8mqv7TgUjCjzs0OLD/eQEhgWK8dkzEr9nCRX+PQ6bN42F4aP2JwOnHrC
	 fkTlEpaex1d0rKOZHn//S2k1FUU/hOAguZwLzvGtYeAnbSQ2OZb3ylCIznHadKCEl0
	 BpEGy2PvwcWeQ==
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-5ac970dded6so2319eaf.0;
        Thu, 16 May 2024 03:21:38 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUORPB4Hv42tFu23HLUJnU6VbZ+Fy7T6EjPa0K8UBdhSk7p7J1T9OCOU2OWHoKDX23xTS1wdYjCQCwIg1lJ3a9vJm6rlE9fYqAaPGoE681l0O1bClfn+tFPBtvGJnFeaC6QkhcFrOBulw==
X-Gm-Message-State: AOJu0YwJUVLrsUyW7tRGoWNeYdOCgUEVrSHlmYaY55ntCpuKixiKH9kl
	7Ml2CMtYgtyuDuXcdCw0ovwK6zoBrcagI854PO3g7q3Xpn9lkEdQDuC47WTiputemHtm5mNGF4b
	U9hztYLcphA4yrE1+lrCz5orHGM8=
X-Google-Smtp-Source: AGHT+IF23aAFo2LYSbazpSjDOWbAdAKsRHExhiDfsFi+eMHe49t3Dylrom1FonaKjaKCP8GUjyuCIIB7agE5jrRixnQ=
X-Received: by 2002:a05:6871:414:b0:23c:9036:1f61 with SMTP id
 586e51a60fabf-24172a15676mr20725484fac.1.1715854898087; Thu, 16 May 2024
 03:21:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <12437901.O9o76ZdvQC@kreacher> <5161bd95-d51e-49cc-bcbd-523fbb747e4b@redhat.com>
 <CAJZ5v0gf-oLcjT8dxnpjAyVfpUep5ST2mHDJy2dySBGCJwjMxg@mail.gmail.com>
 <b53b4fe4-e3b7-4939-a8ea-9eb55f0bece6@redhat.com> <CAJZ5v0i+ejMyj0j7RvVY7+g6eU8bQ9QLG=08fm78i9Ui1fEiVA@mail.gmail.com>
 <2e5c9108-9ca4-4d7c-a062-2a9a5baaf06e@redhat.com>
In-Reply-To: <2e5c9108-9ca4-4d7c-a062-2a9a5baaf06e@redhat.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 16 May 2024 12:21:27 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0ipB1aLCSv9NGukjW8u09qi628sHvgudReV4-=FvrCZMA@mail.gmail.com>
Message-ID: <CAJZ5v0ipB1aLCSv9NGukjW8u09qi628sHvgudReV4-=FvrCZMA@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] ACPI: EC: Install EC address space handler at the
 namespace root
To: Hans de Goede <hdegoede@redhat.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, 
	Linux ACPI <linux-acpi@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Mario Limonciello <mario.limonciello@amd.com>, Armin Wolf <w_armin@gmx.de>, 
	Heikki Krogerus <heikki.krogerus@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, May 16, 2024 at 12:14=E2=80=AFPM Hans de Goede <hdegoede@redhat.com=
> wrote:
>
> Hi,
>
> On 5/16/24 12:09 PM, Rafael J. Wysocki wrote:
> > Hi,
> >
> > On Thu, May 16, 2024 at 11:50=E2=80=AFAM Hans de Goede <hdegoede@redhat=
.com> wrote:
> >>
> >> Hi,
> >>
> >> On 5/16/24 10:37 AM, Rafael J. Wysocki wrote:
> >>> On Thu, May 16, 2024 at 10:35=E2=80=AFAM Hans de Goede <hdegoede@redh=
at.com> wrote:
> >>>>
> >>>> Hi,
> >>>>
> >>>> On 5/15/24 9:39 PM, Rafael J. Wysocki wrote:
> >>>>> Hi Everyone,
> >>>>>
> >>>>> This is an update of
> >>>>>
> >>>>> https://lore.kernel.org/linux-acpi/5787281.DvuYhMxLoT@kreacher/
> >>>>>
> >>>>> which was a follow up for the discussion in:
> >>>>>
> >>>>> https://lore.kernel.org/linux-acpi/CAJZ5v0hiXdv08PRcop7oSYqgr_g5rwz=
RTj7HgdNCCGjXeV44zA@mail.gmail.com/T/#t
> >>>>>
> >>>>> Patch [1/2] has been updated to avoid possible issues related to
> >>>>> systems with defective platform firmware and patch [2/2] is a resen=
d
> >>>>> with a couple of tags added.
> >>>>
> >>>> Thanks, the series looks good to me:
> >>>>
> >>>> Reviewed-by: Hans de Goede <hdegoede@redhat.com>
> >>>>
> >>>> for the series.
> >>>>
> >>>> I assume you are going to send this in as a fix for 6.10 ?
> >>>
> >>> Yes, I am.
> >>>
> >>>> In that case feel free to merge both patches through the
> >>>> linux-pm tree.
> >>>
> >>> Thank you!
> >>
> >> Hmm, I just realized that this:
> >>
> >> https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers=
-x86.git/commit/?h=3Dfor-next&id=3Dc663b26972eae7d2a614f584c92a266fe9a2d44c
> >>
> >> Is part of the main pdx86 pull-request for 6.10 which I'm going to
> >> send to Linus in the next 10 minutes or so. So that is going to
> >> conflict with your 2/2.
> >>
> >> Options:
> >>
> >> a) You only send 1/2 upstream as a fix and I'll then send a rebased
> >> 2/2 upstream as part of the first pdx86 pull-request.
> >>
> >> b) You merge the git://git.kernel.org/pub/scm/linux/kernel/git/pdx86/p=
latform-drivers-x86.git
> >> platform-drivers-x86-v6.10-1 tag (which is the tag for the pull-reques=
t
> >> I'm about to send to Linus) and rebase on top of that before sending
> >> a pull-request for both to Linus.
> >
> > I would rather wait for Linus to merge your PR and merge my changes on
> > top of his merge.
>
> That is fine too. I just send out the pull-request so hopefully Linus wil=
l
> merge it soon(ish).
>
> Note (stating the obvious) when rebasing 2/2 you will pretty much need to
> remove all the new code added by:
>
> https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x8=
6.git/commit/?id=3Dc663b26972eae7d2a614f584c92a266fe9a2d44c

I see, thanks for the notice!

