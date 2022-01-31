Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 836324A497D
	for <lists+linux-acpi@lfdr.de>; Mon, 31 Jan 2022 15:39:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238791AbiAaOjk (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 31 Jan 2022 09:39:40 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:41378 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238432AbiAaOjk (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 31 Jan 2022 09:39:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643639980;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=R0oDEaFGdibME6lqfi97Zey91X/PgbW0htlflxKdk5k=;
        b=bhmr/zMOadt422CdiWAfqLT2xOyYJuuJ+tmHPFlt9vIAX54LmY4N4J8x/U5I4exjXZFdTu
        3u4nx1PnPcCoB5uluy4a3vHCGPO4wwZhWXFOvaJbCa97oBCNVZF40NJcnQuXmR0xnoSyfD
        wSwgcopWOVzJNxaMno0BHgkbCp+5eZM=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-228-_BAm0JhHPA6CGX-82VQqXg-1; Mon, 31 Jan 2022 09:39:38 -0500
X-MC-Unique: _BAm0JhHPA6CGX-82VQqXg-1
Received: by mail-ej1-f70.google.com with SMTP id o4-20020a170906768400b006a981625756so5131432ejm.0
        for <linux-acpi@vger.kernel.org>; Mon, 31 Jan 2022 06:39:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=R0oDEaFGdibME6lqfi97Zey91X/PgbW0htlflxKdk5k=;
        b=DvUy06aPaUcdeEyeagWTdwMVC0y5dY2Sfsl5GbkT3IaVCvUpeVWSf0cGlNPRwLwAPz
         f91/gf+5QamPd4Z1nGasD331ho16pIj3oSYdHDQs6vOu8n25/cWIg7EBUgOA8LMQxz/g
         QDHireWxyLQ8BJWwVgeTu3QNzmDPfM88Mxbvvc127pKgqGOHaT8V7qgMBi9ErjeTOaT7
         vVoCBjknt5M/myoD32c4EtE2Y+rhdja/gIQzXG6gi8kcEN/fqNjmFGcOoXD2x4JW0Pyp
         e7uVcsXrsaIqoaLqoF7ertPUaXtjlrmwEqx1L6JEzEWJf6034oUf8qLO+YxplJNL45G1
         UEMw==
X-Gm-Message-State: AOAM531pHqfv4oVSju7H9Znmc1o8U/noNuu05AvosTJyLGqw6HEc4Y+a
        SZ3s14gCZ8Jmgn1HOCrVxIQGTG92s/rZlZC5CNz0n7mU0g/sevJENtQk9QrAdvZPE6KOjS5Xifz
        PZ9BQZHc8MyiR70lpDwk2vA==
X-Received: by 2002:a17:907:3d01:: with SMTP id gm1mr1106334ejc.695.1643639977291;
        Mon, 31 Jan 2022 06:39:37 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzix88rypjQ9PzeqG917MJ5ZswKyPWRnGuIiC5bkUAy88MpUabwzv3XiWV6ICCl8U202+QhVQ==
X-Received: by 2002:a17:907:3d01:: with SMTP id gm1mr1106311ejc.695.1643639977039;
        Mon, 31 Jan 2022 06:39:37 -0800 (PST)
Received: from [10.40.98.142] ([78.108.130.194])
        by smtp.gmail.com with ESMTPSA id s20sm13504159ejc.189.2022.01.31.06.39.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Jan 2022 06:39:36 -0800 (PST)
Message-ID: <91bfb535-9442-9413-cfca-1b5cb08826ed@redhat.com>
Date:   Mon, 31 Jan 2022 15:39:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH v4 01/20] power: supply: core: Refactor
 power_supply_set_input_current_limit_from_supplier()
Content-Language: en-US
To:     Andy Shevchenko <andriy.shevchenko@intel.com>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Mark Gross <markgross@kernel.org>,
        Andy Shevchenko <andy@kernel.org>,
        Wolfram Sang <wsa@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Sebastian Reichel <sre@kernel.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Ard Biesheuvel <ardb@kernel.org>, Len Brown <lenb@kernel.org>,
        linux-acpi@vger.kernel.org, Yauhen Kharuzhy <jekhor@gmail.com>,
        Tsuchiya Yuto <kitakar@gmail.com>,
        Fabio Aiuto <fabioaiuto83@gmail.com>,
        platform-driver-x86@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-efi@vger.kernel.org
References: <20220130204557.15662-1-hdegoede@redhat.com>
 <20220130204557.15662-2-hdegoede@redhat.com>
 <YffmDCHY6csr0uyD@smile.fi.intel.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <YffmDCHY6csr0uyD@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Andy,

Thank you for the reviews.

On 1/31/22 14:37, Andy Shevchenko wrote:
> On Sun, Jan 30, 2022 at 09:45:38PM +0100, Hans de Goede wrote:
>> Some (USB) charger ICs have variants with USB D+ and D- pins to do their
>> own builtin charger-type detection, like e.g. the bq24190 and bq25890 and
>> also variants which lack this functionality, e.g. the bq24192 and bq25892.
>>
>> In case the charger-type; and thus the input-current-limit detection is
>> done outside the charger IC then we need some way to communicate this to
>> the charger IC. In the past extcon was used for this, but if the external
>> detection does e.g. full USB PD negotiation then the extcon cable-types do
>> not convey enough information.
>>
>> For these setups it was decided to model the external charging "brick"
>> and the parameters negotiated with it as a power_supply class-device
>> itself; and power_supply_set_input_current_limit_from_supplier() was
>> introduced to allow drivers to get the input-current-limit this way.
>>
>> But in some cases psy drivers may want to know other properties, e.g. the
>> bq25892 can do "quick-charge" negotiation by pulsing its current draw,
>> but this should only be done if the usb_type psy-property of its supplier
>> is set to DCP (and device-properties indicate the board allows higher
>> voltages).
>>
>> Instead of adding extra helper functions for each property which
>> a psy-driver wants to query from its supplier, refactor
>> power_supply_set_input_current_limit_from_supplier() into a
>> more generic power_supply_get_property_from_supplier() function.
> 
> ...
> 
>> +	ret = power_supply_get_property_from_supplier(bdi->charger,
>> +						      POWER_SUPPLY_PROP_CURRENT_MAX,
>> +						      &val);
>> +	if (ret == 0)
> 
> Can it be as simple as
> 
> 	if (ret)
> 		return;
> 
> 	...
> 
> 
> ?
> 
> Or did I misunderstand the meaning of 0?

Yes that would be better and together with some of the other tweaks
you've suggested I believe that this warrants a version 5. So I'll
address a v5 addressing all your comment.

Regards,

Hans

