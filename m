Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A2CB60BD19
	for <lists+linux-acpi@lfdr.de>; Tue, 25 Oct 2022 00:07:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231553AbiJXWHq (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 24 Oct 2022 18:07:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231993AbiJXWH0 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 24 Oct 2022 18:07:26 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E86481B76D8
        for <linux-acpi@vger.kernel.org>; Mon, 24 Oct 2022 13:20:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1666642764;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6q/xMoeVmga+HpwADG17OmHFg0oiwCuCqYr1QHNmRRc=;
        b=FJwbUUGvJkM3kKizsX6QKeOD8lW7j3N1Vpdsb5GqJbXM4eKwJGxhHlprZ+cT1Y0+GqMssf
        8awHkpfOCwiQ+5++75mDKcjAeVWuZLqP4gzBIjEqqGxt3AXuZkluVxucpPUM0eXaRrLbaQ
        tVAuxBWd/+iqmdOyZ0/Vhdh/HLcxtaM=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-668-zxtdRPvAPeW_smuY43IecQ-1; Mon, 24 Oct 2022 09:46:19 -0400
X-MC-Unique: zxtdRPvAPeW_smuY43IecQ-1
Received: by mail-ed1-f69.google.com with SMTP id v13-20020a056402348d00b0045d36615696so9696112edc.14
        for <linux-acpi@vger.kernel.org>; Mon, 24 Oct 2022 06:46:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6q/xMoeVmga+HpwADG17OmHFg0oiwCuCqYr1QHNmRRc=;
        b=Uql53UEyjcdHjOGEwDeXuww5Of5nZxA/r84mQt8BBN0l6KpSq+o6sGKAnYZ45HSV8U
         3qilteA+y4dDamkbmXHc84UDqonGkhuQN2zqlvwqiY95v06Sg5R/QeveuiNvg+SWmJQL
         3meOm15lxD/I9g8vZGMFrVnlxOLYFKhfYI9NaNoAAfjvkaE00U8nrKYn19S/lKyj8SDt
         Urg+cfL4Mk4uGxg0QupasylJ4hDGNIKA+GEvylCOfPPi3kuyN/P+tVSjhMf2Dmwi/qa9
         FY97K/GefqIBqw6kNYuRvxS//tOdMrUkR6FKvSrXceierUB4XKEqGl+/9TNNvG9tAWMB
         ADDg==
X-Gm-Message-State: ACrzQf12Wv67nRVny6ES+nkuBVdOHgV9YBaa5et1dZgmp/2+Sxsm4UrF
        Zi0Z3dL+K1QnUwtK2oHPsEw837IyGPyKNn1aqsNCEyr7MwrzbWFJLRhlNiK0Iwoobejgu1hOfrU
        dU5k4GL1gBUW1HwHby/6NFw==
X-Received: by 2002:a17:906:da86:b0:740:7120:c6e6 with SMTP id xh6-20020a170906da8600b007407120c6e6mr27436720ejb.44.1666619178172;
        Mon, 24 Oct 2022 06:46:18 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM6uMSQOmAR/n4zmJ/YtVjssY4EoT9E812QLXAB+tzpiYwnRu5WPcD0IDb/sMzkkzPqWVtQXng==
X-Received: by 2002:a17:906:da86:b0:740:7120:c6e6 with SMTP id xh6-20020a170906da8600b007407120c6e6mr27436705ejb.44.1666619177956;
        Mon, 24 Oct 2022 06:46:17 -0700 (PDT)
Received: from [10.40.98.142] ([78.108.130.194])
        by smtp.gmail.com with ESMTPSA id i1-20020a170906250100b0077a11b79b9bsm15523488ejb.133.2022.10.24.06.46.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Oct 2022 06:46:17 -0700 (PDT)
Message-ID: <92e9d424-0672-b37e-b8b3-cac431ade7f7@redhat.com>
Date:   Mon, 24 Oct 2022 15:46:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH v1] ACPI: video: Fix missing native backlight on
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
References: <20221024133201.43753-1-dmitry.osipenko@collabora.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20221024133201.43753-1-dmitry.osipenko@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi,

On 10/24/22 15:32, Dmitry Osipenko wrote:
> Chromebooks don't have backlight in ACPI table, they suppose to use
> native backlight in this case. Check presence of the CrOS embedded
> controller ACPI device and prefer the native backlight if EC found.

Thank you for this patch!

> Suggested-by: Hans de Goede <hdegoede@redhat.com>
> Fixes: b1d36e73cc1c ("drm/i915: Don't register backlight when another backlight should be used (v2)")
> Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
> ---
>  drivers/acpi/video_detect.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/acpi/video_detect.c b/drivers/acpi/video_detect.c
> index 0d9064a9804c..8ed5021de6fb 100644
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
> @@ -730,6 +735,9 @@ static enum acpi_backlight_type __acpi_video_get_backlight_type(bool native)
>  			return acpi_backlight_video;
>  	}
>  
> +	if (google_cros_ec_present())
> +		return acpi_backlight_native;
> +

Nice, a couple of remarks:

1. Maybe add a small comment explaining why, like all the other tests in the function have a small comment ?

2. I think it would be better to do:

	if (google_cros_ec_present() && native_available)
		return acpi_backlight_native;

I can e.g. imagine in the future some chromebooks where for some reason native
GPU backlight control is not available using the EC for backlight control
and then having the chrome-ec code register a backlight with "vendor" type ?

3. This will also trigger on the Framework laptops and possible other new
non Chromebook designs which choose to use the Chrome EC code for their EC,
I don't expect these devices to get to this point of __acpi_video_get_backlight_type()
(they will hit the earlier acpi_video / native paths) but still I want to
at least point this out in case someone sees a potential issue with this?


If you can address 1. and 2. from above (or explain why 2. is a bad idea)
then I believe that the next version of this can get merged to resolve
the chromebook backlight issues introduced in 6.1-rc1, thank you!


>  	/* No ACPI video (old hw), use vendor specific fw methods. */
>  	return acpi_backlight_vendor;
>  }


Regards,

Hans

