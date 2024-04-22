Return-Path: <linux-acpi+bounces-5235-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 913F88AC8AC
	for <lists+linux-acpi@lfdr.de>; Mon, 22 Apr 2024 11:17:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4366C282AE5
	for <lists+linux-acpi@lfdr.de>; Mon, 22 Apr 2024 09:17:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 872425380C;
	Mon, 22 Apr 2024 09:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bDW9baon"
X-Original-To: linux-acpi@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C412C17C6B
	for <linux-acpi@vger.kernel.org>; Mon, 22 Apr 2024 09:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713777470; cv=none; b=RL1OYK4WCldREpyPY4xLcoA+gY17cVIMt6KCYEJxZqkBjwtw6yiu6AQgJZuP3RJLYNEE5+TwFRr3usDjOT3z5D7ija3N7M4FhZsiYxIv+52fWy6haynI0kVysi5NSjV0mXh0viiRPJtL969w8Zv4DbpQlfTaVlYqh4lPVDL2N+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713777470; c=relaxed/simple;
	bh=0/mzhR3euuAQt28g3nTZ64qU+LnGCHduPlgY060gP6A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rnLnJk7zNHJE+RUN1LS6IO5TdkxY8pKNDPlNfCVIDbRh0ulXYqiqQJt4zcviFTqv+x2hTXIeS+vsgDgc4YkigmCsoes8uqxfOSswQGVjB1iNuv+g1XJiFkbdXfVnn927VmrlB1dWfvCUmkhCltq0IDfjoHoSD3Xql30xt+Cx26c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bDW9baon; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713777467;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PtRXajcKS7+zq+3Fp3p2qpjy4XIBpS9ncu5N46PMenE=;
	b=bDW9baonV44Vol3TJhtflcnZzyDV2z9q35iRBZ+vARrcsLzi/LjYlAOyQpJR3CRqQOS+61
	mxvUrmStEsv83fnEpGe9a1QSgScNr2EG9vF4UXn4B+yi50TPBIlMrGHczNcfmKDH17bk4u
	9jBpSbmZTPoWh28hNiONPmOAv3OyXgo=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-327-lvIVOI1UOOqJLq0A95JF4Q-1; Mon, 22 Apr 2024 05:17:43 -0400
X-MC-Unique: lvIVOI1UOOqJLq0A95JF4Q-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-a5741ee352bso10728766b.1
        for <linux-acpi@vger.kernel.org>; Mon, 22 Apr 2024 02:17:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713777461; x=1714382261;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PtRXajcKS7+zq+3Fp3p2qpjy4XIBpS9ncu5N46PMenE=;
        b=rYCXKjikDdExwrdBWJFj0sSWRIfkj6KeaESUfx7RfIce3gpXX69PDqM5nv5yau7YaL
         3cazblsX6UKmmbtU1oFOt9wn+WAdPRrWhuu+sxeZMcqpb0U2ALTzUmfzgPMAqG0TwkuE
         ras+SRMgAHedVzq6YHaUjjb/G59exxjl0zORgX6Gs7+5QhnYV+r7m+Q9YxOREM5sPTrb
         ehUHs9O9rq+So7lwSLAoGGSEDFBnfxG928/itRF75cTxF4bW7QFTcFmxs+xTXtRRpfaT
         dhsXEsuu7Tn6sUR+AeuMUD8qSYeLtI6XL055Bu2U55QYCBeCArynjSMin5oIi45Tor7n
         DxJA==
X-Forwarded-Encrypted: i=1; AJvYcCUk9gDEtRPryqN2en1gzH/QQ9VJ9tiQ+DR83L5fZgZFuJh4a/IfR4o3zuzPu3Fyl+yti4LqWX91NHG6EbIgQXlO4WvckTNtYnVyfQ==
X-Gm-Message-State: AOJu0YzolUqdT2jzmL/B4+Sab9zaJditxD2qw5qvA6JH4UXyldIwqHyJ
	VIy9PnV2dHunOX3NiY/6zB36fCnbmbsVThjxO+O+HEUOsireFl5Yx3klBNTH1ASSXzp3XKlyvkq
	xgBe0pwJk70Rj89TY8z2kmWTTj+8ZcT9HlvecL3B2jYIF8L+hjih4OwDWZ1c=
