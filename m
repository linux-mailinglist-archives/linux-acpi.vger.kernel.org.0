Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96EC53DA1E0
	for <lists+linux-acpi@lfdr.de>; Thu, 29 Jul 2021 13:14:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236669AbhG2LO6 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 29 Jul 2021 07:14:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:31148 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236244AbhG2LO6 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 29 Jul 2021 07:14:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1627557294;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zddsjIu0dWD/zBHYUlwQGei6rq9GfZwXJkwTqXkgrBc=;
        b=bggmLgB2Piunh26v0eGOaC4K1fFzZ7dvqTilEHE5Nq1kb1CaCKLPwEXjgZLpIGXfTk2VCw
        tVU2tczV1PTMApE6u9pP4l8HMSiOi0ur+0HeTO0mgj+b8xEQ2jMPyT3Mmn0/NwtFlDhjG0
        j5TohJmmjopHe6DpqhbbjY06WCVAtCs=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-370-JxyjXrh0MY-hRrrHIqCcuQ-1; Thu, 29 Jul 2021 07:14:53 -0400
X-MC-Unique: JxyjXrh0MY-hRrrHIqCcuQ-1
Received: by mail-ed1-f71.google.com with SMTP id c20-20020a0564021014b029039994f9cab9so1326901edu.22
        for <linux-acpi@vger.kernel.org>; Thu, 29 Jul 2021 04:14:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=zddsjIu0dWD/zBHYUlwQGei6rq9GfZwXJkwTqXkgrBc=;
        b=M8CNBEGaj4NZBPAgaBtx9qvMZf/sltSSPtCmdRD1aVmxWAYMEETMev+RgyQI48kgvl
         tUEwpGC99WAIj9AgAP/ZocDlvjv9t88tog6G+oxHrRAbb7IY3CfiifmS6i2zqNPLH/oD
         ArBceOUKS9imHaU3O0apRWn+qA6ew37r7r88m2LzXSMdC109qfNkIT/yTtqaaaQ+ZdoQ
         r0sEVnhYffcN/P0kpcMOVIiKhsZk8N7EpLQl2mnQmK0tsLlom65L7vzUE3hGWl/KVYGN
         eA9EhcM9X+Zoraq+lig5u4TDSdVEUvH8OYeoZITvpzsRlatrVgI8+yr+75JYiH/d4gZe
         sxZA==
X-Gm-Message-State: AOAM532hpYe1AmHzuK0VtXR6p5/FqlLCuDwi4xriYqKTx6sQgCG0Slop
        eQlAvX5RIlALwWhIpjFQDGLX1adVZlqWG59tgTvqKfSrPatJhFxJqigVt+Cdot9TJzUXHl4fF4s
        bT8F+sIpt3xuU4+Jw6XD1mA==
X-Received: by 2002:a17:907:3f9a:: with SMTP id hr26mr4155799ejc.110.1627557291965;
        Thu, 29 Jul 2021 04:14:51 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyh6/UAmcpC1SzCmUrQ6YUOFMFK5NQwX4HGs0UJJtJ8aLT2g3TQh+Dcyixf6mHMxqTaSarLlw==
X-Received: by 2002:a17:907:3f9a:: with SMTP id hr26mr4155784ejc.110.1627557291790;
        Thu, 29 Jul 2021 04:14:51 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id o14sm1069481eds.55.2021.07.29.04.14.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Jul 2021 04:14:51 -0700 (PDT)
Subject: Re: [PATCH] platform/x86: Add and use a dual_accel_detect() helper
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Mark Gross <mgross@linux.intel.com>,
        Andy Shevchenko <andy@infradead.org>,
        Henrique de Moraes Holschuh <hmh@hmh.eng.br>,
        Mark Pearson <markpearson@lenovo.com>,
        Thinkpad-acpi devel ML <ibm-acpi-devel@lists.sourceforge.net>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Julius Lehmann <julius@devpi.de>
References: <20210729082134.6683-1-hdegoede@redhat.com>
 <CAHp75VepyNqwLSDaDmc+XCk+_gC5+zGUQ51DOo7KUt2-Gaty-Q@mail.gmail.com>
 <7e6402dd-ec83-5014-8165-95e45cd3169f@redhat.com>
 <CAHp75VeeN7KYifZ7K82CKmj4QKexAu2cK1pqXaj_coMPO4Q8ZQ@mail.gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <06bd005c-2cf0-00e1-be87-c953b0db5cb5@redhat.com>
