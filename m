Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30E61700CFE
	for <lists+linux-acpi@lfdr.de>; Fri, 12 May 2023 18:26:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233864AbjELQ0F (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 12 May 2023 12:26:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235448AbjELQZ5 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 12 May 2023 12:25:57 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 351727EF5;
        Fri, 12 May 2023 09:25:44 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4QHvHT5Lb1z67cDZ;
        Sat, 13 May 2023 00:24:53 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Fri, 12 May
 2023 17:25:42 +0100
Date:   Fri, 12 May 2023 17:25:41 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Dave Jiang <dave.jiang@intel.com>
CC:     <linux-acpi@vger.kernel.org>, <linux-cxl@vger.kernel.org>,
        <rafael@kernel.org>, <lenb@kernel.org>, <dan.j.williams@intel.com>,
        <ira.weiny@intel.com>, <vishal.l.verma@intel.com>,
        <alison.schofield@intel.com>, <lukas@wunner.de>
Subject: Re: [PATCH 4/4] acpi: numa: Add helper function to retrieve the
 performance attributes
Message-ID: <20230512172541.00005669@Huawei.com>
In-Reply-To: <168333153420.2290593.8903766148018143689.stgit@djiang5-mobl3>
References: <168333141100.2290593.16294670316057617744.stgit@djiang5-mobl3>
        <168333153420.2290593.8903766148018143689.stgit@djiang5-mobl3>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml500001.china.huawei.com (7.191.163.213) To
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

On Fri, 05 May 2023 17:05:34 -0700
Dave Jiang <dave.jiang@intel.com> wrote:

> Add helper to retrieve the performance attributes based on the device
> handle.  The helper function is exported so the CXL driver can use that
> to acquire the performance data between the CPU and the CXL host bridge.
> 
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
Trivial comment inline. Otherwise LGTM

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
>  drivers/acpi/numa/hmat.c |   35 +++++++++++++++++++++++++++++++++++
>  include/linux/acpi.h     |    9 +++++++++
>  2 files changed, 44 insertions(+)
> 
> diff --git a/drivers/acpi/numa/hmat.c b/drivers/acpi/numa/hmat.c
> index 951579e903cf..73d716e6096e 100644
> --- a/drivers/acpi/numa/hmat.c
> +++ b/drivers/acpi/numa/hmat.c
> @@ -107,6 +107,41 @@ static struct memory_target *find_mem_target(unsigned int mem_pxm)
>  	return NULL;
>  }
>  
> +static struct memory_target *acpi_find_genport_target(u8 *device_handle)
> +{
> +	struct memory_target *target;
> +
> +	list_for_each_entry(target, &targets, node) {
> +		if (!strncmp(target->device_handle, device_handle,
> +			     ACPI_SRAT_DEVICE_HANDLE_SIZE))

Using this for something that isn't a string?
memcmp() ?

Mind you I'm not sure what the nameless author this code was doing
in packing the device handle as a u8 array rather than a union of the two
types it can contain.  They probably had a reason lost to the mists of time...

> +			return target;
> +	}
> +
> +	return NULL;
> +}
> +
> +/**
> + * acpi_get_genport_coordinates - Retrieve the access coordinates for a generic port
> + * @device_handle: Device handle string (ACPI or PCI) to match up to the gen port
> + * @coord: The access coordinates written back out for the generic port
> + *
> + * Return: 0 on success. Errno on failure.
> + */
> +int acpi_get_genport_coordinates(u8 *device_handle,
> +				 struct access_coordinate *coord)
> +{
> +	struct memory_target *target;
> +
> +	target = acpi_find_genport_target(device_handle);
> +	if (!target)
> +		return -ENOENT;
> +
> +	*coord = target->coord[NODE_ACCESS_CLASS_GENPORT];
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_NS_GPL(acpi_get_genport_coordinates, CXL);
> +
>  static __init void alloc_memory_initiator(unsigned int cpu_pxm)
>  {
>  	struct memory_initiator *initiator;
> diff --git a/include/linux/acpi.h b/include/linux/acpi.h
> index 4c3dfe7587e9..d6a99fa430dd 100644
> --- a/include/linux/acpi.h
> +++ b/include/linux/acpi.h
> @@ -15,6 +15,7 @@
>  #include <linux/device.h>
>  #include <linux/property.h>
>  #include <linux/uuid.h>
> +#include <linux/node.h>
>  
>  #ifndef _LINUX
>  #define _LINUX
> @@ -455,6 +456,8 @@ extern bool acpi_osi_is_win8(void);
>  #ifdef CONFIG_ACPI_NUMA
>  int acpi_map_pxm_to_node(int pxm);
>  int acpi_get_node(acpi_handle handle);
> +int acpi_get_genport_coordinates(u8 *device_handle,
> +				 struct access_coordinate *coord);
>  
>  /**
>   * pxm_to_online_node - Map proximity ID to online node
> @@ -489,6 +492,12 @@ static inline int acpi_get_node(acpi_handle handle)
>  {
>  	return 0;
>  }
> +
> +static inline int acpi_get_genport_coordinates(u8 *device_handle,
> +					       struct access_coordinate *coord)
> +{
> +	return -EOPNOTSUPP;
> +}
>  #endif
>  extern int acpi_paddr_to_node(u64 start_addr, u64 size);
>  
> 
> 

