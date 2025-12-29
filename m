Return-Path: <linux-acpi+bounces-19881-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C90ECE6D08
	for <lists+linux-acpi@lfdr.de>; Mon, 29 Dec 2025 14:05:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2CF783003078
	for <lists+linux-acpi@lfdr.de>; Mon, 29 Dec 2025 13:05:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F51B27AC3A;
	Mon, 29 Dec 2025 13:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DS2zSaR3"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE6EB1DE8BF
	for <linux-acpi@vger.kernel.org>; Mon, 29 Dec 2025 13:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767013547; cv=none; b=sY60mKX6da4C9Fc0oKGGLaBNjuwcSHIbTk78UmE1NOlyJWARxSPLXoPT3iII1oXqER6WZ/q/QgLvTK3LPpOl92JzNuSDnmk2zrIP78wZNYT2Y0Ss0lPU7J+ilXJ7n8miT7iG9liPBZ+1zA2gbpsBMibqIl0Jf6ar3FlyP3CqURY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767013547; c=relaxed/simple;
	bh=89gyhFWTzEdmAqbWfy4vLDBdLx/Z9WFqEd+t+a6VEGI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FvRfxWqB6TKvebZCLhCahNjB1r9At3NehrSXOtsRlClY9knPayywZu3SXS69xXObNsh6Xf+URyHNgmvgI20wmuKJxzVCacakRiPVE+b1WMVo52I+LbL4hB0k9UWqks+Y5G3RvhTYy0RslwF3IIposy6hEc8SBU78+FHhYMZyri0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DS2zSaR3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86089C4CEF7
	for <linux-acpi@vger.kernel.org>; Mon, 29 Dec 2025 13:05:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767013546;
	bh=89gyhFWTzEdmAqbWfy4vLDBdLx/Z9WFqEd+t+a6VEGI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=DS2zSaR39q1dYjpdnQobpADSJtU2DroZELlw4l1yq69wRXdhVT+awWc4XOD4W76bU
	 OZOFxQNlYwLR/xD4yQDJYigF7TwHWabbxHOGEsM9OHZooeQILK3xROqrptXrBUpGZI
	 JENfJj0xsxurxUu+1ltX8YLwP23iWua21m37seGKHfXzhjMG+DiMS1J1nBUXQp0T6z
	 I5QXXYGcQ9jWsQKJdPjSV8LW89Scfv1V7HBHo4gT8EY57TFnij6oKvmAx2F1wddpOx
	 VQYV974Rkh5jgkAiW5kz184Jnw8+PkHPYoOu8/NbAYn/2Arr9ktFohFigTqz2EOphN
	 v0FnweBRxSzbg==
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-3f551ad50d1so3181228fac.0
        for <linux-acpi@vger.kernel.org>; Mon, 29 Dec 2025 05:05:46 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVpaeAe9AGMayNqcuVuixrgSYmFdYI91tskiSvvNUbsZ/FhB5JMFha64gmFjhXShlytudU7BXHAYQXZ@vger.kernel.org
X-Gm-Message-State: AOJu0YyELMxOSdAhIopU2KZX9osgPd12oaqfy1Q+oLyrtL5HkL8tfXjU
	q3rekX/V6QUGM51hcjauZr6k5NsgvBU14SXS3wPlWEI4l8P7q7b7KcFC9lBssPikmw8FaGIgV3M
	pRE8FbhrbEojGaabO8IqAXdRGjeT45Xk=
X-Google-Smtp-Source: AGHT+IH8nTDEGxHe0rQDq5a19sm+MRy3/Emon1EuycnOmKC6W54hVpnw9ZJiW/aPiGi3E/t4RwZd8S1jTVnf1ykzUxs=
X-Received: by 2002:a05:6820:80f:b0:659:9a49:8e53 with SMTP id
 006d021491bc7-65d0ea15d0amr13045627eaf.35.1767013545702; Mon, 29 Dec 2025
 05:05:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2812426.mvXUDI8C0e@rafael.j.wysocki> <aVGQtNsm0hDgRR0m@smile.fi.intel.com>
In-Reply-To: <aVGQtNsm0hDgRR0m@smile.fi.intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 29 Dec 2025 14:05:33 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0gzSwpwN5mzUUvATeww2Q5_s95_-T2Jd2fwgE1cXYFuVQ@mail.gmail.com>
X-Gm-Features: AQt7F2oiqk2-XEtn8CnRY0dINSPlefddJJ7vndos5TZvrXWvIRIKYQRW86t8go8
Message-ID: <CAJZ5v0gzSwpwN5mzUUvATeww2Q5_s95_-T2Jd2fwgE1cXYFuVQ@mail.gmail.com>
Subject: Re: [PATCH v1] ACPI: sysfs: Add device cid attribute for exposing
 _CID lists
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Linux ACPI <linux-acpi@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, Hans de Goede <hansg@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Dec 28, 2025 at 9:19=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Fri, Dec 12, 2025 at 09:52:44PM +0100, Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > Add a new sysfs attribute called "cid" under struct acpi_device for
> > exposing the list of compatible device IDs returned by the device's
> > _CID object, if present.
> >
> > The new attribute will be present only if the _CID object is present.
>
> ...
>
> > +static ssize_t cid_show(struct device *dev, struct device_attribute *a=
ttr,
> > +                     char *buf)
> > +{
> > +     struct acpi_device *acpi_dev =3D to_acpi_device(dev);
> > +     struct acpi_device_info *info =3D NULL;
> > +     ssize_t len =3D 0;
> > +
> > +     acpi_get_object_info(acpi_dev->handle, &info);
> > +     if (!info)
> > +             return 0;
> > +
> > +     if (info->valid & ACPI_VALID_CID) {
> > +             struct acpi_pnp_device_id_list *cid_list =3D &info->compa=
tible_id_list;
> > +             int i;
> > +
> > +             for (i =3D 0; i < cid_list->count - 1; i++)
> > +                     len +=3D sysfs_emit(buf, "%s,", cid_list->ids[i].=
string);
> > +
> > +             len +=3D sysfs_emit(buf, "%s\n", cid_list->ids[i].string)=
;
>
> You definitely meant to use sysfs_emit_at().

Right, thanks!

> > +     }
> > +
> > +     kfree(info);
> > +
> > +     return len;
> > +}
> > +static DEVICE_ATTR_RO(cid);
>
> Do wee have any ABI documentation for these sysfs attributes?

No, there's none I know of.

> If so, it needs to be updated, otherwise perhaps create one?

Well, feel free to do so.

