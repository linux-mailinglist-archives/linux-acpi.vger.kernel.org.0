Return-Path: <linux-acpi+bounces-18156-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 04A92C01F84
	for <lists+linux-acpi@lfdr.de>; Thu, 23 Oct 2025 17:04:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B11633AE57A
	for <lists+linux-acpi@lfdr.de>; Thu, 23 Oct 2025 15:01:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E86F9332EAB;
	Thu, 23 Oct 2025 15:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZhElHD9w"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C35AD225791
	for <linux-acpi@vger.kernel.org>; Thu, 23 Oct 2025 15:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761231611; cv=none; b=oL+gjxJd2rvwcQrOXyISl9NQJc0K1AWe+5gOeE2+Cfd3F9Vslo3gEcHP1f5/YLfNWKjNi58ROk4wFVCZ2jZo/dhgYXdWaG8EJqbbVcatn8K41V+hQZmdcKtxWnUViMwbfTOrhp0i5E9j5/85Z6e9tIG4EQN22WdrLsNkoKGzEDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761231611; c=relaxed/simple;
	bh=4D2jOJRxSF4dEQgBcZy8n0Oy2bxBObeKMoSrbVEDkuA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=segfzajDGMOiXf8DLnFrRtCB++zL2IH3Zx7jR2rtjvtn8JMzeJ9CyoPiLmSOgmNylMmGYB16IFBC1AbTaIK/xV1WIuyxT3Q4EDJWcfhioMqQJo72dvYsDTjrx0xyYuL56XSBC+ndNSLpxDq1erigLZw3P6Ikw52dHNp82R8JY0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZhElHD9w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78593C19421
	for <linux-acpi@vger.kernel.org>; Thu, 23 Oct 2025 15:00:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761231611;
	bh=4D2jOJRxSF4dEQgBcZy8n0Oy2bxBObeKMoSrbVEDkuA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=ZhElHD9w+eEOeLILoWpl/ROaHfan6lMyEhMOFJb+7njnsEVxNuiwnbq2+vlhbIjum
	 Dxz2wY8NQ75RPtfc68s+M99moe/y01nbL2SweJHao0HWoXSl5aLi9tZohr/LAWw3Nl
	 aXwau7DwJQ2MbJZzl17/PgDpunbiFjPrp7Dtz8aGfypJpCGC+sKC3BZbtvRPenkELN
	 60U+gsLcnENM35oLmNwurzuTGMBFh6WQKjXLxNdzjCsWz5qur7HfN+bywhjfMuJ2+b
	 ND/ejimLyV67FWEg5zB0GN41vmTpFmqvuqeUH813umtuT3hDHgPYmQtnQgy4Lg/llS
	 L0IZK0NJJCIHQ==
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-443a9ae4639so469398b6e.1
        for <linux-acpi@vger.kernel.org>; Thu, 23 Oct 2025 08:00:11 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXPX5pjM7LPWoVeMW5TARhzKhbRNk8gIFGsSaEsp3mJlhz9lHr/Hg3ZgOdQUoSG8gais+UObQ/sMXs9@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9Zkj9l5hziWbz653Mu8gZ5NgbsPr18Oi6BK45JsBZ/w4fffDE
	Le7ALZo+v6j/5eMM5jsOTYzxC8FsRQpmgr4aETi4UZgtDsrAG5uQZozr4twMVf8UENZsNotTF27
	i/L1KY0X+xx4k3lBX/Y0L0a38p7lh7DM=
