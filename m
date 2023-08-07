Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 865DD772392
	for <lists+linux-acpi@lfdr.de>; Mon,  7 Aug 2023 14:18:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231810AbjHGMSD (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 7 Aug 2023 08:18:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233352AbjHGMR4 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 7 Aug 2023 08:17:56 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6163106
        for <linux-acpi@vger.kernel.org>; Mon,  7 Aug 2023 05:17:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1691410632;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bu2WjHOzIVOP9vk1kJBHvL9JLmqO8vpFvQBXM5x68QA=;
        b=Mk2BZTKcMCi8CLx0PagH6QHzQdXQQbXWX5pi4rrFk/9Im2ZPlbLAyJpjzPL+llY5/KzEE0
        ZScrMgrM5MDCLDko1h8eZ/znUr9fN/aw7xMFEvN6FZmkZzF7Fvy0T0htUL85Vvg6jW/F45
        efD+PDqYAYmE8GQcs59zOynKaWo6yAo=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-680-qHXbLWg6MPmGJje3gCI5dg-1; Mon, 07 Aug 2023 08:17:11 -0400
X-MC-Unique: qHXbLWg6MPmGJje3gCI5dg-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-94a355cf318so358293266b.2
        for <linux-acpi@vger.kernel.org>; Mon, 07 Aug 2023 05:17:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691410630; x=1692015430;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bu2WjHOzIVOP9vk1kJBHvL9JLmqO8vpFvQBXM5x68QA=;
        b=NzlfrpN2NGUCNpzbNFO9TRe3/1K3CqV/URX6RZ8Y4+1PbvuJLF13Y63zoI/8OvkxKk
         eh1NIG8TU2Sszv2+r/EzVQILzgTb0yMGKk0nYR4s0eVGUhbu6t9HQZnnegzmJIRXrmC+
         TzC11wMxDqyYTvTovpkYd+CYHwPUEkVYM5msfSCAswHw2JMfKb7Z5lgqjyTQ2P3FMiDP
         zZrs3gnUsPtGR7NpljAGCiUsoJvgVENSpYn3QvTnJHHnBzSBCLGnmu6mYK68X0cSruJG
         8NjMSJJLtjTDQTTryrEzHiQnzLbCrsQnHRV6Lms3YH5SwhGmvOzIMkjKfwCUSqBB/iMn
         yP0A==
X-Gm-Message-State: AOJu0YyAfTHyy8DNc3bKTmyoviwqfg0wfaqda9ipXcNLz8Z7ZnDdYOMs
        sK74tnsVwxc9LBxkZpbeXIPIaJJC0ydEt/4wSWHJSpBVP8FsCTAJ9DR7nX0243F3xQ47/r0YpL2
        YFvHFOIAujVJxnCUEtKF/jijWbaoGWg==
X-Received: by 2002:a17:906:3f47:b0:994:4e16:d430 with SMTP id f7-20020a1709063f4700b009944e16d430mr8844991ejj.20.1691410630301;
        Mon, 07 Aug 2023 05:17:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHGii5TVZLhLUxEgHq/U5r38qAbFz19C3rD9mDEGBgoqUEo8Ox3+IjpazjZhLuxKKGpm+73DQ==
X-Received: by 2002:a17:906:3f47:b0:994:4e16:d430 with SMTP id f7-20020a1709063f4700b009944e16d430mr8844978ejj.20.1691410629973;
        Mon, 07 Aug 2023 05:17:09 -0700 (PDT)
Received: from [10.40.98.142] ([78.108.130.194])
        by smtp.gmail.com with ESMTPSA id c21-20020a170906d19500b00992acab8c45sm5226906ejz.12.2023.08.07.05.17.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Aug 2023 05:17:09 -0700 (PDT)
Message-ID: <db155678-c717-351a-730b-aa7fb5c80a0e@redhat.com>
Date:   Mon, 7 Aug 2023 14:17:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] ACPI: video: Add backlight=native DMI quirk for Apple
 iMac12,1 and iMac12,2
Content-Language: en-US
To:     Mario Limonciello <mario.limonciello@amd.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>
Cc:     linux-acpi@vger.kernel.org
References: <20230807094408.242069-1-hdegoede@redhat.com>
 <37253231-82bb-4f31-a9d8-1b74e7806282@amd.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <37253231-82bb-4f31-a9d8-1b74e7806282@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Mario,

On 8/7/23 13:32, Mario Limonciello wrote:
> On 8/7/23 04:44, Hans de Goede wrote:
>> Linux defaults to picking the non-working ACPI video backlight interface
>> on the Apple iMac12,1 and iMac12,2.
>>
>> Add a DMI quirk to pick the working native radeon_bl0 interface instead.
>>
>> Link: https://gitlab.freedesktop.org/drm/amd/-/issues/1838
>> Link: https://gitlab.freedesktop.org/drm/amd/-/issues/2753
>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>> ---
>>   drivers/acpi/video_detect.c | 18 ++++++++++++++++++
>>   1 file changed, 18 insertions(+)
> 
> I'm wondering if you also in the same series should be reverting these two commits?
> 
> 05eacc198c68 ("drm/radeon: Fix eDP for single-display iMac11,2")
> 564d8a2cf3ab ("drm/radeon: Fix eDP for single-display iMac10,1 (v2)")

Those 2 patches select which encoder to use to driver the eDP link,
this seems to be something independent of / orthogonal to which
backlight contrl method to use which is what this patch is about.

Regards,

Hans



> 
>>
>> diff --git a/drivers/acpi/video_detect.c b/drivers/acpi/video_detect.c
>> index 18cc08c858cf..7cceaf31d928 100644
>> --- a/drivers/acpi/video_detect.c
>> +++ b/drivers/acpi/video_detect.c
>> @@ -486,6 +486,24 @@ static const struct dmi_system_id video_detect_dmi_table[] = {
>>           DMI_MATCH(DMI_PRODUCT_NAME, "iMac11,3"),
>>           },
>>       },
>> +    {
>> +     /* https://gitlab.freedesktop.org/drm/amd/-/issues/1838 */
>> +     .callback = video_detect_force_native,
>> +     /* Apple iMac12,1 */
>> +     .matches = {
>> +        DMI_MATCH(DMI_SYS_VENDOR, "Apple Inc."),
>> +        DMI_MATCH(DMI_PRODUCT_NAME, "iMac12,1"),
>> +        },
>> +    },
>> +    {
>> +     /* https://gitlab.freedesktop.org/drm/amd/-/issues/2753 */
>> +     .callback = video_detect_force_native,
>> +     /* Apple iMac12,2 */
>> +     .matches = {
>> +        DMI_MATCH(DMI_SYS_VENDOR, "Apple Inc."),
>> +        DMI_MATCH(DMI_PRODUCT_NAME, "iMac12,2"),
>> +        },
>> +    },
>>       {
>>        /* https://bugzilla.redhat.com/show_bug.cgi?id=1217249 */
>>        .callback = video_detect_force_native,
> 

