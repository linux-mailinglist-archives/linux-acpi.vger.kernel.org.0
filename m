Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B226700CBC
	for <lists+linux-acpi@lfdr.de>; Fri, 12 May 2023 18:16:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232578AbjELQQu (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 12 May 2023 12:16:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232426AbjELQQu (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 12 May 2023 12:16:50 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C833BE;
        Fri, 12 May 2023 09:16:47 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4QHv1V0Dlvz6J7Dk;
        Sat, 13 May 2023 00:12:46 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Fri, 12 May
 2023 17:16:44 +0100
Date:   Fri, 12 May 2023 17:16:43 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Dave Jiang <dave.jiang@intel.com>
CC:     <linux-acpi@vger.kernel.org>, <linux-cxl@vger.kernel.org>,
        <rafael@kernel.org>, <lenb@kernel.org>, <dan.j.williams@intel.com>,
        <ira.weiny@intel.com>, <vishal.l.verma@intel.com>,
        <alison.schofield@intel.com>, <lukas@wunner.de>
Subject: Re: [PATCH 3/4] acpi: numa: Add setting of generic port system
 locality attributes
Message-ID: <20230512171643.00001700@Huawei.com>
In-Reply-To: <168333152832.2290593.17409054392013117865.stgit@djiang5-mobl3>
References: <168333141100.2290593.16294670316057617744.stgit@djiang5-mobl3>
        <168333152832.2290593.17409054392013117865.stgit@djiang5-mobl3>
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

On Fri, 05 May 2023 17:05:28 -0700
Dave Jiang <dave.jiang@intel.com> wrote:

> Add generic port support for the parsing of HMAT system locality sub-table.
> The attributes will be added to the third array member of the access
> coordinates in order to not mix with the existing memory attributes it only
> provides the system locality attributes from initator to the generic port
> targets and is missing the rest of the data to the actual memory device.
> 
> The complete attributes will be updated when a memory device is
> attached and the system locality information is calculated end to end.
> 
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>

Strange question for you.  For now we have it easy as we only have Type 3
CXL devices using this.  Later when we have accelerators, then the generic
port becomes both an initiator and a target (well proxy of one in both cases).
We'll probably want to map the linux view of a generic initiator (CPU less
node) on top of the accelerator using the access characteristics from HMAT +
other parts.

Any thoughts on how to extend this approach to that case?

I can see it might need another access class so that normal memory for example
can be the target of a generic port.  

Maybe it's worth predicting that and renaming CLASS_GENPORT to CLASS_GENPORT_SINK
or something along those lines?

Or just leave it until someone cares?  I'm fine with this answer if you agree ;)

Jonathan

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
> +					}
> +
>  					hmat_update_target_access(target, type, value,
>  								  NODE_ACCESS_CLASS_0);
>  					/* If the node has a CPU, update access 1 */
> 
> 

