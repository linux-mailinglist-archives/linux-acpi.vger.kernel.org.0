Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC1B278F5A8
	for <lists+linux-acpi@lfdr.de>; Fri,  1 Sep 2023 00:39:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239755AbjHaWjo (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 31 Aug 2023 18:39:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231126AbjHaWjn (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 31 Aug 2023 18:39:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AADE1E65;
        Thu, 31 Aug 2023 15:39:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3DF5D62D60;
        Thu, 31 Aug 2023 22:39:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94282C433C9;
        Thu, 31 Aug 2023 22:39:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693521578;
        bh=XS9zHm6oRc/GNSPLGz2EWLB/fuo8sK90xzPyYhnLWRc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=oiD7dE4BCHnH+XgrFUiWf2hni2zo3T4+UpBW+v6SFgEkE0YASa1FR/M4gfS+G7Ky7
         YIsZUZ7fFyp18vRWqrbHcDa3s/kHXeIq8UDZ07oRRVLhlyFJ60JJ1WSbckKHczcqqr
         jmmYS6ah1BRMD8z8vt6XjThCanjl9HvbhbaL3ttwXGkFRCSkO4Zeprx82bsjvFimWK
         Gk5RR6QbPXF7ZMutiiO5UoIBmq4nrLB7RdxIQ4Qm1brhkRpvWP2rr2u4T9cee5C3zo
         GiLNdNtLl1xxHRzSo3tmcyZ099nJS92g30T4WCdpOjH/SCVuY8KuGDAkDtoDlZFlXp
         CHZPJhsFhGzGA==
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-1c4c6717e61so879389fac.1;
        Thu, 31 Aug 2023 15:39:38 -0700 (PDT)
X-Gm-Message-State: AOJu0Yx+aZ4iGGulk4xbv/CbEBJflKrcV0jIu2XyiZ+gDlAxTXsy5TBk
        dOra1K485qdjyk8KDXSp9FXJ4Sg09jho0F8IBms=
X-Google-Smtp-Source: AGHT+IHru+RZnFygVAf63KfLveCZCm0apIQ9eFkLuQr9Qe0woMbAQa/b02zgBa1mMXfnWLNTu4JW2xIPtjNWU7fQEsg=
X-Received: by 2002:a05:6870:64ab:b0:1c1:12dc:70b1 with SMTP id
 cz43-20020a05687064ab00b001c112dc70b1mr1054605oab.57.1693521577676; Thu, 31
 Aug 2023 15:39:37 -0700 (PDT)
MIME-Version: 1.0
References: <20230822203446.4111742-1-sjg@chromium.org> <ZOXKTrC_dzN_hUkY@FVFF77S0Q05N>
 <CAMj1kXEHpRjk_YKOm4czCnnpjqgahj2jV8MMfGLx7b1RdnBnVw@mail.gmail.com>
 <CAPnjgZ1S8G=7eCBF9PcDk4H5sk3AcxSSWXO575jK8SjA9dR8qw@mail.gmail.com>
 <CAMj1kXH83_TB4S0PL3jswxjCP+907YpgS7FRuVTO3G62s7nn5w@mail.gmail.com>
 <CAPnjgZ2kkUt1eOWX8K+EsbjcQZPefNvj5DSaFb9QrvRg0t2h7w@mail.gmail.com>
 <CAMj1kXGe84uaJ9j9ic0V4HC43p7QBoKQ5ssTYd5DMBGtZ3++Jw@mail.gmail.com>
 <CAPnjgZ3L-jGxoXNHnsXY0MXU=jTAN66KNAxSLHPVeHinHMjzkQ@mail.gmail.com>
 <CAMj1kXGw6DGK=gVF3bMH5dp=LL89V9n1V1LMGKDn0CZWGHh8qg@mail.gmail.com>
 <CAPnjgZ1fjee3rf91onPbuLpgqTHe3dZgz0WBSzoiKAabO+ETkQ@mail.gmail.com>
 <CAMj1kXFvLGeXXmyK1wSXLk5yq42f2G3GvBGoN40JF=y4bvCo=Q@mail.gmail.com> <CAPnjgZ25VqPCBSZ69fyb+G93=hzS-gX6zVa0J3vYyY49p0CZmw@mail.gmail.com>
In-Reply-To: <CAPnjgZ25VqPCBSZ69fyb+G93=hzS-gX6zVa0J3vYyY49p0CZmw@mail.gmail.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Fri, 1 Sep 2023 00:39:24 +0200
X-Gmail-Original-Message-ID: <CAMj1kXGzPHFpjr4-Q5Vwe3TSZWdAumWVL7iYJR76VGQbZUSsEA@mail.gmail.com>
Message-ID: <CAMj1kXGzPHFpjr4-Q5Vwe3TSZWdAumWVL7iYJR76VGQbZUSsEA@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] schemas: Add a schema for memory map
To:     Simon Glass <sjg@chromium.org>
Cc:     Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
        Rob Herring <robh@kernel.org>,
        Chiu Chasel <chasel.chiu@intel.com>,
        U-Boot Mailing List <u-boot@lists.denx.de>,
        Gua Guo <gua.guo@intel.com>, linux-acpi@vger.kernel.org,
        lkml <linux-kernel@vger.kernel.org>,
        Yunhui Cui <cuiyunhui@bytedance.com>,
        ron minnich <rminnich@gmail.com>,
        Tom Rini <trini@konsulko.com>,
        Lean Sheng Tan <sheng.tan@9elements.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, 1 Sept 2023 at 00:17, Simon Glass <sjg@chromium.org> wrote:
>
> Hi Ard,
>
> On Thu, 31 Aug 2023 at 15:48, Ard Biesheuvel <ardb@kernel.org> wrote:
> >
> > On Thu, 31 Aug 2023 at 21:03, Simon Glass <sjg@chromium.org> wrote:
> > >
> > > Hi Ard,
> > >
> > > On Thu, 31 Aug 2023 at 06:28, Ard Biesheuvel <ardb@kernel.org> wrote:
> > > >
> > > > On Wed, 30 Aug 2023 at 23:11, Simon Glass <sjg@chromium.org> wrote:
> > > > >
> > > > > Hi Ard,
> > > > >
> > > > > On Tue, 29 Aug 2023 at 15:32, Ard Biesheuvel <ardb@kernel.org> wrote:
> > > > > >
> > > > > > On Tue, 29 Aug 2023 at 21:18, Simon Glass <sjg@chromium.org> wrote:
> > > > > > >
> > > > > > > Hi Ard,
> > > > > > >
> > > > > > > On Thu, 24 Aug 2023 at 03:10, Ard Biesheuvel <ardb@kernel.org> wrote:
> > > > ...
> > > > > > > > In summary, I don't see why a non-UEFI payload would care about UEFI
> > > > > > > > semantics for pre-existing memory reservations, or vice versa. Note
> > > > > > > > that EDK2 will manage its own memory map, and expose it via UEFI boot
> > > > > > > > services and not via DT.
> > > > > > >
> > > > > > > Bear in mind that one or both sides of this interface may be UEFI.
> > > > > > > There is no boot-services link between the two parts that I have
> > > > > > > outlined.
> > > > > > >
> > > > > >
> > > > > > I don't understand what this means.
> > > > > >
> > > > > > UEFI specifies how one component invokes another, and it is not based
> > > > > > on a DT binding. If the second component calls UEFI boot or runtime
> > > > > > services, it should be invoked in this manner. If it doesn't, then it
> > > > > > doesn't care about these memory reservations (and the OS will not be
> > > > > > booted via UEFI either)
> > > > > >
> > > > > > So I feel I am missing something here. Perhaps a practical example
> > > > > > would be helpful?
> > > > >
> > > > > Let's say we want to support these combinations:
> > > > >
> > > > > Platform Init -> Payload
> > > > > --------------------------------
> > > > > U-Boot -> Tianocore
> > > > > coreboot -> U-Boot
> > > > > Tianocore -> U-Boot
> > > > > Tianocore -> Tianocore
> > > > > U-Boot -> U-Boot
> > > > >
> > > > > Some of the above things have UEFI interfaces, some don't. But in the
> > > > > case of Tianocore -> Tianocore we want things to work as if it were
> > > > > Tianocore -> (its own handoff mechanism) Tiancore.
> > > > >
> > > >
> > > > If Tianocore is the payload, it is either implemented as a EFI app, in
> > > > which case it has access to EFI services, or it is not, in which case
> > > > it doesn't care about UEFI semantics of the existing reserved regions,
> > > > and it only needs to know which regions exist and which of those are
> > > > reserved.
> > > >
> > > > And I think the same applies to all other rows in your table: either
> > > > the existence of UEFI needs to be carried forward, which needs to be
> > > > done via EFI services, or it doesn't, in which case the UEFI specific
> > > > reservations can be dropped, and only reserved and available memory is
> > > > relevant.
> > > >
> > > > > Some Platform Init may create runtime code which needs to accessible later.
> > > > >
> > > >
> > > > But not UEFI runtime code, right? If the payload is not UEFI based,
> > > > the OS would never be able to call that runtime code unless it is
> > > > described in a different, non-UEFI way. This is fine, but it is not
> > > > UEFI so we shouldn't call it UEFI runtime memory.
> > > >
> > > > > The way I think of it is that we need to generalise the memory map a
> > > > > bit. Saying that you must use UEFI boot services to discover it is too
> > > > > UEFI-specific.
> > > > >
> > > >
> > > > What I am questioning is why a memory map with UEFI semantics is even
> > > > relevant when those boot services do not exist.
> > > >
> > > > Could you be more specific about why a payload would have to be aware
> > > > of the existence of UEFI boot/runtime service regions if it does not
> > > > consume the UEFI interfaces of the platform init? And if the payload
> > > > exposes UEFI services to the OS, why would it consume a memory map
> > > > with UEFI semantics rather than a simple list of memblocks and memory
> > > > reservations?
> > >
> > > It seems like you are thinking of the Payload as grub, or something
> > > like that? This is not about grub. If there are EFI boot services to
> > > be provided, they are provided by the Payload, not Platform Init. I am
> > > not that familiar with Tianocore, but if you are, perhaps think of it
> > > as splitting Tianocore into two pieces, one of which inits the silicon
> > > and the other which provides the EFI boot services.
> > >
> > > Again, if you are familiar with Tianocore, it can be built either as a
> > > monolithic whole, or as a coreboot Payload. The Payload part of the
> > > code is (roughly) the same in each case. But the Platform Init is
> > > different[1]
> > >
> >
> > I co-maintain OVMF [including the ARM port that I created from
> > scratch] as well as the ARM architecture support in Tianocore, along
> > with a couple of platform ports for ARM boards, some of which could by
> > now be characterized as 'historical' (AMD Seattle, Socionext SynQuacer
> > and Raspberry Pi 3/4). So I think I have a pretty good handle on how
> > Tianocore based firmware is put together.
> >
> > Tianocore as a payload will expose boot services to the OS, and will
> > provide the OS with a memory map using the UEFI APIs. But you still
> > haven't explained why the memory description this Tianocore inherits
> > from the Platform Init would include any UEFI boot or runtime service
> > regions, or any of the other memory regions with UEFI semantics.
> > TIanocore just needs to know a) where memory lives b) which parts of
> > it are already in use (as far as the memory map is concerned), and the
> > existing bindings suffice for this purpose.
> >
> > In short, the memory regions with UEFI semantics are created by the
> > boot phase that actually exposes UEFI to the OS, in which case the
> > boot services can be used to obtain the memory map. If the consumer is
> > not UEFI based, there is no reason to bother it with descriptions of
> > memory regions that have no significance to it.
>
> But aren't you assuming that the Payload knows how to handle the
> hardware and can implement the runtime services? What if (for example)
> powering off the device is hardware-specific and only Platform Init
> knows how?
>

