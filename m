Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29ADF5BC9D9
	for <lists+linux-acpi@lfdr.de>; Mon, 19 Sep 2022 12:50:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230084AbiISKtr (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 19 Sep 2022 06:49:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229865AbiISKtI (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 19 Sep 2022 06:49:08 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99D0426AE6
        for <linux-acpi@vger.kernel.org>; Mon, 19 Sep 2022 03:42:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1663584130;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JSVojkQBpDH2ShcQLnYMDETdr3XUdR9J9jflqCVySAY=;
        b=N8O8jYUSHOavVWjyUNP9wcDpJhquX8o88xX3moP1y5UGsMck8zT7/ybL2twfQi1oiOrGOW
        btHZUMoZ8t+iva6IFPvULMuzurftrcOB0orulyVLCwZ2G2ZXc7/PELQ6orui9qWTICIotM
        aZeI/ODLy9Xe3Ep48kDYPZ9gnMjKtWs=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-222-l0NG9Wm5NiG0GgYAsswx1g-1; Mon, 19 Sep 2022 06:42:09 -0400
X-MC-Unique: l0NG9Wm5NiG0GgYAsswx1g-1
Received: by mail-ed1-f72.google.com with SMTP id i17-20020a05640242d100b0044f18a5379aso20350557edc.21
        for <linux-acpi@vger.kernel.org>; Mon, 19 Sep 2022 03:42:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=JSVojkQBpDH2ShcQLnYMDETdr3XUdR9J9jflqCVySAY=;
        b=s9aSsoXsc8MSkA9safAeSpBYriKqF0FJCno72CqEke7DZJp5MHX0Hk/dd//M7bnnKG
         2e9nw4RGENTVeBsqdsv4F/L9/GTzDPorGrSEoLZuQ9z+sX9+967jdOBzQxRF2Bc5E2Rh
         zToWAibMuBjWT2Z5+P/sBuon6X9gM9OPUotEtrS5RTyHQKAeyCJCl3yhwOrZiJzK4xmJ
         jVZC5sp1QC6ggOuwnS2Yh7/cQ8vxAcoZ/uvtGL/tgtpRZACPHTdksboGKSXVqnR0TMNO
         aAL0HHhmjtq93+ut8c4jpqJfxG3bZ2GrbTb0O3qirKSBQp+hML+PcwI8BUtQeBsGZ/Ml
         TNVA==
X-Gm-Message-State: ACrzQf2yQ+toNleSYjnaRhwff1qkGUc8YcQQLD0i6KpZMZ+LR2KOAGh8
        MT7+i8xrcjIBDtjAvOSKEfWEam0D3jMkwljcA8CuN+VFCy0ModPJ9qLY/LzI60/7qhpDHkbMpct
        AmyAvByyhus94YwIVgw7+xw==
X-Received: by 2002:a17:906:9b87:b0:733:1795:2855 with SMTP id dd7-20020a1709069b8700b0073317952855mr12730727ejc.156.1663584128566;
        Mon, 19 Sep 2022 03:42:08 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM5E9hdTB/zsLiGdHYHGyIfVoWOwYCxo8G7tzx2zblspy+LiFeQDC3v4aeLe3BLK8FnDMRB/wA==
X-Received: by 2002:a17:906:9b87:b0:733:1795:2855 with SMTP id dd7-20020a1709069b8700b0073317952855mr12730715ejc.156.1663584128354;
        Mon, 19 Sep 2022 03:42:08 -0700 (PDT)
Received: from [10.40.98.142] ([78.108.130.194])
        by smtp.gmail.com with ESMTPSA id bs11-20020a170906d1cb00b00738467f743dsm9924874ejb.5.2022.09.19.03.42.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Sep 2022 03:42:07 -0700 (PDT)
Message-ID: <f8fa6d10-6eb1-7fa7-80eb-ea190d29ba4a@redhat.com>
Date:   Mon, 19 Sep 2022 11:42:07 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
Subject: Re: [PATCH 1/5] ACPI: battery: Do not unload battery hooks on single
 error
Content-Language: en-US
To:     Armin Wolf <W_Armin@gmx.de>, markgross@kernel.org
Cc:     rafael@kernel.org, lenb@kernel.org, hmh@hmh.eng.br,
        matan@svgalib.org, corentin.chary@gmail.com, jeremy@system76.com,
        productdev@system76.com, platform-driver-x86@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220912125342.7395-1-W_Armin@gmx.de>
 <20220912125342.7395-2-W_Armin@gmx.de>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20220912125342.7395-2-W_Armin@gmx.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi,

On 9/12/22 13:53, Armin Wolf wrote:
> Currently, battery hooks are being unloaded if they return
> an error when adding a single battery.
> This however also causes the removal of successfully added
> hooks if they return -ENODEV for a single unsupported
> battery.
> 
> Do not unload battery hooks in such cases since the hook
> handles any cleanup actions.
> 
> Signed-off-by: Armin Wolf <W_Armin@gmx.de>

Maybe instead of removing all error checking, allow -ENODEV
and behave as before when the error is not -ENODEV ?

Otherwise we should probably make the add / remove callbacks
void to indicate that any errors are ignored.

Rafael, do you have any opinion on this?

Regards,

Hans

> ---
>  drivers/acpi/battery.c | 24 +++---------------------
>  1 file changed, 3 insertions(+), 21 deletions(-)
> 
> diff --git a/drivers/acpi/battery.c b/drivers/acpi/battery.c
> index 306513fec1e1..e59c261c7c59 100644
> --- a/drivers/acpi/battery.c
> +++ b/drivers/acpi/battery.c
> @@ -724,20 +724,10 @@ void battery_hook_register(struct acpi_battery_hook *hook)
>  	 * its attributes.
>  	 */
>  	list_for_each_entry(battery, &acpi_battery_list, list) {
> -		if (hook->add_battery(battery->bat)) {
> -			/*
> -			 * If a add-battery returns non-zero,
> -			 * the registration of the extension has failed,
> -			 * and we will not add it to the list of loaded
> -			 * hooks.
> -			 */
> -			pr_err("extension failed to load: %s", hook->name);
> -			__battery_hook_unregister(hook, 0);
> -			goto end;
> -		}
> +		hook->add_battery(battery->bat);
>  	}
>  	pr_info("new extension: %s\n", hook->name);
> -end:
> +
>  	mutex_unlock(&hook_mutex);
>  }
>  EXPORT_SYMBOL_GPL(battery_hook_register);
> @@ -762,15 +752,7 @@ static void battery_hook_add_battery(struct acpi_battery *battery)
>  	 * during the battery module initialization.
>  	 */
>  	list_for_each_entry_safe(hook_node, tmp, &battery_hook_list, list) {
> -		if (hook_node->add_battery(battery->bat)) {
> -			/*
> -			 * The notification of the extensions has failed, to
> -			 * prevent further errors we will unload the extension.
> -			 */
> -			pr_err("error in extension, unloading: %s",
> -					hook_node->name);
> -			__battery_hook_unregister(hook_node, 0);
> -		}
> +		hook_node->add_battery(battery->bat);
>  	}
>  	mutex_unlock(&hook_mutex);
>  }
> --
> 2.30.2
> 

