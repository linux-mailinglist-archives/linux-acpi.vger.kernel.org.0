Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 065596EB159
	for <lists+linux-acpi@lfdr.de>; Fri, 21 Apr 2023 20:08:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230472AbjDUSIN (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 21 Apr 2023 14:08:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229582AbjDUSIM (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 21 Apr 2023 14:08:12 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A37FD210E
        for <linux-acpi@vger.kernel.org>; Fri, 21 Apr 2023 11:07:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1682100444;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3GTxHvkaG3Waa0AOi1+R4WFBe9IzMQrM+XQVXW7z1zo=;
        b=cMMFhs4T7EEhVA9WacjkAlxKbDLYCKizr9eR2PGrDDeK3VpP5H4eGRI3sNpqKcjYUVIxeM
        KgccyMUwX3TfuDmHLxzMQIu7eVQ1oihQ4QhiFdsJXUKAefswBtIN0+MEhx3H4wvL0S7JGK
        5KPRvFudDxZKCyo3vKcayzn4ZZlfxtE=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-636-vANBsndbNeusULpHK7mO8A-1; Fri, 21 Apr 2023 14:07:23 -0400
X-MC-Unique: vANBsndbNeusULpHK7mO8A-1
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-50692ecb3c5so2217893a12.0
        for <linux-acpi@vger.kernel.org>; Fri, 21 Apr 2023 11:07:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682100442; x=1684692442;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3GTxHvkaG3Waa0AOi1+R4WFBe9IzMQrM+XQVXW7z1zo=;
        b=O+Jxjihzk99evEmt8AmF+Kd7YfGqHigiWj6wsZNK8g3zym/kRQQFM0G4JbZiHZZcdN
         sX8smA11YRth1jPeqaXNtmTm3LWbffNc/efLR//mMGqxg+EfQfGp1CNqNLwbPaYerKHn
         s2cEyUOLxd6gA2UhyXDphrEO9KP+R2NC+TawbExS0OiHHoumiws+9gpEjNm1uVOeyQaq
         O9TFQuMRghuqSfpMKyTNiuXyzd/+REmCg9TIT62rMVu7q/ZnYLVHNV1q+3T0BJiuh9Ne
         IT0GX/MPgTRlkHYVIxnmhHIrSbWhlCui7ty2pl3MjBhNTO4U0iepzGwuCuKROSGbh/yI
         BOLg==
X-Gm-Message-State: AAQBX9cMIR1wTxv5sXi68h4js6fIFY2jk3WuUGsgfDGmQoiGKeikVJxw
        mL+/AlEb9C/eWf/PXgUiC0Bp14zvXHVMmxO1Tofd7t9bJE+0jT9qjz4CEnRtWdQUy8yDdWTsQYJ
        o8+rKZPmitVh8vQBldF6zlA==
X-Received: by 2002:aa7:dace:0:b0:4fb:78a0:eabe with SMTP id x14-20020aa7dace000000b004fb78a0eabemr5472591eds.14.1682100442218;
        Fri, 21 Apr 2023 11:07:22 -0700 (PDT)
X-Google-Smtp-Source: AKy350YYXiCS9K/XnuCzliK1ZEXEtdMpN9o9CL5iofAlnWDeDqaWbf89O/Rx4HonhWZilXztg2Hlvg==
X-Received: by 2002:aa7:dace:0:b0:4fb:78a0:eabe with SMTP id x14-20020aa7dace000000b004fb78a0eabemr5472578eds.14.1682100441941;
        Fri, 21 Apr 2023 11:07:21 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id u11-20020aa7d0cb000000b0050687dbb5dasm2079089edo.31.2023.04.21.11.07.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Apr 2023 11:07:21 -0700 (PDT)
Message-ID: <06e9623d-26ae-e0e3-8fd8-1f5c89497a5a@redhat.com>
Date:   Fri, 21 Apr 2023 20:07:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] ACPI: scan: Ignore MAGN0001
To:     Marius Hoch <mail@mariushoch.de>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230421162702.3558-1-mail@mariushoch.de>
Content-Language: en-US, nl
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20230421162702.3558-1-mail@mariushoch.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Marius,

On 4/21/23 18:27, Marius Hoch wrote:
> The LSM303D on the Lenovo Yoga Tablet 2 series is present
> as both ACCL0001 and MAGN0001. As we can only ever register an
> i2c client for one of them, ignore MAGN0001.
> 
> Currently this errors:
> i2c i2c-4: Failed to register i2c client MAGN0001:00 at 0x1d (-16)
> 
> Tested on a Lenovo Yoga Tablet 2 1051-F.
> 
> Signed-off-by: Marius Hoch <mail@mariushoch.de>

By adding the HID to the ignore_serial_bus_ids[] list, you are
causing the ACPI code to instead instantiate a platform_device
for it.

This will successfully silence the error you are trying to silence,
but I don't think it really is what you intent / want to do ?

IMHO it would be better to add a NOT_PRESENT_ENTRY_HID() entry
to the override_status_ids[] table in drivers/acpi/x86/utils.c,
this will override the return of _STA, causing neither a
platform_device not an i2c_client to get instantiated for
the duplicate MAGN0001 device.

(please keep the comment above the entry why the entry is there)

Regards,

Hans







> ---
>  drivers/acpi/scan.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
> index 0c6f06abe3f4..d21c411e9719 100644
> --- a/drivers/acpi/scan.c
> +++ b/drivers/acpi/scan.c
> @@ -1730,6 +1730,12 @@ static bool acpi_device_enumeration_by_parent(struct acpi_device *device)
>  	 */
>  		{"BCM4752", },
>  		{"LNV4752", },
> +	/*
> +	 * The LSM303D on the Lenovo Yoga Tablet 2 series is present
> +	 * as both ACCL0001 and MAGN0001. As we can only ever register an
> +	 * i2c client for one of them, ignore MAGN0001.
> +	 */
> +		{"MAGN0001", },
>  		{}
>  	};
>  
> 
> base-commit: cb0856346a60fe3eb837ba5e73588a41f81ac05f

