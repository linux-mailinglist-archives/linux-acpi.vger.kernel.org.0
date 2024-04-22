Return-Path: <linux-acpi+bounces-5236-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DD638AC8AE
	for <lists+linux-acpi@lfdr.de>; Mon, 22 Apr 2024 11:18:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 14BAC282AFB
	for <lists+linux-acpi@lfdr.de>; Mon, 22 Apr 2024 09:18:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C19853816;
	Mon, 22 Apr 2024 09:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LOs+Cvhl"
X-Original-To: linux-acpi@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6882B535D9
	for <linux-acpi@vger.kernel.org>; Mon, 22 Apr 2024 09:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713777513; cv=none; b=IaSBJCWTE3+deNole0mCRukIUJnMKqcVe7qe8d22DFdMqYIDCEEARDDuiuzzaN4ZB5n8ItyaErXi9HyAkwgdA33GBBT8h1r63y17DO0sPSFosDPfHMmOFFRc/NZRVEOg+Ju2EcMmkf/N6dn9phk0tZ2xB4WTMfykrjaG0QPlZfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713777513; c=relaxed/simple;
	bh=XkPe1F7fojBstrkUZSar7UsR/bXJygTVnyW21fd0EV4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oWS2zh6n2/V7xlrlWsKCDoWP1Uc7JfLppwNNnYu6qUvKPGt/ZR3ii6ik14c76QMl1VpyJadxM++u45XkboFSrtJCmG1nO85IRNYTwwbO/4nXteDIQ5AjsfyHmX7JFq9a/7nGktgU09yOHT89tFVW+P/GTaHZXsxQzCAiMQWJeEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LOs+Cvhl; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713777510;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1nhem3dNXin8IlnIuBlRUq6yGLigqUBiZvYi08WNtFM=;
	b=LOs+CvhlbFBfSMFF6dztIS5k4RiuVmBppY322QV6wxMPgyOdcbAJEKvrKxAnafbtX7zGy9
	sjSKIISScX6xrflvinyEE/Dj2kPRJedC9mx1yGTYtCqBsK+lLvb8rj7t8KGwtRDiyiz/Qw
	pHG4idG/UUJ15j4xfxIk2j2FxWnK9A4=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-696-FC4KIoUyP8KcErHx1ZxveA-1; Mon, 22 Apr 2024 05:18:28 -0400
X-MC-Unique: FC4KIoUyP8KcErHx1ZxveA-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-a51beadf204so228050066b.1
        for <linux-acpi@vger.kernel.org>; Mon, 22 Apr 2024 02:18:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713777507; x=1714382307;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1nhem3dNXin8IlnIuBlRUq6yGLigqUBiZvYi08WNtFM=;
        b=biB4ovoQTUT5MJ9f2PAjcdBJmy5MxSoep0wJFzoTKy2XSoBkFZ4qdaaPKGC04PFLTc
         r7LHd6yF8LRGJHi5+4g0YWaaIYeABKkE2yF7vacO54ehIKRyifRaah23Il4XBRgp3wxx
         C6HD3ETSyu3jNMeyuno9tp7PF134gS4naR1d+s2bGdy55Qc2IWVn9zijApiciK61BKJH
         eGaDufYSDAwt2J33JheTK7WrXeYF85qVMqgi1wHusfUprXCn3VJD4+hUg+HHlB2LJbC+
         E9A/pSZwr/TOcIVTCCnWsUIDjzXFqIrjvkDYFL9xkI8nlF2kk7IwsbMMeSQ4ZHgoDcO3
         m/iw==
X-Forwarded-Encrypted: i=1; AJvYcCXETW8EsI9kjMpjsdpuytKr7oAuFTy7MXFguy/tSGoyuqXeTLEzAgrrSxb5E+K7Gda/Az5S+1K+geMnL8AfqUfONkRoDPHnqaVgXA==
X-Gm-Message-State: AOJu0YyFB8b3gg74MKKd9yCy1dsPGJtZNmu2ncOJq1irpv/rrfZkLP6Q
	d9YtfirX9g0tQ//Vc+tnebU8m8a8GxXToEdgIGo4oo5dJFWa3x4izF2qHh5tToI6JY1LIeBfPgD
	OxxMAOrepIQGblIv5gmzcLThFIXTWYytMZpRwEiZ0ap0/2DZGpDlpAwYcL54=
X-Received: by 2002:a17:906:f145:b0:a52:23b6:19c1 with SMTP id gw5-20020a170906f14500b00a5223b619c1mr5539008ejb.76.1713777507658;
        Mon, 22 Apr 2024 02:18:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGqXPWMaup5hLcdQzdPvELCt9Sd1rxOEjwsjwr27jFADT4edQfNiX8i48EvRb1vRFB/JGaTuA==
X-Received: by 2002:a17:906:f145:b0:a52:23b6:19c1 with SMTP id gw5-20020a170906f14500b00a5223b619c1mr5539003ejb.76.1713777507398;
        Mon, 22 Apr 2024 02:18:27 -0700 (PDT)
Received: from [10.40.98.157] ([78.108.130.194])
        by smtp.gmail.com with ESMTPSA id 13-20020a170906058d00b00a522d34fee8sm5506314ejn.114.2024.04.22.02.18.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Apr 2024 02:18:27 -0700 (PDT)
Message-ID: <85ec0beb-9ec2-4360-8b53-fe65f8b6f5a8@redhat.com>
Date: Mon, 22 Apr 2024 11:18:26 +0200
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

Ok, so I have added the following comment to the v2 which I will send out soon:

diff --git a/drivers/iio/accel/acpi-helpers.h b/drivers/iio/accel/acpi-helpers.h
index a4357925bf07..4f4140694b59 100644
--- a/drivers/iio/accel/acpi-helpers.h
+++ b/drivers/iio/accel/acpi-helpers.h
@@ -7,6 +7,13 @@
 #include <linux/sprintf.h>
 
 #ifdef CONFIG_ACPI
+/*
+ * Parse mount matrixes defined in the ACPI "ROTM" format from:
+ * https://learn.microsoft.com/en-us/windows-hardware/drivers/sensors/sensors-acpi-entries
+ * This is a Microsoft extension and not part of the official ACPI spec.
+ * The method name is configurable because some dual-accel setups define 2 mount
+ * matrices in a single ACPI device using separate "ROMK" and "ROMS" methods.
+ */
 static inline bool acpi_read_mount_matrix(struct device *dev,
 					  struct iio_mount_matrix *orientation,
 					  char *acpi_method)

Regards,

Hans



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


