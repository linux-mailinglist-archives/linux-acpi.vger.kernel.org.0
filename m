Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10F772D6139
	for <lists+linux-acpi@lfdr.de>; Thu, 10 Dec 2020 17:09:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392290AbgLJQIt (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 10 Dec 2020 11:08:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391064AbgLJQIk (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 10 Dec 2020 11:08:40 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAF09C0613CF
        for <linux-acpi@vger.kernel.org>; Thu, 10 Dec 2020 08:07:58 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id y23so5885727wmi.1
        for <linux-acpi@vger.kernel.org>; Thu, 10 Dec 2020 08:07:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=YiHCqmGvtiB3Z+JH3guRscAZzDaAzP469aDnVmAj2D4=;
        b=WngW5a7CyBhel3m/c8d1wQglgWDFwfPZE6GTNJFGJO7uBGp+AhCMZf0iBz56/r8UpD
         3rd8J7H5HS4NJoGP2MzD/kdn8d8lfT/VrvmY17WYLB6/tc2H2Rt3hgHrZRULrD3elCks
         NXSzTTYhNO0HFCelgS7SD+c+gc2y2EXrlinSwuL85kU/E6i2fOMH18wf5pnLjU0gjhbR
         +aj5MWbjRbJhA/Xag3VGMGdvPfT/WqGH9gXkafd96qofCZLGnloXboY6UXdQ95zEsWnl
         wKHa6dYXYhqsQtWUxWcPS9geecSlkgEfNBhzB2wtZBUhkVMVflWaa7aL90bBaOtyfqCd
         Nyng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=YiHCqmGvtiB3Z+JH3guRscAZzDaAzP469aDnVmAj2D4=;
        b=IFsfCf5R1maKxMVCFcGtJ/XQ5BexFGopfIkp41ItWw1Boi9hDy0DrAXQ1Rce+CFjxi
         CHJBqfHbWEe72JA/2HoMnFgcRXeltXWjf2uL+VTtPhbjb4PgFBu5rdK+HhaCPh1iqRyB
         ah6d8amcEEsgjxvIMaIjNLZoAdbBMy9RDm7nsOgitRjuqKZw6aEzvNlKHZAwS8FITozr
         vNi44zHyR3BR3YPE0JlxecfvNIkT/kbDCN+Xtp76V2ZvwrcytCIcUHcEE3jhlcAaMtJg
         GmXNWx4KOjc35qdrS547yV6t4AZ7aOcd1Ywv/XBueMowgVUD24LzAs32HTQxszofApcs
         1fjA==
X-Gm-Message-State: AOAM53165I7y1JJww2KtpYoRHorrcqHDqDPg0gh9DCyDZQM181wbaNHC
        HBz/+wAkfFxP9lnhKz/eoSbyrmvYIifQ3Q==
X-Google-Smtp-Source: ABdhPJwmS76klxgxK7T1SgXy4BCmTUtwOUsUDClk4J8JvuJo3lwjq1dsnasGvyAhT2NWQoHxswOMfw==
X-Received: by 2002:a1c:6689:: with SMTP id a131mr8937624wmc.33.1607616477663;
        Thu, 10 Dec 2020 08:07:57 -0800 (PST)
Received: from [192.168.1.211] ([2.29.208.56])
        by smtp.gmail.com with ESMTPSA id g11sm10088026wrq.7.2020.12.10.08.07.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Dec 2020 08:07:56 -0800 (PST)
Subject: Re: acpi_device_notify() binding devices that don't seem like they
 should be bound
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Kieran Bingham <kieran.bingham@ideasonboard.com>
References: <1409ba0c-1580-dc09-e6fe-a0c9bcda6462@gmail.com>
 <858bb2b0-e2b4-f0d4-0088-7106fec3cb8f@gmail.com>
 <9a9c176c-8991-cd12-d2da-34114a9d1aca@gmail.com>
 <CAJZ5v0gsAP1k2ej_5mgK5P_2rLn_GeMbjX9=-BG_die-6WmitA@mail.gmail.com>
 <529a22f7-52ba-f87d-f82b-8f94e1637ca9@gmail.com>
 <CAJZ5v0jy=WecHEQFzfu++uENWerHf5GqfwZMYNjQ2V=H7Geq8Q@mail.gmail.com>
 <7a2358bb-cd8c-83ec-51de-14947fc0e307@gmail.com>
 <CAJZ5v0hCcrX=EFjU6RfH-=twvrv3zzCorJPqOiKVuYGjsx403A@mail.gmail.com>
 <19c50e96-a102-add9-1812-85b8e7d62a0e@gmail.com>
 <CAJZ5v0inSq27Zpq=K4df=wypnSdyk5u1P-06wXiVG_vE2ZvDCQ@mail.gmail.com>
From:   Daniel Scally <djrscally@gmail.com>
Message-ID: <d3758b6a-7661-03b7-5a67-1fcb82253fb7@gmail.com>
Date:   Thu, 10 Dec 2020 16:07:56 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAJZ5v0inSq27Zpq=K4df=wypnSdyk5u1P-06wXiVG_vE2ZvDCQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org


On 10/12/2020 16:05, Rafael J. Wysocki wrote:
> All the adevs with matching _ADR also have both _STA and _HID
> unfortunately. Sorry; let me stop half-arsing this and show you
> something useful:
>
> [    0.219953] acpi_find_child_device(PNP0A08:00, 0x00, false)
> [    0.220818] INT3472:00: _STA 0x00, _ADR=0x00000000, _HID=INT3472
> [    0.220821] INT3472:01: _STA 0x00, _ADR=0x00000000, _HID=INT3472
> [    0.220870] INT3472:02: _STA 0x00, _ADR=0x00000000, _HID=INT3472
> [    0.220892] INT3472:03: _STA 0x00, _ADR=0x00000000, _HID=INT3472
> [    0.220916] INT3472:04: _STA 0x00, _ADR=0x00000000, _HID=INT3472
> [    0.220941] INT3472:05: _STA 0x00, _ADR=0x00000000, _HID=INT3472
> [    0.220965] INT3472:06: _STA 0x00, _ADR=0x00000000, _HID=INT3472
> [    0.220990] INT3472:07: _STA 0x00, _ADR=0x00000000, _HID=INT3472
> These will be ignored with -ENODEV.
>
>> [    0.221038] INT3472:08: _STA 0x0f, _ADR=0x00000000, _HID=INT3472
> For this acpi_find_child_device() will return FIND_CHILD_MIN_SCORE if
> I'm not mistaken.
It does - this is the one that binds, being the first.
>> [    0.221051] OVTI5648:00: _STA 0x0f, _ADR=0x00000000, _HID=OVTI5648
>> [    0.221061] INT3472:09: _STA 0x0f, _ADR=0x00000000, _HID=INT3472
>> [    0.221070] OVTI2680:00: _STA 0x0f, _ADR=0x00000000, _HID=OVTI2680
> As well as for the three above.
>
>> [    0.221079] INT3471:00: _STA 0x00, _ADR=0x00000000, _HID=INT3471
>> [    0.221105] INT33BE:00: _STA 0x00, _ADR=0x00000000, _HID=INT33BE
>> [    0.221130] INT3471:01: _STA 0x00, _ADR=0x00000000, _HID=INT3471
>> [    0.221156] INT33BE:01: _STA 0x00, _ADR=0x00000000, _HID=INT33BE
> And the rest will be ignored.
>
>> That's the debug output I included for each adev that's assessed as a
>> child of PNP0A08:00. _STA, _ADR and _HID present for all, _ADR 0x00 for
>> all, _STA 0x0f for the 2 sensors and their PMIC's and 0x00 for the rest.
>> The same situation holds on both of my devices.
> So in fact we don't want to have an ACPI companion for (PNP0A08:00,
> 0x00, false).
Yeah, I think that's right
> This is a hostbridge special case and let me think about this for a while.
Sure - thanks very much for your help.
