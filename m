Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F33239DE28
	for <lists+linux-acpi@lfdr.de>; Mon,  7 Jun 2021 15:56:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230209AbhFGN6P (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 7 Jun 2021 09:58:15 -0400
Received: from mail-oo1-f50.google.com ([209.85.161.50]:37602 "EHLO
        mail-oo1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230193AbhFGN6N (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 7 Jun 2021 09:58:13 -0400
Received: by mail-oo1-f50.google.com with SMTP id k10-20020a4abd8a0000b0290249ed2f2919so407893oop.4
        for <linux-acpi@vger.kernel.org>; Mon, 07 Jun 2021 06:56:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WPyZXzy8HolYAx+OCqfNzQcP0M0AO6XHUOGtZrm1eE4=;
        b=hCJimSh/2MaPh5fAGoKF2Yve4W04lC/Oxjl0ZTi8qCa1EEXZKEQ+kO6he10bQhO6M+
         YEAtQIW8WJyxcQNfrijKqc2YKSYxCpwKKR/NpoDBWciKtUirfG53801bJYIYdBo/KO2T
         SE5rlnvqkXD/qc35NGldC1nVs8UhhRWJwqtl1UU8+L0jRQvWT+cD4g0dXksrNrkSrvpT
         a9RzRWS+dXDBGUhyn2dgLl5WKHB3TUUgdfqto3In/+GWn5Np6RRNmv5JwDStnJBbu90q
         shDAkHGyBdJhnlZwos88jAiXGixpYhXhJr0F0PwLKY5Kt/qjf0OBvTKqNokJjOikKfhd
         wpnQ==
X-Gm-Message-State: AOAM5337rzepDPMg1dMf4a/EJ+UcwbL8bDCuPdnA3NCjeuidmN63kCOv
        YOHyP+JUmnvWoV2KA+ibaWpf5HI5afbFzZLe76jbna2Q
X-Google-Smtp-Source: ABdhPJylbdO6PRjGYcT2inQGJmz/kvnDLHIXVUGAad8FlLMlnRwQaOQeX2XKS+TsxSnKkuOGO+C76y8dmRmoQrVXzlY=
X-Received: by 2002:a4a:a9c8:: with SMTP id h8mr13675432oon.1.1623074182171;
 Mon, 07 Jun 2021 06:56:22 -0700 (PDT)
MIME-Version: 1.0
References: <20210601121735.53695-1-joey.gouly@arm.com>
In-Reply-To: <20210601121735.53695-1-joey.gouly@arm.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 7 Jun 2021 15:56:11 +0200
Message-ID: <CAJZ5v0jseEZ_T2oR7iVaL6_t=FipbeqvkVE--GggWVV-4iyAkQ@mail.gmail.com>
Subject: Re: [PATCH v2] ACPI / PPTT: Populate cache-id from rev3 of PPTT in ACPIv6.4
To:     Joey Gouly <joey.gouly@arm.com>
Cc:     ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, nd <nd@arm.com>,
        James Morse <james.morse@arm.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, Jun 1, 2021 at 2:17 PM Joey Gouly <joey.gouly@arm.com> wrote:
>
> From: James Morse <james.morse@arm.com>
>
> ACPIv6.4 adds a 'cache id' to the PPTT Cache Type Structure.
> Copy this property across into the cacheinfo leaf when it was
> provided by firmware.
>
> This value gets exposed to userspace as:
> /sys/devices/system/cpu/cpu*/cache/index*/id.
> See the "Cache IDs" section of Documentation/x86/resctrl.rst.
>
> Co-authored-by: Joey Gouly <joey.gouly@arm.com>
> Signed-off-by: James Morse <james.morse@arm.com>
> Signed-off-by: Joey Gouly <joey.gouly@arm.com>
> ---
>
> v2:
> - Pass `revision` instead of the table to `update_cache_properties`.
>
> v1: https://lore.kernel.org/linux-acpi/20210527143955.38591-1-joey.gouly@arm.com/
>
>  drivers/acpi/pptt.c | 18 ++++++++++++++----
>  1 file changed, 14 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/acpi/pptt.c b/drivers/acpi/pptt.c
> index 4ae93350b70d..fe69dc518f31 100644
> --- a/drivers/acpi/pptt.c
> +++ b/drivers/acpi/pptt.c
> @@ -347,6 +347,7 @@ static struct acpi_pptt_cache *acpi_find_cache_node(struct acpi_table_header *ta
>   * @this_leaf: Kernel cache info structure being updated
>   * @found_cache: The PPTT node describing this cache instance
>   * @cpu_node: A unique reference to describe this cache instance
> + * @revision: The revision of the PPTT table
>   *
>   * The ACPI spec implies that the fields in the cache structures are used to
>   * extend and correct the information probed from the hardware. Lets only
> @@ -356,8 +357,11 @@ static struct acpi_pptt_cache *acpi_find_cache_node(struct acpi_table_header *ta
>   */
>  static void update_cache_properties(struct cacheinfo *this_leaf,
>                                     struct acpi_pptt_cache *found_cache,
> -                                   struct acpi_pptt_processor *cpu_node)
> +                                   struct acpi_pptt_processor *cpu_node,
> +                                   u8 revision)
>  {
> +       struct acpi_pptt_cache_v1* found_cache_v1;
> +
>         this_leaf->fw_token = cpu_node;
>         if (found_cache->flags & ACPI_PPTT_SIZE_PROPERTY_VALID)
>                 this_leaf->size = found_cache->size;
> @@ -405,6 +409,13 @@ static void update_cache_properties(struct cacheinfo *this_leaf,
>         if (this_leaf->type == CACHE_TYPE_NOCACHE &&
>             found_cache->flags & ACPI_PPTT_CACHE_TYPE_VALID)
>                 this_leaf->type = CACHE_TYPE_UNIFIED;
> +
> +       if (revision >= 3 && (found_cache->flags & ACPI_PPTT_CACHE_ID_VALID)) {
> +               found_cache_v1 = ACPI_ADD_PTR(struct acpi_pptt_cache_v1,
> +                                             found_cache, sizeof(struct acpi_pptt_cache));
> +               this_leaf->id = found_cache_v1->cache_id;
> +               this_leaf->attributes |= CACHE_ID;
> +       }
>  }
>
>  static void cache_setup_acpi_cpu(struct acpi_table_header *table,
> @@ -425,9 +436,8 @@ static void cache_setup_acpi_cpu(struct acpi_table_header *table,
>                                                    &cpu_node);
>                 pr_debug("found = %p %p\n", found_cache, cpu_node);
>                 if (found_cache)
> -                       update_cache_properties(this_leaf,
> -                                               found_cache,
> -                                               cpu_node);
> +                       update_cache_properties(this_leaf, found_cache,
> +                                               cpu_node, table->revision);
>
>                 index++;
>         }
> --

Applied as 5.14 material with some edits in the subject and changelog, thanks!
