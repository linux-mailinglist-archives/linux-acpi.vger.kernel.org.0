Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55C104BDC17
	for <lists+linux-acpi@lfdr.de>; Mon, 21 Feb 2022 18:41:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359610AbiBUNrT (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 21 Feb 2022 08:47:19 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:39016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359599AbiBUNrS (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 21 Feb 2022 08:47:18 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5029DE86
        for <linux-acpi@vger.kernel.org>; Mon, 21 Feb 2022 05:46:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1645451214;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=L8wxK0sx0ARjItoAWBtZbxxCje2iLbxe1SCm7RJ8TpE=;
        b=fIlBTsxyTfiBe3qKm2FJ0/v96fg8v3qoIs/K6PwQDhHpudo/D8OXk0TziDgvh1ZPWjVsD+
        vLSkVblTWkTo84AnFKX/ceQX/gCKjpJ+Ec5NZ08pRqYjxfiawzZKcZ1vp72FA9hA88JBkH
        tRSxIdPAbjv546zKIcPPql7Ybcn4/6o=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-18-fo8MdriHO_uqzIHm70AQ4w-1; Mon, 21 Feb 2022 08:46:53 -0500
X-MC-Unique: fo8MdriHO_uqzIHm70AQ4w-1
Received: by mail-ej1-f72.google.com with SMTP id h22-20020a1709060f5600b006b11a2d3dcfso4678401ejj.4
        for <linux-acpi@vger.kernel.org>; Mon, 21 Feb 2022 05:46:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=L8wxK0sx0ARjItoAWBtZbxxCje2iLbxe1SCm7RJ8TpE=;
        b=H8GZ1Cn6l0bIYLk0C0Le6AJKssPv52f/14XTULRx1R2E0Glu3KGX5BaCYdT1Pl3Y94
         QeKC2NWi83E0mU6MDvXQP6MHOztXMy9gRr4dl9opVOzzufZknew2m+5S4b8NPS2b4YP6
         391mPtZwvJDdza4YaOBbve1NE626MPNNzJ/eYUxw6pWk0K4zlIPOx3+PG5X8GmD/Yt5p
         xyARZdMSzid3PNj8wrUUqIMd7xrhx5Qe4AhfjV4EthE/5JLLy69lGTOoASaRPx4ZU2Q0
         9skeEw3PLYFcH5TTQ2v0Szh1hhcn9a1a451OXK0i0TTnOKY5LIdPi+ioYs+3lkOeqbyO
         2F6Q==
X-Gm-Message-State: AOAM531g1NJcEF0a2MXe0cMjlZBFDgIxuKdf9GiosDJv7Yp9/oRSq0h/
        e+hETf4p/G9Jjtk18VLN5Jb7oNZHelejHte7peu7yj+XI4iN1IV5PS54w0RbGyd4aPhStklabTU
        gJztxgDHfVWqB5rhTpy4WoQ==
X-Received: by 2002:a17:906:6693:b0:6cf:3cb:89c9 with SMTP id z19-20020a170906669300b006cf03cb89c9mr16122875ejo.23.1645451211816;
        Mon, 21 Feb 2022 05:46:51 -0800 (PST)
X-Google-Smtp-Source: ABdhPJympFeYNPwVrvpdOujabcUfBrLcZOhXrnp6/5Mq9sO8/wrPnfABGYtpZyaMWkA/NIB/5P/gXw==
X-Received: by 2002:a17:906:6693:b0:6cf:3cb:89c9 with SMTP id z19-20020a170906669300b006cf03cb89c9mr16122858ejo.23.1645451211599;
        Mon, 21 Feb 2022 05:46:51 -0800 (PST)
Received: from [10.40.98.142] ([78.108.130.194])
        by smtp.gmail.com with ESMTPSA id 12sm5240258ejh.30.2022.02.21.05.46.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Feb 2022 05:46:51 -0800 (PST)
Message-ID: <be628caf-15a6-d1f2-8c5f-c40baaeb0b5c@redhat.com>
Date:   Mon, 21 Feb 2022 14:46:49 +0100
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

This fixes tag is wrong, that sha does not exist?  See:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/log/drivers/platform/x86/intel/int3472/tps68470_board_data.c

I've updated the hash to 19d8d6e36b4b while merging this.

Regards,

Hans



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

