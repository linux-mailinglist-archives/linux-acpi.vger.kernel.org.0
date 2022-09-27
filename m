Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B703B5EC4E7
	for <lists+linux-acpi@lfdr.de>; Tue, 27 Sep 2022 15:49:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232222AbiI0Ntm (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 27 Sep 2022 09:49:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231901AbiI0Ntl (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 27 Sep 2022 09:49:41 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F12C18368
        for <linux-acpi@vger.kernel.org>; Tue, 27 Sep 2022 06:49:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1664286575;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bIj/8LyuLrxKhsCRApmgbkJl/lXOMxhDqzOflKfD3iE=;
        b=JsiimHsvpbRlrm4u0ZRuFZGqvIFOYjJ2a77ggPSphKuLTMaUWhTQQaHWmtkE7e2gjh+hXu
        6yxQb3OBNX/azYpbeXqA0g2GX2raL9a7ebQvakjWDhHQxjdh8gpxywqA2dOX3DyLqcNPWx
        ixljSsyo1Fj0iAmKQbqRVO+plGBzofY=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-434-TsyRexAMNsOscaePd8eg0g-1; Tue, 27 Sep 2022 09:49:34 -0400
X-MC-Unique: TsyRexAMNsOscaePd8eg0g-1
Received: by mail-ej1-f69.google.com with SMTP id hr29-20020a1709073f9d00b0078333782c48so2979030ejc.10
        for <linux-acpi@vger.kernel.org>; Tue, 27 Sep 2022 06:49:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=bIj/8LyuLrxKhsCRApmgbkJl/lXOMxhDqzOflKfD3iE=;
        b=C4poiTqNANSmFOBu/HEkijHzJHeWJMsqQdRgNs+ZWKVsVlhM8JNmJbFtrLhvSo0qXR
         2BpMuUexXBlbfLIyr6tP0241Uwzy+COL0cmoWEbH/pHfdgeL80rKVTZ4uUNl+RzcB++3
         RmrxaIE37kZN2BOnDANP1OfLQ1OHcAxLRuIwGjyCLG67TLtBC4IbSOeNoOng/qo8Ct/T
         cszJyuxicb1c6YK/X9SYSYWOVLK7Lpjew9O1mefBFF8fEscOiyA7aRV2bp1ZT+U82PlO
         +SQ322zp2dLLDbLe3TEtC59zG5n48om9zmCnwgfwKxX/mmhVoOPYXTdaf7q2zVjwIoCz
         C5Xw==
X-Gm-Message-State: ACrzQf1NMmlo/mC1mYovkOK1RoATOi24SZzGQjsnmGbOPi08DbG9KQ+l
        q9X/9lgjjYdEHAD2q/UlfQmeO8bv0uKkCwqS+k2BmyPQUJxElUhrmnmhwe5+SeuhkqjWnnfBss6
        7FcvWkfdSMTOOZBrUcl8rwg==
X-Received: by 2002:aa7:c549:0:b0:457:421d:449c with SMTP id s9-20020aa7c549000000b00457421d449cmr11384263edr.260.1664286572968;
        Tue, 27 Sep 2022 06:49:32 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM6PQW54IS0vLv7g9Mz+LKIzp4uo7MFpacQCTVhEpt+2gM1FvmJHdSeph4tHcd9bk2oN5T67OQ==
X-Received: by 2002:aa7:c549:0:b0:457:421d:449c with SMTP id s9-20020aa7c549000000b00457421d449cmr11384246edr.260.1664286572798;
        Tue, 27 Sep 2022 06:49:32 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c1e:bf00:d69d:5353:dba5:ee81? (2001-1c00-0c1e-bf00-d69d-5353-dba5-ee81.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:d69d:5353:dba5:ee81])
        by smtp.gmail.com with ESMTPSA id p4-20020a17090635c400b00731803d4d04sm812533ejb.82.2022.09.27.06.49.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Sep 2022 06:49:32 -0700 (PDT)
Message-ID: <729c5fc1-3bc1-f2f3-9820-a1e84b09aeac@redhat.com>
Date:   Tue, 27 Sep 2022 15:49:31 +0200
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

