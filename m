Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 64B184B830
	for <lists+linux-acpi@lfdr.de>; Wed, 19 Jun 2019 14:27:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727591AbfFSM07 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 19 Jun 2019 08:26:59 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:44741 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726246AbfFSM07 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 19 Jun 2019 08:26:59 -0400
Received: by mail-wr1-f68.google.com with SMTP id r16so6924wrl.11
        for <linux-acpi@vger.kernel.org>; Wed, 19 Jun 2019 05:26:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=QSWfzJ0IRnF5xM0kWm72D/t5avHd1tYQoEhgeDHA46Q=;
        b=iupYsJDTD6mefB1y16YhkAJii90fPfiEiLvnoMCucdnD5ePNHAoEj8hrBUgDVg4xUy
         6I9tJfBHzoQdZwqHERvMsnkhrbcHcI0imlUVuDGVUwkSBGK9TOpl9AWru4wm9toD+sQ5
         IfgrAVdXHByoj7SrIplgc2eIDxBPTW3oYRqJdFylf+oCWELSjKxCc4r8kyjBuqpldzih
         zfHDjcodoaD0le2uylm8RAF0c+mVoWelzaDrA6kecm+iXrrrJIJ6Ua5fmRaq1lBNjJxo
         5IXnOOdbVuUk2zJbgNCg3LVpcs2S/CpKXEd3JOz+wV/vRmC9wRLz8Yfc+z/nHkHq5Q2K
         kjzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=QSWfzJ0IRnF5xM0kWm72D/t5avHd1tYQoEhgeDHA46Q=;
        b=kvR730ljw9lN/nMGMBz6HASjXH8hdokPRHu9ZR2/pt1tBSzO086WJysustwYRcqxXz
         tWSAWAjSuw4Na2cBHfOUSZOIChsv8oilRW+Be0mHenvtWVm5+QiwyUjAfOFSNiKHPD+r
         qRhsKZdFY1mCynuPh5T7yjmYVgYCYD9Z1X0PA96kBmAupFYOOWZef6pC80Hr/a+0VqFd
         CHah9NjtTHgqMK+8QzYY+U/TkhcpUcYBlSkiFQhCbsO7MNwvnlg3+AXAd9fOM4w8OLiA
         tQv8eb/b0DGtCWa2luZ4yJkxQlA3ZacIrCGzpJ/er4eU/6eMJZS0kodnw4d67DwTw21C
         6Gaw==
X-Gm-Message-State: APjAAAXhB/tQcIth/uoduV67AwmMWU2RFk+L//hvZQLEPNxhORv3oxqw
        zwXKfAdccGkZni5b4tU9f8KX7w==
X-Google-Smtp-Source: APXvYqx8othWu4CA1HkcpGGfLKUMxtT7r5TURqOCCXY26bgsNPt7GqM4/aKfAHqLCmhlMO46iUr5ig==
X-Received: by 2002:adf:f246:: with SMTP id b6mr26825721wrp.92.1560947217213;
        Wed, 19 Jun 2019 05:26:57 -0700 (PDT)
Received: from dell ([2.27.35.243])
        by smtp.gmail.com with ESMTPSA id j7sm19058928wru.54.2019.06.19.05.26.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 19 Jun 2019 05:26:56 -0700 (PDT)
Date:   Wed, 19 Jun 2019 13:26:55 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org,
        catalin.marinas@arm.com, will.deacon@arm.com,
        lorenzo.pieralisi@arm.com, leif.lindholm@linaro.org
Subject: Re: [RFC PATCH] acpi/arm64: ignore 5.1 FADTs that are reported as 5.0
Message-ID: <20190619122655.GL18371@dell>
References: <20190619121831.7614-1-ard.biesheuvel@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190619121831.7614-1-ard.biesheuvel@linaro.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, 19 Jun 2019, Ard Biesheuvel wrote:

> Some Qualcomm Snapdragon based laptops built to run Microsoft Windows
> are clearly ACPI 5.1 based, given that that is the first ACPI revision
> that supports ARM, and introduced the FADT 'arm_boot_flags' field,
> which has a non-zero field on those systems.
> 
> So in these cases, infer from the ARM boot flags that the FADT must be
> 5.1 or later, and treat it as 5.1.
> 
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> ---
>  arch/arm64/kernel/acpi.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm64/kernel/acpi.c b/arch/arm64/kernel/acpi.c
> index 803f0494dd3e..7722e85fb69c 100644
> --- a/arch/arm64/kernel/acpi.c
> +++ b/arch/arm64/kernel/acpi.c
> @@ -155,10 +155,14 @@ static int __init acpi_fadt_sanity_check(void)
>  	 */
>  	if (table->revision < 5 ||
>  	   (table->revision == 5 && fadt->minor_revision < 1)) {
> -		pr_err("Unsupported FADT revision %d.%d, should be 5.1+\n",
> +		pr_err(FW_BUG "Unsupported FADT revision %d.%d, should be 5.1+\n",
>  		       table->revision, fadt->minor_revision);
> -		ret = -EINVAL;
> -		goto out;
> +
> +		if (!fadt->arm_boot_flags) {
> +			ret = -EINVAL;
> +			goto out;
> +		}
> +		pr_err("FADT has ARM boot flags set, assuming 5.1\n");

Tested-by: Lee Jones <lee.jones@linaro.org>

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
