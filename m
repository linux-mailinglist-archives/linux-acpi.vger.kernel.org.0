Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E3C233ECDC
	for <lists+linux-acpi@lfdr.de>; Wed, 17 Mar 2021 10:19:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229687AbhCQJTT (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 17 Mar 2021 05:19:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:42171 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229845AbhCQJS4 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 17 Mar 2021 05:18:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1615972736;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ISzfzQ/IPmRhET4/orSoWQRmEwqfjZENnnmDXST1Uxo=;
        b=N5rTEi+2Rzpym1qgWaKAtELYWr5DzHLLDvn2HiuRn0GXrlV1B4nF5b1zJLAbzK+edZ1DuW
        FH268HpDgkxzDn6V5vyyy2mv9cxvzj6hm2k2BONrk70w/VMkbQuZPfRqOEel2Wl0EjQigo
        xiyPF9xk8A8w5Nn+hVIWrCiBu05xctE=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-427-NBDJHobuPhe9J_nF56FCqg-1; Wed, 17 Mar 2021 05:18:54 -0400
X-MC-Unique: NBDJHobuPhe9J_nF56FCqg-1
Received: by mail-ed1-f69.google.com with SMTP id p6so18923843edq.21
        for <linux-acpi@vger.kernel.org>; Wed, 17 Mar 2021 02:18:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ISzfzQ/IPmRhET4/orSoWQRmEwqfjZENnnmDXST1Uxo=;
        b=WdXyYujnsmaM2XwDBRmU/KIgfjTwHl4rzdRLc/yw5f2HbbJTmJtIcKoneVZWy/B4Yy
         SX+Pwwg0zX7gb7LQtsBewprCZRUZZ2kyKkdkbeCJfSE224del1eJoYMjwzdIUMstjC6A
         SNaEVu2mryik+29tj0YE/PX/xFtI3iksD1tuO0+emgYYgvVurviIYBmpKgQovIwfuOGN
         k4zDct6N4GEIo/PlxIy5iawM/ojS6vqiMWVlhK/DA8dsoRe86UA0xEUWsBkZt4kisSpg
         7bTwRqPVJ+X1mCvuPk8cJVmJdEZhEv6fBjgUzMUZojVzzgWx8ka/tf4VuPMunKf4/KmS
         8H3g==
X-Gm-Message-State: AOAM530zXQpfkzrPRQsGxum7d0XLeMtSSgqJBfEf1oaqMbnp2+6fN18t
        AklxGrppNElzQgxaaLYexA7QwWwVH1DGoCFtHyzvmO0QXsaUdSzTDWfGlpjKGBZi/0DK2/xxP38
        kZ7PjvZtPcvZSkl6heVuZuA==
X-Received: by 2002:aa7:de11:: with SMTP id h17mr7803121edv.83.1615972732941;
        Wed, 17 Mar 2021 02:18:52 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy5Vki1f67c1FvqFX0zNMhqPKCumzQRxBE+S3SHqyz4ykhSOy+E0AHoUnmgPJw848Jpcto+7A==
X-Received: by 2002:aa7:de11:: with SMTP id h17mr7803108edv.83.1615972732779;
        Wed, 17 Mar 2021 02:18:52 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id r19sm12071627edp.52.2021.03.17.02.18.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Mar 2021 02:18:52 -0700 (PDT)
Subject: Re: [PATCH 2/2] platform/x86: force LPS0 functions for AMD
To:     Alex Deucher <alexander.deucher@amd.com>,
        amd-gfx@lists.freedesktop.org, linux-acpi@vger.kernel.org,
        rjw@rjwysocki.net, lenb@kernel.org
Cc:     Prike.Liang@amd.com, Shyam-sundar.S-k@amd.com,
        Marcin Bachry <hegel666@gmail.com>
References: <20210316194639.287216-1-alexander.deucher@amd.com>
 <20210316194639.287216-2-alexander.deucher@amd.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <de19e30b-e910-5ef5-53ec-bddb4d865489@redhat.com>
Date:   Wed, 17 Mar 2021 10:18:51 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210316194639.287216-2-alexander.deucher@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi,

On 3/16/21 8:46 PM, Alex Deucher wrote:
> ACPI_LPS0_ENTRY_AMD/ACPI_LPS0_EXIT_AMD are supposedly not
> required for AMD platforms, and on some platforms they are
> not even listed in the function mask but at least some HP
> laptops seem to require it to properly support s0ix.
> 
> Based on a patch from Marcin Bachry <hegel666@gmail.com>.
> 
> Bug: https://gitlab.freedesktop.org/drm/amd/-/issues/1230
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> Cc: Marcin Bachry <hegel666@gmail.com>
> ---
>  drivers/acpi/x86/s2idle.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/acpi/x86/s2idle.c b/drivers/acpi/x86/s2idle.c
> index 2d7ddb8a8cb6..dc3cc021125e 100644
> --- a/drivers/acpi/x86/s2idle.c
> +++ b/drivers/acpi/x86/s2idle.c
> @@ -317,11 +317,16 @@ static void lpi_check_constraints(void)
>  	}
>  }
>  
> +static bool acpi_s2idle_vendor_amd(void)
> +{
> +	return boot_cpu_data.x86_vendor == X86_VENDOR_AMD;
> +}
> +
>  static void acpi_sleep_run_lps0_dsm(unsigned int func)
>  {
>  	union acpi_object *out_obj;
>  
> -	if (!(lps0_dsm_func_mask & (1 << func)))
> +	if (!acpi_s2idle_vendor_amd() && !(lps0_dsm_func_mask & (1 << func)))
>  		return;
>  
>  	out_obj = acpi_evaluate_dsm(lps0_device_handle, &lps0_dsm_guid, rev_id, func, NULL);

Skipping the dsm_func_mask feels a bit wrong to me. The commit message talks
about there being a need to unconditional make the calls in the case of the
ACPI_LPS0_ENTRY_AMD/ACPI_LPS0_EXIT_AMD calls. Maybe instead add a "skip_func_mask"
boolean parameter to acpi_sleep_run_lps0_dsm() and set that to false everywhere
except for the 2 ACPI_LPS0_ENTRY_AMD/ACPI_LPS0_EXIT_AMD calls ?

This way we can control when to skip the check on a call by call basis, rather
then always skipping it on all AMD systems.

Regards,

Hans


> @@ -331,11 +336,6 @@ static void acpi_sleep_run_lps0_dsm(unsigned int func)
>  			  func, out_obj ? "successful" : "failed");
>  }
>  
> -static bool acpi_s2idle_vendor_amd(void)
> -{
> -	return boot_cpu_data.x86_vendor == X86_VENDOR_AMD;
> -}
> -
>  static int lps0_device_attach(struct acpi_device *adev,
>  			      const struct acpi_device_id *not_used)
>  {
> 

