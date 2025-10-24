Return-Path: <linux-acpi+bounces-18171-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id BBD60C051C7
	for <lists+linux-acpi@lfdr.de>; Fri, 24 Oct 2025 10:42:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2D4F0507966
	for <lists+linux-acpi@lfdr.de>; Fri, 24 Oct 2025 08:38:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42B2D307AEB;
	Fri, 24 Oct 2025 08:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NIESWRIh"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C5F5306487
	for <linux-acpi@vger.kernel.org>; Fri, 24 Oct 2025 08:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761294930; cv=none; b=T2AwZdE/C1awQ4QN4JPUGdyiD8BD2h4GGHXagiOVvUI4dBGsInAXyHmhLrXcK4XVn2HlJJnUARtYim5Kfjqk6WUuhdwmoprGfL02YaQ5pZo4EMvl9MtjcMhZ5XRBFPDux7nDiT6fPl6CQQ35fCWb6xOhgIX+eZmxtmhuNsz70nE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761294930; c=relaxed/simple;
	bh=rs6+rIkwBSTFk9oYKPn+vWj3PBLzsTh+yyt3kunlGBI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=r8AOnqHxcv8ZtH9iu9FV5Mjlgs6LkhLSDWug/7pLDdjrBTR+DiQqrBcmfgMluEEnRW000/xmV39WvvTOeiE3N1dy86ZM9ZuFD2Z1tewB4z8z1+dybqHU6pncJKDoTzfOV2mlc5vAYjeRTzogoWPXgAwAL0BIkvF7zIqRM3uDUbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NIESWRIh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98088C4CEF1
	for <linux-acpi@vger.kernel.org>; Fri, 24 Oct 2025 08:35:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761294929;
	bh=rs6+rIkwBSTFk9oYKPn+vWj3PBLzsTh+yyt3kunlGBI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=NIESWRIh48tdpGQ8r7/qaZ3/1yO96wyvPJ/RrMpQFBaafnkEx18iZBRSes2pyHDrP
	 EFi1YKFhjK+Wu+Dx92+uwrFVdKnv8h0Q+tr4f8PxYYoJYol20fooQ7W/txSlSR9/Kd
	 xO0YbhChmdOsbsfzor+Ou8dmwgviODWis6pKv4pp+Fp7K+l7RafO+/RZYZTxl/GJvt
	 Y0tmoQP7L3c+bd/Oa5kDsXk7cVlx5R9lq0PxvIIRU+s9L1WagzG1bhLokuyQT0hOjt
	 9knxMzXP8Y3CE2JjzNf5HhD8BoNGsygzGbL3WohK0kgDJBiGxZISiUiltK6p7yTKh2
	 5ESKfs/eJ20/Q==
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-65363319bacso895262eaf.2
        for <linux-acpi@vger.kernel.org>; Fri, 24 Oct 2025 01:35:29 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWJtoB1rKuuAUkH09v0ZZ1zJzbBCjSrmIpbU3sQEfD12TF+yCe1WCxOReR/yzUgXupYvykOzbfE8ar1@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+biSfVo0kthNCrGKPLKTQFnuDkq3XFVC3mcz/GQpwQBlair6a
	n5WGx8zX8WT+tK1x/OBD9QP/NoBqvGpnYMUqBNqHI3k6ellIXuIGtTdEm+aRMW13OX3NetHOY/J
	kyEwDwECmF3+lG9mxux7jnsRHNQWHaOI=
X-Google-Smtp-Source: AGHT+IGDHDmhaPaIVA0YNouC/sPWwhYWD8hB8prSLd6xwuSCIeELLgzZGaGrLwlh4yPxk3EKpeKsGpwzuKkf2GbsaMo=
X-Received: by 2002:a05:6808:1a20:b0:441:8f74:e8f with SMTP id
 5614622812f47-443a3153d11mr12209274b6e.57.1761294928899; Fri, 24 Oct 2025
 01:35:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251007234149.2769-1-W_Armin@gmx.de> <ec099f39-89a2-46ee-a10c-1350ecf7fc83@gmx.de>
 <CAJZ5v0h8w0wrO5ziqQchN_f5Cb=Duqfc6=uOzR_-pk5_UcJ95g@mail.gmail.com>
 <CAJZ5v0idydJCQqnEs38KJT+1TmVJuhLeCFikypDLD1Yd_8zWhg@mail.gmail.com> <de8dc59e-d301-4954-b39c-f032b6aa0db9@gmx.de>
