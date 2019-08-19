Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 908379226E
	for <lists+linux-acpi@lfdr.de>; Mon, 19 Aug 2019 13:31:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727502AbfHSLbI (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 19 Aug 2019 07:31:08 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58760 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727473AbfHSLbI (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 19 Aug 2019 07:31:08 -0400
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com [209.85.208.72])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 76A5B2A09D1
        for <linux-acpi@vger.kernel.org>; Mon, 19 Aug 2019 11:31:07 +0000 (UTC)
Received: by mail-ed1-f72.google.com with SMTP id w22so1915848edx.8
        for <linux-acpi@vger.kernel.org>; Mon, 19 Aug 2019 04:31:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=bliPZUwt3rw3R1LnKj87BgdlVnLez+wpqoT9LgfLIh4=;
        b=gm6LQmlBy55RhqoV3FODzSgfr0F/2ANs5cSk1vK1Yjh+mstxTmREjXD7h5047BhuTK
         ESEsTibX4rx6zmxvJG+arJlMz8hkqhcABezw+m+EfzTdssgPPr7eURfXyHOTGqEDDL10
         JUIL7lxzKzvk6M3W/rlJP41engKqte8PP9ovkUeb/8sV9L/yy9lPQJ+PqmT/ncud4p27
         A4l1Dr6c606KV0T3E1N0jd62BOnXWBwlKmEA+NCJXVQQ1TiWfgEmCiMGBaETY51suuKG
         Kj3B4lq7FZK6vGxlRUVEf5wbCnfksL1jtHkc8Z5OZUkKI21ZIJVFX5EfTvpN50EVqPGr
         wp1w==
X-Gm-Message-State: APjAAAViOJtBmfJQjQQbh3oTYOMlfnAQuwbLgoIDMj35eHP003Ys1Fe+
        Vtw5cxE/trNf8bteiYsjG5bgtlyJfrz6fUyVRMZVSpUTzKwn5Fg2LobA5w7gzx2pActmlhmCX4i
        kVOsdhO7GZQOk+3vHCPVQNw==
X-Received: by 2002:a05:6402:1846:: with SMTP id v6mr21352814edy.31.1566214266168;
        Mon, 19 Aug 2019 04:31:06 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwtB82lEWaRANjYOKWEnVE1pjT1fpZpl0OyDkfWNLhxyA5ZSHpuDoLi9/cM3/4ooLELFN4wzA==
X-Received: by 2002:a05:6402:1846:: with SMTP id v6mr21352788edy.31.1566214265926;
        Mon, 19 Aug 2019 04:31:05 -0700 (PDT)
Received: from shalem.localdomain (84-106-84-65.cable.dynamic.v4.ziggo.nl. [84.106.84.65])
        by smtp.gmail.com with ESMTPSA id i23sm2728772edv.11.2019.08.19.04.31.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Aug 2019 04:31:05 -0700 (PDT)
Subject: Re: [PATCH v2] Skip deferred request irqs for devices known to fail
To:     Ian W MORRISON <ianwmorrison@gmail.com>,
        benjamin.tissoires@redhat.com, mika.westerberg@linux.intel.com,
        andriy.shevchenko@linux.intel.com, linus.walleij@linaro.org,
        bgolaszewski@baylibre.com
Cc:     linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20190819112637.29943-1-ianwmorrison@gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <1bd012ca-9b2f-78c3-abb1-6b5680add404@redhat.com>
Date:   Mon, 19 Aug 2019 13:31:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190819112637.29943-1-ianwmorrison@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi All,

On 19-08-19 13:26, Ian W MORRISON wrote:
> Patch ca876c7483b6 "gpiolib-acpi: make sure we trigger edge events at
> least once on boot" causes the MINIX family of mini PCs to fail to boot
> resulting in a "black screen".
> 
> This patch excludes MINIX devices from executing this trigger in order
> to successfully boot.
> 
> Cc: stable@vger.kernel.org
> Signed-off-by: Ian W MORRISON <ianwmorrison@gmail.com>
> Reviewed-by: Hans de Goede <hdegoede@redhat.com>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Erm, you cannot just add someone's Reviewed-by tag because they have
looked at the patch, you are only supposed to do that when the reviewer
actually puts that in his reply, then you can copy the line and
add it to your commit msg. Please drop these.

Also I might be able to get my hands on a Minix Neo Z83-4 myself
in a couple of days and then I can try to reproduce this, so lets
wait a bit for that and see how that goes.

Regards,

Hans




> ---
>   drivers/gpio/gpiolib-acpi.c | 33 +++++++++++++++++++++++++++------
>   1 file changed, 27 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/gpio/gpiolib-acpi.c b/drivers/gpio/gpiolib-acpi.c
> index fdee8afa5339..f6c3dcdc91c9 100644
> --- a/drivers/gpio/gpiolib-acpi.c
> +++ b/drivers/gpio/gpiolib-acpi.c
> @@ -13,6 +13,7 @@
>   #include <linux/gpio/machine.h>
>   #include <linux/export.h>
>   #include <linux/acpi.h>
> +#include <linux/dmi.h>
>   #include <linux/interrupt.h>
>   #include <linux/mutex.h>
>   #include <linux/pinctrl/pinctrl.h>
> @@ -20,6 +21,17 @@
>   #include "gpiolib.h"
>   #include "gpiolib-acpi.h"
>   
> +static const struct dmi_system_id skip_deferred_request_irqs_table[] = {
> +	{
> +		.ident = "MINIX Z83-4",
> +		.matches = {
> +			DMI_EXACT_MATCH(DMI_SYS_VENDOR, "MINIX"),
> +			DMI_MATCH(DMI_PRODUCT_NAME, "Z83-4"),
> +		},
> +	},
> +	{}
> +};
> +
>   /**
>    * struct acpi_gpio_event - ACPI GPIO event handler data
>    *
> @@ -1273,19 +1285,28 @@ bool acpi_can_fallback_to_crs(struct acpi_device *adev, const char *con_id)
>   	return con_id == NULL;
>   }
>   
> -/* Run deferred acpi_gpiochip_request_irqs() */
> +/*
> + * Run deferred acpi_gpiochip_request_irqs()
> + * but exclude devices known to fail
> +*/
>   static int acpi_gpio_handle_deferred_request_irqs(void)
>   {
>   	struct acpi_gpio_chip *acpi_gpio, *tmp;
> +	const struct dmi_system_id *dmi_id;
>   
> -	mutex_lock(&acpi_gpio_deferred_req_irqs_lock);
> -	list_for_each_entry_safe(acpi_gpio, tmp,
> +	dmi_id = dmi_first_match(skip_deferred_request_irqs_table);
> +	if (dmi_id)
> +		return 0;
> +	else {
> +		mutex_lock(&acpi_gpio_deferred_req_irqs_lock);
> +		list_for_each_entry_safe(acpi_gpio, tmp,
>   				 &acpi_gpio_deferred_req_irqs_list,
>   				 deferred_req_irqs_list_entry)
> -		acpi_gpiochip_request_irqs(acpi_gpio);
> +			acpi_gpiochip_request_irqs(acpi_gpio);
>   
> -	acpi_gpio_deferred_req_irqs_done = true;
> -	mutex_unlock(&acpi_gpio_deferred_req_irqs_lock);
> +		acpi_gpio_deferred_req_irqs_done = true;
> +		mutex_unlock(&acpi_gpio_deferred_req_irqs_lock);
> +	}
>   
>   	return 0;
>   }
> 
