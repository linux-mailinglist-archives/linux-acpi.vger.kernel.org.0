Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 080423ABBCD
	for <lists+linux-acpi@lfdr.de>; Thu, 17 Jun 2021 20:28:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232329AbhFQSal (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 17 Jun 2021 14:30:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231547AbhFQSaj (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 17 Jun 2021 14:30:39 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DC55C061574
        for <linux-acpi@vger.kernel.org>; Thu, 17 Jun 2021 11:28:29 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id gt18so11545492ejc.11
        for <linux-acpi@vger.kernel.org>; Thu, 17 Jun 2021 11:28:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=O3Q9f7dSaAKeUTJs84lDlKTTqcxfOdO9aU0CSmSNnXk=;
        b=pLWPz/O/d4tcyZCF0YOC1/72KPQyo9gELK346NF4cLvZVNBR8dheAMkh51kvQKkV+w
         eq9pSjwA6dodA4/0rjhhjQRCbaMnxRlL+qqNzuXCi4jnuGcZLkpDECjaqk+aOCOy6z7z
         diEGsD2ddXOSKyer27eXL4YsmpMhT4p/MfGDdsm78hikcPjdQf+pAIKyEKukOn2qPIua
         iRprrzxZv9lQu/hUfzEEQVPQpHT15iFOdV3NQj+BmabP9Bsd05DbJB/0FGEpacqEJFiO
         kDvZREn/O2i9P7ejbmvbvF1GOG2rtiJmDN6Mf96DcNWDRbSYyV/Jg59Yi2y5m6f7ol6k
         Q7yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=O3Q9f7dSaAKeUTJs84lDlKTTqcxfOdO9aU0CSmSNnXk=;
        b=JFMkkt0PLb5iXLc4nXmIixdoY5pmoi0MB5rTJT7mUTJP/I3aQk4zoE0Ku+MQ7b6bsa
         KhgjwGDQUJ6vDtaP3Fswh7crHpGFTTKpNO9iovW6nqU33xfMjRGHeqhe3wc3NeLxcMZ4
         6t5UNy+KrB8KbMzZsuoB4hjiWtsOLfZ6rI3L2hVMcufyFd8p00lGRIJ5m1cvEY2G/fAq
         DnbIZcZC3IUptUwbKwyR6EusFSVQHkC2Q29kn5MeEWQpFt3IYhCS0knbRrEnNrjeVGBw
         ivl837fSZ50Nd3T4qX5ROKVA95yfJmXmI+9ffxTq/xSJT0KjgwBI0XqXqHajEFx/hHT8
         1VrQ==
X-Gm-Message-State: AOAM530ClBtQlXSdYhG6CJeUVpDiZ9Qto3eV175f3qyk+OngjLtudzO5
        5ueaVuXDkC0cyNa9TPi/Yus=
X-Google-Smtp-Source: ABdhPJxoMbYn8ATSTTqYH8EDUrse51eLeofLSHnjyKo4q03a5qrEreWr0qFQwN7JkhpTuOLsSIRGbw==
X-Received: by 2002:a17:906:9bce:: with SMTP id de14mr6824088ejc.353.1623954507623;
        Thu, 17 Jun 2021 11:28:27 -0700 (PDT)
Received: from ?IPv6:2a02:908:1984:a6c0::47cb? ([2a02:908:1984:a6c0::47cb])
        by smtp.gmail.com with ESMTPSA id z20sm4177162ejd.18.2021.06.17.11.28.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Jun 2021 11:28:27 -0700 (PDT)
Subject: Re: [PATCH 2/5] ACPI: PM: s2idle: Refactor common code
To:     Mario Limonciello <mario.limonciello@amd.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org
Cc:     teohhanhui@gmail.com, Shyam-sundar.S-k@amd.com,
        Pratik Vishwakarma <Pratik.Vishwakarma@amd.com>
References: <20210617164212.584-1-mario.limonciello@amd.com>
 <20210617164212.584-2-mario.limonciello@amd.com>
From:   Julian Sikorski <belegdol@gmail.com>
Message-ID: <c2b86279-e065-4ca0-2bcf-89f928b52935@gmail.com>
Date:   Thu, 17 Jun 2021 20:28:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210617164212.584-2-mario.limonciello@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

W dniu 17.06.2021 o 18:42, Mario Limonciello pisze:
> From: Pratik Vishwakarma <Pratik.Vishwakarma@amd.com>
> 
> Refactor common code to prepare for upcoming changes.
> * Remove unused struct.
> * Print error before returning.
> * Frees ACPI obj if _DSM type is not as expected.
> * Treat lps0_dsm_func_mask as an integer rather than character
> * Remove extra out_obj
> * Move rev_id
> 
> Co-developed-by: Mario Limonciello <mario.limonciello@amd.com>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> Signed-off-by: Pratik Vishwakarma <Pratik.Vishwakarma@amd.com>
> ---
>   drivers/acpi/x86/s2idle.c | 67 ++++++++++++++++++++-------------------
>   1 file changed, 35 insertions(+), 32 deletions(-)
> 
> diff --git a/drivers/acpi/x86/s2idle.c b/drivers/acpi/x86/s2idle.c
> index da27c1c45c9f..c0cba025072f 100644
> --- a/drivers/acpi/x86/s2idle.c
> +++ b/drivers/acpi/x86/s2idle.c
> @@ -49,7 +49,7 @@ static const struct acpi_device_id lps0_device_ids[] = {
>   
>   static acpi_handle lps0_device_handle;
>   static guid_t lps0_dsm_guid;
> -static char lps0_dsm_func_mask;
> +static int lps0_dsm_func_mask;
>   
>   /* Device constraint entry structure */
>   struct lpi_device_info {
> @@ -70,15 +70,7 @@ struct lpi_constraints {
>   	int min_dstate;
>   };
>   
> -/* AMD */
> -/* Device constraint entry structure */
> -struct lpi_device_info_amd {
> -	int revision;
> -	int count;
> -	union acpi_object *package;
> -};
> -
> -/* Constraint package structure */
> +/* AMD Constraint package structure */
>   struct lpi_device_constraint_amd {
>   	char *name;
>   	int enabled;
> @@ -99,12 +91,12 @@ static void lpi_device_get_constraints_amd(void)
>   					  rev_id, ACPI_LPS0_GET_DEVICE_CONSTRAINTS,
>   					  NULL, ACPI_TYPE_PACKAGE);
>   
> -	if (!out_obj)
> -		return;
> -
>   	acpi_handle_debug(lps0_device_handle, "_DSM function 1 eval %s\n",
>   			  out_obj ? "successful" : "failed");
>   
> +	if (!out_obj)
> +		return;
> +
>   	for (i = 0; i < out_obj->package.count; i++) {
>   		union acpi_object *package = &out_obj->package.elements[i];
>   
> @@ -336,11 +328,33 @@ static bool acpi_s2idle_vendor_amd(void)
>   	return boot_cpu_data.x86_vendor == X86_VENDOR_AMD;
>   }
>   
> +static int validate_dsm(acpi_handle handle, const char *uuid, int rev, guid_t *dsm_guid)
> +{
> +	union acpi_object *obj;
> +	int ret = -EINVAL;
> +
> +	guid_parse(uuid, dsm_guid);
> +	obj = acpi_evaluate_dsm(handle, dsm_guid, rev, 0, NULL);
> +
> +	/* Check if the _DSM is present and as expected. */
> +	if (!obj || obj->type != ACPI_TYPE_BUFFER || obj->buffer.length == 0 ||
> +	    obj->buffer.length > sizeof(u32)) {
> +		acpi_handle_debug(handle,
> +				"_DSM UUID %s rev %d function 0 evaluation failed\n", uuid, rev);
> +		goto out;
> +	}
> +
> +	ret = *(int *)obj->buffer.pointer;
> +	acpi_handle_debug(handle, "_DSM UUID %s rev %d function mask: 0x%x\n", uuid, rev, ret);
> +
> +out:
> +	ACPI_FREE(obj);
> +	return ret;
> +}
> +
>   static int lps0_device_attach(struct acpi_device *adev,
>   			      const struct acpi_device_id *not_used)
>   {
> -	union acpi_object *out_obj;
> -
>   	if (lps0_device_handle)
>   		return 0;
>   
> @@ -348,28 +362,17 @@ static int lps0_device_attach(struct acpi_device *adev,
>   		return 0;
>   
>   	if (acpi_s2idle_vendor_amd()) {
> -		guid_parse(ACPI_LPS0_DSM_UUID_AMD, &lps0_dsm_guid);
> -		out_obj = acpi_evaluate_dsm(adev->handle, &lps0_dsm_guid, 0, 0, NULL);
>   		rev_id = 0;
> +		lps0_dsm_func_mask = validate_dsm(adev->handle,
> +					ACPI_LPS0_DSM_UUID_AMD, rev_id, &lps0_dsm_guid);
>   	} else {
> -		guid_parse(ACPI_LPS0_DSM_UUID, &lps0_dsm_guid);
> -		out_obj = acpi_evaluate_dsm(adev->handle, &lps0_dsm_guid, 1, 0, NULL);
>   		rev_id = 1;
> +		lps0_dsm_func_mask = validate_dsm(adev->handle,
> +					ACPI_LPS0_DSM_UUID, rev_id, &lps0_dsm_guid);
>   	}
>   
> -	/* Check if the _DSM is present and as expected. */
> -	if (!out_obj || out_obj->type != ACPI_TYPE_BUFFER) {
> -		acpi_handle_debug(adev->handle,
> -				  "_DSM function 0 evaluation failed\n");
> -		return 0;
> -	}
> -
> -	lps0_dsm_func_mask = *(char *)out_obj->buffer.pointer;
> -
> -	ACPI_FREE(out_obj);
> -
> -	acpi_handle_debug(adev->handle, "_DSM function mask: 0x%x\n",
> -			  lps0_dsm_func_mask);
> +	if (lps0_dsm_func_mask < 0)
> +		return 0;//function eval failed
>   
>   	lps0_device_handle = adev->handle;
>   
> 
Tested-by: Julian Sikorski <belegdol@gmail.com>
