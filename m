Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 13388F8B6E
	for <lists+linux-acpi@lfdr.de>; Tue, 12 Nov 2019 10:12:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725944AbfKLJMX (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 12 Nov 2019 04:12:23 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:51149 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725874AbfKLJMX (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 12 Nov 2019 04:12:23 -0500
Received: from 79.184.253.153.ipv4.supernova.orange.pl (79.184.253.153) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.292)
 id 669a6dc8760ddf50; Tue, 12 Nov 2019 10:12:19 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Tao Xu <tao3.xu@intel.com>
Cc:     rafael.j.wysocki@intel.com, lenb@kernel.org, keith.busch@intel.com,
        gregkh@linuxfoundation.org, dan.j.williams@intel.com,
        dave.hansen@linux.intel.com, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jingqi Liu <Jingqi.liu@intel.com>
Subject: Re: [PATCH] ACPI/HMAT: use %u instead of %d to print u32 variables
Date:   Tue, 12 Nov 2019 10:12:19 +0100
Message-ID: <1931451.zuokRdAxLL@kreacher>
In-Reply-To: <20191030063403.20128-1-tao3.xu@intel.com>
References: <20191030063403.20128-1-tao3.xu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wednesday, October 30, 2019 7:34:03 AM CET Tao Xu wrote:
> Use %u instead of %d to print u32 variables to expand the value range,
> especially when latency or bandwidth value is bigger than INT_MAX.
> Then HMAT latency can support up to 4.29s and bandwidth can support
> up to 4PB/s.
> 
> Reviewed-by: Dan Williams <dan.j.williams@intel.com>
> Reviewed-by: Jingqi Liu <Jingqi.liu@intel.com>
> Signed-off-by: Tao Xu <tao3.xu@intel.com>
> ---
> 
> This patch is based on:
> EFI Specific Purpose Memory Support,
> https://lore.kernel.org/patchwork/cover/1139858/
> ---
>  drivers/acpi/numa/hmat.c | 18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/acpi/numa/hmat.c b/drivers/acpi/numa/hmat.c
> index 1ce366a7bc55..f96e443990c1 100644
> --- a/drivers/acpi/numa/hmat.c
> +++ b/drivers/acpi/numa/hmat.c
> @@ -293,7 +293,7 @@ static __init int hmat_parse_locality(union acpi_subtable_headers *header,
>  	u8 type, mem_hier;
>  
>  	if (hmat_loc->header.length < sizeof(*hmat_loc)) {
> -		pr_notice("HMAT: Unexpected locality header length: %d\n",
> +		pr_notice("HMAT: Unexpected locality header length: %u\n",
>  			 hmat_loc->header.length);
>  		return -EINVAL;
>  	}
> @@ -305,12 +305,12 @@ static __init int hmat_parse_locality(union acpi_subtable_headers *header,
>  	total_size = sizeof(*hmat_loc) + sizeof(*entries) * ipds * tpds +
>  		     sizeof(*inits) * ipds + sizeof(*targs) * tpds;
>  	if (hmat_loc->header.length < total_size) {
> -		pr_notice("HMAT: Unexpected locality header length:%d, minimum required:%d\n",
> +		pr_notice("HMAT: Unexpected locality header length:%u, minimum required:%u\n",
>  			 hmat_loc->header.length, total_size);
>  		return -EINVAL;
>  	}
>  
> -	pr_info("HMAT: Locality: Flags:%02x Type:%s Initiator Domains:%d Target Domains:%d Base:%lld\n",
> +	pr_info("HMAT: Locality: Flags:%02x Type:%s Initiator Domains:%u Target Domains:%u Base:%lld\n",
>  		hmat_loc->flags, hmat_data_type(type), ipds, tpds,
>  		hmat_loc->entry_base_unit);
>  
> @@ -323,7 +323,7 @@ static __init int hmat_parse_locality(union acpi_subtable_headers *header,
>  			value = hmat_normalize(entries[init * tpds + targ],
>  					       hmat_loc->entry_base_unit,
>  					       type);
> -			pr_info("  Initiator-Target[%d-%d]:%d%s\n",
> +			pr_info("  Initiator-Target[%u-%u]:%u%s\n",
>  				inits[init], targs[targ], value,
>  				hmat_data_type_suffix(type));
>  
> @@ -350,13 +350,13 @@ static __init int hmat_parse_cache(union acpi_subtable_headers *header,
>  	u32 attrs;
>  
>  	if (cache->header.length < sizeof(*cache)) {
> -		pr_notice("HMAT: Unexpected cache header length: %d\n",
> +		pr_notice("HMAT: Unexpected cache header length: %u\n",
>  			 cache->header.length);
>  		return -EINVAL;
>  	}
>  
>  	attrs = cache->cache_attributes;
> -	pr_info("HMAT: Cache: Domain:%d Size:%llu Attrs:%08x SMBIOS Handles:%d\n",
> +	pr_info("HMAT: Cache: Domain:%u Size:%llu Attrs:%08x SMBIOS Handles:%d\n",
>  		cache->memory_PD, cache->cache_size, attrs,
>  		cache->number_of_SMBIOShandles);
>  
> @@ -411,17 +411,17 @@ static int __init hmat_parse_proximity_domain(union acpi_subtable_headers *heade
>  	struct memory_target *target = NULL;
>  
>  	if (p->header.length != sizeof(*p)) {
> -		pr_notice("HMAT: Unexpected address range header length: %d\n",
> +		pr_notice("HMAT: Unexpected address range header length: %u\n",
>  			 p->header.length);
>  		return -EINVAL;
>  	}
>  
>  	if (hmat_revision == 1)
> -		pr_info("HMAT: Memory (%#llx length %#llx) Flags:%04x Processor Domain:%d Memory Domain:%d\n",
> +		pr_info("HMAT: Memory (%#llx length %#llx) Flags:%04x Processor Domain:%u Memory Domain:%u\n",
>  			p->reserved3, p->reserved4, p->flags, p->processor_PD,
>  			p->memory_PD);
>  	else
> -		pr_info("HMAT: Memory Flags:%04x Processor Domain:%d Memory Domain:%d\n",
> +		pr_info("HMAT: Memory Flags:%04x Processor Domain:%u Memory Domain:%u\n",
>  			p->flags, p->processor_PD, p->memory_PD);
>  
>  	if (p->flags & ACPI_HMAT_MEMORY_PD_VALID && hmat_revision == 1) {
> 

Applying as 5.5 material with minor modifications of the subject and
changelog, thanks!



