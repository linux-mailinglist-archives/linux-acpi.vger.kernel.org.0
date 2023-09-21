Return-Path: <linux-acpi+bounces-22-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34F597A9C31
	for <lists+linux-acpi@lfdr.de>; Thu, 21 Sep 2023 21:12:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E453928282F
	for <lists+linux-acpi@lfdr.de>; Thu, 21 Sep 2023 19:12:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AD1894472
	for <lists+linux-acpi@lfdr.de>; Thu, 21 Sep 2023 18:42:30 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B821617745
	for <linux-acpi@vger.kernel.org>; Thu, 21 Sep 2023 17:31:58 +0000 (UTC)
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EE1A6595
	for <linux-acpi@vger.kernel.org>; Thu, 21 Sep 2023 10:31:00 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id 38308e7fff4ca-2c108e106f0so21223371fa.1
        for <linux-acpi@vger.kernel.org>; Thu, 21 Sep 2023 10:31:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1695317452; x=1695922252; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E19Ekl5PJswibGBQfhab8yclZrAA2HIOFTLdNx9MRjc=;
        b=eSiQgXNe8r1r8rOX6hUjdBXBGWqZVu00tLTQGfu1UDSoTrVlKXj6gJ4UaEuKf69YHC
         u+3WCeq6wbbcyUbuE9p0XLz8tlLmGUlMBsVUmxVDH6jRQAUgnZ57ZiLcw7/oE1Eh8mQQ
         yehyLoehgXwNNdgAlWroqnXA0gx2XybFy2uqI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695317452; x=1695922252;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E19Ekl5PJswibGBQfhab8yclZrAA2HIOFTLdNx9MRjc=;
        b=J5oaF2T+VesP8hMjUffkAlCKajRlFa8vFSrBTN1a5z5wMHvKY30KwoGeY48AKRefG/
         UWnqz38LNJ53nvctOdZoEH35WMZlq0ASPFzjimNe83pGQT76O4iNkaBPo3tPt76PnSHA
         xUw1udHn0h3dJ0O3kDapx+mIeuNvOeddAu/AwFQu/dYzsZG6obPZ8MyYpCVZah4VA6SZ
         7ppvXzEDYWzXIZRMYJ7u1ZttM8Sb+/ymhbBuhfcp2qdLk6o5IvuzHphbLaSen4ceWjAa
         c0mnPQQHkta0mzbGf63CLi2j43pmamAROtjxgt7hzF6DVQzPByTC5YNZd3KfyAUUs88G
         5Bcg==
X-Gm-Message-State: AOJu0Yy/6zMEyhP5ZMZf4o4HsB6FxRvmP5qbrNxpW2jdV3qkXyRtDU/z
	A6Cn9F02eP/ixBiS4cTdCGfclMA+KoelcdE3+qY47PP5sjXAQglCU64=
X-Google-Smtp-Source: AGHT+IHwUSKIHM6d3plJsNARSg6EFircCLQgrlATm9TW4MR3SVA1+Jq7dOWRr7DtrCzzOpccxefsLrqZDnFGCznf4SY=
X-Received: by 2002:a17:906:5a68:b0:9aa:e13:426a with SMTP id
 my40-20020a1709065a6800b009aa0e13426amr4250751ejc.73.1695307101683; Thu, 21
 Sep 2023 07:38:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230907214012.74978-1-sjg@chromium.org> <CAL_Jsq+WfWrZErmz4u3_-CoVAuxL21UndcRekfJ1e61ZMMBqRw@mail.gmail.com>
In-Reply-To: <CAL_Jsq+WfWrZErmz4u3_-CoVAuxL21UndcRekfJ1e61ZMMBqRw@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 21 Sep 2023 08:38:09 -0600
Message-ID: <CAPnjgZ3ALq9Hr+t4CywO113mKr83xCgFhfz+6=jav3T3R1_TGA@mail.gmail.com>
Subject: Re: [PATCH v6 1/2] schemas: Add some common reserved-memory usages
To: Rob Herring <robh@kernel.org>
Cc: devicetree@vger.kernel.org, Dhaval Sharma <dhaval@rivosinc.com>, 
	Guo Dong <guo.dong@intel.com>, U-Boot Mailing List <u-boot@lists.denx.de>, 
	Yunhui Cui <cuiyunhui@bytedance.com>, Chiu Chasel <chasel.chiu@intel.com>, 
	Mark Rutland <mark.rutland@arm.com>, linux-acpi@vger.kernel.org, 
	Maximilian Brune <maximilian.brune@9elements.com>, Ard Biesheuvel <ardb@kernel.org>, 
	Tom Rini <trini@konsulko.com>, Lean Sheng Tan <sheng.tan@9elements.com>, 
	Gua Guo <gua.guo@intel.com>, ron minnich <rminnich@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-9.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_SPF_WL autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi Rob,

