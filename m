Return-Path: <linux-acpi+bounces-13860-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 214EFAC2533
	for <lists+linux-acpi@lfdr.de>; Fri, 23 May 2025 16:40:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3BFC33A6528
	for <lists+linux-acpi@lfdr.de>; Fri, 23 May 2025 14:39:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 539082951B5;
	Fri, 23 May 2025 14:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C9PP/tB3"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CBD3128819;
	Fri, 23 May 2025 14:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748011212; cv=none; b=iDwXRK0J9aFbF318X4w9CjB1vI3ebO1A62o4Se6mYnucZOtPAaarL/j2lYpBIWrRvrQKm/gbJlvqNqPCm1PDa//9oOz+T0kW+gD7NQBTe9XPws2Z04yt8udpuBJ7OKKlYwA3t9HE9WQXwvKZGWFudzy5ODoIkJqjc6tJFohedGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748011212; c=relaxed/simple;
	bh=kDH8jZXV99RD2+zo4pJD6EuCbMiuvvhMAXVAdMZ2zbw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RItPO3D03uzAgjKzQDo/EvYziz6SiYT0VifBNZjEI931Ob5qyzK4bbPhUmG2Kw2StnHJQfUYS7ICY71wMH+WvkG+Ay/FU5CvFQZaS8lBNu+CwDcY2R/sAvx3dIG6HP8xJW7u+KuVKU3TCIaQnjqAZLHNFhMsXvp8nZ23wPukZCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C9PP/tB3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0C47C4CEF0;
	Fri, 23 May 2025 14:40:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748011211;
	bh=kDH8jZXV99RD2+zo4pJD6EuCbMiuvvhMAXVAdMZ2zbw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=C9PP/tB3z2cPIk8KO7Voz9zSN9IifDuiLJW1bZFUM2duas3p+MVzI9a7UdbyOGuLE
	 QrsJn5NdMhn20n6vkV8eRqE5W7qcbnB8W71vfExJDVAvOLVFTU2vSYgrkPYaOvRQxK
	 0mHMmUV6VKh1njsd9BKfv/z9Wfprdu7jFDczUMlSo2+6e1KVf3WAyCfNcopJAvEnq1
	 0/fAPA3GrxBd/dFh2+8YfJ/BpPxhv9FfC8ShEBUrykCKEpj6ilYZRI2ZDc9i71eice
	 slioYRE+rtrZC4eE4cG7aTAvyjU6JVyyy9q+2bh/mstbQ8/YjU3UDPU8U5YWgBY4CU
	 50r66APadVNBA==
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-3f6eaa017d0so24350b6e.0;
        Fri, 23 May 2025 07:40:11 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVZQY+K3Uv9epWqob5cBiP/oKpuIMgn5Z6VZ1fD/0S8xrENorp/e+vcm81CN60lO9mBYHzaow0uu9rR@vger.kernel.org, AJvYcCXnegxQ4fOiHvxW8MCeLy2XDSDlisQCbr/ok5cQbKpMBPP3Qa4WQf0HHkhGxbpSVGbLrB7lZmwB0OmRvCG6@vger.kernel.org
X-Gm-Message-State: AOJu0YxWvbvv8DU2+bxU/AK3Swivov/u+/LI4pOpoGBctT3UCGErFL11
	c5Yknubo5qHBtPpeZmfJUEQrX7t0fCH7ARwk1AHh6gyxazNiih0UB5n9+MKLKAtdiR1JL0J3/h9
	a3OfQX8Jx86qJulFQG8XyVEUHDL02Cmo=
X-Google-Smtp-Source: AGHT+IGQr3P7AfTvLgKRXbD5diVDb27jmEpvVaCwm8ZbA9G70HeOVXC3cf8q9SLWdxAV3FDrKgW5kaCx+NPnWIcHZjM=
X-Received: by 2002:a05:6808:6f95:b0:3f8:e55c:16ea with SMTP id
 5614622812f47-4063da9ff85mr2239014b6e.24.1748011210939; Fri, 23 May 2025
 07:40:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250518185111.3560-1-W_Armin@gmx.de> <CAJZ5v0hNmMtR4V0tYqD1dV2BqAKJ2sCOyBadkVtG3sS3V90uvw@mail.gmail.com>
 <a6d92cdd-4dc3-4080-9ed9-5b1f02f247e0@gmx.de>
In-Reply-To: <a6d92cdd-4dc3-4080-9ed9-5b1f02f247e0@gmx.de>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 23 May 2025 16:39:59 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0icRdTSToaKbdf=MdRin4NyB2MstUVaQo8VR6-n7DkVMQ@mail.gmail.com>
X-Gm-Features: AX0GCFvijkBoIWEzV6Uh8N85l6IpPkZxi-mYiFPeR4aMvrQfCV2VB0rGHojPkw0
Message-ID: <CAJZ5v0icRdTSToaKbdf=MdRin4NyB2MstUVaQo8VR6-n7DkVMQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] ACPI: platform_profile: Add support for non-ACPI platforms
To: Armin Wolf <W_Armin@gmx.de>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, lenb@kernel.org, j@jannau.net, 
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 22, 2025 at 6:34=E2=80=AFAM Armin Wolf <W_Armin@gmx.de> wrote:
>
> Am 21.05.25 um 22:17 schrieb Rafael J. Wysocki:
>
> > On Sun, May 18, 2025 at 8:51=E2=80=AFPM Armin Wolf <W_Armin@gmx.de> wro=
te:
> >> Currently the platform profile subsystem assumes that all supported
> >> (i.e. ACPI-capable) platforms always run with ACPI being enabled.
> >> However some ARM64 notebooks do not support ACPI and are instead
> >> using devicetree for booting.
> >>
> >> Do not register the legacy sysfs interface on such devices as it
> >> depends on the acpi_kobj (/sys/firmware/acpi/) being present. Users
> >> are encouraged to use the new platform-profile class interface
> >> instead.
> > So how does it work in this case?
> >
> The platform profile subsystem also exposes a more modern class-based sys=
fs interface,
> see Documentation/ABI/testing/sysfs-class-platform-profile for details.
>
> This interface does not depend on /sys/firmware/acpi being present, so us=
erspace
> programs can still control the platform profiles using the class-based in=
terface.
>
> This will become very important once we have platform profile drivers not=
 depending on
> some sort of ACPI interface. I suspect that sooner or later some drivers =
for the embedded
> controllers on ARM64 notebooks (devicetree!) will register with the platf=
orm profile subsystem.
>
> Apart from that this allows input drivers using platform_profile_cycle() =
to work on non-ACPI
> platforms (like ARm64 devices using devicetree).

This driver though is located in drivers/acpi/ and depends on
CONFIG_ACPI.  Moreover, the platform profile provider drivers need to
select ACPI_PLATFORM_PROFILE so it gets built.  This means that there
are no non-ACPI platform profile providers currently in the tree.

While the observation that the code in the driver, other than the
legacy sysfs interface, doesn't really depend on ACPI is valid, if you
want it to be used on systems without ACPI, it needs to be properly
converted to a generic driver.

For now, it is better to simply make it fail to initialize without
ACPI, so I'm going to apply this patch:

https://patchwork.kernel.org/project/linux-acpi/patch/20250522141410.31315-=
1-alexghiti@rivosinc.com/

Thanks!

