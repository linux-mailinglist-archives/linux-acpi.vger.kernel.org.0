Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7791E60BE78
	for <lists+linux-acpi@lfdr.de>; Tue, 25 Oct 2022 01:23:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231183AbiJXXXV (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 24 Oct 2022 19:23:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230139AbiJXXW5 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 24 Oct 2022 19:22:57 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DC342DE44E
        for <linux-acpi@vger.kernel.org>; Mon, 24 Oct 2022 14:44:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1666647813;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LLng6C1VOPaKmGfnDAR23yy9IW4xWqG/nhRblDLerDI=;
        b=bJ8C7Pt0UOrqmo2QVW8PitdUqp6+JU3WvnKpS/JOTAAbNtny556g44bX9yOXH6tdUj1BnA
        vyKG3TCqymFPfreEhcjx238c+OvhW4jNxbjWqc9ZNTI+FdRLpTcnh/pHR1hCEaabCqMEvs
        tfkSAw83PvSC0kS6u3gpW85xjDvB2Mc=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-292-K4xUVJDYN665TQ7RxUr15w-1; Mon, 24 Oct 2022 11:12:51 -0400
X-MC-Unique: K4xUVJDYN665TQ7RxUr15w-1
Received: by mail-ed1-f71.google.com with SMTP id x18-20020a05640226d200b00461e027f704so2316892edd.7
        for <linux-acpi@vger.kernel.org>; Mon, 24 Oct 2022 08:12:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LLng6C1VOPaKmGfnDAR23yy9IW4xWqG/nhRblDLerDI=;
        b=azluCurwyIVbJMssDupK41l/+UJqBSB2M4Rkt95zLU6kBtfWEr2LH6/N5BhCYZe0vS
         OSZ+Bi/2DbWmi6VnB3fGlY5XPWjk74kQYB8697EmtcdcSj7co0eIMWMq9sKC9CTZGEcq
         8AZHf+LtanB1+A3qUdaBSAwKGCldODbxOpJVxPjKq62aK0FKbuRJYT2vGgMmVx9zLk2U
         SrC/Fqm5vZp24I1xhb2FbUtISaABcVTDBxPrD67yBiN7jTOD82+x1pOki6yPzvrjrFRa
         nA4hgUqJX3317gusiE0YpE7kYIkX6WZLgZ34AUIaq+kZ5Csucscl3sfyQcc93WUbAvLI
         Gwfg==
X-Gm-Message-State: ACrzQf1UNU47aHCg4TnlL66+adi/Ze/Ff83aOub4Ca6AnSBvOLBv6tmO
        ZIKjqsAjqp8H4W9KNAPrfeI9UhOXGFG79AJKlnHOCDkFKR5tFXy5zfPSJeWK01m+EIxE9HIRekc
        wMTCbLdB8cGyLiogyG/FE0A==
X-Received: by 2002:a17:907:7f05:b0:78d:e869:f2fe with SMTP id qf5-20020a1709077f0500b0078de869f2femr26654465ejc.684.1666624370477;
        Mon, 24 Oct 2022 08:12:50 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM7NiY3mR8h0t9Fxj1mnG4UwQWad5Y2Z3MQDaJ6ei5w9igvvCLQDaVpdTc6JMLVHtE1y5iJqvQ==
X-Received: by 2002:a17:907:7f05:b0:78d:e869:f2fe with SMTP id qf5-20020a1709077f0500b0078de869f2femr26654446ejc.684.1666624370217;
        Mon, 24 Oct 2022 08:12:50 -0700 (PDT)
Received: from [10.40.98.142] ([78.108.130.194])
        by smtp.gmail.com with ESMTPSA id 12-20020a170906318c00b00770812e2394sm15742436ejy.160.2022.10.24.08.12.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Oct 2022 08:12:49 -0700 (PDT)
Message-ID: <db61f939-a4a2-05ec-e09c-03a95c81e922@redhat.com>
Date:   Mon, 24 Oct 2022 17:12:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH v2] ACPI: video: Fix missing native backlight on
 Chromebooks
