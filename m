Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35D9369250B
	for <lists+linux-acpi@lfdr.de>; Fri, 10 Feb 2023 19:10:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232760AbjBJSKG (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 10 Feb 2023 13:10:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232742AbjBJSKF (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 10 Feb 2023 13:10:05 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04EA8677B3;
        Fri, 10 Feb 2023 10:10:03 -0800 (PST)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4PD1qy4DPdz67xhs;
        Sat, 11 Feb 2023 02:05:50 +0800 (CST)
Received: from localhost (10.81.210.211) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.17; Fri, 10 Feb
 2023 18:10:00 +0000
Date:   Fri, 10 Feb 2023 18:09:58 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Dan Williams <dan.j.williams@intel.com>
CC:     <linux-cxl@vger.kernel.org>, Fan Ni <fan.ni@samsung.com>,
        <vishal.l.verma@intel.com>, <dave.hansen@linux.intel.com>,
        <linux-mm@kvack.org>, <linux-acpi@vger.kernel.org>
Subject: Re: [PATCH v2 13/20] cxl/region: Add region autodiscovery
Message-ID: <20230210180958.00002e5a@Huawei.com>
In-Reply-To: <167601999958.1924368.9366954455835735048.stgit@dwillia2-xfh.jf.intel.com>
References: <167601992097.1924368.18291887895351917895.stgit@dwillia2-xfh.jf.intel.com>
        <167601999958.1924368.9366954455835735048.stgit@dwillia2-xfh.jf.intel.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.81.210.211]
X-ClientProxiedBy: lhrpeml100004.china.huawei.com (7.191.162.219) To
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

On Fri, 10 Feb 2023 01:06:39 -0800
Dan Williams <dan.j.williams@intel.com> wrote:

> Region autodiscovery is an asynchronous state machine advanced by
> cxl_port_probe(). After the decoders on an endpoint port are enumerated
> they are scanned for actively enabled instances. Each active decoder is
> flagged for auto-assembly CXL_DECODER_F_AUTO and attached to a region.
> If a region does not already exist for the address range setting of the
> decoder one is created. That creation process may race with other
> decoders of the same region being discovered since cxl_port_probe() is
> asynchronous. A new 'struct cxl_root_decoder' lock, @range_lock, is
> introduced to mitigate that race.
> 
> Once all decoders have arrived, "p->nr_targets == p->interleave_ways",
> they are sorted by their relative decode position. The sort algorithm
> involves finding the point in the cxl_port topology where one leg of the
> decode leads to deviceA and the other deviceB. At that point in the
> topology the target order in the 'struct cxl_switch_decoder' indicates
> the relative position of those endpoint decoders in the region.
> 
> >From that point the region goes through the same setup and validation 
Why the >? 
> steps as user-created regions, but instead of programming the decoders
> it validates that driver would have written the same values to the
> decoders as were already present.
> 
> Tested-by: Fan Ni <fan.ni@samsung.com>
> Link: https://lore.kernel.org/r/167564540972.847146.17096178433176097831.stgit@dwillia2-xfh.jf.intel.com
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

A few trivial things inline and this being complex code I'm not
as confident about it as the rest of the series but with that in mind
and the fact I didn't find anything that looked broken...

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

...



> +
> +static int cxl_region_sort_targets(struct cxl_region *cxlr)
> +{
> +	struct cxl_region_params *p = &cxlr->params;
> +	int i, rc = 0;
> +
> +	sort(p->targets, p->nr_targets, sizeof(p->targets[0]), cmp_decode_pos,
> +	     NULL);
> +
> +	for (i = 0; i < p->nr_targets; i++) {
> +		struct cxl_endpoint_decoder *cxled = p->targets[i];
> +
> +		if (cxled->pos < 0)
> +			rc = -ENXIO;

If it makes sense to carry on after pos < 0 I'd like to see a comment here
on why.  If not, nicer to have a separate dev_dbg() for failed case nad
direct return here.

> +		cxled->pos = i;
> +	}
> +
> +	dev_dbg(&cxlr->dev, "region sort %s\n", rc ? "failed" : "successful");
> +	return rc;
> +}
> +

> +
> +int cxl_add_to_region(struct cxl_port *root, struct cxl_endpoint_decoder *cxled)
> +{
> +	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
> +	struct range *hpa = &cxled->cxld.hpa_range;
> +	struct cxl_decoder *cxld = &cxled->cxld;
> +	struct cxl_root_decoder *cxlrd;
> +	struct cxl_region_params *p;
> +	struct cxl_region *cxlr;
> +	bool attach = false;
> +	struct device *dev;
> +	int rc;
> +
> +	dev = device_find_child(&root->dev, &cxld->hpa_range,
> +				match_decoder_by_range);
> +	if (!dev) {
> +		dev_err(cxlmd->dev.parent,
> +			"%s:%s no CXL window for range %#llx:%#llx\n",
> +			dev_name(&cxlmd->dev), dev_name(&cxld->dev),
> +			cxld->hpa_range.start, cxld->hpa_range.end);
> +		return -ENXIO;
> +	}
> +
> +	cxlrd = to_cxl_root_decoder(dev);
> +
> +	/*
> +	 * Ensure that if multiple threads race to construct_region() for @hpa
> +	 * one does the construction and the others add to that.
> +	 */
> +	mutex_lock(&cxlrd->range_lock);
> +	dev = device_find_child(&cxlrd->cxlsd.cxld.dev, hpa,
> +				match_region_by_range);
> +	if (!dev)
> +		cxlr = construct_region(cxlrd, cxled);
> +	else
> +		cxlr = to_cxl_region(dev);
> +	mutex_unlock(&cxlrd->range_lock);
> +
> +	if (IS_ERR(cxlr)) {
> +		rc = PTR_ERR(cxlr);
> +		goto out;
> +	}
> +
> +	attach_target(cxlr, cxled, -1, TASK_UNINTERRUPTIBLE);
> +
> +	down_read(&cxl_region_rwsem);
> +	p = &cxlr->params;
> +	attach = p->state == CXL_CONFIG_COMMIT;
> +	up_read(&cxl_region_rwsem);
> +
> +	if (attach) {
> +		int rc = device_attach(&cxlr->dev);

Shadowing int rc isn't great for readability. Just call it rc2 or something :)
Or given you don't make use of the value...

		/*
		 * If device_attach() fails the range may still be active via
		 * the platform-firmware memory map, otherwise the driver for
		 * regions is local to this file, so driver matching can't fail
+                * and hence device_attach() cannot return 1.

//very much not obvious otherwise to anyone who isn't far too familiar with device_attach()

		 */
		if (device_attach(&cxlr->dev) < 0)
			dev_err()
> +
> +		/*
> +		 * If device_attach() fails the range may still be active via
> +		 * the platform-firmware memory map, otherwise the driver for
> +		 * regions is local to this file, so driver matching can't fail.
> +		 */
> +		if (rc < 0)
> +			dev_err(&cxlr->dev, "failed to enable, range: %pr\n",
> +				p->res);
> +	}
> +
> +	put_device(&cxlr->dev);
> +out:
> +	put_device(&cxlrd->cxlsd.cxld.dev);

Moderately horrible.  Maybe just keep an extra local variable around for the first
use of struct device *dev?  or maybe add a put_cxl_root_decoder() helper?

There are lots of other deep structure access like this I guess, so I don't mind
if you just leave this as yet another one.


> +	return rc;
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_add_to_region, CXL);

...

> diff --git a/drivers/cxl/port.c b/drivers/cxl/port.c
> index a8d46a67b45e..d88518836c2d 100644
> --- a/drivers/cxl/port.c
> +++ b/drivers/cxl/port.c
> @@ -30,6 +30,34 @@ static void schedule_detach(void *cxlmd)
>  	schedule_cxl_memdev_detach(cxlmd);
>  }
>  
> +static int discover_region(struct device *dev, void *root)
> +{
> +	struct cxl_endpoint_decoder *cxled;
> +	int rc;
> +
> +	if (!is_endpoint_decoder(dev))
> +		return 0;
> +
> +	cxled = to_cxl_endpoint_decoder(dev);
> +	if ((cxled->cxld.flags & CXL_DECODER_F_ENABLE) == 0)
> +		return 0;
> +
> +	if (cxled->state != CXL_DECODER_STATE_AUTO)
> +		return 0;
> +
> +	/*
> +	 * Region enumeration is opportunistic, if this add-event fails,
> +	 * continue to the next endpoint decoder.
> +	 */
> +	rc = cxl_add_to_region(root, cxled);
> +	if (rc)
> +		dev_dbg(dev, "failed to add to region: %#llx-%#llx\n",
> +			cxled->cxld.hpa_range.start, cxled->cxld.hpa_range.end);
> +
> +	return 0;
> +}
> +
> +

Two blank lines?

>  static int cxl_switch_port_probe(struct cxl_port *port)
>  {
