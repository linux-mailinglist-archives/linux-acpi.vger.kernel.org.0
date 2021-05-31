Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43B37395A0D
	for <lists+linux-acpi@lfdr.de>; Mon, 31 May 2021 14:07:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231330AbhEaMJM (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 31 May 2021 08:09:12 -0400
Received: from mail-oi1-f172.google.com ([209.85.167.172]:43941 "EHLO
        mail-oi1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231327AbhEaMJK (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 31 May 2021 08:09:10 -0400
Received: by mail-oi1-f172.google.com with SMTP id j75so12053461oih.10
        for <linux-acpi@vger.kernel.org>; Mon, 31 May 2021 05:07:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2bQYrlh6qy/vhuextzfu9rTeGyVmWF9ygxMr+poWqJY=;
        b=X5yV2Tf7/va5B31idh3glHUGEUKK/vOBODxTR2fbQu/ge9fANQZB/dybmJs6uVos1X
         De8JN5xGRbNx22xLjRYSaupgCs8oBGpGhxsY4JNYRdegUSUsFiCc8HnjNmh4Bugc5Lx5
         G+wtg81aNPFPok4O/7a30Ubdya5xtjn8271G0oO2NsXhY9xzaGI6RAfMielD9d+8sHoZ
         fjfG2tk8bTEjItXgHoVS5sldcSaHqwiY32ypqn+eY/LXZMl+aDTfi6NtBVUsnCV6smAi
         3I8XwG5ZyOauJbYId2zHWqXTIhGOn1+Cd1SoFLTJn4k+oVGI7Hj0GmYM9fAZnFLholy8
         YMyw==
X-Gm-Message-State: AOAM531pncV6stHzLy93tToRgLFhuQ8dU1yr9ird6/BJSin6QOHDbHnQ
        hVjf2DWmWTCs8lb+BXW2joO78LiI2xIUSgNiPWQ=
X-Google-Smtp-Source: ABdhPJwZQBEIbiGj/z7ADPy03dONNXC4VD6rjLo0UQ8OrY4V14E9tGqUzMJ0mvTitOovIGgBi1LfuOUvaxrZpAMho04=
X-Received: by 2002:aca:1910:: with SMTP id l16mr13365879oii.69.1622462850782;
 Mon, 31 May 2021 05:07:30 -0700 (PDT)
MIME-Version: 1.0
References: <20210527143955.38591-1-joey.gouly@arm.com>
In-Reply-To: <20210527143955.38591-1-joey.gouly@arm.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 31 May 2021 14:07:14 +0200
Message-ID: <CAJZ5v0hp6spnn9+YckWzvzHKRxQk-6Du30_DF6mwyUmVFS574Q@mail.gmail.com>
Subject: Re: [PATCH v1] ACPI / PPTT: Populate cache-id from rev3 of PPTT in ACPIv6.4
To:     Joey Gouly <joey.gouly@arm.com>
Cc:     ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, nd <nd@arm.com>,
        James Morse <james.morse@arm.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, May 27, 2021 at 4:40 PM Joey Gouly <joey.gouly@arm.com> wrote:
>
> From: James Morse <james.morse@arm.com>
>
> ACPIv6.4 adds a 'cache id' to the PPTT Cache Type Structure.
> Copy this property accross into the cacheinfo leaf when it was
> provided by firmware.
>
> This value getes exposed to userspace as:
> /sys/devices/system/cpu/cpu*/cache/index*/id.
> See the "Cache IDs" section of Documentation/x86/resctrl.rst.
>
> Co-authored-by: Joey Gouly <joey.gouly@arm.com>
> Signed-off-by: James Morse <james.morse@arm.com>
> Signed-off-by: Joey Gouly <joey.gouly@arm.com>
> ---
>  drivers/acpi/pptt.c | 16 ++++++++++++++--
>  1 file changed, 14 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/acpi/pptt.c b/drivers/acpi/pptt.c
> index 4ae93350b70d..c18a30154db5 100644
> --- a/drivers/acpi/pptt.c
> +++ b/drivers/acpi/pptt.c
> @@ -344,6 +344,7 @@ static struct acpi_pptt_cache *acpi_find_cache_node(struct acpi_table_header *ta
>
>  /**
>   * update_cache_properties() - Update cacheinfo for the given processor
> + * @table: The PPTT table - for testing the revision

What about passing the revision itself instead of a pointer to the whole table?

Or even a bool value indicating whether or not to skip the last check?

>   * @this_leaf: Kernel cache info structure being updated
>   * @found_cache: The PPTT node describing this cache instance
>   * @cpu_node: A unique reference to describe this cache instance
> @@ -354,10 +355,13 @@ static struct acpi_pptt_cache *acpi_find_cache_node(struct acpi_table_header *ta
>   *
>   * Return: nothing. Side effect of updating the global cacheinfo
>   */
> -static void update_cache_properties(struct cacheinfo *this_leaf,
> +static void update_cache_properties(struct acpi_table_header *table,
> +                                   struct cacheinfo *this_leaf,
>                                     struct acpi_pptt_cache *found_cache,
>                                     struct acpi_pptt_processor *cpu_node)
>  {
> +       struct acpi_pptt_cache_v1* found_cache_v1;
> +
>         this_leaf->fw_token = cpu_node;
>         if (found_cache->flags & ACPI_PPTT_SIZE_PROPERTY_VALID)
>                 this_leaf->size = found_cache->size;
> @@ -405,6 +409,14 @@ static void update_cache_properties(struct cacheinfo *this_leaf,
>         if (this_leaf->type == CACHE_TYPE_NOCACHE &&
>             found_cache->flags & ACPI_PPTT_CACHE_TYPE_VALID)
>                 this_leaf->type = CACHE_TYPE_UNIFIED;
> +
> +       if (table->revision >= 3 &&
> +           (found_cache->flags & ACPI_PPTT_CACHE_ID_VALID)) {
> +               found_cache_v1 = ACPI_ADD_PTR(struct acpi_pptt_cache_v1,
> +                                             found_cache, sizeof(struct acpi_pptt_cache));
> +               this_leaf->id = found_cache_v1->cache_id;
> +               this_leaf->attributes |= CACHE_ID;
> +       }
>  }
>
>  static void cache_setup_acpi_cpu(struct acpi_table_header *table,
> @@ -425,7 +437,7 @@ static void cache_setup_acpi_cpu(struct acpi_table_header *table,
>                                                    &cpu_node);
>                 pr_debug("found = %p %p\n", found_cache, cpu_node);
>                 if (found_cache)
> -                       update_cache_properties(this_leaf,
> +                       update_cache_properties(table, this_leaf,
>                                                 found_cache,
>                                                 cpu_node);
>
> --
> 2.17.1
>
