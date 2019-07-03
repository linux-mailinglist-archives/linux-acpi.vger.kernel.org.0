Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E02465E502
	for <lists+linux-acpi@lfdr.de>; Wed,  3 Jul 2019 15:14:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726823AbfGCNOG (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 3 Jul 2019 09:14:06 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:38234 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725933AbfGCNOG (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 3 Jul 2019 09:14:06 -0400
Received: by mail-ed1-f67.google.com with SMTP id r12so2051036edo.5
        for <linux-acpi@vger.kernel.org>; Wed, 03 Jul 2019 06:14:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=m+0R/JCvunIYbsVnwClcla1aCK2plCtB0B738DerfBA=;
        b=KbMeoDTjP5ez8lwIUxvMFOVy7GHWtT8Jro+9BsbmsIzIVxIwI3jBPoKhCYTdtS/Alb
         CMHEJHJkYikMtxnY5y/JyiP47GZCCmJXDtDX666SrDG4h9WXhn75tXU3x3zCsrm7A0Xd
         Fzr8q9m54D53wdXvBZChV/9DH26iFCh7R5rsj/EI5UE1fYKYjT4ECjNNoRXJd3a3Q5Wt
         x03JS8tjCeULgv1G/SDc3+wHgyX3z/oitVQdG7CYfHfu04UFaE1njwIWNv1SQ9zqO5II
         zTTS8tumf10BtJZGudPaftdsNG+MZMLqlp16ZP0lUJEBoXwQh8sZbiauybVC5pmAopWM
         ZMbA==
X-Gm-Message-State: APjAAAV1jx5DnMo++dEiSqvJoUAuW+0eRI+3siLpisr6fwp7s8h9xd4V
        A6YAGsyWroixZmBd+TmgdtLjZA==
X-Google-Smtp-Source: APXvYqynI4j1lSB3JmVpo22sA+7dpToo8tQY19IibjnW66w6lzM1PGys7eJfqWnojIMKJ40L/5WXhw==
X-Received: by 2002:a17:906:4717:: with SMTP id y23mr33972819ejq.150.1562159644716;
        Wed, 03 Jul 2019 06:14:04 -0700 (PDT)
Received: from shalem.localdomain (84-106-84-65.cable.dynamic.v4.ziggo.nl. [84.106.84.65])
        by smtp.gmail.com with ESMTPSA id a6sm665853eds.19.2019.07.03.06.14.03
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Jul 2019 06:14:04 -0700 (PDT)
Subject: Re: [PATCH v1] ACPI / PMIC: intel: Drop double removal of address
 space handler
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
        Mika Westerberg <mika.westerberg@linux.intel.com>
References: <20190703011734.82614-1-andriy.shevchenko@linux.intel.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <02babfb3-60c3-517b-39f8-cf1be7963a7c@redhat.com>
Date:   Wed, 3 Jul 2019 15:14:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190703011734.82614-1-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi,

On 03-07-19 03:17, Andy Shevchenko wrote:
> There is no need to remove address space handler twice,
> because removal is idempotent.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Good catch:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans


> ---
>   drivers/acpi/pmic/intel_pmic.c | 2 --
>   1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/acpi/pmic/intel_pmic.c b/drivers/acpi/pmic/intel_pmic.c
> index 1b722fd57d5e..452041398b34 100644
> --- a/drivers/acpi/pmic/intel_pmic.c
> +++ b/drivers/acpi/pmic/intel_pmic.c
> @@ -284,8 +284,6 @@ int intel_pmic_install_opregion_handler(struct device *dev, acpi_handle handle,
>   						    intel_pmic_thermal_handler,
>   						    NULL, opregion);
>   	if (ACPI_FAILURE(status)) {
> -		acpi_remove_address_space_handler(handle, PMIC_POWER_OPREGION_ID,
> -						  intel_pmic_power_handler);
>   		ret = -ENODEV;
>   		goto out_remove_power_handler;
>   	}
> 
