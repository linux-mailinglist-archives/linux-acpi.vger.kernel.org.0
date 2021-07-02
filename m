Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 287613B9FE2
	for <lists+linux-acpi@lfdr.de>; Fri,  2 Jul 2021 13:38:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229917AbhGBLkm (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 2 Jul 2021 07:40:42 -0400
Received: from mail-oi1-f172.google.com ([209.85.167.172]:40882 "EHLO
        mail-oi1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231145AbhGBLkm (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 2 Jul 2021 07:40:42 -0400
Received: by mail-oi1-f172.google.com with SMTP id l26so8341364oic.7;
        Fri, 02 Jul 2021 04:38:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iCHAzsHB0sMws7RBKRjD8P7yBAAzOYebr60jiktS5qU=;
        b=rBXCXMZprANG9hy00/qGTf0DwZACZt8TMqsbmDPl1usJX8/oZda60fxQwkWA5ruEFU
         Sz0Fq5g64E6uNFJj8JtBj/30PAuitNT4XgfIqNP5LDrHnHSQvghCmIEKS5I9gmeffUnl
         j661Owr8cL25JVi3H/sOEo6nFp5+pVTaMSQVkWl+SBc2Q0MUWXqHrfl/6l5+vzgaYbpP
         6DzPmLJ9DAVlg20hbhQ6gVFwniknwIvuPTrzyaNtPW8xIP80u8gYcyivbJnrz8umLSWU
         OB5q6EyP3K6Vn30ikdimbJs4ylJL1obHgJA5gxijvHVwxtCWuzKHqzXP8w+R4h+86MEY
         pqWQ==
X-Gm-Message-State: AOAM531cu7i5RYRGprozXWVsRCITCj5+8o8e+O2IRkFP1iCaW47W3cGC
        aVp0gf+fOjxe60RFRK0xd/Y1O8VF/Nli+ArWOLk=
X-Google-Smtp-Source: ABdhPJxH/S3gbLSLEve2+Dgi7LJpVSavOo27T8oBVokX9aS6bQ8UOCX2B9kZ3TMYo4hnoCpoXOKIp1LNCbA7vZAK5bg=
X-Received: by 2002:aca:417:: with SMTP id 23mr3654572oie.71.1625225890232;
 Fri, 02 Jul 2021 04:38:10 -0700 (PDT)
MIME-Version: 1.0
References: <1625209430-19934-1-git-send-email-aubrey.li@intel.com> <1625209430-19934-2-git-send-email-aubrey.li@intel.com>
In-Reply-To: <1625209430-19934-2-git-send-email-aubrey.li@intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 2 Jul 2021 13:37:58 +0200
Message-ID: <CAJZ5v0jq=-97bW_s7dx2U=y-3rZoJsLtFre2XXYAaQgAdbQdXA@mail.gmail.com>
Subject: Re: [PATCH 2/2] ACPI: let BIOS fall back to legacy handling if PRM disabled
To:     Aubrey Li <aubrey.li@intel.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Aubrey Li <aubrey.li@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, Jul 2, 2021 at 9:03 AM Aubrey Li <aubrey.li@intel.com> wrote:
>
> Based on _OSC PRM bit, BIOS can choose switch from legacy handling
> to using PRM. So if CONFIG_ACPI_PRMT is disabled, this bit should
> not be set to let BIOS fall back to the legacy handling (such as SMI).
>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Aubrey Li <aubrey.li@linux.intel.com>
> ---
>  drivers/acpi/bus.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
> index 60fb6a84..30a3d4a 100644
> --- a/drivers/acpi/bus.c
> +++ b/drivers/acpi/bus.c
> @@ -303,7 +303,9 @@ static void acpi_bus_osc_negotiate_platform_control(void)
>
>         capbuf[OSC_SUPPORT_DWORD] |= OSC_SB_HOTPLUG_OST_SUPPORT;
>         capbuf[OSC_SUPPORT_DWORD] |= OSC_SB_PCLPI_SUPPORT;
> +#ifdef CONFIG_ACPI_PRMT
>         capbuf[OSC_SUPPORT_DWORD] |= OSC_SB_PRM_SUPPORT;
> +#endif

What about using if (IS_ENABLED()) instead of #ifdef?

>
>  #ifdef CONFIG_ARM64
>         capbuf[OSC_SUPPORT_DWORD] |= OSC_SB_GENERIC_INITIATOR_SUPPORT;
> --
> 2.7.4
>
