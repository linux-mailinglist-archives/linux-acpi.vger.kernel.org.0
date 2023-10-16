Return-Path: <linux-acpi+bounces-685-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D2127CB6A5
	for <lists+linux-acpi@lfdr.de>; Tue, 17 Oct 2023 00:38:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B4DBF281170
	for <lists+linux-acpi@lfdr.de>; Mon, 16 Oct 2023 22:38:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69EB038FAA
	for <lists+linux-acpi@lfdr.de>; Mon, 16 Oct 2023 22:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="JZ7Z4BVj"
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84D3D30D0A
	for <linux-acpi@vger.kernel.org>; Mon, 16 Oct 2023 21:55:17 +0000 (UTC)
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E50FD9
	for <linux-acpi@vger.kernel.org>; Mon, 16 Oct 2023 14:55:14 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id 38308e7fff4ca-2c5071165d5so33592991fa.0
        for <linux-acpi@vger.kernel.org>; Mon, 16 Oct 2023 14:55:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1697493313; x=1698098113; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tc/P1acb3I8J14trQrv7akNjvswnVV/SQ5E3mgTEuIc=;
        b=JZ7Z4BVjr7hoUb2aCGraNwtXyZ8bOVkceOswKRP1KKwJ26FA4axsNw9UxyHAYgEUf5
         c3/YGmaUY4e57aqz9+iz4Y2O4nc8+haVhBJbf+SDhhVEEeKHxi5wZn7vD/l97ur9/Gry
         AiasncMSXHO7LQFg2Q2H5pFnO+/73g96ml3vw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697493313; x=1698098113;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tc/P1acb3I8J14trQrv7akNjvswnVV/SQ5E3mgTEuIc=;
        b=d287XICElqhBXeIC0GWaLeYnsjlbTicE0oNtlWYsH7QPE5A3dp5Eh97G2PXW0JEUez
         iEE9p4lM+BqHYk2SiMlL4JQAE8GAu77JbP6AglBNRYOlNkz/iAnri8cpBkOKfgb9Ngxm
         Y4kigWiU08jFD+a4PNYae6UmU9qA+rEIgPpKN9sTkqdjdqcBPYlJoJdNPBvq6D5UZ3JW
         XQJVT8lx1cMMuUiyiE7MUfEeWgjAQ8IQOV/KjzTwjoXdAzHmEz/ZFX3Dc9teqIu7XGgr
         RUNnRFz9e4h60xO+h+/NnN8Y3TvXAEVyDTvGwFG6m9KQTKzNl+dd8wEZwqTiaBZzCXsw
         iy5w==
X-Gm-Message-State: AOJu0YxI6yZbz7ZC2UGWEe1GVlw7w33eSgwhmajt8fJlGyn1yzbQHNEh
	Gq9ECeErJt+AwJT7wt3+jcwxiW65aDTBWRVLqVYzXg==
X-Google-Smtp-Source: AGHT+IGrwZMQ9sUCx6I8enf1J/AgIX1ksUJw2fuS+bwo/E/oF7a8RXAkSkVW1F5psnfn+q/MivI7/AjfDzYKvoyBFnk=
X-Received: by 2002:a2e:b0ed:0:b0:2b9:ecab:d924 with SMTP id
 h13-20020a2eb0ed000000b002b9ecabd924mr334866ljl.18.1697493312677; Mon, 16 Oct
 2023 14:55:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230926194242.2732127-1-sjg@chromium.org> <20230926194242.2732127-2-sjg@chromium.org>
 <CAPnjgZ0Xf3U1aj32LbU-xiU1AqwnM3JL1F8xX-wZ18oEmg+irw@mail.gmail.com>
 <CAMj1kXEXcX7BkDyfy-6_5Vnch=N+onza-yfWfsVaGLE93h2c+Q@mail.gmail.com>
 <CAPnjgZ2SEby-ndrs=W_afBJH56eqc=-mhp1F1nwkvWks+=B54Q@mail.gmail.com>
 <CAMj1kXED3S+0cq+VT7naBrmWrUwT=HZAaZOBRMv8Ui1Pey1QNQ@mail.gmail.com>
 <CAPnjgZ0LrsJ2_ENTYoBrnyFaH3UKdHs3D2XWY=TzBuBpBoTXZA@mail.gmail.com>
 <CAL_Jsq+DQugkEDESW5wySFbLLN8HNqGDJCio8Wpi6fe0LeHKUA@mail.gmail.com>
 <CAPnjgZ0cmKP5hoGCyQ_Rp8ZQXUVwaPYJMWyidXuOOjMVkDoMDw@mail.gmail.com> <CAL_JsqJH=vJ40PNTg_i0LoKA-c0hhMJkL8zCC3_bB-tOkFWWsw@mail.gmail.com>
