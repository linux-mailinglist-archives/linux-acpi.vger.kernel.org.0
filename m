Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47F5868F3FC
	for <lists+linux-acpi@lfdr.de>; Wed,  8 Feb 2023 18:07:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230434AbjBHRHb (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 8 Feb 2023 12:07:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229962AbjBHRHa (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 8 Feb 2023 12:07:30 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 209E620068;
        Wed,  8 Feb 2023 09:07:28 -0800 (PST)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4PBmXp12gfz687Yd;
        Thu,  9 Feb 2023 01:03:22 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.17; Wed, 8 Feb
 2023 17:07:25 +0000
Date:   Wed, 8 Feb 2023 17:07:24 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Dan Williams <dan.j.williams@intel.com>
CC:     <linux-cxl@vger.kernel.org>, <dave.hansen@linux.intel.com>,
        <linux-mm@kvack.org>, <linux-acpi@vger.kernel.org>
Subject: Re: [PATCH 11/18] cxl/region: Add region autodiscovery
Message-ID: <20230208170724.000067ec@Huawei.com>
In-Reply-To: <167564540972.847146.17096178433176097831.stgit@dwillia2-xfh.jf.intel.com>
References: <167564534874.847146.5222419648551436750.stgit@dwillia2-xfh.jf.intel.com>
        <167564540972.847146.17096178433176097831.stgit@dwillia2-xfh.jf.intel.com>
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

On Sun, 05 Feb 2023 17:03:29 -0800
Dan Williams <dan.j.williams@intel.com> wrote:

> Region autodiscovery is an asynchrounous state machine advanced by
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
> steps as user-created regions, but instead of programming the decoders
> it validates that driver would have written the same values to the
> decoders as were already present.
> 
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
A few comments inline,

Thanks,

Jonathan

> ---
>  drivers/cxl/core/hdm.c    |    5 
>  drivers/cxl/core/port.c   |    2 
>  drivers/cxl/core/region.c |  496 ++++++++++++++++++++++++++++++++++++++++++++-
>  drivers/cxl/cxl.h         |   16 +
>  drivers/cxl/port.c        |   26 ++
>  5 files changed, 531 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
> index dcc16d7cb8f3..174cddfec6e8 100644
> --- a/drivers/cxl/core/hdm.c
> +++ b/drivers/cxl/core/hdm.c
> @@ -674,7 +674,7 @@ static int cxl_decoder_reset(struct cxl_decoder *cxld)
>  	up_read(&cxl_dpa_rwsem);
>  
>  	port->commit_end--;
> -	cxld->flags &= ~CXL_DECODER_F_ENABLE;
> +	cxld->flags &= ~(CXL_DECODER_F_ENABLE | CXL_DECODER_F_AUTO);
>  
>  	return 0;
>  }
> @@ -719,7 +719,7 @@ static int init_hdm_decoder(struct cxl_port *port, struct cxl_decoder *cxld,
>  
>  	/* decoders are enabled if committed */
>  	if (committed) {
> -		cxld->flags |= CXL_DECODER_F_ENABLE;
> +		cxld->flags |= CXL_DECODER_F_ENABLE | CXL_DECODER_F_AUTO;
>  		if (ctrl & CXL_HDM_DECODER0_CTRL_LOCK)
>  			cxld->flags |= CXL_DECODER_F_LOCK;
>  		if (FIELD_GET(CXL_HDM_DECODER0_CTRL_TYPE, ctrl))
> @@ -783,6 +783,7 @@ static int init_hdm_decoder(struct cxl_port *port, struct cxl_decoder *cxld,
>  		return rc;
>  	}
>  	*dpa_base += dpa_size + skip;
> +

:)  No comment.

>  	return 0;
>  }
>  


...


> +static int cmp_decode_pos(const void *a, const void *b)
> +{
> +	struct cxl_endpoint_decoder *cxled_a = *(typeof(cxled_a) *)a;
> +	struct cxl_endpoint_decoder *cxled_b = *(typeof(cxled_b) *)b;
> +	struct cxl_memdev *cxlmd_a = cxled_to_memdev(cxled_a);
> +	struct cxl_memdev *cxlmd_b = cxled_to_memdev(cxled_b);
> +	struct cxl_port *port_a = cxled_to_port(cxled_a);
> +	struct cxl_port *port_b = cxled_to_port(cxled_b);
> +	struct cxl_port *iter_a, *iter_b;
> +
> +	/* Exit early if any prior sorting failed */
> +	if (cxled_a->pos < 0 || cxled_b->pos < 0)
> +		return 0;
> +
> +	/*
> +	 * Walk up the hierarchy to find a shared port, find the decoder
> +	 * that maps the range, compare the relative position of those
> +	 * dport mappings.
> +	 */
> +	for (iter_a = port_a; iter_a; iter_a = next_port(iter_a)) {
> +		struct cxl_port *next_a, *next_b, *port;
> +		struct cxl_switch_decoder *cxlsd;
> +
> +		next_a = next_port(iter_a);
> +		for (iter_b = port_b; iter_b; iter_b = next_port(iter_b)) {
> +			int a_pos, b_pos, result;
> +			struct device *dev;
> +			unsigned int seq;
> +
> +			next_b = next_port(iter_b);
> +			if (next_a != next_b)
> +				continue;
> +			if (!next_a)
> +				goto out;
Perhaps treat this as a 'find the match' then carry on, so as to avoid having the
guts of the handling nested so deep.  So something like.

	struct cxl_switch_decoder *cxlsd;
	struct cxl_port *next_a, *next_b, *port;
	bool matched = false; // May be simpler test - I'm just lazy

	// possibly pull this out as a utility function so that
	// error handling can be tidied up by simply returning 
	// rather than gotos.
	for (iter_a = port_a; iter_a; iter_a = next_port(iter_a)) {
		next_a = next_port(iter_a);
		for (iter_b = port_b; iter_b; iter_b = next_port(iter_b)) {
			int a_pos, b_pos, result;
			struct device *dev;
			unsigned int seq;

			next_b = next_port(iter_b);
			if (next_a != next_b)
				continue;
			if (!next_a)
				goto out;
			port = next_a;
			found = true;
			break;
		}
		if (found)
			break;
	}
	if (!found)
		goto out;

	dev = device_find_child(&port->dev, cxled_a,
				decoder_match_range);
	if (!dev) {
		struct range *range = &cxled_a->cxld.hpa_range;
		dev_err(port->uport,
			"failed to find decoder that maps %#llx-:%#llx\n",
		range->start, range->end);
		cxled_a->pos = -1;
		return 0;
	}

	cxlsd = to_cxl_switch_decoder(dev);
	do {
		seq = read_seqbegin(&cxlsd->target_lock);
		find_positions(cxlsd, iter_a, iter_b, &a_pos, &b_pos);
	} while (read_seqretry(&cxlsd->target_lock, seq));

	if (a_pos < 0 || b_pos < 0) {
		dev_err(port->uport,
			"failed to find shared decoder for %s and %s\n",
			dev_name(cxlmd_a->dev.parent),
			dev_name(cxlmd_b->dev.parent));
		cxled_a->pos = -1;
		result = 0;
//if factored as suggested above then a goto here and drop
// the else would be neater again.

	} else {
		result = a_pos - b_pos;
		dev_dbg(port->uport, "%s: %s comes %s %s\n",
			dev_name(&cxlsd->cxld.dev),
			dev_name(cxlmd_a->dev.parent),
			result < 0 ? "before" : "after",
			dev_name(cxlmd_b->dev.parent));
		}
	put_device(dev);

	return result;
out:
	dev_err(cxlmd_a->dev.parent, "failed to find shared port with %s\n",
		dev_name(cxlmd_b->dev.parent));
	cxled_a->pos = -1;
	return 0;
}


> +			dev = device_find_child(&port->dev, cxled_a,
> +						decoder_match_range);
> +			if (!dev) {
> +				struct range *range = &cxled_a->cxld.hpa_range;
> +
> +				dev_err(port->uport,
> +					"failed to find decoder that maps %#llx-:%#llx\n",
> +					range->start, range->end);
> +				cxled_a->pos = -1;
> +				return 0;
> +			}
> +
> +			cxlsd = to_cxl_switch_decoder(dev);
> +			do {
> +				seq = read_seqbegin(&cxlsd->target_lock);
> +				find_positions(cxlsd, iter_a, iter_b, &a_pos,
> +					       &b_pos);
> +			} while (read_seqretry(&cxlsd->target_lock, seq));
> +
> +			if (a_pos < 0 || b_pos < 0) {
> +				dev_err(port->uport,
> +					"failed to find shared decoder for %s and %s\n",
> +					dev_name(cxlmd_a->dev.parent),
> +					dev_name(cxlmd_b->dev.parent));
> +				cxled_a->pos = -1;
> +				result = 0;
> +			} else {
> +				result = a_pos - b_pos;
> +				dev_dbg(port->uport, "%s: %s comes %s %s\n",
> +					dev_name(&cxlsd->cxld.dev),
> +					dev_name(cxlmd_a->dev.parent),
> +					result < 0 ? "before" : "after",
> +					dev_name(cxlmd_b->dev.parent));
> +			}
> +
> +			put_device(dev);
> +
> +			return result;
> +		}
> +	}
> +out:
> +	dev_err(cxlmd_a->dev.parent, "failed to find shared port with %s\n",
> +		dev_name(cxlmd_b->dev.parent));
> +	cxled_a->pos = -1;
> +	return 0;
> +}
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
> +		cxled->pos = i;
> +	}
> +
> +	dev_dbg(&cxlr->dev, "region sort %s\n", rc ? "failed" : "successful");
> +	return rc;
> +}
> +
>  static int cxl_region_attach(struct cxl_region *cxlr,
>  			     struct cxl_endpoint_decoder *cxled, int pos)
>  {
> @@ -1350,6 +1572,50 @@ static int cxl_region_attach(struct cxl_region *cxlr,
>  		return -EINVAL;
>  	}
>  
> +	if (test_bit(CXL_REGION_F_AUTO, &cxlr->flags)) {
> +		int i;
> +
> +		rc = cxl_region_attach_auto(cxlr, cxled, pos);
> +		if (rc)
> +			return rc;
> +
> +		/* await more targets to arrive... */
> +		if (p->nr_targets < p->interleave_ways)
> +			return 0;
> +
> +		/*
> +		 * All targets are here, which implies all PCI enumeration that
> +		 * affects this region has been completed. Walk the topology to
> +		 * sort the devices into their relative region decode position.
> +		 */
> +		rc = cxl_region_sort_targets(cxlr);
> +		if (rc)
> +			return rc;
> +
> +		for (i = 0; i < p->nr_targets; i++) {
> +			cxled = p->targets[i];
> +			ep_port = cxled_to_port(cxled);
> +			dport = cxl_find_dport_by_dev(root_port,
> +						      ep_port->host_bridge);
> +			rc = cxl_region_attach_position(cxlr, cxlrd, cxled,
> +							dport, i);
> +			if (rc)
> +				return rc;
> +		}
> +
> +		rc = cxl_region_setup_targets(cxlr);
> +		if (rc)
> +			return rc;
> +
> +		/*
> +		 * If target setup succeeds in the autodiscovery case
> +		 * then the region is already committed.
> +		 */
> +		p->state = CXL_CONFIG_COMMIT;
> +
> +		return 0;
> +	}
> +
>  	rc = cxl_region_validate_position(cxlr, cxled, pos);
>  	if (rc)
>  		return rc;
> @@ -1500,8 +1766,8 @@ static int detach_target(struct cxl_region *cxlr, int pos)
>  	return rc;
>  }
>  
> -static size_t store_targetN(struct cxl_region *cxlr, const char *buf, int pos,
> -			    size_t len)
> +static ssize_t store_targetN(struct cxl_region *cxlr, const char *buf, int pos,
> +			     size_t len)

