Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EB8B8EF279
	for <lists+linux-acpi@lfdr.de>; Tue,  5 Nov 2019 02:16:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729597AbfKEBQS (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 4 Nov 2019 20:16:18 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:6148 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728602AbfKEBQS (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 4 Nov 2019 20:16:18 -0500
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 441E688D144ABCB71E8E;
        Tue,  5 Nov 2019 09:16:16 +0800 (CST)
Received: from [127.0.0.1] (10.177.223.23) by DGGEMS409-HUB.china.huawei.com
 (10.3.19.209) with Microsoft SMTP Server id 14.3.439.0; Tue, 5 Nov 2019
 09:16:06 +0800
Subject: Re: [PATCH] ACPI/PPTT: fixed some parameter type is not right
To:     Tian Tao <tiantao6@huawei.com>, <rjw@rjwysocki.net>,
        <lenb@kernel.org>, <linux-acpi@vger.kernel.org>,
        <jonathan.cameron@huawei.com>
CC:     <linuxarm@huawei.com>
References: <1572916055-62477-1-git-send-email-tiantao6@huawei.com>
From:   Hanjun Guo <guohanjun@huawei.com>
Message-ID: <b4c4ba3a-b079-e276-f7bb-b91af7d95a7f@huawei.com>
Date:   Tue, 5 Nov 2019 09:15:30 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <1572916055-62477-1-git-send-email-tiantao6@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.223.23]
X-CFilter-Loop: Reflected
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 2019/11/5 9:07, Tian Tao wrote:
> acpi_find_cache_level with level parameter as a signed integer,
> is called by acpi_find_cache_node where the level parameter is unsigned.
> This in turn calls acpi_find_cache_level with the level parameter is
> signed.Make the type consistent as unsigned through all 3 calls.

I'm not against doing this, but it's not a big deal :)

Maybe send to upstream to see what's happening, Rafael is a nice guy.

Thanks
Hanjun
> 
> Signed-off-by: Tian Tao <tiantao6@huawei.com>
> ---
>  drivers/acpi/pptt.c | 32 +++++++++++++++++---------------
>  1 file changed, 17 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/acpi/pptt.c b/drivers/acpi/pptt.c
> index 5af1e9e..bbe9b7a 100644
> --- a/drivers/acpi/pptt.c
> +++ b/drivers/acpi/pptt.c
> @@ -98,11 +98,11 @@ static inline bool acpi_pptt_match_type(int table_type, int type)
>   *
>   * Return: The cache structure and the level we terminated with.
>   */
> -static int acpi_pptt_walk_cache(struct acpi_table_header *table_hdr,
> -				int local_level,
> -				struct acpi_subtable_header *res,
> -				struct acpi_pptt_cache **found,
> -				int level, int type)
> +static unsigned int acpi_pptt_walk_cache(struct acpi_table_header *table_hdr,
> +					 unsigned int local_level,
> +					 struct acpi_subtable_header *res,
> +					 struct acpi_pptt_cache **found,
> +					 unsigned int level, int type)
>  {
>  	struct acpi_pptt_cache *cache;
>  
> @@ -119,7 +119,7 @@ static int acpi_pptt_walk_cache(struct acpi_table_header *table_hdr,
>  			if (*found != NULL && cache != *found)
>  				pr_warn("Found duplicate cache level/type unable to determine uniqueness\n");
>  
> -			pr_debug("Found cache @ level %d\n", level);
> +			pr_debug("Found cache @ level %u\n", level);
>  			*found = cache;
>  			/*
>  			 * continue looking at this node's resource list
> @@ -132,16 +132,18 @@ static int acpi_pptt_walk_cache(struct acpi_table_header *table_hdr,
>  	return local_level;
>  }
>  
> -static struct acpi_pptt_cache *acpi_find_cache_level(struct acpi_table_header *table_hdr,
> -						     struct acpi_pptt_processor *cpu_node,
> -						     int *starting_level, int level,
> -						     int type)
> +static struct
> +acpi_pptt_cache *acpi_find_cache_level(struct acpi_table_header *table_hdr,
> +					struct acpi_pptt_processor *cpu_node,
> +					unsigned int *starting_level,
> +					unsigned int level,
> +					int type)
>  {
>  	struct acpi_subtable_header *res;
> -	int number_of_levels = *starting_level;
> +	unsigned int number_of_levels = *starting_level;
>  	int resource = 0;
>  	struct acpi_pptt_cache *ret = NULL;
> -	int local_level;
> +	unsigned int local_level;
>  
>  	/* walk down from processor node */
>  	while ((res = acpi_get_pptt_resource(table_hdr, cpu_node, resource))) {
> @@ -318,15 +320,15 @@ static u8 acpi_cache_type(enum cache_type type)
>  static struct acpi_pptt_cache *acpi_find_cache_node(struct acpi_table_header *table_hdr,
>  						    u32 acpi_cpu_id,
>  						    enum cache_type type,
> -						    int level,
> +						    unsigned int level,
>  						    struct acpi_pptt_processor **node)
>  {
> -	int total_levels = 0;
> +	unsigned int total_levels = 0;
>  	struct acpi_pptt_cache *found = NULL;
>  	struct acpi_pptt_processor *cpu_node;
>  	u8 acpi_type = acpi_cache_type(type);
>  
> -	pr_debug("Looking for CPU %d's level %d cache type %d\n",
> +	pr_debug("Looking for CPU %d's level %u cache type %d\n",
>  		 acpi_cpu_id, level, acpi_type);
>  
>  	cpu_node = acpi_find_processor_node(table_hdr, acpi_cpu_id);
> 

