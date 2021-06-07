Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B818839D36C
	for <lists+linux-acpi@lfdr.de>; Mon,  7 Jun 2021 05:27:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230169AbhFGD27 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sun, 6 Jun 2021 23:28:59 -0400
Received: from mail-pf1-f171.google.com ([209.85.210.171]:43601 "EHLO
        mail-pf1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230127AbhFGD27 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sun, 6 Jun 2021 23:28:59 -0400
Received: by mail-pf1-f171.google.com with SMTP id t28so12049138pfg.10
        for <linux-acpi@vger.kernel.org>; Sun, 06 Jun 2021 20:26:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=7Dch5XxlBwOHZRN59cFkhlYsFVftmc/hmWGUQo14o6E=;
        b=QO9jBNmKqibUB6BZj/WNSNhz7Mzg2TwQ0mt1QBMu1d1cloed/XBrfIbkJvEhKOkCWV
         19wwQaTl1f/XblWr91QkILxdc2K0p54Nhb5pdh1AQTjdtoiV88iiEPB23Kl3V/Ufk7XU
         Cmyf8Hzm6tzuLW/C+6d/dq8GJd4Rqu7gWEnxyOGLSAxtIxl6o707cJ6RiX7vOheyB010
         7EPKrNLB2d+Qi40OBDZHCMxOWVE/Iu383hFTldlnuGo+yHR5zvnUPYyXS3y6YNQJv32M
         CLpjKhcgPmYK7Ls5/6Fq9e/cuxBfJgQRvsVsmFoGfmQ0OAqshTtTFuwMMPjhECXQL1xS
         gUcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=7Dch5XxlBwOHZRN59cFkhlYsFVftmc/hmWGUQo14o6E=;
        b=GP2axicZXUliy5H7I5OlPpLZg5Vm5yMUR51JsO0b6w5be013rsmJJp39VKbvhEDn5Y
         iMxbSu9fR5ziKYnmE1wdkXVqcMSrj8QVn7wfxgS7W4XYFkAUtzStZYq3o2JB0BFV826r
         D9zCcAA+dHwk0tsFlwJfx3a/vWv+srR5Erq1kaFAzfL8GE4/XgGclfpl5J/n1AOgR9FX
         3DvgYZ39kIIMYHXZF5vgzVlDUYRjfwU4dhdKbJGCoaJrNJF5wct2nDRXI4VccUSbt//d
         ttkeptzh3e/pj3t6P1cfvI9yxSiZuNUWnouCPv0YErTRH0LOIj3nQpHQx4K2eMICd6+g
         Bx1w==
X-Gm-Message-State: AOAM5333wb4/uk8QxX1KtIrgjVGe59F57GO9Sm2/hAtSLLEcmWxsB6FM
        Z8j8xDwFJEULZ7nR6M1vI3g3tQ==
X-Google-Smtp-Source: ABdhPJyAqA37oez/nPsCcvC/NLbSQTAZOlva3EWPvOgCRqpq4fdGRY6qdmQtjzZrSdW7oaFbyy43cg==
X-Received: by 2002:a62:1b88:0:b029:1fb:d3d0:343a with SMTP id b130-20020a621b880000b02901fbd3d0343amr15003381pfb.76.1623036353895;
        Sun, 06 Jun 2021 20:25:53 -0700 (PDT)
Received: from localhost ([136.185.169.128])
        by smtp.gmail.com with ESMTPSA id g2sm2034787pfc.142.2021.06.06.20.25.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Jun 2021 20:25:53 -0700 (PDT)
Date:   Mon, 7 Jun 2021 08:55:50 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     kyle.meyer@hpe.com
Cc:     rjw@rjwysocki.net, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org,
        Takashi Iwai <tiwai@suse.com>
Subject: Re: [PATCH] acpi-cpufreq: Skip cleanup if initialization didn't occur
Message-ID: <20210607032550.qdnl2sxnny42rtwa@vireshk-i7>
References: <20210604170500.46875-1-kyle.meyer@hpe.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210604170500.46875-1-kyle.meyer@hpe.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 04-06-21, 12:05, kyle.meyer@hpe.com wrote:
> From: Kyle Meyer <kyle.meyer@hpe.com>
> 
> acpi-cpufreq is loaded without performing initialization when a cpufreq
> driver exists.
> 
> If initialization didn't occur then skip cleanup in acpi_cpufreq_exit().
> This prevents unnecessary freeing and unregistering when the module is
> unloaded.
> 
> Reported-by: Takashi Iwai <tiwai@suse.com>
> Signed-off-by: Kyle Meyer <kyle.meyer@hpe.com>
> ---
>  drivers/cpufreq/acpi-cpufreq.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/drivers/cpufreq/acpi-cpufreq.c b/drivers/cpufreq/acpi-cpufreq.c
> index 7e7450453714..8d425f14c267 100644
> --- a/drivers/cpufreq/acpi-cpufreq.c
> +++ b/drivers/cpufreq/acpi-cpufreq.c
> @@ -1042,8 +1042,19 @@ static int __init acpi_cpufreq_init(void)
>  
>  static void __exit acpi_cpufreq_exit(void)
>  {
> +	const char *current_driver;
> +
>  	pr_debug("%s\n", __func__);
>  
> +	/*
> +	 * If another cpufreq_driver was loaded, preventing acpi-cpufreq from
> +	 * registering, there's no need to unregister it.
> +	 */
> +	current_driver = cpufreq_get_current_driver();
> +	if (!current_driver ||
> +	    strncmp(current_driver, acpi_cpufreq_driver.name, strlen(acpi_cpufreq_driver.name)))
> +		return;
> +
>  	acpi_cpufreq_boost_exit();
>  
>  	cpufreq_unregister_driver(&acpi_cpufreq_driver);

Looks like some misunderstanding here, this shouldn't happen. If
initialization didn't occur, then exit shall never be called.

-- 
viresh
