Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E4654D8021
	for <lists+linux-acpi@lfdr.de>; Mon, 14 Mar 2022 11:44:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238684AbiCNKp1 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 14 Mar 2022 06:45:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238660AbiCNKpQ (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 14 Mar 2022 06:45:16 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38D4BBC80
        for <linux-acpi@vger.kernel.org>; Mon, 14 Mar 2022 03:44:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E9C36B80D28
        for <linux-acpi@vger.kernel.org>; Mon, 14 Mar 2022 10:44:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C66DC340F4
        for <linux-acpi@vger.kernel.org>; Mon, 14 Mar 2022 10:44:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647254644;
        bh=uvT7cU81YIqJYT+cVhR9x1v9dJvyUVAe9djV4LzrujM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=i2EUXEY1Fo27lNy0cAuSx6VOXrec+7nYpdzsIL3ASVQRcYKDc1CzTseG3U/77zBbP
         KQ27ceMraG19eze0yDpy6QS9lUsdaGQyzxcLKxgbhdD5lH2Oq9qKMiQ0pG2BZ+4Kjf
         uDKz+PgMVDOeTOZ4GGL/5kWuqNMeGWmYAdngDf4ZcoWuDHZwSlpnOGvgZEuDbl62uk
         tU8glwOJeiujYXdKKxdrvw1GRChCG0yXFs8A2ks3tpfhGHL9xmTSmQdm6Sp8Xkv9mM
         t7ihwEYflM+I/cwxvYHRBFcZbIiRpc9RecHD80CqZNq/o5BalXfipjdyKO8l5apW9x
         U09PqNlMdzdoA==
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-2dbfe58670cso157458867b3.3
        for <linux-acpi@vger.kernel.org>; Mon, 14 Mar 2022 03:44:04 -0700 (PDT)
X-Gm-Message-State: AOAM533aeFG+R4y8XjsLUjyXUcBHfUKfVfTH0k/bzfWSuwApv9WBztPD
        5VjABdlnLyDFZWDa2WnRssCPY/bNpeDr1zFhw8Y=
X-Google-Smtp-Source: ABdhPJzP53rsKKCg9qV4VsUmz7jL/PEPygwkKuSbsi4+znY1kUz24XWdAJ8TzEoDjQiyQ6uv7ejl/KzDM5P6h65RKfU=
X-Received: by 2002:a81:e90c:0:b0:2db:d63e:56ff with SMTP id
 d12-20020a81e90c000000b002dbd63e56ffmr18727137ywm.60.1647254643455; Mon, 14
 Mar 2022 03:44:03 -0700 (PDT)
MIME-Version: 1.0
References: <20220221154344.2126-1-shameerali.kolothum.thodi@huawei.com>
 <bb3688c7-8f42-039e-e22f-6529078da97d@redhat.com> <8ecce421-e2ee-1a19-ae2d-a8454a8a5844@arm.com>
 <0cde239c-8d30-33a8-6e5b-792e30e20462@redhat.com>
In-Reply-To: <0cde239c-8d30-33a8-6e5b-792e30e20462@redhat.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Mon, 14 Mar 2022 11:43:51 +0100
X-Gmail-Original-Message-ID: <CAMj1kXEn8RhmHcCxpKeDy_B8-072wvbsZzc-78XNFJdtaKPWBQ@mail.gmail.com>
Message-ID: <CAMj1kXEn8RhmHcCxpKeDy_B8-072wvbsZzc-78XNFJdtaKPWBQ@mail.gmail.com>
Subject: Re: [PATCH v8 00/11] ACPI/IORT: Support for IORT RMR node
To:     Eric Auger <eric.auger@redhat.com>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux IOMMU <iommu@lists.linux-foundation.org>,
        Linuxarm <linuxarm@huawei.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        wanghuiqiang <wanghuiqiang@huawei.com>,
        Hanjun Guo <guohanjun@huawei.com>,
        Steven Price <steven.price@arm.com>,
        Sami Mujawar <Sami.Mujawar@arm.com>,
        Jon Nettleton <jon@solid-run.com>,
        yangyicong <yangyicong@huawei.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, 14 Mar 2022 at 11:37, Eric Auger <eric.auger@redhat.com> wrote:
>
> Hi Robin
>
> On 3/11/22 11:34 AM, Robin Murphy wrote:
> > On 2022-03-11 08:19, Eric Auger wrote:
> >> Hi guys,
> >>
> >> On 2/21/22 4:43 PM, Shameer Kolothum wrote:
> >>> Hi,
> >>>
> >>> Since we now have an updated verion[0] of IORT spec(E.d) which
> >>> addresses the memory attributes issues discussed here [1],
> >>> this series now make use of it.
> >>>
> >>> The pull request for ACPICA E.d related changes are already
> >>> raised and can be found here,
> >>> https://github.com/acpica/acpica/pull/752
> >>>
> >>> v7 --> v8
> >>>    - Patch #1 has temp definitions for RMR related changes till
> >>>      the ACPICA header changes are part of kernel.
> >>>    - No early parsing of RMR node info and is only parsed at the
> >>>      time of use.
> >>>    - Changes to the RMR get/put API format compared to the
> >>>      previous version.
> >>>    - Support for RMR descriptor shared by multiple stream IDs.
> >>>
> >>> Please take a look and let me know your thoughts.
> >>>
> >>> Thanks,
> >>> Shameer
> >>> [0] https://developer.arm.com/documentation/den0049/ed/
> >> I still have a question on the IORT E.d spec (unrelated to this series).
> >>
> >> The spec mandates that if RMR nodes are presented in the IORT,
> >> _DSM function #5 for the PCIe host bridge ACPI device object must return
> >> 0, indicating the OS must honour the PCI config that the FW computed at
> >> boot time.
> >>
> >> However implementing this _DSM #5 as above is known to prevent PCI
> >> devices with IO ports from working, on aarch64 linux.
> >>
> >> "
> >> The reason is that EFI creates I/O port mappings below
> >>      0x1000 (in fact, at 0). However Linux, for legacy reasons, does not
> >>      support I/O ports <= 0x1000 on PCI, so the I/O assignment
> >> created by EFI
> >>      is rejected.
> >>          EFI creates the mappings primarily for itself, and up until
> >> DSM #5
> >>      started to be enforced, all PCI resource allocations that
> >> existed at
> >>      boot were ignored by Linux and recreated from scratch.
> >> "
> >>
> >> This is an excerpt of a qemu commit message that reverted the _DMS #5
> >> change (Revert "acpi/gpex: Inform os to keep firmware resource map").
> >> Has the situation changed since July 2021 (ie. has UEFI been reworked?).
> >> [+ Ard]
> >
> > FWIW I wasn't aware of that, but if it's an issue then it will need to
> > be fixed in Linux or UEFI's PCI resource code (arguably if UEFI has
> > already allocated from the bottom of I/O space then Linux should be
> > safe to assume that there are no legacy PC I/O resources to worry
> > about). The DSM is required to prevent bus numbers being reassigned,
> > because if that happens then any PCI StreamIDs referenced in IORT may
> > suddenly become meaningless and the association of root complex nodes
> > and RMRs to physical hardware lost.
>
> Thank you for confirming and explaining the need for DSM #5. Ard, please
> could you confirm that the incompatibility with PCI devices with IO
> ports is still there?
>

Yes, and this needs to be fixed in Linux. The firmware complies with
the pertinent specifications, and it is Linux that deviates from this
for legacy reasons.

IIRC, this came up on the mailing list at some point, and one of the
issues is that I/O port 0x0 is mistaken for 'no resource' or some
other exceptional case like that, so even if we fix the arbitrary
limit of 0x1000, we may still run into trouble when devices uses I/O
port 0x0.