X-Received: by 2002:a17:906:da02:b0:a52:5774:69cc with SMTP id fi2-20020a170906da0200b00a52577469ccmr5888338ejb.46.1713777461039;
        Mon, 22 Apr 2024 02:17:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFh7qMJwi0u9/HF++3iT5lTh6XOj2JCE6+ODbOmVe7F2mcSeDvJfcAOY9YiiH/qvgq+fdDFDg==
X-Received: by 2002:a17:906:da02:b0:a52:5774:69cc with SMTP id fi2-20020a170906da0200b00a52577469ccmr5888330ejb.46.1713777460679;
        Mon, 22 Apr 2024 02:17:40 -0700 (PDT)
Received: from [10.40.98.157] ([78.108.130.194])
        by smtp.gmail.com with ESMTPSA id h20-20020a170906591400b00a51d3785c7bsm5488503ejq.196.2024.04.22.02.17.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Apr 2024 02:17:40 -0700 (PDT)
Message-ID: <6ea43afc-ec8a-41f7-983e-a0f653ce2704@redhat.com>
Date: Mon, 22 Apr 2024 11:17:39 +0200
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] iio: accel: kxcjk-1013: Move ACPI ROTM parsing to new
 acpi-helpers.h
To: Jonathan Cameron <jic23@kernel.org>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Sean Rhodes
 <sean@starlabs.systems>, linux-iio@vger.kernel.org,
 linux-acpi@vger.kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>
References: <20240417164616.74651-1-hdegoede@redhat.com>
 <20240417164616.74651-3-hdegoede@redhat.com>
 <20240420121345.26c2edf1@jic23-huawei>
Content-Language: en-US
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20240420121345.26c2edf1@jic23-huawei>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi,

On 4/20/24 1:13 PM, Jonathan Cameron wrote:
> On Wed, 17 Apr 2024 18:46:14 +0200
> Hans de Goede <hdegoede@redhat.com> wrote:
> 
>> The ACPI "ROTM" rotation matrix parsing code atm is already duplicated
>> between bmc150-accel-core.c and kxcjk-1013.c and a third user of this is
>> coming.
>>
>> Move the ROTM parsing from kxcjk-1013.c, which has slightly better error
>> logging (and otherwise is 100% identical), into a new acpi-helpers.h file
>> so that it can be shared.
>>
>> Other then moving the code the only 2 other changes are:
>>
>> 1. Rename the function to acpi_read_mount_matrix() to make clear this
>>    is a generic ACPI mount matrix read function.
>> 2. Add a "char *acpi_method" parameter since some bmc150 dual-accel setups
>>    (360° hinges with 1 accel in kbd/base + 1 in display half) declare both
>>    accels in a single ACPI device with 2 different method names for
>>    the 2 matrices.
>>
>> Cc: Sean Rhodes <sean@starlabs.systems>
>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> 
> Tempted to ask you to rename this to
> acpi_non_standard_microsoft_extension_that_they_never_agreed_with_aswg_read_mount_matrix()
> but meh, I'll cope with a reference to:
> https://learn.microsoft.com/en-us/windows-hardware/drivers/sensors/sensors-acpi-entries
> and a comment saying this is not part of the ACPI standard.

Ok, so I'll add a comment like this for v2:

