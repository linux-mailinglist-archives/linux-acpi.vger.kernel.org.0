Return-Path: <linux-acpi+bounces-1618-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CC207F139E
	for <lists+linux-acpi@lfdr.de>; Mon, 20 Nov 2023 13:39:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 58956281DFB
	for <lists+linux-acpi@lfdr.de>; Mon, 20 Nov 2023 12:39:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 129BE1B26C
	for <lists+linux-acpi@lfdr.de>; Mon, 20 Nov 2023 12:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RvQx42ED"
X-Original-To: linux-acpi@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3443EF5
	for <linux-acpi@vger.kernel.org>; Mon, 20 Nov 2023 04:25:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1700483122;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SBUze4Br3/h3ENFWEagU3cqYBL/h55Cp7994NDkXm2g=;
	b=RvQx42EDKsq3CsUFU9LbaKyDmIQr55EPfipWf6GrwxOszCugaQgc19HJdghpcXkBGydKB4
	v99qXTZZXI0LI+/L//H/q3rPCQe7EE2KIoZduXh7AYH+wG1WTvtMFN2Dq7plDEITJUVOhG
	WiYCHl4OyOdhim5aRZV7d4OivMRYr8s=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-412-J3_mWsJuOd6596nxGmp68g-1; Mon, 20 Nov 2023 07:25:21 -0500
X-MC-Unique: J3_mWsJuOd6596nxGmp68g-1
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-5444a9232a9so3275194a12.3
        for <linux-acpi@vger.kernel.org>; Mon, 20 Nov 2023 04:25:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700483119; x=1701087919;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SBUze4Br3/h3ENFWEagU3cqYBL/h55Cp7994NDkXm2g=;
        b=tOdhn0iOe6KRg1HazcxFFoI2qYSGAX4VhPi3+MnLyHgE+OVSHfs5KKEmxLkzet1hT9
         bRORU1AYSLkB4z4WfkWC7N4YKf5nEtF0nqH4D0BS9r+uPZBZY6RbsaAfoMnr2Yf8BTVN
         bYgtvcu2QIpcntbPqdQ0ftTOvMCDOhXgW1xKPqWs+oONMLZaUuLdy4u67UYk18LOC0sw
         3qhXq8x0RsqwvScitPG1Lw50lPg+YJgUyX1BGNkWTyXZdVwJ9fxzYkpc1RVJKVWi9SJY
         DtJp800ZQ3AewZcUkg9r3XEk7fYKN/NScuzKFjl3DppG9JpfCBYmGPvk1uMlGu3MSr3N
         ed+w==
X-Gm-Message-State: AOJu0YyTnYLFnn3joZhZEYGHsYCQkuRluN34AXaSYpfFuyC6sVl2sziN
	mrfEWhVuISkIFP1/b02gWdPKvmgN2ViUhG80y1nQNpmyY2QX2mdqghdh+uLKO6U01gb6TiLAONH
	wXA73w3Ju7XP2JoeSpMmQs/ECStJUWg==
X-Received: by 2002:a05:6402:42c7:b0:53f:bab5:1949 with SMTP id i7-20020a05640242c700b0053fbab51949mr6286469edc.12.1700483119307;
        Mon, 20 Nov 2023 04:25:19 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHKFrVIwqRbrGAZFq9EclcZRxWlr5WL2EMV/hTWmOrYYQF5I7StcjCYVKlVy0rGTPS6aIs3fA==
X-Received: by 2002:a05:6402:42c7:b0:53f:bab5:1949 with SMTP id i7-20020a05640242c700b0053fbab51949mr6286455edc.12.1700483118901;
        Mon, 20 Nov 2023 04:25:18 -0800 (PST)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id j19-20020aa7ca53000000b005488ae52752sm1921822edt.18.2023.11.20.04.25.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Nov 2023 04:25:18 -0800 (PST)
Message-ID: <e2448c2c-db08-47d4-b859-d1f063b1cc7a@redhat.com>
Date: Mon, 20 Nov 2023 13:25:17 +0100
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/4] ACPI: scan: Add LNXVIDEO HID to
 ignore_serial_bus_ids[]
Content-Language: en-US, nl
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Andy Shevchenko <andy@kernel.org>
Cc: linux-acpi@vger.kernel.org, platform-driver-x86@vger.kernel.org,
 "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
References: <20231104205828.63139-1-hdegoede@redhat.com>
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20231104205828.63139-1-hdegoede@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi All,

On 11/4/23 21:58, Hans de Goede wrote:
> The I2C-core already has filtering to skip i2c_client instantiation for
> LNXVIDEO acpi_device-s with I2cSerialBus resources, since LNXVIDEO devices
> are not i2c_client-s and are handled by the acpi_video driver.
> 
> This filtering was added to i2c-core-acpi.c in commit 3a4991a9864c ("i2c:
> acpi: Do not create i2c-clients for LNXVIDEO ACPI devices").
> 
> Now a similar problem has shown up where the SPI-core is instantiating
> an unwanted SPI-device for a SpiSerialBus resource under a LNXVIDEO
> acpi_device. On a Lenovo Yoga Tab 3 YT3-X90F this unwanted SPI-device
> instanstantiation causes the SPI-device instanstantiation for the WM5102
> audio codec to fail with:
> 
> [   21.988441] pxa2xx-spi 8086228E:00: chipselect 0 already in use
> 
> Instead of duplicating the I2C-core filtering in the SPI-core code, push
> the filtering of SerialBus resources under LNXVIDEO acpi_device-s up into
> the ACPI-core by adding the LNXVIDEO HID to ignore_serial_bus_ids[].
> 
> Note the filtering in the I2C-core i2c_acpi_do_lookup() function is still
> necessary because this not only impacts i2c_client instantiation but it
> also makes the I2C-core ignore the I2cSerialBus resource when checking what
> the maximum speed is the I2C bus supports, which is still necessary.
> 
> Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

I've added this series to my review-hans (soon to be for-next) branch now.

Regards,

Hans



> ---
>  drivers/acpi/scan.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
> index 691d4b7686ee..4b6faa2350f5 100644
> --- a/drivers/acpi/scan.c
> +++ b/drivers/acpi/scan.c
> @@ -1727,6 +1727,7 @@ static bool acpi_device_enumeration_by_parent(struct acpi_device *device)
>  	 * Some ACPI devs contain SerialBus resources even though they are not
>  	 * attached to a serial bus at all.
>  	 */
> +		{ACPI_VIDEO_HID, },
>  		{"MSHW0028", },
>  	/*
>  	 * HIDs of device with an UartSerialBusV2 resource for which userspace


