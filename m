Return-Path: <linux-acpi+bounces-10858-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A9853A21A31
	for <lists+linux-acpi@lfdr.de>; Wed, 29 Jan 2025 10:45:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 119291883236
	for <lists+linux-acpi@lfdr.de>; Wed, 29 Jan 2025 09:45:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E458C1B042F;
	Wed, 29 Jan 2025 09:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Au2+X9Qy"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC0EC1B040E;
	Wed, 29 Jan 2025 09:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738143866; cv=none; b=Qi9+EGyAUo4Ssq4GxPYMbQvyQEmc7GuyV9Juppkd7S+ypQdsJ0MtI3YupjT/1cs8UmQzFJRd58ozTiBlTap4D0Hfy34WVWlfkg8c2Vf6AC8HjVPZM6ocscmAiK3y12+77K50QJ6Y6J6+ga8Hzjt3+1r2Z+rNnLIe+ooh9BL1Yz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738143866; c=relaxed/simple;
	bh=LfaKHAN2uZOJZkjYTm+ya0OzY2I/+fKB/2DeImWPq5o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=k/Cr+pQF5vS7BkaizV4JoTt26NMt0MsY6DbNCJ2f4uMKZuCBT2sC3qmVASa0rw7qvb1cSEpg22v7mqpy9CwQuumLfJeKhgBnjVN8xr+1lS5uWlthz5Dt82zJEIyI5tCvVph+pK2wdaeJpKgCEgdCK+CZdgSinSILAA/fGOtYGus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Au2+X9Qy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 383C7C4CEE0;
	Wed, 29 Jan 2025 09:44:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738143866;
	bh=LfaKHAN2uZOJZkjYTm+ya0OzY2I/+fKB/2DeImWPq5o=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Au2+X9QyaEYakely939PQtT4IEQ4UfFXW4jm8iSQpyDqpegajGn6vXaj66LGU33gG
	 HeqypllEr1vPa7eUADnkLvqPO6PlTZdgeqF7WW6AF1rdzWDi/jffA9La+GOByGJyHn
	 Hc+cVGiU7GEnhezsJY8kaa6hJ6Ndjo9WaLWgY1xWrC3XFc8h7KVmek2ZO2ODrXo/BL
	 kc4isDQ+9yisXp7I7dHCdBxZcvUlEhE+TQEVCA633qD5UQzc1Vq3vVB5EvTFyQG4rh
	 R0CycRX9GSTNLKWkHGrRnc+qXUzBs5cnGAvED9wJnUrHHfW0RzmSF08nl+sJFn/oQA
	 bFe0g2kk2QbDQ==
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-71e287897ceso4642133a34.0;
        Wed, 29 Jan 2025 01:44:26 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVZFt8K4b9RvENevncJBPSV0B276SdxIkp4YHYx6kkkGJcR/uEduiGy5LDXH2uYEXqERuTduWuyEkHb@vger.kernel.org, AJvYcCVahg6MhrF2MfF3KWm6Gra3iQPgBhrgXo3Z0ngZKB+okFcFa8ccbKJDWGajo5ILjCHU7zuN1RvtDGkR2e5c@vger.kernel.org
X-Gm-Message-State: AOJu0Ywhobr0d4lP4pAhIjpYR2YmjsFv/NAmlOk94dhgLHONCueGBv01
	0S/OdJTWBsyHzt0VDHbwh//WuLu8R7LFZvswyKgTrab7pjblbQ64CwiaZ22cGLvKUsPdssc98UR
	OWx4UDQfFeW0FBIxXw3DxOfEQgVQ=
X-Google-Smtp-Source: AGHT+IHWCCIOyfzbj+hkpC/pZQ/RgNnAZqCK0ZKS7yEqQQT+/0A4P8vq9/tOhwMr3pIetRbzQJ1feLAer6YoSUoffCY=
X-Received: by 2002:a05:6830:7316:b0:71e:240a:4828 with SMTP id
 46e09a7af769-72656781c42mr1427665a34.16.1738143865393; Wed, 29 Jan 2025
 01:44:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250117022957.25227-1-tanxiaofei@huawei.com> <20250120110417.00000a57@huawei.com>
 <58a450bb-55d1-5415-4b67-9d61603ce48e@huawei.com> <CAJZ5v0ihVJBX0bLqrL-61=LKVoZJOg3RpJykp80uOMf_7YcG+A@mail.gmail.com>
 <20250129043329.GA2344109@ax162>
