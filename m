Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D2E02B6FEA
	for <lists+linux-acpi@lfdr.de>; Tue, 17 Nov 2020 21:20:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726277AbgKQUSz (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 17 Nov 2020 15:18:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726199AbgKQUS1 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 17 Nov 2020 15:18:27 -0500
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0873FC0613CF;
        Tue, 17 Nov 2020 12:18:27 -0800 (PST)
Received: by mail-ej1-x644.google.com with SMTP id oq3so31222555ejb.7;
        Tue, 17 Nov 2020 12:18:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=fIU0MW88AbSfhYMosxAQzBN+NCriw7f/UYq8KSXIzWQ=;
        b=dbLF8W5KNsmWOmz2qHRlSyZrHZvARH78/rsiE1Ma8Niv1s8yloadlFdv7A+d208B7d
         KrsBLhHgSCjmCTzUMkxa/cvwYcp/mluAq893fGgxVV2EF6v2woH8PA581PcsnhYRYn8U
         MsL9laTiPe65EcA2aBkn1HbAsn0fZZQhtCfO63ZHiLX0RYYkRcIFhLb2krKJkgfX9k4R
         41S1af+g7TFncbr+pEIck5Rmm5CgUzne8gOGlOdxA/J9dzTBoLeFY8ogaijvJJBmPNhI
         MGei7xMLZIPEAfui+gsFwzpd41grOxWIY2uHMFcbNBy3BJOragQRYf/uumtOB91SLI/F
         feLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=fIU0MW88AbSfhYMosxAQzBN+NCriw7f/UYq8KSXIzWQ=;
        b=oLmn6SuvXZvyyZN6bH3hr2Dln3XdvB40HG5yLOl8+It18sN/IDnnwbje7jj6jdjC97
         OqucpvEwo/VwKRJ6buqbq5ZXb/vIJnMiDvi05RRFqHQsPjW0YYQGizbytn4S8AsusHzO
         LBMLykxKBOTQ0Lw5CGg8dz8WyS9WGoKJVROnVBIorNOasrif6JiOCs3JmbzmVvxEXT5+
         CVsn0Mqpt9MRAv9dogxnSH8jm3Xn4yVIdK8Ip7AH/7LH/VbWfxMcHYTkC4Ujpg/gHkUs
         OqAjTcyN/W+maXovcIq9GaGjzHZyRM0GvPD5xKFQcdQjSRF9FAH3pX3Pm7qXD2lRRwTn
         bNDw==
X-Gm-Message-State: AOAM531uqq/S2wuMxPoEQuv5TKI89Rzho73zYnnOlPUIplp5H1SDJZZ4
        JcqVYLar4+koXGyNN8tjCCB4vngPEQQ=
X-Google-Smtp-Source: ABdhPJxLrJlp7h5qgyl7mUVpHsvV6ExijuEYUfKBsdwo5prZ+eJGBuK8fm6AhkH+mYE44QtYQU392w==
X-Received: by 2002:a17:906:6a57:: with SMTP id n23mr22331059ejs.315.1605644305444;
        Tue, 17 Nov 2020 12:18:25 -0800 (PST)
Received: from [192.168.2.202] (pd9e5afac.dip0.t-ipconnect.de. [217.229.175.172])
        by smtp.gmail.com with ESMTPSA id fy4sm776820ejb.91.2020.11.17.12.18.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Nov 2020 12:18:24 -0800 (PST)
Subject: Re: [PATCH 9/9] platform/surface: Add Surface ACPI Notify driver
To:     Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <mgross@linux.intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        =?UTF-8?Q?Bla=c5=be_Hrastnik?= <blaz@mxxn.io>,
        Dorian Stoll <dorian.stoll@tmsp.io>,
        platform-driver-x86@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-doc@vger.kernel.org
References: <20201115192143.21571-1-luzmaximilian@gmail.com>
 <20201115192143.21571-10-luzmaximilian@gmail.com>
 <4ad59722-6834-a0f9-8d7a-16b8f22a1f26@infradead.org>
From:   Maximilian Luz <luzmaximilian@gmail.com>
Message-ID: <7973f3e1-40f3-4795-bdea-719fecaa3448@gmail.com>
Date:   Tue, 17 Nov 2020 21:18:23 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <4ad59722-6834-a0f9-8d7a-16b8f22a1f26@infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 11/17/20 9:09 PM, Randy Dunlap wrote:
> On 11/15/20 11:21 AM, Maximilian Luz wrote:
>> diff --git a/drivers/platform/surface/Kconfig b/drivers/platform/surface/Kconfig
>> index cecad7a0cb7b..3b0da86546fa 100644
>> --- a/drivers/platform/surface/Kconfig
>> +++ b/drivers/platform/surface/Kconfig
>> @@ -40,6 +40,26 @@ config SURFACE_3_POWER_OPREGION
>>   	  This driver provides support for ACPI operation
>>   	  region of the Surface 3 battery platform driver.
>>   
>> +config SURFACE_ACPI_NOTIFY
>> +	tristate "Surface ACPI Notify Driver"
>> +	depends on ACPI
>> +	depends on SURFACE_AGGREGATOR
>> +	help
>> +	  Surface ACPI Notify (SAN) driver for Microsoft Surface devices.
> 
> Drop "depends on ACPI" since SURFACE_AGGREGATOR already depends on ACPI.

Okay, will do that.

Thanks,
Max
