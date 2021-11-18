Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E621C45597C
	for <lists+linux-acpi@lfdr.de>; Thu, 18 Nov 2021 11:56:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245669AbhKRK7E (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 18 Nov 2021 05:59:04 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:58629 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S245675AbhKRK7B (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 18 Nov 2021 05:59:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1637232961;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9GsD+o3RBIDK5q4Dr+za2tCHVbf+A5m16mQLXUMGsEI=;
        b=KudRrqRhJquFqd1KPqdF/P88ib0TYDNho3HKAOBZMhRQm22GcBDFpMfaChFCaW4vcVgaNA
        JbICJRapk48jhjcQXVFkA53SSMvGeQf/OeBemWNd44RsS+W0K3HdwwNRNlT8XkGKJUGEG6
        0yP04du0L8xYCZcTl6lam8hcVf0+rQg=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-231-InYgRIoBNeO-RXAFzzAcug-1; Thu, 18 Nov 2021 05:56:00 -0500
X-MC-Unique: InYgRIoBNeO-RXAFzzAcug-1
Received: by mail-ed1-f72.google.com with SMTP id d11-20020a50cd4b000000b003da63711a8aso4884615edj.20
        for <linux-acpi@vger.kernel.org>; Thu, 18 Nov 2021 02:56:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=9GsD+o3RBIDK5q4Dr+za2tCHVbf+A5m16mQLXUMGsEI=;
        b=P/xA+cjnVg3H27xN+FWBBkXweG2TvvQdODLB080qsfeK+hKl3rTWpjZNVTy2vMxxzE
         Y97v6iUZHFyClfstsWlj9UWXM9CUd2tRsOFNw7nxxdKCiQH2t9ujRszxx5CJ6S7+3SVI
         uLZtVLelrP+9jHQBOelIIC4I/U2tXUsHLO/q+snHppILwnFSzQNhGSFu3pjoyTuMSthz
         KSsztYl5eJ5YOQBQ12SPT+WTAFkGTXUSG3+fC4Y0VV69UNa1OFbaYdqQR5RQB/mwiZ7n
         Wejefw7rScV182nhgQphgPqfu2lrsrkV9bTJ2tmyvaN045sMc65NRr7hizhltWzZVZGr
         Vc6w==
X-Gm-Message-State: AOAM532r0IG2lP+zs5U06XW5R3QMCRjrmo3WDfViIRTlUKe+rHz5Sc7f
        XT+XN+MDQVRuQ319gqMz4Cnhsp7T9R9mr062bLLjIrMVcuVMCPk2Hi8Ifd6/Z2tzWJ8SDpaLdiP
        cGUudMVYCMOob0kiJiocr8A==
X-Received: by 2002:a17:907:2cc3:: with SMTP id hg3mr32676002ejc.452.1637232958942;
        Thu, 18 Nov 2021 02:55:58 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwGACg79fvn2uTlptkYznm2w7lRwcXNh+xG/R9Y9eAWj1HKygF6eSByVVRgv2fIJG3Ka2ywlg==
X-Received: by 2002:a17:907:2cc3:: with SMTP id hg3mr32675969ejc.452.1637232958748;
        Thu, 18 Nov 2021 02:55:58 -0800 (PST)
Received: from ?IPV6:2001:1c00:c1e:bf00:1054:9d19:e0f0:8214? (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id sb8sm1254983ejc.51.2021.11.18.02.55.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Nov 2021 02:55:58 -0800 (PST)
Message-ID: <c2d19ca4-5893-1642-3289-cf05a81b55d3@redhat.com>
Date:   Thu, 18 Nov 2021 11:55:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH 1/3] pinctrl: cherryview: Don't use pin/offset 0 to mark
 an interrupt-line as unused
Content-Language: en-US
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     Andy Shevchenko <andy@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org,
        Yauhen Kharuzhy <jekhor@gmail.com>
References: <20211117231614.758362-1-hdegoede@redhat.com>
 <YZYnTbubff1trHkv@lahna>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <YZYnTbubff1trHkv@lahna>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Mika,

On 11/18/21 11:13, Mika Westerberg wrote:
> Hi Hans,
> 
> Few minor comments below.

Thank you for the review. I'll send a new version addressing
all your remarks.

Regards,

Hans


> 
> On Thu, Nov 18, 2021 at 12:16:12AM +0100, Hans de Goede wrote:
>> offset/pin 0 is a perfectly valid offset, so stop using it to have
> 
> Offset/pin (with capital O).
> 
>> the special meaning of interrupt-line not used in the intr_lines.
> 
> interrupt line
> 
>> Instead introduce a new special INTR_LINE_UNUSED value which is never
>> a valid offset and use that to indicate unused interrupt-lines.
> 
> interrupt lines
> 
>> Cc: Yauhen Kharuzhy <jekhor@gmail.com>
>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>> ---
>>  drivers/pinctrl/intel/pinctrl-cherryview.c | 19 ++++++++++++++++---
>>  1 file changed, 16 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/pinctrl/intel/pinctrl-cherryview.c b/drivers/pinctrl/intel/pinctrl-cherryview.c
>> index 980099028cf8..a46f9e5a4748 100644
>> --- a/drivers/pinctrl/intel/pinctrl-cherryview.c
>> +++ b/drivers/pinctrl/intel/pinctrl-cherryview.c
>> @@ -73,6 +73,8 @@ struct intel_pad_context {
>>  	u32 padctrl1;
>>  };
>>  
>> +#define INTR_LINE_UNUSED		U32_MAX
>> +
>>  /**
>>   * struct intel_community_context - community context for Cherryview
>>   * @intr_lines: Mapping between 16 HW interrupt wires and GPIO offset (in GPIO number space)
>> @@ -812,7 +814,7 @@ static int chv_gpio_request_enable(struct pinctrl_dev *pctldev,
>>  		/* Reset the interrupt mapping */
>>  		for (i = 0; i < ARRAY_SIZE(cctx->intr_lines); i++) {
>>  			if (cctx->intr_lines[i] == offset) {
>> -				cctx->intr_lines[i] = 0;
>> +				cctx->intr_lines[i] = INTR_LINE_UNUSED;
>>  				break;
>>  			}
>>  		}
>> @@ -1319,7 +1321,7 @@ static unsigned chv_gpio_irq_startup(struct irq_data *d)
>>  		else
>>  			handler = handle_edge_irq;
>>  
>> -		if (!cctx->intr_lines[intsel]) {
>> +		if (cctx->intr_lines[intsel] == INTR_LINE_UNUSED) {
>>  			irq_set_handler_locked(d, handler);
>>  			cctx->intr_lines[intsel] = pin;
>>  		}
>> @@ -1412,6 +1414,12 @@ static void chv_gpio_irq_handler(struct irq_desc *desc)
>>  		unsigned int offset;
>>  
>>  		offset = cctx->intr_lines[intr_line];
>> +		if (offset == INTR_LINE_UNUSED) {
>> +			dev_err(pctrl->dev, "Interrupt on unused interrupt line %u\n",
> 
> Let's be consistent with the logging so no capital letter here =>
> "interrupt on .."
> 
>> +				intr_line);
>> +			continue;
>> +		}
>> +
>>  		generic_handle_domain_irq(gc->irq.domain, offset);
>>  	}
>>  
>> @@ -1620,9 +1628,10 @@ static int chv_pinctrl_probe(struct platform_device *pdev)
>>  	struct intel_community *community;
>>  	struct device *dev = &pdev->dev;
>>  	struct acpi_device *adev = ACPI_COMPANION(dev);
>> +	struct intel_community_context *cctx;
>>  	struct intel_pinctrl *pctrl;
>>  	acpi_status status;
>> -	int ret, irq;
>> +	int i, ret, irq;
>>  
>>  	soc_data = intel_pinctrl_get_soc_data(pdev);
>>  	if (IS_ERR(soc_data))
>> @@ -1663,6 +1672,10 @@ static int chv_pinctrl_probe(struct platform_device *pdev)
>>  	if (!pctrl->context.communities)
>>  		return -ENOMEM;
>>  
>> +	cctx = &pctrl->context.communities[0];
>> +	for (i = 0; i < ARRAY_SIZE(cctx->intr_lines); i++)
>> +		cctx->intr_lines[i] = INTR_LINE_UNUSED;
>> +
>>  	irq = platform_get_irq(pdev, 0);
>>  	if (irq < 0)
>>  		return irq;
>> -- 
>> 2.31.1
> 

