Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21F5D700C9F
	for <lists+linux-acpi@lfdr.de>; Fri, 12 May 2023 18:10:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241469AbjELQKT (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 12 May 2023 12:10:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230453AbjELQKS (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 12 May 2023 12:10:18 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37F787EF5;
        Fri, 12 May 2023 09:10:09 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4QHtsr2Tffz6J72S;
        Sat, 13 May 2023 00:06:08 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Fri, 12 May
 2023 17:10:06 +0100
Date:   Fri, 12 May 2023 17:10:06 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Dave Jiang <dave.jiang@intel.com>
CC:     <linux-acpi@vger.kernel.org>, <linux-cxl@vger.kernel.org>,
        <rafael@kernel.org>, <lenb@kernel.org>, <dan.j.williams@intel.com>,
        <ira.weiny@intel.com>, <vishal.l.verma@intel.com>,
        <alison.schofield@intel.com>, <lukas@wunner.de>
Subject: Re: [PATCH 3/4] acpi: numa: Add setting of generic port system
 locality attributes
Message-ID: <20230512171006.00004515@Huawei.com>
In-Reply-To: <168333152832.2290593.17409054392013117865.stgit@djiang5-mobl3>
References: <168333141100.2290593.16294670316057617744.stgit@djiang5-mobl3>
        <168333152832.2290593.17409054392013117865.stgit@djiang5-mobl3>
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

On Fri, 05 May 2023 17:05:28 -0700
Dave Jiang <dave.jiang@intel.com> wrote:

> Add generic port support for the parsing of HMAT system locality sub-table.
> The attributes will be added to the third array member of the access
> coordinates in order to not mix with the existing memory attributes it only

attributes. It only ?
Otherwise I'm having trouble following that sentence.

> provides the system locality attributes from initator to the generic port
> targets and is missing the rest of the data to the actual memory device.
> 
> The complete attributes will be updated when a memory device is
> attached and the system locality information is calculated end to end.
> 
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> ---
>  drivers/acpi/numa/hmat.c |    7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/acpi/numa/hmat.c b/drivers/acpi/numa/hmat.c
> index e2ab1cce0add..951579e903cf 100644
> --- a/drivers/acpi/numa/hmat.c
> +++ b/drivers/acpi/numa/hmat.c
> @@ -60,6 +60,7 @@ struct target_cache {
>  enum {
>  	NODE_ACCESS_CLASS_0 = 0,
>  	NODE_ACCESS_CLASS_1,
> +	NODE_ACCESS_CLASS_GENPORT,
>  	NODE_ACCESS_CLASS_MAX,
>  };
>  
> @@ -368,6 +369,12 @@ static __init int hmat_parse_locality(union acpi_subtable_headers *header,
>  			if (mem_hier == ACPI_HMAT_MEMORY) {
>  				target = find_mem_target(targs[targ]);
>  				if (target && target->processor_pxm == inits[init]) {
> +					if (*target->device_handle) {
> +						hmat_update_target_access(target, type, value,
> +								NODE_ACCESS_CLASS_GENPORT);
> +						continue;

There isn't anything that I know of that says a generic port has to be in it's own PXM.

In theory at least they could share one with CPUs or Memory.
Sure the access info will be inaccurate, but meh, it's a firmware table and if the spec
doesn't exclude it then someone might build it.

So rather than continuing here I think you need to add a check on there being memory
or not before deciding not to update the other access classes.

Jonathan


> +					}
> +
>  					hmat_update_target_access(target, type, value,
>  								  NODE_ACCESS_CLASS_0);
>  					/* If the node has a CPU, update access 1 */
> 
> 

