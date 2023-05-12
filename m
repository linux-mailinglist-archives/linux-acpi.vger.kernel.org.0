Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F588700C25
	for <lists+linux-acpi@lfdr.de>; Fri, 12 May 2023 17:43:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241985AbjELPnj (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 12 May 2023 11:43:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241987AbjELPni (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 12 May 2023 11:43:38 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 558365B83;
        Fri, 12 May 2023 08:43:36 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4QHtKq4RC8z67jMp;
        Fri, 12 May 2023 23:41:51 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Fri, 12 May
 2023 16:43:33 +0100
Date:   Fri, 12 May 2023 16:43:32 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Dave Jiang <dave.jiang@intel.com>
CC:     <linux-acpi@vger.kernel.org>, <linux-cxl@vger.kernel.org>,
        <rafael@kernel.org>, <lenb@kernel.org>, <dan.j.williams@intel.com>,
        <ira.weiny@intel.com>, <vishal.l.verma@intel.com>,
        <alison.schofield@intel.com>, <lukas@wunner.de>
Subject: Re: [PATCH 1/4] acpi: numa: Create enum for memory_target access
 coordinates indexing
Message-ID: <20230512164332.00002171@Huawei.com>
In-Reply-To: <168333151653.2290593.15815859836381468990.stgit@djiang5-mobl3>
References: <168333141100.2290593.16294670316057617744.stgit@djiang5-mobl3>
        <168333151653.2290593.15815859836381468990.stgit@djiang5-mobl3>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml100005.china.huawei.com (7.191.160.25) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, 05 May 2023 17:05:16 -0700
Dave Jiang <dave.jiang@intel.com> wrote:

> Create enums to provide named indexing for the access coordinate array.
> This is in preparation for adding generic port support which will add a
> third index in the array to keep the generic port attributes separate from
> the memory attributes.
> 
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>



> ---
>  drivers/acpi/numa/hmat.c |   35 ++++++++++++++++++++++++-----------
>  1 file changed, 24 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/acpi/numa/hmat.c b/drivers/acpi/numa/hmat.c
> index f9ff992038fa..abed728bf09d 100644
> --- a/drivers/acpi/numa/hmat.c
> +++ b/drivers/acpi/numa/hmat.c
> @@ -57,12 +57,18 @@ struct target_cache {
>  	struct node_cache_attrs cache_attrs;
>  };
>  
> +enum {
> +	NODE_ACCESS_CLASS_0 = 0,
> +	NODE_ACCESS_CLASS_1,
> +	NODE_ACCESS_CLASS_MAX,
> +};
> +
>  struct memory_target {
>  	struct list_head node;
>  	unsigned int memory_pxm;
>  	unsigned int processor_pxm;
>  	struct resource memregions;
> -	struct access_coordinate coord[2];
> +	struct access_coordinate coord[NODE_ACCESS_CLASS_MAX];
>  	struct list_head caches;
>  	struct node_cache_attrs cache_attrs;
>  	bool registered;
> @@ -338,10 +344,12 @@ static __init int hmat_parse_locality(union acpi_subtable_headers *header,
>  			if (mem_hier == ACPI_HMAT_MEMORY) {
>  				target = find_mem_target(targs[targ]);
>  				if (target && target->processor_pxm == inits[init]) {
> -					hmat_update_target_access(target, type, value, 0);
> +					hmat_update_target_access(target, type, value,
> +								  NODE_ACCESS_CLASS_0);
>  					/* If the node has a CPU, update access 1 */
>  					if (node_state(pxm_to_node(inits[init]), N_CPU))
> -						hmat_update_target_access(target, type, value, 1);
> +						hmat_update_target_access(target, type, value,
> +									  NODE_ACCESS_CLASS_1);
>  				}
>  			}
>  		}
> @@ -600,10 +608,12 @@ static void hmat_register_target_initiators(struct memory_target *target)
>  	 */
>  	if (target->processor_pxm != PXM_INVAL) {
>  		cpu_nid = pxm_to_node(target->processor_pxm);
> -		register_memory_node_under_compute_node(mem_nid, cpu_nid, 0);
> +		register_memory_node_under_compute_node(mem_nid, cpu_nid,
> +							NODE_ACCESS_CLASS_0);
>  		access0done = true;
>  		if (node_state(cpu_nid, N_CPU)) {
> -			register_memory_node_under_compute_node(mem_nid, cpu_nid, 1);
> +			register_memory_node_under_compute_node(mem_nid, cpu_nid,
> +								NODE_ACCESS_CLASS_1);
>  			return;
>  		}
>  	}
> @@ -644,12 +654,13 @@ static void hmat_register_target_initiators(struct memory_target *target)
>  			}
>  			if (best)
>  				hmat_update_target_access(target, loc->hmat_loc->data_type,
> -							  best, 0);
> +							  best, NODE_ACCESS_CLASS_0);
>  		}
>  
>  		for_each_set_bit(i, p_nodes, MAX_NUMNODES) {
>  			cpu_nid = pxm_to_node(i);
> -			register_memory_node_under_compute_node(mem_nid, cpu_nid, 0);
> +			register_memory_node_under_compute_node(mem_nid, cpu_nid,
> +								NODE_ACCESS_CLASS_0);
>  		}
>  	}
>  
> @@ -681,11 +692,13 @@ static void hmat_register_target_initiators(struct memory_target *target)
>  				clear_bit(initiator->processor_pxm, p_nodes);
>  		}
>  		if (best)
> -			hmat_update_target_access(target, loc->hmat_loc->data_type, best, 1);
> +			hmat_update_target_access(target, loc->hmat_loc->data_type, best,
> +						  NODE_ACCESS_CLASS_1);
>  	}
>  	for_each_set_bit(i, p_nodes, MAX_NUMNODES) {
>  		cpu_nid = pxm_to_node(i);
> -		register_memory_node_under_compute_node(mem_nid, cpu_nid, 1);
> +		register_memory_node_under_compute_node(mem_nid, cpu_nid,
> +							NODE_ACCESS_CLASS_1);
>  	}
>  }
>  
> @@ -746,8 +759,8 @@ static void hmat_register_target(struct memory_target *target)
>  	if (!target->registered) {
>  		hmat_register_target_initiators(target);
>  		hmat_register_target_cache(target);
> -		hmat_register_target_perf(target, 0);
> -		hmat_register_target_perf(target, 1);
> +		hmat_register_target_perf(target, NODE_ACCESS_CLASS_0);
> +		hmat_register_target_perf(target, NODE_ACCESS_CLASS_1);
>  		target->registered = true;
>  	}
>  	mutex_unlock(&target_lock);
> 
> 

