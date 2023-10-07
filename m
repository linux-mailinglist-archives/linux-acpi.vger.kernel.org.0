Return-Path: <linux-acpi+bounces-497-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6657F7BC354
	for <lists+linux-acpi@lfdr.de>; Sat,  7 Oct 2023 02:35:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B0672820DB
	for <lists+linux-acpi@lfdr.de>; Sat,  7 Oct 2023 00:35:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 548B67E2
	for <lists+linux-acpi@lfdr.de>; Sat,  7 Oct 2023 00:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="eJe3ITYg"
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36BF57E2
	for <linux-acpi@vger.kernel.org>; Sat,  7 Oct 2023 00:03:36 +0000 (UTC)
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D6D4BE
	for <linux-acpi@vger.kernel.org>; Fri,  6 Oct 2023 17:03:34 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-99bdcade7fbso472694666b.1
        for <linux-acpi@vger.kernel.org>; Fri, 06 Oct 2023 17:03:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1696637013; x=1697241813; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uDcsQIEmgkQ2z2v3WWS4XEV0ph0sL9LSX0+s7n0YMh4=;
        b=eJe3ITYgPjBMr33L5teqqIJcAO8Ed40m3dwLFMI4y5OmUz27KJ/8G2iMRtPwk9c+8g
         2J3WXnSnPeF6hqFZvbNzvoLjPDW6iMeq9p7CYJK73zEBx+tN/XWytDhc8bJv12lGXb5E
         qMWlNNmgexr3Lj3Zy8LSUSbCHjg9r+8JmfUHg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696637013; x=1697241813;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uDcsQIEmgkQ2z2v3WWS4XEV0ph0sL9LSX0+s7n0YMh4=;
        b=mwzLjrf9+w50q650dg9Qv8hNCOgCm/ZX8kollnWiCoQXbJfo0849HSZ2ILJA1bxStE
         hVa0tZMvjocTp+apCI84XcHBZrXD6ALmzVjJsOqmckdeDDQfzPZXOm9l4n3mGiLrKbQw
         w++PMblTcf6at54A+Xxo3h7v8PLVLEyAWlj7ScNLNJU2Qm8RMTRPWedXgmQc4CIjtzbe
         wDWoZsBeRYGd29ykZXcRrOZckgN5Z1E+14GrRI/hV5o1VP2EnyfWhoVT0nKYGbS3NUMW
         MSf0tiEdFBj2PYzVjcHFkRKaMgvvvoXx4NQnbGpwfAZ/7tZpj6Cx+a9edamfXaRxCRBh
         7gyw==
X-Gm-Message-State: AOJu0YykOhyYJF33vOMbP9IfLVpd8YhsWMXXg1BtYRlzVyGxNJg7mi0z
	N5ESiI6x+LlCWDBrSbk7oB1VE1q1VQqtOQ9thKZxgg==
X-Google-Smtp-Source: AGHT+IHICfBlh5Jn9KCKxlRJo8KnQizgtIiA61TtzHAjgOF4pLzWyegSnBlNZCq/yTtUnR27UDOzc7A1CepkEFmMBc8=
X-Received: by 2002:a17:906:3284:b0:9b8:e670:657b with SMTP id
 4-20020a170906328400b009b8e670657bmr8851025ejw.64.1696637012708; Fri, 06 Oct
 2023 17:03:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230926194242.2732127-1-sjg@chromium.org> <20230926194242.2732127-2-sjg@chromium.org>
 <CAPnjgZ0Xf3U1aj32LbU-xiU1AqwnM3JL1F8xX-wZ18oEmg+irw@mail.gmail.com>
 <CAMj1kXEXcX7BkDyfy-6_5Vnch=N+onza-yfWfsVaGLE93h2c+Q@mail.gmail.com>
 <CAPnjgZ2SEby-ndrs=W_afBJH56eqc=-mhp1F1nwkvWks+=B54Q@mail.gmail.com> <CAMj1kXED3S+0cq+VT7naBrmWrUwT=HZAaZOBRMv8Ui1Pey1QNQ@mail.gmail.com>