Date:   Thu, 29 Jul 2021 13:14:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <CAHp75VeeN7KYifZ7K82CKmj4QKexAu2cK1pqXaj_coMPO4Q8ZQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi,

On 7/29/21 10:50 AM, Andy Shevchenko wrote:
> On Thu, Jul 29, 2021 at 11:45 AM Hans de Goede <hdegoede@redhat.com> wrote:
>>
>> Hi,
>>
>> On 7/29/21 10:37 AM, Andy Shevchenko wrote:
>>> On Thu, Jul 29, 2021 at 11:21 AM Hans de Goede <hdegoede@redhat.com> wrote:
>>>>
>>>> Various 360 degree hinges (yoga) style 2-in-1 devices use 2 accelerometers
>>>> to allow the OS to determine the angle between the display and the base of
>>>> the device.
>>>>
>>>> On Windows these are read by a special HingeAngleService process which
>>>> calls undocumented ACPI methods, to let the firmware know if the 2-in-1 is
>>>> in tablet- or laptop-mode. The firmware may use this to disable the kbd and
>>>> touchpad to avoid spurious input in tablet-mode as well as to report
>>>> SW_TABLET_MODE info to the OS.
>>>>
>>>> Since Linux does not call these undocumented methods, the SW_TABLET_MODE
>>>> info reported by various pdx86 drivers is incorrect on these devices.
>>>>
>>>> Before this commit the intel-hid and thinkpad_acpi code already had 2
>>>> hardcoded checks for ACPI hardware-ids of dual-accel sensors to avoid
>>>> reporting broken info.
>>>>
>>>> And now we also have a bug-report about the same problem in the intel-vbtn
>>>> code. Since there are at least 3 different ACPI hardware-ids in play, add
>>>> a new dual_accel_detect() helper which checks for all 3, rather then
>>>> adding different hardware-ids to the drivers as bug-reports trickle in.
>>>> Having shared code which checks all known hardware-ids is esp. important
>>>> for the intel-hid and intel-vbtn drivers as these are generic drivers
>>>> which are used on a lot of devices.
>>>>
>>>> The BOSC0200 hardware-id requires special handling, because often it is
>>>> used for a single-accelerometer setup. Only in a few cases it refers to
>>>> a dual-accel setup, in which case there will be 2 I2cSerialBus resources
>>>> in the device's resource-list, so the helper checks for this.
>>>
>>> ...
>>>
>>>> +static int dual_accel_i2c_resource_count(struct acpi_resource *ares, void *data)
>>>> +{
>>>> +       struct acpi_resource_i2c_serialbus *sb;
>>>> +       int *count = data;
>>>> +
>>>> +       if (i2c_acpi_get_i2c_resource(ares, &sb))
>>>> +               *count = *count + 1;
>>>> +
>>>> +       return 1;
>>>> +}
>>>
>>> It will be a third copy of this in the kernel.
>>> Let's put it to i2c.h or somewhere available for all these users.
>>>
>>>> +
>>>> +static int dual_accel_i2c_client_count(struct acpi_device *adev)
>>>> +{
>>>> +       int ret, count = 0;
>>>> +       LIST_HEAD(r);
>>>> +
>>>> +       ret = acpi_dev_get_resources(adev, &r, dual_accel_i2c_resource_count, &count);
>>>> +       if (ret < 0)
>>>> +               return ret;
>>>> +
>>>> +       acpi_dev_free_resource_list(&r);
>>>> +       return count;
>>>> +}
>>>
>>> So does this.
>>>
>>> Taking into account that this is a bug fix, I'm okay if you do above
>>> as an additional patch (or patches) on top of this.
>>
>> Right, I had a note about this behind the cut (---) line, but I dropped
>> the patch and git-am-ed it while reworking my tree for some other issue
>> dropping the note (sorry), the note was:
>>
>> """
>> ---
>> Note the counting of the number of I2cSerialBus resources in an
>> ACPI-device's resource-list is becoming a common pattern. I plan
>> to add a new shared helper for this in a follow-up patch-set.
>> I've deliberately not made use of such a new helper in this patch
>> for easier backporting to the stable series.
>> """
>>
>> In other words, I fully agree. I've already added an item to my
>> TODO list about doing a followup series to replace the 3 copies in:
> 
> With this promise taken
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

Thank you, I've added this to the review-hans and fixes branches now.

Regards,

Hans

