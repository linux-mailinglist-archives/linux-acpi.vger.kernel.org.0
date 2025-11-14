Return-Path: <linux-acpi+bounces-18911-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FED1C5E7CC
	for <lists+linux-acpi@lfdr.de>; Fri, 14 Nov 2025 18:15:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id D96133C39E6
	for <lists+linux-acpi@lfdr.de>; Fri, 14 Nov 2025 15:57:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84FD633AD96;
	Fri, 14 Nov 2025 15:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NDYGuzXH"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6081825CC63
	for <linux-acpi@vger.kernel.org>; Fri, 14 Nov 2025 15:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763135279; cv=none; b=edZ49axvuiDSY+cpdUWLDt6xVbLnCjGtaBGeNNzpMNfCuNUHc8c0S2LCxpu5atuxPKbeluMuer+YQcu8iW+yruRAvSPULa08jq59ShEhjoX5tZpM+IzNihKYZu1aB5mEYXbuvzGAMO3jaYPhmxgzVDiKZ3fzmTHnSRb+CGokqK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763135279; c=relaxed/simple;
	bh=stYMW1rnbrIOJU/HCe8c2XsnCESX1XxV9Q1N61dG3jM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dBq253Db2dcjxUf5jTxxKLMfvxOcljO55PQ0f3FcNQAE5ZECrkE7AKq76kOZaHE6REKkOMusRfpHvUCbl+ZokFwMpmNBCIoApMqOGNW02V+3Bx4ICnj0hWMxFih5AOk8MvSsbtYJMvGWC+9GjKC1XEPhCNCFWxHYCo05HRPl5Ms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NDYGuzXH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 000C6C2BC87
	for <linux-acpi@vger.kernel.org>; Fri, 14 Nov 2025 15:47:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763135279;
	bh=stYMW1rnbrIOJU/HCe8c2XsnCESX1XxV9Q1N61dG3jM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=NDYGuzXH5AjU1E/CFae7U6SJc6Ycx/5BRD3jpNwOowuA5Y8QwEZ96DKRz7bnWaOqJ
	 azP5JnSrCUY/iL3TViox5PMhy/0hyjavTo8CL6TZgG18rwNfNM9xONot0qfvwlksSO
	 x9xMwEKJAzNdpT3H9pbqyuOPxAgJNzqobS7oHcivFRPRekBGpIHSRvrZQoJRtiR9ei
	 T30PgPoVU/6lA/cFyJZATjRTDYfet+qh3cXCGvQvwJDke4hCsywzfOL54jh9KdeuFZ
	 xEhXr13L4ukwYEvq02sGUtjxtFzngQn0yJiudECmnQUNpCDUPO8Com9/SfmVCE6LZO
	 969C5ohkVrGQA==
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-3e2d1477b9cso1279301fac.2
        for <linux-acpi@vger.kernel.org>; Fri, 14 Nov 2025 07:47:58 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWo195UIIjcypEidDkkFjTyaWwmuthQzWh5v5Zv/j4igpOtJcDcxCAfGLXzyh1gddJElK5C/haJOGMQ@vger.kernel.org
X-Gm-Message-State: AOJu0YxUH0sos0GywAKkOgmLIrHemoApMK6e2YYTQZ+k96CqpwcQm5DZ
	FGBObLWNSf5or/mt3fQCVpBaQ/uM/Ai7uKUUGS2Z3m6TOBk/hil47vXF1PsYKKq1w6QNDF39nLF
	jBIXGm/hX4gr5apqRXrX3dVq0UKkotDI=
X-Google-Smtp-Source: AGHT+IHRit2A37TKNPjuZK9ZMkd4G/ceai1V9BJH04MolVXSzi+VFZEKcQYGSg5c5s8cFBv+m2f2WyG2KFLGrtPtfpY=
X-Received: by 2002:a05:6870:2f0f:b0:3d2:4319:38eb with SMTP id
 586e51a60fabf-3e86920a6f1mr1978863fac.47.1763135278183; Fri, 14 Nov 2025
 07:47:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <5959587.DvuYhMxLoT@rafael.j.wysocki> <3932581.kQq0lBPeGt@rafael.j.wysocki>
 <20251114090253.n5m43jdvg5rv2bbb@lcpd911>
In-Reply-To: <20251114090253.n5m43jdvg5rv2bbb@lcpd911>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 14 Nov 2025 16:47:46 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0j9fpyrfAR_rsJqm2vRniHoztthn-qMT6qCVjSuOoWRrA@mail.gmail.com>
X-Gm-Features: AWmQ_bmmfmp7pAFxwns4oHH-oyDNtWInQ7WBvGgBPjiZSsHM2lTNZuByPJ6fxoc
Message-ID: <CAJZ5v0j9fpyrfAR_rsJqm2vRniHoztthn-qMT6qCVjSuOoWRrA@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] PCI/sysfs: Use PM_RUNTIME_ACQUIRE()/PM_RUNTIME_ACQUIRE_ERR()
To: Dhruva Gole <d-gole@ti.com>, Bjorn Helgaas <helgaas@kernel.org>
Cc: Linux PM <linux-pm@vger.kernel.org>, Linux ACPI <linux-acpi@vger.kernel.org>, 
	Jonathan Cameron <jonathan.cameron@huawei.com>, Takashi Iwai <tiwai@suse.de>, 
	LKML <linux-kernel@vger.kernel.org>, Zhang Qilong <zhangqilong3@huawei.com>, 
	Frank Li <Frank.Li@nxp.com>, Dan Williams <dan.j.williams@intel.com>, 
	Linux PCI <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 14, 2025 at 10:03=E2=80=AFAM Dhruva Gole <d-gole@ti.com> wrote:
>
> On Nov 13, 2025 at 20:35:27 +0100, Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > Use new PM_RUNTIME_ACQUIRE() and PM_RUNTIME_ACQUIRE_ERR() wrapper macro=
s
> > to make the code look more straightforward.
> >
> > No intentional funtional impact.
>
> Same here ...

Yup, will fix.

> Reviewed-by: Dhruva Gole <d-gole@ti.com>

Thanks!

Bjorn & PCI people, if there are any concerns regarding the change
below, please let me know.

> >
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > ---
> >
> > v1 -> v2: Adjust to the changes in patch [1/3].
> >
> > ---
> >  drivers/pci/pci-sysfs.c |    4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > --- a/drivers/pci/pci-sysfs.c
> > +++ b/drivers/pci/pci-sysfs.c
> > @@ -1517,8 +1517,8 @@ static ssize_t reset_method_store(struct
> >               return count;
> >       }
> >
> > -     ACQUIRE(pm_runtime_active_try, pm)(dev);
> > -     if (ACQUIRE_ERR(pm_runtime_active_try, &pm))
> > +     PM_RUNTIME_ACQUIRE(dev, pm);
> > +     if (PM_RUNTIME_ACQUIRE_ERR(&pm))
> >               return -ENXIO;
> >
> >       if (sysfs_streq(buf, "default")) {
> >
> >
> >
>
> --

