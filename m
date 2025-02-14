Return-Path: <linux-acpi+bounces-11196-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6872FA3637B
	for <lists+linux-acpi@lfdr.de>; Fri, 14 Feb 2025 17:47:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F9F83A5D8F
	for <lists+linux-acpi@lfdr.de>; Fri, 14 Feb 2025 16:46:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40439262816;
	Fri, 14 Feb 2025 16:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="ZBJ4GsS/"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 875261519BF;
	Fri, 14 Feb 2025 16:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739551624; cv=none; b=sZRD9gYbDwYJ2EEaoVIrKuHkbECF5MsMl/dFwxBJ83tFvuYmBOt0N/qGdtrb7x/lL57encqWRnTcnSEKgnsrmRIRVP+1jDNjKvkMMDc24HuztOW+Ol78RcmEvFx79YvUoGdxJrEequbZiNxf69F8L3O20MmmdhMlK08TcXik2d8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739551624; c=relaxed/simple;
	bh=dcO+LnspWooawou45LkIT56ZhReuEcnq4wVqbmqn5wQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hlIBMuOYOGsqTnJEkMKwFzitw16Y73r/3m0vuF3JiI0AX31oB8coxtI7JjX6Pg5Y2vcWqWxCi1++3rFosca/nxNX+5G9HK5kRzWdV3OZhFLS2stNmNuJ3cIh7jd8VNkmW0kf0OEp0MGNmHiH5h0ocEoltV18vWgSpgwz4SAvLFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=ZBJ4GsS/; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1739551612; x=1740156412; i=w_armin@gmx.de;
	bh=Tt9qSh1lGkulOcz4hTZCSW+O6b6j4iGiEVVg8EycV88=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=ZBJ4GsS/UyApJuRHajM8TBzWUMtIv055WJvZhRVGyroDBc0B/392kclsxFBMJsFs
	 yR9ZUKn6lEHZVVvhxvjd1ohFnu5K0ztx9bhXr4/F0tqig91AW6A2Oy+dNZK0xKfV8
	 +qQBb+NOK1JXY/zJ7iDOjA/g76jZjwgMlafnavei1c1/0ozTHSMlytGEwx8VTlnZN
	 fT17g2Xx0SQOSBtrEwWq4FONIddgKhstAeCv2Q2Tuhd1wd7l0lg/aQfaMRnjYl/tS
	 SYCgi0w3T4nwW1G5Sx4IDG5yWSi3Uz2K6k+J/1fv1hncjHpFiZs0nVXJHHkQavR84
	 MIOv2fvuim+NOSD4EA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.0.69] ([87.177.78.219]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mo6v3-1t2Rw839uV-00m4pS; Fri, 14
 Feb 2025 17:46:51 +0100
Message-ID: <0053b236-79cc-496d-936b-5f8b12b39f10@gmx.de>
Date: Fri, 14 Feb 2025 17:46:50 +0100
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] ACPI: fan: Add fan speed reporting for fans with only
 _FST
To: Joshua Grisham <josh@joshuagrisham.com>
Cc: rafael@kernel.org, lenb@kernel.org, linux-acpi@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250125100711.70977-1-josh@joshuagrisham.com>
 <77eb01a6-2905-4776-96ce-eb936c04956b@gmx.de>
 <CAMF+KeZrdkfwoab4zvBYJMuYaScCDFPbvijo9o6d-9CS96238g@mail.gmail.com>
