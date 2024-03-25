Return-Path: <linux-acpi+bounces-4453-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9254688B509
	for <lists+linux-acpi@lfdr.de>; Tue, 26 Mar 2024 00:10:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5B3D3B61A04
	for <lists+linux-acpi@lfdr.de>; Mon, 25 Mar 2024 16:41:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91035152DE3;
	Mon, 25 Mar 2024 14:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Axbhlb5m"
X-Original-To: linux-acpi@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3E0C14D28C
	for <linux-acpi@vger.kernel.org>; Mon, 25 Mar 2024 14:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711378466; cv=none; b=cM8iy7aBXBpqwyR/B9jOq3zH/4T0FZJ9CooNM79VdksaZTXyS4gwJzKYMqJVebRubSN9uEla7/AESvjBhXzlzrvThTnlnL6KGAgafv1kIz7MLDl4ce+wZBNVntD0lV120Am0lc6AQzuQwU7o27nyvFixyAMSjkPdKtmjQZZGTxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711378466; c=relaxed/simple;
	bh=8VnhkxfxjuirtOBESexek616wd5NCpd98WMDdIt5ims=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=p8T0XhUVe/pewH3jjlS0oh9EFow5vZQwjN2TY/yJIDdwCKYD+l1OCEeg52HBgq6PcC3o0i7Gg9ePgoYchL5K9DVgc5xLhJWhLlqS+J/4kajex8BJ9DrxlsIg/WjyjJ3W8UIH/oAczrDxB74Uj3ltkKxNKp9XXAxM3v40Y7/WsZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Axbhlb5m; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711378463;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=a0TLk3PDJF8gYRGg4jydpewHHRZR1/qQMFUxS/nBJe8=;
	b=Axbhlb5mDBRFWrQ8Xw1eNXaIjt8TYhhQdAju2IiHwsbZIWqeJ7SOQa54Wi9LOa7SlaT4EP
	nJJZLKmUvHP2QF34I37kL8aJu5Vrv2q7E2nR7HLUYwuVbf2jmRg0kshsxW+/LWs7YhZuVM
	rVHJONziEX2Nvjn7Qq219te0mt6AjVg=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-252-eBVQf8IxMfudMkS-D7tiiQ-1; Mon, 25 Mar 2024 10:54:22 -0400
X-MC-Unique: eBVQf8IxMfudMkS-D7tiiQ-1
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-5684bbeb4b9so2025919a12.0
        for <linux-acpi@vger.kernel.org>; Mon, 25 Mar 2024 07:54:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711378461; x=1711983261;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=a0TLk3PDJF8gYRGg4jydpewHHRZR1/qQMFUxS/nBJe8=;
        b=X73yDV2XCdRwBJXp70iQeac2mTxr2zsOHcix0f3XMshd3yTyU0c4TbmgegOWzxd948
         2iBJBVwk2pcUyfmfucO0PZKGklmZxTCgQ6LYpam6fs66NCdxHXcIRDuluKA7rCrQmzgR
         DVQ1jRw0oQIOHSgUT6d0aECmb2vxM0xgnVrYlOX5PZRhg3PtHdY7WhGICKKb+o+TkQVU
         IiJq2NFLilJXdQj+gQYAAjoR2gK/h370huEFXM40OuB3xxSAu5sVB3IuWdQSEnY7dSHu
         P6cUuBUnw3GbwM7BuDK/3KTr0cZ94ho30VmFP5UJcR6QL9OBdNhfBCvW6h1fYqyiolwz
         LZCQ==
X-Forwarded-Encrypted: i=1; AJvYcCUkY1scyylH27LAJo+hpnS2/Lseau1c6M6VWRvchKeCgbHskRoHNnCznVPTnmbMc4gWqY9mDVq31zQYpAr0KI0v+Rsb9Py1aUe4KA==
X-Gm-Message-State: AOJu0YxW8DXpbOr70TDtITDBo+/JimuiPft1xwzHB5VFvGebMxEyo006
	5G9P+RsZv0o6XPDqGWAGC90yStOLU46gKGkfHl2FUGFwWQd4JWzWlaJIB8yUaN4Bfu2m4ynrhl4
	t4i8ks2DW9TJuuxyUjUJ1/P3NMAr47WlDHSlG7W1O6CPN5PLNpM5FhTI+FZg=
X-Received: by 2002:a50:9b4e:0:b0:56b:f2d2:eb8c with SMTP id a14-20020a509b4e000000b0056bf2d2eb8cmr4001986edj.40.1711378461074;
        Mon, 25 Mar 2024 07:54:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH68YpwfWBvW9gni07CY7AVxgdhlpPWb3L1BY2eMBTbWB0ch8sTsCV/rCb8oe7oK0YESzMMvw==
X-Received: by 2002:a50:9b4e:0:b0:56b:f2d2:eb8c with SMTP id a14-20020a509b4e000000b0056bf2d2eb8cmr4001973edj.40.1711378460741;
        Mon, 25 Mar 2024 07:54:20 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id y3-20020a50bb03000000b0056b8dcdaca5sm3195919ede.73.2024.03.25.07.54.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Mar 2024 07:54:20 -0700 (PDT)
