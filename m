Return-Path: <linux-acpi+bounces-12906-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FE37A8272E
	for <lists+linux-acpi@lfdr.de>; Wed,  9 Apr 2025 16:07:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 25A4E3A8CA3
	for <lists+linux-acpi@lfdr.de>; Wed,  9 Apr 2025 14:07:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F206726560D;
	Wed,  9 Apr 2025 14:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OWx4g3ME"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCDBB264A76
	for <linux-acpi@vger.kernel.org>; Wed,  9 Apr 2025 14:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744207641; cv=none; b=Y+z00xFgP+x2f0gFlCGjgQeSDx+EJlEiEvilUIIcPx4WZXsGfWK1MXhDacTULeJwinLuJjUJVduqWuPikk6o1z5c07BrKUb+2UQHwWKiX7K1lRSwauBuiiyghYnkiMfQoMu5+ONZW+bfzhgQ1f7fDf6ifPuH5exxi5RaccF9fl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744207641; c=relaxed/simple;
	bh=Ylnyd4UKcWGGSded241Wo5qaAuR45DuBA/5qomazLSo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nIb30hgs0LMX5cH+snzbAvKZjoi1jWD6nELknPoNOptZD8VwFLPd3pOF58rTokaNoTmU1ePbUS/UFQlE/DiFTdMz5SnPe1XGpOTYxOPuKAHzIWGSzJv1kdIRnCRvYSQRgzB6piPA1uMMMTTMOXFNPAvW6gNamPcV5ra6lCAag/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OWx4g3ME; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 513B9C4CEE2
	for <linux-acpi@vger.kernel.org>; Wed,  9 Apr 2025 14:07:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744207641;
	bh=Ylnyd4UKcWGGSded241Wo5qaAuR45DuBA/5qomazLSo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=OWx4g3MEBkwCkQjGlpvkF3HUVx6Z1sIHzOdLdX10adWkx+g0B6zdZlx33cp3dxgwP
	 /gjfg0BX6L+BiiCb5hw19JCGLSUXr96uGX5UlZXYb4YKkF3dsYtHMpQktcdA+rLOEM
	 91PasKejLoLhEoVNXq2ugGu9iXygWKuZPGYAgTdyPDeMT6zGct+npfxGXo7D+y1X9A
	 ZDgi3JoHRbPr27LecvzzQZBaaIG1zTxutKOUp696+915hs+/OotKJuYTRvhi//RPei
	 BJ0b4JQBcbCnNEO2L8rApRUWxUlbAZean6PcZddfF2ZfyexbLLucKuRluzITXC6SI6
	 azYBmUJp6IoTw==
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-2c12b7af278so548924fac.0
        for <linux-acpi@vger.kernel.org>; Wed, 09 Apr 2025 07:07:21 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXAku9Hz1VVN69tB0+V0r7DsKMZS91KtWR5TzNAxdMGbGat1AjcKUvNJEot44bS2KqupMzZCzwMH60p@vger.kernel.org
X-Gm-Message-State: AOJu0Yzfeud8qO5Wlh7Bxh4Et1OSovTF5K2fFiYb0CR5dPImR5pUxS2z
	a/h9TKIf1RuITUaX+lK8xHRoTJSL/rSYY9XTFUAAvSU/VgLfZUhnsaBPxQWWUxeHTLuwmgA+nvp
	hV7kwi9jSWnRHGYoVCEQgNwfhTh8=
X-Google-Smtp-Source: AGHT+IGC/A7sU/5qPA97lgZb2/LjsIdD+DX7DdMmLvr2fSxt/ypxFH1MadKCySziCcmUvWO1zSybBgjLcqyol+Y35h0=
X-Received: by 2002:a05:6870:7e8c:b0:2b8:5d9e:d0d9 with SMTP id
 586e51a60fabf-2d0648c58dbmr3672518fac.4.1744207640586; Wed, 09 Apr 2025
 07:07:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <Z_Qd0x6bLSQjJ7Rw@smile.fi.intel.com> <CAJZ5v0j2Y3vPZhUGJmcWzn6esg9zv5an0KPEN4QfQuyGrd5=YQ@mail.gmail.com>
 <Z_Qeot7pps5Q4vx7@smile.fi.intel.com> <LV8PR11MB86980990221C597E01BAEB7980B52@LV8PR11MB8698.namprd11.prod.outlook.com>
 <LV8PR11MB8698978FFF89ACBEF253667680B52@LV8PR11MB8698.namprd11.prod.outlook.com>
 <Z_ZY_UA7ypFzpT0t@smile.fi.intel.com> <Z_Z9mnDbypQ0KLF8@smile.fi.intel.com>
In-Reply-To: <Z_Z9mnDbypQ0KLF8@smile.fi.intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 9 Apr 2025 16:07:09 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0jWu4rEjO1bYzaTkF3Edcmnyi+3yEz9WNYzb8+3J74hEw@mail.gmail.com>
X-Gm-Features: ATxdqUERXfaraGx-9xin0b4-ewvt4t5EgbfCJmIz4mI_sEqHao4GnjegsWdn20Q
Message-ID: <CAJZ5v0jWu4rEjO1bYzaTkF3Edcmnyi+3yEz9WNYzb8+3J74hEw@mail.gmail.com>
Subject: Re: ACPICA compilation error on x86_64_defconfig (W=1 build)
To: "Shevchenko, Andriy" <andriy.shevchenko@intel.com>
Cc: "Dumbre, Saket" <saket.dumbre@intel.com>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	"Moore, Robert" <robert.moore@intel.com>, "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>, 
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, 
	"acpica-devel@lists.linux.dev" <acpica-devel@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 9, 2025 at 4:01=E2=80=AFPM Shevchenko, Andriy