Content-Language: en-US
From: Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <CAMF+KeZrdkfwoab4zvBYJMuYaScCDFPbvijo9o6d-9CS96238g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:n/PP5S+ZdZUq6qrfxCmzEc48W8gfIR2O0+QP+nmEzrYShzMm3Io
 MmTexC3gg8GEgv0nCS40f9/h7uokKMN1SLohxyS4gM7vauTUwKylXmTPmPrCT37NDtIgBn8
 w7+otjxuRI8zEPKPOTmg1B94X+pPSJNeaKJL+FNuzhjLmZcVaogqshpe+Sp59JP50MWkwhg
 f0bu7RRaW7v3p9SK5nKwQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:FOIFagoj01M=;O11iVxGwMqdFV0ANPEhI/nmevBF
 +cp5KanMT9Thk7W9j/5SSNvHF41pOsohxl4Uwd6npZZ/810bnDEu57jV3x5uyusAL1GQuA7m2
 nP4KzVzHQn9Z7bCHNCW1m9lhRDZttAzt+OmK2LXpfo1+DKPGv6xlsyzX3Fv9znkNRJyctyC3U
 1ypsQafivTYvSLx4xHmADL1Zayqhs4RIK0xFY1X2oLhRgtgj2jAVhgZo2zRJ65295n4/GB3Nf
 jwDFlCd2bCkyo+t6PtrFgYyfRUmnOM3wZmZQzwwMHSNDghnoS20iaDJaMv1UL1odlXxxMjJe5
 CLgomKoOtETcy9m+CBU7SMnFHe+kXXb9oxjBVoOxRHnxx4L9q4xVfp8zmi1EWkh6jNLp7Lilt
 d9PrjehbiagO4Dk46xVZnV2n7PQy67OUK967zwZpCOVogesijbVscIT4k7E+NgwtBqP3FRiYK
 fudyK77NbO9BB4XSkHN5qcb56JzTPISlGHuULi0xggbweSdkNUiQrZr1P2eSpj7jnxqFQPwTK
 6sWCjX2x1qJuju6lpoROSAU0u7dTGVdZAVL3s/m31CCkM7tDFJy+qdf0yvhsJHoOaFDN8pfu6
 4Sit5vVFdVk+gY4/rfDsu7zOHBPyutJTENj/+9mjEZxRn3vMnPJd+baVrg+ThxUMmNAOrA5fQ
 vTKm4HB7bh5r1QPwsjzkZFhjVjf+qb1kRHN07vedP9+5cXYb8s72zeJN6018ZdaYMkPQvCjdJ
 54G/Bh/uI7G4t9ccEhho0i3YC56he3mI+yoInZz9lTjtHRuCrVS9QJxdbAcxiD/w/xTqgGKjh
 xpNQ9q38qkHyQPI2xpIqWvfdN/+zjtSA9A5iSq5/EWL9qnoC7wrUwnw3ADwpQwqEaxZ6pUAhb
 7Eor+PHxbKtvA3+aglGQ9+unrc8Sl47UacNmGner0FUnoElaREtEScsr/eeLN2aDuPaVZGVP+
 cRmd+UuUXGjCyIjW96uV3YYY10VxQ4C45MHdqtxm75cAKZsm03uFeS1qZArU6VInKUHki8MZB
 RihXmoHrmBCXKxycYSHiKHTmVlexis1sAvKTUdM3TJP68Zs24ztJHgUgOacfhh0jMJpaT+ohn
 wB8VKteoOq8t7EKZTXvi0NTghg3HqpjRgAgv5SHQXmsxFd76to4NvhJhyP+oJe5qTGse7BMZF
 3vYSB71o+61/LqkgUUnXkyqYIWn2cpdyTRlmdek7oxmP+F6y7ec0MHU/cAkT2zuoKjphpZ4ZK
 1Jy6arblZztzvpwGv2cy3wFr25rXqnxBikTPwqo+I5+P3rklH8b/Vm0XpLzRC2Um0sqcEzA0y
 K9Fv1AgM9o64EdxVCQ9lKCacPmH7uGSq5rEQHq+9BHs1D8ldXGD1kFpxOj60kOTzHExR0gzN8
 EplvhR9dE0Eg2egm9DbDVNCr8SPO3nnKfbzSD2UMoQt5PPg0AxafH4g+p17ddbijCstyjHiUb
 ygfod8DxQaH/vSntrxY/GbhQ42yk=

Am 06.02.25 um 08:37 schrieb Joshua Grisham:

