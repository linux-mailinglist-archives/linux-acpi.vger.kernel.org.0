Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6ED607A3FFB
	for <lists+linux-acpi@lfdr.de>; Mon, 18 Sep 2023 06:15:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239509AbjIREPF (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 18 Sep 2023 00:15:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239576AbjIREOy (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 18 Sep 2023 00:14:54 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA1A5129
        for <linux-acpi@vger.kernel.org>; Sun, 17 Sep 2023 21:14:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1695010441;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+naNdgA3bFvfUIv4tJXTTMUwzR4YQ9euXBZfFED9oXc=;
        b=MPknRFWjt+gO2KIhppkRjReWPLmE7eoVG9QkQqEgHU0Q/SMVTHXHWOYXLLZZBtPn7AXpVd
        x1M5nTfClD78jLZ8s93PCFf2NpboRtTzPiRIT/lAnvyLvbTY7odf3F4FMPXuhOC5CZdUzi
        bVnJZzJt+BomntwYiJNbOsZ2WcQzvOk=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-101-yysz_wC-O3mpfT2hTDuN5w-1; Mon, 18 Sep 2023 00:13:59 -0400
X-MC-Unique: yysz_wC-O3mpfT2hTDuN5w-1
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-2764e63b6abso882193a91.0
        for <linux-acpi@vger.kernel.org>; Sun, 17 Sep 2023 21:13:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695010438; x=1695615238;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+naNdgA3bFvfUIv4tJXTTMUwzR4YQ9euXBZfFED9oXc=;
        b=ItAYzRDFVNNI3JlRyXe6Ja6c+toRR9nn6LX6vK+dFtfLhTz+ZU8nRgV7wRJODnNYAA
         yJPrARGIkUBamTwllRRoYcVbY3+PexdnXMIfIwzkoxWTtBQb1cs3vUVdGucsDQTmLnqF
         4Qx3ffnqMUZMWGOzejTGPzbGkNV9HN7BwLXMzSq2gmCK+8Ie7rp2iQvwWy/9tZYD5vZI
         yvCMbKJwvudYzbp74PiE5U0PgbtKro8dxa5vVmw4rGEM46CPoGTtp/mP0UB/Zj1SQb+m
         E9b1b1Rt9U1B6XSg+AkHARY6bZt52m1hXpxaUFeZLUEImpjIBp8fY0nKGAi/1H5SIkRE
         Blog==
X-Gm-Message-State: AOJu0YzMR+RXkKrB5LnP2zM21hXcsFRkAiw3vyU6w22r9tuFS4qrispQ
        TvnZQltKmxX/Uu6giiGRoAsA6xP7oaBjBTm5MEJrio10KedFhhyZRyYF3wfkLQmg0I7eRus2gLf
        x6jRajo+8gIUN2KVqs9R5HQ==
X-Received: by 2002:a17:90b:a4a:b0:268:d05c:2d7e with SMTP id gw10-20020a17090b0a4a00b00268d05c2d7emr7199801pjb.14.1695010438621;
        Sun, 17 Sep 2023 21:13:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF1foMotPOeb/U6/yukF28+ks3ZQRkPSCrKuGwYeHbXeH4thsw0w9Gpz7n9powcJl9wMU41Zg==
X-Received: by 2002:a17:90b:a4a:b0:268:d05c:2d7e with SMTP id gw10-20020a17090b0a4a00b00268d05c2d7emr7199783pjb.14.1695010438337;
        Sun, 17 Sep 2023 21:13:58 -0700 (PDT)
Received: from ?IPV6:2001:8003:e5b0:9f00:dbbc:1945:6e65:ec5? ([2001:8003:e5b0:9f00:dbbc:1945:6e65:ec5])
        by smtp.gmail.com with ESMTPSA id s8-20020a17090a074800b00262eb0d141esm6923176pje.28.2023.09.17.21.13.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 17 Sep 2023 21:13:57 -0700 (PDT)
Message-ID: <e364c6e3-4900-404e-54e9-a634eca4384a@redhat.com>
Date:   Mon, 18 Sep 2023 14:13:50 +1000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [RFC PATCH v2 13/35] ACPI: Rename acpi_scan_device_not_present()
 to be about enumeration
Content-Language: en-US
To:     James Morse <james.morse@arm.com>, linux-pm@vger.kernel.org,
        loongarch@lists.linux.dev, linux-acpi@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-riscv@lists.infradead.org, kvmarm@lists.linux.dev
Cc:     x86@kernel.org, Salil Mehta <salil.mehta@huawei.com>,
        Russell King <linux@armlinux.org.uk>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        jianyong.wu@arm.com, justin.he@arm.com
References: <20230913163823.7880-1-james.morse@arm.com>
 <20230913163823.7880-14-james.morse@arm.com>
From:   Gavin Shan <gshan@redhat.com>
In-Reply-To: <20230913163823.7880-14-james.morse@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org



On 9/14/23 02:38, James Morse wrote:
> acpi_scan_device_not_present() is called when a device in the
> hierarchy is not available for enumeration. Historically enumeration
> was only based on whether the device was present.
> 
> To add support for only enumerating devices that are both present
> and enabled, this helper should be renamed. It was only ever about
> enumeration, rename it acpi_scan_device_not_enumerated().
> 
> No change in behaviour is intended.
> 
> Signed-off-by: James Morse <james.morse@arm.com>
> ---
>   drivers/acpi/scan.c | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
> 

Reviewed-by: Gavin Shan <gshan@redhat.com>

> diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
> index ed01e19514ef..17ab875a7d4e 100644
> --- a/drivers/acpi/scan.c
> +++ b/drivers/acpi/scan.c
> @@ -289,10 +289,10 @@ static int acpi_scan_hot_remove(struct acpi_device *device)
>   	return 0;
>   }
>   
> -static int acpi_scan_device_not_present(struct acpi_device *adev)
> +static int acpi_scan_device_not_enumerated(struct acpi_device *adev)
>   {
>   	if (!acpi_device_enumerated(adev)) {
> -		dev_warn(&adev->dev, "Still not present\n");
> +		dev_warn(&adev->dev, "Still not enumerated\n");
>   		return -EALREADY;
>   	}
>   	acpi_bus_trim(adev);
> @@ -327,7 +327,7 @@ static int acpi_scan_device_check(struct acpi_device *adev)
>   			error = -ENODEV;
>   		}
>   	} else {
> -		error = acpi_scan_device_not_present(adev);
> +		error = acpi_scan_device_not_enumerated(adev);
>   	}
>   	return error;
>   }
> @@ -339,7 +339,7 @@ static int acpi_scan_bus_check(struct acpi_device *adev, void *not_used)
>   
>   	acpi_bus_get_status(adev);
>   	if (!acpi_device_is_present(adev)) {
> -		acpi_scan_device_not_present(adev);
> +		acpi_scan_device_not_enumerated(adev);
>   		return 0;
>   	}
>   	if (handler && handler->hotplug.scan_dependent)

Thanks,
Gavin

