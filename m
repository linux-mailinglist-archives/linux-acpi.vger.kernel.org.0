Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CC4B2D28E8
	for <lists+linux-acpi@lfdr.de>; Tue,  8 Dec 2020 11:30:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727796AbgLHKaF (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 8 Dec 2020 05:30:05 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:55595 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726703AbgLHKaF (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 8 Dec 2020 05:30:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1607423318;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=D0hbAKmNYG/q9vSOqKgP25eUntBrtBgiqHG+0m2qSNM=;
        b=fsPVdXhOmZ8N4R26svprHg03TvlhgrXPj/xGEfVSgXiCzr8rqvNAlaa49jhfh1qBap5/0S
        u3YUuuFd/W3MR4QLB9bO5JzXay5uGL8V3nIvsnskkoywfZ4bOW/jXaGhxyefLXqu9ue4b2
        QFxxZA4H9An9Hbw8Q0wUZ4/BjNIedPM=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-195-vBTwC1xqOQ6NdtMnTjoXXg-1; Tue, 08 Dec 2020 05:28:36 -0500
X-MC-Unique: vBTwC1xqOQ6NdtMnTjoXXg-1
Received: by mail-ed1-f71.google.com with SMTP id z20so7164544edl.21
        for <linux-acpi@vger.kernel.org>; Tue, 08 Dec 2020 02:28:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=D0hbAKmNYG/q9vSOqKgP25eUntBrtBgiqHG+0m2qSNM=;
        b=ekXwYT6xN2YamOFd1EtCCtm9Z8ClGNpq45iVFvjOtk+gL/v7sMHWZmpVNcaOOZlT19
         Kak313EB9/NFfMvkmkZFqihdYJA9zSAeJQelLRVZRlxCZYGK9V8DdsAsearLrH42ZDgk
         l89UeppaP7Xa1x28lsWhZKg0+2BhBuk8WK7JPlmN9+zJ/yqakpFMOBBM768d8v7icVW6
         3BLOVZ9UO9cqlq5R+8nN1oqqZcdQonYnhnrGxxMLqGNg5GdyjO2aJ/lCXKqloQff+Ph0
         4CPHjDULT0NcERK2yzqeqGk0OSASJo6wbzyCg0TEuz1nsvXsf3mhLSe1I7pZaeItPnpD
         r9Cg==
X-Gm-Message-State: AOAM532hnBKqQYnZRQ6cUdTCKFC0MhTHEiZJL91saYwPOqkTB0TA7gTg
        tZtNnDr+OUzMrYZqbXCnmA+E3cZCJ4HOY2LpMxuKJ+Q/jae7DS8DALMwle72+gcerCNphhabJZM
        wKgHVbcCXzK6DX9A9ozz/+Q==
X-Received: by 2002:a50:becf:: with SMTP id e15mr18640515edk.138.1607423315362;
        Tue, 08 Dec 2020 02:28:35 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyY4dHEwS89soeujMJW3kd78MwruhEyZKVWG5BWZVLlNVEvwkTrr/M0BCIXk1Rs+Snnr91sqA==
X-Received: by 2002:a50:becf:: with SMTP id e15mr18640506edk.138.1607423315179;
        Tue, 08 Dec 2020 02:28:35 -0800 (PST)
Received: from x1.localdomain (2001-1c00-0c0c-fe00-d2ea-f29d-118b-24dc.cable.dynamic.v6.ziggo.nl. [2001:1c00:c0c:fe00:d2ea:f29d:118b:24dc])
        by smtp.gmail.com with ESMTPSA id j7sm17150087edp.52.2020.12.08.02.28.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Dec 2020 02:28:34 -0800 (PST)
Subject: Re: [PATCH v5 1/3] Documentation: Add documentation for new
 platform_profile sysfs attribute
From:   Hans de Goede <hdegoede@redhat.com>
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
 <ecc70307-aca0-16f8-26b3-4360c61f752b@redhat.com>
Message-ID: <e4cd6704-0b46-36de-ce95-5e18d26bfe9f@redhat.com>
Date:   Tue, 8 Dec 2020 11:28:33 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <ecc70307-aca0-16f8-26b3-4360c61f752b@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi,

On 12/8/20 10:11 AM, Hans de Goede wrote:
> Hi,
> 
> On 12/7/20 8:29 PM, Rafael J. Wysocki wrote:
>> On Thu, Dec 3, 2020 at 10:46 AM Hans de Goede <hdegoede@redhat.com> wrote:
>>>
>>> Hi,
>>>
>>> On 12/2/20 6:11 PM, Mark Pearson wrote:
>>>> On modern systems the platform performance, temperature, fan and other
>>>> hardware related characteristics are often dynamically configurable. The
>>>> profile is often automatically adjusted to the load by some
>>>> automatic-mechanism (which may very well live outside the kernel).
>>>>
>>>> These auto platform-adjustment mechanisms often can be configured with
>>>> one of several 'platform-profiles', with either a bias towards low-power
>>>> consumption or towards performance (and higher power consumption and
>>>> thermals).
>>>>
>>>> Introduce a new platform_profile sysfs API which offers a generic API for
>>>> selecting the performance-profile of these automatic-mechanisms.
>>>>
>>>> Co-developed-by: Mark Pearson <markpearson@lenovo.com>
>>>> Signed-off-by: Mark Pearson <markpearson@lenovo.com>
>>>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>>>
>>> Thank you, patches 1 and 2 look good to me now, you may add my:
>>>
>>> Reviewed-by: Hans de Goede <hdegoede@redhat.com>
>>>
>>> To patch 2 (since I'm co-author of patch 1 it would be a bit weird
>>> to add it there too).
>>>
>>> Rafael, it would be great if you pick up patches 1 and 2 for merging
>>> into 5.11 (assuming that you agree that they are ready) then I will merge
>>> patch 3 once 5.11-rc1 is out.
>>
>> I've applied patch [1/2] (as 5.11-rc material) for now, but I still
>> needed to fix it up somewhat.  Please check the result in my
>> bleeding-edge branch.
> 
> Thank you.
> 
>> I'll get to the other patch tomorrow.
> 
> The other patch likely conflicts with a bunch of other thinkpad_acpi
> changes already in pdx86/for-next; and I still need to review v5 of
> it, so please do not apply it.
> 
> I will pick it up after 5.11-rc1 and send it out as part of a
> pull-req for rc2.

Sorry I misread what you wrote, when you said you "applied patch [1/2]",
I now see that you have only merged:

"[PATCH v5 1/3] Documentation: Add documentation for new platform_profile sysfs attribute"

And that the other patch which you intend to merge is not the
thinkpad_acpi patch but:

"[PATCH v5 2/3] ACPI: platform-profile: Add platform profile support"

So please ignore what I said before.

###

I checked out the fixed up version of:
"[PATCH v5 1/3] Documentation: Add documentation for new platform_profile sysfs attribute"

Which you merged and it looks good to me, thanks.

Regards,

Hans

