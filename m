Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC89337A826
	for <lists+linux-acpi@lfdr.de>; Tue, 11 May 2021 15:52:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230435AbhEKNxQ (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 11 May 2021 09:53:16 -0400
Received: from mail-oo1-f50.google.com ([209.85.161.50]:36777 "EHLO
        mail-oo1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231495AbhEKNxN (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 11 May 2021 09:53:13 -0400
Received: by mail-oo1-f50.google.com with SMTP id v13-20020a4aa40d0000b02902052145a469so2583709ool.3;
        Tue, 11 May 2021 06:52:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=o2wOANe63VWBbOClI5Kxi1LQXDul3YsfQa83b5bGppo=;
        b=PCyDJxIWpWO86jM/2qvkwOkxshs6P663zuBPAoEWcKe3q6Sj6wjMHinXTyNDWg2qm3
         Jaml/jOoKl78jvZaq+kOdy48b9iuq4baC6BpoTBesilr5/2Bhd4UIsuL/UvsfBfDvX4O
         c8xtQ8NkVqS1a92qFqGb1hCEA1uaHlTL4KPR2XRqaqF2TaD4UnyfBgkqHzIlc3ZJUpsv
         86i0uBuYIAKtrJxBlKl3INkR952bsiuUTX6cSHFzsuFvUqXYVlTH5rsOY5TZvc+Ah98K
         K+7R820erCHcKgcnhaMeNsYDawNCxIpalTaHU6BU31JwJh0tA80tZ5VXoihg0YxuUf0X
         hDbg==
X-Gm-Message-State: AOAM531G6F4FWHjFCQSnX3j2LYNmTZ7Ym3ILrqROcy4XHUtWIrBbJdGm
        m4lZ0MOSUKW5MncGSZrHpc68FnxEJHGeu5b6XJU=
X-Google-Smtp-Source: ABdhPJwFcZA16tQZGvHf+XVzbzt7JEHzpCT1W99bHkAMH6RNQF1I4Pwjbx2OY6rEzpdtE4e/qCuxqPeMh09KU3AjpFA=
X-Received: by 2002:a4a:e5d5:: with SMTP id r21mr23824031oov.1.1620741126782;
 Tue, 11 May 2021 06:52:06 -0700 (PDT)
MIME-Version: 1.0
References: <20210511125528.18525-1-heikki.krogerus@linux.intel.com>
In-Reply-To: <20210511125528.18525-1-heikki.krogerus@linux.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 11 May 2021 15:51:55 +0200
Message-ID: <CAJZ5v0iQA91927-OXWVRu2_yNgTS-7b8ew4uvo+qk8q86vzOsg@mail.gmail.com>
Subject: Re: [PATCH] ACPI/IORT: Handle device properties with software node API
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Hanjun Guo <guohanjun@huawei.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Joerg Roedel <jroedel@suse.de>,
        Eric Auger <eric.auger@redhat.com>,
        Will Deacon <will@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, May 11, 2021 at 2:55 PM Heikki Krogerus
<heikki.krogerus@linux.intel.com> wrote:
>
> The older device property API is going to be removed.
> Replacing the device_add_properties() call with software
> node API equivalent device_create_managed_software_node().
>
> Fixes: 434b73e61cc6 ("iommu/arm-smmu-v3: Use device properties for pasid-num-bits")
> Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> ---
>  drivers/acpi/arm64/iort.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
> index 3912a1f6058e5..e34937e11186a 100644
> --- a/drivers/acpi/arm64/iort.c
> +++ b/drivers/acpi/arm64/iort.c
> @@ -976,7 +976,7 @@ static void iort_named_component_init(struct device *dev,
>                                       FIELD_GET(ACPI_IORT_NC_PASID_BITS,
>                                                 nc->node_flags));
>
> -       if (device_add_properties(dev, props))
> +       if (device_create_managed_software_node(dev, props, NULL))
>                 dev_warn(dev, "Could not add device properties\n");
>  }
>
> --

Thanks!

I can take this through the ACPI tree if there are no objections.
