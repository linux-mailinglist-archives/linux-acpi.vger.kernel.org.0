Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA02F45CA41
	for <lists+linux-acpi@lfdr.de>; Wed, 24 Nov 2021 17:41:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349120AbhKXQpB (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 24 Nov 2021 11:45:01 -0500
Received: from mail-oi1-f175.google.com ([209.85.167.175]:46987 "EHLO
        mail-oi1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343531AbhKXQpB (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 24 Nov 2021 11:45:01 -0500
Received: by mail-oi1-f175.google.com with SMTP id s139so6429929oie.13;
        Wed, 24 Nov 2021 08:41:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qaQLoqCr3Bu3FON+bmDgSA2R37z/A0V/SycWUoorbGI=;
        b=CaXonKpcG477DLrXP4loyfllGc5WLweEeRxmJedY+zcWFManPeYjJR92HilwUOXB/z
         rL/1JmPdWJqACsv4uR+AA8Aiw52+ElCEQLH/8Qw5JKykLhtSTpcKRnaP7sqvN+x4NXbx
         uY5El9i/SR/P3Dv+52K2nfxpVR+eEb8uU1FN9QavwXxKja1D1iFhmjsFFq56wPHyvczo
         EfxDFk4YOEGkzf8Ie5bc/KHrYt4JHtT0pvUHEirTt6U/qlkCWFPPrMinlOdO8iRIZOMB
         bSwPzhyFi19OtglssqKCeDvqU3ecrX+dsMFKiy4gOaja+NHIJSZhjy+jyrMnnqbRI1DF
         Vbgg==
X-Gm-Message-State: AOAM530RQFo9JOr2Z4UXWE8cYuylOcgVnFUFKpu0NhbDoWhCv7ip50DS
        y0dhjBQaaXeeGlEMvdA8rU82Et0kEvRPX6H9xi3DLB9v
X-Google-Smtp-Source: ABdhPJwMzsMC2jMaNNsakgM3B5x0vRGM0ZxXXLlO8OmYzG1c2mwxbWAEO71fLiiQdtntTezujFrwcFUaG2W8dmgMEhY=
X-Received: by 2002:a05:6808:e90:: with SMTP id k16mr7477998oil.166.1637772111006;
 Wed, 24 Nov 2021 08:41:51 -0800 (PST)
MIME-Version: 1.0
References: <20211112120029.10851-1-sumeet.r.pawnikar@intel.com>
In-Reply-To: <20211112120029.10851-1-sumeet.r.pawnikar@intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 24 Nov 2021 17:41:40 +0100
Message-ID: <CAJZ5v0ixYxhbE0yYvnLb9WaSGPTudHMGy9BvLzHOJSn2ue58XQ@mail.gmail.com>
Subject: Re: [PATCH] ACPI: DPTF: Update device ID information under comment
To:     Sumeet Pawnikar <sumeet.r.pawnikar@intel.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, Nov 12, 2021 at 12:42 PM Sumeet Pawnikar
<sumeet.r.pawnikar@intel.com> wrote:
>
> Update device ID information appropriately under comment section.
> It seems previously this comment was added considering this driver
> used for Tiger Lake based systems. But, now this is being used by
> Alder Lake based systems as well as per this commit 38748bcb940e
> ("ACPI: DPTF: Support Alder Lake"). So, updating the comment for
> more generic type from INT1045 to INT10xx and also correcting it
> from INT to INTC string for this device ID information under
> comment section.
>
> Signed-off-by: Sumeet Pawnikar <sumeet.r.pawnikar@intel.com>
> ---
>  drivers/acpi/dptf/dptf_pch_fivr.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/acpi/dptf/dptf_pch_fivr.c b/drivers/acpi/dptf/dptf_pch_fivr.c
> index f4e9c2ef2f88..e7ab0fc90db9 100644
> --- a/drivers/acpi/dptf/dptf_pch_fivr.c
> +++ b/drivers/acpi/dptf/dptf_pch_fivr.c
> @@ -46,7 +46,7 @@ static int pch_fivr_read(acpi_handle handle, char *method, struct pch_fivr_resp
>  }
>
>  /*
> - * Presentation of attributes which are defined for INT1045
> + * Presentation of attributes which are defined for INTC10xx
>   * They are:
>   * freq_mhz_low_clock : Set PCH FIVR switching freq for
>   *                     FIVR clock 19.2MHz and 24MHz
> --

Applied as 5.17 material with edited subject and changelog, thanks!