> Den tors 6 feb. 2025 kl 06:05 skrev Armin Wolf <W_Armin@gmx.de>:
>> Am 25.01.25 um 11:07 schrieb Joshua Grisham:
>>
>>> Add support for ACPI fans with _FST to report their speed even if they do
>>> not support fan control.
>>>
>>> As suggested by Armin Wolf [1] and per the Windows Thermal Management
>>> Design Guide [2], Samsung Galaxy Book series devices (and possibly many
>>> more devices where the Windows guide was strictly followed) only implement
>>> the _FST method and do not support ACPI-based fan control.
>>>
>>> Currently, these fans are not supported by the kernel driver but this patch
>>> will make some very small adjustments to allow them to be supported.
>>>
>>> This patch is tested and working for me on a Samsung Galaxy Book2 Pro whose
>>> DSDT (and several other Samsung Galaxy Book series notebooks which
>>> currently have the same issue) can be found at [3].
>> Any updates on this patch? For me it seems ready for mainline.
>>
>> Thanks,
>> Armin Wolf
>>
> Hi Armin, thanks for checking in on this!
>
> For me I have no further updates that I planned or intended to send.
> If it looks good to Rafael or anyone else who wants or needs to review
> then I would be glad to see it applied.
>
> If needed then I can re-send with Armin's Reviewed-by tag inline in
> the commit message but otherwise everything is as I would have wished
> it to be, for what that is worth :)
>
> Thanks again!
>
> Best regards,
> Joshua

I was hoping to get Rafaels attention so that he can give your patch a closer look.

Thanks,
Armin Wolf

