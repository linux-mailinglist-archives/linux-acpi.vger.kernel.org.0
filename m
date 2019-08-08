Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 531B285F66
	for <lists+linux-acpi@lfdr.de>; Thu,  8 Aug 2019 12:20:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389792AbfHHKT5 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 8 Aug 2019 06:19:57 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:38910 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389773AbfHHKT4 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 8 Aug 2019 06:19:56 -0400
Received: by mail-ed1-f67.google.com with SMTP id r12so55348829edo.5
        for <linux-acpi@vger.kernel.org>; Thu, 08 Aug 2019 03:19:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=oS2cy/4g4RlDFRc+61zq/UgTVPK/pNrXepKdT+yLXco=;
        b=r4/T8RbiIabn+Yb30jNOkoPAoEcFC1K/SGzal0BXIcjE6E04p3gKxfUPYYlbb+xaxo
         ADBDXxVi5fMdcdwYZQDc8L/Ae6MNperIHZ1hDtBz81mvxCtedKXzzvzgOsq/7eUNrzoS
         M1ZRc4K/rruc1lUCgH/D/WA7jWuCoPsrjMkFyKGooqNAaCATPlxa5zZDKfNHAkfBybg7
         ryQWN1YrNTFPIOMa2wB9Zj1Zwrkf+Tvk/kkSvUGZsONwOUXstJiALIU0r9NlUZYfX3hV
         jUQAOgnlg7DGt+bxfZH6qY+eoYS3QeExu1VvWli631rkm3rT/w4V/u6baOrOxI4XBKft
         pRxA==
X-Gm-Message-State: APjAAAX7BitabL1pBtUKqvnskYzokIZLRy1yRHBUXxX1QyaxTh1klJwh
        gdNoo1LJQnirnVEYAug8aKD+1Q==
X-Google-Smtp-Source: APXvYqw2tM5paSc8isBKnWGgAwEZzKYdgftiYWcXUtMBKQI/XSRFBC0NiTak9ef5A70MD36m5r7g2Q==
X-Received: by 2002:a17:906:e204:: with SMTP id gf4mr12251166ejb.302.1565259594667;
        Thu, 08 Aug 2019 03:19:54 -0700 (PDT)
Received: from shalem.localdomain (84-106-84-65.cable.dynamic.v4.ziggo.nl. [84.106.84.65])
        by smtp.gmail.com with ESMTPSA id b30sm22057756ede.88.2019.08.08.03.19.53
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Thu, 08 Aug 2019 03:19:53 -0700 (PDT)
Subject: Re: [PATCH 5.3 regression fix] pwm: Fallback to the static
 lookup-list when acpi_pwm_get fails
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-pwm@vger.kernel.org, linux-acpi@vger.kernel.org,
        youling257@gmail.com,
        Nikolaus Voss <nikolaus.voss@loewensteinmedical.de>
References: <20190730154848.5164-1-hdegoede@redhat.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <31c3f15e-649e-a3c1-56e2-0c35fda24ae1@redhat.com>
Date:   Thu, 8 Aug 2019 12:19:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190730154848.5164-1-hdegoede@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Thierry,

Ping? This fixes a somewhat serious regression in 5.3, can we please get
this queued up for merging into 5.3 ?

Regards,

Hans

On 30-07-19 17:48, Hans de Goede wrote:
> Commit 4a6ef8e37c4d ("pwm: Add support referencing PWMs from ACPI")
> made pwm_get unconditionally return the acpi_pwm_get return value if
> the device passed to pwm_get has an ACPI fwnode.Thieer
> 
> But even if the passed in device has an ACPI fwnode, it does not
> necessarily have the necessary ACPI package defining its pwm bindings,
> especially since the binding / API of this ACPI package has only been
> introduced very recently.
> 
> Up until now X86/ACPI devices which use a separate pwm controller for
> controlling their LCD screen's backlight brightness have been relying
> on the static lookup-list to get their pwm.
> 
> pwm_get unconditionally returning the acpi_pwm_get return value breaks
> this, breaking backlight control on these devices.
> 
> This commit fixes this by making pwm_get fall back to the static
> lookup-list if acpi_pwm_get returns -ENOENT.
> 
> BugLink: https://bugs.freedesktop.org/show_bug.cgi?id=96571
> Reported-by: youling257@gmail.com
> Fixes: 4a6ef8e37c4d ("pwm: Add support referencing PWMs from ACPI")
> Cc: Nikolaus Voss <nikolaus.voss@loewensteinmedical.de>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
>   drivers/pwm/core.c | 7 +++++--
>   1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
> index c3ab07ab31a9..8edfac17364e 100644
> --- a/drivers/pwm/core.c
> +++ b/drivers/pwm/core.c
> @@ -882,8 +882,11 @@ struct pwm_device *pwm_get(struct device *dev, const char *con_id)
>   		return of_pwm_get(dev, dev->of_node, con_id);
>   
>   	/* then lookup via ACPI */
> -	if (dev && is_acpi_node(dev->fwnode))
> -		return acpi_pwm_get(dev->fwnode);
> +	if (dev && is_acpi_node(dev->fwnode)) {
> +		pwm = acpi_pwm_get(dev->fwnode);
> +		if (!IS_ERR(pwm) || PTR_ERR(pwm) != -ENOENT)
> +			return pwm;
> +	}
>   
>   	/*
>   	 * We look up the provider in the static table typically provided by
> 