> 
> I'm not grumpy at all about companies who add non standard stuff without
> at least reserving the ID space.
> 
> Why isn't it a _DSM (Device Specific Method) with a microsoft defined UUID? Harrumph.
> 
> +CC Rafael and linux-acpi as whilst this remains in IIO, it is named such that it
> ends up in the acpi_* namespace.  They may not care, but best to check!
> 
> Jonathan
> 
> 
>> ---
>>  drivers/iio/accel/acpi-helpers.h | 76 ++++++++++++++++++++++++++++++++
>>  drivers/iio/accel/kxcjk-1013.c   | 71 ++---------------------------
>>  2 files changed, 79 insertions(+), 68 deletions(-)
>>  create mode 100644 drivers/iio/accel/acpi-helpers.h
>>
>> diff --git a/drivers/iio/accel/acpi-helpers.h b/drivers/iio/accel/acpi-helpers.h
>> new file mode 100644
>> index 000000000000..a4357925bf07
>> --- /dev/null
>> +++ b/drivers/iio/accel/acpi-helpers.h
>> @@ -0,0 +1,76 @@
>> +/* SPDX-License-Identifier: GPL-2.0-only */
>> +/* ACPI helper functions for parsing ACPI rotation matrices */
>> +
>> +#include <linux/acpi.h>
>> +#include <linux/dev_printk.h>
>> +#include <linux/iio/iio.h>
>> +#include <linux/sprintf.h>
>> +
>> +#ifdef CONFIG_ACPI
>> +static inline bool acpi_read_mount_matrix(struct device *dev,
>> +					  struct iio_mount_matrix *orientation,
>> +					  char *acpi_method)
>> +{
>> +	struct acpi_buffer buffer = { ACPI_ALLOCATE_BUFFER, NULL };
>> +	struct acpi_device *adev = ACPI_COMPANION(dev);
>> +	char *str;
>> +	union acpi_object *obj, *elements;
>> +	acpi_status status;
>> +	int i, j, val[3];
>> +	bool ret = false;
>> +
>> +	if (!adev || !acpi_has_method(adev->handle, acpi_method))
>> +		return false;
>> +
>> +	status = acpi_evaluate_object(adev->handle, acpi_method, NULL, &buffer);
>> +	if (ACPI_FAILURE(status)) {
>> +		dev_err(dev, "Failed to get ACPI mount matrix: %d\n", status);
>> +		return false;
>> +	}
>> +
>> +	obj = buffer.pointer;
>> +	if (obj->type != ACPI_TYPE_PACKAGE || obj->package.count != 3) {
>> +		dev_err(dev, "Unknown ACPI mount matrix package format\n");
>> +		goto out_free_buffer;
>> +	}
>> +
>> +	elements = obj->package.elements;
>> +	for (i = 0; i < 3; i++) {
>> +		if (elements[i].type != ACPI_TYPE_STRING) {
>> +			dev_err(dev, "Unknown ACPI mount matrix element format\n");
>> +			goto out_free_buffer;
>> +		}
>> +
>> +		str = elements[i].string.pointer;
>> +		if (sscanf(str, "%d %d %d", &val[0], &val[1], &val[2]) != 3) {
>> +			dev_err(dev, "Incorrect ACPI mount matrix string format\n");
>> +			goto out_free_buffer;
>> +		}
>> +
>> +		for (j = 0; j < 3; j++) {
>> +			switch (val[j]) {
>> +			case -1: str = "-1"; break;
>> +			case 0:  str = "0";  break;
>> +			case 1:  str = "1";  break;
>> +			default:
>> +				dev_err(dev, "Invalid value in ACPI mount matrix: %d\n", val[j]);
>> +				goto out_free_buffer;
>> +			}
>> +			orientation->rotation[i * 3 + j] = str;
>> +		}
>> +	}
>> +
>> +	ret = true;
>> +
>> +out_free_buffer:
>> +	kfree(buffer.pointer);
>> +	return ret;
>> +}
>> +#else
>> +static inline bool acpi_read_mount_matrix(struct device *dev,
>> +					  struct iio_mount_matrix *orientation,
>> +					  char *acpi_method)
>> +{
>> +	return false;
>> +}
>> +#endif
>> diff --git a/drivers/iio/accel/kxcjk-1013.c b/drivers/iio/accel/kxcjk-1013.c
>> index bb1660667bb0..7e19278491dc 100644
>> --- a/drivers/iio/accel/kxcjk-1013.c
>> +++ b/drivers/iio/accel/kxcjk-1013.c
>> @@ -24,6 +24,8 @@
>>  #include <linux/iio/triggered_buffer.h>
>>  #include <linux/iio/accel/kxcjk_1013.h>
>>  
>> +#include "acpi-helpers.h"
>> +
>>  #define KXCJK1013_DRV_NAME "kxcjk1013"
>>  #define KXCJK1013_IRQ_NAME "kxcjk1013_event"
>>  
>> @@ -636,73 +638,6 @@ static int kxcjk1013_set_power_state(struct kxcjk1013_data *data, bool on)
>>  	return 0;
>>  }
>>  
>> -#ifdef CONFIG_ACPI
>> -static bool kxj1009_apply_acpi_orientation(struct device *dev,
>> -					   struct iio_mount_matrix *orientation)
>> -{
>> -	struct acpi_buffer buffer = { ACPI_ALLOCATE_BUFFER, NULL };
>> -	struct acpi_device *adev = ACPI_COMPANION(dev);
>> -	char *str;
>> -	union acpi_object *obj, *elements;
>> -	acpi_status status;
>> -	int i, j, val[3];
>> -	bool ret = false;
>> -
>> -	if (!adev || !acpi_has_method(adev->handle, "ROTM"))
>> -		return false;
>> -
>> -	status = acpi_evaluate_object(adev->handle, "ROTM", NULL, &buffer);
>> -	if (ACPI_FAILURE(status)) {
>> -		dev_err(dev, "Failed to get ACPI mount matrix: %d\n", status);
>> -		return false;
>> -	}
>> -
>> -	obj = buffer.pointer;
>> -	if (obj->type != ACPI_TYPE_PACKAGE || obj->package.count != 3) {
>> -		dev_err(dev, "Unknown ACPI mount matrix package format\n");
>> -		goto out_free_buffer;
>> -	}
>> -
>> -	elements = obj->package.elements;
>> -	for (i = 0; i < 3; i++) {
>> -		if (elements[i].type != ACPI_TYPE_STRING) {
>> -			dev_err(dev, "Unknown ACPI mount matrix element format\n");
>> -			goto out_free_buffer;
>> -		}
>> -
>> -		str = elements[i].string.pointer;
>> -		if (sscanf(str, "%d %d %d", &val[0], &val[1], &val[2]) != 3) {
>> -			dev_err(dev, "Incorrect ACPI mount matrix string format\n");
>> -			goto out_free_buffer;
>> -		}
>> -
>> -		for (j = 0; j < 3; j++) {
>> -			switch (val[j]) {
>> -			case -1: str = "-1"; break;
>> -			case 0:  str = "0";  break;
>> -			case 1:  str = "1";  break;
>> -			default:
>> -				dev_err(dev, "Invalid value in ACPI mount matrix: %d\n", val[j]);
>> -				goto out_free_buffer;
>> -			}
>> -			orientation->rotation[i * 3 + j] = str;
>> -		}
>> -	}
>> -
>> -	ret = true;
>> -
>> -out_free_buffer:
>> -	kfree(buffer.pointer);
>> -	return ret;
>> -}
>> -#else
>> -static bool kxj1009_apply_acpi_orientation(struct device *dev,
>> -					  struct iio_mount_matrix *orientation)
>> -{
>> -	return false;
>> -}
>> -#endif
>> -
>>  static int kxcjk1013_chip_update_thresholds(struct kxcjk1013_data *data)
>>  {
>>  	int ret;
>> @@ -1533,7 +1468,7 @@ static int kxcjk1013_probe(struct i2c_client *client)
>>  	} else {
>>  		data->active_high_intr = true; /* default polarity */
>>  
>> -		if (!kxj1009_apply_acpi_orientation(&client->dev, &data->orientation)) {
>> +		if (!acpi_read_mount_matrix(&client->dev, &data->orientation, "ROTM")) {
>>  			ret = iio_read_mount_matrix(&client->dev, &data->orientation);
>>  			if (ret)
>>  				return ret;
> 


