Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1AE07428E84
	for <lists+linux-acpi@lfdr.de>; Mon, 11 Oct 2021 15:46:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236318AbhJKNsh (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 11 Oct 2021 09:48:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:58754 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236302AbhJKNsg (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 11 Oct 2021 09:48:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1633959996;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=u6DOb9W+mr1GjdJH/2XbWUql9BRZsSj2QfBWX7iXaJU=;
        b=eeWmPov2+iNvnOyK8gQ78mmns4ZhfkPZSogm9+WK6irXRByRS/KBffWRYEbTQIn9WIhTXE
        ZrvF8VfkwxcaB42pvX86N+3yrH/WeYY5urHaHrktLrCuMVhkw3P6fEY6hTPPtvshR/TS1n
        ScRw/XzbaxpPm3C3xHimuaWuEwdvAbc=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-377-TF6RKQXdP-aUyULX2qaEwQ-1; Mon, 11 Oct 2021 09:46:35 -0400
X-MC-Unique: TF6RKQXdP-aUyULX2qaEwQ-1
Received: by mail-ed1-f71.google.com with SMTP id v9-20020a50d849000000b003db459aa3f5so13340727edj.15
        for <linux-acpi@vger.kernel.org>; Mon, 11 Oct 2021 06:46:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=u6DOb9W+mr1GjdJH/2XbWUql9BRZsSj2QfBWX7iXaJU=;
        b=wVhMPRPeAz+PQFyjEz6qtXV6LGR4m8jKmX96t2Kmsa+Y2IAoeuqaUJ9eqjiPbUyKc2
         JZa7poQZpC77HVE+DdOvIOqfF2S6tvx6f0H3wlInGEbBdH0lqFkxsXStsiZ6kr5MMSMB
         FDbSOqwQVvKYDiXoUdzTJyZWp9xahL4aQIHSAXBiEaEoBR+JX7s5tZ+cxT/4QpDVFqo0
         Fi8GXqShIrghfsnRce6Deo3k68O1uWAm7e7RGrM4yMkX8AL4ymupa+PhPQgw3pZb+NaW
         w4gvKER112sQhmimxBzxz/pC0wqQ9eukwTcTlQF+d+s5i+4voT2gGjUXPoGVcEX56ih4
         Vojg==
X-Gm-Message-State: AOAM531tp3lZNqXRpmyH+7iGK7aR50bQ7g4jRtzVjAhBrERGK338nKuc
        fxnnpg8NHWdybb756MBV5d09018LpQP3MTvqK32lgLFbapRrc/STl6ysbvBLDxJDPJsjhr+CqaO
        w7ATXreUjMvK7PLBDase4Ig==
X-Received: by 2002:aa7:db8a:: with SMTP id u10mr43526204edt.189.1633959993700;
        Mon, 11 Oct 2021 06:46:33 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyRwi9U7s2IhR5kI8VuvUR4QQwNMVV7wDkQjkuDwgGNm8rg71fZHIgmHCovzrOcnv2oFED7dw==
X-Received: by 2002:aa7:db8a:: with SMTP id u10mr43526174edt.189.1633959993550;
        Mon, 11 Oct 2021 06:46:33 -0700 (PDT)
Received: from x1.localdomain ([81.30.35.201])
        by smtp.gmail.com with ESMTPSA id f12sm757429edx.90.2021.10.11.06.46.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Oct 2021 06:46:33 -0700 (PDT)
Subject: Re: [PATCH 1/2] platform/x86: amd-pmc: Add alternative acpi id for
 PMC controller
To:     Sachi King <nakato@nakato.io>, Shyam-sundar.S-k@amd.com,
        mgross@linux.intel.com, mario.limonciello@amd.com,
        rafael@kernel.org, lenb@kernel.org
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org, stable@vger.kernel.org
References: <20211002041840.2058647-1-nakato@nakato.io>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <038d2490-0cfd-e68c-2129-b386e1c9d071@redhat.com>
Date:   Mon, 11 Oct 2021 15:46:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20211002041840.2058647-1-nakato@nakato.io>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi,

On 10/2/21 6:18 AM, Sachi King wrote:
> The Surface Laptop 4 AMD has used the AMD0005 to identify this
> controller instead of using the appropriate ACPI ID AMDI0005.  Include
> AMD0005 in the acpi id list.
> 
> Cc: <stable@vger.kernel.org> # 5.14+
> Signed-off-by: Sachi King <nakato@nakato.io>

Thank you for your patch, I've applied this patch to my review-hans 
branch:
https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git/log/?h=review-hans

Once I've run some tests on this branch the patches there will be
added to the platform-drivers-x86/for-next branch and eventually
will be included in the pdx86 pull-request to Linus for the next
merge-window.

I will also include this in my upcoming pdx86-fixes pull-req for 5.15 .

Regards,

Hans

> ---
>  drivers/platform/x86/amd-pmc.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/platform/x86/amd-pmc.c b/drivers/platform/x86/amd-pmc.c
> index d6a7c896ac86..fc95620101e8 100644
> --- a/drivers/platform/x86/amd-pmc.c
> +++ b/drivers/platform/x86/amd-pmc.c
> @@ -476,6 +476,7 @@ static const struct acpi_device_id amd_pmc_acpi_ids[] = {
>  	{"AMDI0006", 0},
>  	{"AMDI0007", 0},
>  	{"AMD0004", 0},
> +	{"AMD0005", 0},
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(acpi, amd_pmc_acpi_ids);
> 

