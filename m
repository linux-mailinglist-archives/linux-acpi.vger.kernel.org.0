Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44E7E60BBD2
	for <lists+linux-acpi@lfdr.de>; Mon, 24 Oct 2022 23:15:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232878AbiJXVPQ (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 24 Oct 2022 17:15:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233134AbiJXVO4 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 24 Oct 2022 17:14:56 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A406A87B6
        for <linux-acpi@vger.kernel.org>; Mon, 24 Oct 2022 12:20:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1666639141;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1ebv5PfsZX2R6eh39y9WmbJdsnetujUEQgGrB9f3X2I=;
        b=gZg/D7/ZsLC0gLZaxhJgvTcCfI//6URS51kh1x/2Kuq8MUSm/1Euiqvw6+Un/L+P6mfdqM
        BZRyMZUOPMpEhX6jf4i597uVhZpZPMZPL4/yGTNxBAhA1yZPM6ThKsdhkuDkYmfdCVBl0Q
        DRThVQgZ72b1If68EneP688YCixaFUE=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-164-dnLzNAadMOGZCkctO89I8g-1; Mon, 24 Oct 2022 09:47:40 -0400
X-MC-Unique: dnLzNAadMOGZCkctO89I8g-1
Received: by mail-ed1-f72.google.com with SMTP id x18-20020a05640226d200b00461e027f704so2058366edd.7
        for <linux-acpi@vger.kernel.org>; Mon, 24 Oct 2022 06:47:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1ebv5PfsZX2R6eh39y9WmbJdsnetujUEQgGrB9f3X2I=;
        b=3tv3fkjtjXTclDeHAhTGszHe63opNGVTNRXMBTvGkSjMrf79O1gkEYBGg9Zd5sX0x0
         YOgOI63eCa0HEvWijSe6qgzxIqcb91fDGSVXDkByUNxh1DeoPoNstAe5aBZM7EZ70d75
         0eMfkyYk3RxQQxFadYcgsD312+7rNrPb8UVpMGcRVGc7zRiq4HPZ6T+FG8ub0shofjW0
         /Og54ns6iLx6HYg3EQciGMLRoGNt4Rarv2TzgcT2kT/9A/YrbJcf8j0mp8jO34nUeFAv
         YNf5iJFNX/lrsYFiMhTSNCgEpGAPDNZ6gePzHu+f4ey6ibS+3eqGA406Ds2vQhVJbbZv
         GYLQ==
X-Gm-Message-State: ACrzQf3787ZbVyS5lvPSOSr/4S9p8gLQMmZJ7i/PSboXe7dYzXcJqDSv
        hKJZf5RE1KWCgdlFagpoglqXO3GoTFWTIu9HKWiGZpN3nbxn+X0Yq3HjAcPbl9lLuGlwG8mAu+o
        CkL3cfSGQ4WWoZgiYX1Urqg==
X-Received: by 2002:a17:907:a067:b0:7a7:dc5e:eb2d with SMTP id ia7-20020a170907a06700b007a7dc5eeb2dmr4709572ejc.121.1666619259238;
        Mon, 24 Oct 2022 06:47:39 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM7oLEXiE5I2sif+CugVS4fAFykp7aZ+J8hwrp6+8o79Py19z5YlVBnOblcNVHSJKIVCIbJM4Q==
X-Received: by 2002:a17:907:a067:b0:7a7:dc5e:eb2d with SMTP id ia7-20020a170907a06700b007a7dc5eeb2dmr4709548ejc.121.1666619259029;
        Mon, 24 Oct 2022 06:47:39 -0700 (PDT)
Received: from [10.40.98.142] ([78.108.130.194])
        by smtp.gmail.com with ESMTPSA id ck5-20020a0564021c0500b00461b169c02csm2670629edb.91.2022.10.24.06.47.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Oct 2022 06:47:38 -0700 (PDT)
Message-ID: <a70f951c-98d2-5b48-e8c0-08067a7a535c@redhat.com>
Date:   Mon, 24 Oct 2022 15:47:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH v2] platform/x86: dell-ddv: Minor style fixes
Content-Language: en-US
To:     Armin Wolf <W_Armin@gmx.de>, markgross@kernel.org
Cc:     andriy.shevchenko@intel.com, rafael@kernel.org, lenb@kernel.org,
        hmh@hmh.eng.br, matan@svgalib.org, corentin.chary@gmail.com,
        jeremy@system76.com, productdev@system76.com,
        mario.limonciello@amd.com, pobrn@protonmail.com,
        coproscefalo@gmail.com, platform-driver-x86@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220928221501.3823-1-W_Armin@gmx.de>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20220928221501.3823-1-W_Armin@gmx.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi,

On 9/29/22 00:15, Armin Wolf wrote:
> Fix some style issues found during review to improve
> code maintainability, no functional changes.
> 
> Tested on a Dell Inspiron 3505.
> 
> Signed-off-by: Armin Wolf <W_Armin@gmx.de>

Thank you for your patch, I've applied this patch to my review-hans 
branch:
https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git/log/?h=review-hans

Note it will show up in my review-hans branch once I've pushed my
local branch there, which might take a while.

Once I've run some tests on this branch the patches there will be
added to the platform-drivers-x86/for-next branch and eventually
will be included in the pdx86 pull-request to Linus for the next
merge-window.

Regards,

Hans

> ---
> Changes in v2:
> - change commit message
> ---
>  drivers/platform/x86/dell/dell-wmi-ddv.c | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/platform/x86/dell/dell-wmi-ddv.c b/drivers/platform/x86/dell/dell-wmi-ddv.c
> index 6ccce90f475d..699feae3c435 100644
> --- a/drivers/platform/x86/dell/dell-wmi-ddv.c
> +++ b/drivers/platform/x86/dell/dell-wmi-ddv.c
> @@ -1,13 +1,12 @@
>  // SPDX-License-Identifier: GPL-2.0-or-later
>  /*
> - * dell-wmi-ddv.c -- Linux driver for WMI sensor information on Dell notebooks.
> + * Linux driver for WMI sensor information on Dell notebooks.
>   *
>   * Copyright (C) 2022 Armin Wolf <W_Armin@gmx.de>
>   */
> 
>  #define pr_format(fmt) KBUILD_MODNAME ": " fmt
> 
> -#include <acpi/battery.h>
>  #include <linux/acpi.h>
>  #include <linux/debugfs.h>
>  #include <linux/device.h>
> @@ -21,6 +20,8 @@
>  #include <linux/sysfs.h>
>  #include <linux/wmi.h>
> 
> +#include <acpi/battery.h>
> +
>  #define DRIVER_NAME	"dell-wmi-ddv"
> 
>  #define DELL_DDV_SUPPORTED_INTERFACE 2
> @@ -52,7 +53,8 @@ enum dell_ddv_method {
> 
>  struct dell_wmi_ddv_data {
>  	struct acpi_battery_hook hook;
> -	struct device_attribute temp_attr, eppid_attr;
> +	struct device_attribute temp_attr;
> +	struct device_attribute eppid_attr;
>  	struct wmi_device *wdev;
>  };
> 
> @@ -153,8 +155,9 @@ static int dell_wmi_ddv_query_string(struct wmi_device *wdev, enum dell_ddv_meth
> 
>  static int dell_wmi_ddv_battery_index(struct acpi_device *acpi_dev, u32 *index)
>  {
> -	const char *uid_str = acpi_device_uid(acpi_dev);
> +	const char *uid_str;
> 
> +	uid_str = acpi_device_uid(acpi_dev);
>  	if (!uid_str)
>  		return -ENODEV;
> 
> --
> 2.30.2
> 

