Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0B1281167A6
	for <lists+linux-acpi@lfdr.de>; Mon,  9 Dec 2019 08:43:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727122AbfLIHnX (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 9 Dec 2019 02:43:23 -0500
Received: from mga05.intel.com ([192.55.52.43]:34353 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727115AbfLIHnX (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 9 Dec 2019 02:43:23 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Dec 2019 23:43:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,294,1571727600"; 
   d="scan'208";a="237660470"
Received: from txu2-mobl.ccr.corp.intel.com (HELO [10.239.197.115]) ([10.239.197.115])
  by fmsmga004.fm.intel.com with ESMTP; 08 Dec 2019 23:43:21 -0800
Subject: Re: [PATCH] ACPI/HMAT: Fix the parsing of Cache Associativity and
 Write Policy
To:     rafael.j.wysocki@intel.com, lenb@kernel.org, keith.busch@intel.com,
        gregkh@linuxfoundation.org, dan.j.williams@intel.com,
        dave.hansen@linux.intel.com
Cc:     linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20191202070348.32148-1-tao3.xu@intel.com>
From:   Tao Xu <tao3.xu@intel.com>
Message-ID: <5cb15538-7097-1aa1-00a1-ce21c086c13b@intel.com>
Date:   Mon, 9 Dec 2019 15:43:21 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <20191202070348.32148-1-tao3.xu@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Gentle ping :)

On 12/2/2019 3:03 PM, Tao Xu wrote:
> In chapter 5.2.27.5, Table 5-147: Field "Cache Attributes" of
> ACPI 6.3 spec: 0 is "None", 1 is "Direct Mapped", 2 is "Complex Cache
> Indexing" for Cache Associativity; 0 is "None", 1 is "Write Back",
> 2 is "Write Through" for Write Policy.
> 
> Signed-off-by: Tao Xu <tao3.xu@intel.com>
> ---
>   drivers/acpi/numa/hmat.c | 4 ++--
>   include/linux/node.h     | 4 ++--
>   2 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/acpi/numa/hmat.c b/drivers/acpi/numa/hmat.c
> index 2c32cfb72370..719d0279563d 100644
> --- a/drivers/acpi/numa/hmat.c
> +++ b/drivers/acpi/numa/hmat.c
> @@ -383,7 +383,7 @@ static __init int hmat_parse_cache(union acpi_subtable_headers *header,
>   		break;
>   	case ACPI_HMAT_CA_NONE:
>   	default:
> -		tcache->cache_attrs.indexing = NODE_CACHE_OTHER;
> +		tcache->cache_attrs.indexing = NODE_CACHE_NONE;
>   		break;
>   	}
>   
> @@ -396,7 +396,7 @@ static __init int hmat_parse_cache(union acpi_subtable_headers *header,
>   		break;
>   	case ACPI_HMAT_CP_NONE:
>   	default:
> -		tcache->cache_attrs.write_policy = NODE_CACHE_WRITE_OTHER;
> +		tcache->cache_attrs.write_policy = NODE_CACHE_WRITE_NONE;
>   		break;
>   	}
>   	list_add_tail(&tcache->node, &target->caches);
> diff --git a/include/linux/node.h b/include/linux/node.h
> index 4866f32a02d8..6dbd764d09ce 100644
> --- a/include/linux/node.h
> +++ b/include/linux/node.h
> @@ -36,15 +36,15 @@ struct node_hmem_attrs {
>   };
>   
>   enum cache_indexing {
> +	NODE_CACHE_NONE,
>   	NODE_CACHE_DIRECT_MAP,
>   	NODE_CACHE_INDEXED,
> -	NODE_CACHE_OTHER,
>   };
>   
>   enum cache_write_policy {
> +	NODE_CACHE_WRITE_NONE,
>   	NODE_CACHE_WRITE_BACK,
>   	NODE_CACHE_WRITE_THROUGH,
> -	NODE_CACHE_WRITE_OTHER,
>   };
>   
>   /**
> 

