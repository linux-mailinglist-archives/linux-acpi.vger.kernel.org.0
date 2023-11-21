Return-Path: <linux-acpi+bounces-1706-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF3107F3606
	for <lists+linux-acpi@lfdr.de>; Tue, 21 Nov 2023 19:34:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 25A32B20E56
	for <lists+linux-acpi@lfdr.de>; Tue, 21 Nov 2023 18:34:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AB2051002
	for <lists+linux-acpi@lfdr.de>; Tue, 21 Nov 2023 18:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pe7fdDHC"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 868C6171C2;
	Tue, 21 Nov 2023 16:42:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 000F9C433A9;
	Tue, 21 Nov 2023 16:42:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700584933;
	bh=aFR/mFQKExXAv/nb9N19ON2XLkx59yXepa2exX1U6mQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Pe7fdDHCYkc7KSUUeoKGd+0k8Upqv5tT863pJGU6nom4MjmioYRNKbeeU0LYigqZq
	 mMoZQ3vR4gUYsV+BP9oBU4OcW/h49OyCHzx3buepvFUai6rwRi0xUoAubDBLKYTfiF
	 x2sEZ4+vPSgTUkOumnqe4Clb6jiycxpkF9ZKDfBJhdSvdEzoEJR6iMuaMYN+nrphmO
	 e4cyi62ZvttrtqkKx3rGbj0qL+rlTQXDv8NkAOoqv8abis72OenhUfPRZeO38ntXpw
	 WEIoTkiwOhGFOwsZGqT0zIdnUwC23hQ0e2dmCHM3KERmpmJUJYHdfojukPCpmwdbJm
	 cjJszLlSX6B5g==
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2c50fbc218bso72057671fa.3;
        Tue, 21 Nov 2023 08:42:12 -0800 (PST)
X-Gm-Message-State: AOJu0YzfltrG1BNxAEZMQuA8PWtOEFPjiUL4aGpQWKap8etok/rbE2G3
	TQ/WgemQoVqc4YCRwmRVPWdzbKPiFoWqZh09Uis=
X-Google-Smtp-Source: AGHT+IE1BtBBQXH8IhaD0lfThsj9OIMHKzDOIxlPBJGUB9DukWvY41yZhOqj18nk5W7PFyAXHxOdAkbW6vA0h7iKYww=
X-Received: by 2002:a2e:8e63:0:b0:2bb:a28b:58e1 with SMTP id
 t3-20020a2e8e63000000b002bba28b58e1mr7794383ljk.41.1700584931089; Tue, 21 Nov
 2023 08:42:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230926194242.2732127-1-sjg@chromium.org> <20230926194242.2732127-2-sjg@chromium.org>
 <BN9PR11MB5483FF3039913334C7EA83E1E6AEA@BN9PR11MB5483.namprd11.prod.outlook.com>
 <CAMj1kXFG92NpL7T7YocOup0xLKyopt3MnSCp0RL8cLzozzJz7A@mail.gmail.com>
 <BN9PR11MB548303B09536EB1577472029E6B3A@BN9PR11MB5483.namprd11.prod.outlook.com>
 <CAPnjgZ36t8g7E=0MSJyaV8-QKv9RVYe47Jd5E=NU-mFM4LWBQA@mail.gmail.com>
