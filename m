Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E08B5A2706
	for <lists+linux-acpi@lfdr.de>; Fri, 26 Aug 2022 13:46:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229618AbiHZLq6 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 26 Aug 2022 07:46:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238040AbiHZLq5 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 26 Aug 2022 07:46:57 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42623B275F
        for <linux-acpi@vger.kernel.org>; Fri, 26 Aug 2022 04:46:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1661514415;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LzRWmNLVKwuncbIKIC/eUHILTfbqmte1R4dyrq2G5Ow=;
        b=WThNuSUohjD2QIOAhdec5qaScm8chOufNdLvhVIb8cYNLiJ1mYwsiIgEcSzUGPlYV+Lmsi
        OznIVK7uQMVtPcDCOBhTN0eCSV5vg4A60uey7OwYa+xjccrJf3uEYMHIAi8z0KxDtsbLVd
        AuSMAkF6Q/VTt5GmukJQTMzkNI4bYNw=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-306-K2dSLcmdOuOc1OPlD6Uxjg-1; Fri, 26 Aug 2022 07:46:52 -0400
X-MC-Unique: K2dSLcmdOuOc1OPlD6Uxjg-1
Received: by mail-ej1-f70.google.com with SMTP id mp41-20020a1709071b2900b0073d84b11981so524779ejc.23
        for <linux-acpi@vger.kernel.org>; Fri, 26 Aug 2022 04:46:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=LzRWmNLVKwuncbIKIC/eUHILTfbqmte1R4dyrq2G5Ow=;
        b=sAg6IWDgs3sTO9B0hnYYBQL2XRyFDc8lYBkYSolvuzmeaMynS2nOMhq0bCrmFRQomJ
         vxCn15LSU90NbPL0jqQWvu84D1Odhli7V8rUhT+0nfo2trlC4HpH+EmGZhVmAlnBz1Hy
         9RD058H/Qit3nXqH5qGDL2WJeHPgvZGbk7Va9IJ3vv42Pftn41xYIGNxNNmhS7oUD4XO
         xoXrf+WkNMZX/gxOF6F61iFGkIus2Sl4rMm+W0gUThmFpzXc/Ox+4kn5JEwbMLNPsu53
         LrOuE6RNTmxREPpnhHuoCHwvlLdVTMJnl21giCYHUnSGN/tOcaZZ7JbvR6T22chwLUh9
         Ot5w==
X-Gm-Message-State: ACgBeo23qYonFMFJhQHd45xZqNyQpEgqeG1ht43FvKXlz1zvBYf9Ivem
        yDXopXidcOfrVYycCh42NZxyiTCYM1D6Nogy0k9NvW+scvBp0Zrub/LX7kFUCers2O71+Muwu3L
        47yixjecJgNnK67WoUo7FCQ==
X-Received: by 2002:a17:907:7da0:b0:734:9bc0:6203 with SMTP id oz32-20020a1709077da000b007349bc06203mr5235070ejc.637.1661514411033;
        Fri, 26 Aug 2022 04:46:51 -0700 (PDT)
X-Google-Smtp-Source: AA6agR5NB0znu6T2CgXrsQPALIw0XlcDCuEZ75+oyYfCbbAJDvcmQWcV3S3VvWl9IwYe9zDvNoZ9eQ==
X-Received: by 2002:a17:907:7da0:b0:734:9bc0:6203 with SMTP id oz32-20020a1709077da000b007349bc06203mr5235061ejc.637.1661514410840;
        Fri, 26 Aug 2022 04:46:50 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c1e:bf00:d69d:5353:dba5:ee81? (2001-1c00-0c1e-bf00-d69d-5353-dba5-ee81.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:d69d:5353:dba5:ee81])
        by smtp.gmail.com with ESMTPSA id f8-20020a17090631c800b0073bf84be798sm810529ejf.142.2022.08.26.04.46.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Aug 2022 04:46:50 -0700 (PDT)
Message-ID: <d097b844-8fe4-3469-2137-9e8407348175@redhat.com>
Date:   Fri, 26 Aug 2022 13:46:49 +0200
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
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi All,

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

So I've been thinking a bit about this and this is going to
be a problem with my pending backlight refactor work.

*** Note this patch should still be merged as a fix for 6.0
and older ***

On these models acpi_video_get_backlight_type() returns
acpi_backlight_video, otherwise setting disable_backlight_sysfs_if
would not do anything.

After my "drm/kms: Stop registering multiple /sys/class/backlight
devs for a single display" series (1), the intel_backlight will no
longer gets registered, that now only happens when
acpi_video_get_backlight_type() returns acpi_backlight_native.

This will break the disable_backlight_sysfs_if workaround
because after this there then won't be any devices under
/sys/class/backlight at all.

I have been thinking about how to fix this, here are my notes
I have written on this.

-toshiba r830 / z830 problem after series:
 -duplicate DMI match in video_detect, force native
 -make disable_backlight_sysfs_if still work even when
  acpi_video_register_backlight() does not get called, just do
  the backlight_init directly from acpi_video_register()
  when disable_backlight_sysfs_if is set, as before
  my refactor series

This will work, but it makes the code (even more) ugly /
convoluted.

Arvid, I wonder if instead of using disable_backlight_sysfs_if
you can try:

0. Remove disable_backlight_sysfs_if from cmdline / quirk
1. Adding acpi_backlight=native to the kernel commandline
2. In toshiba_acpi_resume() add a HCI_PANEL_POWER_ON PANEL_ON

and see if that also fixes things ?

If that is the case then we can:

1. Move the DMI quirks for disable_backlight_sysfs_if
   from acpi_video.c to video_detect.c to force native
   mode by quirk
2. Add the DMI table with the models needing this to
   toshiba_acpi.c and then based on that call
   HCI_PANEL_POWER_ON PANEL_ON on resume from there
3. Since there are no more quirks using it, remove the
   disable_backlight_sysfs_if hack / workaround from
   acpi_video.c

This will give a nice-cleanup of the generic acpi_video.c
code moving the toshiba specific fixup to toshiba_acpi
where it really belongs.

Regards,

Hans



1) https://lore.kernel.org/platform-driver-x86/20220825143726.269890-1-hdegoede@redhat.com/T/


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