In-Reply-To: <CAMj1kXED3S+0cq+VT7naBrmWrUwT=HZAaZOBRMv8Ui1Pey1QNQ@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 6 Oct 2023 18:03:16 -0600
Message-ID: <CAPnjgZ0LrsJ2_ENTYoBrnyFaH3UKdHs3D2XWY=TzBuBpBoTXZA@mail.gmail.com>
Subject: Re: [PATCH v7 2/2] schemas: Add some common reserved-memory usages
To: Ard Biesheuvel <ardb@kernel.org>
Cc: devicetree@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>, 
	Rob Herring <robh@kernel.org>, Lean Sheng Tan <sheng.tan@9elements.com>, 
	lkml <linux-kernel@vger.kernel.org>, Dhaval Sharma <dhaval@rivosinc.com>, 
	Maximilian Brune <maximilian.brune@9elements.com>, Yunhui Cui <cuiyunhui@bytedance.com>, 
	Guo Dong <guo.dong@intel.com>, Tom Rini <trini@konsulko.com>, 
	ron minnich <rminnich@gmail.com>, Gua Guo <gua.guo@intel.com>, 
	Chiu Chasel <chasel.chiu@intel.com>, linux-acpi@vger.kernel.org, 
	U-Boot Mailing List <u-boot@lists.denx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-9.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_SPF_WL
	autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi Ard,

On Fri, 6 Oct 2023 at 17:00, Ard Biesheuvel <ardb@kernel.org> wrote:
>
> On Fri, 6 Oct 2023 at 20:17, Simon Glass <sjg@chromium.org> wrote:
> >
> > Hi Ard,
> >
> > On Fri, 6 Oct 2023 at 11:33, Ard Biesheuvel <ardb@kernel.org> wrote:
> > >
> > > On Mon, 2 Oct 2023 at 19:54, Simon Glass <sjg@chromium.org> wrote:
> > > >
> > > > Hi Rob,
> > > >
> > > > On Tue, 26 Sept 2023 at 13:42, Simon Glass <sjg@chromium.org> wrote=
:
> > > > >
> > > > > It is common to split firmware into 'Platform Init', which does t=
he
> > > > > initial hardware setup and a "Payload" which selects the OS to be=
 booted.
> > > > > Thus an handover interface is required between these two pieces.
> > > > >
> > > > > Where UEFI boot-time services are not available, but UEFI firmwar=
e is
> > > > > present on either side of this interface, information about memor=
y usage
> > > > > and attributes must be presented to the "Payload" in some form.
> > > > >
> > > > > This aims to provide an small schema addition for the memory mapp=
ing
> > > > > needed to keep these two pieces working together well.
> > > > >
> > > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > > > ---
> > > > >
> > > > > Changes in v7:
> > > > > - Rename acpi-reclaim to acpi
> > > > > - Drop individual mention of when memory can be reclaimed
> > > > > - Rewrite the item descriptions
> > > > > - Add back the UEFI text (with trepidation)
> > > >
> > > > I am again checking on this series. Can it be applied, please?
> > > >
> > >
> > > Apologies for the delay in response. I have been away.
> >
> > OK, I hope you had a nice trip.
> >
>
> Thanks, it was wonderful!
>
> > >
> > > >
> > > > >
> > > > > Changes in v6:
> > > > > - Drop mention of UEFI
> > > > > - Use compatible strings instead of node names
> > > > >
> > > > > Changes in v5:
> > > > > - Drop the memory-map node (should have done that in v4)
> > > > > - Tidy up schema a bit
> > > > >
> > > > > Changes in v4:
> > > > > - Make use of the reserved-memory node instead of creating a new =
one
> > > > >
> > > > > Changes in v3:
> > > > > - Reword commit message again
> > > > > - cc a lot more people, from the FFI patch
> > > > > - Split out the attributes into the /memory nodes
> > > > >
> > > > > Changes in v2:
> > > > > - Reword commit message
> > > > >
> > > > >  .../reserved-memory/common-reserved.yaml      | 71 +++++++++++++=
++++++
> > > > >  1 file changed, 71 insertions(+)
> > > > >  create mode 100644 dtschema/schemas/reserved-memory/common-reser=
ved.yaml
> > > > >
> > > > > diff --git a/dtschema/schemas/reserved-memory/common-reserved.yam=
l b/dtschema/schemas/reserved-memory/common-reserved.yaml
> > > > > new file mode 100644
> > > > > index 0000000..f7fbdfd
> > > > > --- /dev/null
> > > > > +++ b/dtschema/schemas/reserved-memory/common-reserved.yaml
> > > > > @@ -0,0 +1,71 @@
> > > > > +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> > > > > +%YAML 1.2
> > > > > +---
> > > > > +$id: http://devicetree.org/schemas/reserved-memory/common-reserv=
ed.yaml#
> > > > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > > > +
> > > > > +title: Common memory reservations
> > > > > +
> > > > > +description: |
> > > > > +  Specifies that the reserved memory region can be used for the =
purpose
> > > > > +  indicated by its compatible string.
> > > > > +
> > > > > +  Clients may reuse this reserved memory if they understand what=
 it is for,
