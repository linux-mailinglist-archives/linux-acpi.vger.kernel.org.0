Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB0D370B948
	for <lists+linux-acpi@lfdr.de>; Mon, 22 May 2023 11:44:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232630AbjEVJo0 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-acpi@lfdr.de>); Mon, 22 May 2023 05:44:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232657AbjEVJoV (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 22 May 2023 05:44:21 -0400
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB537FD;
        Mon, 22 May 2023 02:44:18 -0700 (PDT)
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-96f66fbd770so59788766b.1;
        Mon, 22 May 2023 02:44:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684748657; x=1687340657;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H0v9adtniTT8QNuGIgBreS0o2NPh2mX6275Qoav/Keo=;
        b=CXwi1SAEX8lHCPFyvAbrxI5uaANzedgDMy4bV6/qoApMLglr6Z8idHPB0rJEZMNcKH
         p2lUuAoMm91setAVT9vUwArBjtkg/Pi2+VlQeLDgjhttDq69uOLnHV10w7RiHx5tyW4Z
         pBmzEd+ix8s1+uD8uPYLl15qs5/WPSHlfdrkxJp5r+W71pbeQf+urMmjK1p6I6hVnpzf
         bu0aEuNIouLCN/GDGuCJZuAlI6xlGm+ih2iBvnthyE7xVpOAHSWpI7xz5VQKMxoS84Ka
         QoSQwxxLG6qBGaESlBWrvqvbZ1CSXGiVCmGadqUbP9QbS5vKdztSvpKSNlHfeTISVr8/
         B2Zg==
X-Gm-Message-State: AC+VfDyIOyHvypvLerHZheg6+8aMGOweAbgcoV7Dqhp18WBALbTm+11h
        rugOjZcPpbIKaPw5sBR6No0m76ltURwQhAC6qV8=
X-Google-Smtp-Source: ACHHUZ4WRGjpcozBTc7qvQY6+H8MfsrOajqLuZkWKppHdNcZWnk2yX1TxehlXPzo4Nxu9a1Mq7fs3kQCYqmFJ/lSjEE=
X-Received: by 2002:a17:906:2218:b0:96f:4c38:4b1a with SMTP id
 s24-20020a170906221800b0096f4c384b1amr8703985ejs.5.1684748656459; Mon, 22 May
 2023 02:44:16 -0700 (PDT)
MIME-Version: 1.0
References: <DM6PR19MB2780634FE9D96D6FB72712B2BC429@DM6PR19MB2780.namprd19.prod.outlook.com>
In-Reply-To: <DM6PR19MB2780634FE9D96D6FB72712B2BC429@DM6PR19MB2780.namprd19.prod.outlook.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 22 May 2023 11:44:01 +0200
Message-ID: <CAJZ5v0j5hFbVh05wP5t49_j2kSkW9XY3WaqtrOb6YA9NJYHKcQ@mail.gmail.com>
Subject: Re: ACPI: what should Linux do for "call-order-swap" quirk from firmware?
To:     Ratchanan Srirattanamet <peathot@hotmail.com>
Cc:     linux-pm@vger.kernel.org,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Mario Limonciello <mario.limonciello@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

+Mario and linux-acpi

On Sun, May 21, 2023 at 9:26 PM Ratchanan Srirattanamet
<peathot@hotmail.com> wrote:
>
> Hello,
>
> I'm trying to debug an issue where Nouveau is unable to runtime-resume
> an Nvidia GTX 1650 Ti in an AMD-based laptop [1]. As part of this, I've
> traced ACPI calls for the same device on Windows. And it seems like this
> device has a weird quirk, which I call it "call-order-swap" for a lack
> of better words, when it transitions from D3cold to D0.
>
> So, a bit of context: Lenovo Legion 5-15ARH05 [2] is a laptop sporting
> AMD Ryzen 7 4800H with Radeon Graphics + Nvidia GTX 1650 Ti. This
> device's PCI-E topology to the GPU is:
>
> 00:01.1 PCI bridge [0604]: Advanced Micro Devices, Inc. [AMD] Renoir
> PCIe GPP Bridge [1022:1633]
>          +- 01:00.0 VGA compatible controller [0300]: NVIDIA Corporation
> TU117M [GeForce GTX 1650 Ti Mobile] [10de:1f95] (rev a1)
>
> And for ACPI perspective (according to my interpretation), a power
> resource \_SB.PCI0.GPP0 seems to represent the PCI bridge, having
> \_SB.PCI0.GPP0.PG00 as a power resource, and \_SB.PCI0.GPP0.PEGP seems
> to represent the GPU itself, which doesn't seem to have its own power
> resource. All ACPI table dumps and infos can be found in the issue on
> Freedesktop GitLab [1].
>
> Now, if I understand the specs correctly, when transitioning the GPU &
> the bridge back from D3cold to D0, the kernel should start up the bridge
> before the GPU itself. From the ACPI perspective, I should see calls for
> .PG00._ON() (power resource for the bridge) before .PEGP.PS0().
>
> However, on Windows [3], instead it seems like .PEGP.PS0() is called
> before .PG00._ON(), for some reason. This is weird, because if
> .PG00._ON() has not been called yet, .PEGP.PS0() should be even valid to
> call. Now, I have no idea on what part of the Windows system is supposed
> to call those ACPI functions, but my feeling is that it must be either
> Nvidia or AMD driver that does this kind of quirks.
>
> As for what Linux does... well it seems like when Linux resumes the PCI
> bridge, it calls only .PG00._ON(), skipping .PEGP.PS0() on the ground
> that the downstream devices must have been reset when that happens. I'm
> not sure that's the right thing to happen either, but at least it makes
> more sense. Nvidia's proprietary driver seems to disable runtime D3
> support inside it completely on this device, so I think Nvidia must have
> a quirk for this chipset, as I briefly borrowed my friend's laptop
> sporting AMD 6000 series CPU and it doesn't disable runtime D3.
>
> So... I'm not sure what the correct behavior is here. I'm a developer
> myself, but kernel is not where I'm familiar with. Please advise me on
> where I should look next.
>
> Ratchanan.
>
> P.S. please make sure to include me in the reply, as I'm not the list's
> subscriber.
>
> [1] https://gitlab.freedesktop.org/drm/nouveau/-/issues/79
> [2]
> https://pcsupport.lenovo.com/th/en/products/laptops-and-netbooks/legion-series/legion-5-15arh05/82b5/82b500fqta
> [3]
> https://gitlab.freedesktop.org/drm/nouveau/uploads/2659e5cb41a52290ebf18d9906408d62/nvamli1-processed.txt
