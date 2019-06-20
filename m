Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 483024C8AF
	for <lists+linux-acpi@lfdr.de>; Thu, 20 Jun 2019 09:53:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725912AbfFTHxb (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 20 Jun 2019 03:53:31 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:34943 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725877AbfFTHxb (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 20 Jun 2019 03:53:31 -0400
Received: by mail-wr1-f66.google.com with SMTP id m3so1962770wrv.2
        for <linux-acpi@vger.kernel.org>; Thu, 20 Jun 2019 00:53:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=lsH4ngDT/IdZoy4iegWWymDr6AeZO2FoX+v0sL59S/I=;
        b=iQsP9zZQDrH362G1r/CZ1OPNk5wLoR8zIomFtOu2gAbskhz9nQ3HKeF6mJbP9rVPq3
         tAOHNJFczTm3T4oD6EZ2i50NXcuGAKvRacF54rMVTPKdnm7wni2JW676wor1o5iPbGDv
         yy8v5jRp8SjvI1rVbjZAg2fiKlwp/jBGtEem1rRpOgx5ZcaDEdBInzp7uX1n4fuA3qL2
         I1g/oKK8PEI831IvntNvoogM2pT6Gt7f6gsfdq7upihtRiXH6ZpiOdsVRy0o7GNyHmmT
         df0P3vRwYMeyJczZ6v9O2xS5PL/Dp848L0RfPE4JL7efkAjlFvRzVBwUqVd8GIl0j//v
         mAXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=lsH4ngDT/IdZoy4iegWWymDr6AeZO2FoX+v0sL59S/I=;
        b=JziTHKQr9uOB5FGA4ZQK6Uf1g5DVIpJQ4pg3OuwRzS4TauV/CQ1hR0bA2UpwOXLpVl
         gShJU86GpTYdvhshpZ2UF2GLomBbg3xNv/K7EX6Aw1vRjOTv/39shiQIY3JngxbwDlQl
         4e7I9mgeAWWh2yfIT0KMh7a0SOXkFpDfDTl8eY5o67iumJvcqR6n8r7aGzVulivnxXca
         5f+0K4ESchXzLp9fAsVCkHTLEP0owWohDpYVgdRMqcj9/F13GJXR4zG6q4hqInBN6ZoM
         E9d4HOyRsI53Mtbgxoj5rbe3rLesWW34m5jYkCZ4svVSW7DSKjHOaX+Ye1ioz+IkvvIi
         InCQ==
X-Gm-Message-State: APjAAAXJAfqv/PfBAu7rffCwwgtlU37TdtUzMQJSAZjxTLv3GTbIp0zH
        5LlXugDanmBjlM4PDZhQnSIfWw==
X-Google-Smtp-Source: APXvYqxbGKCKLUn3drTEpSz73VjgGxfZE9vrgDD+Nfc1mCFbKox+zYrpH9lA3V3XjjOS4BUgKN3W/g==
X-Received: by 2002:adf:e311:: with SMTP id b17mr90917417wrj.11.1561017208729;
        Thu, 20 Jun 2019 00:53:28 -0700 (PDT)
Received: from localhost ([2a02:8010:64d6:1:af8:edfb:42f3:6c14])
        by smtp.gmail.com with ESMTPSA id a84sm5174055wmf.29.2019.06.20.00.53.27
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 20 Jun 2019 00:53:27 -0700 (PDT)
Date:   Thu, 20 Jun 2019 08:53:26 +0100
From:   Graeme Gregory <graeme.gregory@linaro.org>
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org,
        catalin.marinas@arm.com, will.deacon@arm.com,
        lorenzo.pieralisi@arm.com, lee.jones@linaro.org,
        leif.lindholm@linaro.org
Subject: Re: [RFC PATCH] acpi/arm64: ignore 5.1 FADTs that are reported as 5.0
Message-ID: <20190620075326.GA2148@xora-haswell.xora.org.uk>
References: <20190619121831.7614-1-ard.biesheuvel@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190619121831.7614-1-ard.biesheuvel@linaro.org>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, Jun 19, 2019 at 02:18:31PM +0200, Ard Biesheuvel wrote:
> Some Qualcomm Snapdragon based laptops built to run Microsoft Windows
> are clearly ACPI 5.1 based, given that that is the first ACPI revision
> that supports ARM, and introduced the FADT 'arm_boot_flags' field,
> which has a non-zero field on those systems.
> 
> So in these cases, infer from the ARM boot flags that the FADT must be
> 5.1 or later, and treat it as 5.1.
> 

Makes sense, I did actually see this in the wild in SBSA machine too
once.

Reviewed-by: Graeme Gregory <graeme.gregory@linaro.org>

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
>  	}
>  
>  	if (!(fadt->flags & ACPI_FADT_HW_REDUCED)) {
> -- 
> 2.20.1
> 
