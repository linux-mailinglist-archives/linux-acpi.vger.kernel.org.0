Return-Path: <linux-acpi+bounces-9938-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CE3609E530C
	for <lists+linux-acpi@lfdr.de>; Thu,  5 Dec 2024 11:54:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A2AA28850C
	for <lists+linux-acpi@lfdr.de>; Thu,  5 Dec 2024 10:54:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B3BC1D63F2;
	Thu,  5 Dec 2024 10:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sd89kMrE"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15093199FA4
	for <linux-acpi@vger.kernel.org>; Thu,  5 Dec 2024 10:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733396089; cv=none; b=gUP90i7U1FGsMtFCF1mp/0Qhm+x+6kwtFe643j87IG0pAePQ3WY9Xz0blVNk0kY+zGS8PZc3Ilm2nlGO7GZVMN/eqYapq0BmzkcYd6y9E7qmBRZRIh4Jh2km3qrG3BP2zGO3FWVbz5zcHE0FtQJbZtO7py/maXcZ6K/i+fnABwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733396089; c=relaxed/simple;
	bh=BdUBP0mf5EjSuforn5WQR+yX3nbD0UCGKJ6aavJwAdw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QAXgYx59uE/e04DuPP1U5ofJ1GnimyNrhaLvOu+vNGYH5AJPu1PJHz5+M0YhfHOgXfKYcSYtjg/YFZeJdmij8CbdkeRP2foxkLzew+oj3gbgnt81xTw+ILKTNeHDMa4KobZ7CqHNq3nh77zjGzdYmLh5Soc/gsMrbaPBhczObIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sd89kMrE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84D47C4CED1
	for <linux-acpi@vger.kernel.org>; Thu,  5 Dec 2024 10:54:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733396088;
	bh=BdUBP0mf5EjSuforn5WQR+yX3nbD0UCGKJ6aavJwAdw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=sd89kMrELIUmIGGFfPB8ayrQNezCqXbd6qRVe4CcItyPZGEdHmVANrBxfuz+LWjVw
	 FGT14pu3RRXAnHzeYQK/xWunqAxOeQFEiNtR9UfHiBkCvp3KvYrU437SFUot/jNedW
	 Row1EVoL4fHaApO1LTH5P3UoGTBw72BSfe3ACtMW40oColeHJ4wy6DRBWY/vUB+6Ig
	 yRnP4LkaNvSngPlt3zCzpzOTM+KMB6MlIvO6EECFvEeuWfJvL5uP7no6D0eXkFNJ1E
	 8ifdIVlyLDFAer8ENjvUMQ5DKeapAqJl1olGK3xTaftexEztyd1au3HsttqDZL9BER
	 022rV8fHz8Ruw==
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-29e579b9e9aso524127fac.1
        for <linux-acpi@vger.kernel.org>; Thu, 05 Dec 2024 02:54:48 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXZZTITn+lEllhDjwSJZKGZVaavT6SUTNrLfc+mSLi5Y680RayVmRNkW853Z8XRGpttYQL+U8Q6VbgN@vger.kernel.org
X-Gm-Message-State: AOJu0YykZt8bo9HIRQnK1DQ1KP3Sw+9+OEu+UFLRLQ7muI/NhE6cSwY0
	/YGfTtyvnnl+yKfmvifSD9i0zHSJCsPKGF7pzrQ//jLIsX1cwYoXyLPurAT0LBs6tI3cKFe2Rjg
	vMIOoISPbHPNy3RlKwN/8rSAZVaM=
X-Google-Smtp-Source: AGHT+IFsuyRopIAmQzcXa9P53pW8wgWowsdn78TB5Z//KKg/Z13TgsfpjQS0PeiJmin2FchTMTnYxnQu1SIcydaBKlU=
X-Received: by 2002:a05:6871:e415:b0:260:f883:95f9 with SMTP id
 586e51a60fabf-29e888ee6aemr10564798fac.42.1733396087840; Thu, 05 Dec 2024
 02:54:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <4542595.LvFx2qVVIh@kreacher> <2927980.e9J7NaK4W3@kreacher>
 <C20272A3-65B5-4AAD-B6AD-0B93A95C5D93@gmail.com> <CAJZ5v0jeE=3-0ad7OMWETnhYfQE+fhw2dQTfYTmn=_6gDnDghQ@mail.gmail.com>
 <2D27B47A-A6EB-487C-8DEA-6792A0BAE886@gmail.com>