In-Reply-To: <CAL_JsqJH=vJ40PNTg_i0LoKA-c0hhMJkL8zCC3_bB-tOkFWWsw@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 16 Oct 2023 15:54:56 -0600
Message-ID: <CAPnjgZ1FrdGKjGAxUbkQoL2vHwhC_2Oa2KT+0cm25dQAuAjxAQ@mail.gmail.com>
Subject: Re: [PATCH v7 2/2] schemas: Add some common reserved-memory usages
To: Rob Herring <robh@kernel.org>
Cc: Ard Biesheuvel <ardb@kernel.org>, devicetree@vger.kernel.org, 
	Mark Rutland <mark.rutland@arm.com>, Lean Sheng Tan <sheng.tan@9elements.com>, 
	lkml <linux-kernel@vger.kernel.org>, Dhaval Sharma <dhaval@rivosinc.com>, 
	Maximilian Brune <maximilian.brune@9elements.com>, Yunhui Cui <cuiyunhui@bytedance.com>, 
	Guo Dong <guo.dong@intel.com>, Tom Rini <trini@konsulko.com>, 
	ron minnich <rminnich@gmail.com>, Gua Guo <gua.guo@intel.com>, 
	Chiu Chasel <chasel.chiu@intel.com>, linux-acpi@vger.kernel.org, 
	U-Boot Mailing List <u-boot@lists.denx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-9.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_SPF_WL
	autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi Rob,

On Mon, 16 Oct 2023 at 10:50, Rob Herring <robh@kernel.org> wrote:
>
> On Fri, Oct 13, 2023 at 4:09=E2=80=AFPM Simon Glass <sjg@chromium.org> wr=
ote:
> >
> > Hi Rob,
> >
> > On Fri, 13 Oct 2023 at 13:42, Rob Herring <robh@kernel.org> wrote:
> > >
> > > On Fri, Oct 6, 2023 at 7:03=E2=80=AFPM Simon Glass <sjg@chromium.org>=
 wrote:
> > > >
> > > > Hi Ard,
> > > >
> > > > On Fri, 6 Oct 2023 at 17:00, Ard Biesheuvel <ardb@kernel.org> wrote=
:
> > > > >
> > > > > On Fri, 6 Oct 2023 at 20:17, Simon Glass <sjg@chromium.org> wrote=
:
> > > > > >
> > > > > > Hi Ard,
> > > > > >
> > > > > > On Fri, 6 Oct 2023 at 11:33, Ard Biesheuvel <ardb@kernel.org> w=
rote:
> > > > > > >
> > > > > > > On Mon, 2 Oct 2023 at 19:54, Simon Glass <sjg@chromium.org> w=
rote:
> > > > > > > >
> > > > > > > > Hi Rob,
> > > > > > > >
> > > > > > > > On Tue, 26 Sept 2023 at 13:42, Simon Glass <sjg@chromium.or=
g> wrote:
> > > > > > > > >
> > > > > > > > > It is common to split firmware into 'Platform Init', whic=
h does the
> > > > > > > > > initial hardware setup and a "Payload" which selects the =
OS to be booted.
> > > > > > > > > Thus an handover interface is required between these two =
pieces.
> > > > > > > > >
> > > > > > > > > Where UEFI boot-time services are not available, but UEFI=
 firmware is
> > > > > > > > > present on either side of this interface, information abo=
ut memory usage
> > > > > > > > > and attributes must be presented to the "Payload" in some=
 form.
