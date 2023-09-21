Return-Path: <linux-acpi+bounces-17-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21B807A95B4
	for <lists+linux-acpi@lfdr.de>; Thu, 21 Sep 2023 18:30:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD770281BD4
	for <lists+linux-acpi@lfdr.de>; Thu, 21 Sep 2023 16:30:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9415ABA3A
	for <lists+linux-acpi@lfdr.de>; Thu, 21 Sep 2023 16:30:14 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AA2920E7;
	Thu, 21 Sep 2023 15:20:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0B4BC4E769;
	Thu, 21 Sep 2023 15:20:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1695309653;
	bh=rx2mBq0S4jOILd4Wy6fahnc3smaID9qQL5yme6+cfXo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=HLRnLX/wSplzOGEeyeBmR/Fv4NUMnPnLmnmnxPUt/KtmG2LhWs1zHxcxO+l/7d1xm
	 7RIIcOpj3VUysvVz80wzBpWSV3EZr6PxbixD2ttI0aXZGwjLWIcpCmSZchVuf9ONyF
	 r1FIAwffNsSq4WxcwyB0ZkGVq9oB6hkqMKnIPMU45DVjq8a1ZvwpA8NNcDZb2RONzA
	 HDeXASWJk18PEXGIvcwzJkuNvnTl/nO8srNo8BOrkdjQQvsTXqVE6gMPm+BPLgjycc
	 3Hgb8ggMrlKSkgEmISe4WBwkBx3EBlSPYnmC/UM8+z8fRARyWz7iCG/YfZ04dc2zCS
	 FA19n/Gv/JchA==
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-502153ae36cso1873538e87.3;
        Thu, 21 Sep 2023 08:20:53 -0700 (PDT)
X-Gm-Message-State: AOJu0YxXdouyeDodBHRJkXUhrACe0d2adI3wzuEYhMlQOipDpoqTCoiO
	1bdxmXfYYV4qJZlXH7fW+JCleGaYS+B5Gnwc/Q==
X-Google-Smtp-Source: AGHT+IF6PiJLK0gbCkd0ug1K5ldijn1PTOoqwsaU2NTp56tyTljvoRHYmhguxEitR2xZCgafPoy7TVLHNd/qL9jHCJw=
X-Received: by 2002:a05:6512:2387:b0:503:af9:eb1c with SMTP id
 c7-20020a056512238700b005030af9eb1cmr6330203lfv.27.1695309651666; Thu, 21 Sep
 2023 08:20:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230907214012.74978-1-sjg@chromium.org> <CAL_Jsq+WfWrZErmz4u3_-CoVAuxL21UndcRekfJ1e61ZMMBqRw@mail.gmail.com>
 <CAPnjgZ3ALq9Hr+t4CywO113mKr83xCgFhfz+6=jav3T3R1_TGA@mail.gmail.com>
In-Reply-To: <CAPnjgZ3ALq9Hr+t4CywO113mKr83xCgFhfz+6=jav3T3R1_TGA@mail.gmail.com>
From: Rob Herring <robh@kernel.org>
Date: Thu, 21 Sep 2023 10:20:39 -0500
X-Gmail-Original-Message-ID: <CAL_JsqJdTR9morobxty1egHFmTwL1-Kh3-sQ5CY7xit80fE2jw@mail.gmail.com>
Message-ID: <CAL_JsqJdTR9morobxty1egHFmTwL1-Kh3-sQ5CY7xit80fE2jw@mail.gmail.com>
Subject: Re: [PATCH v6 1/2] schemas: Add some common reserved-memory usages
To: Simon Glass <sjg@chromium.org>
Cc: devicetree@vger.kernel.org, Dhaval Sharma <dhaval@rivosinc.com>, 
	Guo Dong <guo.dong@intel.com>, U-Boot Mailing List <u-boot@lists.denx.de>, 
	Yunhui Cui <cuiyunhui@bytedance.com>, Chiu Chasel <chasel.chiu@intel.com>, 
	Mark Rutland <mark.rutland@arm.com>, linux-acpi@vger.kernel.org, 
	Maximilian Brune <maximilian.brune@9elements.com>, Ard Biesheuvel <ardb@kernel.org>, 
	Tom Rini <trini@konsulko.com>, Lean Sheng Tan <sheng.tan@9elements.com>, 
	Gua Guo <gua.guo@intel.com>, ron minnich <rminnich@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 21, 2023 at 9:38=E2=80=AFAM Simon Glass <sjg@chromium.org> wrot=