Content-Language: en-US
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Dmitry Osipenko <dmitry.osipenko@collabora.com>,
        Len Brown <lenb@kernel.org>,
        Akihiko Odaki <akihiko.odaki@daynix.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Sean Paul <seanpaul@chromium.org>, kernel@collabora.com,
        linux-acpi@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
References: <20221024141210.67784-1-dmitry.osipenko@collabora.com>
 <dda4b024-69d2-1d1d-da23-e922e5b6128a@redhat.com>
 <CAJZ5v0irmk3aAK9t3UYcus+SXDL+AaT88LPXfyJU2PrXbkgfMg@mail.gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <CAJZ5v0irmk3aAK9t3UYcus+SXDL+AaT88LPXfyJU2PrXbkgfMg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi,

On 10/24/22 16:45, Rafael J. Wysocki wrote:
> On Mon, Oct 24, 2022 at 4:32 PM Hans de Goede <hdegoede@redhat.com> wrote:
>>
>> Hi,
>>
>> On 10/24/22 16:12, Dmitry Osipenko wrote:
>>> Chromebooks don't have backlight in ACPI table, they suppose to use
>>> native backlight in this case. Check presence of the CrOS embedded
>>> controller ACPI device and prefer the native backlight if EC found.
>>>
>>> Suggested-by: Hans de Goede <hdegoede@redhat.com>
>>> Fixes: 2600bfa3df99 ("ACPI: video: Add acpi_video_backlight_use_native() helper")
>>> Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
>>> ---
>>>
>>> Changelog:
>>>
>>> v2: - Added explanatory comment to the code and added check for the
>>>       native backlight presence, like was requested by Hans de Goede.
>>
>> Thanks this version looks good to me:
>>
>> Reviewed-by: Hans de Goede <hdegoede@redhat.com>
>>
>> Rafael, can you pick this up and send it in a fixes pull-req
>> for 6.1 to Linus? Or shall I pick this one up and include it
>> in my next pull-req?
> 
> It would be better if you could pick this up IMV, so please free to add
> 
> Acled-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Ok, I've merged this now and I'll send out fixes pull-req with this
to Linus before coming Friday.

Dmitry, Thank you for your patch, I've applied this patch to my
fixes branch:
https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git/log/?h=fixes

Regards,

Hans




> 
> to it.
> 
> Thanks!
> 
>>>
>>>  drivers/acpi/video_detect.c | 12 ++++++++++++
>>>  1 file changed, 12 insertions(+)
>>>
>>> diff --git a/drivers/acpi/video_detect.c b/drivers/acpi/video_detect.c
>>> index 0d9064a9804c..9cd8797d12bb 100644
>>> --- a/drivers/acpi/video_detect.c
>>> +++ b/drivers/acpi/video_detect.c
>>> @@ -668,6 +668,11 @@ static const struct dmi_system_id video_detect_dmi_table[] = {
>>>       { },
>>>  };
>>>
>>> +static bool google_cros_ec_present(void)
>>> +{
>>> +     return acpi_dev_found("GOOG0004");
>>> +}
>>> +
>>>  /*
>>>   * Determine which type of backlight interface to use on this system,
>>>   * First check cmdline, then dmi quirks, then do autodetect.
>>> @@ -730,6 +735,13 @@ static enum acpi_backlight_type __acpi_video_get_backlight_type(bool native)
>>>                       return acpi_backlight_video;
>>>       }
>>>
>>> +     /*
>>> +      * Chromebooks that don't have backlight handle in ACPI table
>>> +      * are supposed to use native backlight if it's available.
>>> +      */
>>> +     if (google_cros_ec_present() && native_available)
>>> +             return acpi_backlight_native;
>>> +
>>>       /* No ACPI video (old hw), use vendor specific fw methods. */
>>>       return acpi_backlight_vendor;
>>>  }
>>
> 

