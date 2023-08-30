Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4771E78E194
	for <lists+linux-acpi@lfdr.de>; Wed, 30 Aug 2023 23:47:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242467AbjH3Vrk (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 30 Aug 2023 17:47:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242456AbjH3Vrj (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 30 Aug 2023 17:47:39 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BD0ACDB
        for <linux-acpi@vger.kernel.org>; Wed, 30 Aug 2023 14:47:05 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-522dd6b6438so134981a12.0
        for <linux-acpi@vger.kernel.org>; Wed, 30 Aug 2023 14:47:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1693431928; x=1694036728; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=qsmmyr5OFzyMVcMpEFVBPPKJRXoUjcjNdTuQLnrGF48=;
        b=cdYKXToplsq9eIJ+cxnDloiRphbnBeh5UDEKnkqw97AgXhBHwC1IJOKtGykkyxh3mX
         xp97pCT0YLvdObD+imxFWKhPO2ksmKrVFzVB9cI09uGGfzVOf6FXZDgoHUYFJmWN5Tvw
         CnhtXmbyK3HB3vTc2YT9hIQaGQVtvkgaAvROk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693431928; x=1694036728;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qsmmyr5OFzyMVcMpEFVBPPKJRXoUjcjNdTuQLnrGF48=;
        b=YDJZrQOy4e2PZkIVOJkyCc0YkzLo3LhShBR61kQSgcWgljt0Tdqt0b9bWH5gj7qvhD
         0KdM/qbJLD/bmPUJ7IZchYoyxckV94z2oIVE7WLuPo7xGa9AOFg0KZsrv+e1kG8iipbc
         lCo/AhbtZGA4/e2iZCReU7BrIKg3Mq2Jt+I6B6p7ynh+o+VVV0Llgt8UVQxCtYwtCShJ
         Rhn4lMEmjeBSBPQhWSTY0TxuCSNRlrG9ijsHb9q3QOxMXNVzNQGA6UXCR51M5l3DYv/r
         PM1Mfv+TpN7dSLdXNrSBCZIu027CYo3hg+8KuLO9MeOLW8Fuiz3Af9i4WlKzOHTeIHIV
         Xr2g==
X-Gm-Message-State: AOJu0Ywgp0BGTtKzUQiAQcojeO/A/jdKYlZBsyji+H7X1hqNJ3MdGpJw
        xip371JBVeCVIpcCzK/pHEO4lKWjFnZNK2QuDae3KFwtE1xdpxRQ/v7bYA==
X-Google-Smtp-Source: AGHT+IFDRoXLXPrIZmwI2bs476erTEre4LDDRoGLiwdLjD+TCzsvOulU+GzGz8j1hshodfcQrQVfKGCcCkOqp5X7yDU=
X-Received: by 2002:ac2:5f02:0:b0:500:77c4:108 with SMTP id
 2-20020ac25f02000000b0050077c40108mr1924403lfq.9.1693429856927; Wed, 30 Aug
 2023 14:10:56 -0700 (PDT)
MIME-Version: 1.0
References: <20230822203446.4111742-1-sjg@chromium.org> <ZOXKTrC_dzN_hUkY@FVFF77S0Q05N>
 <CAMj1kXEHpRjk_YKOm4czCnnpjqgahj2jV8MMfGLx7b1RdnBnVw@mail.gmail.com>
 <CAPnjgZ1S8G=7eCBF9PcDk4H5sk3AcxSSWXO575jK8SjA9dR8qw@mail.gmail.com>
 <CAMj1kXH83_TB4S0PL3jswxjCP+907YpgS7FRuVTO3G62s7nn5w@mail.gmail.com>
 <CAPnjgZ2kkUt1eOWX8K+EsbjcQZPefNvj5DSaFb9QrvRg0t2h7w@mail.gmail.com> <CAMj1kXGe84uaJ9j9ic0V4HC43p7QBoKQ5ssTYd5DMBGtZ3++Jw@mail.gmail.com>
In-Reply-To: <CAMj1kXGe84uaJ9j9ic0V4HC43p7QBoKQ5ssTYd5DMBGtZ3++Jw@mail.gmail.com>
From:   Simon Glass <sjg@chromium.org>
Date:   Wed, 30 Aug 2023 15:10:45 -0600
Message-ID: <CAPnjgZ3L-jGxoXNHnsXY0MXU=jTAN66KNAxSLHPVeHinHMjzkQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] schemas: Add a schema for memory map
To:     Ard Biesheuvel <ardb@kernel.org>
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
X-Spam-Status: No, score=-9.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_SPF_WL
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Ard,

On Tue, 29 Aug 2023 at 15:32, Ard Biesheuvel <ardb@kernel.org> wrote:
>
> On Tue, 29 Aug 2023 at 21:18, Simon Glass <sjg@chromium.org> wrote:
> >
> > Hi Ard,
> >
> > On Thu, 24 Aug 2023 at 03:10, Ard Biesheuvel <ardb@kernel.org> wrote:
> > >
> > > On Wed, 23 Aug 2023 at 22:04, Simon Glass <sjg@chromium.org> wrote:
> > > >
> > > > Hi,
> > > >
> > > > On Wed, 23 Aug 2023 at 08:24, Ard Biesheuvel <ardb@kernel.org> wrote:
> > > > >
> > > > > On Wed, 23 Aug 2023 at 10:59, Mark Rutland <mark.rutland@arm.com> wrote:
> > > > > >
> > > > > > On Tue, Aug 22, 2023 at 02:34:42PM -0600, Simon Glass wrote:
> > > > > > > The Devicetree specification skips over handling of a logical view of
> > > > > > > the memory map, pointing users to the UEFI specification.
> > > > > > >
> > > > > > > It is common to split firmware into 'Platform Init', which does the
> > > > > > > initial hardware setup and a "Payload" which selects the OS to be booted.
> > > > > > > Thus an handover interface is required between these two pieces.
> > > > > > >
> > > > > > > Where UEFI boot-time services are not available, but UEFI firmware is
> > > > > > > present on either side of this interface, information about memory usage
> > > > > > > and attributes must be presented to the "Payload" in some form.
> > > > >
> > > > > Not quite.
> > > > >
> > > > > This seems to be intended for consumption by Linux booting in ACPI
> > > > > mode, but not via UEFI, right?
> > > >
> > > > Actually, this is for consumption by firmware. The goal is to allow
> > > > edk2 to boot into U-Boot and vice versa, i.e. provide some
> > > > interoperability between firmware projects. I will use the "Platform
> > > > Init" and "Payload" terminology here too.
> > > >
> > >
> > > OK. It was the cc to linux-acpi@ and the authors of the
> > > ACPI/SMBIOS-without-UEFI patches that threw me off here.
> > >
> > > If we are talking about an internal interface for firmware components,
> > > I'd be inclined to treat this as an implementation detail, as long as
> > > the OS is not expected to consume these DT nodes.
> > >
> > > However, I struggle to see the point of framing this information as a
> > > 'UEFI memory map'. Neither EDK2 nor u-boot consume this information
> > > natively, and there is already prior art in both projects to consume
> > > nodes following the existing bindings for device_type=memory and the
> > > /reserved-memory node. UEFI runtime memory is generally useless
> > > without UEFI runtime services, and UEFI boot services memory is just
> > > free memory.
> > >
> > > There is also an overlap with the handover between secure and
> > > non-secure firmware on arm64, which is also DT based, and communicates
> > > available memory as well as RAM regions that are reserved for firmware
> > > use.
> > >
> > > In summary, I don't see why a non-UEFI payload would care about UEFI
> > > semantics for pre-existing memory reservations, or vice versa. Note
> > > that EDK2 will manage its own memory map, and expose it via UEFI boot
> > > services and not via DT.
> >
> > Bear in mind that one or both sides of this interface may be UEFI.
> > There is no boot-services link between the two parts that I have
> > outlined.
> >
>
> I don't understand what this means.
>
> UEFI specifies how one component invokes another, and it is not based
> on a DT binding. If the second component calls UEFI boot or runtime
> services, it should be invoked in this manner. If it doesn't, then it
> doesn't care about these memory reservations (and the OS will not be
> booted via UEFI either)
>
> So I feel I am missing something here. Perhaps a practical example
> would be helpful?

