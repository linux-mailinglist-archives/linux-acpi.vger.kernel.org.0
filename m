Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3E9139F7C3
	for <lists+linux-acpi@lfdr.de>; Tue,  8 Jun 2021 15:24:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232940AbhFHN02 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 8 Jun 2021 09:26:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:30129 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232823AbhFHN0Z (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 8 Jun 2021 09:26:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623158672;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=brIbnPOD/BK5YsLnUZ2t11ArliAy+cQp/GfRlPgoYLQ=;
        b=VrjdHzEXccCqIoJ20aRjPnyPJg6rJrTSRO/EO24+XwJ5uy/+LP361lA55QeyNIum6lHbYR
        lMwmWO6gUayOy5dK0YYYkng3XCpW9i5BodURwCFk+V8u7TYkY/FNaXoQSKkWXssXVP6k/y
        bx308b7hS2tJTSTmXa2qzBT5w2WNBjM=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-280-3bMTs7LxPSiJsAMm7mLe3Q-1; Tue, 08 Jun 2021 09:24:31 -0400
X-MC-Unique: 3bMTs7LxPSiJsAMm7mLe3Q-1
Received: by mail-ed1-f71.google.com with SMTP id t11-20020a056402524bb029038ffacf1cafso1494097edd.5
        for <linux-acpi@vger.kernel.org>; Tue, 08 Jun 2021 06:24:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=brIbnPOD/BK5YsLnUZ2t11ArliAy+cQp/GfRlPgoYLQ=;
        b=B8DpQC7uB2sVQoSG25yLb8CEOeH/meSok9NzGcFZjLgIGIokmuQz80xZDH+jTNVouJ
         YUYNtLjb/UyFjS/xgt2GjDald5OLQoiWjds+Hyv2IrzgLtWOPx9GAv0B2ZRuB3cUdYjG
         DXSciAXsb/zgW7poPRWioeikHifk0baaT57xTy+2CL5opL1gBrGPEJN7F4bfKg+PLgNS
         jTL9A/e38Uw4OJ7HypRdVVxAsw+PPdmUlaF9rJC0earfBIMxjuqPw+SfmyXLsXHkLf7q
         fPzq33VIJPL3TET2NgBNbkyLVAeYa/H++tI1Vb0/BnGhdNH5u8Fa42+iikVCBUutf44a
         GOqA==
X-Gm-Message-State: AOAM5301KyclqNMmax3cAoTHPStLMqkw4oavPx5JgiKodOyMS+b66uFi
        60yhPm76G2+57Jej3+nvmnhA32k64A3E4eA5tCRO25P/upnIow4Ynd3DyaeWQIcwxdTFjUyTBRQ
        6H4/OwmElF/v6h4g0MBo2hZpYVZLDLQOcTDeUSdDOQ5teo0qJ9w3v5Q65hOqAfICk8jL3pedhkw
        ==
X-Received: by 2002:a05:6402:2805:: with SMTP id h5mr9270073ede.379.1623158669791;
        Tue, 08 Jun 2021 06:24:29 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzofuOiACZmjwI5NUJ0a6BHxTEsZcwZ+HMcFcQXfBHfodtcqOR3sUy+XnP5l/QkGHasGMnTgw==
X-Received: by 2002:a05:6402:2805:: with SMTP id h5mr9270033ede.379.1623158669519;
        Tue, 08 Jun 2021 06:24:29 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id p13sm8855663edq.67.2021.06.08.06.24.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Jun 2021 06:24:29 -0700 (PDT)
Subject: Re: Some SSDT tables are not loading with kernel >= 5.12
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     Mario Limonciello <mario.limonciello@outlook.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        linux-acpi <linux-acpi@vger.kernel.org>
References: <f634a05a-e3a9-93ab-4b87-d41f5ee083a5@redhat.com>
 <93d783c4-4468-023b-193e-3fc6eca35445@redhat.com>
 <a3c05e2f-af1c-ef19-4c9a-6b5b82d2da6d@redhat.com>
 <CAJZ5v0hYnEes7SDqwSqTGKQf4Qebr=gmj_qSQOPWKQzPdpAwrw@mail.gmail.com>
 <FR1PR80MB5051E91269FD36681BB357A7E1389@FR1PR80MB5051.lamprd80.prod.outlook.com>
 <YL5EjVDYLPhRKMIA@lahna.fi.intel.com>
 <209a230c-a7a6-7a8e-0515-97fb534d7401@redhat.com>
 <0f733402-ae3b-b4e7-13c4-e6161f9c7e81@redhat.com>
 <YL9YOlLosVeYfuuu@lahna.fi.intel.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <edeba86c-1db7-e547-09a0-27da405155b3@redhat.com>
Date:   Tue, 8 Jun 2021 15:24:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <YL9YOlLosVeYfuuu@lahna.fi.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi,

On 6/8/21 1:44 PM, Mika Westerberg wrote:
> Hi,
> 
> On Tue, Jun 08, 2021 at 11:50:15AM +0200, Hans de Goede wrote:
>> Hi,
>>
>> On 6/7/21 9:18 PM, Hans de Goede wrote:
>>> Hi,
>>>
>>> On 6/7/21 6:08 PM, Mika Westerberg wrote:
>>>> Hi,
>>>>
>>>> Tried now on ADL-P and TGL systems and the _OSC still works properly.
>>>>
>>>> Thanks Hans for fixing!
>>>>
>>>> Feel free to add my Tested-by.
>>>
>>> Thank you for testing, unfortunately so far from the comments here:
>>>
>>> https://bugzilla.kernel.org/show_bug.cgi?id=213023
>>>
>>> it seems that my patch does not help resolve the issues caused
>>> by commit 719e1f561afb ("ACPI: Execute platform _OSC also with query
>>> bit clear"), where as reverting that commit does resolve them :|
>>>
>>> Does anyone have any other ideas how to fix this ?
>>
>> The reporter who has done the bisect has commented out the new/second
>> _OSC call and that fixes things for them. So I've written a new fix
>> (attached), note just as before this is untested ATM.
>>
>> Mika, if you can test this one (it replaces the previous one)
>> on machines with native USB4 support to check those don't regress then
>> that would be great.
> 
> I can test it sure, but first let's try to understand what the problem is :)
> 
>> I've asked the various reporters from the 2 bugzilla's for this to also
>> test this new patch. I'll let you know how that goes.
> 
> The _OSC on at least one of the affected platforms look like this:
> 
>     If ((Arg0 == ToUUID ("0811b06e-4a27-44f9-8d60-3cbbc22e7b48") /* Platform-wide Capabilities */))
>     {
> 	If ((Arg1 == One))
> 	{
> 	    OSCP = CAP0 /* \_SB_._OSC.CAP0 */
> 	    If ((CAP0 & 0x04))
> 	    {
> 		OSCO = 0x04
> 		If (((SGMD & 0x0F) != 0x02))
> 		{
> 		    If ((RTD3 == Zero))
> 		    {
> 			CAP0 &= 0x3B
> 			STS0 |= 0x10
> 		    }
> 		}
> 	    }
> 	}
> 	Else
> 	{
> 	    STS0 &= 0xFFFFFF00
> 	    STS0 |= 0x0A
> 	}
>     }
>     Else
>     {
> 	STS0 &= 0xFFFFFF00
> 	STS0 |= 0x06
>     }
> 
> Probably it is fine to call it several times but the issue is with the mask
> that it does:
> 
>     CAP0 &= 0x3B
> 
> This clears out the upper bits. I think this is actually a BIOS bug as it ends
> up clearing OSC_SB_PCLPI_SUPPORT which is probably not intented, and that seems
> to cause skipping of the LPI tables or something like that.
> 
> The alternative is to pass the original caps to the second _OSC call. I think
> this is safe too. While looking at the code, I found a couple of other issues
> that should be fixed with the below hack patch.
> 
> What do you think about this approach?

I think you might be on to something, quoting from the spec:

"""
6.2.11.1.3 Sequence of _OSC calls
The following rules govern sequences of calls to _OSC that are issued to the same host bridge and
occur within the same boot.
• The OS is permitted to evaluate _OSC an arbitrary number of times.
• If the OS declares support of a feature in the Status Field in one call to _OSC, then it must
preserve the set state of that bit (declaring support for that feature) in all subsequent calls.
• If the OS is granted control of a feature in the Control Field in one call to _OSC, then it must
preserve the set state of that bit (requesting that feature) in all subsequent calls.
"""

So the spec is saying that we should indeed keep all the flags which set during
the first call also set during subsequent calls.

If you can turn this into a proper patch then I can ask the reporters of
the 2 bugs to test that patch.

Regards,

Hans






> 
> diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
> index be7da23fad76..80ff81bb668b 100644
> --- a/drivers/acpi/bus.c
> +++ b/drivers/acpi/bus.c
> @@ -290,7 +290,7 @@ static void acpi_bus_osc_negotiate_platform_control(void)
>  	struct acpi_osc_context context = {
>  		.uuid_str = sb_uuid_str,
>  		.rev = 1,
> -		.cap.length = 8,
> +		.cap.length = sizeof(capbuf),
>  		.cap.pointer = capbuf,
>  	};
>  	acpi_handle handle;
> @@ -330,32 +330,21 @@ static void acpi_bus_osc_negotiate_platform_control(void)
>  	if (ACPI_FAILURE(acpi_run_osc(handle, &context)))
>  		return;
>  
> -	capbuf_ret = context.ret.pointer;
> -	if (context.ret.length <= OSC_SUPPORT_DWORD) {
> -		kfree(context.ret.pointer);
> -		return;
> -	}
> +	kfree(context.ret.pointer);
>  
> -	/*
> -	 * Now run _OSC again with query flag clear and with the caps
> -	 * supported by both the OS and the platform.
> -	 */
> +	/* Now run _OSC again with query flag clear */
>  	capbuf[OSC_QUERY_DWORD] = 0;
> -	capbuf[OSC_SUPPORT_DWORD] = capbuf_ret[OSC_SUPPORT_DWORD];
> -	kfree(context.ret.pointer);
>  
>  	if (ACPI_FAILURE(acpi_run_osc(handle, &context)))
>  		return;
>  
>  	capbuf_ret = context.ret.pointer;
> -	if (context.ret.length > OSC_SUPPORT_DWORD) {
> -		osc_sb_apei_support_acked =
> -			capbuf_ret[OSC_SUPPORT_DWORD] & OSC_SB_APEI_SUPPORT;
> -		osc_pc_lpi_support_confirmed =
> -			capbuf_ret[OSC_SUPPORT_DWORD] & OSC_SB_PCLPI_SUPPORT;
> -		osc_sb_native_usb4_support_confirmed =
> -			capbuf_ret[OSC_SUPPORT_DWORD] & OSC_SB_NATIVE_USB4_SUPPORT;
> -	}
> +	osc_sb_apei_support_acked =
> +		capbuf_ret[OSC_SUPPORT_DWORD] & OSC_SB_APEI_SUPPORT;
> +	osc_pc_lpi_support_confirmed =
> +		capbuf_ret[OSC_SUPPORT_DWORD] & OSC_SB_PCLPI_SUPPORT;
> +	osc_sb_native_usb4_support_confirmed =
> +		capbuf_ret[OSC_SUPPORT_DWORD] & OSC_SB_NATIVE_USB4_SUPPORT;
>  
>  	kfree(context.ret.pointer);
>  }
> 

