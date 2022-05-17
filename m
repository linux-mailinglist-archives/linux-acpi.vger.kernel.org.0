Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B88A52A589
	for <lists+linux-acpi@lfdr.de>; Tue, 17 May 2022 17:02:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347597AbiEQPC3 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 17 May 2022 11:02:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243507AbiEQPC1 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 17 May 2022 11:02:27 -0400
Received: from mail-io1-f41.google.com (mail-io1-f41.google.com [209.85.166.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEB886410;
        Tue, 17 May 2022 08:02:25 -0700 (PDT)
Received: by mail-io1-f41.google.com with SMTP id q203so3706208iod.0;
        Tue, 17 May 2022 08:02:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Hy9Fd7X4zWlZDVMRHmrsAnJCqrq0FuPgwnYlhjRMc+M=;
        b=h9kzDs1ENar/YlTwbHiTk4WwcfDyyY240uuoEgCYeCr8eoS6T7zDui13pa85nrKXa9
         +B0AkXQD7WRf3mZCQnHb39HAVf1/4puk6itnRgX3gGn/GTOrMMK4c4ezlda22eciz4R4
         GcaI5FqFGg+uf8DA2t83RXaLpJcmsGXiwPGUZFchEmRscr494VTj+yUtSXOJlBD9+eZO
         B720SCmoxIV7ETyqwzOfGsjssUeHn3iZ86uReJxo1qekMToIetVn8hnBe/mPUHzLjmNq
         bMwG7r5ohbouu1qSnVuqxLDaebioVB/Y6wZLQo5yDRbcXM9LEDb37v3+HJ6R9L0pghvI
         yd5A==
X-Gm-Message-State: AOAM530/9NOuEfyM4A8pG/2FQXjM98E1yUp4TvCPjT005EgIHL0El7vE
        PT0eoPAYIYIgd++0h2lLaP7XfVawG4bDGWE2cXjzNhg+
X-Google-Smtp-Source: ABdhPJwXLH/EDjQbAWO8AgtCBj7RSBPSJyTjT/MEJTmnCK/Yct/LD0ToRzPkNBc5al34nAyrikJRVGhUz/UB83jrUVk=
X-Received: by 2002:a05:6602:2dc4:b0:648:adac:bae8 with SMTP id
 l4-20020a0566022dc400b00648adacbae8mr10802774iow.9.1652799745301; Tue, 17 May
 2022 08:02:25 -0700 (PDT)
MIME-Version: 1.0
References: <20220505015814.3727692-1-rui.zhang@intel.com> <20220505015814.3727692-3-rui.zhang@intel.com>
In-Reply-To: <20220505015814.3727692-3-rui.zhang@intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 17 May 2022 17:02:14 +0200
Message-ID: <CAJZ5v0ikGkBqT1FNxGv3Y2guMRhb0su+qioGee=eo22NS+xErQ@mail.gmail.com>
Subject: Re: [PATCH 2/7] thermal: intel: pch: enhance overheat handling
To:     Zhang Rui <rui.zhang@intel.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>, kvalo@kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        linux-rtc@vger.kernel.org,
        "open list:NETWORKING DRIVERS (WIRELESS)" 
        <linux-wireless@vger.kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        merez@codeaurora.org, mat.jonczyk@o2.pl,
        Sumeet Pawnikar <sumeet.r.pawnikar@intel.com>,
        Len Brown <len.brown@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, May 5, 2022 at 3:58 AM Zhang Rui <rui.zhang@intel.com> wrote:
>
> Commit ef63b043ac86 ("thermal: intel: pch: fix S0ix failure due to PCH
> temperature above threshold") introduces delay loop mechanism that allows
> PCH temperature to go down below threshold during suspend so it won't
> block S0ix. And the default overall delay timeout is 1 second.
>
> However, in practice, we found that the time it takes to cool the PCH down
> below threshold highly depends on the initial PCH temperature when the
> delay starts, as well as the ambient temperature.
> And in some cases, the 1 second delay is not sufficient. As a result, the
> system stays in a shallower power state like PCx instead of S0ix, and
> drains the battery power, without user' notice.
>
> To make sure S0ix is not blocked by the PCH overheating, we
> 1. expand the default overall timeout to 60 seconds.
> 2. make sure the temperature is below threshold rather than equal to it.
> 3. move the delay to .suspend_noirq phase instead, in order to
>    a) do cooling delay with a more quiescent system
>    b) be aware of wakeup events during the long delay, because some wakeup
>       events (ACPI Power button Press, USB mouse, etc) become valid only
>       in .suspend_noirq phase and later.
>
> This may introduce longer suspend time, but only in the cases when the
> system overheats and Linux used to enter a shallower S2idle state, say,
> PCx instead of S0ix.
>
> Signed-off-by: Zhang Rui <rui.zhang@intel.com>
> Tested-by: Sumeet Pawnikar <sumeet.r.pawnikar@intel.com>
> ---
>  drivers/thermal/intel/intel_pch_thermal.c | 18 +++++++++++-------
>  1 file changed, 11 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/thermal/intel/intel_pch_thermal.c b/drivers/thermal/intel/intel_pch_thermal.c
> index 527c91f5960b..b7b32e2f5ae2 100644
> --- a/drivers/thermal/intel/intel_pch_thermal.c
> +++ b/drivers/thermal/intel/intel_pch_thermal.c
> @@ -70,8 +70,8 @@ static unsigned int delay_timeout = 100;
>  module_param(delay_timeout, int, 0644);
>  MODULE_PARM_DESC(delay_timeout, "amount of time delay for each iteration.");
>
> -/* Number of iterations for cooling delay, 10 counts by default for now */
> -static unsigned int delay_cnt = 10;
> +/* Number of iterations for cooling delay, 600 counts by default for now */
> +static unsigned int delay_cnt = 600;
>  module_param(delay_cnt, int, 0644);
>  MODULE_PARM_DESC(delay_cnt, "total number of iterations for time delay.");
>
> @@ -193,10 +193,11 @@ static int pch_wpt_get_temp(struct pch_thermal_device *ptd, int *temp)
>         return 0;
>  }
>
> +/* Cool the PCH when it's overheat in .suspend_noirq phase */
>  static int pch_wpt_suspend(struct pch_thermal_device *ptd)
>  {
>         u8 tsel;
> -       u8 pch_delay_cnt = 1;
> +       int pch_delay_cnt = 1;
>         u16 pch_thr_temp, pch_cur_temp;
>
>         /* Shutdown the thermal sensor if it is not enabled by BIOS */
> @@ -233,7 +234,10 @@ static int pch_wpt_suspend(struct pch_thermal_device *ptd)
>          * which helps to indentify the reason why S0ix entry was rejected.
>          */
>         while (pch_delay_cnt <= delay_cnt) {
> -               if (pch_cur_temp <= pch_thr_temp)
> +               if (pch_cur_temp < pch_thr_temp)
> +                       break;
> +
> +               if (pm_wakeup_pending())
>                         break;
>
>                 dev_warn(&ptd->pdev->dev,
> @@ -245,7 +249,7 @@ static int pch_wpt_suspend(struct pch_thermal_device *ptd)
>                 pch_delay_cnt++;
>         }
>
> -       if (pch_cur_temp > pch_thr_temp)
> +       if (pch_cur_temp >= pch_thr_temp)
>                 dev_warn(&ptd->pdev->dev,
>                         "CPU-PCH is hot [%dC] even after delay, continue to suspend. S0ix might fail\n",
>                         pch_cur_temp);
> @@ -455,7 +459,7 @@ static void intel_pch_thermal_remove(struct pci_dev *pdev)
>         pci_disable_device(pdev);
>  }
>
> -static int intel_pch_thermal_suspend(struct device *device)
> +static int intel_pch_thermal_suspend_noirq(struct device *device)
>  {
>         struct pch_thermal_device *ptd = dev_get_drvdata(device);
>
> @@ -495,7 +499,7 @@ static const struct pci_device_id intel_pch_thermal_id[] = {
>  MODULE_DEVICE_TABLE(pci, intel_pch_thermal_id);
>
>  static const struct dev_pm_ops intel_pch_pm_ops = {
> -       .suspend = intel_pch_thermal_suspend,
> +       .suspend_noirq = intel_pch_thermal_suspend_noirq,

IMO it would be better to put this change into a separate patch and
reorder the other changes after this one.  It is valid by itself.

>         .resume = intel_pch_thermal_resume,
>  };
>
> --
