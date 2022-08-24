Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5541E5A032C
	for <lists+linux-acpi@lfdr.de>; Wed, 24 Aug 2022 23:14:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240658AbiHXVOS (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 24 Aug 2022 17:14:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240650AbiHXVOR (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 24 Aug 2022 17:14:17 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 779187C1B2
        for <linux-acpi@vger.kernel.org>; Wed, 24 Aug 2022 14:14:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1661375651;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VPlZpUQnpRAIqpm5ipdfUx1oHWbvu+xTIcLASi0Tytg=;
        b=jNfwVSkOgXo7aV7KN6ny592WjPxRn+J4O+JfI52ltf+pOQboMz/4e8WAH5mauFuflzAzYu
        IX/QFttNdg2sJ+RhvNm/LVKPZq6kuzIqqs39pC13VWs3xamYtGClKYnWMx7OwAti/OvyPu
        7v6p9NJbcwp2B2OKh+CniASaXcVXwMw=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-20-9TPq8wfhNemJ5hG9XZ3c-A-1; Wed, 24 Aug 2022 17:14:10 -0400
X-MC-Unique: 9TPq8wfhNemJ5hG9XZ3c-A-1
Received: by mail-ej1-f70.google.com with SMTP id qa35-20020a17090786a300b0073d4026a97dso4503533ejc.9
        for <linux-acpi@vger.kernel.org>; Wed, 24 Aug 2022 14:14:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=VPlZpUQnpRAIqpm5ipdfUx1oHWbvu+xTIcLASi0Tytg=;
        b=bBO9cv3/yAN5GVILqQQM/hAW8Qd1fWDBlPcKGDOX7W2vB3cRGgY+ukpFuP02nWCKkF
         LgEZY2hwxR41gQDMMTOSxdpQpGK6/0jS8lvvoG9AaARSJ4cL0TBA6T48sIDO1NUUGWFp
         W+2jtBqiuRPF0K+0QYxpusJJFyrIXeZlYAsJtFWsuac8n4J/8Ocn7/RvoRnRGequEdHl
         0f6Ufletj0Id7hHaaI6dT94ApTbpC+CPz/SCJ7f26Sab+VazikK0DuWQP+E3qAq3XFb5
         W85nQXkxrhUZE2Woz7wOV0JXHHicGzJIZBpUQbq6dsntLaGCkV8VrP/aPamDWJGnEXJq
         23rA==
X-Gm-Message-State: ACgBeo3ZnizN6WltXDryeJ4vMsBgWYR7r66wA9PBoy4n+m7160HRyrvY
        r/oCw5noIJeAtb3P0bGGm4/cXjten9MQiJDcgW/ZcAO6genK2oUjlFhW/bpJ48sPQh1Mv+R9Rs3
        pX1w+xGhzAR2CSE4MOfBCFw==
X-Received: by 2002:a05:6402:4311:b0:447:9fb:b710 with SMTP id m17-20020a056402431100b0044709fbb710mr675179edc.272.1661375648852;
        Wed, 24 Aug 2022 14:14:08 -0700 (PDT)
X-Google-Smtp-Source: AA6agR5+QBug5BEfeaXN0FY7AGFF/YhIS3w2r50RV9rsX3TCJQKvttPirQ3xLm5wlQBOrWYGaZVH1g==
X-Received: by 2002:a05:6402:4311:b0:447:9fb:b710 with SMTP id m17-20020a056402431100b0044709fbb710mr675167edc.272.1661375648664;
        Wed, 24 Aug 2022 14:14:08 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c1e:bf00:d69d:5353:dba5:ee81? (2001-1c00-0c1e-bf00-d69d-5353-dba5-ee81.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:d69d:5353:dba5:ee81])
        by smtp.gmail.com with ESMTPSA id l10-20020a1709060cca00b0073bf84be798sm1598158ejh.142.2022.08.24.14.14.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Aug 2022 14:14:08 -0700 (PDT)
Message-ID: <e28f1308-aa59-70b9-e6db-c8f97abcf8e3@redhat.com>
Date:   Wed, 24 Aug 2022 23:14:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH 1/1] ACPI: video: Add Toshiba Satellite/Portege Z830 quirk
Content-Language: en-US
To:     Arvid Norlander <lkml@vorpal.se>, linux-acpi@vger.kernel.org
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>
References: <20220824184950.631520-1-lkml@vorpal.se>
 <20220824184950.631520-2-lkml@vorpal.se>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20220824184950.631520-2-lkml@vorpal.se>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi,

On 8/24/22 20:49, Arvid Norlander wrote:
> Toshiba Satellite Z830 needs the quirk video_disable_backlight_sysfs_if
> for proper backlight control after suspend/resume cycles.
> 
> Toshiba Portege Z830 is simply the same laptop rebranded for certain
> markets (I looked through the manual to other language sections to confirm
> this) and thus also needs this quirk.
> 
> Thanks to Hans de Goede for suggesting this fix.
> 
> Link: https://www.spinics.net/lists/platform-driver-x86/msg34394.html
> Signed-off-by: Arvid Norlander <lkml@vorpal.se>

Thanks, patch looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans


> 
> ---
>  drivers/acpi/acpi_video.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/drivers/acpi/acpi_video.c b/drivers/acpi/acpi_video.c
> index 5cbe2196176d..2a4990733cf0 100644
> --- a/drivers/acpi/acpi_video.c
> +++ b/drivers/acpi/acpi_video.c
> @@ -496,6 +496,22 @@ static const struct dmi_system_id video_dmi_table[] = {
>  		DMI_MATCH(DMI_PRODUCT_NAME, "SATELLITE R830"),
>  		},
>  	},
> +	{
> +	 .callback = video_disable_backlight_sysfs_if,
> +	 .ident = "Toshiba Satellite Z830",
> +	 .matches = {
> +		DMI_MATCH(DMI_SYS_VENDOR, "TOSHIBA"),
> +		DMI_MATCH(DMI_PRODUCT_NAME, "SATELLITE Z830"),
> +		},
> +	},
> +	{
> +	 .callback = video_disable_backlight_sysfs_if,
> +	 .ident = "Toshiba Portege Z830",
> +	 .matches = {
> +		DMI_MATCH(DMI_SYS_VENDOR, "TOSHIBA"),
> +		DMI_MATCH(DMI_PRODUCT_NAME, "PORTEGE Z830"),
> +		},
> +	},
>  	/*
>  	 * Some machine's _DOD IDs don't have bit 31(Device ID Scheme) set
>  	 * but the IDs actually follow the Device ID Scheme.

