Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEB424BE407
	for <lists+linux-acpi@lfdr.de>; Mon, 21 Feb 2022 18:58:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355193AbiBUKkD (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 21 Feb 2022 05:40:03 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:60094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355241AbiBUKjw (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 21 Feb 2022 05:39:52 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 54676249
        for <linux-acpi@vger.kernel.org>; Mon, 21 Feb 2022 02:01:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1645437663;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7zRfE52oN/QSXCEKNsEZ7++nbxAmr5JsTor+N2gBmzI=;
        b=IJgyCidgiHGhfkqLQNdmYpM7BqQeVOJ8kpbCOl4mUyh5qwb1GtIlaAxxiWyuNw/ndVRELa
        dN6yFbBfcqTfeup6WW9BPS7vIHyvgEsfsHr4zcHzStIzS81JLV0+TLLc/28QZ+FV89YFCB
        eky9GoIs9VzNeA7TYQFmIpaG9GTE2FY=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-672-hCGJjE9wPGaXDTWeZAeOxQ-1; Mon, 21 Feb 2022 05:01:01 -0500
X-MC-Unique: hCGJjE9wPGaXDTWeZAeOxQ-1
Received: by mail-ed1-f70.google.com with SMTP id l14-20020aa7cace000000b003f7f8e1cbbdso9850775edt.20
        for <linux-acpi@vger.kernel.org>; Mon, 21 Feb 2022 02:01:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=7zRfE52oN/QSXCEKNsEZ7++nbxAmr5JsTor+N2gBmzI=;
        b=CrIO7ZY/y4QdfX9pvPTa93dTjx08xZOsop3dZpSJ/d2HsxE0OY+7czxYEqA3adGzyM
         cwaLiv4zJZgdfZ/ABIa1pVvGEO9baBSiyuECR1ADeFNPt6FPGOsCsGc3J2PcNvX9UsbE
         5rBrsz0LQKMOpsXwHCYzqYJyAy6XZX+sPKdPWVGcyTeFEfTLYeo5Rj7QWeThdogdF/+r
         rXoWYL5B/zYj9W/C4QmAFRVF5RuNfwTamkqML20Pd1citBmGQ90tILKkVgNl0fWGw+gl
         oYAnm1xbAledtpk0afVOsQvawgoVUAkp1g+nKGFs+4LmbrrXLrCEjx00I9IZiN2H/8C8
         U4Yw==
X-Gm-Message-State: AOAM531pKnZVuJSrjCTNiXK5hI/Uq53tPlFNXnm6LhLRe+UWtF7b/WcQ
        G/++34dquoa8q8+084YqHd+3PlL+2ZVJzW5PXsRxZTIGlnNpzyk/d5DkJBXGl87MFq4sS2UOHaA
        EKWeaDsX8wbPkaZOP5LPnUA==
X-Received: by 2002:aa7:d592:0:b0:410:b9f9:90f2 with SMTP id r18-20020aa7d592000000b00410b9f990f2mr20653667edq.327.1645437660451;
        Mon, 21 Feb 2022 02:01:00 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwKxxF03XDkkjYZ6BX/PbJeA9bUIOPF7+CUVN7njnRJrqqGbBNAH8lOCWNvtEeuuU0wdXkISA==
X-Received: by 2002:aa7:d592:0:b0:410:b9f9:90f2 with SMTP id r18-20020aa7d592000000b00410b9f990f2mr20653652edq.327.1645437660311;
        Mon, 21 Feb 2022 02:01:00 -0800 (PST)
Received: from [10.40.98.142] ([78.108.130.194])
        by smtp.gmail.com with ESMTPSA id z8sm4957427ejc.151.2022.02.21.02.00.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Feb 2022 02:00:59 -0800 (PST)
Message-ID: <7d5f6a24-3c2c-355a-7ea1-92c9e364bfa6@redhat.com>
Date:   Mon, 21 Feb 2022 11:00:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH 4/6] platform/x86: int3472: Add terminator to
 gpiod_lookup_table
Content-Language: en-US
To:     Daniel Scally <djrscally@gmail.com>, linux-acpi@vger.kernel.org,
        linux-clk@vger.kernel.org, platform-driver-x86@vger.kernel.org
Cc:     rafael@kernel.org, lenb@kernel.org, mturquette@baylibre.com,
        sboyd@kernel.org, markgross@kernel.org, robert.moore@intel.com
References: <20220216225304.53911-1-djrscally@gmail.com>
 <20220216225304.53911-5-djrscally@gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20220216225304.53911-5-djrscally@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi,

On 2/16/22 23:53, Daniel Scally wrote:
> Without the terminator, if a con_id is passed to gpio_find() that
> does not exist in the lookup table the function will not stop looping
> correctly, and eventually cause an oops.
> 
> Fixes: 1596ef1251b5 ("platform/x86: int3472: Pass tps68470_regulator_platform_data to the tps68470-regulator MFD-cell")
> Signed-off-by: Daniel Scally <djrscally@gmail.com>
> ---
>  drivers/platform/x86/intel/int3472/tps68470_board_data.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/platform/x86/intel/int3472/tps68470_board_data.c b/drivers/platform/x86/intel/int3472/tps68470_board_data.c
> index f93d437fd192..525f09a3b5ff 100644
> --- a/drivers/platform/x86/intel/int3472/tps68470_board_data.c
> +++ b/drivers/platform/x86/intel/int3472/tps68470_board_data.c
> @@ -100,7 +100,8 @@ static struct gpiod_lookup_table surface_go_tps68470_gpios = {
>  	.dev_id = "i2c-INT347A:00",
>  	.table = {
>  		GPIO_LOOKUP("tps68470-gpio", 9, "reset", GPIO_ACTIVE_LOW),
> -		GPIO_LOOKUP("tps68470-gpio", 7, "powerdown", GPIO_ACTIVE_LOW)
> +		GPIO_LOOKUP("tps68470-gpio", 7, "powerdown", GPIO_ACTIVE_LOW),
> +		{ }
>  	}
>  };
>  


Oops, I'll got and apply this to pdx86/for-next and pdx86/fixes right away. Please drop this
from the next version of the series.

Regards,

Hans