> > > > > > > > >
> > > > > > > > > This aims to provide an small schema addition for the mem=
ory mapping
> > > > > > > > > needed to keep these two pieces working together well.
> > > > > > > > >
> > > > > > > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > > > > > > > ---
> > > > > > > > >
> > > > > > > > > Changes in v7:
> > > > > > > > > - Rename acpi-reclaim to acpi
> > > > > > > > > - Drop individual mention of when memory can be reclaimed
> > > > > > > > > - Rewrite the item descriptions
> > > > > > > > > - Add back the UEFI text (with trepidation)
> > > > > > > >
> > > > > > > > I am again checking on this series. Can it be applied, plea=
se?
> > > > > > > >
> > > > > > >
> > > > > > > Apologies for the delay in response. I have been away.
> > > > > >
> > > > > > OK, I hope you had a nice trip.
> > > > > >
> > > > >
> > > > > Thanks, it was wonderful!
> > > > >
> > > > > > >
> > > > > > > >
> > > > > > > > >
> > > > > > > > > Changes in v6:
> > > > > > > > > - Drop mention of UEFI
> > > > > > > > > - Use compatible strings instead of node names
> > > > > > > > >
> > > > > > > > > Changes in v5:
> > > > > > > > > - Drop the memory-map node (should have done that in v4)
> > > > > > > > > - Tidy up schema a bit
> > > > > > > > >
> > > > > > > > > Changes in v4:
> > > > > > > > > - Make use of the reserved-memory node instead of creatin=
g a new one
> > > > > > > > >
> > > > > > > > > Changes in v3:
> > > > > > > > > - Reword commit message again
> > > > > > > > > - cc a lot more people, from the FFI patch
> > > > > > > > > - Split out the attributes into the /memory nodes
> > > > > > > > >
> > > > > > > > > Changes in v2:
> > > > > > > > > - Reword commit message
> > > > > > > > >
> > > > > > > > >  .../reserved-memory/common-reserved.yaml      | 71 +++++=
++++++++++++++
> > > > > > > > >  1 file changed, 71 insertions(+)
> > > > > > > > >  create mode 100644 dtschema/schemas/reserved-memory/comm=
on-reserved.yaml
> > > > > > > > >
> > > > > > > > > diff --git a/dtschema/schemas/reserved-memory/common-rese=
rved.yaml b/dtschema/schemas/reserved-memory/common-reserved.yaml
> > > > > > > > > new file mode 100644
> > > > > > > > > index 0000000..f7fbdfd
> > > > > > > > > --- /dev/null
> > > > > > > > > +++ b/dtschema/schemas/reserved-memory/common-reserved.ya=
ml
> > > > > > > > > @@ -0,0 +1,71 @@
> > > > > > > > > +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> > > > > > > > > +%YAML 1.2
> > > > > > > > > +---
> > > > > > > > > +$id: http://devicetree.org/schemas/reserved-memory/commo=
n-reserved.yaml#
> > > > > > > > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > > > > > > > +
> > > > > > > > > +title: Common memory reservations
> > > > > > > > > +
> > > > > > > > > +description: |
> > > > > > > > > +  Specifies that the reserved memory region can be used =
for the purpose
> > > > > > > > > +  indicated by its compatible string.
> > > > > > > > > +
> > > > > > > > > +  Clients may reuse this reserved memory if they underst=
and what it is for,
> > > > > > > > > +  subject to the notes below.
> > > > > > > > > +
> > > > > > > > > +maintainers:
> > > > > > > > > +  - Simon Glass <sjg@chromium.org>
> > > > > > > > > +
> > > > > > > > > +allOf:
> > > > > > > > > +  - $ref: reserved-memory.yaml
> > > > > > > > > +
> > > > > > > > > +properties:
> > > > > > > > > +  compatible:
> > > > > > > > > +    description: |
> > > > > > > > > +      This describes some common memory reservations, wi=
th the compatible
> > > > > > > > > +      string indicating what it is used for:
> > > > > > > > > +
> > > > > > > > > +         acpi: Advanced Configuration and Power Interfac=
e (ACPI) tables
> > > > > > > > > +         acpi-nvs: ACPI Non-Volatile-Sleeping Memory (NV=
S). This is reserved by
> > > > > > > > > +           the firmware for its use and is required to b=
e saved and restored
> > > > > > > > > +           across an NVS sleep
> > > > > > > > > +         boot-code: Contains code used for booting which=
 is not needed by the OS
> > > > > > > > > +         boot-code: Contains data used for booting which=
 is not needed by the OS
> > > > > > > > > +         runtime-code: Contains code used for interactin=
g with the system when
> > > > > > > > > +           running the OS
> > > > > > > > > +         runtime-data: Contains data used for interactin=
g with the system when
> > > > > > > > > +           running the OS
> > > > > > > > > +
> > > > > > > > > +    enum:
> > > > > > > > > +      - acpi
> > > > > > > > > +      - acpi-nvs
> > > > > > > > > +      - boot-code
> > > > > > > > > +      - boot-data
> > > > > > > > > +      - runtime-code
> > > > > > > > > +      - runtime-data
> > > > > > > > > +
> > > > > > >
> > > > > > > As I mentioned a few times already, I don't think these compa=
tibles
> > > > > > > should be introduced here.
> > > > > > >
> > > > > > > A reserved region has a specific purpose, and the compatible =
should be
> > > > > > > more descriptive than the enum above. If the consumer does no=
t
> > > > > > > understand this purpose, it should simply treat the memory as=
 reserved
> > > > > > > and not touch it. Alternatively, these regions can be referen=
ced from
> > > > > > > other DT nodes using phandles if needed.
> > > > > >
> > > > > > We still need some description of what these regions are used f=
or, so
> > > > > > that the payload can use the correct regions. I do not have any=
 other
