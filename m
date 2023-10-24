Return-Path: <linux-acpi+bounces-860-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B6D87D4778
	for <lists+linux-acpi@lfdr.de>; Tue, 24 Oct 2023 08:30:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 744D8B20CB3
	for <lists+linux-acpi@lfdr.de>; Tue, 24 Oct 2023 06:30:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6884125C8
	for <lists+linux-acpi@lfdr.de>; Tue, 24 Oct 2023 06:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="foHyIBuz"
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3A5F20F7
	for <linux-acpi@vger.kernel.org>; Tue, 24 Oct 2023 05:55:33 +0000 (UTC)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28863D68
	for <linux-acpi@vger.kernel.org>; Mon, 23 Oct 2023 22:55:31 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-4083f613272so34963995e9.1
        for <linux-acpi@vger.kernel.org>; Mon, 23 Oct 2023 22:55:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698126929; x=1698731729; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JRKAq32kiO8SHEJdnq8IZIE4OyF7eOxyRpbcJQrGcHc=;
        b=foHyIBuzRQxjus4VWScbugguROw596fMtWa7AwrGCwots+9gZ8Gmc2g+yB/lFrCUSY
         nDbKg7CGdZ6Ewo1tetnMMUiYJHRVVHIKnRH9goUwRkqDiOJkN4dqyeHDyXwemUnUcBm3
         zHyYXCBm4Iw3g4UbjAXaIHwSkdKm/XSseYdI/16Pdukbsc7BbVKqc5JGBpDB89jHMF9s
         /pvpTQNYmd8NRG7qSzOglEqexCciYx7+FoPYwD20AyvGfU4hKRjBLqlh9T1tNcpAab2m
         ASEoXN3P345q4opwzITxi0ET2uLlJXM93XyD/PklOxpcGC2Ijs9HsUcj5TYW9bIGMhDo
         v4UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698126929; x=1698731729;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JRKAq32kiO8SHEJdnq8IZIE4OyF7eOxyRpbcJQrGcHc=;
        b=idf41A8Auh8TWXX+b5JIXUwRxPTE5uGX2YAvBxzG7cyojd5OXSmZzJtZVyFXFblzC4
         tL21X0xTK8RJbipnGnfyLtEjcr4jBxjaBpIN7yGsULWRSaqv8CyGPeWJhyqU0L3pT79k
         FwYG7ge9zlkjn0YNtDl9ozbtSiKp0dFGKwRLO3HqTzfdW5ovC/r5gkOeXVTTKVVw57su
         8NQLxCr7ZZNjdn36ZiNUCuE1f0TTRzmNg/DQGPXW/+bbHe7lBJMydZ6Jh1tU/BiGhYWV
         xN2jRL1HqddwH8ZqDI4CXIvc1FlHnKCpt+hz9GhgYrlaPeQicmZLWuIfJa/PO7T2Y1o3
         eoJA==
X-Gm-Message-State: AOJu0YyhRrzu0MQdo8DOoMreBcbkOb1JovqzWHiUu50LEo8OqqKIH4fL
	fbDDBcdqRXUboXyH1z5hzB5+eeBcMlQBTe7Gptk=
X-Google-Smtp-Source: AGHT+IFL+Yalmba6O5qvPo/OHqywkkRoLeTLgboMat0T78uwgR8AaQMIHrMeEb/tY3FwqMKnyi2Dcw==
X-Received: by 2002:adf:e4cc:0:b0:32d:a3c5:ea80 with SMTP id v12-20020adfe4cc000000b0032da3c5ea80mr7126077wrm.51.1698126929400;
        Mon, 23 Oct 2023 22:55:29 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id n15-20020adfe78f000000b003197869bcd7sm9174110wrm.13.2023.10.23.22.55.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Oct 2023 22:55:29 -0700 (PDT)
Date: Tue, 24 Oct 2023 08:55:25 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: rafael@kernel.org, lenb@kernel.org, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH 2/4] ACPI: sysfs: Fix a potential out-of-bound write in
 create_of_modalias()
Message-ID: <df33bc21-4792-4395-bbe0-4c8893818f6b@kadam.mountain>
References: <cover.1698081019.git.christophe.jaillet@wanadoo.fr>
 <004a9aa85dcc37d112443e133c9edfd7624cd47b.1698081019.git.christophe.jaillet@wanadoo.fr>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <004a9aa85dcc37d112443e133c9edfd7624cd47b.1698081019.git.christophe.jaillet@wanadoo.fr>

On Mon, Oct 23, 2023 at 09:33:16PM +0200, Christophe JAILLET wrote:
> The remaining size of the buffer used by snprintf() is not updated after
> the first write, so subsequent write in the 'for' loop a few lines below
> can write some data past the end of the 'modalias' buffer.
> 
> Correctly update the remaining size.
> 
> Note that this pattern is already correctly written in
> create_pnp_modalias().
> 
> Fixes: 8765c5ba1949 ("ACPI / scan: Rework modalias creation when "compatible" is present")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
>  drivers/acpi/device_sysfs.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/acpi/device_sysfs.c b/drivers/acpi/device_sysfs.c
> index 4deb36dccb73..7ec3142f3eda 100644
> --- a/drivers/acpi/device_sysfs.c
> +++ b/drivers/acpi/device_sysfs.c
> @@ -215,6 +215,8 @@ static int create_of_modalias(const struct acpi_device *acpi_dev, char *modalias
>  	if (len >= size)
>  		return -ENOMEM;
>  
> +	size -= len;
> +

Yeah.  This is a good bugfix but it also shows why the canonical format
is better.  In the canonical format the "size - len" happens as part of
snprintf() instead of on a separate line where it can be forgotten.

	len += snprintf(buf + len, size - len, "string");

Also the user space version of snprintf() can fail but the
kernel space version can't.  This code is more complicated and introduces
a memory corruption bug because it is pretending that we need to check
for negatives.  People (someone) sometimes (once ten years ago) tell me
that checking for negatives is important for security but actually it's
the reverse.

regards,
dan carpenter


