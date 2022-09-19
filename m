Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A3955BC9DC
	for <lists+linux-acpi@lfdr.de>; Mon, 19 Sep 2022 12:50:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229582AbiISKuK (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 19 Sep 2022 06:50:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbiISKtW (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 19 Sep 2022 06:49:22 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3A4BE35
        for <linux-acpi@vger.kernel.org>; Mon, 19 Sep 2022 03:42:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1663584172;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Np+fkkjO8lPl7vvZkMr0k8ISZAWRunlk0eF5U4B0S+s=;
        b=gMQFtMMVPgMKrOsNKW5lp6Nf1eY6yIQaQgLXTdvNc9taUmGohANRW1Bvq5GVKiXFiPqP7x
        8phq3FS6IDK64CbWmSn5ko2lWSAW+gAvkUt8OzORZEL7BWxLv3vLRzMOAsOHsbrI67FpUa
        7haVaX9oTY0QIj3VT2R1bu6IIZ/hi0s=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-448-PYwT6OY2OueUop8LtRjgjA-1; Mon, 19 Sep 2022 06:42:48 -0400
X-MC-Unique: PYwT6OY2OueUop8LtRjgjA-1
Received: by mail-ed1-f72.google.com with SMTP id c6-20020a05640227c600b004521382116dso15059978ede.22
        for <linux-acpi@vger.kernel.org>; Mon, 19 Sep 2022 03:42:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=Np+fkkjO8lPl7vvZkMr0k8ISZAWRunlk0eF5U4B0S+s=;
        b=QgRtMQrNp50kR/AiRyJPYw87Lnal4Dzqgmj+TFp0MV4gP/cDnitGNGrDbZXUN/lmDI
         n3NEZisGw1NBByAkM6F45x7WFQ85CSt/gzcHq2WT5Tq3Cy0u+9Lt3gIk+ZlQgSWEv1SH
         k3Fm2gVHQseSuz95MplGfDciF6gBqDkkcncSY+3C/5NlLfci5iMGnLFYUe1/OwjUcChV
         Yvz0MYzfvqJEnP3KSoSMO2xdO3APVNQhj0uVR5iXNUe67UQD7UHSx1pzCZaKUVlEB5wS
         7+rAcNkcORLKP34YP83ueEyJoMrmCj+GEjBZYFC58OVfq+7RdIjuXenrkU0oElvQigHQ
         a/rg==
X-Gm-Message-State: ACrzQf1CiCJIWa8r3GUCEaz6RL0AOhNSVY3nUBCNt/7Vd+FWyFgP8h/i
        Zd3JRu5syCt1T9w+hD0HyCWC60e4fLGlS2hBjv9L9yE9jTffZGpGADVW8FAbtAo0i8OS9ru7KzB
        gdy63CJGPUWtQIsh3H0zE0Q==
X-Received: by 2002:a17:907:70a:b0:741:78ab:dce5 with SMTP id xb10-20020a170907070a00b0074178abdce5mr12638731ejb.527.1663584167813;
        Mon, 19 Sep 2022 03:42:47 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM6FiwxrL7uPiNvLAfLhlopkwhwhbm4bGbnVuuFkEIv/9QzhlBdvIK4zNn7OcPAey1ylp5FbCA==
X-Received: by 2002:a17:907:70a:b0:741:78ab:dce5 with SMTP id xb10-20020a170907070a00b0074178abdce5mr12638715ejb.527.1663584167587;
        Mon, 19 Sep 2022 03:42:47 -0700 (PDT)
Received: from [10.40.98.142] ([78.108.130.194])
        by smtp.gmail.com with ESMTPSA id dk9-20020a0564021d8900b0044ea683d04csm20050091edb.14.2022.09.19.03.42.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Sep 2022 03:42:47 -0700 (PDT)
Message-ID: <1095514c-f734-b7d5-4a6a-4ed230ecb03a@redhat.com>
Date:   Mon, 19 Sep 2022 11:42:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
Subject: Re: [PATCH 2/5] ACPI: battery: Simplify battery_hook_unregister()
Content-Language: en-US
To:     Armin Wolf <W_Armin@gmx.de>, markgross@kernel.org
Cc:     rafael@kernel.org, lenb@kernel.org, hmh@hmh.eng.br,
        matan@svgalib.org, corentin.chary@gmail.com, jeremy@system76.com,
        productdev@system76.com, platform-driver-x86@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220912125342.7395-1-W_Armin@gmx.de>
 <20220912125342.7395-3-W_Armin@gmx.de>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20220912125342.7395-3-W_Armin@gmx.de>
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
> Since __battery_hook_unregister() is always called
> with lock set to 1, remove the unneeded conditionals
> and merge it with battery_hook_unregister().
> 
> Signed-off-by: Armin Wolf <W_Armin@gmx.de>

Thanks, patch looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans


> ---
>  drivers/acpi/battery.c | 17 ++++++-----------
>  1 file changed, 6 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/acpi/battery.c b/drivers/acpi/battery.c
> index e59c261c7c59..4aea65f3d8c3 100644
> --- a/drivers/acpi/battery.c
> +++ b/drivers/acpi/battery.c
> @@ -686,27 +686,22 @@ static LIST_HEAD(acpi_battery_list);
>  static LIST_HEAD(battery_hook_list);
>  static DEFINE_MUTEX(hook_mutex);
> 
> -static void __battery_hook_unregister(struct acpi_battery_hook *hook, int lock)
> +void battery_hook_unregister(struct acpi_battery_hook *hook)
>  {
>  	struct acpi_battery *battery;
>  	/*
>  	 * In order to remove a hook, we first need to
>  	 * de-register all the batteries that are registered.
>  	 */
> -	if (lock)
> -		mutex_lock(&hook_mutex);
> +	mutex_lock(&hook_mutex);
> +
>  	list_for_each_entry(battery, &acpi_battery_list, list) {
>  		hook->remove_battery(battery->bat);
>  	}
>  	list_del(&hook->list);
> -	if (lock)
> -		mutex_unlock(&hook_mutex);
> -	pr_info("extension unregistered: %s\n", hook->name);
> -}
> 
> -void battery_hook_unregister(struct acpi_battery_hook *hook)
> -{
> -	__battery_hook_unregister(hook, 1);
> +	mutex_unlock(&hook_mutex);
> +	pr_info("extension unregistered: %s\n", hook->name);
>  }
>  EXPORT_SYMBOL_GPL(battery_hook_unregister);
> 
> @@ -784,7 +779,7 @@ static void __exit battery_hook_exit(void)
>  	 * need to remove the hooks.
>  	 */
>  	list_for_each_entry_safe(hook, ptr, &battery_hook_list, list) {
> -		__battery_hook_unregister(hook, 1);
> +		battery_hook_unregister(hook);
>  	}
>  	mutex_destroy(&hook_mutex);
>  }
> --
> 2.30.2
> 

