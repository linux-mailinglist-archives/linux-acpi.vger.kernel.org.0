Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA696413392
	for <lists+linux-acpi@lfdr.de>; Tue, 21 Sep 2021 14:52:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232819AbhIUMx2 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 21 Sep 2021 08:53:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:41161 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232702AbhIUMxZ (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 21 Sep 2021 08:53:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1632228716;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TqxAQwuwKeUNvwuaTqo1+dLfw9h1X6NxpXvwJl/CpGM=;
        b=itExvVqPG2cyY/PK7A/KCBqNiE/df2bbBtLHHFCo1VLnElZHsABLHbyhIqp2T0epgOhpkV
        3/coGXBkH227QEQ8w6k6U/tD9bR+4iuqkAtEWsiFbcGKQiNfVFF/NaJ63j7We61wQR2+m+
        d2GhiNKDqxIw+mRVvkKARliG+Sq7/cE=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-202-KIb5OmqQOdmhvMplBhDlbg-1; Tue, 21 Sep 2021 08:51:55 -0400
X-MC-Unique: KIb5OmqQOdmhvMplBhDlbg-1
Received: by mail-ed1-f71.google.com with SMTP id m20-20020aa7c2d4000000b003d1add00b8aso18945775edp.0
        for <linux-acpi@vger.kernel.org>; Tue, 21 Sep 2021 05:51:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=TqxAQwuwKeUNvwuaTqo1+dLfw9h1X6NxpXvwJl/CpGM=;
        b=M503Aa+3DF1Ek3va/5tTeAoBSLxQVucU3tJevVK7FCHVhxd9H/DkX5WvVwVKeLRsqv
         37aEdH6kwyCfMxpyfVj/viipTyKCaMBEf1jGAiDjmNQouxnPjcn5ue5xYHMwOfOjr6MJ
         W7xzxYCHCQzBycbC3gxGs1ynNG4vS/D2zfRoWVrJwX8BBV2MBV1J+BPqtBqyuPqQxZcw
         yEfxbahUPHwNifwp3jYuuNFJSNwDPTijEQk7uOWUkkr/qkYU8/d+E/RfWfnAHo7AarfW
         Xjo6y5yE6CKCALyOONRIKfyKSi67IEcpkq+FR8PYeUYZ+PvoAtsV8Mt+FqK4HjG7XPG8
         kJsQ==
X-Gm-Message-State: AOAM533+yuSOrtNeSYNRUD91ETcAszHfzKtvkjv576B5Jn+wO9G0Sk6s
        zAGh535lNA8Qlw6GGe3Tz2aA1P0eOpRnWi4qkI0udNMs1lH8TwrS27pPXTqhGdhi94Ftd3MGOLw
        bXlJKQXSv9MSjrdZW8ucv0w==
X-Received: by 2002:a17:906:c52:: with SMTP id t18mr34493873ejf.148.1632228714521;
        Tue, 21 Sep 2021 05:51:54 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxhuiUQhb0tewsqj63rPQftRwt57rxaB6FUVbu3JbDMhgH6wEublWh/IKVcBTwPNrwaAf/NaA==
X-Received: by 2002:a17:906:c52:: with SMTP id t18mr34493856ejf.148.1632228714315;
        Tue, 21 Sep 2021 05:51:54 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id d9sm8435983ede.31.2021.09.21.05.51.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Sep 2021 05:51:54 -0700 (PDT)
Subject: Re: [PATCH 2/2] acpi: pnp: remove duplicated BRI0A49 and BDP3336
 entries
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, Matan Ziv-Av <matan@svgalib.org>,
        Mark Gross <mgross@linux.intel.com>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        platform-driver-x86@vger.kernel.org
References: <20210916170054.136790-1-krzysztof.kozlowski@canonical.com>
 <20210916170054.136790-2-krzysztof.kozlowski@canonical.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <f78523c5-df88-a768-3b9a-d542bbd73a1c@redhat.com>
Date:   Tue, 21 Sep 2021 14:51:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210916170054.136790-2-krzysztof.kozlowski@canonical.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi,

On 9/16/21 7:00 PM, Krzysztof Kozlowski wrote:
> BRI0A49 and BDP3336 are already on the list.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>

Thanks, patch looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Rafael, I've picked up 1/2 since that applies to a drivers/platform/x86
driver. I'll leave picking this one up to you.

Regards,

Hans

> ---
>  drivers/acpi/acpi_pnp.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/acpi/acpi_pnp.c b/drivers/acpi/acpi_pnp.c
> index 8f2dc176bb41..ffdcfcd4a10d 100644
> --- a/drivers/acpi/acpi_pnp.c
> +++ b/drivers/acpi/acpi_pnp.c
> @@ -156,8 +156,6 @@ static const struct acpi_device_id acpi_pnp_device_ids[] = {
>  	{"BRI0A49"},		/* Boca Complete Ofc Communicator 14.4 Data-FAX */
>  	{"BRI1400"},		/* Boca Research 33,600 ACF Modem */
>  	{"BRI3400"},		/* Boca 33.6 Kbps Internal FD34FSVD */
> -	{"BRI0A49"},		/* Boca 33.6 Kbps Internal FD34FSVD */
> -	{"BDP3336"},		/* Best Data Products Inc. Smart One 336F PnP Modem */
>  	{"CPI4050"},		/* Computer Peripherals Inc. EuroViVa CommCenter-33.6 SP PnP */
>  	{"CTL3001"},		/* Creative Labs Phone Blaster 28.8 DSVD PnP Voice */
>  	{"CTL3011"},		/* Creative Labs Modem Blaster 28.8 DSVD PnP Voice */
> 

