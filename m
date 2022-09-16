Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 752AF5BA857
	for <lists+linux-acpi@lfdr.de>; Fri, 16 Sep 2022 10:43:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230135AbiIPInL (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 16 Sep 2022 04:43:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230424AbiIPInI (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 16 Sep 2022 04:43:08 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A4E1A6C66
        for <linux-acpi@vger.kernel.org>; Fri, 16 Sep 2022 01:43:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1663317785;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VbO+Lm6okm9qbgHERmbkye329u238iBYwsZHrrR1iRI=;
        b=OnwSxhtdl2UgS2UgZx2L2extSk3R2OEVxZb5OPEnhP8jXoDagKfYFprNsFNCTLE79TatOk
        b/wAL8cEmGW/tzWFJ0uWGVNJgP7rCZJaqdNqdbuR+4jOuMogPCCxWHo4gyB3wKJtOPVPXH
        jnHC13pCqsalh480NYIMZgrD5G/bsCo=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-671-Xk7a2KHwP8SfPFCQ45V_sg-1; Fri, 16 Sep 2022 04:43:04 -0400
X-MC-Unique: Xk7a2KHwP8SfPFCQ45V_sg-1
Received: by mail-ed1-f70.google.com with SMTP id y1-20020a056402358100b00451b144e23eso10754245edc.18
        for <linux-acpi@vger.kernel.org>; Fri, 16 Sep 2022 01:43:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=VbO+Lm6okm9qbgHERmbkye329u238iBYwsZHrrR1iRI=;
        b=71Kuko2hN8OAR+FagdD7u980iThm4X6q4twnNBfgZlq59/GFsdhxA4/E1tKLWHszUs
         mlSqXenZLzD3ftuJrvoRYaJp8xAS1mJK5QoBq/SKY0kSzSwhYz6WEkxj4dPL1dnxni13
         vIZom7TbpthzGfOZIAE4TpnRtquHs2Km12z76ae5JhKiepqT869s1UgEu0GnrNSm/Q9U
         URc/NXz+bYA97jb+sJNePf6FjgsP80ru7jO8PkIaNT/lZbVLrLydTLLP7kZ4DJrm2q1o
         QxrxASretQcUJBDeIeVgUg4j5pAQTxZ22OtDAkAX7YkG3cwNnlr6ITrSHQfHNwnx/piT
         i3FQ==
X-Gm-Message-State: ACrzQf253UQk/2ad8osQmpyU2eDx1SHGsy2Xm0s5n8e5caRbyLsITuSH
        l7GxDBF5DLlaNkCohMiTqDSgNqqCV4TA3qhySi98dS1FXgoYKW1vQ1SfCneps4xYbnPQPDocYxb
        wl+VBvQHdBBKyPMJ5elaB1Q==
X-Received: by 2002:a17:906:9bce:b0:770:2600:2cef with SMTP id de14-20020a1709069bce00b0077026002cefmr2695255ejc.611.1663317783705;
        Fri, 16 Sep 2022 01:43:03 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM759gvZBCB6O2D2gJJ1AFr4bzGtpik89lSSdGx3I+fQrZSmG1RYEyHiJYSHpT68QQAT/44CcQ==
X-Received: by 2002:a17:906:9bce:b0:770:2600:2cef with SMTP id de14-20020a1709069bce00b0077026002cefmr2695243ejc.611.1663317783518;
        Fri, 16 Sep 2022 01:43:03 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c1e:bf00:d69d:5353:dba5:ee81? (2001-1c00-0c1e-bf00-d69d-5353-dba5-ee81.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:d69d:5353:dba5:ee81])
        by smtp.gmail.com with ESMTPSA id s1-20020a056402014100b0044e8d0682b2sm13047094edu.71.2022.09.16.01.43.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Sep 2022 01:43:02 -0700 (PDT)
Message-ID: <42663baa-2d8c-a45a-a33e-571119ec12aa@redhat.com>
Date:   Fri, 16 Sep 2022 10:43:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
Subject: Re: [PATCH] ACPI / x86: Add a quirk for Dell Inspiron 14 2-in-1 for
 StorageD3Enable
To:     Mario Limonciello <mario.limonciello@amd.com>,
        linux-kernel@vger.kernel.org
Cc:     Luya Tshimbalanga <luya@fedoraproject.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org
References: <20220915182315.276-1-mario.limonciello@amd.com>
Content-Language: en-US
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20220915182315.276-1-mario.limonciello@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi,

On 9/15/22 20:23, Mario Limonciello wrote:
> Dell Inspiron 14 2-in-1 has two ACPI nodes under GPP1 both with _ADR of
> 0, both without _HID.  It's ambiguous which the kernel should take, but
> it seems to take "DEV0".  Unfortunately "DEV0" is missing the device
> property `StorageD3Enable` which is present on "NVME".
> 
> To avoid this causing problems for suspend, add a quirk for this system
> to behave like `StorageD3Enable` property was found.
> 
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=216440
> Reported-and-tested-by: Luya Tshimbalanga <luya@fedoraproject.org>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>

Thanks, patch looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans


> ---
> I had attempted to modify the heuristics for when two ACPI devices
> have the same _ADR to prefer the one with a _DSD, but this wasn't enough
> of a help. As the ACPI node doesn't contain anything valuable besides
> the _DSD, it seems that a quirk for the system is a fine enough solution.
> 
>  drivers/acpi/x86/utils.c | 19 ++++++++++++++++++-
>  1 file changed, 18 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/acpi/x86/utils.c b/drivers/acpi/x86/utils.c
> index 664070fc8349..d7cdd8406c84 100644
> --- a/drivers/acpi/x86/utils.c
> +++ b/drivers/acpi/x86/utils.c
> @@ -207,9 +207,26 @@ static const struct x86_cpu_id storage_d3_cpu_ids[] = {
>  	{}
>  };
>  
> +static const struct dmi_system_id force_storage_d3_dmi[] = {
> +	{
> +		/*
> +		 * _ADR is ambiguous between GPP1.DEV0 and GPP1.NVME
> +		 * but .NVME is needed to get StorageD3Enable node
> +		 * https://bugzilla.kernel.org/show_bug.cgi?id=216440
> +		 */
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
> +			DMI_MATCH(DMI_PRODUCT_NAME, "Inspiron 14 7425 2-in-1"),
> +		}
> +	},
> +	{}
> +};
> +
>  bool force_storage_d3(void)
>  {
> -	return x86_match_cpu(storage_d3_cpu_ids);
> +	const struct dmi_system_id *dmi_id = dmi_first_match(force_storage_d3_dmi);
> +
> +	return dmi_id || x86_match_cpu(storage_d3_cpu_ids);
>  }
>  
>  /*