> > > > > +  subject to the notes below.
> > > > > +
> > > > > +maintainers:
> > > > > +  - Simon Glass <sjg@chromium.org>
> > > > > +
> > > > > +allOf:
> > > > > +  - $ref: reserved-memory.yaml
> > > > > +
> > > > > +properties:
> > > > > +  compatible:
> > > > > +    description: |
> > > > > +      This describes some common memory reservations, with the c=
ompatible
> > > > > +      string indicating what it is used for:
> > > > > +
> > > > > +         acpi: Advanced Configuration and Power Interface (ACPI)=
 tables
> > > > > +         acpi-nvs: ACPI Non-Volatile-Sleeping Memory (NVS). This=
 is reserved by
> > > > > +           the firmware for its use and is required to be saved =
and restored
> > > > > +           across an NVS sleep
> > > > > +         boot-code: Contains code used for booting which is not =
needed by the OS
> > > > > +         boot-code: Contains data used for booting which is not =
needed by the OS
> > > > > +         runtime-code: Contains code used for interacting with t=
he system when
> > > > > +           running the OS
> > > > > +         runtime-data: Contains data used for interacting with t=
he system when
> > > > > +           running the OS
> > > > > +
> > > > > +    enum:
> > > > > +      - acpi
> > > > > +      - acpi-nvs
> > > > > +      - boot-code
> > > > > +      - boot-data
> > > > > +      - runtime-code
> > > > > +      - runtime-data
> > > > > +
> > >
> > > As I mentioned a few times already, I don't think these compatibles
> > > should be introduced here.
> > >
> > > A reserved region has a specific purpose, and the compatible should b=
e
> > > more descriptive than the enum above. If the consumer does not
> > > understand this purpose, it should simply treat the memory as reserve=
d
> > > and not touch it. Alternatively, these regions can be referenced from
> > > other DT nodes using phandles if needed.
> >
> > We still need some description of what these regions are used for, so
> > that the payload can use the correct regions. I do not have any other
> > solution to this problem. We are in v7 at present. At least explain
> > where you want the compatible strings to be introduced.
> >
>
> My point is really that by themselves, these regions are not usable by
> either a payload or an OS that consumes this information. Unless there
> is some other information being provided (via DT I imagine) that
> describes how these things are supposed to be used, they are nothing
> more than memory reservations that should be honored, and providing
> this arbitrary set of labels is unnecessary.
>
> > What sort of extra detail are you looking for? Please be specific and
> > preferably add some suggestions so I can close this out ASAP.
> >
>
> A payload or OS can do nothing with a memory reservation called
> 'runtime-code' it it doesn't know what is inside. So there is another
> DT node somewhere that describes this, and that can simply point to
> this region (via a phandle) if it needs to describe the
> correspondence. This is more idiomatic for DT afaik (but I am not the
> expert).  But more importantly, it avoids overloading some vague
> labels with behavior (e.g., executable permissions for code regions)
> that should only be displayed for regions with a particular use,
> rather than for a ill defined class of reservations the purpose of
> which is not clear.
>
> What I am trying to avoid is the OS ending up being forced to consume
> this information in parallel to the EFI memory map, and having to
> reconcile them. I'd be much happier if this gets contributed to a spec
> that only covers firmware-to-firmware, and is prevented from leaking
> into the OS facing interface.

I don't know about "another DT node". We don't have one at present.

There is already a note in the DT spec about this:

> 3.5.4 /reserved-memory and UEFI

> When booting via [UEFI], static /reserved-memory regions must also be lis=
ted in the system memory map obtained
> via the GetMemoryMap() UEFI boot time service as defined in [UEFI] =C2=A7=
 7.2. The reserved memory regions need to be
> included in the UEFI memory map to protect against allocations by UEFI ap=
plications.
>
> Reserved regions with the no-map property must be listed in the memory ma=
p with type EfiReservedMemoryType. All
> other reserved regions must be listed with type EfiBootServicesData.
>
> Dynamic reserved memory regions must not be listed in the [UEFI] memory m=
ap because they are allocated by the OS
> after exiting firmware boot services.

I don't fully understand what all that means, but does it cover your concer=
n?

Regards,
Simon

