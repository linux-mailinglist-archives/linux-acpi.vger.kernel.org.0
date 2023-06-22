Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B53473A227
	for <lists+linux-acpi@lfdr.de>; Thu, 22 Jun 2023 15:48:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230301AbjFVNsE (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 22 Jun 2023 09:48:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230433AbjFVNro (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 22 Jun 2023 09:47:44 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B0DB1997;
        Thu, 22 Jun 2023 06:47:44 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Qn1p631Whz6J6Hk;
        Thu, 22 Jun 2023 21:45:02 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 22 Jun
 2023 14:47:41 +0100
Date:   Thu, 22 Jun 2023 14:47:41 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Dave Jiang <dave.jiang@intel.com>
CC:     <linux-acpi@vger.kernel.org>, <linux-cxl@vger.kernel.org>,
        <rafael@kernel.org>, <lenb@kernel.org>, <dan.j.williams@intel.com>,
        <ira.weiny@intel.com>, <vishal.l.verma@intel.com>,
        <alison.schofield@intel.com>, <lukas@wunner.de>
Subject: Re: [PATCH v3 5/6] acpi: numa: Add setting of generic port system
 locality attributes
Message-ID: <20230622144741.00007964@Huawei.com>
In-Reply-To: <168686425375.2950427.10184250250033053574.stgit@djiang5-mobl3>
References: <168686408822.2950427.16242077816997472103.stgit@djiang5-mobl3>
        <168686425375.2950427.10184250250033053574.stgit@djiang5-mobl3>
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

On Thu, 15 Jun 2023 14:24:13 -0700
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
With rename of device_handle, or a comment perhaps, in earlier patch.
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> 
> ---
> v3:
> - Drop continue after setting gen target access data. (Jonathan)
> v2:
> - Fix commit log runon sentence. (Jonathan)
> - Add a check for memory type for skipping other access levels. (Jonathan)
> - NODE_ACCESS_CLASS_GENPORT to NODE_ACCESS_CLASS_GENPORT_SINK. (Jonathan)
> ---
>  drivers/acpi/numa/hmat.c |    4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/acpi/numa/hmat.c b/drivers/acpi/numa/hmat.c
> index cb240f5233fe..32b951cd5ee4 100644
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
> @@ -329,6 +330,9 @@ static __init void hmat_update_target(unsigned int tgt_pxm, unsigned int init_px
>  		return;
>  
>  	if (target && target->processor_pxm == init_pxm) {
> +		if (*target->device_handle)

Just for reference - this is where I suddenly wondered what a generic thing
like a device_handle had to do with this path ;)

> +			hmat_update_target_access(target, type, value,
> +						  NODE_ACCESS_CLASS_GENPORT_SINK);
Real nitpick but could we put them in order of the enum... 
That is put this at the end.

>  		hmat_update_target_access(target, type, value,
>  					  NODE_ACCESS_CLASS_0);
>  		/* If the node has a CPU, update access 1 */
> 
> 

