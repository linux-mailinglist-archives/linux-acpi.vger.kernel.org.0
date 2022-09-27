Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 067A65EC702
	for <lists+linux-acpi@lfdr.de>; Tue, 27 Sep 2022 16:56:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232359AbiI0O4d (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 27 Sep 2022 10:56:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232443AbiI0O4J (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 27 Sep 2022 10:56:09 -0400
Received: from vorpal.se (vorpal.se [151.236.221.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18EF160512;
        Tue, 27 Sep 2022 07:54:58 -0700 (PDT)
Received: by vorpal.se (Postfix) with ESMTPSA id 6159E14293;
        Tue, 27 Sep 2022 14:54:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=vorpal.se; s=2019;
        t=1664290485; bh=ZMDF6AxLpFRw30JwNzc+ZPcKjRwkI977PeS1iICmxpE=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=YtmnwQ3aLJeB6Gb1K+tFA89yK35/b3WnBMPg+LrP/xda9u9kqkr1Cj4kWih/Yh7fb
         2gtoge3oUHtLoMOhY5+kMEHGFD5UiNdR8/lTaW+gceKBbMrGdIg2NvswvMZ1JYUd1x
         mLzk4tRucVEOk93DqymCKQ/y0jKsv2AnIGNaTOpq0nhomyt9AJsNrze4zIx8HSZWmb
         AZlHkpLpthA00+0wgjzFU1cQJ6PVYd/stB52lOKlgCCJNZgoTwlisOfou0dOpNRo/Q
         YafydpNQX2LIHDk0pkKr/DKhQnJvbA9ZnchBDRNwPl9FNzBTCmqVnPvmqkriBqpLHl
         VxIjmO49HSj0Q==
Message-ID: <d1ec9351-7e5c-0f2d-8a67-f640d1105044@vorpal.se>
Date:   Tue, 27 Sep 2022 16:54:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH RFC v2 1/2] platform/x86: quickstart: Add ACPI quickstart
 button (PNP0C32) driver
Content-Language: en-US
To:     Hans de Goede <hdegoede@redhat.com>,
        =?UTF-8?Q?Barnab=c3=a1s_P=c5=91cze?= <pobrn@protonmail.com>
Cc:     platform-driver-x86@vger.kernel.org, linux-acpi@vger.kernel.org,
        Len Brown <lenb@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-input@vger.kernel.org, Azael Avalos <coproscefalo@gmail.com>
References: <20220922182424.934340-1-lkml@vorpal.se>
 <20220922182424.934340-2-lkml@vorpal.se>
 <4-mkye9NM7L93IKQAGjd8BmHi1_2zEnx4F8L3AvKk9RsNBtuoS5cpNCKV-nyb1Xpb1jmAZQDdpNlyvjoUfrFKkq4V-EOfXo9b_gRbyC1hSs=@protonmail.com>
 <3095147c-844c-42cf-833b-8a2eae5fcc21@vorpal.se>
 <729c5fc1-3bc1-f2f3-9820-a1e84b09aeac@redhat.com>
From:   Arvid Norlander <lkml@vorpal.se>
In-Reply-To: <729c5fc1-3bc1-f2f3-9820-a1e84b09aeac@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi,

I think something may be slightly broken. I got the below email twice, once in
reply to where it should be, once as a reply to the cover letter.

Best regards,
Arvid

On 2022-09-27 15:49, Hans de Goede wrote:
> Hi,
> 
> On 9/25/22 20:19, Arvid Norlander wrote:
>> Hi,
>>
>> Thank you, I have incorperated your feedback in my local branch.
>>
>> On 2022-09-23 21:24, Barnabás Pőcze wrote:
>>> Hi
>>>
>>> 2022. szeptember 22., csütörtök 20:24 keltezéssel, Arvid Norlander írta:
>>>
>>>> This is loosely based on a previous staging driver that was removed. See
>>>> links below for more info on that driver. The original commit ID was
>>>> 0be013e3dc2ee79ffab8a438bbb4e216837e3d52.
>>>>
>>>> However, here a completely different approach is taken to the user space
>>>> API (which should solve the issues the original driver had). Each PNP0C32
>>>> device is a button, and each such button gets a separate input device
>>>> associated with it (instead of a shared platform input device).
>>>>
>>>> The button ID (as read from ACPI method GHID) is provided via a sysfs file
>>>> "button_id".
>>>>
>>>> If the button caused a wakeup it will "latch" the "wakeup_cause" sysfs file
>>>> to true. This can be reset by a user space process.
>>>>
>>>> Link: https://marc.info/?l=linux-acpi&m=120550727131007
>>>> Link: https://lkml.org/lkml/2010/5/28/327
>>>> Signed-off-by: Arvid Norlander <lkml@vorpal.se>
>>>> ---
>>>> [...]
>>>> diff --git a/drivers/platform/x86/quickstart.c b/drivers/platform/x86/quickstart.c
>>>> new file mode 100644
>>>> index 000000000000..ce51abe012f7
>>>> --- /dev/null
>>>> +++ b/drivers/platform/x86/quickstart.c
>>>> @@ -0,0 +1,320 @@
>>
>> <snip>
>>
>>>> +
>>>> +static ssize_t wakeup_cause_store(struct device *dev,
>>>> +				  struct device_attribute *attr,
>>>> +				  const char *buf, size_t count)
>>>> +{
>>>> +	struct quickstart_acpi *quickstart = dev_get_drvdata(dev);
>>>> +
>>>> +	if (count < 2)
>>>> +		return -EINVAL;
>>>> +
>>>> +	if (strncasecmp(buf, "false", 4) != 0)
>>>> +		return -EINVAL;
>>>> +
>>>
>>> If "true"/"false" will be used in the final version, then I think this check
>>> currently is too lax. You could use `sysfs_streq()`. And I think the `count < 2`
>>> check is not needed.
>>
>> Regarding the user space API I don't know, that is one of the open
>> questions in the cover letter. I have yet to get any feedback on any of
>> those questions. That is something that needs to happen before this driver
>> can be included. I would appreciate your feedback on those.
> 
> I will reply to this question in my general review of the driver.
> 
> Regards,
> 
> Hans
> 
> 
> 
>>
>> <snip>
>>
>>>
>>> Regards,
>>> Barnabás Pőcze
>>
>> Regards,
>> Arvid Norlander
>>
> 

