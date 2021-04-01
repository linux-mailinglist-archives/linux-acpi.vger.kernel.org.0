Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 546A83510C3
	for <lists+linux-acpi@lfdr.de>; Thu,  1 Apr 2021 10:22:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229612AbhDAIVf (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 1 Apr 2021 04:21:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:39954 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230291AbhDAIVJ (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 1 Apr 2021 04:21:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1617265269;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0MM1VR6/A5jTsbab6p2eQODlayvRnz6tiru7uoQ/VlI=;
        b=I+hP9spf9wxULMB6JXlJry/7/NrvceT4+cryToCaUjOP4/ezrlVwqJVr8C9R4UsoRJFpMh
        pvrZpIh1bP7z0IZSAJPLEG7WSmYQ8hIYzVWIYbGF5pHjFwWOtPjpromDK5j/Is/5Hpqc5s
        Vbn7ln04JwZE0mea4sowIQwBEZf6I4U=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-555-v28yqaGkPACk_uAhw2yuWA-1; Thu, 01 Apr 2021 04:21:07 -0400
X-MC-Unique: v28yqaGkPACk_uAhw2yuWA-1
Received: by mail-ed1-f71.google.com with SMTP id cq11so2455709edb.14
        for <linux-acpi@vger.kernel.org>; Thu, 01 Apr 2021 01:21:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=0MM1VR6/A5jTsbab6p2eQODlayvRnz6tiru7uoQ/VlI=;
        b=CPbEWkbOjFtQ/G0A1i7GiDOG/H00zSUwTXAQ+6okIo2QVBpD7Gf/vP6SHr4cS7v1tY
         1XSndAV8q4FMA4Ad3rte8Y/u6d9TnNEOEGMWJfWAUnu7TvkK5kYzBUWdcqW8tALcj0kH
         MTJyjUxzV2JGp5bcJiJsAl7568Zz7Wj8lLvFKWduVH4ZZb4P5cRgoZuKj8qFh3DdZl2B
         GCpMWYE0F42NxGbKx8CRkwK/76fQO1iZg87gxRmsavNexz8rXLSz/6pk8rfxPxbOEjla
         FUwJZoIGKB6zOX8Q2B40x5t3xWLs7/Me5ieR9tgUE1fDPFbxbwBGVKy1isK2h92IN2Cd
         6rIQ==
X-Gm-Message-State: AOAM533/avgx/Opas69u/PPHoZGrqPKX0dE8fbBUZ25BoTV/8eJuwBBo
        hT45kylJWo9RRMg7+NFvtMBeOstwWL8TqS4h8Nmmj9w0maq0XrZCHt6JgVbQHcj6B1Bpnw///cH
        y+Fmay3JOPaOmLaI7s5viow==
X-Received: by 2002:a50:ee10:: with SMTP id g16mr8367961eds.215.1617265266054;
        Thu, 01 Apr 2021 01:21:06 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwQd6v8W1tiSUNXdFnYdiBd5A2Pnx2X951i2gw6YNvs3Bp5MzyFCqdP4jJQZr0cvQIcMrEYjw==
X-Received: by 2002:a50:ee10:: with SMTP id g16mr8367945eds.215.1617265265929;
        Thu, 01 Apr 2021 01:21:05 -0700 (PDT)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id gn19sm2352669ejc.4.2021.04.01.01.21.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Apr 2021 01:21:05 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Shixin Liu <liushixin2@huawei.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shixin Liu <liushixin2@huawei.com>, Len Brown <lenb@kernel.org>
Subject: Re: [PATCH -next] ACPI: processor: Fix a prepocessor warning
In-Reply-To: <20210401023900.3114325-1-liushixin2@huawei.com>
References: <20210401023900.3114325-1-liushixin2@huawei.com>
Date:   Thu, 01 Apr 2021 10:21:04 +0200
Message-ID: <87pmzes9e7.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Shixin Liu <liushixin2@huawei.com> writes:

> When compiling with defconfig on x86_64, I got a warning:
>
> drivers/acpi/processor_idle.c: In function =E2=80=98acpi_idle_play_dead=
=E2=80=99:
> drivers/acpi/processor_idle.c:542:15: warning: extra tokens at end of #if=
def directive
>   542 | #ifdef defined(CONFIG_X86) && defined(CONFIG_HOTPLUG_CPU)
>       |
>
> Fixes: bc5706eaeae0 ("ACPI: processor: Fix CPU0 wakeup in acpi_idle_play_=
dead()")
> Signed-off-by: Shixin Liu <liushixin2@huawei.com>
> ---
>  drivers/acpi/processor_idle.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.c
> index 19fb28a8005b..0925b1477230 100644
> --- a/drivers/acpi/processor_idle.c
> +++ b/drivers/acpi/processor_idle.c
> @@ -539,7 +539,7 @@ static int acpi_idle_play_dead(struct cpuidle_device =
*dev, int index)
>  		} else
>  			return -ENODEV;
>=20=20
> -#ifdef defined(CONFIG_X86) && defined(CONFIG_HOTPLUG_CPU)
> +#if defined(CONFIG_X86) && defined(CONFIG_HOTPLUG_CPU)
>  		/* If NMI wants to wake up CPU0, start CPU0. */
>  		if (wakeup_cpu0())
>  			start_cpu0();

Thank you for the patch,

this was already reported by Stephen Rothwell and I suggested Rafael the
exact same fix:

https://lore.kernel.org/lkml/87czvfu9j5.fsf@vitty.brq.redhat.com/

It would probably be better if we fold the fix in (if stil possible).

--=20
Vitaly

