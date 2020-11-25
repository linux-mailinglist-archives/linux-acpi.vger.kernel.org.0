Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B73CA2C445A
	for <lists+linux-acpi@lfdr.de>; Wed, 25 Nov 2020 16:48:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730571AbgKYPrj (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 25 Nov 2020 10:47:39 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:39882 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730682AbgKYPrj (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 25 Nov 2020 10:47:39 -0500
Received: by mail-ot1-f68.google.com with SMTP id z24so2605531oto.6;
        Wed, 25 Nov 2020 07:47:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VPEAtWsf8MMjkM2nOUeIWdN0dpu++VrabhFJBAe7b/U=;
        b=HXgAsNh2M4vmm/wyGa4Gw62upnMfikGr+X/3ha9zLARw5PtiYHd/75FWK66j9K5tIT
         riQM49zcbdCQWX2RbPyjg8o6OzWr+VzYy02KL7xuvgkAtNKdCCFYyPN7361ByduJvb7O
         RbkqFhsqeIIObV9nkyqTn6OKogYFYpTt1Vk/GKNQi/WRS4gyuyzAn5a4BiJKfY08O4T2
         dJdd3wXWo2TJBo29d91fBz7nFMnaixTNm3kujSC/+w2WtdjMgvyR9j9R8tC+QpPBJx0M
         6yiaLjjJeg7NXm+VTFwSaMqmlGaFDQj3zOZU3h3tTSvk67E6riMj1BpCImrDCKqa0qW3
         NBuA==
X-Gm-Message-State: AOAM531VD1I7JsbvP9dFqQpSdxLwdfdhJFA3VR9Cp/B4vh+TiePKaNzT
        0vFnIxxIZh4zS7oFU4W0N0lxiRTUVnywYtscSV0=
X-Google-Smtp-Source: ABdhPJzbXGTvSVycJKWZaz0c4u4qfrWcR8Mo7wsvnvNd3HkGfhnPKqBR+nZIXqsBDJ7JmQuN+6hkLXfpitcd5H7aSqw=
X-Received: by 2002:a05:6830:2385:: with SMTP id l5mr3209449ots.321.1606319258689;
 Wed, 25 Nov 2020 07:47:38 -0800 (PST)
MIME-Version: 1.0
References: <20201123235951.96243-1-punitagrawal@gmail.com>
In-Reply-To: <20201123235951.96243-1-punitagrawal@gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 25 Nov 2020 16:47:27 +0100
Message-ID: <CAJZ5v0ghqXQ_bOYvP7qPDkhyJKseJm5gUJ4hLjLbUE=rRQFx=Q@mail.gmail.com>
Subject: Re: [PATCH] ACPI: processor: Drop duplicate setting of shared_cpu_map
To:     Punit Agrawal <punitagrawal@gmail.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, Nov 24, 2020 at 1:00 AM Punit Agrawal <punitagrawal@gmail.com> wrote:
>
> 'shared_cpu_map', stored as part of the per-processor
> acpi_processor_performance structre, is used to store cpus that share
> a performance domain. By definition it contains the owning cpu.
>
> While building the 'shared_cpu_map' it is being set twice - once while
> initialising the performance domains and again when matching cpus
> belonging to the same domain.
>
> Drop the unnecessary initialisation.
>
> Signed-off-by: Punit Agrawal <punitagrawal@gmail.com>
> ---
>  drivers/acpi/processor_perflib.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/drivers/acpi/processor_perflib.c b/drivers/acpi/processor_perflib.c
> index b04a68950ff1..b0d320f18163 100644
> --- a/drivers/acpi/processor_perflib.c
> +++ b/drivers/acpi/processor_perflib.c
> @@ -616,7 +616,6 @@ int acpi_processor_preregister_performance(
>                         continue;
>
>                 pr->performance = per_cpu_ptr(performance, i);
> -               cpumask_set_cpu(i, pr->performance->shared_cpu_map);
>                 pdomain = &(pr->performance->domain_info);
>                 if (acpi_processor_get_psd(pr->handle, pdomain)) {
>                         retval = -EINVAL;
> --

Applied as 5.11 material, thanks!
