Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCF3173A21D
	for <lists+linux-acpi@lfdr.de>; Thu, 22 Jun 2023 15:45:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229889AbjFVNpX (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 22 Jun 2023 09:45:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230433AbjFVNpQ (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 22 Jun 2023 09:45:16 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DB081735;
        Thu, 22 Jun 2023 06:45:15 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Qn1l85Zplz67VcY;
        Thu, 22 Jun 2023 21:42:28 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 22 Jun
 2023 14:45:12 +0100
Date:   Thu, 22 Jun 2023 14:45:11 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Dave Jiang <dave.jiang@intel.com>
CC:     <linux-acpi@vger.kernel.org>, <linux-cxl@vger.kernel.org>,
        <rafael@kernel.org>, <lenb@kernel.org>, <dan.j.williams@intel.com>,
        <ira.weiny@intel.com>, <vishal.l.verma@intel.com>,
        <alison.schofield@intel.com>, <lukas@wunner.de>
Subject: Re: [PATCH v3 3/6] acpi: numa: Add genport target allocation to the
 HMAT parsing
Message-ID: <20230622144511.0000319d@Huawei.com>
In-Reply-To: <168686424175.2950427.1861604402516465647.stgit@djiang5-mobl3>
References: <168686408822.2950427.16242077816997472103.stgit@djiang5-mobl3>
        <168686424175.2950427.1861604402516465647.stgit@djiang5-mobl3>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml500003.china.huawei.com (7.191.162.67) To
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

On Thu, 15 Jun 2023 14:24:01 -0700
Dave Jiang <dave.jiang@intel.com> wrote:

> Add SRAT parsing for the HMAT init in order to collect the device handle
> from the Generic Port Affinity Structure. The device handle will serve as
> the key to search for target data.
> 
> Consoliate the common code with alloc_memory_target() in a helper function
> alloc_target().
> 
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> 

On second thoughts - device_handle is rather cryptic as a name
and there are no handy comments on what it is.
Can we call it gen_port_device_handle or something like that?


> ---
> v3:
> - Move ACPI_SRAT_DEVICE_HANDLE_SIZE to separate patch for ACPICA
> ---
>  drivers/acpi/numa/hmat.c |   53 +++++++++++++++++++++++++++++++++++++++++++---
>  1 file changed, 50 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/acpi/numa/hmat.c b/drivers/acpi/numa/hmat.c
> index abed728bf09d..e2ab1cce0add 100644
> --- a/drivers/acpi/numa/hmat.c
> +++ b/drivers/acpi/numa/hmat.c
> @@ -71,6 +71,7 @@ struct memory_target {
>  	struct access_coordinate coord[NODE_ACCESS_CLASS_MAX];
>  	struct list_head caches;
>  	struct node_cache_attrs cache_attrs;
> +	u8 device_handle[ACPI_SRAT_DEVICE_HANDLE_SIZE];
>  	bool registered;
>  };
>  
> @@ -125,8 +126,7 @@ static __init void alloc_memory_initiator(unsigned int cpu_pxm)
>  	list_add_tail(&initiator->node, &initiators);
>  }
>  
> -static __init void alloc_memory_target(unsigned int mem_pxm,
> -		resource_size_t start, resource_size_t len)
> +static __init struct memory_target *alloc_target(unsigned int mem_pxm)
>  {
>  	struct memory_target *target;
>  
> @@ -134,7 +134,7 @@ static __init void alloc_memory_target(unsigned int mem_pxm,
>  	if (!target) {
>  		target = kzalloc(sizeof(*target), GFP_KERNEL);
>  		if (!target)
> -			return;
> +			return NULL;
>  		target->memory_pxm = mem_pxm;
>  		target->processor_pxm = PXM_INVAL;
>  		target->memregions = (struct resource) {
> @@ -147,6 +147,19 @@ static __init void alloc_memory_target(unsigned int mem_pxm,
>  		INIT_LIST_HEAD(&target->caches);
>  	}
>  
> +	return target;
> +}
> +
> +static __init void alloc_memory_target(unsigned int mem_pxm,
> +				       resource_size_t start,
> +				       resource_size_t len)
> +{
> +	struct memory_target *target;
> +
> +	target = alloc_target(mem_pxm);
> +	if (!target)
> +		return;
> +
>  	/*
>  	 * There are potentially multiple ranges per PXM, so record each
>  	 * in the per-target memregions resource tree.
> @@ -157,6 +170,17 @@ static __init void alloc_memory_target(unsigned int mem_pxm,
>  				start, start + len, mem_pxm);
>  }
>  
> +static __init void alloc_genport_target(unsigned int mem_pxm, u8 *handle)
> +{
> +	struct memory_target *target;
> +
> +	target = alloc_target(mem_pxm);
> +	if (!target)
> +		return;
> +
> +	memcpy(target->device_handle, handle, ACPI_SRAT_DEVICE_HANDLE_SIZE);
> +}
> +
>  static __init const char *hmat_data_type(u8 type)
>  {
>  	switch (type) {
> @@ -498,6 +522,22 @@ static __init int srat_parse_mem_affinity(union acpi_subtable_headers *header,
>  	return 0;
>  }
>  
> +static __init int srat_parse_genport_affinity(union acpi_subtable_headers *header,
> +					      const unsigned long end)
> +{
> +	struct acpi_srat_generic_affinity *ga = (void *)header;
> +
> +	if (!ga)
> +		return -EINVAL;
> +
> +	if (!(ga->flags & ACPI_SRAT_GENERIC_AFFINITY_ENABLED))
> +		return 0;
> +
> +	alloc_genport_target(ga->proximity_domain, (u8 *)ga->device_handle);
> +
> +	return 0;
> +}
> +
>  static u32 hmat_initiator_perf(struct memory_target *target,
>  			       struct memory_initiator *initiator,
>  			       struct acpi_hmat_locality *hmat_loc)
> @@ -848,6 +888,13 @@ static __init int hmat_init(void)
>  				ACPI_SRAT_TYPE_MEMORY_AFFINITY,
>  				srat_parse_mem_affinity, 0) < 0)
>  		goto out_put;
> +
> +	if (acpi_table_parse_entries(ACPI_SIG_SRAT,
> +				     sizeof(struct acpi_table_srat),
> +				     ACPI_SRAT_TYPE_GENERIC_PORT_AFFINITY,
> +				     srat_parse_genport_affinity, 0) < 0)
> +		goto out_put;
> +
>  	acpi_put_table(tbl);
>  
>  	status = acpi_get_table(ACPI_SIG_HMAT, 0, &tbl);
> 
> 
> 

