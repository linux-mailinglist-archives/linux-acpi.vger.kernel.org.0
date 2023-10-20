Return-Path: <linux-acpi+bounces-809-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D03AB7D141B
	for <lists+linux-acpi@lfdr.de>; Fri, 20 Oct 2023 18:36:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 53FEAB20F66
	for <lists+linux-acpi@lfdr.de>; Fri, 20 Oct 2023 16:36:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4B4F1EA66
	for <lists+linux-acpi@lfdr.de>; Fri, 20 Oct 2023 16:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73D7B12E58
	for <linux-acpi@vger.kernel.org>; Fri, 20 Oct 2023 15:49:40 +0000 (UTC)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E2B51A3;
	Fri, 20 Oct 2023 08:49:37 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.201])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4SBpsm1khlz67M1H;
	Fri, 20 Oct 2023 23:49:00 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Fri, 20 Oct
 2023 16:49:34 +0100
Date: Fri, 20 Oct 2023 16:49:33 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Raag Jadav <raag.jadav@intel.com>
CC: <rafael@kernel.org>, <len.brown@intel.com>, <robert.moore@intel.com>,
	<mika.westerberg@linux.intel.com>, <andriy.shevchenko@linux.intel.com>,
	<mark.rutland@arm.com>, <will@kernel.org>, <linux@roeck-us.net>,
	<linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<acpica-devel@lists.linuxfoundation.org>, <linux-gpio@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-hwmon@vger.kernel.org>,
	<mallikarjunappa.sangannavar@intel.com>, <bala.senthil@intel.com>
Subject: Re: [PATCH v1 1/8] ACPI: utils: Introduce acpi_dev_uid_match() for
 matching _UID
Message-ID: <20231020164933.00002f53@Huawei.com>
In-Reply-To: <20231020084732.17130-2-raag.jadav@intel.com>
References: <20231020084732.17130-1-raag.jadav@intel.com>
	<20231020084732.17130-2-raag.jadav@intel.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml100006.china.huawei.com (7.191.160.224) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected

On Fri, 20 Oct 2023 14:17:25 +0530
Raag Jadav <raag.jadav@intel.com> wrote:

> Introduce acpi_dev_uid_match() helper that matches the device with
> supplied _UID string.
> 
> Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Signed-off-by: Raag Jadav <raag.jadav@intel.com>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>  /**
>   * acpi_dev_hid_uid_match - Match device by supplied HID and UID
>   * @adev: ACPI device to match.
>   * @hid2: Hardware ID of the device.
>   * @uid2: Unique ID of the device, pass NULL to not check _UID.
>   *
> - * Matches HID and UID in @adev with given @hid2 and @uid2.
> - * Returns true if matches.
> + * Matches HID and UID in @adev with given @hid2 and @uid2. Absence of @uid2
> + * will be treated as a match. If user wants to validate @uid2, it should be
> + * done before calling this function. This behaviour is as needed by most of
> + * its current users.

If there are other other users that need different behavior are they
buggy?  Also what behavior is this referring to?

I'd just drop the at last sentence as confusing and not adding much.

> + *
> + * Returns:
> + *  - %true if matches or @uid2 is NULL.
> + *  - %false otherwise.
>   */
>  bool acpi_dev_hid_uid_match(struct acpi_device *adev,
>  			    const char *hid2, const char *uid2)
>  {
>  	const char *hid1 = acpi_device_hid(adev);
> -	const char *uid1 = acpi_device_uid(adev);
>  
>  	if (strcmp(hid1, hid2))
>  		return false;
>  
> -	if (!uid2)
> -		return true;
> -
> -	return uid1 && !strcmp(uid1, uid2);
> +	return acpi_dev_uid_match(adev, uid2);
>  }
>  EXPORT_SYMBOL(acpi_dev_hid_uid_match);
>  
> diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
> index 254685085c82..d1fe6446ffe0 100644
> --- a/include/acpi/acpi_bus.h
> +++ b/include/acpi/acpi_bus.h
> @@ -760,6 +760,7 @@ static inline bool acpi_device_can_poweroff(struct acpi_device *adev)
>  		adev->power.states[ACPI_STATE_D3_HOT].flags.explicit_set);
>  }
>  
> +bool acpi_dev_uid_match(struct acpi_device *adev, const char *uid2);
>  bool acpi_dev_hid_uid_match(struct acpi_device *adev, const char *hid2, const char *uid2);
>  int acpi_dev_uid_to_integer(struct acpi_device *adev, u64 *integer);
>  
> diff --git a/include/linux/acpi.h b/include/linux/acpi.h
> index afd94c9b8b8a..db3a33e19c97 100644
> --- a/include/linux/acpi.h
> +++ b/include/linux/acpi.h
> @@ -787,6 +787,11 @@ static inline bool acpi_dev_present(const char *hid, const char *uid, s64 hrv)
>  
>  struct acpi_device;
>  
> +static inline bool acpi_dev_uid_match(struct acpi_device *adev, const char *uid2)
> +{
> +	return false;
> +}
> +
>  static inline bool
>  acpi_dev_hid_uid_match(struct acpi_device *adev, const char *hid2, const char *uid2)
>  {


