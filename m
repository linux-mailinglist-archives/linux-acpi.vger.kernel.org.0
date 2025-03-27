Return-Path: <linux-acpi+bounces-12514-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EF54FA73EC6
	for <lists+linux-acpi@lfdr.de>; Thu, 27 Mar 2025 20:41:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5AF183BEF64
	for <lists+linux-acpi@lfdr.de>; Thu, 27 Mar 2025 19:39:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEB3F22FDEF;
	Thu, 27 Mar 2025 19:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Eh8S5WyK"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 887211C5D6C;
	Thu, 27 Mar 2025 19:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743104194; cv=none; b=K/h2y112H+4iMX1wjmI98daZjyyCrfln1NpEA1cBaksc3zZYmgflmvPZJRJDFbpqO8CrNT8Vbxoi2BoCMO6ur7vJVZIzBOi1b/4Hzhy1hbCqSdAEoX2Ml08iwyolnO/kRLoATYZJ15cfq1Ers56O01MYPAKorWwl4H2AH3mttxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743104194; c=relaxed/simple;
	bh=MWCe7oKa9LJV3uUJ0pa/D8DM2BFCRPDwbe55B9EXvSA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aAvrhUlsvMjTKg6nxQm6gUPRKp0BnqS0yHoBktKmctzP99XIrNDytL3D2kEtYp0GCs5rNPHgyYwLka4uFNp2ommEBkvBN4boIYR0xI/levgnpT0z7yPjFoErXkurGdzE2LWlx7UtyvErTvTjFHi+RYZP8Y9fanolgBWSXGEnC3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Eh8S5WyK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E94B4C2BCB4;
	Thu, 27 Mar 2025 19:36:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743104194;
	bh=MWCe7oKa9LJV3uUJ0pa/D8DM2BFCRPDwbe55B9EXvSA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Eh8S5WyKpuggFjBQ8DgPqkayAr2zB0DrUVNU4SRrV4AcO+oLicYrPndyfOtNej1WS
	 hpD+wnK5UI7dnqM7YSWATJyX7bhSprxkuqcxBgsLP1f1Vx2Ur35flKpQC+bQ7kbdJZ
	 h4T8kTnBQHhgorEFzFRcY4JiCziBAI6+OyJAmBn20EHFavUd4/K74HssW7EQFOsoxe
	 /kntB7dNTQyeXSg/oVis2lLCo02/U80hndpyyJUvd5IKZWpzW8STeh043kRAD34Zbk
	 tTZ7ThEbeDp0UeAklezXN0oHvKRhnHgk6qbJBzK1PTsVlOm6JHnq4wDosa5awcRYkl
	 eEtSo+BAHkzdg==
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-72bb97260ceso411485a34.1;
        Thu, 27 Mar 2025 12:36:33 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU/4cXkp3wPwAm5bFrpnCF6mLlyZQhv+r0PX0Zm696MywlZeMURDr+FDPqYsnsvOj8jCAp7HJCivurN@vger.kernel.org, AJvYcCUF1AlPH/jDAfO41U93uxXpjL0fk7dvsj5S92IM1I8Tge+DAENuzciKrhP9cyqZJ+U4iW3nQ0AEM3oU1wbgJEU=@vger.kernel.org, AJvYcCW+GSIwK8AIRR2Qp9H4qyAMosNZa3O4ZLQ6fzTc29D5cg/3ZXlW+bmPJWHE2Dg4P/oBnn56WAJ2JFZPm8oz@vger.kernel.org
X-Gm-Message-State: AOJu0Yyb7EGJg6E0EvyuN2eHwNh+7aLh2lEp9MIcbh/B24rPhxHhn24S
	EK9cMYhC81H0En+WDe9dI7eDF3LCkwtX1SM8XjKOVWrd1TyDz4SNbBycjXMdrOTrbzTNTPu8YDS
	TexL4IDPajJsq8PswWVekCqAr3X0=
X-Google-Smtp-Source: AGHT+IFYJEH/GBkCoyxgjCZKobIjKQ32lIwPJmKFN6375XMv5X6Zm5IiBkQa4InpYz4Mrw75lvtlU9/G2jfgDgMlSAQ=
X-Received: by 2002:a05:6870:e393:b0:29e:5cb1:b148 with SMTP id
 586e51a60fabf-2c847f2c9cfmr3051708fac.6.1743104193121; Thu, 27 Mar 2025
 12:36:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250317-ivo-intel_oc_wdt-v3-0-32c396f4eefd@siemens.com>
 <20250317-ivo-intel_oc_wdt-v3-2-32c396f4eefd@siemens.com> <1beeb77c-83d6-4634-ba39-2b40efbb8437@siemens.com>
 <CAJZ5v0jh1jJy+YRMtLDnYqAhPrN2Pox+NY0Vqh_uqb7F=NwqEg@mail.gmail.com>
 <54d3c7a8-1392-4870-9bd6-48aebe3881f1@siemens.com> <9f4e560e-35c1-413f-be83-d537abf41183@roeck-us.net>
