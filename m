Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E466460BB25
	for <lists+linux-acpi@lfdr.de>; Mon, 24 Oct 2022 22:48:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235072AbiJXUsS (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 24 Oct 2022 16:48:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235124AbiJXUsA (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 24 Oct 2022 16:48:00 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 691E48C022
        for <linux-acpi@vger.kernel.org>; Mon, 24 Oct 2022 11:54:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1666637641;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=St4Oo1+ZOBe0lGhOZfdzJtwdKULc2yTF38gsrCy5cIs=;
        b=N829PdDrmVzByitWkATr6x8PoxHChHn3Zu/g3jNf73bnOMcxIqpUP2167Bt9thfKBonmNR
        x55qCFJit7qq5dQkl72XOCQVN+waXKMmA/Lz6LDrGNdUeVFOHeZOgxRKnhe7sL4UitpnyK
        Uz1lPsa5fQs4klDiZwR3x9bIyICmMbo=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-649-ns_KGLk9OUCmvBxAiEbjPw-1; Mon, 24 Oct 2022 10:32:41 -0400
X-MC-Unique: ns_KGLk9OUCmvBxAiEbjPw-1
Received: by mail-ed1-f69.google.com with SMTP id z7-20020a05640235c700b0045d3841ccf2so9857254edc.9
        for <linux-acpi@vger.kernel.org>; Mon, 24 Oct 2022 07:32:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=St4Oo1+ZOBe0lGhOZfdzJtwdKULc2yTF38gsrCy5cIs=;
        b=ggQpJAXiG+n5eaFMuw+4CmMrJM6e4H7YJu8vi+RWD9Zwa26sCxmwBBsfzdkhGmvIBQ
         rwmAGze4Cib1OEPlSPrBHbT9gFAiPO2KUE5goBzafa3wEkBJHg9Y/sg+GhWuiPKs2TYY
         KFblhXdmG7I8Co3VUZrmLHoiMTMaoUrMdYzYMOAIDoUY8NldiX2oKL7lIpSVyBf2JUFE
         YSAEhBjbI53PaaEkvU93/kx+4c2UwvE2iKqH8vK8v99D/3ai4tJ5bEqgThJ+07J+BHQJ
         VtFpiauYHXHZuRJCEY5I1hRp9/BT+j4IOeTiEoxpiHUnY2WKJVqXJYlZ5r8FtzGH0b39
         2l6Q==
X-Gm-Message-State: ACrzQf0rd0EtKnFA8or4cKpEdQLRuIoe46J6/pkn2FGdYKWdFL4P3NH2
        jd34Zf6mpGRhSSixNs58ZQ8tKaPzNdKJU1wluS2akJi+wRAhmjG0m+sdsUqzwUbasQXpkVx7/9v
        66zKnIPUkxpd956EsNAqqrQ==
X-Received: by 2002:a05:6402:2710:b0:45c:d7b4:6948 with SMTP id y16-20020a056402271000b0045cd7b46948mr30996975edd.215.1666621960894;
        Mon, 24 Oct 2022 07:32:40 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM7FteBuj1i+suD+fzUBHUwobCQ42/zPj3LuJ2XNuBwLGr/mL3KqKm8I/n6s3gjZh8Jv/+v1Ag==
X-Received: by 2002:a05:6402:2710:b0:45c:d7b4:6948 with SMTP id y16-20020a056402271000b0045cd7b46948mr30996964edd.215.1666621960720;
        Mon, 24 Oct 2022 07:32:40 -0700 (PDT)
Received: from [10.40.98.142] ([78.108.130.194])
        by smtp.gmail.com with ESMTPSA id ed5-20020a056402294500b00461621cae1fsm4010174edb.16.2022.10.24.07.32.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Oct 2022 07:32:39 -0700 (PDT)
Message-ID: <dda4b024-69d2-1d1d-da23-e922e5b6128a@redhat.com>
Date:   Mon, 24 Oct 2022 16:32:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH v2] ACPI: video: Fix missing native backlight on
 Chromebooks
Content-Language: en-US
To:     Dmitry Osipenko <dmitry.osipenko@collabora.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Akihiko Odaki <akihiko.odaki@daynix.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Sean Paul <seanpaul@chromium.org>
Cc:     kernel@collabora.com, linux-acpi@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20221024141210.67784-1-dmitry.osipenko@collabora.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20221024141210.67784-1-dmitry.osipenko@collabora.com>
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

On 10/24/22 16:12, Dmitry Osipenko wrote:
> Chromebooks don't have backlight in ACPI table, they suppose to use
> native backlight in this case. Check presence of the CrOS embedded
> controller ACPI device and prefer the native backlight if EC found.
> 
> Suggested-by: Hans de Goede <hdegoede@redhat.com>
> Fixes: 2600bfa3df99 ("ACPI: video: Add acpi_video_backlight_use_native() helper")
> Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
> ---
> 
> Changelog:
> 
> v2: - Added explanatory comment to the code and added check for the
>       native backlight presence, like was requested by Hans de Goede.

Thanks this version looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Rafael, can you pick this up and send it in a fixes pull-req
for 6.1 to Linus? Or shall I pick this one up and include it
in my next pull-req?

Regards,

Hans





> 
>  drivers/acpi/video_detect.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/drivers/acpi/video_detect.c b/drivers/acpi/video_detect.c
> index 0d9064a9804c..9cd8797d12bb 100644
> --- a/drivers/acpi/video_detect.c
> +++ b/drivers/acpi/video_detect.c
> @@ -668,6 +668,11 @@ static const struct dmi_system_id video_detect_dmi_table[] = {
>  	{ },
>  };
>  
> +static bool google_cros_ec_present(void)
> +{
> +	return acpi_dev_found("GOOG0004");
> +}
> +
>  /*
>   * Determine which type of backlight interface to use on this system,
>   * First check cmdline, then dmi quirks, then do autodetect.
> @@ -730,6 +735,13 @@ static enum acpi_backlight_type __acpi_video_get_backlight_type(bool native)
>  			return acpi_backlight_video;
>  	}
>  
> +	/*
> +	 * Chromebooks that don't have backlight handle in ACPI table
> +	 * are supposed to use native backlight if it's available.
> +	 */
> +	if (google_cros_ec_present() && native_available)
> +		return acpi_backlight_native;
> +
>  	/* No ACPI video (old hw), use vendor specific fw methods. */
>  	return acpi_backlight_vendor;
>  }

