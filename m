Return-Path: <linux-acpi+bounces-12213-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D3DDA5FA09
	for <lists+linux-acpi@lfdr.de>; Thu, 13 Mar 2025 16:33:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E02A19C5C53
	for <lists+linux-acpi@lfdr.de>; Thu, 13 Mar 2025 15:32:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D45126980A;
	Thu, 13 Mar 2025 15:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mdemwfWv"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61ED32690EA;
	Thu, 13 Mar 2025 15:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741879796; cv=none; b=Jhljm8f6JmOS5ve5RhzNWiuTj6gMFFxBec/g4CfUcbPGU9bVXUqypJN+DhxpShEx8CuRbiVdPoDSYOtBMGth5C2Xw/pesqMu7nygNQirsH/ZKtpDMB6L2xs99A1lTLFG/lGuoJpWpg9+tWe/1pe6714RNrPyMua8BwZE3rx53m0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741879796; c=relaxed/simple;
	bh=KOcaqJ+jOjwttb1Rn+NciPwgA/FfTTO/vnYTOKl6pjo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=O+i5LJTY8p6fvX3xjJehDSCPxIioEuD4IIu/N3Q7v6uobwaK+FtKep/MBvVi7P6v1oQyscNROeryNe1O6C1sdlbBIWFJJT3vvluTsy6qMhlYSP8/i5RYZKZk9vHua/tAaYEhgi38bKSYF4wLQF4I1h+BT9scBsV9WHd/nkOracw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mdemwfWv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD68BC4CEEF;
	Thu, 13 Mar 2025 15:29:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741879795;
	bh=KOcaqJ+jOjwttb1Rn+NciPwgA/FfTTO/vnYTOKl6pjo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=mdemwfWvUCEcgVWYzbVaiMG4f1cjRSg/mFKyKtyBy5aWVOult6kadPsi0ScU/Ogop
	 zLLzNr6KID6yV/l3g/EazKUStkYdsgmKwHOWB2FHzEy/wB1UKm8rGzkbpRUnVNq2Vb
	 ZoyX+BCY7eAzRc/MZz1yldzFT7DdmaZkMxaxoOCnYV5rG2Us9JMhexnnPwokwOc01Z
	 dRXgjfUg62DrWxdq3HxdJms4N5dBFly4bI8rDMheh3EtDc7u0lRzbk9hecjNJsUWSk
	 uOuO9Uu+cNgeVjhy0PVtqxs3WMXZCdskP+ogfmRl03fbmdvEchh3GqZz4RnfkQ+tMB
	 azXDTJpUT12SA==
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-2c1caacc1f7so662775fac.3;
        Thu, 13 Mar 2025 08:29:55 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWC2bbDhVOsl9eCsLcBKpA6CHef8kJwJWcsQ4LiuEKLWOg3dqQnDMWgBidhxuiH9zeheBl1XPlR5z7juR4sJdQ=@vger.kernel.org, AJvYcCWYP+2w1OzW0IUV/uS/sLqSb/9UQg2BoqFi9o6GfTalRhcRJrCWGwn4dsP5xluUjX9mzcbYbDBQZ5PL@vger.kernel.org, AJvYcCWoQosovXdSvVVk6FuSukEEAwW+eprFC1RuZZ7Y2vidD+Wxwt6+ho6HhyN2LNL2m9/o5JxxzQQwOnfC9pKP@vger.kernel.org
X-Gm-Message-State: AOJu0YzEwixqosTmAnVS/v8jGK6prv/4IZBmXGTsTZnWXZLkD/A4i4qD
	A3IN8zhyyI+/cvgHbz8/35+WKghCY5i2am0sZxGugqebub8XTn9fGaE7sGZqUMpI+3rONnZeE2e
	PfciBdA5861xI2HmGv/tnruBnWeQ=
