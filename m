Return-Path: <linux-acpi+bounces-9276-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A0E49BBAAC
	for <lists+linux-acpi@lfdr.de>; Mon,  4 Nov 2024 17:56:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C62381F223CF
	for <lists+linux-acpi@lfdr.de>; Mon,  4 Nov 2024 16:56:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EF981C232D;
	Mon,  4 Nov 2024 16:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sk7Qu41H"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 129951369B6;
	Mon,  4 Nov 2024 16:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730739397; cv=none; b=nfrX7YleIiaY69JqRP2bYJTFpFoOs1v7Op5W4KEHeIWPPL4v4kXyzI2ldVPaUOexPyNi0c1DilPqfJ5SHe8QX1KHGTa/Tn1v03hvJphXKekLN0qNhQByIfgnfgJ+96culk0d/IIYNQtWrz0Dao1gn8IVdfS6gaapcDVC7L6n2B4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730739397; c=relaxed/simple;
	bh=+KgTmQ9m+fs9YTuWdW7aG+cCQ9cVogjvZwU1FhHJIBg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CA9mpefYv7E8inzXMNmZb0OptQkusBht0kA8RI6ItpnAfezpmyEQ2TdRbMXOEO50Bu3vk0NrjiISC2UWE/rUQdQDTyJpuMF1d9quwZxgIgq3ovXIGpH8x/mc9MhepZXM3Qc7711PkMN1gi5eyw76VHoCen4I8YpTmur8wgTBck4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sk7Qu41H; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7B63C4CECE;
	Mon,  4 Nov 2024 16:56:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730739396;
	bh=+KgTmQ9m+fs9YTuWdW7aG+cCQ9cVogjvZwU1FhHJIBg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=sk7Qu41H4GkK0MG2aMjjpLAHn/f6KnCk4oe6CHBze16mQjzwOC/UaY0c7r0SiTPOH
	 qKZwV2CPtTeooezXzOmTxG66O52TrRi4gDz5tgLUMh2OLJFg3EPgxYzLfGs/r/9irA
	 vYOBQ1N0vc4RfC1O8JHaWM1MBAyH1CdImQN6iOdF1Q29JhCPmORQQnht+c8M5GLI0A
	 d0Ms3Nh+T2UaVCFYLgnPeE7CEV6Nwc4CscqvpkD2DOPd8AQy5d48JEggUB9fOM23Hv
	 bR7kNBrcFXP0SatIgcPxnoffV4P51K7Z4P3SSAsGEvD4cZHv2ux2tyAzvqsRH6Jvey
	 tecx++q9Ce0uQ==
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-71807ad76a8so2313890a34.0;
        Mon, 04 Nov 2024 08:56:36 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVS6uzjSnYyfoNmz0xZO+fXAPV2Emddp0hIwZi4M/o7vTZS3o7/DqlzoIu4CNSJ/u61WZSHuvpO0wQM@vger.kernel.org, AJvYcCXHziFUjMVhh5x0mRz4lbclRrsW6FneulxtvCRIRhofXTYu0+Xq7r6/lcXDF4eTyG6OETLa6ymVTrgWS8R0@vger.kernel.org
X-Gm-Message-State: AOJu0YyHaNjVOzSu5hIxut0itcZCxp0tF2SVxIB9gGC8BmNUS61gGqnf
	2+TzQxF+c4prKhR0GL3t4FqFUZvfy1izD8WTR2vWG/k+nuuJqj3vCDAPtfg6F/GqHeg0+7IGSbl
	NGuLx0qxaRJ7x9jsi/PpS/qtswFQ=
X-Google-Smtp-Source: AGHT+IGqClGbcCdHSjv8Vf4H2PhPkz4ezPZJC6cNLWeX2RBDPTAbEMbkUZvikotdP6EMbyljFkVsYmeSKRAxbeMvM08=
X-Received: by 2002:a05:6871:c703:b0:277:f14c:844b with SMTP id
 586e51a60fabf-2948463078fmr14817784fac.37.1730739396262; Mon, 04 Nov 2024
 08:56:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241030162754.2110946-1-andriy.shevchenko@linux.intel.com> <63b16433-9f80-492f-9389-633a9852a223@weissschuh.net>
In-Reply-To: <63b16433-9f80-492f-9389-633a9852a223@weissschuh.net>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 4 Nov 2024 17:56:25 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0ip=JacAZTLigdivuASCtNdqp=RZv99OMNiNPt4WYcnxA@mail.gmail.com>
Message-ID: <CAJZ5v0ip=JacAZTLigdivuASCtNdqp=RZv99OMNiNPt4WYcnxA@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] ACPI: battery: Check for error code from
 devm_mutex_init() call
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas@weissschuh.net>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>, 
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 30, 2024 at 5:42=E2=80=AFPM Thomas Wei=C3=9Fschuh <thomas@weiss=
schuh.net> wrote:
>
> Hi Andy,
>
> Oct 30, 2024 10:28:03 Andy Shevchenko <andriy.shevchenko@linux.intel.com>=
:
>
> > Even if it's not critical, the avoidance of checking the error code
> > from devm_mutex_init() call today diminishes the point of using devm
> > variant of it. Tomorrow it may even leak something. Add the missed
> > check.
>
> Thanks!
>
> Assuming you found this via some sort of tool and you already fixed up al=
l the other places in the tree missing these checks,
> wouldn't it make sense to mark devm_mutex_init() as __must_check?
>
> > Fixes: 0710c1ce5045 ("ACPI: battery: initialize mutexes through devm_ A=
PIs")
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>
> Reviewed-by: Thomas Wei=C3=9Fschuh <linux@weissschuh.net>

Applied, thanks!

> > ---
> > drivers/acpi/battery.c | 8 ++++++--
> > 1 file changed, 6 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/acpi/battery.c b/drivers/acpi/battery.c
> > index 66662712e288..70f706d7634f 100644
> > --- a/drivers/acpi/battery.c
> > +++ b/drivers/acpi/battery.c
> > @@ -1226,8 +1226,12 @@ static int acpi_battery_add(struct acpi_device *=
device)
> >     strscpy(acpi_device_name(device), ACPI_BATTERY_DEVICE_NAME);
> >     strscpy(acpi_device_class(device), ACPI_BATTERY_CLASS);
> >     device->driver_data =3D battery;
> > -   devm_mutex_init(&device->dev, &battery->lock);
> > -   devm_mutex_init(&device->dev, &battery->sysfs_lock);
> > +   result =3D devm_mutex_init(&device->dev, &battery->lock);
> > +   if (result)
> > +       return result;
> > +   result =3D devm_mutex_init(&device->dev, &battery->sysfs_lock);
> > +   if (result)
> > +       return result;
> >     if (acpi_has_method(battery->device->handle, "_BIX"))
> >         set_bit(ACPI_BATTERY_XINFO_PRESENT, &battery->flags);
> >
> > --
> > 2.43.0.rc1.1336.g36b5255a03ac
>