In-Reply-To: <20250129043329.GA2344109@ax162>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 29 Jan 2025 10:44:13 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0g90=6KzV9=efVsJLHqjE=+M6=mbYy2Xym53es4RdszmQ@mail.gmail.com>
X-Gm-Features: AWEUYZl3f3DiaSCtoovXYnunVRc1-B3-ULn6nJmUG8EC-pmi9SnV199X4xNLTDc
Message-ID: <CAJZ5v0g90=6KzV9=efVsJLHqjE=+M6=mbYy2Xym53es4RdszmQ@mail.gmail.com>
Subject: Re: [PATCH v3] acpi: Fix HED module initialization order when it is built-in
To: Nathan Chancellor <nathan@kernel.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Xiaofei Tan <tanxiaofei@huawei.com>, 
	Jonathan Cameron <Jonathan.Cameron@huawei.com>, lenb@kernel.org, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, mchehab+huawei@kernel.org, 
	roberto.sassu@huawei.com, shiju.jose@huawei.com, prime.zeng@hisilicon.com, 
	linuxarm@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 29, 2025 at 5:33=E2=80=AFAM Nathan Chancellor <nathan@kernel.or=
g> wrote:
>
> On Thu, Jan 23, 2025 at 08:35:51PM +0100, Rafael J. Wysocki wrote:
> > On Tue, Jan 21, 2025 at 3:23=E2=80=AFAM Xiaofei Tan <tanxiaofei@huawei.=
com> wrote:
> > >
> > >
> > > =E5=9C=A8 2025/1/20 19:04, Jonathan Cameron =E5=86=99=E9=81=93:
> > > > On Fri, 17 Jan 2025 10:29:57 +0800
> > > > Xiaofei Tan <tanxiaofei@huawei.com> wrote:
> > > >
> > > >> When the module HED is built-in, the module HED init is behind EVG=
ED
> > > >> as the driver are in the same initcall level, then the order is de=
termined
> > > >> by Makefile order. That order violates expectations. Because RAS r=
ecords
> > > >> can't be handled in the special time window that EVGED has initial=
ized
> > > >> while HED not.
> > > >>
> > > >> If the number of such RAS records is more than the APEI HEST error=
 source
> > > >> number, the HEST resources could be occupied all, and then could a=
ffect
> > > >> subsequent RAS error reporting.
> > > >>
> > > >> Change the initcall level of HED to subsys_init to fix the issue. =
If build
> > > >> HED as a module, the problem remains. To solve this problem comple=
tely,
> > > >> change the ACPI_HED from tristate to bool.
> > > >>
> > > >> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > > > Given the change in approach (even though I reviewed this internall=
y)
> > > > should probably have dropped my RB.   Anyhow, consider this me
> > > > giving it again on list.
> > > OK. thanks.
> >
> > Applied as 6.14-rc material with a rewritten changelog and under a new
> > subject: "ACPI: HED: Always initialize before evged".
> >
> > Thanks!
>
> For what it's worth, I just bisected a new error message that I see when
> booting several x86_64 distribution configurations in QEMU to this
> change in -next as commit 19badc4e57c6 ("ACPI: HED: Always initialize
> before evged"):
>
>   $ curl -LSso .config https://gitlab.archlinux.org/archlinux/packaging/p=
ackages/linux/-/raw/main/config
>
>   $ make -skj"$(nproc)" ARCH=3Dx86_64 CROSS_COMPILE=3Dx86_64-linux- oldde=
fconfig bzImage
>
>   $ qemu-system-x86_64 \
>         -display none \
>         -nodefaults \
>         -M q35 \
>         -d unimp,guest_errors \
>         -append 'console=3DttyS0 earlycon=3Duart8250,io,0x3f8' \
>         -kernel arch/x86/boot/bzImage \
>         -initrd rootfs.cpio \
>         -cpu host \
>         -enable-kvm \
>         -m 512m \
>         -smp 8
>         -serial mon:stdio
>   ...
>   [    0.535126] Error: Driver 'hardware_error_device' is already registe=
red, aborting...
>   ...
>
> If there is any additional information I can provide or patches I can
> test, I am more than happy to do so. Apologies if this has already been
> reported or resolved, I did a search on the mailing list and I did not
> see anything.

No, it hasn't.

So AFAICS the commit in question needs to do more to switch over hed
to non-modular.

I'll drop it for now, thanks!