X-Google-Smtp-Source: AGHT+IHMtXKQWrypSPm9vK+VaGkMq73Nn9oqs+qKkdJNhyBFxYSjvgA4skVIn6H1wfVTtmOBiF18M6xbsYvphIqwnYA=
X-Received: by 2002:a05:6870:71cf:b0:2c2:3eb4:e53 with SMTP id
 586e51a60fabf-2c2e89ee38emr6680729fac.37.1741879795151; Thu, 13 Mar 2025
 08:29:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250312-ivo-intel_oc_wdt-v2-0-52d09738cd0b@siemens.com>
 <20250312-ivo-intel_oc_wdt-v2-2-52d09738cd0b@siemens.com> <CAJZ5v0iBcxGcqp88kHN64WddvmC-y6F1XaFeSNHFYuQnayg7dQ@mail.gmail.com>
 <63e69331-bb8f-45f6-adb8-872f594fa02e@siemens.com>
In-Reply-To: <63e69331-bb8f-45f6-adb8-872f594fa02e@siemens.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 13 Mar 2025 16:29:44 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0ij0UyLr+tBBia-M4Y7grs+w3fhxnuvRCh67YXPe3h=ig@mail.gmail.com>
X-Gm-Features: AQ5f1JpOVlg_sQUPDaaKSJ09s36TukH120JPROOUwYfDdD8mzVD1N6OT7eiy4Z4
Message-ID: <CAJZ5v0ij0UyLr+tBBia-M4Y7grs+w3fhxnuvRCh67YXPe3h=ig@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] ACPI: PNP: Add Intel OC Watchdog IDs to non-PNP
 device list
To: Diogo Ivo <diogo.ivo@siemens.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
	Wim Van Sebroeck <wim@linux-watchdog.org>, Guenter Roeck <linux@roeck-us.net>, 
	linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, 
	linux-watchdog@vger.kernel.org, jan.kiszka@siemens.com, 
	benedikt.niedermayr@siemens.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Mar 13, 2025 at 11:28=E2=80=AFAM Diogo Ivo <diogo.ivo@siemens.com> =
wrote:
>
> Hi Rafael,
>
> On 3/12/25 7:31 PM, Rafael J. Wysocki wrote:
> > On Wed, Mar 12, 2025 at 4:46=E2=80=AFPM Diogo Ivo <diogo.ivo@siemens.co=
m> wrote:
> >>
> >> With the kernel having an ACPI driver for these watchdog devices add
> >> their IDs to the known non-PNP device list. Note that this commit is
> >> not a complete list of all the possible watchdog IDs.
> >>
> >> Signed-off-by: Diogo Ivo <diogo.ivo@siemens.com>
> >> ---
> >>   drivers/acpi/acpi_pnp.c | 2 ++
> >>   1 file changed, 2 insertions(+)
> >>
> >> diff --git a/drivers/acpi/acpi_pnp.c b/drivers/acpi/acpi_pnp.c
> >> index 01abf26764b00c86f938dea2ed138424f041f880..3f5a1840f573303c71f5d5=
79e32963a5b29d2587 100644
> >> --- a/drivers/acpi/acpi_pnp.c
> >> +++ b/drivers/acpi/acpi_pnp.c
> >> @@ -355,8 +355,10 @@ static bool acpi_pnp_match(const char *idstr, con=
st struct acpi_device_id **matc
> >>    * device represented by it.
> >>    */
> >>   static const struct acpi_device_id acpi_nonpnp_device_ids[] =3D {
> >> +       {"INT3F0D"},
> >>          {"INTC1080"},
> >>          {"INTC1081"},
> >> +       {"INTC1099"},
> >>          {""},
> >>   };
> >>
> >>
> >> --
> >
> > Is there a particular reason for this patch?
>
> Yes, since the ACPI tables for these watchdogs have both a PNP0C02 CID an=
d
> and then an HID (such as INT3F0D or INTC1099) without this patch the driv=
er
> in patch 01 will not bind to the device because PNP will bind to it first=
.
> My understanding is that this table was added to solve exactly this probl=
em
> so I added these HIDs here, but if this is wrong and I misunderstood
> please let me know.

You are right, but the above information is missing from the
changelog.  Please add it there.