In-Reply-To: <de8dc59e-d301-4954-b39c-f032b6aa0db9@gmx.de>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 24 Oct 2025 10:35:16 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0gd3N_2W95=wuGdymy++0Mm5NLa8zKX8nhO4Lie83PBvQ@mail.gmail.com>
X-Gm-Features: AS18NWBGBPvY2tOkAuHWHydpl-mL1FxjQEeN6LOGczTKwPqDRuEuGSc5EQl7L8o
Message-ID: <CAJZ5v0gd3N_2W95=wuGdymy++0Mm5NLa8zKX8nhO4Lie83PBvQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/6] ACPI fan _DSM support
To: Armin Wolf <W_Armin@gmx.de>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, lenb@kernel.org, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 23, 2025 at 10:13=E2=80=AFPM Armin Wolf <W_Armin@gmx.de> wrote:
>
> Am 23.10.25 um 21:22 schrieb Rafael J. Wysocki:
>
> > On Thu, Oct 23, 2025 at 11:59=E2=80=AFAM Rafael J. Wysocki <rafael@kern=
el.org> wrote:
> >> On Wed, Oct 22, 2025 at 11:41=E2=80=AFPM Armin Wolf <W_Armin@gmx.de> w=
rote:
> >>> Am 08.10.25 um 01:41 schrieb Armin Wolf:
> >>>
> >>>> Microsoft has designed a _DSM interface for the ACPI fan device [1]
> >>>> that allows the OS to set fan speed trip points. The ACPI firmware
> >>>> will notify the ACPI fan device when said trip points are triggered.
> >>>>
> >>>> Unfortunately some device manufacturers (like HP) blindly assume tha=
t
> >>>> the OS will use this _DSM interface and thus only update the fan spe=
ed
> >>>> value returned by the _FST control method when sending a notificatio=
n
> >>>> to the ACPI fan device. This results in stale fan speed values being
> >>>> reported by the ACPI fan driver [2].
> >>>>
> >>>> The first patch performs a simple cleanup in order to reduce the usa=
ge
> >>>> of the acpi_device struct. The second patch fixes an issue with some
> >>>> 64-bit ACPI implementations where an invalid value was reported
> >>>> instead of the standard ACPI placeholder value (0xFFFFFFFF). The thi=
rd
> >>>> patch fixes an unrelated issue inside the hwmon support code while t=
he
> >>>> next two patches add support for the ACPI fan notifications as
> >>>> specified in ACPI 11.2.3. The last patch finally adds support for th=
e
> >>>> Microsoft _DSM interface.
> >>>>
> >>>> All patches where tested with a custom SSDT [3] and the acpi_call [4=
]
> >>>> kernel module and appear to work just fine.
> >>> Any thought on this?
> >> Not yet, but I'm going to get to it today.
> >>
> >>> I tested it with a custom SSDT, so i can prove that those patches wor=
k.
> >> OK
> > I've applied two first patches for 6.19 and the third one for 6.18-rc, =
as a fix.
>
> Please note that the third patch depends on the first patch! Otherwise yo=
u will
> get a runtime error when acpi_fan_hwmon_read() tries to cast the platform=
 device
> to a ACPI device.

Ah, good to know, I've missed that dependency, thanks for pointing it out.

> > My understanding is that patches [4-5/6] are preparations for the last
> > one that needs a pointer to the MSFT documentation it is based on.
>
> I understand, i will send a v3 series without the first three patch and t=
his
> issue being addressed.

Thanks!

