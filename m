Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D3AF2ED4A9
	for <lists+linux-acpi@lfdr.de>; Thu,  7 Jan 2021 17:46:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728934AbhAGQpo (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 7 Jan 2021 11:45:44 -0500
Received: from mail-ot1-f41.google.com ([209.85.210.41]:32991 "EHLO
        mail-ot1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728210AbhAGQpo (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 7 Jan 2021 11:45:44 -0500
Received: by mail-ot1-f41.google.com with SMTP id b24so6911431otj.0;
        Thu, 07 Jan 2021 08:45:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+uZsJqi945rkcVNm9VG7/abNUIugtrjhQzGRoQZbwj0=;
        b=G5IUr/2Oz6alok1/TZVASPO1i6upYScuhg0iNATiAZPWe+707Z1U6VM5ywSY8CmpP5
         hzYxuN3qor3pK2Hr9cVwfC0+3GAvZnlBUthAbMu5am30aRUqomJ8tMs1bUUGPYsYGaoL
         nFX59X1mUydAXcBbrUnoHo3arIDWIqsFQyFaraUtGQ0wk2uaw78wbR3GMbATn4bbhHgl
         hCkhz7TygmqAA+0KgBsHBFtSjaTuEelrgjZvdeGOelOb1kDc23xg+Cfb+0aviqCV5t3K
         WWRiDUPs+50/ZcMAAaQgxsRTrZEn64ZdfE/ouSqSW/DpyuVpJmcGcBDrvB+RolCoXga/
         6E+Q==
X-Gm-Message-State: AOAM532Ea6MSaKmrAsd6iYyo/leB4Suymd7h3IYYQ7jU4bC2jkHcT7G4
        bLIbiO0gJilJ9lX7Uu53TFwpUCvbb29sYMkqnss=
X-Google-Smtp-Source: ABdhPJxORZr4iS7jVPnM0soLaho3P2ZecdCv4gYOBLb4qCBf7E7fX1+pc+5Rtn1IbZzbvl38VpjX2o3v9LwTxxe5Fpo=
X-Received: by 2002:a9d:208a:: with SMTP id x10mr7080650ota.260.1610037903337;
 Thu, 07 Jan 2021 08:45:03 -0800 (PST)
MIME-Version: 1.0
References: <20201231113525.19614-1-shawn.guo@linaro.org>
In-Reply-To: <20201231113525.19614-1-shawn.guo@linaro.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 7 Jan 2021 17:44:52 +0100
Message-ID: <CAJZ5v0hWsGNxbDgOVV-1_BbreX1+vD6hJ1Mu+_G8cEAq2RH_-g@mail.gmail.com>
Subject: Re: [PATCH] ACPI: add stub acpi_create_platform_device() for !CONFIG_ACPI
To:     Shawn Guo <shawn.guo@linaro.org>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, Dec 31, 2020 at 12:36 PM Shawn Guo <shawn.guo@linaro.org> wrote:
>
> It adds a stub acpi_create_platform_device() for !CONFIG_ACPI build, so
> that caller doesn't have to deal with !CONFIG_ACPI build issue.
>
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> ---
> This fixes an build issue reported by kernel test robot as below.
>
> https://lore.kernel.org/linux-arm-msm/20201230124925.19260-1-shawn.guo@linaro.org/T/#u
>
>  include/linux/acpi.h | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/include/linux/acpi.h b/include/linux/acpi.h
> index 2630c2e953f7..053bf05fb1f7 100644
> --- a/include/linux/acpi.h
> +++ b/include/linux/acpi.h
> @@ -885,6 +885,13 @@ static inline int acpi_device_modalias(struct device *dev,
>         return -ENODEV;
>  }
>
> +static inline struct platform_device *
> +acpi_create_platform_device(struct acpi_device *adev,
> +                           struct property_entry *properties)
> +{
> +       return NULL;
> +}
> +
>  static inline bool acpi_dma_supported(struct acpi_device *adev)
>  {
>         return false;
> --

Applied as 5.11-rc material, thanks!
