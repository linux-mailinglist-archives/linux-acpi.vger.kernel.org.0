Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5F0BEFBC8A
	for <lists+linux-acpi@lfdr.de>; Thu, 14 Nov 2019 00:25:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726303AbfKMXZu (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 13 Nov 2019 18:25:50 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:49649 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727004AbfKMXZt (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 13 Nov 2019 18:25:49 -0500
Received: from 79.184.253.153.ipv4.supernova.orange.pl (79.184.253.153) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.292)
 id 6d7fe1fb416dddba; Thu, 14 Nov 2019 00:25:46 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Tian Tao <tiantao6@huawei.com>
Cc:     lenb@kernel.org, linux-acpi@vger.kernel.org,
        jonathan.cameron@huawei.com, linuxarm@huawei.com
Subject: Re: [PATCH] ACPI/PPTT: fixed some parameter type is not right
Date:   Thu, 14 Nov 2019 00:25:45 +0100
Message-ID: <1714500.3x5i8LQbYU@kreacher>
In-Reply-To: <1572916055-62477-1-git-send-email-tiantao6@huawei.com>
References: <1572916055-62477-1-git-send-email-tiantao6@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tuesday, November 5, 2019 2:07:35 AM CET Tian Tao wrote:
> acpi_find_cache_level with level parameter as a signed integer,
> is called by acpi_find_cache_node where the level parameter is unsigned.
> This in turn calls acpi_find_cache_level with the level parameter is
> signed.Make the type consistent as unsigned through all 3 calls.
> 
> Signed-off-by: Tian Tao <tiantao6@huawei.com>

Well, it is good to be consistent in general, but the patch doesn't apply
(because of the last hunk) and the changelog is incorrect AFAICS.

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




