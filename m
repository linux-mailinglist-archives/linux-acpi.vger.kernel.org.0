Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 133B44BE861
	for <lists+linux-acpi@lfdr.de>; Mon, 21 Feb 2022 19:05:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355006AbiBUKco (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 21 Feb 2022 05:32:44 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:50594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355000AbiBUKcg (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 21 Feb 2022 05:32:36 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D62E16C958
        for <linux-acpi@vger.kernel.org>; Mon, 21 Feb 2022 01:52:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1645437155;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rWKdB+xdsSGrYxoHd80FLMCMuF8hy6C+CmJuSV61wzE=;
        b=b8o5PB2mznPuEWmozr9J5d7rpYRGmQdyRxyTWwnNnVTfrxNdjGDB3peHoF8kIlLhzXPKt+
        irXsjchQURHfV8IcC2yuLbpX83QkbKFRPijOWktYvNYxBio0H5L3ob5YaIOgG9B2sJGF5Z
        +TF+1s+yFlxsIR9PxRjErH0bM1ZVON4=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-425-CcnUm_15P4Sw2xWyAu7IOQ-1; Mon, 21 Feb 2022 04:52:34 -0500
X-MC-Unique: CcnUm_15P4Sw2xWyAu7IOQ-1
Received: by mail-ed1-f72.google.com with SMTP id eg48-20020a05640228b000b00413041cd917so1157601edb.12
        for <linux-acpi@vger.kernel.org>; Mon, 21 Feb 2022 01:52:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=rWKdB+xdsSGrYxoHd80FLMCMuF8hy6C+CmJuSV61wzE=;
        b=UjyDXzJcoZZ+aNZBBChE7cuwUDKpJwIpPPZcgwcAVuPJ4sPCeNMtvvjqeD0CuGeTTG
         GcihjGFHWzs8ZnvkLAY2sVIAWAhCI44VpSiyXJnc9gR1Y9ArezOdyar7Nl54HjrRbUD0
         y/ruXgW3jRPC3LQgZy1xMby3jJlRyLyUvASn87gW9BxHYED4qtggngcbob/p/77A2Cdi
         gzr0IewwaiVoEoYGHryEcDYXkTT2HmWvftznZTHEc+AI8Wi26L86Tsr91CnAVIMjg2WH
         IhJ+eqJJ/FXB4tvz/MeJhswTkdUzsfvHotuGrXzGDtKuo7nXPJjEa19HFbLfn+Jt/qW9
         Q9fg==
X-Gm-Message-State: AOAM533Pl7eg8nFUoAg/G/jsWaRCEMPTP32rUEZGLaKcXj/Aj536qrvU
        AW/REYRL/jVX14iCw3IB5NZl+4JugcpmybxmvlZgZwJZIDq2jB/qFUNzqcFwtL0xsn+Y6jw6aZG
        WOVhk2Kad8nBsIkH1lOKYGw==
X-Received: by 2002:a05:6402:3715:b0:410:a415:fd95 with SMTP id ek21-20020a056402371500b00410a415fd95mr20619464edb.288.1645437153005;
        Mon, 21 Feb 2022 01:52:33 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwfjucEjn+NxsIVVAlxvKWSfIUNLfVlNeuy2epy4FKSTUnKHqY117TAezZRujd7MCV1h/QIvA==
X-Received: by 2002:a05:6402:3715:b0:410:a415:fd95 with SMTP id ek21-20020a056402371500b00410a415fd95mr20619452edb.288.1645437152824;
        Mon, 21 Feb 2022 01:52:32 -0800 (PST)
Received: from [10.40.98.142] ([78.108.130.194])
        by smtp.gmail.com with ESMTPSA id g11sm5131745ejs.14.2022.02.21.01.52.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Feb 2022 01:52:32 -0800 (PST)
Message-ID: <d2bc537d-b311-6fb6-faf1-a847ae3b83be@redhat.com>
Date:   Mon, 21 Feb 2022 10:52:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH 2/6] ACPI: bus: Add iterator for dependent devices
Content-Language: en-US
To:     Daniel Scally <djrscally@gmail.com>, linux-acpi@vger.kernel.org,
        linux-clk@vger.kernel.org, platform-driver-x86@vger.kernel.org
Cc:     rafael@kernel.org, lenb@kernel.org, mturquette@baylibre.com,
        sboyd@kernel.org, markgross@kernel.org, robert.moore@intel.com
References: <20220216225304.53911-1-djrscally@gmail.com>
 <20220216225304.53911-3-djrscally@gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20220216225304.53911-3-djrscally@gmail.com>
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
> Add a helper macro to iterate over ACPI devices that are flagged
> as consumers of an initial supplier ACPI device.
> 
> Signed-off-by: Daniel Scally <djrscally@gmail.com>
> ---
>  include/acpi/acpi_bus.h | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
> index 8b06fef04722..72103bcdd5b3 100644
> --- a/include/acpi/acpi_bus.h
> +++ b/include/acpi/acpi_bus.h
> @@ -723,6 +723,18 @@ bool acpi_dev_ready_for_enumeration(const struct acpi_device *device);
>  struct acpi_device *acpi_dev_get_next_consumer_dev(struct acpi_device *supplier,
>  						   struct acpi_device *start);
>  struct acpi_device *acpi_dev_get_first_consumer_dev(struct acpi_device *supplier);
> +
> +/**
> + * for_each_acpi_consumer_dev - iterate over the consumer ACPI devices for a
> + *				given supplier
> + * @supplier: Pointer to the supplier's ACPI device
> + * @consumer: Pointer to &struct acpi_device to hold the consumer, initially NULL
> + */
> +#define for_each_acpi_consumer_dev(supplier, consumer)			\
> +	for (consumer = acpi_dev_get_first_consumer_dev(supplier);	\

If we drop acpi_dev_get_first_consumer_dev() this needs to be updated to:

	for (consumer = acpi_dev_get_next_consumer_dev(supplier, NULL);  \

Otherwise this looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans

> +	     consumer;							\
> +	     consumer = acpi_dev_get_next_consumer_dev(supplier, consumer))
> +
>  struct acpi_device *
>  acpi_dev_get_next_match_dev(struct acpi_device *adev, const char *hid, const char *uid, s64 hrv);
>  struct acpi_device *