Let's say we want to support these combinations:

Platform Init -> Payload
--------------------------------
U-Boot -> Tianocore
coreboot -> U-Boot
Tianocore -> U-Boot
Tianocore -> Tianocore
U-Boot -> U-Boot

Some of the above things have UEFI interfaces, some don't. But in the
case of Tianocore -> Tianocore we want things to work as if it were
Tianocore -> (its own handoff mechanism) Tiancore.

Some Platform Init may create runtime code which needs to accessible later.

The way I think of it is that we need to generalise the memory map a
bit. Saying that you must use UEFI boot services to discover it is too
UEFI-specific.

>
>
> > >
> > > ...
> > > >
> > > > There is no intent to implement the UEFI spec, here. It is simply that
> > > > some payloads (EDK2) are used to having this information.
> > > >
> > > > Imagine splitting EDK2 into two parts, one of which does platform init
> > > > and the other which (the payload) boots the OS. The payload wants
> > > > information from Platform Init and it needs to be in a devicetree,
> > > > since that is what we have chosen for this interface. So to some
> > > > extent this is unrelated to whether you have EFI boot services. We
> > > > just need to be able to pass the information across the interface.
> > > > Note that the user can (without recompilation, etc.) replace the
> > > > second part with U-Boot (for example) and it must still work.
> > > >
> > >
> > > OK, so device tree makes sense for this. This is how I implemented the
> > > EDK2 port that targets QEMU/mach-virt - it consumes the DT to discover
> > > the UART, RTC,, memory, PCI host bridge, etc.
> > >
> > > But I don't see a use case for a UEFI memory map here.
> > >
> > >
> ...
> > > >
> > > > Here I believe you are talking about booting the kernel in EFI mode,
> > > > but that is not the intent of this patch. This is all about things
> > > > happening in firmware. Now, if the payload (second) part of the
> > > > firmware decides it wants to offer EFI boot services and boot the
> > > > kernel via the EFI stub, then it may very well pack this information
> > > > (with a few changes) into a system table and make it available to the
> > > > kernel stub. But by then this FDT binding is irrelevant, since it has
> > > > served its purpose (which, to reiterate, is to facilitate information
> > > > passage from platform init to 'payload').
> > > >
> > >
> > > Indeed. As long as this binding is never consumed by the OS, I don't
> > > have any objections to it - I just fail to see the point.
> >
> > OK thanks.
> >
> > The point is that Platform Init and the payload need to agree about
> > where certain things are in memory. It is true that this is coming
> > from an EFI context, but that is just an example. Platform Init
> > doesn't necessarily know whether its payload is EFI, but may set this
> > up for use by the payload, just in case.
> >
>
> Platform init can communicate memory reservations to a UEFI payload if
> needed, and there is prior art for this.
>
> Platform init *cannot* communicate UEFI specific boot or runtime
> reservations in this manner, as this doesn't make sense: either
> Platform Init is UEFI and invokes a UEFI payload, in which case the
> UEFI spec applies. In other cases, the UEFI memory regions either
> don't exist or are irrelevant. The only EFI-agnostic aspect here is
> RAM reservation for use by firmware in general, and this does not have
> these UEFI semantics and does not need to be framed as such.

How does one do the handoff if we don't know whether the payload
supports UEFI or not? I am coming from an interoperability POV here.

Regards,
Simon