On Thu, 21 Sept 2023 at 08:25, Rob Herring <robh@kernel.org> wrote:
>
> On Thu, Sep 7, 2023 at 4:40=E2=80=AFPM Simon Glass <sjg@chromium.org> wro=
te:
> >
> > It is common to split firmware into 'Platform Init', which does the
> > initial hardware setup and a "Payload" which selects the OS to be boote=
d.
> > Thus an handover interface is required between these two pieces.
> >
> > This aims to provide an small schema addition for the memory mapping
> > needed to keep these two pieces working together well.
> >
> > Signed-off-by: Simon Glass <sjg@chromium.org>
> > ---
> >
> > Changes in v6:
> > - Drop mention of UEFI
> > - Use compatible strings instead of node names
> >
> > Changes in v5:
> > - Drop the memory-map node (should have done that in v4)
> > - Tidy up schema a bit
> >
> > Changes in v4:
> > - Make use of the reserved-memory node instead of creating a new one
> >
> > Changes in v3:
> > - Reword commit message again
> > - cc a lot more people, from the FFI patch
> > - Split out the attributes into the /memory nodes
> >
> > Changes in v2:
> > - Reword commit message
> >
> >  .../reserved-memory/common-reserved.yaml      | 71 +++++++++++++++++++
> >  1 file changed, 71 insertions(+)
> >  create mode 100644 dtschema/schemas/reserved-memory/common-reserved.ya=
ml
> >
> > diff --git a/dtschema/schemas/reserved-memory/common-reserved.yaml b/dt=
schema/schemas/reserved-memory/common-reserved.yaml
> > new file mode 100644
> > index 0000000..4889f59
> > --- /dev/null
> > +++ b/dtschema/schemas/reserved-memory/common-reserved.yaml
> > @@ -0,0 +1,71 @@
> > +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/reserved-memory/common-reserved.yam=
l#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Common memory reservations
> > +
> > +description: |
> > +  Specifies that the reserved memory region can be used for the purpos=
e
> > +  indicated by its compatible string.
> > +
> > +  Clients may reuse this reserved memory if they understand what it is=
 for,
> > +  subject to the notes below.
> > +
> > +maintainers:
> > +  - Simon Glass <sjg@chromium.org>
> > +
> > +allOf:
> > +  - $ref: reserved-memory.yaml
> > +
> > +properties:
> > +  compatible:
> > +    description: |
> > +      This describes some common memory reservations:
> > +
> > +         acpi-reclaim: Contains ACPI tables; memory may be reclaimed w=
hen the
> > +           tables are no-longer needed
>
> I think you are mixing 2 things with the name here. What the memory
> contains and what to do with it. You don't need the latter. The
> consumer of the region will know what to do with it if anything based
> on knowing what is in the region. For example, The DTB passed to the
> OS is typically in a reserved region (probably still /mem-reserve/
> though). The DTB may remain there forever or the OS could copy it
> somewhere else and free the reserved region. The Linux kernel does
> both depending on the arch. (Of course there is no "dtb" compatible
> because we have to pass the location of the dtb to even find the
> reserved regions in the first place.)
>
> So the question here is whether just "acpi" (or "acpi-tables"?) would
> be explicit enough?

Yes acpi-tables would be enough.

>
> > +         acpi-nvs: Contains ACPI Non-volatile-storage data; memory may=
 be
> > +           reclaimed when the tables are no-longer needed
>
> No need to say anything about reclaiming.

OK...so what about all that discussion about being able to reclaim the
memory if you know what it is for? Where should that be written? Or is
it somewhere else already?

>
> I know some ACPIisms (e.g. DSDT), but I don't know what NVS or
> "Non-volatile-storage data" is in an ACPI context.
>
> > +         boot-code: Contains code used for booting; memory may be recl=
aimed by
> > +           the OS when it is running
> > +         boot-code: Contains data used for booting; memory may be recl=
aimed by
>
> boot-data?

Yes

>
> > +           the OS when it is running
>
> I thought these were for stages before we get to OS?

Yes...but of course these will be passed on to the OS in some form.
See above re reclaiming.

>
> > +         runtime-code: Contains code used for interacting with the sys=
tem when
> > +           running; memory may be reclaimed if this code is not called
> > +         runtime-data: Contains data used for interacting with the sys=
tem when
> > +           running; memory may be reclaimed if the runtime code is not=
 used
>
> "boot" vs. "runtime" seem too vague. However, if these mean EFI boot
> time services and runtime services, then I understand exactly what
> they are. In that case dropping 'uefi,' was a mistake. But EFI has its
> own way to define these regions, right?

I really don't want to do another round of that circle. I was asked to
drop mention of EFI which I did. If these are too vague, what should I
do instead? Perhaps:

boot-code / data
os-code / data

?

Regards,
Simon

