Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3F42A8E022
	for <lists+linux-acpi@lfdr.de>; Wed, 14 Aug 2019 23:49:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728819AbfHNVtr (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 14 Aug 2019 17:49:47 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:51451 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728750AbfHNVtr (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 14 Aug 2019 17:49:47 -0400
Received: from mail-qk1-f198.google.com ([209.85.222.198])
        by youngberry.canonical.com with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <alex.hung@canonical.com>)
        id 1hy19M-0002li-CQ
        for linux-acpi@vger.kernel.org; Wed, 14 Aug 2019 21:49:44 +0000
Received: by mail-qk1-f198.google.com with SMTP id e18so241595qkl.17
        for <linux-acpi@vger.kernel.org>; Wed, 14 Aug 2019 14:49:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=w1D8Zv52DMVI+1tJMrYZUNsEQ+/Ls5xmkyTop5o1js0=;
        b=Jdh8y9DouHyOeryjOK/spLKSrv7fhFhQKoxV6Qf8iA5sSFkilyxSimYz/UnQf2rCN7
         zdaPoHVApORqW0Yt86SJ0Rp6VakgA2dKJsvSwikC459WYEgcvUZ25szRz2Ca0tHItJEx
         gwVa2nZ00+FtAsNTUoOXLnyleYoucb9QFv29rUJbTF+eWty7RH8VJGB4wvLd2ZYcah0r
         1YZBWTd25WcJxnVc/1+y31masKg108LTK7rIEhsxizSUQrW6n6ZoIAFc5E3Enyvwv/0K
         PBf//afEAyX/LVuFcqIhJKcZ7VHKTEa53Qp7b63nwoxDpoXTQRefHN9RCJmpkKEKwQoX
         k8yA==
X-Gm-Message-State: APjAAAV0aY0zFwGPLWLuhzJ6NUVLTZmncZu6lbmVfsc813J1cVNcoqJf
        C3ZKagPJE2zJqMri/kVnHZxVA9+Lg6OLcp1iFqzMoKdkRaT3+N4eWT1Re8PRgf7KA0AOHeiEx2J
        S77XsDtOxlKWBWOnrbeQuvxEeubgpQ5c6yjMOu3EpgPBF/mBBiRxRT1I=
X-Received: by 2002:a0c:f706:: with SMTP id w6mr1203596qvn.98.1565819383592;
        Wed, 14 Aug 2019 14:49:43 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzcGzXZYUfIv5JuhgEy8csgt/G/+sxp+oSBTO1E+31KuR6LKUls9RsfxiIM2IRCFHVyk/GRcm+GmCe9i0bILN4=
X-Received: by 2002:a0c:f706:: with SMTP id w6mr1203573qvn.98.1565819383322;
 Wed, 14 Aug 2019 14:49:43 -0700 (PDT)
MIME-Version: 1.0
References: <20190814213118.28473-1-kherbst@redhat.com> <20190814213118.28473-2-kherbst@redhat.com>
In-Reply-To: <20190814213118.28473-2-kherbst@redhat.com>
From:   Alex Hung <alex.hung@canonical.com>
Date:   Wed, 14 Aug 2019 15:49:32 -0600
Message-ID: <CAJ=jquaoA+_WmTJtcGq4b0A_Sb=Aw_3_TsUR-8nxJ+rJTdoFPA@mail.gmail.com>
Subject: Re: [PATCH 1/7] Revert "ACPI / OSI: Add OEM _OSI string to enable
 dGPU direct output"
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

Thanks for the series of fixes. I will check whether these fixes work
on the original intended systems.

On Wed, Aug 14, 2019 at 3:31 PM Karol Herbst <kherbst@redhat.com> wrote:
>
> This reverts commit 28586a51eea666d5531bcaef2f68e4abbd87242c.
>
> The original commit message didn't even make sense. AMD _does_ support it and
> it works with Nouveau as well.
>
> Also what was the issue being solved here? No references to any bugs and not
> even explaining any issue at all isn't the way we do things.
>
> And even if it means a muxed design, then the fix is to make it work inside the
> driver, not adding some hacky workaround through ACPI tricks.
>
> And what out of tree drivers do or do not support we don't care one bit anyway.
>
> Signed-off-by: Karol Herbst <kherbst@redhat.com>
> CC: Alex Hung <alex.hung@canonical.com>
> CC: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> CC: Dave Airlie <airlied@redhat.com>
> CC: Lyude Paul <lyude@redhat.com>
> CC: Ben Skeggs <bskeggs@redhat.com>
> ---
>  drivers/acpi/osi.c | 7 -------
>  1 file changed, 7 deletions(-)
>
> diff --git a/drivers/acpi/osi.c b/drivers/acpi/osi.c
> index bec0bebc7f52..9b20ac4d79a0 100644
> --- a/drivers/acpi/osi.c
> +++ b/drivers/acpi/osi.c
> @@ -61,13 +61,6 @@ osi_setup_entries[OSI_STRING_ENTRIES_MAX] __initdata = {
>          * a BIOS workaround.
>          */
>         {"Linux-Lenovo-NV-HDMI-Audio", true},
> -       /*
> -        * Linux-HPI-Hybrid-Graphics is used by BIOS to enable dGPU to
> -        * output video directly to external monitors on HP Inc. mobile
> -        * workstations as Nvidia and AMD VGA drivers provide limited
> -        * hybrid graphics supports.
> -        */
> -       {"Linux-HPI-Hybrid-Graphics", true},
>  };
>
>  static u32 acpi_osi_handler(acpi_string interface, u32 supported)
> --
> 2.21.0
>


-- 
Cheers,
Alex Hung
