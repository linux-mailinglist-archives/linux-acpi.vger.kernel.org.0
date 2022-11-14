Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CEBF6284BA
	for <lists+linux-acpi@lfdr.de>; Mon, 14 Nov 2022 17:12:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235941AbiKNQMw (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 14 Nov 2022 11:12:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235602AbiKNQMv (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 14 Nov 2022 11:12:51 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCCE61B79F
        for <linux-acpi@vger.kernel.org>; Mon, 14 Nov 2022 08:11:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1668442311;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BpPThT6SGaBN78s3OVD/YXOLYpKR7kgZzXJ4kH4zvf4=;
        b=f3z2cedy/0n6aoQZL8x0kyPpl9oeI3eI3nuKtU++JO/B5AygCpwQ4L3bFxnsFVlpwx6GVo
        kj+V+M453F9ugbJ+FcK7QNaxYdJfpgS8zqym2ZHwEL37WdL1gii6lD69fXxxhvwclXJUoj
        nJDe1WZeE8Td/6oRRoG8Rcgp0s48upA=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-669-VAnIER1APYyHWQKQpfpGIg-1; Mon, 14 Nov 2022 11:11:49 -0500
X-MC-Unique: VAnIER1APYyHWQKQpfpGIg-1
Received: by mail-ej1-f69.google.com with SMTP id sb4-20020a1709076d8400b007ae596eac08so5796037ejc.22
        for <linux-acpi@vger.kernel.org>; Mon, 14 Nov 2022 08:11:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BpPThT6SGaBN78s3OVD/YXOLYpKR7kgZzXJ4kH4zvf4=;
        b=QW3RZLGxHU8A9bJGJPfFtlzamIP2X3EXGg5SfvKloYzXnvozV4p35rQMGfky+QZfGC
         UpFxA4vaBe0dvl96QOg9XSTYiP4OHnluSatURSKB4bgPQ2PBFzbmmWg3sxoJyNkZDp+l
         YwMKcFpPXvRN6MKAzdINGC+v5HgDooIes+m/hOp9pRlpdWBP5+wdHr6Gc2vMWkvnzmH/
         9dwIfCzmP2hc0u4LkH31lxMM1fHmYgVoX9bEeAq/Gtk7DdoNudZXO0voT1WZ627hLfo9
         r5xBhw3RpMv6dFVmEOCmJTYyACNTEIxSzgtlj3p78Y5BzzY502QAM6YgGtEHdsBJfSJ5
         AIcg==
X-Gm-Message-State: ANoB5pn7Ujgo5jTCRdo7hueN5r2jf0m/IC9JwE3VNWx0S70V6pE9uHDt
        q7PqpMFjVitKTiOqCNmvL5VotXrdZWxlRDpmsfppspEv4ukKxiSYKcqZgOvH7q5y2lwPjLktOuf
        lABUJum6XhL1HQm+H2X81bQ==
X-Received: by 2002:a17:906:29d4:b0:78d:a4ca:32df with SMTP id y20-20020a17090629d400b0078da4ca32dfmr10383703eje.686.1668442306522;
        Mon, 14 Nov 2022 08:11:46 -0800 (PST)
X-Google-Smtp-Source: AA0mqf5JabkcuoYygkz/F8fyRb0mrNRG6iZFj1IIeJnLfHw0Gtl2YdVALLipSgTBsx7gPR3DKcIERw==
X-Received: by 2002:a17:906:29d4:b0:78d:a4ca:32df with SMTP id y20-20020a17090629d400b0078da4ca32dfmr10383685eje.686.1668442306290;
        Mon, 14 Nov 2022 08:11:46 -0800 (PST)
Received: from [10.40.98.142] ([78.108.130.194])
        by smtp.gmail.com with ESMTPSA id b25-20020a17090630d900b0078d38cda2b1sm4293314ejb.202.2022.11.14.08.11.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Nov 2022 08:11:45 -0800 (PST)
Message-ID: <be4df501-8602-1154-f702-832391c4a362@redhat.com>
Date:   Mon, 14 Nov 2022 17:11:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH 0/7] ACPI: video: Prefer native over vendor + quirk
 updates
Content-Language: en-US
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Len Brown <lenb@kernel.org>, Matthew Garrett <mjg59@srcf.ucam.org>,
        linux-acpi@vger.kernel.org
References: <20221114144459.455519-1-hdegoede@redhat.com>
 <CAJZ5v0jPV3VXSXO+tW+dUwZ7QkWdXmiDtA7TTOgM9++SpBiWZA@mail.gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <CAJZ5v0jPV3VXSXO+tW+dUwZ7QkWdXmiDtA7TTOgM9++SpBiWZA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi,

On 11/14/22 16:27, Rafael J. Wysocki wrote:
> On Mon, Nov 14, 2022 at 3:45 PM Hans de Goede <hdegoede@redhat.com> wrote:
>>
>> Hi Rafael, et. al.,
>>
>> As mentioned already in the RFC:
>>
>> """
>> Here is a second attempt at always registering only a single
>> /sys/class/backlight device per panel.
>>
>> This first round of testing has shown that native works well even on
>> systems so old that the don't have acpi_video backlight control support.
>>
>> This patch series makes native be preferred over vendor, which should
>> avoid the problems seen with the 6.1 changes before the fixes.
>> """
>>
>> The 2 base patches (last 2 patches of the series now) are unchanged from
>> the RFC. New is a bunch of video_detect DMI quirk updates, 3 small fixes to
>> existing quirks + 2 new quirks. 1 of the new quirks is necessary to avoid
>> a known regression with preferring native over vendor on 1 model,
>> the other DMI quirk is unrelated to the other changes.
>>
>> This series applies on top of the platform-drivers-x86-v6.1-3 tag from:
>> https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git/
>>
>> So either you will need to merge that tag (or merge v6.1-rc5 from Linus)
>> before applying these patches, or I can merge this through my for-next
>> branch which already has these changes. Either way works for me.
> 
> I'll apply them on top of the -rc5.

Great, thank you.

Regards,

Hans

