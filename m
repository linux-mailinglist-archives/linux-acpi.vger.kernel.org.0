Return-Path: <linux-acpi+bounces-96-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A937F7ADD2E
	for <lists+linux-acpi@lfdr.de>; Mon, 25 Sep 2023 18:32:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 5B152281DE9
	for <lists+linux-acpi@lfdr.de>; Mon, 25 Sep 2023 16:32:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CD701D6A2
	for <lists+linux-acpi@lfdr.de>; Mon, 25 Sep 2023 16:32:04 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74C381C29C
	for <linux-acpi@vger.kernel.org>; Mon, 25 Sep 2023 15:04:17 +0000 (UTC)
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47CC9103
	for <linux-acpi@vger.kernel.org>; Mon, 25 Sep 2023 08:04:14 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id 2adb3069b0e04-503056c8195so11039855e87.1
        for <linux-acpi@vger.kernel.org>; Mon, 25 Sep 2023 08:04:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1695654252; x=1696259052; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7Txl9Ul5ppPZWo20VjtGmmKq+FIdSbk7aHQLdyBIM4I=;
        b=ASImDT6dRUdONxOvyc1sTIBQSMigcyXtBcmZKQZPX19fcg1uzsbp1nOauKXCkE5NQQ
         7NkUpS2NBhORTm4X1/BwRs2HewtsYsRzgCVswCYTOBZNwIWKLv8VvsWK3CDH8Gii7gbx
         VfzGU9D7fP1owulnPBTpSyZc5RmxNYT41+jUg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695654252; x=1696259052;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7Txl9Ul5ppPZWo20VjtGmmKq+FIdSbk7aHQLdyBIM4I=;
        b=LwQp5gLlvcczifkqcAaDxl7/eQq+DtszcPhvizThVdh4mWLuYkqhpdCmNl0QxgFZ6i
         YXDyRjyx0vmqw/aP2lnCAoNfyV4f1I905C8iaUgZTMZDwTqSq5bdM70U9OnfMEIkFO+0
         hh6CvjfSa679wQUKK0XGGzqH748DLxUnmUihH2G91+7uuBe16fQH1vP/8tZKR6w3RLw+
         6Y77726LSDg02vCG014JYSPDiJjoFa0I4uVlTmbq5+sxbnW9w8SERwsjsnWtBCj4I1n7
         BMtPvGUimQ/tB8gfe2V066HoyATC+ndnOqLu4WzC+fJq2QGMu1di8xxpSNaS4lgeH4aQ
         1OaQ==
X-Gm-Message-State: AOJu0YwY2tEv91X5pw2Ut7KxHj2kEH7nyWpieSUhWg6D0gcf44emuv07
	o5tDlU9hzPZDD6UgnnvKC/Zg8yobUTsqioJwFmIIWA==
X-Google-Smtp-Source: AGHT+IE5AhtMP6qEM9yWMqRJ3+7rXd9hu34InnVnapcgdPnz9dWwim+voHnX9Y2fhT6EBxN6ptIT7YU/xt9iAOQjDSg=
X-Received: by 2002:a05:6512:1044:b0:500:a0a3:80ff with SMTP id
 c4-20020a056512104400b00500a0a380ffmr5994543lfb.58.1695654252173; Mon, 25 Sep
 2023 08:04:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230907214012.74978-1-sjg@chromium.org> <CAL_Jsq+WfWrZErmz4u3_-CoVAuxL21UndcRekfJ1e61ZMMBqRw@mail.gmail.com>
 <CAPnjgZ3ALq9Hr+t4CywO113mKr83xCgFhfz+6=jav3T3R1_TGA@mail.gmail.com>
 <CAL_JsqJdTR9morobxty1egHFmTwL1-Kh3-sQ5CY7xit80fE2jw@mail.gmail.com> <CAPnjgZ37MmqinWHcWWToVsMwn+3TY=bzyXAqLFgz6kZN=tZ54g@mail.gmail.com>