?



...


> +
> +void cxl_add_to_region(struct cxl_endpoint_decoder *cxled)
> +{
> +	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
> +	struct range *hpa = &cxled->cxld.hpa_range;
> +	struct cxl_decoder *cxld = &cxled->cxld;
> +	struct cxl_root_decoder *cxlrd;
> +	struct cxl_region_params *p;
> +	struct cxl_region *cxlr;
> +	struct cxl_port *root;
> +	bool attach = false;
> +	struct device *dev;
> +
> +	root = find_cxl_root(&cxlmd->dev);
> +	if (!root) {
> +		dev_err(cxlmd->dev.parent, "%s: failed to map CXL root\n",
> +			dev_name(&cxlmd->dev));
> +		return;

I'm not a fan of muddling on from errors at lower layers of code.
I'd push that decision up to the caller - so return an error code from here.
If caller just wants to ignore it (with appropriate comment on why) then
that is fine by me.


> +	}
> +
> +	dev = device_find_child(&root->dev, &cxld->hpa_range,
> +				  match_decoder_by_range);

device_find_child is acquiring a reference to the child I think.

> +	if (!dev) {
> +		dev_err(cxlmd->dev.parent,
> +			"%s:%s no CXL window for range %#llx:%#llx\n",
> +			dev_name(&cxlmd->dev), dev_name(&cxld->dev),
> +			cxld->hpa_range.start, cxld->hpa_range.end);
> +		goto out;
> +	}
> +	cxlrd = to_cxl_root_decoder(dev);
Here we've stashed the dev that we have a reference to in cxlrd.
> +
> +	mutex_lock(&cxlrd->range_lock);
> +	dev = device_find_child(&cxlrd->cxlsd.cxld.dev, hpa,
> +				match_region_by_range);
> +	if (!dev)
> +		cxlr = construct_region(cxlrd, cxled);
> +	else
> +		cxlr = to_cxl_region(dev);
> +	mutex_unlock(&cxlrd->range_lock);
> +
> +	if (IS_ERR(cxlr))

In this path, do we drop the reference to cxlrd->dev?

> +		goto out;
> +
> +	attach_target(cxlr, cxled, -1, TASK_UNINTERRUPTIBLE);
> +
> +	down_read(&cxl_region_rwsem);
> +	p = &cxlr->params;
> +	attach = p->state >= CXL_CONFIG_COMMIT;

Test is a bit non obvious.  In the tree I'm looking at
CXL_CONFIG_COMMIT is last value in the enum.


> +	up_read(&cxl_region_rwsem);
> +
> +	if (attach) {
> +		int rc = device_attach(&cxlr->dev);
> +
> +		/*
> +		 * If device_attach() fails the range may still be
> +		 * active via the platform-firmware memory map
> +		 */
> +		if (rc < 0)

We also want to know if the no matching driver found case happened so perhaps
		if (rc != 1)

> +			dev_err(&cxlr->dev, "failed to enable, range: %pr\n",
> +				p->res);
> +	}
> +
> +	put_device(&cxlr->dev);
> +out:
> +	put_device(&root->dev);
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_add_to_region, CXL);
> +
>  static int cxl_region_invalidate_memregion(struct cxl_region *cxlr)
>  {
>  	if (!test_bit(CXL_REGION_F_INCOHERENT, &cxlr->flags))
> @@ -2103,6 +2554,15 @@ static int cxl_region_invalidate_memregion(struct cxl_region *cxlr)
>  	return 0;
>  }

> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index ca76879af1de..9b3765c5c81a 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -261,6 +261,8 @@ resource_size_t cxl_rcrb_to_component(struct device *dev,
>   * cxl_decoder flags that define the type of memory / devices this
>   * decoder supports as well as configuration lock status See "CXL 2.0
>   * 8.2.5.12.7 CXL HDM Decoder 0 Control Register" for details.
> + * Additionally indicate whether decoder settings were autodetected,
> + * user customized.
>   */
>  #define CXL_DECODER_F_RAM   BIT(0)
>  #define CXL_DECODER_F_PMEM  BIT(1)
> @@ -268,6 +270,7 @@ resource_size_t cxl_rcrb_to_component(struct device *dev,
>  #define CXL_DECODER_F_TYPE3 BIT(3)
>  #define CXL_DECODER_F_LOCK  BIT(4)
>  #define CXL_DECODER_F_ENABLE    BIT(5)
> +#define CXL_DECODER_F_AUTO  BIT(6)

That's a bit nasty and unexpected - can we rename to make it really clear
it's not a hardware flag at the point of usage.
Or just put it in a a new structure field rather than pushing it in here.

>  #define CXL_DECODER_F_MASK  GENMASK(5, 0)

Hmm. This mask isn't currently used and now has
an odd meaning because of hiding a flag in bit(6).


...

>  
>  /*
> diff --git a/drivers/cxl/port.c b/drivers/cxl/port.c
> index 5453771bf330..012a0c6f8476 100644
> --- a/drivers/cxl/port.c
> +++ b/drivers/cxl/port.c
> @@ -30,6 +30,23 @@ static void schedule_detach(void *cxlmd)
>  	schedule_cxl_memdev_detach(cxlmd);
>  }
>  
> +static int discover_region(struct device *dev, void *data)
> +{
> +	const unsigned long flags = CXL_DECODER_F_ENABLE | CXL_DECODER_F_AUTO;
> +	struct cxl_endpoint_decoder *cxled;
> +
> +	if (!is_endpoint_decoder(dev))
> +		return 0;
> +
> +	cxled = to_cxl_endpoint_decoder(dev);
> +	if ((cxled->cxld.flags & flags) != flags)
> +		return 0;
> +
> +	cxl_add_to_region(cxled);
> +
> +	return 0;
> +}
> +
>  static int cxl_port_probe(struct device *dev)
>  {
>  	struct cxl_port *port = to_cxl_port(dev);
> @@ -78,6 +95,15 @@ static int cxl_port_probe(struct device *dev)
>  		return rc;
>  	}
>  
> +	if (!is_cxl_endpoint(port))
> +		return 0;
> +
> +	/*
> +	 * Now that all endpoint decoders are successfully enumerated,
> +	 * try to assemble regions from committed decoders
> +	 */
> +	device_for_each_child(dev, NULL, discover_region);
> +

There is a steady reduction in common code vs specific code for the two
cases in here.  Maybe it's time just to split the probe into

static int cxl_port_probe(struct device *dev)
{
	if (is_cxl_endpoint(port))
		cxl_port_probe_endpoint();
	else
		cxl_port_probe_not endpoint(); //with better naming.
}

Shared code is about 7 lines vs 40+ unshared.



>  	return 0;
>  }
>  
> 
> 