>>> [1]: https://lore.kernel.org/platform-driver-x86/53c5075b-1967-45d0-937f-463912dd966d@gmx.de
>>> [2]: https://learn.microsoft.com/en-us/windows-hardware/design/device-experiences/design-guide
>>> [3]: https://github.com/joshuagrisham/samsung-galaxybook-extras/tree/8e3087a06b8bdcdfdd081367af4b744a56cc4ee9/dsdt
>>>
>>> Signed-off-by: Joshua Grisham <josh@joshuagrisham.com>
>>> ---
>>>
>>> v1->v2:
>>> - Still allow acpi4_only_fst fans to update power state on
>>>     suspend/resume
>>> - Fix if / else if logic error
>>> - Also hide hwmon_power_input for acpi4_only_fst fans
>>>
>>> v2->v3:
>>> - Still allow acpi4_only_fst fans to set initial power state on probe
>>> ---
>>>    drivers/acpi/fan.h       |  1 +
>>>    drivers/acpi/fan_attr.c  | 37 ++++++++++++++++++++++---------------
>>>    drivers/acpi/fan_core.c  | 22 +++++++++++++++++-----
>>>    drivers/acpi/fan_hwmon.c | 12 ++++++++++++
>>>    4 files changed, 52 insertions(+), 20 deletions(-)
>>>
>>> diff --git a/drivers/acpi/fan.h b/drivers/acpi/fan.h
>>> index 488b51e2c..d0aad88a7 100644
>>> --- a/drivers/acpi/fan.h
>>> +++ b/drivers/acpi/fan.h
>>> @@ -49,6 +49,7 @@ struct acpi_fan_fst {
>>>
>>>    struct acpi_fan {
>>>        bool acpi4;
>>> +     bool acpi4_only_fst;
>>>        struct acpi_fan_fif fif;
>>>        struct acpi_fan_fps *fps;
>>>        int fps_count;
>>> diff --git a/drivers/acpi/fan_attr.c b/drivers/acpi/fan_attr.c
>>> index f4f6e2381..d83f88429 100644
>>> --- a/drivers/acpi/fan_attr.c
>>> +++ b/drivers/acpi/fan_attr.c
>>> @@ -75,15 +75,6 @@ int acpi_fan_create_attributes(struct acpi_device *device)
>>>        struct acpi_fan *fan = acpi_driver_data(device);
>>>        int i, status;
>>>
>>> -     sysfs_attr_init(&fan->fine_grain_control.attr);
>>> -     fan->fine_grain_control.show = show_fine_grain_control;
>>> -     fan->fine_grain_control.store = NULL;
>>> -     fan->fine_grain_control.attr.name = "fine_grain_control";
>>> -     fan->fine_grain_control.attr.mode = 0444;
>>> -     status = sysfs_create_file(&device->dev.kobj, &fan->fine_grain_control.attr);
>>> -     if (status)
>>> -             return status;
>>> -
>>>        /* _FST is present if we are here */
>>>        sysfs_attr_init(&fan->fst_speed.attr);
>>>        fan->fst_speed.show = show_fan_speed;
>>> @@ -92,7 +83,19 @@ int acpi_fan_create_attributes(struct acpi_device *device)
>>>        fan->fst_speed.attr.mode = 0444;
>>>        status = sysfs_create_file(&device->dev.kobj, &fan->fst_speed.attr);
>>>        if (status)
>>> -             goto rem_fine_grain_attr;
>>> +             return status;
>>> +
>>> +     if (fan->acpi4_only_fst)
>>> +             return 0;
>>> +
>>> +     sysfs_attr_init(&fan->fine_grain_control.attr);
>>> +     fan->fine_grain_control.show = show_fine_grain_control;
>>> +     fan->fine_grain_control.store = NULL;
>>> +     fan->fine_grain_control.attr.name = "fine_grain_control";
>>> +     fan->fine_grain_control.attr.mode = 0444;
>>> +     status = sysfs_create_file(&device->dev.kobj, &fan->fine_grain_control.attr);
>>> +     if (status)
>>> +             goto rem_fst_attr;
>>>
>>>        for (i = 0; i < fan->fps_count; ++i) {
>>>                struct acpi_fan_fps *fps = &fan->fps[i];
>>> @@ -109,18 +112,18 @@ int acpi_fan_create_attributes(struct acpi_device *device)
>>>
>>>                        for (j = 0; j < i; ++j)
>>>                                sysfs_remove_file(&device->dev.kobj, &fan->fps[j].dev_attr.attr);
>>> -                     goto rem_fst_attr;
>>> +                     goto rem_fine_grain_attr;
>>>                }
>>>        }
>>>
>>>        return 0;
>>>
>>> -rem_fst_attr:
>>> -     sysfs_remove_file(&device->dev.kobj, &fan->fst_speed.attr);
>>> -
>>>    rem_fine_grain_attr:
>>>        sysfs_remove_file(&device->dev.kobj, &fan->fine_grain_control.attr);
>>>
>>> +rem_fst_attr:
>>> +     sysfs_remove_file(&device->dev.kobj, &fan->fst_speed.attr);
>>> +
>>>        return status;
>>>    }
>>>
>>> @@ -129,9 +132,13 @@ void acpi_fan_delete_attributes(struct acpi_device *device)
>>>        struct acpi_fan *fan = acpi_driver_data(device);
>>>        int i;
>>>
>>> +     sysfs_remove_file(&device->dev.kobj, &fan->fst_speed.attr);
>>> +
>>> +     if (fan->acpi4_only_fst)
>>> +             return;
>>> +
>>>        for (i = 0; i < fan->fps_count; ++i)
>>>                sysfs_remove_file(&device->dev.kobj, &fan->fps[i].dev_attr.attr);
>>>
>>> -     sysfs_remove_file(&device->dev.kobj, &fan->fst_speed.attr);
>>>        sysfs_remove_file(&device->dev.kobj, &fan->fine_grain_control.attr);
>>>    }
>>> diff --git a/drivers/acpi/fan_core.c b/drivers/acpi/fan_core.c
>>> index 10016f52f..66aa1be64 100644
>>> --- a/drivers/acpi/fan_core.c
>>> +++ b/drivers/acpi/fan_core.c
>>> @@ -211,6 +211,11 @@ static bool acpi_fan_is_acpi4(struct acpi_device *device)
>>>               acpi_has_method(device->handle, "_FST");
>>>    }
>>>
>>> +static bool acpi_fan_has_fst(struct acpi_device *device)
>>> +{
>>> +     return acpi_has_method(device->handle, "_FST");
>>> +}
>>> +
>>>    static int acpi_fan_get_fif(struct acpi_device *device)
>>>    {
>>>        struct acpi_buffer buffer = { ACPI_ALLOCATE_BUFFER, NULL };
>>> @@ -327,7 +332,12 @@ static int acpi_fan_probe(struct platform_device *pdev)
>>>        device->driver_data = fan;
>>>        platform_set_drvdata(pdev, fan);
>>>
>>> -     if (acpi_fan_is_acpi4(device)) {
>>> +     if (acpi_fan_is_acpi4(device))
>>> +             fan->acpi4 = true;
>>> +     else if (acpi_fan_has_fst(device))
>>> +             fan->acpi4_only_fst = true;
>>> +
>>> +     if (fan->acpi4) {
>>>                result = acpi_fan_get_fif(device);
>>>                if (result)
>>>                        return result;
>>> @@ -335,7 +345,9 @@ static int acpi_fan_probe(struct platform_device *pdev)
>>>                result = acpi_fan_get_fps(device);
>>>                if (result)
>>>                        return result;
>>> +     }
>>>
>>> +     if (fan->acpi4 || fan->acpi4_only_fst) {
>>>                result = devm_acpi_fan_create_hwmon(device);
>>>                if (result)
>>>                        return result;
>>> @@ -343,9 +355,9 @@ static int acpi_fan_probe(struct platform_device *pdev)
>>>                result = acpi_fan_create_attributes(device);
>>>                if (result)
>>>                        return result;
>>> +     }
>>>
>>> -             fan->acpi4 = true;
>>> -     } else {
>>> +     if (!fan->acpi4) {
>>>                result = acpi_device_update_power(device, NULL);
>>>                if (result) {
>>>                        dev_err(&device->dev, "Failed to set initial power state\n");
>>> @@ -391,7 +403,7 @@ static int acpi_fan_probe(struct platform_device *pdev)
>>>    err_unregister:
>>>        thermal_cooling_device_unregister(cdev);
>>>    err_end:
>>> -     if (fan->acpi4)
>>> +     if (fan->acpi4 || fan->acpi4_only_fst)
>>>                acpi_fan_delete_attributes(device);
>>>
>>>        return result;
>>> @@ -401,7 +413,7 @@ static void acpi_fan_remove(struct platform_device *pdev)
>>>    {
>>>        struct acpi_fan *fan = platform_get_drvdata(pdev);
>>>
>>> -     if (fan->acpi4) {
>>> +     if (fan->acpi4 || fan->acpi4_only_fst) {
>>>                struct acpi_device *device = ACPI_COMPANION(&pdev->dev);
>>>
>>>                acpi_fan_delete_attributes(device);
>>> diff --git a/drivers/acpi/fan_hwmon.c b/drivers/acpi/fan_hwmon.c
>>> index bd0d31a39..d0668ecc2 100644
>>> --- a/drivers/acpi/fan_hwmon.c
>>> +++ b/drivers/acpi/fan_hwmon.c
>>> @@ -43,6 +43,12 @@ static umode_t acpi_fan_hwmon_is_visible(const void *drvdata, enum hwmon_sensor_
>>>                case hwmon_fan_input:
>>>                        return 0444;
>>>                case hwmon_fan_target:
>>> +                     /*
>>> +                      * Fans with only _FST do not support fan control.
>>> +                      */
>>> +                     if (fan->acpi4_only_fst)
>>> +                             return 0;
>>> +
>>>                        /*
>>>                         * When in fine grain control mode, not every fan control value
>>>                         * has an associated fan performance state.
>>> @@ -57,6 +63,12 @@ static umode_t acpi_fan_hwmon_is_visible(const void *drvdata, enum hwmon_sensor_
>>>        case hwmon_power:
>>>                switch (attr) {
>>>                case hwmon_power_input:
>>> +                     /*
>>> +                      * Fans with only _FST do not support fan control.
>>> +                      */
>>> +                     if (fan->acpi4_only_fst)
>>> +                             return 0;
>>> +
>>>                        /*
>>>                         * When in fine grain control mode, not every fan control value
>>>                         * has an associated fan performance state.