In-Reply-To: <CAPnjgZ37MmqinWHcWWToVsMwn+3TY=bzyXAqLFgz6kZN=tZ54g@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 25 Sep 2023 09:04:00 -0600
Message-ID: <CAPnjgZ2tZBY-Mq3ncGEBDd9nhVP5NJbqVFzZe7=UmWtN7kELtQ@mail.gmail.com>
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
X-Spam-Status: No, score=-9.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_SPF_WL
	autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi Rob,

On Thu, 21 Sept 2023 at 10:45, Simon Glass <sjg@chromium.org> wrote:
>
> Hi Rob,
>
> On Thu, 21 Sept 2023 at 09:20, Rob Herring <robh@kernel.org> wrote:
> >
> > On Thu, Sep 21, 2023 at 9:38=E2=80=AFAM Simon Glass <sjg@chromium.org> =
wrote:
> > >
> > > Hi Rob,
> > >
> > > On Thu, 21 Sept 2023 at 08:25, Rob Herring <robh@kernel.org> wrote:
> > > >
> > > > On Thu, Sep 7, 2023 at 4:40=E2=80=AFPM Simon Glass <sjg@chromium.or=
g> wrote:
> > > > >
> > > > > It is common to split firmware into 'Platform Init', which does t=
he
> > > > > initial hardware setup and a "Payload" which selects the OS to be=
 booted.
