Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F21AE68EEFB
	for <lists+linux-acpi@lfdr.de>; Wed,  8 Feb 2023 13:30:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229598AbjBHMah (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 8 Feb 2023 07:30:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjBHMah (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 8 Feb 2023 07:30:37 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED241AD2D;
        Wed,  8 Feb 2023 04:30:34 -0800 (PST)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4PBfSP3JP0z6801v;
        Wed,  8 Feb 2023 20:29:09 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.17; Wed, 8 Feb
 2023 12:30:32 +0000
Date:   Wed, 8 Feb 2023 12:30:31 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Dan Williams <dan.j.williams@intel.com>
CC:     <linux-cxl@vger.kernel.org>, <dave.hansen@linux.intel.com>,
        <linux-mm@kvack.org>, <linux-acpi@vger.kernel.org>
Subject: Re: [PATCH 07/18] cxl/region: Move region-position validation to a
 helper
Message-ID: <20230208123031.00006990@Huawei.com>
In-Reply-To: <167564538779.847146.8356062886811511706.stgit@dwillia2-xfh.jf.intel.com>
References: <167564534874.847146.5222419648551436750.stgit@dwillia2-xfh.jf.intel.com>
        <167564538779.847146.8356062886811511706.stgit@dwillia2-xfh.jf.intel.com>
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
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Sun, 05 Feb 2023 17:03:07 -0800
Dan Williams <dan.j.williams@intel.com> wrote:

> In preparation for region autodiscovery, that needs all devices
> discovered before their relative position in the region can be
> determined, consolidate all position dependent validation in a helper.
> 
> Recall that in the on-demand region creation flow the end-user picks the
> position of a given endpoint decoder in a region. In the autodiscovery
> case the position of an endpoint decoder can only be determined after
> all other endpoint decoders that claim to decode the region's address
> range have been enumerated and attached. So, in the autodiscovery case
> endpoint decoders may be attached before their relative position is
> known. Once all decoders arrive, then positions can be determined and
> validated with cxl_region_validate_position() the same as user initiated
> on-demand creation.
> 
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
Hi Dan,

A few comments inline, but mostly reflect the original code rather than
the refactoring you have done in this patch.

Jonathan


> +static int cxl_region_attach(struct cxl_region *cxlr,
> +			     struct cxl_endpoint_decoder *cxled, int pos)
> +{
> +	struct cxl_root_decoder *cxlrd = to_cxl_root_decoder(cxlr->dev.parent);
> +	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
> +	struct cxl_region_params *p = &cxlr->params;
> +	struct cxl_port *ep_port, *root_port;
> +	struct cxl_dport *dport;
> +	int rc = -ENXIO;
> +
> +	if (cxled->mode != cxlr->mode) {
> +		dev_dbg(&cxlr->dev, "%s region mode: %d mismatch: %d\n",
> +			dev_name(&cxled->cxld.dev), cxlr->mode, cxled->mode);
> +		return -EINVAL;
> +	}
> +
> +	if (cxled->mode == CXL_DECODER_DEAD) {
> +		dev_dbg(&cxlr->dev, "%s dead\n", dev_name(&cxled->cxld.dev));
> +		return -ENODEV;
> +	}
> +
> +	/* all full of members, or interleave config not established? */
> +	if (p->state > CXL_CONFIG_INTERLEAVE_ACTIVE) {
> +		dev_dbg(&cxlr->dev, "region already active\n");
> +		return -EBUSY;
> +	} else if (p->state < CXL_CONFIG_INTERLEAVE_ACTIVE) {
> +		dev_dbg(&cxlr->dev, "interleave config missing\n");
> +		return -ENXIO;
> +	}
> +
>  	ep_port = cxled_to_port(cxled);
>  	root_port = cxlrd_to_port(cxlrd);
>  	dport = cxl_find_dport_by_dev(root_port, ep_port->host_bridge);
> @@ -1284,13 +1327,6 @@ static int cxl_region_attach(struct cxl_region *cxlr,
>  		return -ENXIO;
>  	}
>  
> -	if (cxlrd->calc_hb(cxlrd, pos) != dport) {
> -		dev_dbg(&cxlr->dev, "%s:%s invalid target position for %s\n",
> -			dev_name(&cxlmd->dev), dev_name(&cxled->cxld.dev),
> -			dev_name(&cxlrd->cxlsd.cxld.dev));
> -		return -ENXIO;
> -	}
> -

In an ideal world, this would have been nice as two patches.
One that reorders the various checks so that they are in the order
after you have factored things out (easy to review for correctness)
then one that factored it out.

>  	if (cxled->cxld.target_type != cxlr->type) {
>  		dev_dbg(&cxlr->dev, "%s:%s type mismatch: %d vs %d\n",
>  			dev_name(&cxlmd->dev), dev_name(&cxled->cxld.dev),
> @@ -1314,12 +1350,13 @@ static int cxl_region_attach(struct cxl_region *cxlr,
>  		return -EINVAL;
>  	}
>  
> -	for (iter = ep_port; !is_cxl_root(iter);
> -	     iter = to_cxl_port(iter->dev.parent)) {
> -		rc = cxl_port_attach_region(iter, cxlr, cxled, pos);
> -		if (rc)
> -			goto err;
> -	}
> +	rc = cxl_region_validate_position(cxlr, cxled, pos);
> +	if (rc)
> +		return rc;
> +
> +	rc = cxl_region_attach_position(cxlr, cxlrd, cxled, dport, pos);
> +	if (rc)
> +		return rc;
>  
>  	p->targets[pos] = cxled;
>  	cxled->pos = pos;

More something about original code than the refactoring...

I'm not keen on the side effects that aren't unwound in the error paths.

p->targets[pos] and cxled->pos are left set.  Probably never matters
but not elegant or as easy to reason about as it would be if they
were cleared in error cases.  In particular there is a check on
whether p->targets[pos] is set that will result in a dev_dbg even
though setting it up actually failed.


> @@ -1343,10 +1380,6 @@ static int cxl_region_attach(struct cxl_region *cxlr,
>  
>  err_decrement:
>  	p->nr_targets--;
> -err:
> -	for (iter = ep_port; !is_cxl_root(iter);
> -	     iter = to_cxl_port(iter->dev.parent))
> -		cxl_port_detach_region(iter, cxlr, cxled);
>  	return rc;
>  }
>  
> 