> > > > > > solution to this problem. We are in v7 at present. At least exp=
lain
> > > > > > where you want the compatible strings to be introduced.
> > > > > >
> > > > >
> > > > > My point is really that by themselves, these regions are not usab=
le by
> > > > > either a payload or an OS that consumes this information. Unless =
there
> > > > > is some other information being provided (via DT I imagine) that
> > > > > describes how these things are supposed to be used, they are noth=
ing
> > > > > more than memory reservations that should be honored, and providi=
ng
> > > > > this arbitrary set of labels is unnecessary.
> > > > >
> > > > > > What sort of extra detail are you looking for? Please be specif=
ic and
> > > > > > preferably add some suggestions so I can close this out ASAP.
> > > > > >
> > > > >
> > > > > A payload or OS can do nothing with a memory reservation called
> > > > > 'runtime-code' it it doesn't know what is inside.
> > >
> > > Agreed. The question is WHAT runtime-code? The compatible needs to an=
swer that.
> > >
> > > For example, we have 'ramoops' as a compatible in reserved memory.
> > > That tells us *exactly* what's there. We know how to parse it. If we
> > > know ramoops is not supported, then we know we can toss it out and
> > > reclaim the memory.
> >
> > So if we said:
> >
> >    compatible =3D "runtime-code-efi"
> >
> > would that be OK? We seem to be in catch 22 here, because if I don't
> > mention EFI unhappy, but if I do, Ard is unhappy.
>
> Better yes, because then it is for something specific. However, AIUI,
> that's setup for the OS and defining that region is already defined by
> the EFI memory map. That's Ard's issue. If there's a need outside of
> the EFI to OS handoff,

There is a need. Here is part of the commit message again. If there is
something else you need to know, please ask.

>>>>
It is common to split firmware into 'Platform Init', which does the
initial hardware setup and a "Payload" which selects the OS to be booted.
Thus an handover interface is required between these two pieces.

Where UEFI boot-time services are not available, but UEFI firmware is
present on either side of this interface, information about memory usage
and attributes must be presented to the "Payload" in some form.
<<<

> then you need to define what that usecase looks
> like. Describe the problem rather than present your solution.
>
> If this is all specific to EDK2 then it should say that rather than
> 'efi'. I imagine Ard would be happier with something tied to EDK2 than
> *all* UEFI. Though maybe the problem could be any implementation? IDK.
> Maybe it's TF-A that needs to define where the EFI runtime services
> region is and that needs to be passed all the way thru to the EFI
> implementation? So again, define the problem.

It is not specific to EDK2. Imagine this boot sequence:

- Platform Init (U-Boot) starts up
- U-Boot uses its platform knowledge to sets some ACPI tables and put
various things in memory
- U-Boot sets up some runtime code and data for the OS
- U-Boot jumps to the Tianocore payload **
- Payload (Tianocore) wants to know where the ACPI tables are, for example
- Tianocore needs to provide boot services to the OS, so needs to know
the memory map, etc.

** At this point we want to use DT to pass the required information.

Of course, Platform Init could be coreboot or Tianocore or some
strange private binary. Payload could be U-Boot or something else.
That is the point of this effort, to build interoperability.

>
> > What about the boottime code....you want to know which project it is fr=
om?
>
> I think it is the same.
>
> >
> > +      - acpi
> > +      - acpi-nvs
> >
> > Those two should be enough info, right?
>
> I think so. NVS is not a term I've heard in relation to ACPI, but that
> may just be my limited ACPI knowledge.

Perhaps it is only an Intel thing. It stands for Non-Volatile-Sleeping
Memory and it has various platform settings in a binary format that is
normally SoC-specific.

>
> > +      - boot-code
> > +      - boot-data
> >
> > For these, they don't pertain to the OS, so perhaps they are OK?
>
> Hard to tell that just from the name... 'boot' could be any component
> involved in booting including the OS.

 suggested that 'boot' should mean booting the OS. If the OS does lots
of fixup stuff at the start of it, I don't know what that is called.

So if boot-code is no good, what do you suggest?

Alternatively I could remove these for now, if it will help make progress.

>
> > In
> > any case, using a generic term like this makes some sense to me. We
> > can always add a new compatible like "efi-boottime-services" later. It
> > may be that the boottime services would be handled by the payload, so
> > not needed in all cases.
>
> Why later? You have a specific use in mind and I imagine Ard has
> thoughts on that.

Because we don't need it right away, and just want to make some progress.

Perhaps the problem here is that Linux has tied itself up in knots
with its EFI stuff and DT fixups and what-not. But this is not that.
It is a simple handoff between two pieces of firmware, Platform Init
and Payload. It has nothing to do with the OS. With Tianocore they are
typically combined, but with this usage they are split, and we can
swap out one project for another on either side of the DT interface.

I do have views on the 'EFI' opt-out with reserved-memory, if you are
interested, but that relates to the OS. If you are wanting to place
some constraints on /reserved-memory and /memory we could do that
e.g. that the DT and the map returned by EFI boot services must be
consistent. But as it is, the nodes are ignored by the OS when booting
with EFI, aren't they?

Regards,
Simon

