Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AE506E9368
	for <lists+linux-acpi@lfdr.de>; Thu, 20 Apr 2023 13:52:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231827AbjDTLwT (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 20 Apr 2023 07:52:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230246AbjDTLwS (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 20 Apr 2023 07:52:18 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF81BE69;
        Thu, 20 Apr 2023 04:52:17 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Q2FrV1Kh8z67M1H;
        Thu, 20 Apr 2023 19:32:42 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Thu, 20 Apr
 2023 12:33:51 +0100
Date:   Thu, 20 Apr 2023 12:33:50 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Dave Jiang <dave.jiang@intel.com>
CC:     <linux-cxl@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
        <dan.j.williams@intel.com>, <ira.weiny@intel.com>,
        <vishal.l.verma@intel.com>, <alison.schofield@intel.com>,
        <rafael@kernel.org>, <lukas@wunner.de>
Subject: Re: [PATCH v4 05/23] cxl: Add callback to parse the DSMAS subtables
 from CDAT
Message-ID: <20230420123350.000061b1@Huawei.com>
In-Reply-To: <168193569130.1178687.11664485128816659216.stgit@djiang5-mobl3>
References: <168193556660.1178687.15477509915255912089.stgit@djiang5-mobl3>
        <168193569130.1178687.11664485128816659216.stgit@djiang5-mobl3>
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
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, 19 Apr 2023 13:21:31 -0700
Dave Jiang <dave.jiang@intel.com> wrote:

> Provide a callback function to the CDAT parser in order to parse the Device
> Scoped Memory Affinity Structure (DSMAS). Each DSMAS structure contains the
> DPA range and its associated attributes in each entry. See the CDAT
> specification for details.
> 
> Coherent Device Attribute Table 1.03 2.1 Device Scoped memory Affinity
> Structure (DSMAS)

I'm not sure what purpose of this is. If it's just detecting problems
with the entry because we aren't interested in the content yet, then fine
but good to make that clear in patch intro.

Maybe I'm missing something!

Thanks,

Jonathan

> 
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> 
> ---
> v3:
> - Add spec section number. (Alison)
> - Remove cast from void *. (Alison)
> - Refactor cxl_port_probe() block. (Alison)
> - Move CDAT parse to cxl_endpoint_port_probe()
> 
> v2:
> - Add DSMAS table size check. (Lukas)
> - Use local DSMAS header for LE handling.
> - Remove dsmas lock. (Jonathan)
> - Fix handle size (Jonathan)
> - Add LE to host conversion for DSMAS address and length.
> - Make dsmas_list local


> diff --git a/drivers/cxl/port.c b/drivers/cxl/port.c
> index 615e0ef6b440..3022bdd52439 100644
> --- a/drivers/cxl/port.c
> +++ b/drivers/cxl/port.c
> @@ -57,6 +57,16 @@ static int discover_region(struct device *dev, void *root)
>  	return 0;
>  }

>  static int cxl_switch_port_probe(struct cxl_port *port)
>  {
>  	struct cxl_hdm *cxlhdm;
> @@ -125,6 +135,18 @@ static int cxl_endpoint_port_probe(struct cxl_port *port)
>  	device_for_each_child(&port->dev, root, discover_region);
>  	put_device(&root->dev);
>  
> +	if (port->cdat.table) {
> +		LIST_HEAD(dsmas_list);
> +
> +		rc = cdat_table_parse_dsmas(port->cdat.table,
> +					    cxl_dsmas_parse_entry,
> +					    (void *)&dsmas_list);
> +		if (rc < 0)
> +			dev_warn(&port->dev, "Failed to parse DSMAS: %d\n", rc);
> +
> +		dsmas_list_destroy(&dsmas_list);

I'm a little confused here.  What's the point?  Parse them then throw the info away?
Maybe a comment if all we are trying to do is warn about CDAT problems.


> +	}
> +
>  	return 0;
>  }
>  
> 
> 

