Return-Path: <linux-acpi+bounces-18160-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B342BC0271D
	for <lists+linux-acpi@lfdr.de>; Thu, 23 Oct 2025 18:28:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 281301A62129
	for <lists+linux-acpi@lfdr.de>; Thu, 23 Oct 2025 16:28:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39C4A2D877C;
	Thu, 23 Oct 2025 16:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Prdk/SBo"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 769E02D77E3
	for <linux-acpi@vger.kernel.org>; Thu, 23 Oct 2025 16:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761236859; cv=none; b=BA6JCpMTLaBggKJlJBy+oa7dHB9OZiQerLga0awQ/AtwPAaynrzpj6DN2jU/6Yvv6oHLts6Q7KgikT8Myui9Iv5nL2yiXE1MWes05MZL9ydzI/RzrO5jqMYLjuEFUx0p9L9ppf5bLj0yv6dyCG9MZon3wLCKXKWTEgBOfDcleMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761236859; c=relaxed/simple;
	bh=97MO41jRSpevZOQY5X/s6jqv4fmMPnX3F7sJNNlsleo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XKPubHPG6mLWu0qjtNvVwNRQ57i2UUaAsw0Z8DeOPl3yH1BCdIM7dgGFxWmMnKh74Z5AAo5fSrEyEGtRwF6HtbDCt7mtGBAQkpvciCjtEJndfrfyW0QxIhCBwkd9tKTX1BVFITNcEO0pn/RzZjqEavzHqGbFfGP5nYbDRNw9NAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Prdk/SBo; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-63c21467e5bso1840774a12.0
        for <linux-acpi@vger.kernel.org>; Thu, 23 Oct 2025 09:27:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761236855; x=1761841655; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=97MO41jRSpevZOQY5X/s6jqv4fmMPnX3F7sJNNlsleo=;
        b=Prdk/SBofghIdtzCeMBtAvJyI7nlROk7g2TwGmQ3o5R9VZEILaksGldZ+H2+iWi+s6
         l9FTfZS16hPTzScJA8prerCGLoP8y5i0SMRHOavog3f5yLoguaOY27V0bQjIYLQxzDPB
         YRNs1PweZsaccigXXB26VDi6eTdwxqA7xvgL6sJJ3JJVbW/L5weyVsJ86S5NOj5LPNfU
         lBnesfC7nyGsGXVmCIbuR2WyESddOYcgzF+I2kXb/RjmVSVad6+BvHP7phcphn3ElSUx
         WGg/iCfqqncmWwMLn/dLnmM7aK69LVSCwJrok4e+iWRH+mv24SY0z8jy461KcIaPov0O
         Kp/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761236855; x=1761841655;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=97MO41jRSpevZOQY5X/s6jqv4fmMPnX3F7sJNNlsleo=;
        b=xLKEsY83B5BO9WF+PryS7fo0UIipp7oD+SJiVQweHcImtHkhcCVDC94NUgv3Crljhc
         /QR+uYKO9JNnaaVmwSiTAZ10IUeGwJWQQ/isAokN+JUJcdA1aMqz84hfJ41Nf2A4vAVE
         n6Q4+tUh1Fm1dnSKuxOp3x5yR56iSS6rsAf3mUxf0tj5Q7BRk9WypWfsMuWtU8sk3SMT
         f+r8fl8yyVqjeTNlxqOZilJncJ4ZWELq4SOSy5kDGFbRpJArcMX43+9S+jVXW+YD3+sG
         6Yr6cIQS/6sDTFsvy0Y+4dvnu/j6q2cJvC1x0IYH1rjRA8IrOQ2R0Ic0FqP24DUdm6XA
         fT9g==
X-Forwarded-Encrypted: i=1; AJvYcCV43AHuxqSVfhORsP4L893A2y88zGHP1Uzllgca2ecBokAqLCNlJ172gTeB9vFCm1fG7iJGP1vRgqJV@vger.kernel.org
X-Gm-Message-State: AOJu0YwBDIuOY3Ot71t39BLn6nBFNZOIWqCdTnemmAp5VB5etIYVUSRi
	3WWQuXd6yFmAH+Tcyp4m6SMyM0KtACOVbHrNtqPwqJRK7eGblC1+Gpvj1xBgSjGXAhsL8cYVz0k
	7pvycM+2B/kH7DahaEKEfrTBEmRH8XlzSE1Go0/du
X-Gm-Gg: ASbGncuIGUQUskgd1cEYJ7XOVBGwXSCfcVe3ZxIwb9iy9oOfEr0FzJj8s+h3iPD4Xve
	ucjHPFF5MQJwS57tXuOXwAt/QQlcY9I80sp3weKN022CoFOJHwdoycH5AomlCCDLKc+CkWBxLym
	T0DS43kIi2zIymYUs2Ryj54OKdSvsGEYNKGxvxnLD1W7POyZvL4wfX3OSIgmeVEWz3w+pBdJFQ7
	IojmBBMEG0TPWKle+yJf1Y2ZaeXxqezjC9B/AnD6JfbaPp4Ec+DYs0HUoakuSyVya3yEe+RjMWI
	Txw3f4I0UtsgECDohrXZXS+6Lg==
