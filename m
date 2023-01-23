Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CE5F677ED0
	for <lists+linux-acpi@lfdr.de>; Mon, 23 Jan 2023 16:11:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232234AbjAWPLM (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 23 Jan 2023 10:11:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231547AbjAWPLL (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 23 Jan 2023 10:11:11 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B226813508
        for <linux-acpi@vger.kernel.org>; Mon, 23 Jan 2023 07:10:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674486627;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fmap69GAARLOEaTycvmFa7dlDHy8lvFIgVzaeRPkzcs=;
        b=ZGUp1px6H7WVCTvETv4TT49fPS4RjnIextafIAJnxOxIMsnipPRmxogSVEmSCbfGlRwkOi
        VObl9FFQKF33gFZ3fWYqIumN/MtLi+BJ5A/yWgtWSLElkYNIxluulIT1L3A0IAPTsD6xzz
        +pGlUbNq9PX60ZBtCZ+1d0zgjM9l7Mg=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-170-BCgD-nIRN3Sa-XuNvElksA-1; Mon, 23 Jan 2023 10:10:26 -0500
X-MC-Unique: BCgD-nIRN3Sa-XuNvElksA-1
Received: by mail-ej1-f69.google.com with SMTP id wz4-20020a170906fe4400b0084c7e7eb6d0so7899002ejb.19
        for <linux-acpi@vger.kernel.org>; Mon, 23 Jan 2023 07:10:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fmap69GAARLOEaTycvmFa7dlDHy8lvFIgVzaeRPkzcs=;
        b=0apTF45GaMQTjxrG1Kck/SdImz4OL7beWAF4uQbdeSMvIsHr8KP58tfPaHBrC41QbX
         vAAsshQgANWmhoEhNj0X2pxyWqHiRHee/aq/e8BmHx16OAo/rytCm7ur5kCMNK8RUFsG
         uhcS0RpXRikpPZG9JqQn3v+Lhckbe8/mP+TzOnSW+IVyzOsYUXsok6Zv1eUNTrGX5nmK
         pyyOpVaK/6qqkWF9HZmiUJS2BkWpa9MuNePo3T9ytKdf3ebfoEHNWp8cgLxV4okhyUGG
         bU5gYHzRLXnovRNd+KZKn7DrBIxPZTUiNuhHnBhKMl9ZLKlLu4mz31G0eBvN7SVyF/Bc
         uMtA==
X-Gm-Message-State: AFqh2ko/E2Z8m6jwfDw2kGPDJv+qpNbf2St17iouA+z5Rblbvv1C333S
        6GXh4kTpjBrZ5Skzy4RwpgZZf9s6fND8S/CYtuoNCOn08oPyBrweRXJ38FQZ87jKBHUK8U6mv6A
        9Mn+jr9RoBwMq2vwHFa4Xdg==
X-Received: by 2002:a17:906:8d0f:b0:870:b950:18d4 with SMTP id rv15-20020a1709068d0f00b00870b95018d4mr28481238ejc.5.1674486625030;
        Mon, 23 Jan 2023 07:10:25 -0800 (PST)
X-Google-Smtp-Source: AMrXdXv+mOXznbb9ctsRkLFnb1W9dMN1iRIkGODPHCo2RtV1KcMF0smb9ggMnQqPayBO1qTkPZ13Xg==
X-Received: by 2002:a17:906:8d0f:b0:870:b950:18d4 with SMTP id rv15-20020a1709068d0f00b00870b95018d4mr28481221ejc.5.1674486624818;
        Mon, 23 Jan 2023 07:10:24 -0800 (PST)
Received: from [10.40.98.142] ([78.108.130.194])
        by smtp.gmail.com with ESMTPSA id g21-20020a170906869500b0084d36fd208esm21416112ejx.18.2023.01.23.07.10.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Jan 2023 07:10:24 -0800 (PST)
Message-ID: <1db86ea3-a658-fe4f-53ae-cc16e5fa125c@redhat.com>
Date:   Mon, 23 Jan 2023 16:10:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH 2/3] platform/x86: apple-gmux: Add apple_gmux_detect()
 helper
Content-Language: en-US
From:   Hans de Goede <hdegoede@redhat.com>
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
 <a02857d6-83c1-07f7-ebf0-f0b15b190f60@redhat.com>
In-Reply-To: <a02857d6-83c1-07f7-ebf0-f0b15b190f60@redhat.com>
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

On 1/23/23 16:05, Hans de Goede wrote:
> Hi,
> 
> On 1/23/23 15:23, Lukas Wunner wrote:
>> On Mon, Jan 23, 2023 at 03:13:28PM +0100, Hans de Goede wrote:
>>> On 1/23/23 14:49, Lukas Wunner wrote:
>>>> On Mon, Jan 23, 2023 at 12:37:49PM +0100, Hans de Goede wrote:
>>>>> --- a/include/linux/apple-gmux.h
>>>>> +++ b/include/linux/apple-gmux.h
>>>> [...]
>>>>> +static inline bool apple_gmux_is_indexed(unsigned long iostart)
>>>>> +{
>>>>> +	u16 val;
>>>>> +
>>>>> +	outb(0xaa, iostart + 0xcc);
>>>>> +	outb(0x55, iostart + 0xcd);
>>>>> +	outb(0x00, iostart + 0xce);
>>>>> +
>>>>> +	val = inb(iostart + 0xcc) | (inb(iostart + 0xcd) << 8);
>>>>> +	if (val == 0x55aa)
>>>>> +		return true;
>>>>> +
>>>>> +	return false;
>>>>> +}
>>>>
>>>> Something like this, and especially the large apple_gmux_detect() below,
>>>> should not live in a header file.
>>>
>>> I understand where you are coming from, but these functions really
>>> are not that large.
>>>
>>>> Why can't apple_gmux.ko just export a detection function which is used
>>>> both internally and as a helper by the backlight detection?
>>>
>>> Both the acpi-video code and the apple-gmux code can be built as
>>> modules. So this will break if the acpi-video code get builtin
>>> and the apple-gmux code does not.
>>>
>>> This can be worked around in Kconfig by adding something like:
>>>
>>> 	depends on APPLE_GMUX || APPLE_GMUX=n
>>>
>>> to the ACPI_VIDEO Kconfig bits and then cross our fingers
>>> we don't get some Kconfig circular dep thing causing things
>>> to error out.
>>
>> Can we force APPLE_GMUX to be built-in if ACPI_VIDEO is?
>>
>> Would making APPLE_GMUX depend on ACPI_VIDEO (instead of
>> "ACPI_VIDEO=n || ACPI_VIDEO") achieve that?  I believe
>> APPLE_GMUX would then inherit the setting of ACPI_VIDEO?
> 
> I'm afraid that won't work, make it depend on ACPI_VIDEO would not
> make it inherit ACPI_VIDEO's setting instead it would be limited
> to ACPI_VIDEO's setting.
> 
> So if we make APPLE_GMUX "depends on ACPI_VIDEO" and ACPI_VIDEO=y
> then APPLE_GMUX can be both Y or M, where as if ACPI_VIDEO=m
> then APPLE_GMUX can only be m.
> 
> Note that the APPLE_GMUX Kconfig "ACPI_VIDEO=n || ACPI_VIDEO"
> bit is obsolete and should be dropped (I have already prepared
> a patch for this), the apple_gmux code no longer depends on any
> of the ACPI_VIDEO symbols.  Which does make it possible to
> add a dependency the other way.
> 
> I just tried the following:
> 
> --- a/drivers/acpi/Kconfig
> +++ b/drivers/acpi/Kconfig
> @@ -210,6 +210,8 @@ config ACPI_VIDEO
>  	depends on BACKLIGHT_CLASS_DEVICE
>  	depends on INPUT
>  	depends on ACPI_WMI || !X86
> +	# ACPI_VIDEO uses symbols from APPLE_GMUX if that is enabled
> +	depends on APPLE_GMUX || APPLE_GMUX=n
>  	select THERMAL
>  	help
>  	  This driver implements the ACPI Extensions For Display Adapters
> 
> And that does not cause any circular dep issues it seems

And 10 seconds after hitting send I realized that things are not this simple,
because a bunch of other Kconfig bits do "select ACPI_VIDEO" and Kconfig
bits doing "select FOO" much make sure all the dependencies of FOO are met
and we have just added a new dependency...

So all those other places then would need something similar. Kconfig is
great, but with intra dependencies it really can get quite hairy.

So IMHO the (really not that big) static inline detect function really
is the best solution here.

Regards,

Hans



