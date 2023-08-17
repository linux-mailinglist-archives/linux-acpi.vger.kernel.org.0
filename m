Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B64C77FD79
	for <lists+linux-acpi@lfdr.de>; Thu, 17 Aug 2023 20:04:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237584AbjHQSEH convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-acpi@lfdr.de>); Thu, 17 Aug 2023 14:04:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354286AbjHQSED (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 17 Aug 2023 14:04:03 -0400
Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com [209.85.161.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5AE1273C
        for <linux-acpi@vger.kernel.org>; Thu, 17 Aug 2023 11:03:58 -0700 (PDT)
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-56d75fb64a6so24630eaf.0
        for <linux-acpi@vger.kernel.org>; Thu, 17 Aug 2023 11:03:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692295438; x=1692900238;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qsciARMPdufqMH1ITF715V2lvkJl4g385CSCixi2Vpk=;
        b=IKp2NJI+YVZSMMLwJbxaIwALYbfXJUU9kdSAd9bmSjgi55iVN7oM5AmS/Cg3lzCQz+
         R94VkVkHlcX8fr9P2SHgHNEJ++VpA+g9vzz7lwryskSfyXI3SjuXV3h6eiDfzRlZWYnt
         Ronv+yv8NNwfcs6NwrbeiXFYR7YLRVxR03sT2daUWhCSdVJV0RIqv0QuwC97/b8X48Nf
         T9Bv00AeFfv8EgR7IyJuSEXEm1Va/OrTkUIfAdfU4jlLgYDbeXLLhP0pyI73JK4MDWbK
         Zjb0vF591GJoO0c1APu2yLP7CoWYxJndRMFvUJaoAB1f3aZYtVJhrk7y6d1KakZCYFZi
         z9mQ==
X-Gm-Message-State: AOJu0YwCQlZBp1hU3i+ucqpluwQq8cAWKMRdzJ0Vj33IPmuZw89XpxvY
        gv0HGWqMNc8TuBHxzXdDu7XGuQM8y499nh6IhJPzpadu
X-Google-Smtp-Source: AGHT+IElTT4Wd4kiEp2BoeAAurrDCvDzjdAs2/h5pu2t54z3rIMgM5KtN7vexsO9fkF0OR1WeUgKidHPfxb220sEOdQ=
X-Received: by 2002:a4a:eb1a:0:b0:560:b01a:653d with SMTP id
 f26-20020a4aeb1a000000b00560b01a653dmr579880ooj.0.1692295437881; Thu, 17 Aug
 2023 11:03:57 -0700 (PDT)
MIME-Version: 1.0
References: <20230729042050.4413-1-rui.zhang@intel.com>
In-Reply-To: <20230729042050.4413-1-rui.zhang@intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 17 Aug 2023 20:03:46 +0200
Message-ID: <CAJZ5v0iv4AqYzskabcpt56_SnhA8BXDBvichj6DcpiXK02ZPqA@mail.gmail.com>
Subject: Re: [PATCH] ACPI: acpi_tad: Install SystemCMOS address space handler
 for ACPI000E
To:     Zhang Rui <rui.zhang@intel.com>
Cc:     rjw@rjwysocki.net, linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Sat, Jul 29, 2023 at 6:21 AM Zhang Rui <rui.zhang@intel.com> wrote:
>
> Currently, the SystemCMOS address space handler is installed for the
> ACPI RTC devices (PNP0B00/PNP0B01/PNP0B02) only. But there are platforms
> with SystemCMOS Operetion Region defined under the ACPI Time and Alarm
> Device (ACPI000E), which is used by the ACPI pre-defined control methods
> like _GRT (Get the Real time) and _SRT (Set the Real time).
>
> When accessing these control methods via the acpi_tad sysfs interface,
> missing SystemCMOS address space handler causes errors like below
> [  478.255453] ACPI Error: No handler for Region [RTCM] (00000000a8d2dd39) [SystemCMOS] (20230331/evregion-130)
> [  478.255458] ACPI Error: Region SystemCMOS (ID=5) has no handler (20230331/exfldio-261)
> [  478.255461] Initialized Local Variables for Method [_GRT]:
> [  478.255461]   Local1: 00000000f182542c <Obj>           Integer 0000000000000000
> [  478.255464] No Arguments are initialized for method [_GRT]
> [  478.255465] ACPI Error: Aborting method \_SB.AWAC._GRT due to previous error (AE_NOT_EXIST) (20230331/psparse-529)
>
> Export two APIs for SystemCMOS address space handler from acpi_cmos_rtc
> scan handler and install the handler for the ACPI Time and Alarm
> Device from acpi_tad driver.
>
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=217714
> Signed-off-by: Zhang Rui <rui.zhang@intel.com>
> ---
>  drivers/acpi/acpi_cmos_rtc.c | 25 ++++++++++++++++++-------
>  drivers/acpi/acpi_tad.c      | 26 +++++++++++++++++++++-----
>  include/acpi/acpi_bus.h      |  9 +++++++++
>  3 files changed, 48 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/acpi/acpi_cmos_rtc.c b/drivers/acpi/acpi_cmos_rtc.c
> index 4cf4aef7ce0c..9b55d1593d16 100644
> --- a/drivers/acpi/acpi_cmos_rtc.c
> +++ b/drivers/acpi/acpi_cmos_rtc.c
> @@ -51,12 +51,11 @@ acpi_cmos_rtc_space_handler(u32 function, acpi_physical_address address,
>         return AE_OK;
>  }
>
> -static int acpi_install_cmos_rtc_space_handler(struct acpi_device *adev,
> -               const struct acpi_device_id *id)
> +int acpi_install_cmos_rtc_space_handler(acpi_handle handle)
>  {
>         acpi_status status;
>
> -       status = acpi_install_address_space_handler(adev->handle,
> +       status = acpi_install_address_space_handler(handle,
>                         ACPI_ADR_SPACE_CMOS,
>                         &acpi_cmos_rtc_space_handler,
>                         NULL, NULL);
> @@ -67,18 +66,30 @@ static int acpi_install_cmos_rtc_space_handler(struct acpi_device *adev,
>
>         return 1;
>  }
> +EXPORT_SYMBOL_GPL(acpi_install_cmos_rtc_space_handler);
>
> -static void acpi_remove_cmos_rtc_space_handler(struct acpi_device *adev)
> +void acpi_remove_cmos_rtc_space_handler(acpi_handle handle)
>  {
> -       if (ACPI_FAILURE(acpi_remove_address_space_handler(adev->handle,
> +       if (ACPI_FAILURE(acpi_remove_address_space_handler(handle,
>                         ACPI_ADR_SPACE_CMOS, &acpi_cmos_rtc_space_handler)))
>                 pr_err("Error removing CMOS-RTC region handler\n");
>  }
> +EXPORT_SYMBOL_GPL(acpi_remove_cmos_rtc_space_handler);
> +
> +static int acpi_cmos_rtc_attach_handler(struct acpi_device *adev, const struct acpi_device_id *id)
> +{
> +       return acpi_install_cmos_rtc_space_handler(adev->handle);
> +}
> +
> +static void acpi_cmos_rtc_detach_handler(struct acpi_device *adev)
> +{
> +       acpi_remove_cmos_rtc_space_handler(adev->handle);
> +}
>
>  static struct acpi_scan_handler cmos_rtc_handler = {
>         .ids = acpi_cmos_rtc_ids,
> -       .attach = acpi_install_cmos_rtc_space_handler,
> -       .detach = acpi_remove_cmos_rtc_space_handler,
> +       .attach = acpi_cmos_rtc_attach_handler,
> +       .detach = acpi_cmos_rtc_detach_handler,
>  };
>
>  void __init acpi_cmos_rtc_init(void)
> diff --git a/drivers/acpi/acpi_tad.c b/drivers/acpi/acpi_tad.c
> index e9b8e8305e23..36ba6827d912 100644
> --- a/drivers/acpi/acpi_tad.c
> +++ b/drivers/acpi/acpi_tad.c
> @@ -557,6 +557,7 @@ static int acpi_tad_disable_timer(struct device *dev, u32 timer_id)
>  static int acpi_tad_remove(struct platform_device *pdev)
>  {
>         struct device *dev = &pdev->dev;
> +       acpi_handle handle = ACPI_HANDLE(dev);
>         struct acpi_tad_driver_data *dd = dev_get_drvdata(dev);
>
>         device_init_wakeup(dev, false);
> @@ -577,6 +578,7 @@ static int acpi_tad_remove(struct platform_device *pdev)
>
>         pm_runtime_put_sync(dev);
>         pm_runtime_disable(dev);
> +       acpi_remove_cmos_rtc_space_handler(handle);
>         return 0;
>  }
>
> @@ -589,6 +591,11 @@ static int acpi_tad_probe(struct platform_device *pdev)
>         unsigned long long caps;
>         int ret;
>
> +       ret = acpi_install_cmos_rtc_space_handler(handle);
> +       if (ret < 0) {
> +               dev_info(dev, "Unable to install space handler\n");
> +               return -ENODEV;
> +       }
>         /*
>          * Initialization failure messages are mostly about firmware issues, so
>          * print them at the "info" level.
> @@ -596,22 +603,27 @@ static int acpi_tad_probe(struct platform_device *pdev)
>         status = acpi_evaluate_integer(handle, "_GCP", NULL, &caps);
>         if (ACPI_FAILURE(status)) {
>                 dev_info(dev, "Unable to get capabilities\n");
> -               return -ENODEV;
> +               ret = -ENODEV;
> +               goto remove_handler;
>         }
>
>         if (!(caps & ACPI_TAD_AC_WAKE)) {
>                 dev_info(dev, "Unsupported capabilities\n");
> -               return -ENODEV;
> +               ret = -ENODEV;
> +               goto remove_handler;
>         }
>
>         if (!acpi_has_method(handle, "_PRW")) {
>                 dev_info(dev, "Missing _PRW\n");
> -               return -ENODEV;
> +               ret = -ENODEV;
> +               goto remove_handler;
>         }
>
>         dd = devm_kzalloc(dev, sizeof(*dd), GFP_KERNEL);
> -       if (!dd)
> -               return -ENOMEM;
> +       if (!dd) {
> +               ret = -ENOMEM;
> +               goto remove_handler;
> +       }
>
>         dd->capabilities = caps;
>         dev_set_drvdata(dev, dd);
> @@ -653,6 +665,10 @@ static int acpi_tad_probe(struct platform_device *pdev)
>
>  fail:
>         acpi_tad_remove(pdev);
> +       /* Don't fallthrough because cmos rtc space handler is removed in acpi_tad_remove() */
> +       return ret;
> +remove_handler:
> +       acpi_remove_cmos_rtc_space_handler(handle);
>         return ret;
>  }
>
> diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
> index c941d99162c0..fb95fff23e5b 100644
> --- a/include/acpi/acpi_bus.h
> +++ b/include/acpi/acpi_bus.h
> @@ -645,6 +645,8 @@ int acpi_disable_wakeup_device_power(struct acpi_device *dev);
>  #ifdef CONFIG_X86
>  bool acpi_device_override_status(struct acpi_device *adev, unsigned long long *status);
>  bool acpi_quirk_skip_acpi_ac_and_battery(void);
> +int acpi_install_cmos_rtc_space_handler(acpi_handle handle);
> +void acpi_remove_cmos_rtc_space_handler(acpi_handle handle);
>  #else
>  static inline bool acpi_device_override_status(struct acpi_device *adev,
>                                                unsigned long long *status)
> @@ -655,6 +657,13 @@ static inline bool acpi_quirk_skip_acpi_ac_and_battery(void)
>  {
>         return false;
>  }
> +static inline int acpi_install_cmos_rtc_space_handler(acpi_handle handle)
> +{
> +       return 1;
> +}
> +static inline void acpi_remove_cmos_rtc_space_handler(acpi_handle handle)
> +{
> +}
>  #endif
>
>  #if IS_ENABLED(CONFIG_X86_ANDROID_TABLETS)
> --

Applied as 6.6 material with some minor adjustments, thanks!

I'm wondering though what will happen if both the "old" CMOS RTC
device and the ACPI TAD are present in the namespace at the same time?
