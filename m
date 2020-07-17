Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 169C222441E
	for <lists+linux-acpi@lfdr.de>; Fri, 17 Jul 2020 21:20:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728175AbgGQTTz (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 17 Jul 2020 15:19:55 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:57952 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727999AbgGQTTy (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 17 Jul 2020 15:19:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1595013592;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Du0bkJJuZiGwcsmmaS0iHcsLc6G/grfEoCnxuV98a2A=;
        b=cVMA9O9qwqHTlXzQDlGJVKukO12bNaB5vECaAfRW4BNVIHX0N8cAgWEl5BKQkqQAmo4liZ
        rLDoLycslYMZVjyzIf6hRsrjvz5T2B2ocYZote11NIK1OVuGCHuBLVNlV2uD1wUQRjQpy2
        Fl/ba4KSQZ+rb6V9eYAfH+Zzv1E/Iiw=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-119-1N3DP1gUPnCLoSVurpCBLA-1; Fri, 17 Jul 2020 15:19:49 -0400
X-MC-Unique: 1N3DP1gUPnCLoSVurpCBLA-1
Received: by mail-qt1-f199.google.com with SMTP id d45so6948501qte.12
        for <linux-acpi@vger.kernel.org>; Fri, 17 Jul 2020 12:19:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:reply-to:to:cc:date
         :in-reply-to:references:organization:user-agent:mime-version
         :content-transfer-encoding;
        bh=Du0bkJJuZiGwcsmmaS0iHcsLc6G/grfEoCnxuV98a2A=;
        b=krZ5umQuY6/tP05+LuFEKEO37C0iVkiQz+QLxdMs/JTSUyDcG1JyHHtvLzI322xNxf
         7urZYr4Vuq6W1lE+Fgct93Ofi2TSg+zvexDAUstEhMMLgAqptu3wKhuJL+NVt0CNGgJZ
         FfLiR5dB5adgdVAdH2y3X2bzMd+T8PlHd5g6YmiW56g44y8WSlzE5CDPmcDBpvLYgdQw
         30WgNLZQ9nOsal7HhIaD69jY3RHQ8z5qUYcFwVVVqqF12tkoThSKFbYmPLdcM4jDFAsq
         G4kKdfCzHGCUEDy0e7uMA7pxVARDfXr28LQnTaI19fNZckJ24+0Zh56tH82F5WSc1Miw
         2nqg==
X-Gm-Message-State: AOAM533u9jTiXeARBFxknsaf1+pBNMpzQTJ+SWtDGkVC2bDKF5yIrTUe
        80Cajpi4RDKCMcEfNCs/mkxOJvb0Noevt1FPHOiKUDUUjjhnyuiOmF3obL35AGJBohemE93KpGD
        w0yhiSzeivKaXtYbgDuMIRw==
X-Received: by 2002:ac8:2a3d:: with SMTP id k58mr11996369qtk.265.1595013589360;
        Fri, 17 Jul 2020 12:19:49 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyT0/KR3PO3o3z4CMqcsVwsJeewSBzu5ESSc3mYOvNJKWnWh8PK7bA6UyC//9un04gWCMUW8A==
X-Received: by 2002:ac8:2a3d:: with SMTP id k58mr11996348qtk.265.1595013589062;
        Fri, 17 Jul 2020 12:19:49 -0700 (PDT)
Received: from Whitewolf.lyude.net (pool-108-49-102-102.bstnma.fios.verizon.net. [108.49.102.102])
        by smtp.gmail.com with ESMTPSA id f41sm12423841qtk.55.2020.07.17.12.19.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2020 12:19:48 -0700 (PDT)
Message-ID: <7bc7287b5cbac6535765b3490bd55da1e1cb4d07.camel@redhat.com>
Subject: Re: [PATCH] RFC: ACPI / OSI: remove workarounds for hybrid graphics
 laptops
From:   Lyude Paul <lyude@redhat.com>
Reply-To: lyude@redhat.com
To:     Karol Herbst <kherbst@redhat.com>, linux-acpi@vger.kernel.org
Cc:     Alex Hung <alex.hung@canonical.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org
Date:   Fri, 17 Jul 2020 15:19:47 -0400
In-Reply-To: <20200717190547.648604-1-kherbst@redhat.com>
References: <20200717190547.648604-1-kherbst@redhat.com>
Organization: Red Hat
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.3 (3.36.3-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hey-just wanted to give some additional context I think Karol missed here. It
should be noted that since the last time me and Karol looked at reverting these,
we've already fixed all of the nasty runtime PM (e.g. runtime D3) issues we
could find. This includes the infamous one that was affecting nearly all of the
nvidia pascal (+ some maxwell 2 and turing, it ended up being that the intel PCI
bridge was the culprit) machines on the market. Right now I'm only aware of one
major issue we have, which is the result of a recent PCI core change that we're
already in the process of getting reverted:

https://lkml.org/lkml/2020/7/16/1288

[if you do any testing of runtime PM, you may need to temporarily revert this
patch to make things work]

So, really-runtime D3 is very much supported with nouveau. And we've put a _lot_
of effort into making sure of that, and are happy to fix any issues you're still
finding. It also works just fine in AMD, but if you're finding systems it
doesn't work with amd on then please let the amdgpu folks know upstream so they
can properly fix it. Otherwise, these ACPI workarounds are likely making the
power consumption on these systems (for nouveau, amdgpu, and radeon)
dramatically higher then it needs to be.

On Fri, 2020-07-17 at 21:05 +0200, Karol Herbst wrote:
> It's hard to figure out what systems are actually affected and right now I
> don't see a good way of removing those...
> 
> But I'd like to see thos getting removed and drivers fixed instead (which
> happened at least for nouveau).
> 
> And as mentioned before, I prefer people working on fixing issues instead
> of spending time to add firmware level workarounds which are hard to know
> to which systems they apply to, hard to remove and basically a big huge
> pain to work with.
> In the end I have no idea how to even figure out what systems are affected
> and which not by this, so I have no idea how to even verify we can safely
> remove this (which just means those are impossible to remove unless we risk
> breaking systems, which again makes those supper annoying to deal with).
> 
> Also from the comments it's hard to get what those bits really do. Are they
> just preventing runtime pm or do the devices are powered down when booting?
> I am sure it's the former, still...
> 
> Please, don't do this again.
> 
> For now, those workaround prevent power savings on systems those workaround
> applies to, which might be any so those should get removed asap and if
> new issues arrise removing those please do a proper bug report and we can
> look into it and come up with a proper fix (and keep this patch out until
> we resolve all of those).
> 
> Signed-off-by: Karol Herbst <kherbst@redhat.com>
> CC: Alex Hung <alex.hung@canonical.com>
> CC: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> CC: Len Brown <lenb@kernel.org>
> CC: Lyude Paul <lyude@redhat.com>
> CC: linux-kernel@vger.kernel.org
> CC: dri-devel@lists.freedesktop.org
> CC: nouveau@lists.freedesktop.org
> ---
>  drivers/acpi/osi.c | 24 ------------------------
>  1 file changed, 24 deletions(-)
> 
> diff --git a/drivers/acpi/osi.c b/drivers/acpi/osi.c
> index 9f68538091384..d4405e1ca9b97 100644
> --- a/drivers/acpi/osi.c
> +++ b/drivers/acpi/osi.c
> @@ -44,30 +44,6 @@ osi_setup_entries[OSI_STRING_ENTRIES_MAX] __initdata = {
>  	{"Processor Device", true},
>  	{"3.0 _SCP Extensions", true},
>  	{"Processor Aggregator Device", true},
> -	/*
> -	 * Linux-Dell-Video is used by BIOS to disable RTD3 for NVidia graphics
> -	 * cards as RTD3 is not supported by drivers now.  Systems with NVidia
> -	 * cards will hang without RTD3 disabled.
> -	 *
> -	 * Once NVidia drivers officially support RTD3, this _OSI strings can
> -	 * be removed if both new and old graphics cards are supported.
> -	 */
> -	{"Linux-Dell-Video", true},
> -	/*
> -	 * Linux-Lenovo-NV-HDMI-Audio is used by BIOS to power on NVidia's HDMI
> -	 * audio device which is turned off for power-saving in Windows OS.
> -	 * This power management feature observed on some Lenovo Thinkpad
> -	 * systems which will not be able to output audio via HDMI without
> -	 * a BIOS workaround.
> -	 */
> -	{"Linux-Lenovo-NV-HDMI-Audio", true},
> -	/*
> -	 * Linux-HPI-Hybrid-Graphics is used by BIOS to enable dGPU to
> -	 * output video directly to external monitors on HP Inc. mobile
> -	 * workstations as Nvidia and AMD VGA drivers provide limited
> -	 * hybrid graphics supports.
> -	 */
> -	{"Linux-HPI-Hybrid-Graphics", true},
>  };
>  
>  static u32 acpi_osi_handler(acpi_string interface, u32 supported)