In-Reply-To: <2D27B47A-A6EB-487C-8DEA-6792A0BAE886@gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 5 Dec 2024 11:54:36 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0hzHONOO=JCCniQONPAhFMLuDaWO=_n=fpStEQyaYP5hg@mail.gmail.com>
Message-ID: <CAJZ5v0hzHONOO=JCCniQONPAhFMLuDaWO=_n=fpStEQyaYP5hg@mail.gmail.com>
Subject: Re: [PATCH v3 2/7] ACPI: scan: Extract CSI-2 connection graph from _CRS
To: Miao Wang <shankerwangmiao@gmail.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, 
	Linux ACPI <linux-acpi@vger.kernel.org>, Sakari Ailus <sakari.ailus@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 5, 2024 at 8:24=E2=80=AFAM Miao Wang <shankerwangmiao@gmail.com=
> wrote:
>
>
> > 2024=E5=B9=B412=E6=9C=884=E6=97=A5 03:44=EF=BC=8CRafael J. Wysocki <raf=
ael@kernel.org> =E5=86=99=E9=81=93=EF=BC=9A
> >
> > Hi,
> >
> > Sorry for the delay.
> >
> > On Thu, Nov 21, 2024 at 10:57=E2=80=AFPM Miao Wang <shankerwangmiao@gma=
il.com> wrote:
> >>
> >> 2023=E5=B9=B411=E6=9C=887=E6=97=A5 00:09=EF=BC=8CRafael J. Wysocki <rj=
w@rjwysocki.net> =E5=86=99=E9=81=93=EF=BC=9A
> >>>
> >>> +static acpi_status acpi_bus_check_add(acpi_handle handle, bool first=
_pass,
> >>>                                    struct acpi_device **adev_p)
> >>>  {
> >>>      struct acpi_device *device =3D acpi_fetch_acpi_dev(handle);
> >>> @@ -2054,9 +2059,25 @@ static acpi_status acpi_bus_check_add(ac
> >>>              if (acpi_device_should_be_hidden(handle))
> >>>                      return AE_OK;
> >>>
> >>> -            /* Bail out if there are dependencies. */
> >>> -            if (acpi_scan_check_dep(handle, check_dep) > 0)
> >>> -                    return AE_CTRL_DEPTH;
> >>> +            if (first_pass) {
> >>> +                    acpi_mipi_check_crs_csi2(handle);
> >>> +
> >>> +                    /* Bail out if there are dependencies. */
> >>> +                    if (acpi_scan_check_dep(handle) > 0) {
> >>> +                            /*
> >>> +                             * The entire CSI-2 connection graph nee=
ds to be
> >>> +                             * extracted before any drivers or scan =
handlers
> >>> +                             * are bound to struct device objects, s=
o scan
> >>> +                             * _CRS CSI-2 resource descriptors for a=
ll
> >>> +                             * devices below the current handle.
> >>> +                             */
> >>> +                            acpi_walk_namespace(ACPI_TYPE_DEVICE, ha=
ndle,
> >>> +                                                ACPI_UINT32_MAX,
> >>> +                                                acpi_scan_check_crs_=
csi2_cb,
> >>> +                                                NULL, NULL, NULL);
> >>> +                            return AE_CTRL_DEPTH;
> >>> +                    }
> >>> +            }
> >>>
> >>>              fallthrough;
> >>>      case ACPI_TYPE_ANY:     /* for ACPI_ROOT_OBJECT */
> >>>
> >>
> >> Hi, I'd like to report some issues caused by this patch. Correct me if=
 I'm wrong
> >> since I'm not expert on ACPI. Before this patch, properties of ACPI de=
vices with
> >> _DEP relationship declared were evaluated after the initialization of =
the
> >> depending devices, i.e. the execution of handler->attach(). With this =
patch,
> >> _CRS of all the ACPI devices are evaluated to check if the device cont=
ains a
> >> CSI2 resource, regardless of the declaration of _DEP relationship.

[cut]

>
> Maybe we can prioritize the initialization of the PCI host bridge to
> fully eliminate this issue?

The problem with this is that the current code requires struct
acpi_device objects to be present for all PCI devices that have
corresponding objects in the ACPI Namespace at the time when the host
bridge is initialized because that causes the PCI bus to be scanned
for devices and struct acpi_device objects are looked up from there.

To make this work, the "ACPI companion lookup" code needs to be
changed and that would be kind of a heavy lifting and it may introduce
some unexpected enumeration ordering issues.

Alternatively, the PCI host bridge could be initialized early, but
without scanning the PCI bus which would be scanned at the time when
all of the struct acpi_device objects are present.  It looks like this
could be made work, but it would require some investigation and code
refactoring.

