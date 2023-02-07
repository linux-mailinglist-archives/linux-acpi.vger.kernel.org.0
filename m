Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5414768E4AB
	for <lists+linux-acpi@lfdr.de>; Wed,  8 Feb 2023 00:54:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229721AbjBGXyq (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 7 Feb 2023 18:54:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbjBGXyp (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 7 Feb 2023 18:54:45 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 349242C67E;
        Tue,  7 Feb 2023 15:54:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675814083; x=1707350083;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=yetl3Yu3QsiV7QaJgEz1shk71z4juJdcKqOJCIbrrxU=;
  b=n1csmZYKsMNXrmcwvwRAoZiTBKwp+P0uelox4W8f7RN+1NqGnZdPW5XK
   3kpP+HC0kLvPHWR2SPoquBzKr0Xl0ASYKzMSb5ElE2mXcJPymIdSOkMUL
   Z3fvOVTTObVYM1wDLzTmhVW/NAQiD9K+Tt9qbLPxt57FSWV3r2NsoEcgy
   1XubUjaQkNngo92sBRVxOX8BaSXu8O0N+rbBjdwyhyVF3uIag4meXofWX
   8r4bliXQSnas0qFarV9XBRS7xvh6V16qQlUkGiBSBfbkDS4JdnMQoHkKD
   8sf8/vucW/TbEFeuJUAM9WgLHACcGtFIxNuZlp6tPnyJqlShIcHH3FDCa
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10614"; a="331791241"
X-IronPort-AV: E=Sophos;i="5.97,279,1669104000"; 
   d="scan'208";a="331791241"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2023 15:54:30 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10614"; a="995924223"
X-IronPort-AV: E=Sophos;i="5.97,279,1669104000"; 
   d="scan'208";a="995924223"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [10.212.98.37]) ([10.212.98.37])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2023 15:54:29 -0800
Message-ID: <1d0acf54-30b0-3d5a-7aca-ffc144dc7bf0@intel.com>
Date:   Tue, 7 Feb 2023 16:54:29 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.6.0
Subject: Re: [PATCH 11/18] cxl/region: Add region autodiscovery
Content-Language: en-US
To:     Dan Williams <dan.j.williams@intel.com>, linux-cxl@vger.kernel.org
Cc:     dave.hansen@linux.intel.com, linux-mm@kvack.org,
        linux-acpi@vger.kernel.org
References: <167564534874.847146.5222419648551436750.stgit@dwillia2-xfh.jf.intel.com>
 <167564540972.847146.17096178433176097831.stgit@dwillia2-xfh.jf.intel.com>
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <167564540972.847146.17096178433176097831.stgit@dwillia2-xfh.jf.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org



On 2/5/23 6:03 PM, Dan Williams wrote:
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
>>From that point the region goes through the same setup and validation
> steps as user-created regions, but instead of programming the decoders
> it validates that driver would have written the same values to the
> decoders as were already present.
> 
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

May want to run checkpatch on this one.

DJ

> ---
>   drivers/cxl/core/hdm.c    |    5
>   drivers/cxl/core/port.c   |    2
>   drivers/cxl/core/region.c |  496 ++++++++++++++++++++++++++++++++++++++++++++-
>   drivers/cxl/cxl.h         |   16 +
>   drivers/cxl/port.c        |   26 ++
>   5 files changed, 531 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
> index dcc16d7cb8f3..174cddfec6e8 100644
> --- a/drivers/cxl/core/hdm.c
> +++ b/drivers/cxl/core/hdm.c
> @@ -674,7 +674,7 @@ static int cxl_decoder_reset(struct cxl_decoder *cxld)
>   	up_read(&cxl_dpa_rwsem);
>   
>   	port->commit_end--;
> -	cxld->flags &= ~CXL_DECODER_F_ENABLE;
> +	cxld->flags &= ~(CXL_DECODER_F_ENABLE | CXL_DECODER_F_AUTO);
>   
>   	return 0;
>   }
> @@ -719,7 +719,7 @@ static int init_hdm_decoder(struct cxl_port *port, struct cxl_decoder *cxld,
>   
>   	/* decoders are enabled if committed */
>   	if (committed) {
> -		cxld->flags |= CXL_DECODER_F_ENABLE;
> +		cxld->flags |= CXL_DECODER_F_ENABLE | CXL_DECODER_F_AUTO;
>   		if (ctrl & CXL_HDM_DECODER0_CTRL_LOCK)
>   			cxld->flags |= CXL_DECODER_F_LOCK;
>   		if (FIELD_GET(CXL_HDM_DECODER0_CTRL_TYPE, ctrl))
> @@ -783,6 +783,7 @@ static int init_hdm_decoder(struct cxl_port *port, struct cxl_decoder *cxld,
>   		return rc;
>   	}
>   	*dpa_base += dpa_size + skip;
> +
>   	return 0;
>   }
>   
> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> index 47e450c3a5a9..8130430ffbcf 100644
> --- a/drivers/cxl/core/port.c
> +++ b/drivers/cxl/core/port.c
> @@ -446,6 +446,7 @@ bool is_endpoint_decoder(struct device *dev)
>   {
>   	return dev->type == &cxl_decoder_endpoint_type;
>   }
> +EXPORT_SYMBOL_NS_GPL(is_endpoint_decoder, CXL);
>   
>   bool is_root_decoder(struct device *dev)
>   {
> @@ -1622,6 +1623,7 @@ struct cxl_root_decoder *cxl_root_decoder_alloc(struct cxl_port *port,
>   	}
>   
>   	cxlrd->calc_hb = calc_hb;
> +	mutex_init(&cxlrd->range_lock);
>   
>   	cxld = &cxlsd->cxld;
>   	cxld->dev.type = &cxl_decoder_root_type;
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index 34cf95217901..6fe8c70790df 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -6,6 +6,7 @@
>   #include <linux/module.h>
>   #include <linux/slab.h>
>   #include <linux/uuid.h>
> +#include <linux/sort.h>
>   #include <linux/idr.h>
>   #include <cxlmem.h>
>   #include <cxl.h>
> @@ -520,7 +521,12 @@ static void cxl_region_iomem_release(struct cxl_region *cxlr)
>   	if (device_is_registered(&cxlr->dev))
>   		lockdep_assert_held_write(&cxl_region_rwsem);
>   	if (p->res) {
> -		remove_resource(p->res);
> +		/*
> +		 * Autodiscovered regions may not have been able to insert their
> +		 * resource.
> +		 */
> +		if (p->res->parent)
> +			remove_resource(p->res);
>   		kfree(p->res);
>   		p->res = NULL;
>   	}
> @@ -1101,12 +1107,35 @@ static int cxl_port_setup_targets(struct cxl_port *port,
>   		return rc;
>   	}
>   
> -	cxld->interleave_ways = iw;
> -	cxld->interleave_granularity = ig;
> -	cxld->hpa_range = (struct range) {
> -		.start = p->res->start,
> -		.end = p->res->end,
> -	};
> +	if (test_bit(CXL_REGION_F_AUTO, &cxlr->flags)) {
> +		if (cxld->interleave_ways != iw ||
> +		    cxld->interleave_granularity != ig ||
> +		    cxld->hpa_range.start != p->res->start ||
> +		    cxld->hpa_range.end != p->res->end ||
> +		    ((cxld->flags & CXL_DECODER_F_ENABLE) == 0)) {
> +			dev_err(&cxlr->dev,
> +				"%s:%s %s expected iw: %d ig: %d %pr\n",
> +				dev_name(port->uport), dev_name(&port->dev),
> +				__func__, iw, ig, p->res);
> +			dev_err(&cxlr->dev,
> +				"%s:%s %s got iw: %d ig: %d state: %s %#llx:%#llx\n",
> +				dev_name(port->uport), dev_name(&port->dev),
> +				__func__, cxld->interleave_ways,
> +				cxld->interleave_granularity,
> +				(cxld->flags & CXL_DECODER_F_ENABLE) ?
> +					"enabled" :
> +					"disabled",
> +				cxld->hpa_range.start, cxld->hpa_range.end);
> +			return -ENXIO;
> +		}
> +	} else {
> +		cxld->interleave_ways = iw;
> +		cxld->interleave_granularity = ig;
> +		cxld->hpa_range = (struct range) {
> +			.start = p->res->start,
> +			.end = p->res->end,
> +		};
> +	}
>   	dev_dbg(&cxlr->dev, "%s:%s iw: %d ig: %d\n", dev_name(port->uport),
>   		dev_name(&port->dev), iw, ig);
>   add_target:
> @@ -1117,7 +1146,17 @@ static int cxl_port_setup_targets(struct cxl_port *port,
>   			dev_name(&cxlmd->dev), dev_name(&cxled->cxld.dev), pos);
>   		return -ENXIO;
>   	}
> -	cxlsd->target[cxl_rr->nr_targets_set] = ep->dport;
> +	if (test_bit(CXL_REGION_F_AUTO, &cxlr->flags)) {
> +		if (cxlsd->target[cxl_rr->nr_targets_set] != ep->dport) {
> +			dev_dbg(&cxlr->dev, "%s:%s: %s expected %s at %d\n",
> +				dev_name(port->uport), dev_name(&port->dev),
> +				dev_name(&cxlsd->cxld.dev),
> +				dev_name(ep->dport->dport),
> +				cxl_rr->nr_targets_set);
> +			return -ENXIO;
> +		}
> +	} else
> +		cxlsd->target[cxl_rr->nr_targets_set] = ep->dport;
>   	inc = 1;
>   out_target_set:
>   	cxl_rr->nr_targets_set += inc;
> @@ -1159,6 +1198,13 @@ static void cxl_region_teardown_targets(struct cxl_region *cxlr)
>   	struct cxl_ep *ep;
>   	int i;
>   
> +	/*
> +	 * In the auto-discovery case skip automatic teardown since the
> +	 * address space is already active
> +	 */
> +	if (test_bit(CXL_REGION_F_AUTO, &cxlr->flags))
> +		return;
> +
>   	for (i = 0; i < p->nr_targets; i++) {
>   		cxled = p->targets[i];
>   		cxlmd = cxled_to_memdev(cxled);
> @@ -1191,8 +1237,8 @@ static int cxl_region_setup_targets(struct cxl_region *cxlr)
>   			iter = to_cxl_port(iter->dev.parent);
>   
>   		/*
> -		 * Descend the topology tree programming targets while
> -		 * looking for conflicts.
> +		 * Descend the topology tree programming / validating
> +		 * targets while looking for conflicts.
>   		 */
>   		for (ep = cxl_ep_load(iter, cxlmd); iter;
>   		     iter = ep->next, ep = cxl_ep_load(iter, cxlmd)) {
> @@ -1287,6 +1333,182 @@ static int cxl_region_attach_position(struct cxl_region *cxlr,
>   	return rc;
>   }
>   
> +static int cxl_region_attach_auto(struct cxl_region *cxlr,
> +				  struct cxl_endpoint_decoder *cxled, int pos)
> +{
> +	struct cxl_region_params *p = &cxlr->params;
> +
> +	if (!(cxled->cxld.flags & CXL_DECODER_F_AUTO)) {
> +		dev_err(&cxlr->dev,
> +			"%s: unable to add decoder to autodetected region\n",
> +			dev_name(&cxled->cxld.dev));
> +		return -EINVAL;
> +	}
> +
> +	if (pos >= 0) {
> +		dev_dbg(&cxlr->dev, "%s: expected auto position, not %d\n",
> +			dev_name(&cxled->cxld.dev), pos);
> +		return -EINVAL;
> +	}
> +
> +	if (p->nr_targets >= p->interleave_ways) {
> +		dev_err(&cxlr->dev, "%s: no more target slots available\n",
> +			dev_name(&cxled->cxld.dev));
> +		return -ENXIO;
> +	}
> +
> +	/*
> +	 * Temporarily record the endpoint decoder into the target array. Yes,
> +	 * this means that userspace can view devices in the wrong position
> +	 * before the region activates, and must be careful to understand when
> +	 * it might be racing region autodiscovery.
> +	 */
> +	pos = p->nr_targets;
> +	p->targets[pos] = cxled;
> +	cxled->pos = pos;
> +	p->nr_targets++;
> +
> +	return 0;
> +}
> +
> +static struct cxl_port *next_port(struct cxl_port *port)
> +{
> +	if (!port->parent_dport)
> +		return NULL;
> +	return port->parent_dport->port;
> +}
> +
> +static int decoder_match_range(struct device *dev, void *data)
> +{
> +	struct cxl_endpoint_decoder *cxled = data;
> +	struct cxl_switch_decoder *cxlsd;
> +
> +	if (!is_switch_decoder(dev))
> +		return 0;
> +
> +	cxlsd = to_cxl_switch_decoder(dev);
> +	return range_contains(&cxlsd->cxld.hpa_range, &cxled->cxld.hpa_range);
> +}
> +
> +static void find_positions(const struct cxl_switch_decoder *cxlsd,
> +			   const struct cxl_port *iter_a,
> +			   const struct cxl_port *iter_b, int *a_pos,
> +			   int *b_pos)
> +{
> +	int i;
> +
> +	for (i = 0, *a_pos = -1, *b_pos = -1; i < cxlsd->nr_targets; i++) {
> +		if (cxlsd->target[i] == iter_a->parent_dport)
> +			*a_pos = i;
> +		else if (cxlsd->target[i] == iter_b->parent_dport)
> +			*b_pos = i;
> +		if (*a_pos >= 0 && *b_pos >= 0)
> +			break;
> +	}
> +}
> +
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
> +			port = next_a;
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
>   static int cxl_region_attach(struct cxl_region *cxlr,
>   			     struct cxl_endpoint_decoder *cxled, int pos)
>   {
> @@ -1350,6 +1572,50 @@ static int cxl_region_attach(struct cxl_region *cxlr,
>   		return -EINVAL;
>   	}
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
>   	rc = cxl_region_validate_position(cxlr, cxled, pos);
>   	if (rc)
>   		return rc;
> @@ -1500,8 +1766,8 @@ static int detach_target(struct cxl_region *cxlr, int pos)
>   	return rc;
>   }
>   
> -static size_t store_targetN(struct cxl_region *cxlr, const char *buf, int pos,
> -			    size_t len)
> +static ssize_t store_targetN(struct cxl_region *cxlr, const char *buf, int pos,
> +			     size_t len)
>   {
>   	int rc;
>   
> @@ -2079,6 +2345,191 @@ static int devm_cxl_add_pmem_region(struct cxl_region *cxlr)
>   	return rc;
>   }
>   
> +static int match_decoder_by_range(struct device *dev, void *data)
> +{
> +	struct range *r1, *r2 = data;
> +	struct cxl_root_decoder *cxlrd;
> +
> +	if (!is_root_decoder(dev))
> +		return 0;
> +
> +	cxlrd = to_cxl_root_decoder(dev);
> +	r1 = &cxlrd->cxlsd.cxld.hpa_range;
> +	return range_contains(r1, r2);
> +}
> +
> +static int match_region_by_range(struct device *dev, void *data)
> +{
> +	struct cxl_region_params *p;
> +	struct cxl_region *cxlr;
> +	struct range *r = data;
> +	int rc = 0;
> +
> +	if (!is_cxl_region(dev))
> +		return 0;
> +
> +	cxlr = to_cxl_region(dev);
> +	p = &cxlr->params;
> +
> +	down_read(&cxl_region_rwsem);
> +	if (p->res && p->res->start == r->start && p->res->end == r->end)
> +		rc = 1;
> +	up_read(&cxl_region_rwsem);
> +
> +	return rc;
> +}
> +
> +/* Establish an empty region covering the given HPA range */
> +static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
> +					   struct cxl_endpoint_decoder *cxled)
> +{
> +	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
> +	struct cxl_port *port = cxlrd_to_port(cxlrd);
> +	struct range *hpa = &cxled->cxld.hpa_range;
> +	struct cxl_region_params *p;
> +	struct cxl_region *cxlr;
> +	struct resource *res;
> +	int rc;
> +
> +	do {
> +		cxlr = __create_region(cxlrd, cxled->mode,
> +				       atomic_read(&cxlrd->region_id));
> +	} while (IS_ERR(cxlr) && PTR_ERR(cxlr) == -EBUSY);
> +
> +	if (IS_ERR(cxlr)) {
> +		dev_err(cxlmd->dev.parent,
> +			"%s:%s: %s failed assign region: %ld\n",
> +			dev_name(&cxlmd->dev), dev_name(&cxled->cxld.dev),
> +			__func__, PTR_ERR(cxlr));
> +		return cxlr;
> +	}
> +
> +	down_write(&cxl_region_rwsem);
> +	p = &cxlr->params;
> +	if (p->state >= CXL_CONFIG_INTERLEAVE_ACTIVE) {
> +		dev_err(cxlmd->dev.parent,
> +			"%s:%s: %s autodiscovery interrupted\n",
> +			dev_name(&cxlmd->dev), dev_name(&cxled->cxld.dev),
> +			__func__);
> +		rc = -EBUSY;
> +		goto err;
> +	}
> +
> +	set_bit(CXL_REGION_F_AUTO, &cxlr->flags);
> +
> +	res = kmalloc(sizeof(*res), GFP_KERNEL);
> +	if (!res) {
> +		rc = -ENOMEM;
> +		goto err;
> +	}
> +
> +	*res = DEFINE_RES_MEM_NAMED(hpa->start, range_len(hpa),
> +				    dev_name(&cxlr->dev));
> +	rc = insert_resource(cxlrd->res, res);
> +	if (rc) {
> +		/*
> +		 * Platform-firmware may not have split resources like "System
> +		 * RAM" on CXL window boundaries see cxl_region_iomem_release()
> +		 */
> +		dev_warn(cxlmd->dev.parent,
> +			 "%s:%s: %s %s cannot insert resource\n",
> +			 dev_name(&cxlmd->dev), dev_name(&cxled->cxld.dev),
> +			 __func__, dev_name(&cxlr->dev));
> +	}
> +
> +	p->res = res;
> +	p->interleave_ways = cxled->cxld.interleave_ways;
> +	p->interleave_granularity = cxled->cxld.interleave_granularity;
> +	p->state = CXL_CONFIG_INTERLEAVE_ACTIVE;
> +
> +	rc = sysfs_update_group(&cxlr->dev.kobj, get_cxl_region_target_group());
> +	if (rc)
> +		goto err;
> +
> +	dev_dbg(cxlmd->dev.parent, "%s:%s: %s %s res: %pr iw: %d ig: %d\n",
> +		dev_name(&cxlmd->dev), dev_name(&cxled->cxld.dev), __func__,
> +		dev_name(&cxlr->dev), p->res, p->interleave_ways,
> +		p->interleave_granularity);
> +
> +	/* ...to match put_device() in cxl_add_to_region() */
> +	get_device(&cxlr->dev);
> +	up_write(&cxl_region_rwsem);
> +
> +	return cxlr;
> +
> +err:
> +	up_write(&cxl_region_rwsem);
> +	devm_release_action(port->uport, unregister_region, cxlr);
> +	return ERR_PTR(rc);
> +}
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
> +	}
> +
> +	dev = device_find_child(&root->dev, &cxld->hpa_range,
> +				  match_decoder_by_range);
> +	if (!dev) {
> +		dev_err(cxlmd->dev.parent,
> +			"%s:%s no CXL window for range %#llx:%#llx\n",
> +			dev_name(&cxlmd->dev), dev_name(&cxld->dev),
> +			cxld->hpa_range.start, cxld->hpa_range.end);
> +		goto out;
> +	}
> +	cxlrd = to_cxl_root_decoder(dev);
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
> +		goto out;
> +
> +	attach_target(cxlr, cxled, -1, TASK_UNINTERRUPTIBLE);
> +
> +	down_read(&cxl_region_rwsem);
> +	p = &cxlr->params;
> +	attach = p->state >= CXL_CONFIG_COMMIT;
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
>   static int cxl_region_invalidate_memregion(struct cxl_region *cxlr)
>   {
>   	if (!test_bit(CXL_REGION_F_INCOHERENT, &cxlr->flags))
> @@ -2103,6 +2554,15 @@ static int cxl_region_invalidate_memregion(struct cxl_region *cxlr)
>   	return 0;
>   }
>   
> +static int is_system_ram(struct resource *res, void *arg)
> +{
> +	struct cxl_region *cxlr = arg;
> +	struct cxl_region_params *p = &cxlr->params;
> +
> +	dev_dbg(&cxlr->dev, "%pr has System RAM: %pr\n", p->res, res);
> +	return 1;
> +}
> +
>   static int cxl_region_probe(struct device *dev)
>   {
>   	struct cxl_region *cxlr = to_cxl_region(dev);
> @@ -2136,6 +2596,18 @@ static int cxl_region_probe(struct device *dev)
>   	switch (cxlr->mode) {
>   	case CXL_DECODER_PMEM:
>   		return devm_cxl_add_pmem_region(cxlr);
> +	case CXL_DECODER_RAM:
> +		/*
> +		 * The region can not be manged by CXL if any portion of
> +		 * it is already online as 'System RAM'
> +		 */
> +		if (walk_iomem_res_desc(IORES_DESC_NONE,
> +					IORESOURCE_SYSTEM_RAM | IORESOURCE_BUSY,
> +					p->res->start, p->res->end, cxlr,
> +					is_system_ram) > 0)
> +			return 0;
> +		dev_dbg(dev, "TODO: hookup devdax\n");
> +		return 0;
>   	default:
>   		dev_dbg(&cxlr->dev, "unsupported region mode: %d\n",
>   			cxlr->mode);
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index ca76879af1de..9b3765c5c81a 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -261,6 +261,8 @@ resource_size_t cxl_rcrb_to_component(struct device *dev,
>    * cxl_decoder flags that define the type of memory / devices this
>    * decoder supports as well as configuration lock status See "CXL 2.0
>    * 8.2.5.12.7 CXL HDM Decoder 0 Control Register" for details.
> + * Additionally indicate whether decoder settings were autodetected,
> + * user customized.
>    */
>   #define CXL_DECODER_F_RAM   BIT(0)
>   #define CXL_DECODER_F_PMEM  BIT(1)
> @@ -268,6 +270,7 @@ resource_size_t cxl_rcrb_to_component(struct device *dev,
>   #define CXL_DECODER_F_TYPE3 BIT(3)
>   #define CXL_DECODER_F_LOCK  BIT(4)
>   #define CXL_DECODER_F_ENABLE    BIT(5)
> +#define CXL_DECODER_F_AUTO  BIT(6)
>   #define CXL_DECODER_F_MASK  GENMASK(5, 0)
>   
>   enum cxl_decoder_type {
> @@ -380,6 +383,7 @@ typedef struct cxl_dport *(*cxl_calc_hb_fn)(struct cxl_root_decoder *cxlrd,
>    * @region_id: region id for next region provisioning event
>    * @calc_hb: which host bridge covers the n'th position by granularity
>    * @platform_data: platform specific configuration data
> + * @range_lock: sync region autodiscovery by address range
>    * @cxlsd: base cxl switch decoder
>    */
>   struct cxl_root_decoder {
> @@ -387,6 +391,7 @@ struct cxl_root_decoder {
>   	atomic_t region_id;
>   	cxl_calc_hb_fn calc_hb;
>   	void *platform_data;
> +	struct mutex range_lock;
>   	struct cxl_switch_decoder cxlsd;
>   };
>   
> @@ -436,6 +441,13 @@ struct cxl_region_params {
>    */
>   #define CXL_REGION_F_INCOHERENT 0
>   
> +/*
> + * Indicate whether this region has been assembled by autodetection or
> + * userspace assembly. Prevent endpoint decoders outside of automatic
> + * detection from being added to the region.
> + */
> +#define CXL_REGION_F_AUTO 1
> +
>   /**
>    * struct cxl_region - CXL region
>    * @dev: This region's device
> @@ -699,6 +711,7 @@ struct cxl_nvdimm_bridge *cxl_find_nvdimm_bridge(struct device *dev);
>   #ifdef CONFIG_CXL_REGION
>   bool is_cxl_pmem_region(struct device *dev);
>   struct cxl_pmem_region *to_cxl_pmem_region(struct device *dev);
> +void cxl_add_to_region(struct cxl_endpoint_decoder *cxled);
>   #else
>   static inline bool is_cxl_pmem_region(struct device *dev)
>   {
> @@ -708,6 +721,9 @@ static inline struct cxl_pmem_region *to_cxl_pmem_region(struct device *dev)
>   {
>   	return NULL;
>   }
> +static inline void cxl_add_to_region(struct cxl_endpoint_decoder *cxled)
> +{
> +}
>   #endif
>   
>   /*
> diff --git a/drivers/cxl/port.c b/drivers/cxl/port.c
> index 5453771bf330..012a0c6f8476 100644
> --- a/drivers/cxl/port.c
> +++ b/drivers/cxl/port.c
> @@ -30,6 +30,23 @@ static void schedule_detach(void *cxlmd)
>   	schedule_cxl_memdev_detach(cxlmd);
>   }
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
>   static int cxl_port_probe(struct device *dev)
>   {
>   	struct cxl_port *port = to_cxl_port(dev);
> @@ -78,6 +95,15 @@ static int cxl_port_probe(struct device *dev)
>   		return rc;
>   	}
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
>   	return 0;
>   }
>   
> 
