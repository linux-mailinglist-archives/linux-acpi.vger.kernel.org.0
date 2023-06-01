Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE2EE71A06B
	for <lists+linux-acpi@lfdr.de>; Thu,  1 Jun 2023 16:39:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232425AbjFAOjK (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 1 Jun 2023 10:39:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231608AbjFAOjI (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 1 Jun 2023 10:39:08 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DEC81B5;
        Thu,  1 Jun 2023 07:38:47 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4QX7zl4ryTz6J6sh;
        Thu,  1 Jun 2023 22:38:43 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Thu, 1 Jun
 2023 15:38:44 +0100
Date:   Thu, 1 Jun 2023 15:38:44 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Dave Jiang <dave.jiang@intel.com>
CC:     <linux-acpi@vger.kernel.org>, <linux-cxl@vger.kernel.org>,
        <rafael@kernel.org>, <lenb@kernel.org>, <dan.j.williams@intel.com>,
        <ira.weiny@intel.com>, <vishal.l.verma@intel.com>,
        <alison.schofield@intel.com>, <lukas@wunner.de>
Subject: Re: [PATCH v2 3/4] acpi: numa: Add setting of generic port system
 locality attributes
Message-ID: <20230601153844.000071fc@Huawei.com>
In-Reply-To: <168451347867.3465146.10428399827479313906.stgit@djiang5-mobl3>
References: <168451341624.3465146.15355962690295941676.stgit@djiang5-mobl3>
        <168451347867.3465146.10428399827479313906.stgit@djiang5-mobl3>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml100003.china.huawei.com (7.191.160.210) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, 19 May 2023 09:24:38 -0700
Dave Jiang <dave.jiang@intel.com> wrote:

> Add generic port support for the parsing of HMAT system locality sub-table.
> The attributes will be added to the third array member of the access
> coordinates in order to not mix with the existing memory attributes. It only
> provides the system locality attributes from initator to the generic port
> targets and is missing the rest of the data to the actual memory device.
> 
> The complete attributes will be updated when a memory device is
> attached and the system locality information is calculated end to end.
> 
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>

Missing 
---
here

As a passing comment, hmat_parse_locality() is awfully deeply nested
- maybe worth looking to see if some of the deeply nested stuff can be
factored out...  That would be a new patch however


> 
> v2:
> - Fix commit log runon sentence. (Jonathan)
> - Add a check for memory type for skipping other access levels. (Jonathan)
> - NODE_ACCESS_CLASS_GENPORT to NODE_ACCESS_CLASS_GENPORT_SINK. (Jonathan)
> ---
>  drivers/acpi/numa/hmat.c |   10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/drivers/acpi/numa/hmat.c b/drivers/acpi/numa/hmat.c
> index e2ab1cce0add..82320c92abed 100644
> --- a/drivers/acpi/numa/hmat.c
> +++ b/drivers/acpi/numa/hmat.c
> @@ -60,6 +60,7 @@ struct target_cache {
>  enum {
>  	NODE_ACCESS_CLASS_0 = 0,
>  	NODE_ACCESS_CLASS_1,
> +	NODE_ACCESS_CLASS_GENPORT_SINK,
>  	NODE_ACCESS_CLASS_MAX,
>  };
>  
> @@ -368,6 +369,15 @@ static __init int hmat_parse_locality(union acpi_subtable_headers *header,
>  			if (mem_hier == ACPI_HMAT_MEMORY) {
>  				target = find_mem_target(targs[targ]);
>  				if (target && target->processor_pxm == inits[init]) {
> +					if (*target->device_handle) {
> +						hmat_update_target_access(target, type, value,
> +								NODE_ACCESS_CLASS_GENPORT_SINK);
> +						if ((hmat_loc->flags &
> +						     ACPI_HMAT_MEMORY_HIERARCHY) ==
> +						    ACPI_HMAT_MEMORY)
> +							continue;

I'm confused.  Isn't this already what was checked for with
if (mem_heir == ACPI_HMAT_MEMORY)?

> +					}
> +
>  					hmat_update_target_access(target, type, value,
>  								  NODE_ACCESS_CLASS_0);
>  					/* If the node has a CPU, update access 1 */
> 
> 

