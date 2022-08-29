Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 811415A4EEA
	for <lists+linux-acpi@lfdr.de>; Mon, 29 Aug 2022 16:12:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230436AbiH2OMf (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 29 Aug 2022 10:12:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230370AbiH2OMO (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 29 Aug 2022 10:12:14 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 852B986FCB
        for <linux-acpi@vger.kernel.org>; Mon, 29 Aug 2022 07:12:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1661782331;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Gchx3QcbILv+R1KpDkUP8I1SPjXQQm2dxzcc9UyT0MI=;
        b=GdLSgZLoxdIkByrT8TsOZKq1dQOfxlrqL/+Dcp8HOiQPufpbp67lOWAWH3eEopYEAVhATs
        iJtKdocN3rGYy2eycF9Plv3ikMGzexdRTZE0o05rNTFCegFBZkrKspAobV7EH+eFiH8JIw
        alt0CV9xRpTKzSp8SS56vzbLpoZAV8g=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-175-PdkEo5FxMdKY8qe0B4o_qg-1; Mon, 29 Aug 2022 10:12:08 -0400
X-MC-Unique: PdkEo5FxMdKY8qe0B4o_qg-1
Received: by mail-ej1-f72.google.com with SMTP id ho13-20020a1709070e8d00b00730a655e173so2366222ejc.8
        for <linux-acpi@vger.kernel.org>; Mon, 29 Aug 2022 07:12:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=Gchx3QcbILv+R1KpDkUP8I1SPjXQQm2dxzcc9UyT0MI=;
        b=50x6i8ZaDLzHvcILXj7zY6LFnAamNZg/7H/8BnhAcHP2yh5p9sRvD+3d5U8vQU0QVj
         40Yu1g2OUkNGTh2d+vmpVmR5y7i01yg0h3/KUdWVWBxr5Wfy4q6wq0l9wHV4fL2y6/9K
         +ekpjb96wokTthO++gEnK0tPSKHzeQVcE5bgZExIoTOmt/DGOA4xFP6wviprw7MQ+QlG
         68pH/GbXWJB11GLFx8mlxJjieL+TSqDjMOxkK10ewtpduIi5lx7yZhFcgvbMVM8WEhLd
         /7X/k6FmuNQPO2GQ9ZO5cFXHrQP+6BpKiQKZn3GUJGEIYymeB/qpWawDMIf2UuAHczeA
         UgUQ==
X-Gm-Message-State: ACgBeo2Tlq+iqLawNGuweKgTyWMvHr2qjKWahVNtK1pIBDTLXu1WFBD7
        OnzdOhxRrC0J7ZUfuU77oIXWzeivstI0wDt3rCsIgCmiU6wxr0OE9RpIJq2lzwL0iwKpqk9Z9tp
        8hp+8LfhJ7rlUkmV5UDCWxg==
X-Received: by 2002:a17:907:7604:b0:741:4e7a:a1ca with SMTP id jx4-20020a170907760400b007414e7aa1camr6693349ejc.250.1661782327160;
        Mon, 29 Aug 2022 07:12:07 -0700 (PDT)
X-Google-Smtp-Source: AA6agR6QFsyT06jigyqSK2xhkZIwLk+RgG2ezJ3fcS/HrwTHwsLeiGd9A6/yxhD4r7mcp02lkSsX/g==
X-Received: by 2002:a17:907:7604:b0:741:4e7a:a1ca with SMTP id jx4-20020a170907760400b007414e7aa1camr6693330ejc.250.1661782326858;
        Mon, 29 Aug 2022 07:12:06 -0700 (PDT)
Received: from [10.40.98.142] ([78.108.130.194])
        by smtp.gmail.com with ESMTPSA id m20-20020a17090679d400b00715a02874acsm4551296ejo.35.2022.08.29.07.12.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Aug 2022 07:12:06 -0700 (PDT)
Message-ID: <9640be14-b478-5887-9057-de2796eccd6b@redhat.com>
Date:   Mon, 29 Aug 2022 16:12:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 1/1] ACPI: video: Add Toshiba Satellite/Portege Z830 quirk
Content-Language: en-US
From:   Hans de Goede <hdegoede@redhat.com>
To:     Arvid Norlander <lkml@vorpal.se>, linux-acpi@vger.kernel.org
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>
References: <20220824184950.631520-1-lkml@vorpal.se>
 <20220824184950.631520-2-lkml@vorpal.se>
 <d097b844-8fe4-3469-2137-9e8407348175@redhat.com>
 <3863cad2-1910-b377-011b-4970eeb68e13@vorpal.se>
 <91260f39-27d9-222b-53e7-41ab4bb412a3@redhat.com>
In-Reply-To: <91260f39-27d9-222b-53e7-41ab4bb412a3@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi,

On 8/27/22 15:49, Hans de Goede wrote:
> hI,
> 
> On 8/27/22 13:23, Arvid Norlander wrote:
>> Hi,
>>
>> On 2022-08-26 13:46, Hans de Goede wrote:
>>> Hi All,
>>>
>>> [...]
>>>
>>> Arvid, I wonder if instead of using disable_backlight_sysfs_if
>>> you can try:
>>>
>>> 0. Remove disable_backlight_sysfs_if from cmdline / quirk
>>> 1. Adding acpi_backlight=native to the kernel commandline
>>> 2. In toshiba_acpi_resume() add a HCI_PANEL_POWER_ON PANEL_ON
>>>
>>> and see if that also fixes things ?
>>>
>> Yes, this works.
> 
> Great, thank you for testing this!
> 
> In hindsight the disable_backlight_sysfs_if flag was a mistake
> and I should have fixed this differently (I wrote the code adding
> that flag).  And now it is sorta getting in the way of cleaning
> up the backlight handling. So IMHO removing disable_backlight_sysfs_if
> is the best thing to do here.
> 
>> I do not have a patch for this (I assume it
>> would involve creating quirk tables, checking for support for
>> HCI_PANEL_POWER_ON, etc). I simply hard coded the call in for
>> the test. I very much doubt I will have time to code this in
>> the near future as well.
> 
> No problem I will prepare a patch series for you to test. Note
> this will be on top of my other backlight cleanups, so I
> will just send you an email pointing to a git branch to test,
> I hope this will be ok?

Arvid, here is a git branch with my backlight-refactor for you
to test:

https://github.com/jwrdegoede/linux-sunxi/commits/backlight-refactor-for-arvid

If you can give this a test spin (without any special kernel
commandline options) then that would be great.

>> However, do we know what the other Toshiba's that need this
>> quirk also supports HCI_PANEL_POWER_ON? I obviously can only
>> test the Z830 that I own.
> 
> It seems that all models which need this are all from the same
> generation so I would expect the same fix to work. If I get
> regression reports from users after my cleanup series lands
> I can then take a closer look at the DSDT tables of the
> other models if necessary.

Quick update on this I've taken a look at the DSTD's _BCM method
which is the magic call done by acpi_video on resume which
turns the panel back on and in both a R700 as well as a R830
it ends up doing this:

SMBR (0xFF00, 0x2A, Local0, 0x00, 0xB2)

Which translates to:

HCI_SET HCI_BRIGHTNESS <brightness-level>

Note that in this case brightness-level used by the acpi_video
code is the initial brightness at power-on since acpi_video
is not used to actually control the brightness.

Which makes using HCI_PANEL_POWER_ON a better idea since
that does not touches the brightness.

So I believe that replacing disable_backlight_sysfs_if with
a HCI call by toshiba_acpi on resume should work on all
affected models.

Regards,

Hans

