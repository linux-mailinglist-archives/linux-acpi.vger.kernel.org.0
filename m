Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A02B273A207
	for <lists+linux-acpi@lfdr.de>; Thu, 22 Jun 2023 15:40:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230195AbjFVNka (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 22 Jun 2023 09:40:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229765AbjFVNka (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 22 Jun 2023 09:40:30 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3C611997;
        Thu, 22 Jun 2023 06:40:26 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Qn1dh5x4Pz67GBK;
        Thu, 22 Jun 2023 21:37:44 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 22 Jun
 2023 14:40:24 +0100
Date:   Thu, 22 Jun 2023 14:40:23 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Dave Jiang <dave.jiang@intel.com>
CC:     <linux-acpi@vger.kernel.org>, <linux-cxl@vger.kernel.org>,
        <rafael@kernel.org>, <lenb@kernel.org>, <dan.j.williams@intel.com>,
        <ira.weiny@intel.com>, <vishal.l.verma@intel.com>,
        <alison.schofield@intel.com>, <lukas@wunner.de>
Subject: Re: [PATCH v3 4/6] acpi: Break out nesting for
 hmat_parse_locality()
Message-ID: <20230622144023.000053f8@Huawei.com>
In-Reply-To: <168686424781.2950427.15323220900348586144.stgit@djiang5-mobl3>
References: <168686408822.2950427.16242077816997472103.stgit@djiang5-mobl3>
        <168686424781.2950427.15323220900348586144.stgit@djiang5-mobl3>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml500006.china.huawei.com (7.191.161.198) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, 15 Jun 2023 14:24:07 -0700
Dave Jiang <dave.jiang@intel.com> wrote:

> Refactor hmat_parse_locality() to break up the deep nesting of the
> function.
> 
> Suggested-by: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
>  drivers/acpi/numa/hmat.c |   32 ++++++++++++++++++++------------
>  1 file changed, 20 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/acpi/numa/hmat.c b/drivers/acpi/numa/hmat.c
> index e2ab1cce0add..cb240f5233fe 100644
> --- a/drivers/acpi/numa/hmat.c
> +++ b/drivers/acpi/numa/hmat.c
> @@ -320,11 +320,28 @@ static __init void hmat_add_locality(struct acpi_hmat_locality *hmat_loc)
>  	}
>  }
>  
> +static __init void hmat_update_target(unsigned int tgt_pxm, unsigned int init_pxm,
> +				      u8 mem_hier, u8 type, u32 value)
> +{
> +	struct memory_target *target = find_mem_target(tgt_pxm);
> +
> +	if (mem_hier != ACPI_HMAT_MEMORY)
> +		return;
> +
> +	if (target && target->processor_pxm == init_pxm) {
> +		hmat_update_target_access(target, type, value,
> +					  NODE_ACCESS_CLASS_0);
> +		/* If the node has a CPU, update access 1 */
> +		if (node_state(pxm_to_node(init_pxm), N_CPU))
> +			hmat_update_target_access(target, type, value,
> +						  NODE_ACCESS_CLASS_1);
> +	}
> +}
> +
>  static __init int hmat_parse_locality(union acpi_subtable_headers *header,
>  				      const unsigned long end)
>  {
>  	struct acpi_hmat_locality *hmat_loc = (void *)header;
> -	struct memory_target *target;
>  	unsigned int init, targ, total_size, ipds, tpds;
>  	u32 *inits, *targs, value;
>  	u16 *entries;
> @@ -365,17 +382,8 @@ static __init int hmat_parse_locality(union acpi_subtable_headers *header,
>  				inits[init], targs[targ], value,
>  				hmat_data_type_suffix(type));
>  
> -			if (mem_hier == ACPI_HMAT_MEMORY) {
> -				target = find_mem_target(targs[targ]);
> -				if (target && target->processor_pxm == inits[init]) {
> -					hmat_update_target_access(target, type, value,
> -								  NODE_ACCESS_CLASS_0);
> -					/* If the node has a CPU, update access 1 */
> -					if (node_state(pxm_to_node(inits[init]), N_CPU))
> -						hmat_update_target_access(target, type, value,
> -									  NODE_ACCESS_CLASS_1);
> -				}
> -			}
> +			hmat_update_target(targs[targ], inits[init],
> +					   mem_hier, type, value);
>  		}
>  	}
>  
> 
> 
> 

