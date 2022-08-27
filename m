Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF2605A37FE
	for <lists+linux-acpi@lfdr.de>; Sat, 27 Aug 2022 15:51:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231337AbiH0NtT (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sat, 27 Aug 2022 09:49:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230282AbiH0NtS (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sat, 27 Aug 2022 09:49:18 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBE932F008
        for <linux-acpi@vger.kernel.org>; Sat, 27 Aug 2022 06:49:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1661608156;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/jIgEpXuaoymkW5N3a0Hu7x+XyenaU/Bk7Z7wFNDdX8=;
        b=hVhAx3GktSRNDrJVC3tCyNKO9BCkhLI62XKOm7WzOMx0jdK23FXCM2RTHco2WEX/cJJUM0
        okyMuu8OlsbitY8Zx739CCy4UjGijR9MF5XDg2YblWp/JAD7gv/hNhCIuo5Vg0z7LT3WOT
        KcH2YK7ruIHm4w8cOQaLWA7MMjqq3b0=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-308-Vd9w7FcMORGXfZeo2ISOXg-1; Sat, 27 Aug 2022 09:49:13 -0400
X-MC-Unique: Vd9w7FcMORGXfZeo2ISOXg-1
Received: by mail-ed1-f70.google.com with SMTP id y14-20020a056402440e00b0044301c7ccd9so2744027eda.19
        for <linux-acpi@vger.kernel.org>; Sat, 27 Aug 2022 06:49:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=/jIgEpXuaoymkW5N3a0Hu7x+XyenaU/Bk7Z7wFNDdX8=;
        b=IpgRuL31WWkomW5wA4IYgXPMrGL9qotb6FSZnTcieATUo5cZOERw4dCb+w5GGcDD8B
         GrzpY2A9k/JScD8NNHnt9aVwLc6/dndMY+9Upqpjj0rN0+t4fVAcGXTe1uw17LGhFUPQ
         R/Shomn2+/2HEQ/Ojh15ykNUih4iQDi+daDpEO87EYYV/Jd++EBIhgjNu4rJ09iOnwoG
         X0kopjEYkIW1EXPauPwI1kCwKytDmS+CvC32VouQ7oC89K35lpQtcVoeD58toRKZO5zK
         r+S0E+KTl7/hKdb4YWYLUXwjdutmspCAEJkSQSFGB+po6G+kZRKt9xEjb0hdQdxjqsLC
         5y4w==
X-Gm-Message-State: ACgBeo1GgyIeKZ02W3uJg4R23UJ2tmKJtj//QApBfu3MfA6+Ay1hd4hb
        6e/vBb1jdPzAOOKB19PsK+BqcEwnIn3/tQ1HfxEjF46BjL2of3vD2sWgUjMBeq/hyL/EUNireoc
        8Bab7ah+cB3fK6ZrEaAr63A==
X-Received: by 2002:a17:906:4fd0:b0:73d:be5b:2b50 with SMTP id i16-20020a1709064fd000b0073dbe5b2b50mr8226745ejw.679.1661608152408;
        Sat, 27 Aug 2022 06:49:12 -0700 (PDT)
X-Google-Smtp-Source: AA6agR7K14/SEEeEbN8RtcMLTqIPg0jA9i5arN3T5f95cc32RN+iWa+G3gyr4vpTEnGJuzrcieA1Nw==
X-Received: by 2002:a17:906:4fd0:b0:73d:be5b:2b50 with SMTP id i16-20020a1709064fd000b0073dbe5b2b50mr8226735ejw.679.1661608152183;
        Sat, 27 Aug 2022 06:49:12 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c1e:bf00:d69d:5353:dba5:ee81? (2001-1c00-0c1e-bf00-d69d-5353-dba5-ee81.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:d69d:5353:dba5:ee81])
        by smtp.gmail.com with ESMTPSA id z5-20020aa7cf85000000b0043cbdb16fbbsm2800317edx.24.2022.08.27.06.49.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 27 Aug 2022 06:49:11 -0700 (PDT)
Message-ID: <91260f39-27d9-222b-53e7-41ab4bb412a3@redhat.com>
Date:   Sat, 27 Aug 2022 15:49:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH 1/1] ACPI: video: Add Toshiba Satellite/Portege Z830 quirk
Content-Language: en-US
To:     Arvid Norlander <lkml@vorpal.se>, linux-acpi@vger.kernel.org
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>
References: <20220824184950.631520-1-lkml@vorpal.se>
 <20220824184950.631520-2-lkml@vorpal.se>
 <d097b844-8fe4-3469-2137-9e8407348175@redhat.com>
 <3863cad2-1910-b377-011b-4970eeb68e13@vorpal.se>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <3863cad2-1910-b377-011b-4970eeb68e13@vorpal.se>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

hI,

On 8/27/22 13:23, Arvid Norlander wrote:
> Hi,
> 
> On 2022-08-26 13:46, Hans de Goede wrote:
>> Hi All,
>>
>> [...]
>>
>> Arvid, I wonder if instead of using disable_backlight_sysfs_if
>> you can try:
>>
>> 0. Remove disable_backlight_sysfs_if from cmdline / quirk
>> 1. Adding acpi_backlight=native to the kernel commandline
>> 2. In toshiba_acpi_resume() add a HCI_PANEL_POWER_ON PANEL_ON
>>
>> and see if that also fixes things ?
>>
> Yes, this works.

Great, thank you for testing this!

In hindsight the disable_backlight_sysfs_if flag was a mistake
and I should have fixed this differently (I wrote the code adding
that flag).  And now it is sorta getting in the way of cleaning
up the backlight handling. So IMHO removing disable_backlight_sysfs_if
is the best thing to do here.

> I do not have a patch for this (I assume it
> would involve creating quirk tables, checking for support for
> HCI_PANEL_POWER_ON, etc). I simply hard coded the call in for
> the test. I very much doubt I will have time to code this in
> the near future as well.

No problem I will prepare a patch series for you to test. Note
this will be on top of my other backlight cleanups, so I
will just send you an email pointing to a git branch to tes,
I hope this will be ok?

> However, do we know what the other Toshiba's that need this
> quirk also supports HCI_PANEL_POWER_ON? I obviously can only
> test the Z830 that I own.

It seems that all models which need this are all from the same
generation so I would expect the same fix to work. If I get
regression reports from users after my cleanup series lands
I can then take a closer look at the DSDT tables of the
other models if necessary.

Regards,

Hans




> 
>> If that is the case then we can:
>>
>> 1. Move the DMI quirks for disable_backlight_sysfs_if
>>    from acpi_video.c to video_detect.c to force native
>>    mode by quirk
>> 2. Add the DMI table with the models needing this to
>>    toshiba_acpi.c and then based on that call
>>    HCI_PANEL_POWER_ON PANEL_ON on resume from there
>> 3. Since there are no more quirks using it, remove the
>>    disable_backlight_sysfs_if hack / workaround from
>>    acpi_video.c
>>
>> This will give a nice-cleanup of the generic acpi_video.c
>> code moving the toshiba specific fixup to toshiba_acpi
>> where it really belongs.
>>
>> Regards,
>>
>> Hans
>>
>>
> 
> Best regards,
> Arvid Norlander
> 

