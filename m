Return-Path: <linux-acpi+bounces-12424-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 39F70A709EE
	for <lists+linux-acpi@lfdr.de>; Tue, 25 Mar 2025 20:06:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 49A4919A0251
	for <lists+linux-acpi@lfdr.de>; Tue, 25 Mar 2025 18:59:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEFB44A21;
	Tue, 25 Mar 2025 18:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Iz9YJ/Eh"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F82019049A;
	Tue, 25 Mar 2025 18:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742929168; cv=none; b=IjKU4m1rUVOfNTGO0l0stSTI9oTryKhDKnHlyIBi6CQk8bbCbodCayCeZzhxcIdNnnR26qjeuV0bNC5IVJANGstD09suKRo3AZMAE3cxe1ewriAmwkdIIa2ZuzQMx9n01LbcrNhQihHVc8DGITU4DYpyWOHnpyckEWFEfyNh7bE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742929168; c=relaxed/simple;
	bh=9LVQC+aIvaoTYsz1PD07JOGItrLOSYoDZl8VS7cgO18=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=d8JGFsbWokIpMYiq2A2QJNWw9cVKHDzABGtkrc/shCj3l9DznJEt+1R5FKfWl7hpiMeGJqcUOUSvbTHmgezGTgVAZWoPw8koCsTcZTX2hTJhbrO4tqJmAxicOCm3Mu/MyU0qp/71RSeAzW3j3q3UcHD63+bh+hH49XLdqJ59rtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Iz9YJ/Eh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2945BC4CEE4;
	Tue, 25 Mar 2025 18:59:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742929168;
	bh=9LVQC+aIvaoTYsz1PD07JOGItrLOSYoDZl8VS7cgO18=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Iz9YJ/EhQZXeGnQD4IYmnwuPI0GmITr9xbroo1tjRiHIe21N+VYnK0kOhpEyKCGYj
	 c7Ss4gE2LcryCD8MIkGYoSX2eCv9LFewUf/KSellZb8YumK1pLf8b1+l/Gw+MmizOa
	 T7oYpcrI7Q8sopsTkRuLJBZsxNNhkpn45Q2YZLgOVYTH0R3Hd6aGLEIYFKZhdxvOLL
	 equ4yP8y9fz5fhnvYb//YRvpF7m4M3K/TIpuRI3OWRf3ItCj63YaB1GcgFYZGsVc60
	 7WBB9r3Gi/ZhxaAUUHIccTdYRfySvw82vFqkTKYe8YaGMzmQzVOnnJ54pQmY0kqjD3
	 RjIlgbeTXpsLw==
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-2c2ada8264aso2608612fac.2;
        Tue, 25 Mar 2025 11:59:28 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUGjbRlwXJteJHIIOYIZ67zCxA4LUXfhBjAY516Zx1GsY76c7p3bSBFEf2hZgLxO0JplZyz5gtIyM2EU183@vger.kernel.org, AJvYcCVgKzxsgBuFzBDIosHp54F0zmfIefgtlVnKQpioOdCm/qh15GMvlKfvLfwbptT5dmGFanx3NKrZEEpwkljuMPY=@vger.kernel.org, AJvYcCWxz79TAgxawb413mOXicIsjlUn/C35JYiFJez2IF2hd4UkNI1tmlYfuxAgjzgRr+fP9uL261k2hsAB@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5dsY7Sa3wV/igrAetx0EpMJ4ZQpVENCJCqvMcNcbita8cRIEO
	ud9/+fr00QYan7YOathPaYu4ehDn6FadaqujCxXA9LVuXlTK8qKLVMZimU5nd6SnI2DxSA2Rc8Y
	cX32HMmHne0XYSDdiUknKVy9K55w=
X-Google-Smtp-Source: AGHT+IGYFDih76ZCcI4DFKFSbsLWidus3XA5/4LpT4w95waG2KqujFRpK+jyOo/5/j2lGBD6q/ezXcymcHZJHmVrqTs=
X-Received: by 2002:a05:6870:46a8:b0:2c2:3ae9:5b9c with SMTP id
 586e51a60fabf-2c7801fe4d5mr12078147fac.2.1742929167443; Tue, 25 Mar 2025
 11:59:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250317-ivo-intel_oc_wdt-v3-0-32c396f4eefd@siemens.com>
 <20250317-ivo-intel_oc_wdt-v3-2-32c396f4eefd@siemens.com> <1beeb77c-83d6-4634-ba39-2b40efbb8437@siemens.com>
In-Reply-To: <1beeb77c-83d6-4634-ba39-2b40efbb8437@siemens.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 25 Mar 2025 19:59:14 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0jh1jJy+YRMtLDnYqAhPrN2Pox+NY0Vqh_uqb7F=NwqEg@mail.gmail.com>
X-Gm-Features: AQ5f1JpddNTTHybEk3zZj11Lb5Jq8iuktb-1Vetg4y60p60aQiC_Sr6tzkoGS6k
Message-ID: <CAJZ5v0jh1jJy+YRMtLDnYqAhPrN2Pox+NY0Vqh_uqb7F=NwqEg@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] ACPI: PNP: Add Intel OC Watchdog IDs to non-PNP
 device list
To: Diogo Ivo <diogo.ivo@siemens.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
	Wim Van Sebroeck <wim@linux-watchdog.org>, Guenter Roeck <linux@roeck-us.net>, 
	linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, 
	linux-watchdog@vger.kernel.org, jan.kiszka@siemens.com, 
	benedikt.niedermayr@siemens.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 25, 2025 at 6:19=E2=80=AFPM Diogo Ivo <diogo.ivo@siemens.com> w=
rote:
>
> Hello,
>
> On 3/17/25 10:55 AM, Diogo Ivo wrote:
> > Intel Over-Clocking Watchdogs are described in ACPI tables by both the
> > generic PNP0C02 _CID and their ACPI _HID. The presence of the _CID then
> > causes the PNP scan handler to attach to the watchdog, preventing the
> > actual watchdog driver from binding. Address this by adding the ACPI
> > _HIDs to the list of non-PNP devices, so that the PNP scan handler is
> > bypassed.
> >
> > Note that these watchdogs can be described by multiple _HIDs for what
> > seems to be identical hardware. This commit is not a complete list of
> > all the possible watchdog ACPI _HIDs.
> >
> > Signed-off-by: Diogo Ivo <diogo.ivo@siemens.com>
> > ---
> > v2->v3:
> >   - Reword the commit message to clarify purpose of patch
> > ---
> > ---
> >   drivers/acpi/acpi_pnp.c | 2 ++
> >   1 file changed, 2 insertions(+)
> >
> > diff --git a/drivers/acpi/acpi_pnp.c b/drivers/acpi/acpi_pnp.c
> > index 01abf26764b00c86f938dea2ed138424f041f880..3f5a1840f573303c71f5d57=
9e32963a5b29d2587 100644
> > --- a/drivers/acpi/acpi_pnp.c
> > +++ b/drivers/acpi/acpi_pnp.c
> > @@ -355,8 +355,10 @@ static bool acpi_pnp_match(const char *idstr, cons=
t struct acpi_device_id **matc
> >    * device represented by it.
> >    */
> >   static const struct acpi_device_id acpi_nonpnp_device_ids[] =3D {
> > +     {"INT3F0D"},
> >       {"INTC1080"},
> >       {"INTC1081"},
> > +     {"INTC1099"},
> >       {""},
> >   };
> >
> >
>
> Gentle ping on this patch.

Do you want me to pick it up or do you want to route it through a
different tree?