e:
>
> Hi Rob,
>
> On Thu, 21 Sept 2023 at 08:25, Rob Herring <robh@kernel.org> wrote:
> >
> > On Thu, Sep 7, 2023 at 4:40=E2=80=AFPM Simon Glass <sjg@chromium.org> w=
rote:
> > >
> > > It is common to split firmware into 'Platform Init', which does the
> > > initial hardware setup and a "Payload" which selects the OS to be boo=
ted.
> > > Thus an handover interface is required between these two pieces.
> > >
> > > This aims to provide an small schema addition for the memory mapping
> > > needed to keep these two pieces working together well.
> > >
> > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > ---
> > >
> > > Changes in v6:
> > > - Drop mention of UEFI
> > > - Use compatible strings instead of node names
> > >
> > > Changes in v5:
> > > - Drop the memory-map node (should have done that in v4)
> > > - Tidy up schema a bit
> > >
> > > Changes in v4:
> > > - Make use of the reserved-memory node instead of creating a new one
> > >
> > > Changes in v3:
> > > - Reword commit message again
> > > - cc a lot more people, from the FFI patch
> > > - Split out the attributes into the /memory nodes
> > >
> > > Changes in v2:
> > > - Reword commit message
> > >
> > >  .../reserved-memory/common-reserved.yaml      | 71 +++++++++++++++++=
++
> > >  1 file changed, 71 insertions(+)
> > >  create mode 100644 dtschema/schemas/reserved-memory/common-reserved.=
yaml
> > >
> > > diff --git a/dtschema/schemas/reserved-memory/common-reserved.yaml b/=
dtschema/schemas/reserved-memory/common-reserved.yaml
> > > new file mode 100644
> > > index 0000000..4889f59
> > > --- /dev/null
> > > +++ b/dtschema/schemas/reserved-memory/common-reserved.yaml
> > > @@ -0,0 +1,71 @@
> > > +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> > > +%YAML 1.2
> > > +---
> > > +$id: http://devicetree.org/schemas/reserved-memory/common-reserved.y=
aml#
> > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > +
> > > +title: Common memory reservations
> > > +
> > > +description: |
> > > +  Specifies that the reserved memory region can be used for the purp=
ose
> > > +  indicated by its compatible string.
> > > +
> > > +  Clients may reuse this reserved memory if they understand what it =
is for,
> > > +  subject to the notes below.
> > > +
> > > +maintainers:
> > > +  - Simon Glass <sjg@chromium.org>
> > > +
> > > +allOf:
> > > +  - $ref: reserved-memory.yaml
> > > +
> > > +properties:
> > > +  compatible:
> > > +    description: |
> > > +      This describes some common memory reservations:
> > > +
> > > +         acpi-reclaim: Contains ACPI tables; memory may be reclaimed=
 when the
> > > +           tables are no-longer needed
> >
> > I think you are mixing 2 things with the name here. What the memory
> > contains and what to do with it. You don't need the latter. The
> > consumer of the region will know what to do with it if anything based
> > on knowing what is in the region. For example, The DTB passed to the
> > OS is typically in a reserved region (probably still /mem-reserve/
> > though). The DTB may remain there forever or the OS could copy it
> > somewhere else and free the reserved region. The Linux kernel does
> > both depending on the arch. (Of course there is no "dtb" compatible
> > because we have to pass the location of the dtb to even find the
> > reserved regions in the first place.)
> >
> > So the question here is whether just "acpi" (or "acpi-tables"?) would
> > be explicit enough?
>
> Yes acpi-tables would be enough.
>
> >
> > > +         acpi-nvs: Contains ACPI Non-volatile-storage data; memory m=
ay be
> > > +           reclaimed when the tables are no-longer needed
> >
> > No need to say anything about reclaiming.
>
> OK...so what about all that discussion about being able to reclaim the
> memory if you know what it is for? Where should that be written? Or is
> it somewhere else already?

Reclaiming is a policy of the consumer of the data. It belongs in the
documentation of the consumer if you are going to document it.

The global policy is you can't use reserved regions and you can't
reclaim them if you don't know what they are. If you want to add
something to that effect in reserved-memory.yaml or the spec, that's
fine, but that's not a per compatible thing.

> > I know some ACPIisms (e.g. DSDT), but I don't know what NVS or
> > "Non-volatile-storage data" is in an ACPI context.
> >
> > > +         boot-code: Contains code used for booting; memory may be re=
claimed by
> > > +           the OS when it is running
> > > +         boot-code: Contains data used for booting; memory may be re=
claimed by
> >
> > boot-data?
>
> Yes
>
> >
> > > +           the OS when it is running
> >
> > I thought these were for stages before we get to OS?
>
> Yes...but of course these will be passed on to the OS in some form.
> See above re reclaiming.
>
> >
> > > +         runtime-code: Contains code used for interacting with the s=
ystem when
> > > +           running; memory may be reclaimed if this code is not call=
ed
> > > +         runtime-data: Contains data used for interacting with the s=
ystem when
> > > +           running; memory may be reclaimed if the runtime code is n=
ot used
> >
> > "boot" vs. "runtime" seem too vague. However, if these mean EFI boot
> > time services and runtime services, then I understand exactly what
> > they are. In that case dropping 'uefi,' was a mistake. But EFI has its
> > own way to define these regions, right?
>
> I really don't want to do another round of that circle. I was asked to
> drop mention of EFI which I did. If these are too vague, what should I
> do instead? Perhaps:
>
> boot-code / data
> os-code / data

The kernel is boot code (and os code and runtime code). Can I use
these for the kernel image? Certainly not. But they are too vague to
understand when to use them and when not to. Are they specific to EDK2
implementation? Then perhaps they need an 'edk2' prefix.

Either these are related to EFI boot time services and runtime
services or they aren't. Which is it? If they are related, then EFI
should certainly be mentioned. Review comments are wrong all the time
when the reasoning is missing or misunderstood. Please back up and
explain why these are needed. Maybe it's buried in prior threads
somewhere, but I'm not going back to re-read all that. This patch has
to stand on its own.

Rob