X-Google-Smtp-Source: AGHT+IHa1e0HiSHmvwXRumDdY7jZn5K3wnKO4MT9rWI/sxjE/u3U28hEj9Jhooq5nM+ZxTxJW/DdLo+z7u3biFECeGs=
X-Received: by 2002:a05:6808:6909:b0:438:37eb:62c7 with SMTP id
 5614622812f47-443a2e2985fmr11783735b6e.21.1761231610537; Thu, 23 Oct 2025
 08:00:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251002113404.3117429-1-srosek@google.com> <20251002113404.3117429-2-srosek@google.com>
 <CAJZ5v0ho8MhU8jj=YMyDKdTQWZt24LjoCaoEgJRsdi3YykkBBQ@mail.gmail.com> <CAF3aWvGdvHxA_fJm1EE2byL0LQUC3K2LGeDLxr3EpRzSQ=3Waw@mail.gmail.com>
In-Reply-To: <CAF3aWvGdvHxA_fJm1EE2byL0LQUC3K2LGeDLxr3EpRzSQ=3Waw@mail.gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 23 Oct 2025 16:59:59 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0jPJqpX5xJX0j5OC21sp093O_B+jsL1mSBztR1wORV0Fg@mail.gmail.com>
X-Gm-Features: AS18NWBXAE19BSgci90ZeQZmyqlqzpPybg5SJsR149yPoAo8jLxZSgIzaDlfpfM
Message-ID: <CAJZ5v0jPJqpX5xJX0j5OC21sp093O_B+jsL1mSBztR1wORV0Fg@mail.gmail.com>
Subject: Re: [PATCH v3 1/6] ACPI: DPTF: Ignore SoC DTS thermal while scanning
To: =?UTF-8?Q?S=C5=82awomir_Rosek?= <srosek@google.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Alex Hung <alexhung@gmail.com>, 
	Hans de Goede <hansg@kernel.org>, Ilpo Jarvinen <ilpo.jarvinen@linux.intel.com>, 
	AceLan Kao <acelan.kao@canonical.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Zhang Rui <rui.zhang@intel.com>, 
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Tomasz Nowicki <tnowicki@google.com>, 
	Stanislaw Kardach <skardach@google.com>, Michal Krawczyk <mikrawczyk@google.com>, 
	linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, 
	platform-driver-x86@vger.kernel.org, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 23, 2025 at 4:36=E2=80=AFPM S=C5=82awomir Rosek <srosek@google.=
