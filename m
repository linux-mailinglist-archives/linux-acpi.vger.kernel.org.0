Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CD48E4C8B6
	for <lists+linux-acpi@lfdr.de>; Thu, 20 Jun 2019 09:55:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725966AbfFTHzs (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 20 Jun 2019 03:55:48 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:37453 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725912AbfFTHzs (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 20 Jun 2019 03:55:48 -0400
Received: by mail-wr1-f65.google.com with SMTP id v14so1955982wrr.4
        for <linux-acpi@vger.kernel.org>; Thu, 20 Jun 2019 00:55:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=Gh9W5/GePIdJPYsbievPRqI2sEImz3p8nPrvCOdAnwE=;
        b=wteyUX5W39y/ZucePY2SSaeNmQcPplgLBHmg+lOaDdDnUfclLPsHeb552zy8a0QR2O
         eqg2VMFKxTrDYyxblUcaLPMnP0v4VyfYB5hI8RfjRGvCBcE77ny+s3G1ikEs+lKJzO4S
         ZthC2I1SCuozsjmVanNqTV27Ss+gK7lgY0ZAYWp1ug464Q/dHZ3xA4NztOM4wTkEhfQa
         ao4qKRiishLsJ5jbZe/7rkwy3zIKJfuCdLTm2yivFO1fYr8f74/SY0ckvgBvOJ9Ewq+t
         Vn1+rUmcp8bIKrQ3vXta9Xjkqfc2jCrFMp7CA08X/3bQBqfDnfPcUel/KfoQCBrbVEvS
         zMxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=Gh9W5/GePIdJPYsbievPRqI2sEImz3p8nPrvCOdAnwE=;
        b=Efl6+s2wCg2wwOxz331YpFzVxf0JEYevZYy436beVR9WMuWKoWF5X4dK4RKaFY+MtY
         zLrSANL2EdWXDNSzNjTBw9AAx4jvDKsNC1k9Tn/26nOsYlm0xXg9xSUg9T+FJVn9mW3U
         L3miaeypIV8GRl+Fnpe5wP5ADMzmXhK47YV/QRzUprj/Te5gXy4LFhY+cGxsV+k41+OG
         8oDGj+PlXoG758B/+YBwoOC9+OJ7E24WOnnroWBpHWshK3CXEfkU9HRd8395DtxJ6YIq
         heGff46P6+pvnRMJXQ5Zld8q+1QRn+Fv69+agmok8lC6lN+1KFQYJ74840zHlqqEdren
         h0Ug==
X-Gm-Message-State: APjAAAV3XTLNC+RZr5f2a947MThaNIDFEDHYOhsz+/PDW9N+39KT5TY4
        gbnHhZLhshiVKvrNIJWTbAnwxw==
X-Google-Smtp-Source: APXvYqzXkq8UWfb6q6eTvGiHjAYiqH3i7UiJ2xXe/b4xMgjhkQHEDFdKkx8mT5SYYayfcivhb/iUDg==
X-Received: by 2002:adf:cc92:: with SMTP id p18mr44312025wrj.260.1561017345954;
        Thu, 20 Jun 2019 00:55:45 -0700 (PDT)
Received: from dell ([2.27.35.243])
        by smtp.gmail.com with ESMTPSA id b2sm26344792wrp.72.2019.06.20.00.55.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 20 Jun 2019 00:55:45 -0700 (PDT)
Date:   Thu, 20 Jun 2019 08:55:43 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     linux-acpi@vger.kernel.org, lenb@kernel.org, rjw@rjwysocki.net
Subject: Re: [PATCH] acpi: make AC and battery drivers available on !X86
Message-ID: <20190620075543.GA4699@dell>
References: <20190620073353.5770-1-ard.biesheuvel@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190620073353.5770-1-ard.biesheuvel@linaro.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, 20 Jun 2019, Ard Biesheuvel wrote:

> ACPI battery and AC devices can be found in arm64 laptops as well,
> so drop the Kconfig dependency on X86 for their drivers.
> 
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> ---
>  drivers/acpi/Kconfig | 2 --
>  1 file changed, 2 deletions(-)

Tested-by: Lee Jones <lee.jones@linaro.org>

> diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
> index e016f7a6ed13..3c8011e7b0d7 100644
> --- a/drivers/acpi/Kconfig
> +++ b/drivers/acpi/Kconfig
> @@ -155,7 +155,6 @@ config ACPI_EC_DEBUGFS
>  
>  config ACPI_AC
>  	tristate "AC Adapter"
> -	depends on X86
>  	select POWER_SUPPLY
>  	default y
>  	help
> @@ -168,7 +167,6 @@ config ACPI_AC
>  
>  config ACPI_BATTERY
>  	tristate "Battery"
> -	depends on X86
>  	select POWER_SUPPLY
>  	default y
>  	help

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
