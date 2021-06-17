Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDC163ABBCE
	for <lists+linux-acpi@lfdr.de>; Thu, 17 Jun 2021 20:28:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232350AbhFQSaq (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 17 Jun 2021 14:30:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232345AbhFQSap (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 17 Jun 2021 14:30:45 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73A60C061574
        for <linux-acpi@vger.kernel.org>; Thu, 17 Jun 2021 11:28:36 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id g20so11684571ejt.0
        for <linux-acpi@vger.kernel.org>; Thu, 17 Jun 2021 11:28:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=/lSKbQDDpPSxBUvywpCxysk0Y8UR/ypzuzrn9pQjsPA=;
        b=hexRHnqYmcSVnXzZKJGhaB/YOlzq9JzpYe9FJ/QdImApmp2yFdqzsVVjIb1TQDAvKk
         c3LZs+nwD0l9rol8U8ovEpceDeFY9vSykmPX2t+4AZj9C+C+DLLBpg6XmzSx2C1P45qG
         4vr/lrCi54fUy8wi9uO+CAzw0LVCCXUGaeOYSImk2KYvOB4U906n88Q7lG28N+jlK/2a
         lGmvXzNrQh3ARMYjxoqG29iCHuHM/ZmYdSQUZJQifDLSKXdCkObtvU51863Ut98g8u2/
         hNWRigb3tEtH2b6r+368uFWrOpc4zShnzcF/Su10Xh2GbSWh5swYdTo6PN3hW/hNPbRH
         2LxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=/lSKbQDDpPSxBUvywpCxysk0Y8UR/ypzuzrn9pQjsPA=;
        b=PZupzRIq3vyYcDzPfXJ2xRBL5+nFwLWAzlwaZ2kVbCYH8ynpQgTqedqxuYvGV/gZQI
         +IZjqunu5IeUtKE8qu/8Tdk2DV1xc3tbGtUapbdbiK+fyq7zuJp/ICsK5nLLSHHYxNoV
         qMalJAwarj2ACjaZHPNQi2u5HpVRCpolH6+20JmxFhKPCkhX0uLF2p7t7HCvfGlZexi5
         UqTdUDy3xrugk9TR7V99Rro+N8gXi9hmFO5S9IeAF7cDSsI5kqlsZtT9s3E8MTdGLMgJ
         QHmkobPuA3+vfXLSDp5ZjMybJf/gQ6ZeL8EbGu/3q2OB4b+iYnjcjZZcIZADchHrD5To
         0bCA==
X-Gm-Message-State: AOAM532brv5Kh24nzwSxe57BuaUfFHwZ+zvIKg88HuFGZbSsvbuGlhn/
        d5+fgQ8Ztk4iSssKkqPHAr0=
X-Google-Smtp-Source: ABdhPJyTH6aehiKxnhY5ffwmqWZrCazDFRlRrslhze66PfYUhCw1Y5uv4NXxTCRr7xZxyd+3uFFzfQ==
X-Received: by 2002:a17:907:2136:: with SMTP id qo22mr6693551ejb.40.1623954515066;
        Thu, 17 Jun 2021 11:28:35 -0700 (PDT)
Received: from ?IPv6:2a02:908:1984:a6c0::47cb? ([2a02:908:1984:a6c0::47cb])
        by smtp.gmail.com with ESMTPSA id u4sm4121933eje.81.2021.06.17.11.28.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Jun 2021 11:28:34 -0700 (PDT)
Subject: Re: [PATCH 3/5] ACPI: PM: s2idle: Add support for multiple func mask
To:     Mario Limonciello <mario.limonciello@amd.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org
Cc:     teohhanhui@gmail.com, Shyam-sundar.S-k@amd.com,
        Pratik Vishwakarma <Pratik.Vishwakarma@amd.com>
References: <20210617164212.584-1-mario.limonciello@amd.com>
 <20210617164212.584-3-mario.limonciello@amd.com>
From:   Julian Sikorski <belegdol@gmail.com>
Message-ID: <05d1676f-5cfc-37cb-8fed-c55c2a631d01@gmail.com>
Date:   Thu, 17 Jun 2021 20:28:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210617164212.584-3-mario.limonciello@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

W dniu 17.06.2021 o 18:42, Mario Limonciello pisze:
> From: Pratik Vishwakarma <Pratik.Vishwakarma@amd.com>
> 
> Required for follow-up patch adding new UUID
> needing new function mask.
> 
> Signed-off-by: Pratik Vishwakarma <Pratik.Vishwakarma@amd.com>
> ---
>   drivers/acpi/x86/s2idle.c | 31 ++++++++++++++++++++-----------
>   1 file changed, 20 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/acpi/x86/s2idle.c b/drivers/acpi/x86/s2idle.c
> index c0cba025072f..0d19669ac7ad 100644
> --- a/drivers/acpi/x86/s2idle.c
> +++ b/drivers/acpi/x86/s2idle.c
> @@ -309,14 +309,15 @@ static void lpi_check_constraints(void)
>   	}
>   }
>   
> -static void acpi_sleep_run_lps0_dsm(unsigned int func)
> +static void acpi_sleep_run_lps0_dsm(unsigned int func, unsigned int func_mask, guid_t dsm_guid)
>   {
>   	union acpi_object *out_obj;
>   
> -	if (!(lps0_dsm_func_mask & (1 << func)))
> +	if (!(func_mask & (1 << func)))
>   		return;
>   
> -	out_obj = acpi_evaluate_dsm(lps0_device_handle, &lps0_dsm_guid, rev_id, func, NULL);
> +	out_obj = acpi_evaluate_dsm(lps0_device_handle, &dsm_guid,
> +					rev_id, func, NULL);
>   	ACPI_FREE(out_obj);
>   
>   	acpi_handle_debug(lps0_device_handle, "_DSM function %u evaluation %s\n",
> @@ -412,11 +413,15 @@ int acpi_s2idle_prepare_late(void)
>   		lpi_check_constraints();
>   
>   	if (acpi_s2idle_vendor_amd()) {
> -		acpi_sleep_run_lps0_dsm(ACPI_LPS0_SCREEN_OFF_AMD);
> -		acpi_sleep_run_lps0_dsm(ACPI_LPS0_ENTRY_AMD);
> +		acpi_sleep_run_lps0_dsm(ACPI_LPS0_SCREEN_OFF_AMD,
> +				lps0_dsm_func_mask, lps0_dsm_guid);
> +		acpi_sleep_run_lps0_dsm(ACPI_LPS0_ENTRY_AMD,
> +				lps0_dsm_func_mask, lps0_dsm_guid);
>   	} else {
> -		acpi_sleep_run_lps0_dsm(ACPI_LPS0_SCREEN_OFF);
> -		acpi_sleep_run_lps0_dsm(ACPI_LPS0_ENTRY);
> +		acpi_sleep_run_lps0_dsm(ACPI_LPS0_SCREEN_OFF,
> +				lps0_dsm_func_mask, lps0_dsm_guid);
> +		acpi_sleep_run_lps0_dsm(ACPI_LPS0_ENTRY,
> +				lps0_dsm_func_mask, lps0_dsm_guid);
>   	}
>   
>   	return 0;
> @@ -428,11 +433,15 @@ void acpi_s2idle_restore_early(void)
>   		return;
>   
>   	if (acpi_s2idle_vendor_amd()) {
> -		acpi_sleep_run_lps0_dsm(ACPI_LPS0_EXIT_AMD);
> -		acpi_sleep_run_lps0_dsm(ACPI_LPS0_SCREEN_ON_AMD);
> +		acpi_sleep_run_lps0_dsm(ACPI_LPS0_EXIT_AMD,
> +				lps0_dsm_func_mask, lps0_dsm_guid);
> +		acpi_sleep_run_lps0_dsm(ACPI_LPS0_SCREEN_ON_AMD,
> +				lps0_dsm_func_mask, lps0_dsm_guid);
>   	} else {
> -		acpi_sleep_run_lps0_dsm(ACPI_LPS0_EXIT);
> -		acpi_sleep_run_lps0_dsm(ACPI_LPS0_SCREEN_ON);
> +		acpi_sleep_run_lps0_dsm(ACPI_LPS0_EXIT,
> +				lps0_dsm_func_mask, lps0_dsm_guid);
> +		acpi_sleep_run_lps0_dsm(ACPI_LPS0_SCREEN_ON,
> +				lps0_dsm_func_mask, lps0_dsm_guid);
>   	}
>   }
>   
> 
Tested-by: Julian Sikorski <belegdol@gmail.com>
