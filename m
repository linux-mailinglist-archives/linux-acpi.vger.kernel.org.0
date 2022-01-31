Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC7124A4A5B
	for <lists+linux-acpi@lfdr.de>; Mon, 31 Jan 2022 16:18:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236806AbiAaPSg (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 31 Jan 2022 10:18:36 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:56447 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1359325AbiAaPS2 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 31 Jan 2022 10:18:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643642307;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QAmHJ3ZqJTt7UjSWKk/RmdR+bF1h3fqMtdi/ZP9ycBM=;
        b=OKCmRJS+5xenMbyewrqR1qoUmY0fMRgaEGztBvdW6+ZTdgSsj3vHQ6dctSS5Q/qAHyqN+q
        BqGqXGyiioNQ7UKD49yKF9rcNDG1bY/nCZFWKhFsCh7xJnFiGMNBeFq6DNu35OjGx0kCRh
        JvfVmq9u5WZsOT3BdECWE8Em+NPO/BY=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-84-0f6mls4gM0Kqtp4lgP4BEA-1; Mon, 31 Jan 2022 10:18:26 -0500
X-MC-Unique: 0f6mls4gM0Kqtp4lgP4BEA-1
Received: by mail-ej1-f72.google.com with SMTP id x16-20020a170906135000b006b5b4787023so5159054ejb.12
        for <linux-acpi@vger.kernel.org>; Mon, 31 Jan 2022 07:18:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=QAmHJ3ZqJTt7UjSWKk/RmdR+bF1h3fqMtdi/ZP9ycBM=;
        b=OpChrvD0nxXS9n7T4qbmKr7pnq7F7145laudFeWMdDonxEq2UPR0FibB2qQtMNuUD1
         NuKclh+lKmEnVjesJerh7kU+c5Q86fip4sf940u8RULuPGulubp7pv8wR0Gq+2r8DU3z
         nINYSYUozZCnqG5FqhppwqEaqkR7EVv+KNk4hBQ5zq/nP1ENJpT/S0mGfN88/2fly2ZX
         B6VRTMmJBwvqJ6IFkJ7PaT1gmDu8Oue5HwmShc/O/zyziEyp3aJIKvauciHQhRDtyh+F
         D492ZKXWVY3BT3S3apbZ6u6vuJjC8WzZDmUs6SmZZZH9M32FmcA4QK5gvpZGTkUleige
         CTJA==
X-Gm-Message-State: AOAM530Vzw3m/0BNDhwxe1gr3rSpVbuFrUXSbzenf/mWXMhDFAuZXVMT
        TQpGJAwsZVZIuz7n+TUj9XLWrZLaVKL1xjSsSG9oeSqbX9JxElkdZeP9YPmdjAaA0waM1nxdyrc
        28wSWBZEK1XuiJ9/NN2AATw==
X-Received: by 2002:a17:906:6a0f:: with SMTP id qw15mr17992175ejc.66.1643642305155;
        Mon, 31 Jan 2022 07:18:25 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwghhGi3a8HVBfaCXbVG/NksU+mqLsEfT2UOuHdYNlaoGRK5E2h8OZRKIK5ywYsytO+GY3g4w==
X-Received: by 2002:a17:906:6a0f:: with SMTP id qw15mr17992163ejc.66.1643642304969;
        Mon, 31 Jan 2022 07:18:24 -0800 (PST)
Received: from [10.40.98.142] ([78.108.130.194])
        by smtp.gmail.com with ESMTPSA id co19sm18008399edb.7.2022.01.31.07.18.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Jan 2022 07:18:24 -0800 (PST)
Message-ID: <bc465932-b2e5-7ff4-1b9a-cf2d76079251@redhat.com>
Date:   Mon, 31 Jan 2022 16:18:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH v4 12/20] power: supply: bq25890: Support higher charging
 voltages through Pump Express+ protocol
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
 <20220130204557.15662-13-hdegoede@redhat.com>
 <YffouVvL9M4fch0I@smile.fi.intel.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <YffouVvL9M4fch0I@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi,