In-Reply-To: <CAPnjgZ36t8g7E=0MSJyaV8-QKv9RVYe47Jd5E=NU-mFM4LWBQA@mail.gmail.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Tue, 21 Nov 2023 11:41:59 -0500
X-Gmail-Original-Message-ID: <CAMj1kXHAEeK7x2f13k_JV3Xcw61nNLasyvXQf+mKwKekQ48EpQ@mail.gmail.com>
Message-ID: <CAMj1kXHAEeK7x2f13k_JV3Xcw61nNLasyvXQf+mKwKekQ48EpQ@mail.gmail.com>
Subject: Re: [PATCH v7 2/2] schemas: Add some common reserved-memory usages
To: Simon Glass <sjg@chromium.org>
Cc: "Chiu, Chasel" <chasel.chiu@intel.com>, 
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Rob Herring <robh@kernel.org>, "Tan, Lean Sheng" <sheng.tan@9elements.com>, 
	lkml <linux-kernel@vger.kernel.org>, Dhaval Sharma <dhaval@rivosinc.com>, 
	"Brune, Maximilian" <maximilian.brune@9elements.com>, Yunhui Cui <cuiyunhui@bytedance.com>, 
	"Dong, Guo" <guo.dong@intel.com>, Tom Rini <trini@konsulko.com>, 
	ron minnich <rminnich@gmail.com>, "Guo, Gua" <gua.guo@intel.com>, 
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, U-Boot Mailing List <u-boot@lists.denx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 20 Nov 2023 at 21:12, Simon Glass <sjg@chromium.org> wrote:
>
> Hi,
>
> On Mon, 13 Nov 2023 at 11:09, Chiu, Chasel <chasel.chiu@intel.com> wrote:
> >
> >
> > Hi Ard,
> >
> > Please see my reply below inline.
> >
> > Thanks,
> > Chasel
> >
> >
> > > -----Original Message-----
> > > From: Ard Biesheuvel <ardb@kernel.org>
> > > Sent: Saturday, November 11, 2023 3:04 AM
> > > To: Chiu, Chasel <chasel.chiu@intel.com>
> > > Cc: Simon Glass <sjg@chromium.org>; devicetree@vger.kernel.org; Mark =
Rutland
> > > <mark.rutland@arm.com>; Rob Herring <robh@kernel.org>; Tan, Lean Shen=
g
> > > <sheng.tan@9elements.com>; lkml <linux-kernel@vger.kernel.org>; Dhava=
l
> > > Sharma <dhaval@rivosinc.com>; Brune, Maximilian
> > > <maximilian.brune@9elements.com>; Yunhui Cui <cuiyunhui@bytedance.com=
>;
> > > Dong, Guo <guo.dong@intel.com>; Tom Rini <trini@konsulko.com>; ron mi=
nnich
> > > <rminnich@gmail.com>; Guo, Gua <gua.guo@intel.com>; linux-
> > > acpi@vger.kernel.org; U-Boot Mailing List <u-boot@lists.denx.de>
> > > Subject: Re: [PATCH v7 2/2] schemas: Add some common reserved-memory
> > > usages
> > >
> > > On Sat, 11 Nov 2023 at 04:20, Chiu, Chasel <chasel.chiu@intel.com> wr=
ote:
> > > >
> > > >
> > > > Just sharing some usage examples from UEFI/EDK2 scenario.
> > > > To support ACPI S4/Hibernation, memory map must be consistent befor=
e
> > > > entering and after resuming from S4, in this case payload may need =
to
> > > > know previous memory map from bootloader (currently generic payload
> > > > cannot access platform/bootloader specific non-volatile data, thus
> > > > could not save/restore memory map information)
> > >
> > > So how would EDK2 reconstruct the entire EFI memory map from just the=
se
> > > unannotated /reserved-memory nodes? The EFI memory map contains much
> > > more information than that, and all of it has to match the pre-hibern=
ate situation,
> > > right? Can you given an example?
> >
> >
> > Here we listed only typically memory types that may change cross differ=
ent platforms.
> > Reserved memory type already can be handled by reserved-memory node, an=
d rest of the types usually no need to change cross platforms thus currentl=
y we could rely on default in generic payload.
> > In the future if we see a need to add new memory types we will discuss =
and add it to FDT schema.
> >
> >
> >
> > >
> > > > Another usage is to support binary model which generic payload is a=
 prebuilt
> > > binary compatible for all platforms/configurations, however the paylo=
ad default
> > > memory map might not always work for all the configurations and we wa=
nt to
> > > allow bootloader to override payload default memory map without recom=
piling.
> > > >
> > >
> > > Agreed. But can you explain how a EDK2 payload might make meaningful =
use of
> > > 'runtime-code' regions provided via DT  by the non-EDK2 platform init=
? Can you
> > > give an example?
> >
> >
> > Runtime-code/data is used by UEFI payload for booting UEFI OS which req=
uired UEFI runtime services.
> > Platform Init will select some regions from the usable memory and assig=
n it to runtime-code/data for UPL to consume. Or assign same runtime-code/d=
ata from previous boot.
> > If UEFI OS is not supported, PlatformInit may not need to provide runti=
me-code/data regions to payload. (always providing runtime-code/data should=
 be supported too)
> >
> >
> > >
> > > > Under below assumption:
> > > >         FDT OS impact has been evaluated and taken care by relevant
> > > experts/stakeholders.
> > > > Reviewed-by: Chasel Chiu <chasel.chiu@intel.com>
> > > >
> > >
> > > I am sorry but I don't know what 'FDT OS impact' means. We are talkin=
g about a
> > > firmware-to-firmware abstraction that has the potential to leak into =
the OS
> > > visible interface.
> > >
> > > I am a maintainer in the Tianocore project myself, so it would help i=
f you could
> > > explain who these relevant experts and stakeholders are. Was this dis=
cussed on
> > > the edk2-devel mailing list? If so, apologies for missing it but I ma=
y not have been
> > > cc'ed perhaps?
> >
> >
> >
> >
> > I'm not familiar with FDT OS, also I do not know if who from edk2-devel=
 were supporting FDT OS, I think Simon might be able to connect FDT OS expe=
rts/stakeholders.
> > We are mostly focusing on payload firmware phase implementation in edk2=
 (and other payloads too), however, since we have aligned the payload FDT a=
nd OS FDT months ago, I'm assuming FDT OS impact must be there and we need =
(or already done?) FDT OS experts to support it. (again, maybe Simon could =
share more information about FDT OS)
> >
> > In edk2 such FDT schema is UefiPayloadPkg internal usage only and paylo=
ad entry will convert FDT into HOB thus we expected the most of the edk2 ge=
neric code are no-touch/no impact, that's why we only had small group (Uefi=
PayloadPkg) discussion.
> > Ard, if you are aware of any edk2 code that's for supporting FDT OS, pl=
ease let us know and we can discuss if those code were impacted or not.
>
> We discussed this and just to clarify, 'FDT OS' is not a special OS,
> it is just Linux.
>
> So, with the above, are we all on the same page? Can the patch be
> applied, perhaps? If not, what other discussion is needed?
>

An example of how a platform-init/payload combination would make
meaningful use of such runtime-code/data regions.

