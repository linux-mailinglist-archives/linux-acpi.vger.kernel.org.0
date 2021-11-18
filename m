Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B3244559F9
	for <lists+linux-acpi@lfdr.de>; Thu, 18 Nov 2021 12:17:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343830AbhKRLUK (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 18 Nov 2021 06:20:10 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:57040 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1344091AbhKRLSc (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 18 Nov 2021 06:18:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1637234132;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tLL+SXRUQtHOYzxbBR3+E0gRNLnRI75C+gDiy6tjAt8=;
        b=hrSgJCLKrJKdfBVPh4mUWlkwE118qWBtfaeZiFsRdLareT8eVkdXKXoTIsLbDd4IW1Ko1E
        C8fyWATPqJzRMR3tfT7v98uwVtWzsDutQWKrOrk4u2Y30wRkjA3hYpzcuEGe5K2G6ehA/J
        iBsv6YIbCuDrouJsKHGHdC9eX0NWyPw=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-421-AmOeLMSMPR-T1Jaf11mPWQ-1; Thu, 18 Nov 2021 06:15:31 -0500
X-MC-Unique: AmOeLMSMPR-T1Jaf11mPWQ-1
Received: by mail-ed1-f69.google.com with SMTP id f4-20020a50e084000000b003db585bc274so4937250edl.17
        for <linux-acpi@vger.kernel.org>; Thu, 18 Nov 2021 03:15:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=tLL+SXRUQtHOYzxbBR3+E0gRNLnRI75C+gDiy6tjAt8=;
        b=nFFMw6/JXeTd4JCGNmqePZt3iB53VZeG0d5rdJq5EguEhJP6DPRnOTRLwKDqHvb+tF
         AvTywH7BnRyhlXpFUtyhjxWXdm3CZUpr6Xc503NtrRJmwte8A8sPo4I+qPMU7azQYd6m
         jARd1qHnxeqDSCLoSo1KDEdNYf+hceLV4EWuTwkocGBjx+DHihUix42czsOFX9BqOCLu
         Zuhae1q4K+aa2E0cd2Ywfx9iRnbItYuAml0tisko5NiZ5MwAy/dGN0g9jNkpILHZ5PI7
         jWl+HW5wgzUjFDUI8kJ8qgqRYOSK9s/dFyNudGcmr0ONuAmxm7mYeEOEkcnfqUpDX0mc
         alpQ==
X-Gm-Message-State: AOAM531raQVpELD86CtB9ShqV3PRHNT9A4bQm76xOLck/s6Ra6Z897XG
        VK8xOQsuQfLeRdReIYczVSo5Eov8IYlalJ5BOB6B24YTNjwO1l3bWIuqXHtFTCsyg+5u0SSWeca
        p5nSgIJgIZ22H/tp1/s5Y1A==
X-Received: by 2002:a05:6402:1e92:: with SMTP id f18mr9950644edf.153.1637234129760;
        Thu, 18 Nov 2021 03:15:29 -0800 (PST)
X-Google-Smtp-Source: ABdhPJz5/BQkcvD/uZZZVRUuLcyQyQ3pCqJV0hnk93SdCb0dVL3YaH/L93PMB3108ej+wxX65snoNw==
X-Received: by 2002:a05:6402:1e92:: with SMTP id f18mr9950618edf.153.1637234129565;
        Thu, 18 Nov 2021 03:15:29 -0800 (PST)
Received: from ?IPV6:2001:1c00:c1e:bf00:1054:9d19:e0f0:8214? (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id p10sm1378086edj.91.2021.11.18.03.15.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Nov 2021 03:15:29 -0800 (PST)
Message-ID: <937cf1fd-0cb1-1a12-7745-8cc2a2e3405a@redhat.com>
Date:   Thu, 18 Nov 2021 12:15:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH 5.16 regression fix 0/5] ACPI: scan: Skip turning off some
 unused objects during scan
Content-Language: en-US
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Len Brown <lenb@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        linux-mmc <linux-mmc@vger.kernel.org>
References: <20211117220118.408953-1-hdegoede@redhat.com>
 <CAJZ5v0hDWN4cKh+ZcB__wrWHChm=FjhwvCShXzseECQOFotM6w@mail.gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <CAJZ5v0hDWN4cKh+ZcB__wrWHChm=FjhwvCShXzseECQOFotM6w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi,

On 11/18/21 12:08, Rafael J. Wysocki wrote:
> On Wed, Nov 17, 2021 at 11:01 PM Hans de Goede <hdegoede@redhat.com> wrote:
>>
>> Hi Rafael,
>>
>> Commit c10383e8ddf4 ("ACPI: scan: Release PM resources blocked by
>> unused objects") adds a:
>>
>>         bus_for_each_dev(&acpi_bus_type, NULL, NULL, acpi_dev_turn_off_if_unused);
>>
>> call to acpi_scan_init(). On some devices with buggy DSDTs calling
>> _PS3 for one device may result in it turning off another device.
> 
> Well, I'm going to revert this commit.  I'm sending a pull request
> with the revert later today.
> 
>> Specifically the DSDT of the GPD win and GPD pocket devices has a
>> "\\_SB_.PCI0.SDHB.BRC1" device for a non existing SDIO wifi module
>> which _PS3 method sets a GPIO causing the PCI wifi card to turn off.
>>
>> I've an earlier, in some ways simpler, fix for this here:
>> https://fedorapeople.org/~jwrdegoede/0001-ACPI-scan-Skip-turning-off-some-unused-objects-durin.patch
>>
>> But the sdhci-acpi.c MMC host code already has an older workaround
>> for it to not toggle power on this broken ACPI object; and this
>> simpler fix would require keeping that workaround. So then we would
>> have 2 workarounds for the same issue in the kernel.
>>
>> Thus instead I've come up with a slightly different approach which
>> IMHO has ended up pretty well.
>>
>> Patches 1-3 of this series are this different approach and assuming
>> they are considered ok must be merged into 5.16 to fix the regression
>> caused by commit c10383e8ddf4 on these devices.
> 
> So I'll have a look at these and if they look good, we can do that
> instead of the problematic commit in 5.17.

I'm a bit confused now, if the problematic commit is going to get
reversed then technically we don't need this series anymore ?

Or are you planning on re-introducing it in some form for 5.17 ?

With that said getting this series merged would still be good,
patch 1 + 2 make the existing always_present quirk code more generic
which might be useful later. And then patch 3 (which is small)
allows dropping some ugliness from the sdhci-acpi.c code since
the DSDT bug we are hitting will now be solved by the
new acpi-dev-status-override mechanism.

Regards,

Hans

