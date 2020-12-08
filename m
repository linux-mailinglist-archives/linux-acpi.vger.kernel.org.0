Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 571E52D273B
	for <lists+linux-acpi@lfdr.de>; Tue,  8 Dec 2020 10:14:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728669AbgLHJMw (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 8 Dec 2020 04:12:52 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:46297 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726418AbgLHJMv (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 8 Dec 2020 04:12:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1607418685;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5Ad9dVIz2TEPmfPmKHjiScQxj4MpEXhAMwys+bMreiU=;
        b=UePwd1DPULy8qHaIENqeuUxEK4HPLWWoRNqniAWfPSj8KSzm/FMNlH5MI+l10yhHVeC0kO
        gbZ5gFLsq+em7OTa5am77hxoxPg4onLQ5NMNhLhJr40stEwmQB9p6EZZiKOG7tNTaM2nPO
        CLCpqjOMoysTY+Yj5YVZE3MFuhymgkk=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-80-4kaxoUPDPuWKA3ohAvtdxQ-1; Tue, 08 Dec 2020 04:11:23 -0500
X-MC-Unique: 4kaxoUPDPuWKA3ohAvtdxQ-1
Received: by mail-ej1-f71.google.com with SMTP id m4so1867581ejc.14
        for <linux-acpi@vger.kernel.org>; Tue, 08 Dec 2020 01:11:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=5Ad9dVIz2TEPmfPmKHjiScQxj4MpEXhAMwys+bMreiU=;
        b=Ns8TGPq727MBN9utYKH4NDVt5Y606d38Fp9cWigA/p8gdGj2xpRQfmDfLnJnsd6k5y
         DwuGjZdFfNvVrqPLivhLKy+gnXFzwqZ/PBWkvD34NjE52aiurF6YLrwFvziSbKWFCXAf
         w9a+kJFKRtiz0tBpWpWc3pT5t7zy+N+W1K+Fe92PUI0HxU6o3+9Ynf+aq1X3kQeIq/pi
         PadfajaYfrK+6vd10kHtxtcEM8UVta2qaXxxP4J2gwpAa0+NBah8AbqIDiPH2rs5dgKC
         mtn8gcJK/ppLx8MzCktlMBdhtBKyTRYyuzyDDAaXGW8DSsrZlWGsQJG8aiPkcvQqbrCn
         sRyw==
X-Gm-Message-State: AOAM532OIgJRxuw8Wu6loHzuhIZn1Li8r7Qq1J+B5s46TSbTXOFp9xqD
        v0tvASR9c9XkDYlpnoKNTRnljriwMeM9I6lpLxKvl5FTui2QikUlVnAU5Vuhqo6E4PoXPkmjEFg
        whd7fOskEyOuAf9vfPrFkhA==
X-Received: by 2002:a17:906:1194:: with SMTP id n20mr22002836eja.269.1607418682098;
        Tue, 08 Dec 2020 01:11:22 -0800 (PST)
X-Google-Smtp-Source: ABdhPJw790b+pkpX7nw4XPxUqBpja8l3M/T+KRTl5nj0rMBa8xD00oQ4kISlVGPU4VL//BKIPAAapw==
X-Received: by 2002:a17:906:1194:: with SMTP id n20mr22002831eja.269.1607418681943;
        Tue, 08 Dec 2020 01:11:21 -0800 (PST)
Received: from x1.localdomain (2001-1c00-0c0c-fe00-d2ea-f29d-118b-24dc.cable.dynamic.v6.ziggo.nl. [2001:1c00:c0c:fe00:d2ea:f29d:118b:24dc])
        by smtp.gmail.com with ESMTPSA id rl7sm13740822ejb.107.2020.12.08.01.11.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Dec 2020 01:11:21 -0800 (PST)
Subject: Re: [PATCH v5 1/3] Documentation: Add documentation for new
 platform_profile sysfs attribute
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Mark Pearson <markpearson@lenovo.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Mark Gross <mgross@linux.intel.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Bastien Nocera <hadess@hadess.net>,
        =?UTF-8?Q?Barnab=c3=a1s_P=c5=91cze?= <pobrn@protonmail.com>,
        Mario Limonciello <mario.limonciello@dell.com>,
        Elia Devito <eliadevito@gmail.com>,
        Benjamin Berg <bberg@redhat.com>,
        Darren Hart <dvhart@infradead.org>
References: <markpearson@lenovo.com>
 <20201202171120.65269-1-markpearson@lenovo.com>
 <74b6ef2c-ac13-bffe-edda-478512950d22@redhat.com>
 <CAJZ5v0iWD5Ej-1oCfMAskvQoovMRVc5TkpST1t9brsJirx+5zQ@mail.gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <ecc70307-aca0-16f8-26b3-4360c61f752b@redhat.com>
Date:   Tue, 8 Dec 2020 10:11:20 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <CAJZ5v0iWD5Ej-1oCfMAskvQoovMRVc5TkpST1t9brsJirx+5zQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi,

On 12/7/20 8:29 PM, Rafael J. Wysocki wrote:
> On Thu, Dec 3, 2020 at 10:46 AM Hans de Goede <hdegoede@redhat.com> wrote:
>>
>> Hi,
>>
>> On 12/2/20 6:11 PM, Mark Pearson wrote:
>>> On modern systems the platform performance, temperature, fan and other
>>> hardware related characteristics are often dynamically configurable. The
>>> profile is often automatically adjusted to the load by some
>>> automatic-mechanism (which may very well live outside the kernel).
>>>
>>> These auto platform-adjustment mechanisms often can be configured with
>>> one of several 'platform-profiles', with either a bias towards low-power
>>> consumption or towards performance (and higher power consumption and
>>> thermals).
>>>
>>> Introduce a new platform_profile sysfs API which offers a generic API for
>>> selecting the performance-profile of these automatic-mechanisms.
>>>
>>> Co-developed-by: Mark Pearson <markpearson@lenovo.com>
>>> Signed-off-by: Mark Pearson <markpearson@lenovo.com>
>>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>>
>> Thank you, patches 1 and 2 look good to me now, you may add my:
>>
>> Reviewed-by: Hans de Goede <hdegoede@redhat.com>
>>
>> To patch 2 (since I'm co-author of patch 1 it would be a bit weird
>> to add it there too).
>>
>> Rafael, it would be great if you pick up patches 1 and 2 for merging
>> into 5.11 (assuming that you agree that they are ready) then I will merge
>> patch 3 once 5.11-rc1 is out.
> 
> I've applied patch [1/2] (as 5.11-rc material) for now, but I still
> needed to fix it up somewhat.  Please check the result in my
> bleeding-edge branch.

Thank you.

> I'll get to the other patch tomorrow.

The other patch likely conflicts with a bunch of other thinkpad_acpi
changes already in pdx86/for-next; and I still need to review v5 of
it, so please do not apply it.

I will pick it up after 5.11-rc1 and send it out as part of a
pull-req for rc2.

Regards,

Hans