In-Reply-To: <9f4e560e-35c1-413f-be83-d537abf41183@roeck-us.net>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 27 Mar 2025 20:36:21 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0j5-5LRPOkBA84Q9KatMh53btKC_jXFwnxgfUQ7H4Q60w@mail.gmail.com>
X-Gm-Features: AQ5f1JppsboRum-5Qw-Mo5ecnQauw3SkcipMRzy80dwhv2aD3rW6uwWTb6BtnC8
Message-ID: <CAJZ5v0j5-5LRPOkBA84Q9KatMh53btKC_jXFwnxgfUQ7H4Q60w@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] ACPI: PNP: Add Intel OC Watchdog IDs to non-PNP
 device list
To: Guenter Roeck <linux@roeck-us.net>, Diogo Ivo <diogo.ivo@siemens.com>
Cc: Len Brown <lenb@kernel.org>, Wim Van Sebroeck <wim@linux-watchdog.org>, 
	linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, 
	linux-watchdog@vger.kernel.org, jan.kiszka@siemens.com, 
	benedikt.niedermayr@siemens.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 26, 2025 at 3:02=E2=80=AFPM Guenter Roeck <linux@roeck-us.net> =
wrote:
>
> On 3/26/25 02:01, Diogo Ivo wrote:
> > On 3/25/25 6:59 PM, Rafael J. Wysocki wrote:
> >> On Tue, Mar 25, 2025 at 6:19=E2=80=AFPM Diogo Ivo <diogo.ivo@siemens.c=
om> wrote:
> >>>
> >>> Hello,
> >>>
> >>> On 3/17/25 10:55 AM, Diogo Ivo wrote:
> >>>> Intel Over-Clocking Watchdogs are described in ACPI tables by both t=
he
> >>>> generic PNP0C02 _CID and their ACPI _HID. The presence of the _CID t=
hen
> >>>> causes the PNP scan handler to attach to the watchdog, preventing th=
e
> >>>> actual watchdog driver from binding. Address this by adding the ACPI
> >>>> _HIDs to the list of non-PNP devices, so that the PNP scan handler i=
s
> >>>> bypassed.
> >>>>
> >>>> Note that these watchdogs can be described by multiple _HIDs for wha=
t
> >>>> seems to be identical hardware. This commit is not a complete list o=
f
> >>>> all the possible watchdog ACPI _HIDs.
> >>>>
> >>>> Signed-off-by: Diogo Ivo <diogo.ivo@siemens.com>
> >>>> ---
> >>>> v2->v3:
> >>>>    - Reword the commit message to clarify purpose of patch
> >>>> ---
> >>>> ---
> >>>>    drivers/acpi/acpi_pnp.c | 2 ++
> >>>>    1 file changed, 2 insertions(+)
> >>>>
> >>>> diff --git a/drivers/acpi/acpi_pnp.c b/drivers/acpi/acpi_pnp.c
> >>>> index 01abf26764b00c86f938dea2ed138424f041f880..3f5a1840f573303c71f5=
d579e32963a5b29d2587 100644
> >>>> --- a/drivers/acpi/acpi_pnp.c
> >>>> +++ b/drivers/acpi/acpi_pnp.c
> >>>> @@ -355,8 +355,10 @@ static bool acpi_pnp_match(const char *idstr, c=
onst struct acpi_device_id **matc
> >>>>     * device represented by it.
> >>>>     */
> >>>>    static const struct acpi_device_id acpi_nonpnp_device_ids[] =3D {
> >>>> +     {"INT3F0D"},
> >>>>        {"INTC1080"},
> >>>>        {"INTC1081"},
> >>>> +     {"INTC1099"},
> >>>>        {""},
> >>>>    };
> >>>>
> >>>>
> >>>
> >>> Gentle ping on this patch.
> >>
> >> Do you want me to pick it up or do you want to route it through a
> >> different tree?
> >
> > Unless the watchdog maintainers have any objections it's fine if you
> > pick it up.
> >
>
> Ok with me.

Applied as 6.15-rc material, thanks!

