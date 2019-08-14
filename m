Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 894358E147
	for <lists+linux-acpi@lfdr.de>; Thu, 15 Aug 2019 01:35:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729646AbfHNXfE (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 14 Aug 2019 19:35:04 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:52868 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729617AbfHNXfD (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 14 Aug 2019 19:35:03 -0400
Received: from mail-qk1-f200.google.com ([209.85.222.200])
        by youngberry.canonical.com with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <alex.hung@canonical.com>)
        id 1hy2nF-0008WG-IM
        for linux-acpi@vger.kernel.org; Wed, 14 Aug 2019 23:35:01 +0000
Received: by mail-qk1-f200.google.com with SMTP id d203so513294qke.4
        for <linux-acpi@vger.kernel.org>; Wed, 14 Aug 2019 16:35:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VyFhDO1eWcBeMeihOWCBNHAWrS5d5d9jzD5/Lieum7w=;
        b=XJzxhCuWz1U5eMoF3U3laNVIzHjX3z4E8pv2fTNQgnB6ckpbRxZySpVjP/F+U7+HwJ
         lzYFEjQtLTB3bbaiwTm43wE7DQ03lyHEfMhsJUvRoiaHJ8wZfz/FPqikm1OYsBDdkRFS
         xgXuzDuU4j7NZXYO0JRbwWnNvM5DMkp/LjuTjGc9Mxwu1O/qC8F53x3J2mTuNoWQ1K2h
         +uJGswnorsDORAE9GhENt0WSBAZl6i5WP1BT+IjiUEEh7ZuFLulEcn0cT35yti9MVrzL
         d5U6v6GxD3o2PqoLQ5dVkVrLE5ghJSwF0KF/bOhe3RAb8Cj1hZEIWLET0GIO9Xz35cxb
         mheA==
X-Gm-Message-State: APjAAAUlMyZAQ/1pTx9gMgJNuKRs3ErVm5p8BMeHS9Rl1P89+PM5kAcQ
        AhaMxS95juF2nT7yT0u1oVVgiX1/ec9JX2wV+fDZvlnv8EyEntYEev5xvS+gHOsiB/bcz6aiLwo
        Md2ELPyVtLjnfEQV1Ps39xFzJv2StEuvtk2uJWD1LY7DZ+z7IBSx3+oQ=
X-Received: by 2002:a0c:f6ce:: with SMTP id d14mr1525100qvo.56.1565825700754;
        Wed, 14 Aug 2019 16:35:00 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxE+6MV13gPzPrDixW9IwdnT+USgnWkWtGUiu6QcUgWCmd75vba/3ZYWWy4K18nZ+ZMC4zhsyMCvvjKOohDSj4=
X-Received: by 2002:a0c:f6ce:: with SMTP id d14mr1525085qvo.56.1565825700594;
 Wed, 14 Aug 2019 16:35:00 -0700 (PDT)
MIME-Version: 1.0
References: <20190814213118.28473-1-kherbst@redhat.com> <20190814213118.28473-4-kherbst@redhat.com>
In-Reply-To: <20190814213118.28473-4-kherbst@redhat.com>
From:   Alex Hung <alex.hung@canonical.com>
Date:   Wed, 14 Aug 2019 17:34:49 -0600
Message-ID: <CAJ=jquaVcWisQ3Qw-_GMktcOq4zqFmeYXztfwNAVKZJO=_+yLA@mail.gmail.com>
Subject: Re: [PATCH 3/7] Revert "ACPI / OSI: Add OEM _OSI strings to disable
 NVidia RTD3"
To:     Karol Herbst <kherbst@redhat.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux ACPI Mailing List <linux-acpi@vger.kernel.org>,
        dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Dave Airlie <airlied@redhat.com>,
        Lyude Paul <lyude@redhat.com>, Ben Skeggs <bskeggs@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, Aug 14, 2019 at 3:31 PM Karol Herbst <kherbst@redhat.com> wrote:
>
> This reverts commit 9251a71db62ca9cc7e7cf364218610b0f018c291.
>
> This was never discussed with anybody Nouveau related and we would have NACKed
> this change immediately.
>
> We have a better workaround, which makes it actually work with Nouveau. No idea
> why the comment mentions the Nvidia driver and assumes it gives any weight to
> the reasoning.... we don't care about out of tree drivers.
>
> Nouveau does support RTD3, but we had some issues with that. And we even have
> a better fix for this issue. Also, can we _please_ do it in a way worthy of an
> upstream community the next time?
>
> If some distribution feels like they have to please companies not wanting to
> be part of the linux community, please do so downstream and don't try to push
> something like this upstream.

Hi Karol,

A lot of appreciation for your hard-work on this issue, but unfriendly
comments aren't necessary. At the time this was discussed with
hardware vendors and platform vendors and it worked for many systems
and benefit for many people buying these platforms. Last but not
least, I do appreciate better fixes and want to retire the hacks too.

I am going to notify hardware owners to test these patches on the
original intended systems, and will report whether there are
regressions.


>
> Signed-off-by: Karol Herbst <kherbst@redhat.com>
> CC: Alex Hung <alex.hung@canonical.com>
> CC: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> CC: Dave Airlie <airlied@redhat.com>
> CC: Lyude Paul <lyude@redhat.com>
> CC: Ben Skeggs <bskeggs@redhat.com>
> ---
>  drivers/acpi/osi.c | 9 ---------
>  1 file changed, 9 deletions(-)
>
> diff --git a/drivers/acpi/osi.c b/drivers/acpi/osi.c
> index 56cc95b6b724..f5d559a2ff14 100644
> --- a/drivers/acpi/osi.c
> +++ b/drivers/acpi/osi.c
> @@ -44,15 +44,6 @@ osi_setup_entries[OSI_STRING_ENTRIES_MAX] __initdata = {
>         {"Processor Device", true},
>         {"3.0 _SCP Extensions", true},
>         {"Processor Aggregator Device", true},
> -       /*
> -        * Linux-Dell-Video is used by BIOS to disable RTD3 for NVidia graphics
> -        * cards as RTD3 is not supported by drivers now.  Systems with NVidia
> -        * cards will hang without RTD3 disabled.
> -        *
> -        * Once NVidia drivers officially support RTD3, this _OSI strings can
> -        * be removed if both new and old graphics cards are supported.
> -        */
> -       {"Linux-Dell-Video", true},
>  };
>
>  static u32 acpi_osi_handler(acpi_string interface, u32 supported)
> --
> 2.21.0
>


--
Cheers,
Alex Hung