If the payload relies on the platform init for anything, it can use
whichever interface those components manage to agree on.

If this interface is UEFI, the payload can use UEFI to obtain the memory map.

If this interface is not UEFI, the UEFI memory map is irrelevant, and
existing DT bindings are available that can describe this information.

> On another track, would it help if we just dropped all mention of
> UEFI? The binding does not mention it.
>

Your binding has

+      usage:
+        $ref: /schemas/types.yaml#/definitions/string
+        description: |
+          Describes the usage of the memory region, e.g.:
+
+            "acpi-reclaim", "acpi-nvs", "bootcode", "bootdata", "bootdata",
+            "runtime-code", "runtime-data".
+
+            See enum EFI_MEMORY_TYPE in "Unified Extensible Firmware Interface
+            (UEFI) Specification" for all the types. For now there are not
+            listed here.

Every type listed is derived from a definition in the UEFI spec, which
is specifically mentioned as the source.

> On a third track, what if Platform Init wants to set aside some memory
> for runtime code, e.g. in SRAM?
>

SRAM is not the best example here, as it is typically not described by
DT using device_type=memory, and never treated as ordinary system RAM
that needs to be reserved in order to prevent the OS or other boot
stages from stepping on it. In UEFI, such a region would not appear in
the UEFI memory map at all unless the OS needed to add it to the
runtime memory map (i.e., when UEFI runtime service implementations
themselves need to access such a region, similar to how the RTC or NOR
flash may be described as MemoryMappedIo regions so that GetTime() or
GetVariable() can access the underlying peripherals)

But if the Platform Init wants to reserve some system RAM for runtime
code (e.g., for its PSCI implementation on ARM), it can add it to the
/reserved-memory node, where both the payload and the OS will be able
to find it if needed.

> I'm just not sure that Platform Init and Payload are as completely
> independent as you seem to be suggesting. Once we get into the
> Payload, the only things we know are what Platform Init told us.
>

They are not independent, and that is not at all what I am claiming.

What I am objecting to is framing the platform init<->payload memory
handover in terms of UEFI memory types, which may conflict with well
established DT bindings that already serve the same purpose. The only
difference between /reserved-memory and this binding seems to be the
collection of UEFI memory types, which don't belong there in the first
place.