X-Google-Smtp-Source: AGHT+IGRu6yI1emkCCw3nvVlzdH/6fU0sebXYjptgLv/4PO9Xk3ol/HgZ5f+hbDRyxJrRiKEy/KfoNbWzUlcluN7VUM=
X-Received: by 2002:a50:9e2a:0:b0:639:e9a4:a5f1 with SMTP id
 4fb4d7f45d1cf-63c1f6cef09mr20904049a12.27.1761236854479; Thu, 23 Oct 2025
 09:27:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251002113404.3117429-1-srosek@google.com> <20251002113404.3117429-3-srosek@google.com>
 <CAJZ5v0iQToOkedruYqsowSm8=fxpnyJf86JJHB36E8+aCSZ5Hw@mail.gmail.com>
 <CAF3aWvFSomq+cm2sj+KjkYw=WODsrwH-VLDL=yOc6o9dqc5hWA@mail.gmail.com> <CAJZ5v0g72U3+u_KedKpZh2TuN-iYbXPcnZhN16oDvi4UqUTr7Q@mail.gmail.com>
In-Reply-To: <CAJZ5v0g72U3+u_KedKpZh2TuN-iYbXPcnZhN16oDvi4UqUTr7Q@mail.gmail.com>
From: =?UTF-8?Q?S=C5=82awomir_Rosek?= <srosek@google.com>
Date: Thu, 23 Oct 2025 18:27:23 +0200
X-Gm-Features: AWmQ_blF7s0d_2rpPBOJV_yCAuUzVG3-BC5mVNgcU7WAEA9ki3dMFD97y8RMCx8
Message-ID: <CAF3aWvFc5ZZo3VaJSr68FwGuCFYJU=tXsJ6Fm1vmNLs4B=+8dg@mail.gmail.com>
Subject: Re: [PATCH v3 2/6] ACPI: DPTF: Move INT340X device IDs to header
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Alex Hung <alexhung@gmail.com>, Hans de Goede <hansg@kernel.org>, 
	Ilpo Jarvinen <ilpo.jarvinen@linux.intel.com>, AceLan Kao <acelan.kao@canonical.com>, 
	Daniel Lezcano <daniel.lezcano@linaro.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Zhang Rui <rui.zhang@intel.com>, 
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Tomasz Nowicki <tnowicki@google.com>, 
	Stanislaw Kardach <skardach@google.com>, Michal Krawczyk <mikrawczyk@google.com>, 
	linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, 
	platform-driver-x86@vger.kernel.org, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 23, 2025 at 5:11=E2=80=AFPM Rafael J. Wysocki <rafael@kernel.or=
g> wrote:
>
> On Thu, Oct 23, 2025 at 4:41=E2=80=AFPM S=C5=82awomir Rosek <srosek@googl=
e.com> wrote:
> >
> > On Wed, Oct 22, 2025 at 8:46=E2=80=AFPM Rafael J. Wysocki <rafael@kerne=
l.org> wrote:
> > >
> > > On Thu, Oct 2, 2025 at 1:34=E2=80=AFPM Slawomir Rosek <srosek@google.=
com> wrote:
> > > >
> > > > The ACPI INT340X device IDs are shared between the DPTF core
> > > > and thermal drivers, thus they are moved to the common header.
> > > >
> > > > Signed-off-by: Slawomir Rosek <srosek@google.com>
> > >
> > > I've actually started to wonder if int340x_thermal_handler is needed =
at all.
> > >
> > > It just creates a platform device if the given ACPI device ID is in
> > > its list,
> >
> > That's true. It creates platform device for the given ACPI device ID,
> > but only if CONFIG_INT340X_THERMAL is enabled.
> >
> > > but acpi_default_enumeration() would do that too with the
> > > caveat that it would also be done for CONFIG_INT340X_THERMAL unset.
> >
> > Not exactly. scan handler returns ret=3D1, so device is marked as enume=
rated
> > https://elixir.bootlin.com/linux/v6.18-rc2/source/drivers/acpi/scan.c#L=
2314
> >
> > > That should not be a problem though because if CONFIG_INT340X_THERMAL=
,
> > > there are no drivers that will bind to those platform devices, so the
> > > net outcome should be the same.
> >
> > If CONFIG_INT340X_THERMAL is not set and there are no drivers to attach
> > to platform devices and int340x_thermal_handler is removed then you are
> > right, acpi_default_enumeration() will enumerate ACPI bus anyway and
> > create platform devices for all ACPI device IDs. However, for me it loo=
ks
> > like it was intentional to prevent this behaviour unless INT340X driver=
s
> > are "present" in the system (were enabled for build so should be).
> > I am not sure how DPTF works and what may happen if platform devices ar=
e
> > visible in sysfs while drivers are not loaded.
>
> Such a dependency would be unexpected and confusing.
>
> Also, I'm not sure why it would be useful because the lack of drivers
> means that the devices in question are not handled, so no
> functionality related to them is provided by the kernel.
>
> > >
> > > Thus I'm wondering if the way to go might be to drop
> > > int340x_thermal_handler and simply keep the device IDs in the drivers
> > > that use them for device binding.
> >
> > Even better. If it's not required for DPTF to prevent enumeration
> > on the platform bus I can simply remove the scan handler.
>
> I would at least try to do that.

Makes sense, so I'll give it a try. Removing handler will result with
only two patches, one to update dts_doc_thermal kconfig and second
to remove the dptf scan handler, the rest won't be needed for a new
patchset. Should I send it as v4?

