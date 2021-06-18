Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6D453AC5B9
	for <lists+linux-acpi@lfdr.de>; Fri, 18 Jun 2021 10:05:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230175AbhFRIHh (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 18 Jun 2021 04:07:37 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:46409 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231877AbhFRIHg (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 18 Jun 2021 04:07:36 -0400
Received: from mail-pg1-f200.google.com ([209.85.215.200])
        by youngberry.canonical.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1lu9VF-0004SG-Fi
        for linux-acpi@vger.kernel.org; Fri, 18 Jun 2021 08:05:25 +0000
Received: by mail-pg1-f200.google.com with SMTP id q12-20020a65684c0000b029022094918bbfso5488718pgt.2
        for <linux-acpi@vger.kernel.org>; Fri, 18 Jun 2021 01:05:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=+PLCucqXHY43yZvJcb/dMjOX1CfrSKN1lKU2FSeK1Fw=;
        b=To1Oof4gEnGlZfWpsu0uAVjp3Z9Z/RCbgtCvGknq3mnWmAodcT1rpqhMtf4gXZtVeL
         onEW6cVOdtuKN2fYGfcvj25dPvDjuXwoP00VmtpA2dFv1qjX9U6j26nMove9fJccdtL9
         6wuAKk3rB8ChoG+1uJWZ6VxXJ8nEcMGnmYxvrrd8mDw0g72iv+vTL6h7WjMD3ug3cUBK
         LNXbAV0wK0HeX1yrN0igydt3A04Ty2EYlFQe7BxjYUdz2+ZnUWtwXFKKL8SPkOSaH83l
         kmVeVSlWwXEzbxblA+E4c0g9oBTBI9v0jTVfoihDdBRfS6Lmk1hIbCBNWftzeqDrQc0g
         M45w==
X-Gm-Message-State: AOAM531ahpZja2/EGSMbilbBhSqD+Xb+gJre19GvObgY+4AeMaTJoU7o
        D0VgGHkncC/FbGhuzVVtTduqq3Lv9TP2OleCA6V9imqkKD3KICotPHOvVPWeQY2UgkXX1YhnUIo
        tBHJPoejs60rgygPepHhjf5UId1JjY9HCfUvrin8=
X-Received: by 2002:a65:44c1:: with SMTP id g1mr7936929pgs.76.1624003524076;
        Fri, 18 Jun 2021 01:05:24 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxBaJbp3NM6EPzMxzx9xKavRXZTYjEdsnfw+lAMz1erkyiVyLLYOmB93TsFnhUkkP5nuntCzQ==
X-Received: by 2002:a65:44c1:: with SMTP id g1mr7936906pgs.76.1624003523747;
        Fri, 18 Jun 2021 01:05:23 -0700 (PDT)
Received: from ?IPv6:2001:b011:3815:5129:46fc:fd28:8033:4504? (2001-b011-3815-5129-46fc-fd28-8033-4504.dynamic-ip6.hinet.net. [2001:b011:3815:5129:46fc:fd28:8033:4504])
        by smtp.gmail.com with ESMTPSA id d127sm7077191pfc.50.2021.06.18.01.05.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Jun 2021 01:05:23 -0700 (PDT)
Subject: Re: [PATCH 5/5] ACPI: PM: Adjust behavior for field problems on AMD
 systems
To:     Mario Limonciello <mario.limonciello@amd.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org
Cc:     Julian Sikorski <belegdol@gmail.com>, teohhanhui@gmail.com,
        Shyam-sundar.S-k@amd.com
References: <20210617164212.584-1-mario.limonciello@amd.com>
 <20210617164212.584-5-mario.limonciello@amd.com>
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
Message-ID: <060aec21-d109-a805-5fc9-196e341940a9@canonical.com>
Date:   Fri, 18 Jun 2021 16:05:19 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210617164212.584-5-mario.limonciello@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org


On 6/18/21 12:42 AM, Mario Limonciello wrote:
> Some AMD Systems with uPEP _HID AMD004/AMDI005 have an off by one bug
> in their function mask return.  This means that they will call entrance
> but not exit for matching functions.
>
> Other AMD systems with this HID should use the Microsoft generic UUID.
>
> AMD systems with uPEP HID AMDI006 should be using the Microsoft method.
>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> Tested-by: Julian Sikorski <belegdol@gmail.com>


The series makes s2idle works on HP EliteBook 845 G8.

For the whole series,

Tested-by: Kai-Heng Feng <kai.heng.feng@canonical.com>

> ---
>   drivers/acpi/x86/s2idle.c | 15 +++++++++++++++
>   1 file changed, 15 insertions(+)
>
> diff --git a/drivers/acpi/x86/s2idle.c b/drivers/acpi/x86/s2idle.c
> index 3f2a90648ec9..816bf2c34b7a 100644
> --- a/drivers/acpi/x86/s2idle.c
> +++ b/drivers/acpi/x86/s2idle.c
> @@ -371,12 +371,27 @@ static int lps0_device_attach(struct acpi_device *adev,
>   		return 0;
>   
>   	if (acpi_s2idle_vendor_amd()) {
> +		/* AMD0004, AMDI0005:
> +		 * - Should use rev_id 0x0
> +		 * - function mask > 0x3: Should use AMD method, but has off by one bug
> +		 * - function mask = 0x3: Should use Microsoft method
> +		 * AMDI0006:
> +		 * - should use rev_id 0x0
> +		 * - function mask = 0x3: Should use Microsoft method
> +		 */
> +		const char *hid = acpi_device_hid(adev);
>   		rev_id = 0;
>   		lps0_dsm_func_mask = validate_dsm(adev->handle,
>   					ACPI_LPS0_DSM_UUID_AMD, rev_id, &lps0_dsm_guid);
>   		lps0_dsm_func_mask_microsoft = validate_dsm(adev->handle,
>   					ACPI_LPS0_DSM_UUID_MICROSOFT, rev_id,
>   					&lps0_dsm_guid_microsoft);
> +		if (lps0_dsm_func_mask > 0x3 && (!strcmp(hid, "AMD0004") ||
> +						 !strcmp(hid, "AMDI0005"))) {
> +			lps0_dsm_func_mask = (lps0_dsm_func_mask << 1) | 0x1;
> +			acpi_handle_debug(adev->handle, "_DSM UUID %s: Adjusted function mask: 0x%x\n",
> +					  ACPI_LPS0_DSM_UUID_AMD, lps0_dsm_func_mask);
> +		}
>   	} else {
>   		rev_id = 1;
>   		lps0_dsm_func_mask = validate_dsm(adev->handle,
>
