Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67E2277917B
	for <lists+linux-acpi@lfdr.de>; Fri, 11 Aug 2023 16:12:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234300AbjHKOMJ (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 11 Aug 2023 10:12:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbjHKOMI (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 11 Aug 2023 10:12:08 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6410A10E4
        for <linux-acpi@vger.kernel.org>; Fri, 11 Aug 2023 07:11:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1691763085;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=da3RUjNaf0ptiK4vOUMQ3vUy+8sPGczXAYcIjVXcZwQ=;
        b=amVsJGhkL1Y6q6UBcn8+a9PH+gp9mvR2OuF4NXgA4wtu38RqaAxnRSbpsACs3s04dBS+X1
        pbz+z5/30iLu7Cr7SUiMbyxDyRdCeIHaZ640FrnS4nH+7alTimgvmNL1aFxIQmXvpKnChN
        Ca5RZ8fliZs7LpAU1uaK/hNsxlSPudM=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-284-J-nz85OFPPiBBVG8zigjnQ-1; Fri, 11 Aug 2023 10:11:23 -0400
X-MC-Unique: J-nz85OFPPiBBVG8zigjnQ-1
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-99bebfada8cso140123266b.1
        for <linux-acpi@vger.kernel.org>; Fri, 11 Aug 2023 07:11:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691763081; x=1692367881;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=da3RUjNaf0ptiK4vOUMQ3vUy+8sPGczXAYcIjVXcZwQ=;
        b=Gk3qg8wW4lWYd8IwVLa0di0GALHXGOolxvKCJ5xbCMu5gxrfc4FGcQcwmjPFxkIYBx
         9bCzXd4EhmyicFHfeV3SgbgUFfKNcVVBcOl7AgSefPmjfhnv9INYRBcLkD24x2AxUTyQ
         X5s4oMUSZZBQRnPgf0DT65WmO33R5P43OZSfgxo5cF/COse9Q1RY/UmGR4KI4qwnkPi6
         u/vk0/lMPU3qkkgXb4WQG7H4D3i60ScPXoFoLcb5zn7dRz5O0n1sc0dJDrmdRQVTSUE4
         ez0G+JdgJExU/W1Gym54F5kkVL5xLrfnQY/cGsq90TyIhtXs8exHB2Q8NiXOd+8lHELt
         7Hiw==
X-Gm-Message-State: AOJu0Yy6wjRrFsqT7dc2ordKhYdIvZbEVQGMZacJ+Ek6yZjqkiauTV4e
        p9BBvRRZpfXJ3WCTu9cMCbp/PD0j+hJbcckJKLCiwxCA3aWpuPw1BJqsW4Ey8ZeMfbDMOU3YgQo
        zr4LXGUmfZTVo0THWcP+yM3MRqvGV7A==
X-Received: by 2002:a17:907:2e19:b0:993:e9b8:90f5 with SMTP id ig25-20020a1709072e1900b00993e9b890f5mr1767068ejc.8.1691763081109;
        Fri, 11 Aug 2023 07:11:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE3CP863bST7FaekwEhDxjrgXYjLqo4nMZTrm9tNfxW3VBjtGXfw2+O+ug3S3qNei6o8RDvHQ==
X-Received: by 2002:a17:907:2e19:b0:993:e9b8:90f5 with SMTP id ig25-20020a1709072e1900b00993e9b890f5mr1767043ejc.8.1691763080759;
        Fri, 11 Aug 2023 07:11:20 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id v8-20020a1709060b4800b009930308425csm2306491ejg.31.2023.08.11.07.11.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Aug 2023 07:11:19 -0700 (PDT)
Message-ID: <e6857898-e145-411a-c1da-6996ab88b66f@redhat.com>
Date:   Fri, 11 Aug 2023 16:11:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] ACPI: resource: Add IRQ override quirk for PCSpecialist
 Elimina Pro 16 M
To:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Mario Limonciello <mario.limonciello@amd.com>,
        August Wikerfors <git@augustwikerfors.se>
Cc:     Linux regressions mailing list <regressions@lists.linux.dev>,
        stable@vger.kernel.org, linux-acpi@vger.kernel.org
References: <20230810090011.104770-1-hdegoede@redhat.com>
Content-Language: en-US, nl
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20230810090011.104770-1-hdegoede@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi,

On 8/10/23 11:00, Hans de Goede wrote:
> The PCSpecialist Elimina Pro 16 M laptop model is a Zen laptop which
> needs to use the MADT IRQ settings override and which does not have
> an INT_SRC_OVR entry for IRQ 1 in its MADT.
> 
> So this model needs a DMI quirk to enable the MADT IRQ settings override
> to fix its keyboard not working.
> 
> Fixes: a9c4a912b7dc ("ACPI: resource: Remove "Zen" specific match and quirks")
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=217394#c18
> Cc: Mario Limonciello <mario.limonciello@amd.com>
> Cc: Linux regressions mailing list <regressions@lists.linux.dev>
> Cc: All applicable <stable@vger.kernel.org>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

I have received confirmation from the reporter that this bug *avoids* things regressing on the PCSpecialist Elimina Pro 16 M after reverting a9c4a912b7dc ("ACPI: resource: Remove "Zen" specific match and quirks").

Regards,

Hans



> ---
>  drivers/acpi/resource.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/drivers/acpi/resource.c b/drivers/acpi/resource.c
> index 8e32dd5776f5..a4d9f149b48d 100644
> --- a/drivers/acpi/resource.c
> +++ b/drivers/acpi/resource.c
> @@ -498,6 +498,17 @@ static const struct dmi_system_id maingear_laptop[] = {
>  	{ }
>  };
>  
> +static const struct dmi_system_id pcspecialist_laptop[] = {
> +	{
> +		.ident = "PCSpecialist Elimina Pro 16 M",
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "PCSpecialist"),
> +			DMI_MATCH(DMI_PRODUCT_NAME, "Elimina Pro 16 M"),
> +		},
> +	},
> +	{ }
> +};
> +
>  static const struct dmi_system_id lg_laptop[] = {
>  	{
>  		.ident = "LG Electronics 17U70P",
> @@ -523,6 +534,7 @@ static const struct irq_override_cmp override_table[] = {
>  	{ asus_laptop, 1, ACPI_LEVEL_SENSITIVE, ACPI_ACTIVE_LOW, 0, false },
>  	{ tongfang_gm_rg, 1, ACPI_EDGE_SENSITIVE, ACPI_ACTIVE_LOW, 1, true },
>  	{ maingear_laptop, 1, ACPI_EDGE_SENSITIVE, ACPI_ACTIVE_LOW, 1, true },
> +	{ pcspecialist_laptop, 1, ACPI_EDGE_SENSITIVE, ACPI_ACTIVE_LOW, 1, true },
>  	{ lg_laptop, 1, ACPI_LEVEL_SENSITIVE, ACPI_ACTIVE_LOW, 0, false },
>  };
>  

