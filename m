Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 335635EC496
	for <lists+linux-acpi@lfdr.de>; Tue, 27 Sep 2022 15:35:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232314AbiI0Nfs (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 27 Sep 2022 09:35:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229779AbiI0Nff (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 27 Sep 2022 09:35:35 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8E1C6AA3A
        for <linux-acpi@vger.kernel.org>; Tue, 27 Sep 2022 06:35:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1664285732;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bIj/8LyuLrxKhsCRApmgbkJl/lXOMxhDqzOflKfD3iE=;
        b=ZB4/Fs9CvbI2uvV1I9jKIzGCpfho9z7PUs/6Q6tsnNv9R6bXQ5TNJnn96fBOdVdvNTNXIl
        h5R9bMZjIQG4LSsqHWvQhzbLRLHSozCNs/cv9isc7gUlMkbwwE8XHl06hCNoXVmu7TsrlW
        0ihhCfIrA2GBGbjnRRHmNA866PcuB9Q=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-42-A8IAQWFAM9WnFsxzyFEa5Q-1; Tue, 27 Sep 2022 09:35:31 -0400
X-MC-Unique: A8IAQWFAM9WnFsxzyFEa5Q-1
Received: by mail-ed1-f70.google.com with SMTP id z13-20020a05640240cd00b0045276a79364so7771310edb.2
        for <linux-acpi@vger.kernel.org>; Tue, 27 Sep 2022 06:35:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=bIj/8LyuLrxKhsCRApmgbkJl/lXOMxhDqzOflKfD3iE=;
        b=odErHzZBl2CM13mfp5tJt6ld9QhMqNXfx4dsTQbB7cUf+uvg/3G6zlD0G0tL84m7LV
         cuWZ+E2/lsHAM9PzHWU61B0YdJkE1WpMMmwSrceXD69NxLL+153b1hnp0eldLIlv2kCj
         cBhte8V7tzAWR9SUHx8CzxpHOp42keUiNzoOAzQRei3C/hzinauKYK2hGBNY396XRNLw
         3x8yTfTyn/owEQGMmx86obO8yTC1U0cJAxQQ95A2vh91R8kzoMaVQg6VNncGlrzbv8Kc
         H3iYbMOvrrph6U5RNoIC4LOTyy7wsJ7kHsSA5PGZoUp1836oZzB29gIHeft2PBcSMlxp
         j86Q==
X-Gm-Message-State: ACrzQf0hxiDolxfpqueynKjC61R6hGpjQouD98BDhRFpK451bQccPvD2
        HEFTmRvOuqTWr/eCnp00XHB+tiwxSGaPwKjulUXxZ/4WCjn2xla74Jlfmyv/Q6U1dNO1EJotGuW
        nI4m5GbJuI84kwFrbFcsgig==
X-Received: by 2002:a17:907:802:b0:781:8017:b2df with SMTP id wv2-20020a170907080200b007818017b2dfmr22711975ejb.606.1664285728701;
        Tue, 27 Sep 2022 06:35:28 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM7nFd0P2BNHTBpUa3NwtqcrQs7WuFQhVItcv934KvS5WCRB0JbFGcNP0VtzIhYp6GYqvsTEYg==
X-Received: by 2002:a17:907:802:b0:781:8017:b2df with SMTP id wv2-20020a170907080200b007818017b2dfmr22711955ejb.606.1664285728502;
        Tue, 27 Sep 2022 06:35:28 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c1e:bf00:d69d:5353:dba5:ee81? (2001-1c00-0c1e-bf00-d69d-5353-dba5-ee81.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:d69d:5353:dba5:ee81])
        by smtp.gmail.com with ESMTPSA id r10-20020a1709061baa00b00783f32d7eaesm778136ejg.164.2022.09.27.06.35.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Sep 2022 06:35:27 -0700 (PDT)
Message-ID: <037e2137-3c4d-95e1-76d0-27bec98a609e@redhat.com>
Date:   Tue, 27 Sep 2022 15:35:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
Subject: Re: [PATCH RFC v2 1/2] platform/x86: quickstart: Add ACPI quickstart
 button (PNP0C32) driver
Content-Language: en-US
To:     Arvid Norlander <lkml@vorpal.se>,
        =?UTF-8?Q?Barnab=c3=a1s_P=c5=91cze?= <pobrn@protonmail.com>
Cc:     platform-driver-x86@vger.kernel.org, linux-acpi@vger.kernel.org,
        Len Brown <lenb@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-input@vger.kernel.org, Azael Avalos <coproscefalo@gmail.com>
References: <20220922182424.934340-1-lkml@vorpal.se>
 <20220922182424.934340-2-lkml@vorpal.se>
 <4-mkye9NM7L93IKQAGjd8BmHi1_2zEnx4F8L3AvKk9RsNBtuoS5cpNCKV-nyb1Xpb1jmAZQDdpNlyvjoUfrFKkq4V-EOfXo9b_gRbyC1hSs=@protonmail.com>
 <3095147c-844c-42cf-833b-8a2eae5fcc21@vorpal.se>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <3095147c-844c-42cf-833b-8a2eae5fcc21@vorpal.se>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi,

On 9/25/22 20:19, Arvid Norlander wrote:
> Hi,
> 
> Thank you, I have incorperated your feedback in my local branch.
> 
> On 2022-09-23 21:24, Barnabás Pőcze wrote:
>> Hi
>>
>> 2022. szeptember 22., csütörtök 20:24 keltezéssel, Arvid Norlander írta:
>>
>>> This is loosely based on a previous staging driver that was removed. See
>>> links below for more info on that driver. The original commit ID was
>>> 0be013e3dc2ee79ffab8a438bbb4e216837e3d52.
>>>
>>> However, here a completely different approach is taken to the user space
>>> API (which should solve the issues the original driver had). Each PNP0C32
>>> device is a button, and each such button gets a separate input device
>>> associated with it (instead of a shared platform input device).
>>>
>>> The button ID (as read from ACPI method GHID) is provided via a sysfs file
>>> "button_id".
>>>
>>> If the button caused a wakeup it will "latch" the "wakeup_cause" sysfs file
>>> to true. This can be reset by a user space process.
>>>
>>> Link: https://marc.info/?l=linux-acpi&m=120550727131007
>>> Link: https://lkml.org/lkml/2010/5/28/327
>>> Signed-off-by: Arvid Norlander <lkml@vorpal.se>
>>> ---
>>> [...]
>>> diff --git a/drivers/platform/x86/quickstart.c b/drivers/platform/x86/quickstart.c
>>> new file mode 100644
>>> index 000000000000..ce51abe012f7
>>> --- /dev/null
>>> +++ b/drivers/platform/x86/quickstart.c
>>> @@ -0,0 +1,320 @@
> 
> <snip>
> 
>>> +
>>> +static ssize_t wakeup_cause_store(struct device *dev,
>>> +				  struct device_attribute *attr,
>>> +				  const char *buf, size_t count)
>>> +{
>>> +	struct quickstart_acpi *quickstart = dev_get_drvdata(dev);
>>> +
>>> +	if (count < 2)
>>> +		return -EINVAL;
>>> +
>>> +	if (strncasecmp(buf, "false", 4) != 0)
>>> +		return -EINVAL;
>>> +
>>
>> If "true"/"false" will be used in the final version, then I think this check
>> currently is too lax. You could use `sysfs_streq()`. And I think the `count < 2`
>> check is not needed.
> 
> Regarding the user space API I don't know, that is one of the open
> questions in the cover letter. I have yet to get any feedback on any of
> those questions. That is something that needs to happen before this driver
> can be included. I would appreciate your feedback on those.

I will reply to this question in my general review of the driver.

Regards,

Hans



> 
> <snip>
> 
>>
>> Regards,
>> Barnabás Pőcze
> 
> Regards,
> Arvid Norlander
> 