com> wrote:
>
> On Wed, Oct 22, 2025 at 8:33=E2=80=AFPM Rafael J. Wysocki <rafael@kernel.=
org> wrote:
> >
> > On Thu, Oct 2, 2025 at 1:34=E2=80=AFPM Slawomir Rosek <srosek@google.co=
m> wrote:
> > >
> > > The Intel SoC DTS thermal driver on Baytrail platform uses IRQ 86 for
> > > critical overheating notification. The IRQ 86 is described in the _CR=
S
> > > control method of INT3401 device, thus Intel SoC DTS thermal driver
> > > requires INT3401 device to be enumerated.
> >
> > I don't think that the specific interrupt number is relevant here.  It
> > would be sufficient to say something like "The IRQ used by the Intel
> > SoC DTS thermal device for critical overheating notification is listed
> > in _CRS of device INT3401 which therefore needs to be enumerated for
> > Intel SoC DTS thermal to work."
>
> Above text is copied from the original change which is linked below.
> I will rephrase it as you suggested.
>
> >
> > > Since dependency on INT3401 device is unrelated to DPTF the IS_ENABLE=
()
> > > macro is removed from ACPI DPTF INT340X scan handler, instead Kconfig
> > > is updated to ensure proper enumeration of INT3401 device.
> >
> > It is not entirely clear what happens in this patch after reading the
> > above paragraph.
> >
> > I would rather continue the previous thought by saying that the
> > enumeration happens by binding the int3401_thermal driver to the
> > INT3401 platform device.  Thus CONFIG_INT340X_THERMAL is in fact
> > necessary for enumerating it, so checking CONFIG_INTEL_SOC_DTS_THERMAL
> > in int340x_thermal_handler_attach() is pointless and INT340X_THERMAL
> > may as well be selected by INTEL_SOC_DTS_THERMAL.
>
> Sure, I will rephrase it to clearly describe what happens here.
>
> >
> > > Fixes: 014d9d5d0cc1 ("ACPI/int340x_thermal: enumerate INT3401 for Int=
el SoC DTS thermal driver")
> >
> > Why do you want this tag to be added?
>
> Just for context. The IS_ENABLE is added to the scan handler in 014d9d5d0=
cc1
> and this change is about to fix that. I can remove the tag if it's not ne=
eded.

I don't see a functional issue with this, it is just dead code AFAICS.
As a rule, Fixes: tags are not added to patches removing dead code.

> >
> > > Signed-off-by: Slawomir Rosek <srosek@google.com>
> > > ---
> > >  drivers/acpi/dptf/int340x_thermal.c | 7 +------
> > >  drivers/thermal/intel/Kconfig       | 3 ++-
> > >  2 files changed, 3 insertions(+), 7 deletions(-)
> > >
> > > diff --git a/drivers/acpi/dptf/int340x_thermal.c b/drivers/acpi/dptf/=
int340x_thermal.c
> > > index a222df059a16..947fe50c2ef6 100644
> > > --- a/drivers/acpi/dptf/int340x_thermal.c
> > > +++ b/drivers/acpi/dptf/int340x_thermal.c
> > > @@ -11,10 +11,9 @@
> > >
> > >  #include "../internal.h"
> > >
> > > -#define INT3401_DEVICE 0X01
> > >  static const struct acpi_device_id int340x_thermal_device_ids[] =3D =
{
> > >         {"INT3400"},
> > > -       {"INT3401", INT3401_DEVICE},
> > > +       {"INT3401"},
> > >         {"INT3402"},
> > >         {"INT3403"},
> > >         {"INT3404"},
> > > @@ -76,10 +75,6 @@ static int int340x_thermal_handler_attach(struct a=
cpi_device *adev,
> > >  {
> > >         if (IS_ENABLED(CONFIG_INT340X_THERMAL))
> > >                 acpi_create_platform_device(adev, NULL);
> > > -       /* Intel SoC DTS thermal driver needs INT3401 to set IRQ desc=
riptor */
> > > -       else if (IS_ENABLED(CONFIG_INTEL_SOC_DTS_THERMAL) &&
> > > -                id->driver_data =3D=3D INT3401_DEVICE)
> > > -               acpi_create_platform_device(adev, NULL);
> > >         return 1;
> > >  }
> > >
> > > diff --git a/drivers/thermal/intel/Kconfig b/drivers/thermal/intel/Kc=
onfig
> > > index e0268fac7093..f9e275538e29 100644
> > > --- a/drivers/thermal/intel/Kconfig
> > > +++ b/drivers/thermal/intel/Kconfig
> > > @@ -44,7 +44,8 @@ config INTEL_SOC_DTS_IOSF_CORE
> > >
> > >  config INTEL_SOC_DTS_THERMAL
> > >         tristate "Intel SoCs DTS thermal driver"
> > > -       depends on X86 && PCI && ACPI
> > > +       depends on X86_64 && PCI && ACPI
> >
> > AFAICS NET needs to be added to the dependency list above or selecting
> > INT340X_THERMAL below may not actually cause it to be built.
>
> Right. Previously I tried to "select NET" (INTEL_SOC_DTS_THERMAL does not
> depend on NET directly so it seemed to be more appropriate to me) but got
> circular dependency error so I assumed it is ensured somehow. Now I check=
ed
> again and you are right, I was able to disable NET and get unmet dependen=
cies.
> I will add dependency on NET. Thanks

The rule of thumb is that if you want A to select B, then they both
need to depend on the same things.

> >
> > > +       select INT340X_THERMAL
> > >         select INTEL_SOC_DTS_IOSF_CORE
> > >         help
> > >           Enable this to register Intel SoCs (e.g. Bay Trail) platfor=
m digital
> > > --
>