On 1/31/22 14:48, Andy Shevchenko wrote:
> On Sun, Jan 30, 2022 at 09:45:49PM +0100, Hans de Goede wrote:
>> From: Yauhen Kharuzhy <jekhor@gmail.com>
>>
>> Add a "linux,pump-express-vbus-max" property which indicates if the Pump
>> Express+ protocol should be used to increase the charging protocol.
>>
>> If this new property is set and a DCP charger is detected then request
>> a higher charging voltage through the Pump Express+ protocol.
>>
>> So far this new property is only used on x86/ACPI (non devicetree) devs,
>> IOW it is not used in actual devicetree files. The devicetree-bindings
>> maintainers have requested properties like these to not be added to the
>> devicetree-bindings, so the new property is deliberately not added
>> to the existing devicetree-bindings.
>>
>> Changes by Hans de Goede:
>> - Port to my bq25890 patch-series + various cleanups
>> - Make behavior configurable through a new "linux,pump-express-vbus-max"
>>   device-property
>> - Sleep 1 second before re-checking the Vbus voltage after requesting
>>   it to be raised, to ensure that the ADC has time to sampled the new Vbus
>> - Add VBUSV bq25890_tables[] entry and use it in bq25890_get_vbus_voltage()
>> - Tweak commit message
> 
> ...
> 
>> +static void bq25890_pump_express_work(struct work_struct *data)
>> +{
>> +	struct bq25890_device *bq =
>> +		container_of(data, struct bq25890_device, pump_express_work.work);
>> +	int voltage, i, ret;
>> +
>> +	dev_dbg(bq->dev, "Start to request input voltage increasing\n");
>> +
>> +	/* Enable current pulse voltage control protocol */
>> +	ret = bq25890_field_write(bq, F_PUMPX_EN, 1);
>> +	if (ret < 0)
>> +		goto error_print;
>> +
>> +	for (i = 0; i < PUMP_EXPRESS_MAX_TRIES; i++) {
> 
>> +		voltage = bq25890_get_vbus_voltage(bq);
>> +		if (voltage < 0)
>> +			goto error_print;
> 
> It also can be (at least in align with the rest error paths)
> 
> 		ret = bq25890_get_vbus_voltage(bq);
> 		if (ret < 0)
> 			goto error_print;
> 		voltage = ret;
> 
> followed up (but not necessarily)...

The suggested pattern is useful when ret needs to be set on the error-exit
path, but we are not doing that here. So I prefer to just keep this as is.

Regards,

Hans



> 
>> +		dev_dbg(bq->dev, "input voltage = %d uV\n", voltage);
>> +
>> +		if ((voltage + PUMP_EXPRESS_VBUS_MARGIN_uV) >
>> +					bq->pump_express_vbus_max)
>> +			break;
>> +
>> +		ret = bq25890_field_write(bq, F_PUMPX_UP, 1);
>> +		if (ret < 0)
>> +			goto error_print;
>> +
>> +		/* Note a single PUMPX up pulse-sequence takes 2.1s */
>> +		ret = regmap_field_read_poll_timeout(bq->rmap_fields[F_PUMPX_UP],
>> +						     ret, !ret, 100000, 3000000);
>> +		if (ret < 0)
>> +			goto error_print;
>> +
>> +		/* Make sure ADC has sampled Vbus before checking again */
>> +		msleep(1000);
>> +	}
>> +
>> +	bq25890_field_write(bq, F_PUMPX_EN, 0);
>> +
>> +	dev_info(bq->dev, "Hi-voltage charging requested, input voltage is %d mV\n",
>> +		 voltage);
> 
>> +	return;
>> +error_print:
> 
> 	if (ret < 0)
> 
> But it's up to you.
> 
>> +	dev_err(bq->dev, "Failed to request hi-voltage charging\n");
>> +}
> 