Message-ID: <5f07bed0-045b-4576-81ee-c87392846334@redhat.com>
Date: Mon, 25 Mar 2024 15:54:19 +0100
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/2] platform/x86: wmi: Support reading/writing 16 bit
 EC values
Content-Language: en-US, nl
To: Armin Wolf <W_Armin@gmx.de>, ilpo.jarvinen@linux.intel.com
Cc: rafael@kernel.org, lenb@kernel.org, mario.limonciello@amd.com,
 sathyanarayanan.kuppuswamy@linux.intel.com, linux-acpi@vger.kernel.org,
 platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240314184538.2933-1-W_Armin@gmx.de>
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20240314184538.2933-1-W_Armin@gmx.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi,

On 3/14/24 7:45 PM, Armin Wolf wrote:
> The ACPI EC address space handler currently only supports
> reading/writing 8 bit values. Some firmware implementations however
> want to access for example 16 bit values, which is perfectly legal
> according to the ACPI spec.
> 
> Add support for reading/writing such values.
> 
> Tested on a Dell Inspiron 3505 and a Asus Prime B650-Plus.
> 
> Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> Signed-off-by: Armin Wolf <W_Armin@gmx.de>

Thank you for your patch-series, I've applied the series to my
review-hans branch:
https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git/log/?h=review-hans

Note it will show up in my review-hans branch once I've pushed my
local branch there, which might take a while.

Once I've run some tests on this branch the patches there will be
added to the platform-drivers-x86/for-next branch and eventually
will be included in the pdx86 pull-request to Linus for the next
merge-window.

Regards,

Hans




> ---
> Chnages since v4:
> - spelling fix
> - fix checkpatch warning
> 
> Changes since v3:
> - change type of variable i to size_t
> 
> Changes since v2:
> - fix address overflow check
> 
> Changes since v1:
> - use BITS_PER_BYTE
> - validate that number of bytes to read/write does not overflow the
>   address
> ---
>  drivers/platform/x86/wmi.c | 54 +++++++++++++++++++++++++++++---------
>  1 file changed, 41 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/platform/x86/wmi.c b/drivers/platform/x86/wmi.c
> index 1920e115da89..9602658711cf 100644
> --- a/drivers/platform/x86/wmi.c
> +++ b/drivers/platform/x86/wmi.c
> @@ -1153,6 +1153,34 @@ static int parse_wdg(struct device *wmi_bus_dev, struct platform_device *pdev)
>  	return 0;
>  }
> 
> +static int ec_read_multiple(u8 address, u8 *buffer, size_t bytes)
> +{
> +	size_t i;
> +	int ret;
> +
> +	for (i = 0; i < bytes; i++) {
> +		ret = ec_read(address + i, &buffer[i]);
> +		if (ret < 0)
> +			return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static int ec_write_multiple(u8 address, u8 *buffer, size_t bytes)
> +{
> +	size_t i;
> +	int ret;
> +
> +	for (i = 0; i < bytes; i++) {
> +		ret = ec_write(address + i, buffer[i]);
> +		if (ret < 0)
> +			return ret;
> +	}
> +
> +	return 0;
> +}
> +
>  /*
>   * WMI can have EmbeddedControl access regions. In which case, we just want to
>   * hand these off to the EC driver.
> @@ -1162,27 +1190,27 @@ acpi_wmi_ec_space_handler(u32 function, acpi_physical_address address,
>  			  u32 bits, u64 *value,
>  			  void *handler_context, void *region_context)
>  {
> -	int result = 0;
> -	u8 temp = 0;
> +	int bytes = bits / BITS_PER_BYTE;
> +	int ret;
> 
> -	if ((address > 0xFF) || !value)
> +	if (!value)
> +		return AE_NULL_ENTRY;
> +
> +	if (!bytes || bytes > sizeof(*value))
>  		return AE_BAD_PARAMETER;
> 
> -	if (function != ACPI_READ && function != ACPI_WRITE)
> +	if (address > U8_MAX || address + bytes - 1 > U8_MAX)
>  		return AE_BAD_PARAMETER;
> 
> -	if (bits != 8)
> +	if (function != ACPI_READ && function != ACPI_WRITE)
>  		return AE_BAD_PARAMETER;
> 
> -	if (function == ACPI_READ) {
> -		result = ec_read(address, &temp);
> -		*value = temp;
> -	} else {
> -		temp = 0xff & *value;
> -		result = ec_write(address, temp);
> -	}
> +	if (function == ACPI_READ)
> +		ret = ec_read_multiple(address, (u8 *)value, bytes);
> +	else
> +		ret = ec_write_multiple(address, (u8 *)value, bytes);
> 
> -	switch (result) {
> +	switch (ret) {
>  	case -EINVAL:
>  		return AE_BAD_PARAMETER;
>  	case -ENODEV:
> --
> 2.39.2
> 