> > > > > Thus an handover interface is required between these two pieces.
> > > > >
> > > > > This aims to provide an small schema addition for the memory mapp=
ing
> > > > > needed to keep these two pieces working together well.
> > > > >
> > > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > > > ---
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
> > > > > index 0000000..4889f59
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
> > > > > +      This describes some common memory reservations:
> > > > > +
> > > > > +         acpi-reclaim: Contains ACPI tables; memory may be recla=
imed when the
> > > > > +           tables are no-longer needed
> > > >
> > > > I think you are mixing 2 things with the name here. What the memory
> > > > contains and what to do with it. You don't need the latter. The
> > > > consumer of the region will know what to do with it if anything bas=
ed
> > > > on knowing what is in the region. For example, The DTB passed to th=
e
> > > > OS is typically in a reserved region (probably still /mem-reserve/
> > > > though). The DTB may remain there forever or the OS could copy it
> > > > somewhere else and free the reserved region. The Linux kernel does
> > > > both depending on the arch. (Of course there is no "dtb" compatible
> > > > because we have to pass the location of the dtb to even find the
> > > > reserved regions in the first place.)
> > > >
> > > > So the question here is whether just "acpi" (or "acpi-tables"?) wou=
ld
> > > > be explicit enough?
> > >
> > > Yes acpi-tables would be enough.
> > >
> > > >
> > > > > +         acpi-nvs: Contains ACPI Non-volatile-storage data; memo=
ry may be
> > > > > +           reclaimed when the tables are no-longer needed
> > > >
> > > > No need to say anything about reclaiming.
> > >
> > > OK...so what about all that discussion about being able to reclaim th=
e
> > > memory if you know what it is for? Where should that be written? Or i=
s
> > > it somewhere else already?
> >
> > Reclaiming is a policy of the consumer of the data. It belongs in the
> > documentation of the consumer if you are going to document it.
> >
> > The global policy is you can't use reserved regions and you can't
> > reclaim them if you don't know what they are. If you want to add
> > something to that effect in reserved-memory.yaml or the spec, that's
> > fine, but that's not a per compatible thing.
>
> OK I will do that.
>
> >
> > > > I know some ACPIisms (e.g. DSDT), but I don't know what NVS or
> > > > "Non-volatile-storage data" is in an ACPI context.
> > > >
> > > > > +         boot-code: Contains code used for booting; memory may b=
e reclaimed by
> > > > > +           the OS when it is running
> > > > > +         boot-code: Contains data used for booting; memory may b=
e reclaimed by
> > > >
> > > > boot-data?
> > >
> > > Yes
> > >
> > > >
> > > > > +           the OS when it is running
> > > >
> > > > I thought these were for stages before we get to OS?
> > >
> > > Yes...but of course these will be passed on to the OS in some form.
> > > See above re reclaiming.
> > >
> > > >
> > > > > +         runtime-code: Contains code used for interacting with t=
he system when
> > > > > +           running; memory may be reclaimed if this code is not =
called
> > > > > +         runtime-data: Contains data used for interacting with t=
he system when
> > > > > +           running; memory may be reclaimed if the runtime code =
is not used
> > > >
> > > > "boot" vs. "runtime" seem too vague. However, if these mean EFI boo=
t
> > > > time services and runtime services, then I understand exactly what
> > > > they are. In that case dropping 'uefi,' was a mistake. But EFI has =
its
> > > > own way to define these regions, right?
> > >
> > > I really don't want to do another round of that circle. I was asked t=
o
> > > drop mention of EFI which I did. If these are too vague, what should =
I
> > > do instead? Perhaps:
> > >
> > > boot-code / data
> > > os-code / data
> >
> > The kernel is boot code (and os code and runtime code). Can I use
>
> What do you mean by that? The kernel is an OS. It might have an EFI
> stub or other stuff, but it is not a boot loader. We have to have some
> generally accepted terms for what is the OS and what is the firmware.
>
> > these for the kernel image? Certainly not. But they are too vague to
> > understand when to use them and when not to. Are they specific to EDK2
> > implementation? Then perhaps they need an 'edk2' prefix.
> >
> > Either these are related to EFI boot time services and runtime
> > services or they aren't. Which is it? If they are related, then EFI
> > should certainly be mentioned. Review comments are wrong all the time
> > when the reasoning is missing or misunderstood. Please back up and
> > explain why these are needed. Maybe it's buried in prior threads
> > somewhere, but I'm not going back to re-read all that. This patch has
> > to stand on its own.
>
> For my email client it is buried in this thread, see the ~20 messages
> above, or [1]. I took all the EFI stuff out of here because it was
> going nowhere.
>
> The text I removed in this version is:
>
> >>>
> It is common to split firmware into 'Platform Init', which does the
> initial hardware setup and a "Payload" which selects the OS to be booted.
> Thus an handover interface is required between these two pieces.
>
> Where UEFI boot-time services are not available, but UEFI firmware is
> present on either side of this interface, information about memory usage
> and attributes must be presented to the "Payload" in some form.
> <<<
>
> Then I tried to explain it in terms of Tianocore being split into two
> parts, one of which does Platform Init (e.g. silicon setup) and the
> other which boots the OS. But that got lost is discussion about DXEs,
> etc. There is no other communication mechanism between these two
> pieces, nor does either piece know (at runtime or build time) whether
> the other is there, or whether it is something else (e.g. coreboot or
> U-Boot). This allows supporting Platform Init / Payload combinations
> like coreboot->Tianocore, Tianocore->Tianocore. coreboot->U-Boot,
> etc., i.e. universal compatibility.
>
> IMhO this binding doesn't need to be about EFI. The concept of code
> which is used during boot and code which is used by the OS doesn't
> seem specific to EFI. After all, ARM has PSCI code which presumably
> lives somewhere.
>
> So do you really want it to mention EFI?
>
> I have volunteered to take this on on behalf of the EDK2 people, who
> are copied on this thread and hoping / relying on something being
> resolved.

Do you have any thoughts on the above? I'd really like to understand
what needs to be done here. We have a meeting tomorrow on the handoff
format and I don't have a lot to show for my efforts of the last 5
weeks.

Regards,
SImon

> [1] https://lore.kernel.org/lkml/CAMj1kXHGpCt8qkd6XYQF8mMdivQkTnEWjv6NzsF=
K=3D+N72LAn=3DQ@mail.gmail.com/

