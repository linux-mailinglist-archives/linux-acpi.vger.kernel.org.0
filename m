Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7F1C113241E
	for <lists+linux-acpi@lfdr.de>; Tue,  7 Jan 2020 11:48:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727658AbgAGKsy (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 7 Jan 2020 05:48:54 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:34351 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727589AbgAGKsy (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 7 Jan 2020 05:48:54 -0500
Received: by mail-ot1-f67.google.com with SMTP id a15so75887497otf.1;
        Tue, 07 Jan 2020 02:48:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WSE97IsDt/0HNGDotMlpkWXy8wGljVOzhB0c9xp6lOQ=;
        b=CgClBwzsglgCjFH7jdg5jX6oBmETH6CNZ+GEj6qCjKg+S5IT1Y7/ib8cFQIieikey8
         pJX+0w5gNhGki9gAyOlAtF4nSXqvDuYEbY8EAJt1giRo6Em89z0g4ikRH5FqW7HUiMSt
         tYmlFjowoStg++ONMkxW13NmKpjlfLPlwZlQTZDblo2N18J1cGPWwtvwbthYnvSooeNd
         U9xF+uuecSgLhbG0Scse1mLLoIzOTMg8xhxoTbxLVU23h/IzyR0aKpAClmTJbSQ3iE2N
         bLLfcOum6ZnYbPrIGEEbNfQganFapm+rjJWEl1LShpTUdmOkWsGKu05e1MMTqU15BBtS
         r8YA==
X-Gm-Message-State: APjAAAXwLPUnrJe/Hz1ggf/PN2dwevoBs2tz72bSDLKiHts7mYIjxCGK
        JEEcgu45Y8t2b8bxc7irjAV1m8zRXrnnvkGPkIY=
X-Google-Smtp-Source: APXvYqyb909xw3pW97wWn1+hEZa4V25wQcI/pM8kvkSjy7tVft8dVm7RxOov26ChMbLWIGhx807LcgPTRqNHsWQ5k50=
X-Received: by 2002:a9d:7b4a:: with SMTP id f10mr12352350oto.4.1578394133504;
 Tue, 07 Jan 2020 02:48:53 -0800 (PST)
MIME-Version: 1.0
References: <1577706988-56848-1-git-send-email-wangxiongfeng2@huawei.com>
In-Reply-To: <1577706988-56848-1-git-send-email-wangxiongfeng2@huawei.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 7 Jan 2020 11:48:42 +0100
Message-ID: <CAJZ5v0gN4A+eRtebxY=8DYfFiRE7FWO_3=a4m9G1_sgUsGPBWA@mail.gmail.com>
Subject: Re: [PATCH v2] ACPI/PPTT: fixed some parameter type is not right
To:     Xiongfeng Wang <wangxiongfeng2@huawei.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        tiantao <tiantao6@huawei.com>,
        Jonathan Cameron <jonathan.cameron@huawei.com>,
        Hanjun Guo <guohanjun@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, Dec 30, 2019 at 1:01 PM Xiongfeng Wang
<wangxiongfeng2@huawei.com> wrote:
>
> From: Tian Tao <tiantao6@huawei.com>
>
> The fourth parameter 'level' of function 'acpi_find_cache_level()' is a
> signed interger, but its caller 'acpi_find_cache_node()' passes that
> parameter an unsigned interger. This patch fixes the paramter type
> inconsistency.
>
> Signed-off-by: Tian Tao <tiantao6@huawei.com>
> Signed-off-by: Xiongfeng Wang <wangxiongfeng2@huawei.com>
>
> ---
> v2:     fix the conflicts in the third hunk.
>         Modify the commit information a little bit.
> ---
>  drivers/acpi/pptt.c | 29 +++++++++++++++--------------
>  1 file changed, 15 insertions(+), 14 deletions(-)
>
> diff --git a/drivers/acpi/pptt.c b/drivers/acpi/pptt.c
> index f31544d..4ae9335 100644
> --- a/drivers/acpi/pptt.c
> +++ b/drivers/acpi/pptt.c
> @@ -98,11 +98,11 @@ static inline bool acpi_pptt_match_type(int table_type, int type)
>   *
>   * Return: The cache structure and the level we terminated with.
>   */
> -static int acpi_pptt_walk_cache(struct acpi_table_header *table_hdr,
> -                               int local_level,
> -                               struct acpi_subtable_header *res,
> -                               struct acpi_pptt_cache **found,
> -                               int level, int type)
> +static unsigned int acpi_pptt_walk_cache(struct acpi_table_header *table_hdr,
> +                                        unsigned int local_level,
> +                                        struct acpi_subtable_header *res,
> +                                        struct acpi_pptt_cache **found,
> +                                        unsigned int level, int type)
>  {
>         struct acpi_pptt_cache *cache;
>
> @@ -119,7 +119,7 @@ static int acpi_pptt_walk_cache(struct acpi_table_header *table_hdr,
>                         if (*found != NULL && cache != *found)
>                                 pr_warn("Found duplicate cache level/type unable to determine uniqueness\n");
>
> -                       pr_debug("Found cache @ level %d\n", level);
> +                       pr_debug("Found cache @ level %u\n", level);
>                         *found = cache;
>                         /*
>                          * continue looking at this node's resource list
> @@ -132,16 +132,17 @@ static int acpi_pptt_walk_cache(struct acpi_table_header *table_hdr,
>         return local_level;
>  }
>
> -static struct acpi_pptt_cache *acpi_find_cache_level(struct acpi_table_header *table_hdr,
> -                                                    struct acpi_pptt_processor *cpu_node,
> -                                                    int *starting_level, int level,
> -                                                    int type)
> +static struct acpi_pptt_cache *
> +acpi_find_cache_level(struct acpi_table_header *table_hdr,
> +                     struct acpi_pptt_processor *cpu_node,
> +                     unsigned int *starting_level, unsigned int level,
> +                     int type)
>  {
>         struct acpi_subtable_header *res;
> -       int number_of_levels = *starting_level;
> +       unsigned int number_of_levels = *starting_level;
>         int resource = 0;
>         struct acpi_pptt_cache *ret = NULL;
> -       int local_level;
> +       unsigned int local_level;
>
>         /* walk down from processor node */
>         while ((res = acpi_get_pptt_resource(table_hdr, cpu_node, resource))) {
> @@ -321,12 +322,12 @@ static struct acpi_pptt_cache *acpi_find_cache_node(struct acpi_table_header *ta
>                                                     unsigned int level,
>                                                     struct acpi_pptt_processor **node)
>  {
> -       int total_levels = 0;
> +       unsigned int total_levels = 0;
>         struct acpi_pptt_cache *found = NULL;
>         struct acpi_pptt_processor *cpu_node;
>         u8 acpi_type = acpi_cache_type(type);
>
> -       pr_debug("Looking for CPU %d's level %d cache type %d\n",
> +       pr_debug("Looking for CPU %d's level %u cache type %d\n",
>                  acpi_cpu_id, level, acpi_type);
>
>         cpu_node = acpi_find_processor_node(table_hdr, acpi_cpu_id);
> --

Applied for 5.6 as "ACPI: PPTT: Consistently use unsigned int as
parameter type" with some minor changes in the changelog.

Thanks!
