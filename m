Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 966A95B1F71
	for <lists+linux-acpi@lfdr.de>; Thu,  8 Sep 2022 15:42:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231738AbiIHNmX (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 8 Sep 2022 09:42:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbiIHNmW (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 8 Sep 2022 09:42:22 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BC93E72D2
        for <linux-acpi@vger.kernel.org>; Thu,  8 Sep 2022 06:42:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1662644540;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dY7UGDgAaThf/zGLCo78Nc7H8PVWh9/Q5L5/T8dTqWI=;
        b=aZt3pEaxQzlnRIFmRJbiD+vzhCbgfdM+EP6o0kAv1yRBAPbiAxbp2k4kbcnVUEgOAm9GcH
        X2JpznQo1K0YFAv3BkBxddJbe4ZP48+0qsoMfZ8FebCpqJ6iKfqWfUGa0oHhJirR01aqf6
        eg5WODeQfJ3U67s01DzsEOJPwWUEe14=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-568-tTSj9F74M52iN4XOBvRqzg-1; Thu, 08 Sep 2022 09:42:19 -0400
X-MC-Unique: tTSj9F74M52iN4XOBvRqzg-1
Received: by mail-ej1-f72.google.com with SMTP id hp14-20020a1709073e0e00b00741a2093c4aso6537196ejc.20
        for <linux-acpi@vger.kernel.org>; Thu, 08 Sep 2022 06:42:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=dY7UGDgAaThf/zGLCo78Nc7H8PVWh9/Q5L5/T8dTqWI=;
        b=bZ0i3o+ZykDhVJ+7OTNah5CwUe5m2Dr7VgUzHcMq9PvKT8DD17zusG3m1cQ9g/nWob
         xGo3xzkJ0rv0g0aYfhcp60EVL18wG+G7mXyVxeH3ZLwNnal/5KGnGflWa3DgdtcxlW4E
         QQgxPdarbv5v3zTKmVKJ3ewd3D/i6tPtrzcCkVaYz/sGaW9f1HE9Npf5/gIm1xOcTgCz
         WFL0NXXcmqOUOjC04APsuuGXoFA6kksCj1maDoJ62NR6H38Vxhai52slhcmif5+rjrIa
         OQPpITWZsXQeORGdldCuh7Y2F3h8Zh0tO1OH1HP28WqA2kDVTC4nVUf84I30WtpbV3Vo
         ysAw==
X-Gm-Message-State: ACgBeo3SSrAuwiWkE44FwgmtIRI6Ik45Xn3XwlAQLz8ixYexYwMQNXBh
        3ZIrsj+7pd8bfB2FrWUTymn6dTfAjKMoEeRbzRXeX5aD9PUdoMhZNkBxRXwGMq5kRXz6dY471/e
        d5RDYe8omXMiEHlEVYTEqYg==
X-Received: by 2002:a17:907:96a3:b0:740:a894:f with SMTP id hd35-20020a17090796a300b00740a894000fmr6136608ejc.460.1662644538479;
        Thu, 08 Sep 2022 06:42:18 -0700 (PDT)
X-Google-Smtp-Source: AA6agR5AC4iFP8kH6lKh83PspsOpkpVkUS6JN8xBfUD/yEuKwkju+iQLnwP+Y88hQIIWETucCSz8UQ==
X-Received: by 2002:a17:907:96a3:b0:740:a894:f with SMTP id hd35-20020a17090796a300b00740a894000fmr6136591ejc.460.1662644538255;
        Thu, 08 Sep 2022 06:42:18 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c1e:bf00:d69d:5353:dba5:ee81? (2001-1c00-0c1e-bf00-d69d-5353-dba5-ee81.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:d69d:5353:dba5:ee81])
        by smtp.gmail.com with ESMTPSA id bm9-20020a0564020b0900b0044ec76521a1sm5837844edb.55.2022.09.08.06.42.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Sep 2022 06:42:17 -0700 (PDT)
Message-ID: <767b4c6c-c860-b490-4e85-34c6677de456@redhat.com>
Date:   Thu, 8 Sep 2022 15:42:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v2 8/8] efi/dev-path-parser: Refactor _UID handling to use
 acpi_dev_uid_to_integer()
Content-Language: en-US
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Mark Brown <broonie@kernel.org>, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-efi@vger.kernel.org,
        linux-i2c@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org,
        devel@acpica.org
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>, Elie Morisse <syniurge@gmail.com>,
        Nehal Shah <nehal-bakulchandra.shah@amd.com>,
        Shyam Sundar S K <shyam-sundar.s-k@amd.com>,
        Khalil Blaiech <kblaiech@nvidia.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Robert Moore <robert.moore@intel.com>,
        Wolfram Sang <wsa@kernel.org>
References: <20220908132910.62122-1-andriy.shevchenko@linux.intel.com>
 <20220908132910.62122-9-andriy.shevchenko@linux.intel.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20220908132910.62122-9-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi,

On 9/8/22 15:29, Andy Shevchenko wrote:
> ACPI utils provide acpi_dev_uid_to_integer() helper to extract _UID as
> an integer. Use it instead of custom approach.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Reviewed-by: Ard Biesheuvel <ardb@kernel.org>

Thanks, patch looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans


> ---
>  drivers/firmware/efi/dev-path-parser.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/firmware/efi/dev-path-parser.c b/drivers/firmware/efi/dev-path-parser.c
> index eb9c65f97841..f80d87c199c3 100644
> --- a/drivers/firmware/efi/dev-path-parser.c
> +++ b/drivers/firmware/efi/dev-path-parser.c
> @@ -15,9 +15,11 @@
>  static long __init parse_acpi_path(const struct efi_dev_path *node,
>  				   struct device *parent, struct device **child)
>  {
> -	char hid[ACPI_ID_LEN], uid[11]; /* UINT_MAX + null byte */
>  	struct acpi_device *adev;
>  	struct device *phys_dev;
> +	char hid[ACPI_ID_LEN];
> +	u64 uid;
> +	int ret;
>  
>  	if (node->header.length != 12)
>  		return -EINVAL;
> @@ -27,12 +29,12 @@ static long __init parse_acpi_path(const struct efi_dev_path *node,
>  		'A' + ((node->acpi.hid >>  5) & 0x1f) - 1,
>  		'A' + ((node->acpi.hid >>  0) & 0x1f) - 1,
>  			node->acpi.hid >> 16);
> -	sprintf(uid, "%u", node->acpi.uid);
>  
>  	for_each_acpi_dev_match(adev, hid, NULL, -1) {
> -		if (adev->pnp.unique_id && !strcmp(adev->pnp.unique_id, uid))
> +		ret = acpi_dev_uid_to_integer(adev, &uid);
> +		if (ret == 0 && node->acpi.uid == uid)
>  			break;
> -		if (!adev->pnp.unique_id && node->acpi.uid == 0)
> +		if (ret == -ENODATA && node->acpi.uid == 0)
>  			break;
>  	}
>  	if (!adev)

