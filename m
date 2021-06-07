Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03F8A39D8FE
	for <lists+linux-acpi@lfdr.de>; Mon,  7 Jun 2021 11:43:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230175AbhFGJpp (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 7 Jun 2021 05:45:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:57396 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230173AbhFGJpp (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 7 Jun 2021 05:45:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623059034;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oMfAGEnB3KnX6OzBZtXRf2dooxSH3S2O+uOI4xMgprM=;
        b=HE6nI7sVCkI82rYvgwYZdZOZ+3ocfEpcDrPGyDAXyuF6b7vUsfSGxDF87pK9nu2sjb0AvO
        S19Ye/myLYLTSEU97DBNNaVyEkJPfa+6eq2pcOJLwhHxaSHOQSqgcFqpIVSZ/pnDXymTTV
        QMgrQBHXda/b9Ho+vWJknu6HqorCcdU=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-539-afBl_Y4tOJiD2Ew40xnGaQ-1; Mon, 07 Jun 2021 05:43:52 -0400
X-MC-Unique: afBl_Y4tOJiD2Ew40xnGaQ-1
Received: by mail-ej1-f69.google.com with SMTP id a25-20020a1709064a59b0290411db435a1eso1139577ejv.11
        for <linux-acpi@vger.kernel.org>; Mon, 07 Jun 2021 02:43:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=oMfAGEnB3KnX6OzBZtXRf2dooxSH3S2O+uOI4xMgprM=;
        b=B/pgj2wLc0did53U1VprxgM9Pint0bhWtk0yXFlKCBDjog1D51Mu+deDot4KJmN5yK
         lNj78spPYs7t3Rgk4c85wgbBDTeu65w41kwklCGiuJ9qJpGvZzRjZess2NybwxBQ4m6e
         QY5RO46nLPpGVoqr5wnoi7uNhi7SC8oqtO2U46zX+y+7VYGe31D8JrPca7BWIQ7aeLKv
         ikseSfj8n2nbMS1rvAz2rP3wblIvFJznVCoYAcp84jB4cD/VgfKP25FCaFxHoXKoLXMm
         0qANgTokkLajNdDzuXKCzeL3W8CeA+5m4ArAJz7oJjpKFw/HQjM9MQOrFCCqsHgFo67K
         MS5Q==
X-Gm-Message-State: AOAM530uVE66qMV9WTwnV5BL2YZbsUpQ9Xb1UcM/9O8Q8+UMm6VaC8mb
        m5MRSwSJVmZRjiYmlaf508ibny5ybvK5+16JsVx6IXQLzJ+C76tq4HKtk93s4+DiBNSPCK301sm
        hmx6sat0QEXpZVm6770b77JR069GbKLTgkIq71k5ryAqqrfKrQkH6nIQAvzjAPwWSdPfB/56FxA
        ==
X-Received: by 2002:aa7:dc4f:: with SMTP id g15mr18696874edu.277.1623059031417;
        Mon, 07 Jun 2021 02:43:51 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJymb6GrL/q67AgTGfPDxm6jp1Hk4r6ehQUPpwhCNBVBVIW29Jf01BEKgd9v+pt0AYRomQd7kg==
X-Received: by 2002:aa7:dc4f:: with SMTP id g15mr18696861edu.277.1623059031221;
        Mon, 07 Jun 2021 02:43:51 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id f26sm7415789edu.31.2021.06.07.02.43.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Jun 2021 02:43:50 -0700 (PDT)
Subject: Re: Some SSDT tables are not loading with kernel >= 5.12
From:   Hans de Goede <hdegoede@redhat.com>
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>
Cc:     linux-acpi <linux-acpi@vger.kernel.org>
References: <f634a05a-e3a9-93ab-4b87-d41f5ee083a5@redhat.com>
Message-ID: <93d783c4-4468-023b-193e-3fc6eca35445@redhat.com>
Date:   Mon, 7 Jun 2021 11:43:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <f634a05a-e3a9-93ab-4b87-d41f5ee083a5@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi,

On 6/3/21 7:26 PM, Hans de Goede wrote:
> Hi Rafael,
> 
> I've been helping some users with trying to get to the bottom of some
> new ACPI errors with kernel 5.12, see:
> 
> https://bugzilla.kernel.org/show_bug.cgi?id=213023
> 
> After looking at dmesg output; and after editing the dmesg output
> a bit so that I could do diff -u on it, the following stands out:
> 
> --- dmesg_5.10.38-1-lts	2021-06-03 16:29:41.372922210 +0200
> +++ dmesg_linux-5.12.5-arch1-1	2021-06-03 16:30:01.013031634 +0200
> @@ -92,7 +92,7 @@
>  ACPI: IRQ9 used by override.
>  Using ACPI (MADT) for SMP configuration information
>  ACPI: HPET id: 0x8086a201 base: 0xfed00000
> -ACPI: Core revision 20200925
> +ACPI: Core revision 20210105
>  PM: Registering ACPI NVS region [mem 0x7156c000-0x7156cfff] (4096 bytes)
>  PM: Registering ACPI NVS region [mem 0x8a88f000-0x8af7efff] (7274496 bytes)
>  ACPI FADT declares the system doesn't support PCIe ASPM, so disable it
> @@ -113,10 +113,6 @@
>  ACPI: Dynamic OEM Table Load:
>  ACPI: SSDT 0xFFFF... 0003FF (v02 PmRef  Cpu0Cst  00003001 INTL 20160527)
>  ACPI: Dynamic OEM Table Load:
> -ACPI: SSDT 0xFFFF... 0000BA (v02 PmRef  Cpu0Hwp  00003000 INTL 20160527)
> -ACPI: Dynamic OEM Table Load:
> -ACPI: SSDT 0xFFFF... 000628 (v02 PmRef  HwpLvt   00003000 INTL 20160527)
> -ACPI: Dynamic OEM Table Load:
>  ACPI: SSDT 0xFFFF... 000D14 (v02 PmRef  ApIst    00003000 INTL 20160527)
>  ACPI: Dynamic OEM Table Load:
>  ACPI: SSDT 0xFFFF... 000317 (v02 PmRef  ApHwp    00003000 INTL 20160527)
> 
> Note how for some reason the kernel is no longer loading the Cpu0Hwp and
> HwpLvt SSDT-s ?
> 
> Do you have any ideas what might be causing this ?

Good news, a very similar bug is being tracked here:

https://bugzilla.redhat.com/show_bug.cgi?id=1963717

And one of the reporters there has done a git bisect and has found the commit which is causing the problem for them:

"""
git-bisect points to 719e1f561afbe020ed175825a9bd25ed62ed1697 :
"ACPI: Execute platform _OSC also with query bit clear".

Tested 5.12.9 kernel with the commit reverted, and confirmed that the error
messages are gone. (I had to revert
5a6a2c0f0f43676df27632d657a3f18b151a7ef8 for dependency too.)

It also brings back the /sys/devices/system/cpu/cpu0/acpi_cppc which is absent
in the stable 5.12.x

Hope this helps
"""

I've asked the reporters of:
https://bugzilla.kernel.org/show_bug.cgi?id=213023

To also try reverting 719e1f561afbe020ed175825a9bd25ed62ed1697 and see if that
helps (I expect it will, I believe the 2 bugs are the same issue).

Either way we need to do something about this to fix this for the reporter of
https://bugzilla.redhat.com/show_bug.cgi?id=1963717

Any ideas on how to fix this?

Regards,

Hans

