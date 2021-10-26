Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACD8243B34E
	for <lists+linux-acpi@lfdr.de>; Tue, 26 Oct 2021 15:42:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234649AbhJZNom (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 26 Oct 2021 09:44:42 -0400
Received: from mail-ot1-f51.google.com ([209.85.210.51]:33554 "EHLO
        mail-ot1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230420AbhJZNoj (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 26 Oct 2021 09:44:39 -0400
Received: by mail-ot1-f51.google.com with SMTP id 107-20020a9d0a74000000b00553bfb53348so2141053otg.0;
        Tue, 26 Oct 2021 06:42:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZLF/RSQc/WiflaSY0ZupsORfhON+Yiy4zLK9+j5ymtI=;
        b=sI7ve687dTXw0k6/yy4Sj6sZVx69m0YJ/ex+sOc1wZyDqDj4cVQRKZdkBQK86Zqfdp
         9+DjBNIkt/+21v5wx4xqyClixqzmqHSo26uU3GjPPluXU71lgJEDaG5dtx5zBc5tULX9
         pUVtyL/VBO1KG8exaIpfT4lxNZ2dLsYr0JWqgLfhxzMOL4MID4gtcfoAYVw8Ai4ZmKpy
         KjdxRXlckjamlT7gJey2N3SsqUjKiVWQ21XJsM8wsEi2w+s3KNnpzTOBS3fpXpt+UGsn
         4/mYgfywMAqp7PhAJFrEv5NEJZDNHB+TdQ6ijPwPlZuVFtxLaFRUKPt4XqqmmTasrg5g
         iFKw==
X-Gm-Message-State: AOAM533TsXvi8KWoJ9dJN1aT6LAHWHGULqr9AaiFsgt3G2BB2vo/wgdx
        YfYJJTNWEZp7+d+bdt0w/cW7ybEUNvYYiWDMKGw=
X-Google-Smtp-Source: ABdhPJxGD/GRph7GnjGJpYV5SHMstOTxDb52gzL4qpypFSKXy7VQrJk1KlQhvVV5EYbQSOx1DwxlEBnjwSpL8mZkAU4=
X-Received: by 2002:a9d:65c1:: with SMTP id z1mr19082692oth.198.1635255735613;
 Tue, 26 Oct 2021 06:42:15 -0700 (PDT)
MIME-Version: 1.0
References: <4369779.LvFx2qVVIh@kreacher> <3338400.QJadu78ljV@kreacher> <21252081.EfDdHjke4D@kreacher>
In-Reply-To: <21252081.EfDdHjke4D@kreacher>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 26 Oct 2021 15:41:59 +0200
Message-ID: <CAJZ5v0gOUdM64FqkeXmGd+Zyc5a_u=RBC6S2rxM4F5oTJ57wNw@mail.gmail.com>
Subject: Re: [PATCH v2 7/7] perf: qcom_l2_pmu: ACPI: Use ACPI_COMPANION() directly
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Linux ACPI <linux-acpi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, Oct 13, 2021 at 6:16 PM Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> The ACPI_HANDLE() macro is a wrapper arond the ACPI_COMPANION()
> macro and the ACPI handle produced by the former comes from the
> ACPI device object produced by the latter, so it is way more
> straightforward to evaluate the latter directly instead of passing
> the handle produced by the former to acpi_bus_get_device().
>
> Modify l2_cache_pmu_probe_cluster() accordingly (no intentional
> functional impact).
>
> While at it, rename the ACPI device pointer to adev for more
> clarity.
>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

If nobody nas any concerns regarding this patch, I will queue it up
for 5.16 in the ACPI tree, because it is requisite for further
changes.

Thanks!

> ---
>
> v1 -> v2:
>    * Resend with a different From and S-o-b address.  No other changes.
>
> ---
>  drivers/perf/qcom_l2_pmu.c |    7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
>
> Index: linux-pm/drivers/perf/qcom_l2_pmu.c
> ===================================================================
> --- linux-pm.orig/drivers/perf/qcom_l2_pmu.c
> +++ linux-pm/drivers/perf/qcom_l2_pmu.c
> @@ -840,17 +840,14 @@ static int l2_cache_pmu_probe_cluster(st
>  {
>         struct platform_device *pdev = to_platform_device(dev->parent);
>         struct platform_device *sdev = to_platform_device(dev);
> +       struct acpi_device *adev = ACPI_COMPANION(dev);
>         struct l2cache_pmu *l2cache_pmu = data;
>         struct cluster_pmu *cluster;
> -       struct acpi_device *device;
>         unsigned long fw_cluster_id;
>         int err;
>         int irq;
>
> -       if (acpi_bus_get_device(ACPI_HANDLE(dev), &device))
> -               return -ENODEV;
> -
> -       if (kstrtoul(device->pnp.unique_id, 10, &fw_cluster_id) < 0) {
> +       if (!adev || kstrtoul(adev->pnp.unique_id, 10, &fw_cluster_id) < 0) {
>                 dev_err(&pdev->dev, "unable to read ACPI uid\n");
>                 return -ENODEV;
>         }
>
>
>
