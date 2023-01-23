Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33D8F677EB5
	for <lists+linux-acpi@lfdr.de>; Mon, 23 Jan 2023 16:06:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231644AbjAWPGX (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 23 Jan 2023 10:06:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231584AbjAWPGW (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 23 Jan 2023 10:06:22 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23B9F28D1B
        for <linux-acpi@vger.kernel.org>; Mon, 23 Jan 2023 07:05:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674486320;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JEvCGEsLOHHBMk5CdYE2GD1MGPLN8/V4uqqqJrhxouk=;
        b=ZmO5tILTNJ9CkanGURj1LCiN/s0Mn20kpIChT9O9pztuaTeKUKVi9UOcJ4ZmcBiMkvWHIs
        kR/YggEJGtGKmhsIpDnbI0RF1/QyxNdh1oPQImHdwBa3E01EZMHuB/NxXfYd1tFFm0xxop
        tAGRNJVhALNfwQ6T5MI3qpOjiWxBKRo=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-673-iMJa2MU6OGudD-k3hKcMlg-1; Mon, 23 Jan 2023 10:05:14 -0500
X-MC-Unique: iMJa2MU6OGudD-k3hKcMlg-1
Received: by mail-ed1-f71.google.com with SMTP id l17-20020a056402255100b00472d2ff0e59so8636046edb.19
        for <linux-acpi@vger.kernel.org>; Mon, 23 Jan 2023 07:05:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JEvCGEsLOHHBMk5CdYE2GD1MGPLN8/V4uqqqJrhxouk=;
        b=OAGOapJ1U9ypUSUqbzWjfD3DFg87T8h0lvMzmuAu9DkWlL6n9SrkKM3muEWQDxZDKz
         OqvdDAt3AN/Yn26gc2BkXeXsIRoDmmKJhcoc93q+sA4q2SQDynUvZB7NFuFrgQvS7y64
         BvUAcWNgNgi8IAHzMAvmW3EUa7R1F2ouKuTTYxjLuUC87JJvRPFj6aeibuNsNl2ohaRK
         pMUmW6iFzwXvI7z97HYrBhGvpBgcmfpEO3SZ8n3mVmYtWeNWrDwkXLvNhG+WMs5VxP8F
         SDsf10EwpBWzYkFL0kCcWkIalHz5Av0OJ7fMKjDZpbA1gUv/gtnrQdsVnH41/xBW/HlW
         cAJQ==
X-Gm-Message-State: AFqh2krp81LRei9n/WCpSosZ0kdRlNho5rWPBw8Hfh0U08CrYPaJ1nnr
        mEQqtV3J6/8/AquJXSS0Q8FBtZxfaDgNc1hOzDcnifSNYzVe63uke24SREKOGN0gURBhyWN3fD8
        sW6IBcw67gZxYy+gOUX8FPg==
X-Received: by 2002:a17:907:b17:b0:873:699f:e87c with SMTP id h23-20020a1709070b1700b00873699fe87cmr25495874ejl.71.1674486312327;
        Mon, 23 Jan 2023 07:05:12 -0800 (PST)
X-Google-Smtp-Source: AMrXdXviB5B3uEy+zL6ibLyF4Ak1otAsCaR/eb20/CKGCAYr+PhtwtRrEUD7d5kcXU1zmKAtkxf2Qg==
X-Received: by 2002:a17:907:b17:b0:873:699f:e87c with SMTP id h23-20020a1709070b1700b00873699fe87cmr25495853ejl.71.1674486312114;
        Mon, 23 Jan 2023 07:05:12 -0800 (PST)
Received: from [10.40.98.142] ([78.108.130.194])
        by smtp.gmail.com with ESMTPSA id kv8-20020a17090778c800b00864d20e5401sm15656573ejc.196.2023.01.23.07.05.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Jan 2023 07:05:11 -0800 (PST)
Message-ID: <a02857d6-83c1-07f7-ebf0-f0b15b190f60@redhat.com>
Date:   Mon, 23 Jan 2023 16:05:10 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH 2/3] platform/x86: apple-gmux: Add apple_gmux_detect()
 helper
Content-Language: en-US
To:     Lukas Wunner <lukas@wunner.de>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Aditya Garg <gargaditya08@live.com>,
        Mark Gross <mgross@linux.intel.com>,
        linux-acpi@vger.kernel.org, Andy Shevchenko <andy@infradead.org>,
        platform-driver-x86@vger.kernel.org
References: <20230123113750.462144-1-hdegoede@redhat.com>
 <20230123113750.462144-3-hdegoede@redhat.com>
 <20230123134907.GA2649@wunner.de>
 <9fc84f34-669e-a89c-52d9-c714fe8e4e49@redhat.com>
 <20230123142335.GA31736@wunner.de>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20230123142335.GA31736@wunner.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi,

On 1/23/23 15:23, Lukas Wunner wrote:
> On Mon, Jan 23, 2023 at 03:13:28PM +0100, Hans de Goede wrote:
>> On 1/23/23 14:49, Lukas Wunner wrote:
>>> On Mon, Jan 23, 2023 at 12:37:49PM +0100, Hans de Goede wrote:
>>>> --- a/include/linux/apple-gmux.h
>>>> +++ b/include/linux/apple-gmux.h
>>> [...]
>>>> +static inline bool apple_gmux_is_indexed(unsigned long iostart)
>>>> +{
>>>> +	u16 val;
>>>> +
>>>> +	outb(0xaa, iostart + 0xcc);
>>>> +	outb(0x55, iostart + 0xcd);
>>>> +	outb(0x00, iostart + 0xce);
>>>> +
>>>> +	val = inb(iostart + 0xcc) | (inb(iostart + 0xcd) << 8);
>>>> +	if (val == 0x55aa)
>>>> +		return true;
>>>> +
>>>> +	return false;
>>>> +}
>>>
>>> Something like this, and especially the large apple_gmux_detect() below,
>>> should not live in a header file.
>>
>> I understand where you are coming from, but these functions really
>> are not that large.
>>
>>> Why can't apple_gmux.ko just export a detection function which is used
>>> both internally and as a helper by the backlight detection?
>>
>> Both the acpi-video code and the apple-gmux code can be built as
>> modules. So this will break if the acpi-video code get builtin
>> and the apple-gmux code does not.
>>
>> This can be worked around in Kconfig by adding something like:
>>
>> 	depends on APPLE_GMUX || APPLE_GMUX=n
>>
>> to the ACPI_VIDEO Kconfig bits and then cross our fingers
>> we don't get some Kconfig circular dep thing causing things
>> to error out.
> 
> Can we force APPLE_GMUX to be built-in if ACPI_VIDEO is?
> 
> Would making APPLE_GMUX depend on ACPI_VIDEO (instead of
> "ACPI_VIDEO=n || ACPI_VIDEO") achieve that?  I believe
> APPLE_GMUX would then inherit the setting of ACPI_VIDEO?

I'm afraid that won't work, make it depend on ACPI_VIDEO would not
make it inherit ACPI_VIDEO's setting instead it would be limited
to ACPI_VIDEO's setting.

So if we make APPLE_GMUX "depends on ACPI_VIDEO" and ACPI_VIDEO=y
then APPLE_GMUX can be both Y or M, where as if ACPI_VIDEO=m
then APPLE_GMUX can only be m.

Note that the APPLE_GMUX Kconfig "ACPI_VIDEO=n || ACPI_VIDEO"
bit is obsolete and should be dropped (I have already prepared
a patch for this), the apple_gmux code no longer depends on any
of the ACPI_VIDEO symbols.  Which does make it possible to
add a dependency the other way.

I just tried the following:

--- a/drivers/acpi/Kconfig
+++ b/drivers/acpi/Kconfig
@@ -210,6 +210,8 @@ config ACPI_VIDEO
 	depends on BACKLIGHT_CLASS_DEVICE
 	depends on INPUT
 	depends on ACPI_WMI || !X86
+	# ACPI_VIDEO uses symbols from APPLE_GMUX if that is enabled
+	depends on APPLE_GMUX || APPLE_GMUX=n
 	select THERMAL
 	help
 	  This driver implements the ACPI Extensions For Display Adapters

And that does not cause any circular dep issues it seems, so 
If we really want to have the detection code inside apple_gmux then
we could use the above and have the acpi-video code depend on
apple_gmux.ko.  I'm not a fan of that though, as mentioned before
the intent for the acpi-video code's detection parts is to be
as much standalone code as possible.

Regards,

Hans