<andriy.shevchenko@intel.com> wrote:
>
> Note, I have posted two much better solutions in that bug report thread.

Which bug report thread do you mean?

> Please, choose one and fix, it prevents kernel from building...

With Clang-19 and 'make W=3D1' that is.

> On Wed, Apr 09, 2025 at 02:24:45PM +0300, Shevchenko, Andriy wrote:
> > GCC should ignore all clang specific pragmas as far as I know.
> >
> > But this seems to me the not the best solution either. What code needs =
is to
> > have some refactoring to make sure the variable is used or not defined =
and used
> > at all. Unfortunately, I am not familiar with ACPICA to propose anythin=
g right
> > now, though.
> >
> > On Tue, Apr 08, 2025 at 09:34:36PM +0300, Dumbre, Saket wrote:
> > > I am not sure about the Linux environment specifics like Andy describ=
ed in the
> > > previous conversation, but if GCC or some other compiler throws an er=
ror in the
> > > code with #pragma for clang, then may I suggest using this instead:
> > >
> > > #pragma clang diagnostic push
> > > #if defined(__clang__) && __clang__ >=3D n (replace n with the least =
version
> > > number which introduces this new warning type)
> > > #pragma clang diagnostic ignored "-Wunused-but-set-variable"
> > > #endif
> > > u32 num_carats;
> > > #pragma clang diagnostic pop
> > >
> > > =E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=
=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=
=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=
=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=
=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=
=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=
=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=
=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=
=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=
=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81
> > > From: Dumbre, Saket <saket.dumbre@intel.com>
> > > Sent: Tuesday, April 8, 2025 11:11 AM
> > > To: Shevchenko, Andriy <andriy.shevchenko@intel.com>; Rafael J. Wysoc=
ki
> > > <rafael@kernel.org>
> > > Cc: Moore, Robert <robert.moore@intel.com>; Wysocki, Rafael J
> > > <rafael.j.wysocki@intel.com>; linux-acpi@vger.kernel.org
> > > <linux-acpi@vger.kernel.org>; acpica-devel@lists.linux.dev
> > > <acpica-devel@lists.linux.dev>
> > > Subject: Re: ACPICA compilation error on x86_64_defconfig (W=3D1 buil=
d)
> > >
> > > Hi Andy and Rafael,
> > >
> > > This issue is a duplication of an Apple ecosystem-based (ARM + M-seri=
es micro
> > > architecture) ACPICA GitHub Issue, which I was waiting on a response =
from the
> > > contributor/submitter to move ahead to resolve it:
> > > https://github.com/acpica/acpica/issues/973
> > >
> > > I don't see a platform specific file for Clang/LLVM in ACPICA (only f=
or GCC and
> > > MSVC), so I think the worst-case untidy solution would be to locally =
patch this
> > > warning-turned-error by suppressing this warning type if the compiler=
 is Clang/
> > > LLVM.
> > >
> > > It would look somewhat better to move that line all the way down afte=
r all the
> > > other definitions/declarations just before any execution line and wra=
p it with
> > > a #pragma something along the lines:
> > >
> > > #pragma clang diagnostic push
> > > #pragma clang diagnostic ignored "-Wunused-but-set-variable"
> > > u32 num_carats;
> > > #pragma clang diagnostic pop
> > >
> > > I am just not sure if this is the only place in the ACPICA code that =
generates
> > > this warning type and depending on the answer, this fix could be impl=
emented at
> > > a wider/global scale, but please give this hacky fix a try and let me=
 know if
> > > it resolves that. Thanks a lot!
> > >
> > >
> > > Kind regards,
> > >
> > > Saket Dumbre
> > >
> > >
> > > =E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=
=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=
=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=
=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=
=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=
=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=
=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=
=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=
=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=
=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81
> > > From: Shevchenko, Andriy
> > > Sent: Monday, April 7, 2025 11:51 AM
> > > To: Rafael J. Wysocki
> > > Cc: Dumbre, Saket; Moore, Robert; Wysocki, Rafael J;
> > > linux-acpi@vger.kernel.org; acpica-devel@lists.linux.dev
> > > Subject: Re: ACPICA compilation error on x86_64_defconfig (W=3D1 buil=
d)
> > >
> > > On Mon, Apr 07, 2025 at 08:49:41PM +0200, Rafael J. Wysocki wrote:
> > > > On Mon, Apr 7, 2025 at 8:47=E2=80=AFPM Andy Shevchenko
> > > > <andriy.shevchenko@intel.com> wrote:
> > > > >
> > > > > v6.15-rc1 (but seems older should also be problematic) fails to c=
ompile by
> > > > > Clang 19 with `make W=3D1`.
> > > > >
> > > > >   CC      drivers/acpi/acpica/nsaccess.o
> > > > >   drivers/acpi/acpica/nsaccess.c:295:6: error: variable 'num_cara=
ts' set
> > > but not used [-Werror,-Wunused-but-set-variable]
> > > > >     295 |         u32 num_carats;
> > > > >         |             ^
> > > > >   1 error generated.
> > > > >
> > > > > I looked briefly in the code and I have no idea how to fix this, =
as
> > > probably
> > > > > __maybe_unused not an option for ACPICA. Hence this report.
> > > > >
> > > > > Note, the in-tree defconfig is in use:
> > > > >
> > > > >         git checkout v6.15-rc1
> > > > >         make x86_64_defconfig
> > >
> > > > >         make W=3D1
> > >
> > > Since it's a clang, this should have also something like LLVM=3D1.
> > >
> > > > > should trigger it.
> > >
> > > --
> > > With Best Regards,
> > > Andy Shevchenko
> > >
> > >
> >
> > --
> > With Best Regards,
> > Andy Shevchenko
> >
> >
>
> --
> With Best Regards,
> Andy Shevchenko
>
>
>

