Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E023691AD3
	for <lists+linux-acpi@lfdr.de>; Fri, 10 Feb 2023 10:07:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231720AbjBJJHq (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 10 Feb 2023 04:07:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231737AbjBJJHA (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 10 Feb 2023 04:07:00 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABF84BB9A;
        Fri, 10 Feb 2023 01:06:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676020000; x=1707556000;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=xg87SwclHTz/KBBQ2o6kd8aRFgOzWf7Clc07w0ozOXQ=;
  b=W32/MnAvCX9l6dwMwhZWBSPTkKacNetL9nYsnQzBzBtQssAn2h2lZsxe
   kFbLzQNf8TZo0x4CTB27IhAxpn07IIPpRKyRVb63CphZNaXcvFMAGG9kl
   s9OlY90WrCH+T8XnTUVL4pQkXdsHlLILRdMNtaYZJ8F+CoZU5G9NyOr9A
   WZRSe5OjQ8GtbQHg0KU9pxkyXgKwAcITYbvDUbpV08rFlIShx0LVWb0Es
   3aLa6ygt3eMxS6vw/fPxKJIiUaZnkNJE8KgUqGztB2KSHnWXv7snQ3ePp
   pscz884uaJ1VFmU+Le89RuGd2ewvzlaCyUYXJgPRARCbpx1SoSRjhkaoD
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10616"; a="329003112"
X-IronPort-AV: E=Sophos;i="5.97,286,1669104000"; 
   d="scan'208";a="329003112"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2023 01:06:40 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10616"; a="913463913"
X-IronPort-AV: E=Sophos;i="5.97,286,1669104000"; 
   d="scan'208";a="913463913"
Received: from hrchavan-mobl.amr.corp.intel.com (HELO dwillia2-xfh.jf.intel.com) ([10.209.46.42])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2023 01:06:40 -0800
Subject: [PATCH v2 13/20] cxl/region: Add region autodiscovery
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     Fan Ni <fan.ni@samsung.com>, vishal.l.verma@intel.com,
        dave.hansen@linux.intel.com, linux-mm@kvack.org,
        linux-acpi@vger.kernel.org
Date:   Fri, 10 Feb 2023 01:06:39 -0800
Message-ID: <167601999958.1924368.9366954455835735048.stgit@dwillia2-xfh.jf.intel.com>
In-Reply-To: <167601992097.1924368.18291887895351917895.stgit@dwillia2-xfh.jf.intel.com>
References: <167601992097.1924368.18291887895351917895.stgit@dwillia2-xfh.jf.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Region autodiscovery is an asynchronous state machine advanced by
cxl_port_probe(). After the decoders on an endpoint port are enumerated
they are scanned for actively enabled instances. Each active decoder is
flagged for auto-assembly CXL_DECODER_F_AUTO and attached to a region.
If a region does not already exist for the address range setting of the
decoder one is created. That creation process may race with other
decoders of the same region being discovered since cxl_port_probe() is
asynchronous. A new 'struct cxl_root_decoder' lock, @range_lock, is
introduced to mitigate that race.

Once all decoders have arrived, "p->nr_targets == p->interleave_ways",
they are sorted by their relative decode position. The sort algorithm
involves finding the point in the cxl_port topology where one leg of the
decode leads to deviceA and the other deviceB. At that point in the
topology the target order in the 'struct cxl_switch_decoder' indicates
the relative position of those endpoint decoders in the region.

>From that point the region goes through the same setup and validation
steps as user-created regions, but instead of programming the decoders
it validates that driver would have written the same values to the
decoders as were already present.

Tested-by: Fan Ni <fan.ni@samsung.com>
Link: https://lore.kernel.org/r/167564540972.847146.17096178433176097831.stgit@dwillia2-xfh.jf.intel.com
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/cxl/core/hdm.c    |   11 +
 drivers/cxl/core/port.c   |    2 
 drivers/cxl/core/region.c |  497 ++++++++++++++++++++++++++++++++++++++++++++-
 drivers/cxl/cxl.h         |   29 +++
 drivers/cxl/port.c        |   48 ++++
 5 files changed, 576 insertions(+), 11 deletions(-)

diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
index a0891c3464f1..8c29026a4b9d 100644
--- a/drivers/cxl/core/hdm.c
+++ b/drivers/cxl/core/hdm.c
@@ -676,6 +676,14 @@ static int cxl_decoder_reset(struct cxl_decoder *cxld)
 	port->commit_end--;
 	cxld->flags &= ~CXL_DECODER_F_ENABLE;
 
+	/* Userspace is now responsible for reconfiguring this decoder */
+	if (is_endpoint_decoder(&cxld->dev)) {
+		struct cxl_endpoint_decoder *cxled;
+
+		cxled = to_cxl_endpoint_decoder(&cxld->dev);
+		cxled->state = CXL_DECODER_STATE_MANUAL;
+	}
+
 	return 0;
 }
 
@@ -783,6 +791,9 @@ static int init_hdm_decoder(struct cxl_port *port, struct cxl_decoder *cxld,
 		return rc;
 	}
 	*dpa_base += dpa_size + skip;
+
+	cxled->state = CXL_DECODER_STATE_AUTO;
+
 	return 0;
 }
 
diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index 9e5df64ea6b5..59620528571a 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -446,6 +446,7 @@ bool is_endpoint_decoder(struct device *dev)
 {
 	return dev->type == &cxl_decoder_endpoint_type;
 }
+EXPORT_SYMBOL_NS_GPL(is_endpoint_decoder, CXL);
 
 bool is_root_decoder(struct device *dev)
 {
@@ -1628,6 +1629,7 @@ struct cxl_root_decoder *cxl_root_decoder_alloc(struct cxl_port *port,
 	}
 
 	cxlrd->calc_hb = calc_hb;
+	mutex_init(&cxlrd->range_lock);
 
 	cxld = &cxlsd->cxld;
 	cxld->dev.type = &cxl_decoder_root_type;
diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 691605f1e120..3f6453da2c51 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -6,6 +6,7 @@
 #include <linux/module.h>
 #include <linux/slab.h>
 #include <linux/uuid.h>
+#include <linux/sort.h>
 #include <linux/idr.h>
 #include <cxlmem.h>
 #include <cxl.h>
@@ -524,7 +525,12 @@ static void cxl_region_iomem_release(struct cxl_region *cxlr)
 	if (device_is_registered(&cxlr->dev))
 		lockdep_assert_held_write(&cxl_region_rwsem);
 	if (p->res) {
-		remove_resource(p->res);
+		/*
+		 * Autodiscovered regions may not have been able to insert their
+		 * resource.
+		 */
+		if (p->res->parent)
+			remove_resource(p->res);
 		kfree(p->res);
 		p->res = NULL;
 	}
@@ -1105,12 +1111,35 @@ static int cxl_port_setup_targets(struct cxl_port *port,
 		return rc;
 	}
 
-	cxld->interleave_ways = iw;
-	cxld->interleave_granularity = ig;
-	cxld->hpa_range = (struct range) {
-		.start = p->res->start,
-		.end = p->res->end,
-	};
+	if (test_bit(CXL_REGION_F_AUTO, &cxlr->flags)) {
+		if (cxld->interleave_ways != iw ||
+		    cxld->interleave_granularity != ig ||
+		    cxld->hpa_range.start != p->res->start ||
+		    cxld->hpa_range.end != p->res->end ||
+		    ((cxld->flags & CXL_DECODER_F_ENABLE) == 0)) {
+			dev_err(&cxlr->dev,
+				"%s:%s %s expected iw: %d ig: %d %pr\n",
+				dev_name(port->uport), dev_name(&port->dev),
+				__func__, iw, ig, p->res);
+			dev_err(&cxlr->dev,
+				"%s:%s %s got iw: %d ig: %d state: %s %#llx:%#llx\n",
+				dev_name(port->uport), dev_name(&port->dev),
+				__func__, cxld->interleave_ways,
+				cxld->interleave_granularity,
+				(cxld->flags & CXL_DECODER_F_ENABLE) ?
+					"enabled" :
+					"disabled",
+				cxld->hpa_range.start, cxld->hpa_range.end);
+			return -ENXIO;
+		}
+	} else {
+		cxld->interleave_ways = iw;
+		cxld->interleave_granularity = ig;
+		cxld->hpa_range = (struct range) {
+			.start = p->res->start,
+			.end = p->res->end,
+		};
+	}
 	dev_dbg(&cxlr->dev, "%s:%s iw: %d ig: %d\n", dev_name(port->uport),
 		dev_name(&port->dev), iw, ig);
 add_target:
@@ -1121,7 +1150,17 @@ static int cxl_port_setup_targets(struct cxl_port *port,
 			dev_name(&cxlmd->dev), dev_name(&cxled->cxld.dev), pos);
 		return -ENXIO;
 	}
-	cxlsd->target[cxl_rr->nr_targets_set] = ep->dport;
+	if (test_bit(CXL_REGION_F_AUTO, &cxlr->flags)) {
+		if (cxlsd->target[cxl_rr->nr_targets_set] != ep->dport) {
+			dev_dbg(&cxlr->dev, "%s:%s: %s expected %s at %d\n",
+				dev_name(port->uport), dev_name(&port->dev),
+				dev_name(&cxlsd->cxld.dev),
+				dev_name(ep->dport->dport),
+				cxl_rr->nr_targets_set);
+			return -ENXIO;
+		}
+	} else
+		cxlsd->target[cxl_rr->nr_targets_set] = ep->dport;
 	inc = 1;
 out_target_set:
 	cxl_rr->nr_targets_set += inc;
@@ -1163,6 +1202,13 @@ static void cxl_region_teardown_targets(struct cxl_region *cxlr)
 	struct cxl_ep *ep;
 	int i;
 
+	/*
+	 * In the auto-discovery case skip automatic teardown since the
+	 * address space is already active
+	 */
+	if (test_bit(CXL_REGION_F_AUTO, &cxlr->flags))
+		return;
+
 	for (i = 0; i < p->nr_targets; i++) {
 		cxled = p->targets[i];
 		cxlmd = cxled_to_memdev(cxled);
@@ -1195,8 +1241,8 @@ static int cxl_region_setup_targets(struct cxl_region *cxlr)
 			iter = to_cxl_port(iter->dev.parent);
 
 		/*
-		 * Descend the topology tree programming targets while
-		 * looking for conflicts.
+		 * Descend the topology tree programming / validating
+		 * targets while looking for conflicts.
 		 */
 		for (ep = cxl_ep_load(iter, cxlmd); iter;
 		     iter = ep->next, ep = cxl_ep_load(iter, cxlmd)) {
@@ -1291,6 +1337,185 @@ static int cxl_region_attach_position(struct cxl_region *cxlr,
 	return rc;
 }
 
+static int cxl_region_attach_auto(struct cxl_region *cxlr,
+				  struct cxl_endpoint_decoder *cxled, int pos)
+{
+	struct cxl_region_params *p = &cxlr->params;
+
+	if (cxled->state != CXL_DECODER_STATE_AUTO) {
+		dev_err(&cxlr->dev,
+			"%s: unable to add decoder to autodetected region\n",
+			dev_name(&cxled->cxld.dev));
+		return -EINVAL;
+	}
+
+	if (pos >= 0) {
+		dev_dbg(&cxlr->dev, "%s: expected auto position, not %d\n",
+			dev_name(&cxled->cxld.dev), pos);
+		return -EINVAL;
+	}
+
+	if (p->nr_targets >= p->interleave_ways) {
+		dev_err(&cxlr->dev, "%s: no more target slots available\n",
+			dev_name(&cxled->cxld.dev));
+		return -ENXIO;
+	}
+
+	/*
+	 * Temporarily record the endpoint decoder into the target array. Yes,
+	 * this means that userspace can view devices in the wrong position
+	 * before the region activates, and must be careful to understand when
+	 * it might be racing region autodiscovery.
+	 */
+	pos = p->nr_targets;
+	p->targets[pos] = cxled;
+	cxled->pos = pos;
+	p->nr_targets++;
+
+	return 0;
+}
+
+static struct cxl_port *next_port(struct cxl_port *port)
+{
+	if (!port->parent_dport)
+		return NULL;
+	return port->parent_dport->port;
+}
+
+static int decoder_match_range(struct device *dev, void *data)
+{
+	struct cxl_endpoint_decoder *cxled = data;
+	struct cxl_switch_decoder *cxlsd;
+
+	if (!is_switch_decoder(dev))
+		return 0;
+
+	cxlsd = to_cxl_switch_decoder(dev);
+	return range_contains(&cxlsd->cxld.hpa_range, &cxled->cxld.hpa_range);
+}
+
+static void find_positions(const struct cxl_switch_decoder *cxlsd,
+			   const struct cxl_port *iter_a,
+			   const struct cxl_port *iter_b, int *a_pos,
+			   int *b_pos)
+{
+	int i;
+
+	for (i = 0, *a_pos = -1, *b_pos = -1; i < cxlsd->nr_targets; i++) {
+		if (cxlsd->target[i] == iter_a->parent_dport)
+			*a_pos = i;
+		else if (cxlsd->target[i] == iter_b->parent_dport)
+			*b_pos = i;
+		if (*a_pos >= 0 && *b_pos >= 0)
+			break;
+	}
+}
+
+static int cmp_decode_pos(const void *a, const void *b)
+{
+	struct cxl_endpoint_decoder *cxled_a = *(typeof(cxled_a) *)a;
+	struct cxl_endpoint_decoder *cxled_b = *(typeof(cxled_b) *)b;
+	struct cxl_memdev *cxlmd_a = cxled_to_memdev(cxled_a);
+	struct cxl_memdev *cxlmd_b = cxled_to_memdev(cxled_b);
+	struct cxl_port *port_a = cxled_to_port(cxled_a);
+	struct cxl_port *port_b = cxled_to_port(cxled_b);
+	struct cxl_port *iter_a, *iter_b, *port = NULL;
+	struct cxl_switch_decoder *cxlsd;
+	struct device *dev;
+	int a_pos, b_pos;
+	unsigned int seq;
+
+	/* Exit early if any prior sorting failed */
+	if (cxled_a->pos < 0 || cxled_b->pos < 0)
+		return 0;
+
+	/*
+	 * Walk up the hierarchy to find a shared port, find the decoder that
+	 * maps the range, compare the relative position of those dport
+	 * mappings.
+	 */
+	for (iter_a = port_a; iter_a; iter_a = next_port(iter_a)) {
+		struct cxl_port *next_a, *next_b;
+
+		next_a = next_port(iter_a);
+		if (!next_a)
+			break;
+
+		for (iter_b = port_b; iter_b; iter_b = next_port(iter_b)) {
+			next_b = next_port(iter_b);
+			if (next_a != next_b)
+				continue;
+			port = next_a;
+			break;
+		}
+
+		if (port)
+			break;
+	}
+
+	if (!port) {
+		dev_err(cxlmd_a->dev.parent,
+			"failed to find shared port with %s\n",
+			dev_name(cxlmd_b->dev.parent));
+		goto err;
+	}
+
+	dev = device_find_child(&port->dev, cxled_a, decoder_match_range);
+	if (!dev) {
+		struct range *range = &cxled_a->cxld.hpa_range;
+
+		dev_err(port->uport,
+			"failed to find decoder that maps %#llx-%#llx\n",
+			range->start, range->end);
+		goto err;
+	}
+
+	cxlsd = to_cxl_switch_decoder(dev);
+	do {
+		seq = read_seqbegin(&cxlsd->target_lock);
+		find_positions(cxlsd, iter_a, iter_b, &a_pos, &b_pos);
+	} while (read_seqretry(&cxlsd->target_lock, seq));
+
+	put_device(dev);
+
+	if (a_pos < 0 || b_pos < 0) {
+		dev_err(port->uport,
+			"failed to find shared decoder for %s and %s\n",
+			dev_name(cxlmd_a->dev.parent),
+			dev_name(cxlmd_b->dev.parent));
+		goto err;
+	}
+
+	dev_dbg(port->uport, "%s comes %s %s\n", dev_name(cxlmd_a->dev.parent),
+		a_pos - b_pos < 0 ? "before" : "after",
+		dev_name(cxlmd_b->dev.parent));
+
+	return a_pos - b_pos;
+err:
+	cxled_a->pos = -1;
+	return 0;
+}
+
+static int cxl_region_sort_targets(struct cxl_region *cxlr)
+{
+	struct cxl_region_params *p = &cxlr->params;
+	int i, rc = 0;
+
+	sort(p->targets, p->nr_targets, sizeof(p->targets[0]), cmp_decode_pos,
+	     NULL);
+
+	for (i = 0; i < p->nr_targets; i++) {
+		struct cxl_endpoint_decoder *cxled = p->targets[i];
+
+		if (cxled->pos < 0)
+			rc = -ENXIO;
+		cxled->pos = i;
+	}
+
+	dev_dbg(&cxlr->dev, "region sort %s\n", rc ? "failed" : "successful");
+	return rc;
+}
+
 static int cxl_region_attach(struct cxl_region *cxlr,
 			     struct cxl_endpoint_decoder *cxled, int pos)
 {
@@ -1354,6 +1579,50 @@ static int cxl_region_attach(struct cxl_region *cxlr,
 		return -EINVAL;
 	}
 
+	if (test_bit(CXL_REGION_F_AUTO, &cxlr->flags)) {
+		int i;
+
+		rc = cxl_region_attach_auto(cxlr, cxled, pos);
+		if (rc)
+			return rc;
+
+		/* await more targets to arrive... */
+		if (p->nr_targets < p->interleave_ways)
+			return 0;
+
+		/*
+		 * All targets are here, which implies all PCI enumeration that
+		 * affects this region has been completed. Walk the topology to
+		 * sort the devices into their relative region decode position.
+		 */
+		rc = cxl_region_sort_targets(cxlr);
+		if (rc)
+			return rc;
+
+		for (i = 0; i < p->nr_targets; i++) {
+			cxled = p->targets[i];
+			ep_port = cxled_to_port(cxled);
+			dport = cxl_find_dport_by_dev(root_port,
+						      ep_port->host_bridge);
+			rc = cxl_region_attach_position(cxlr, cxlrd, cxled,
+							dport, i);
+			if (rc)
+				return rc;
+		}
+
+		rc = cxl_region_setup_targets(cxlr);
+		if (rc)
+			return rc;
+
+		/*
+		 * If target setup succeeds in the autodiscovery case
+		 * then the region is already committed.
+		 */
+		p->state = CXL_CONFIG_COMMIT;
+
+		return 0;
+	}
+
 	rc = cxl_region_validate_position(cxlr, cxled, pos);
 	if (rc)
 		return rc;
@@ -2087,6 +2356,193 @@ static int devm_cxl_add_pmem_region(struct cxl_region *cxlr)
 	return rc;
 }
 
+static int match_decoder_by_range(struct device *dev, void *data)
+{
+	struct range *r1, *r2 = data;
+	struct cxl_root_decoder *cxlrd;
+
+	if (!is_root_decoder(dev))
+		return 0;
+
+	cxlrd = to_cxl_root_decoder(dev);
+	r1 = &cxlrd->cxlsd.cxld.hpa_range;
+	return range_contains(r1, r2);
+}
+
+static int match_region_by_range(struct device *dev, void *data)
+{
+	struct cxl_region_params *p;
+	struct cxl_region *cxlr;
+	struct range *r = data;
+	int rc = 0;
+
+	if (!is_cxl_region(dev))
+		return 0;
+
+	cxlr = to_cxl_region(dev);
+	p = &cxlr->params;
+
+	down_read(&cxl_region_rwsem);
+	if (p->res && p->res->start == r->start && p->res->end == r->end)
+		rc = 1;
+	up_read(&cxl_region_rwsem);
+
+	return rc;
+}
+
+/* Establish an empty region covering the given HPA range */
+static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
+					   struct cxl_endpoint_decoder *cxled)
+{
+	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
+	struct cxl_port *port = cxlrd_to_port(cxlrd);
+	struct range *hpa = &cxled->cxld.hpa_range;
+	struct cxl_region_params *p;
+	struct cxl_region *cxlr;
+	struct resource *res;
+	int rc;
+
+	do {
+		cxlr = __create_region(cxlrd, cxled->mode,
+				       atomic_read(&cxlrd->region_id));
+	} while (IS_ERR(cxlr) && PTR_ERR(cxlr) == -EBUSY);
+
+	if (IS_ERR(cxlr)) {
+		dev_err(cxlmd->dev.parent,
+			"%s:%s: %s failed assign region: %ld\n",
+			dev_name(&cxlmd->dev), dev_name(&cxled->cxld.dev),
+			__func__, PTR_ERR(cxlr));
+		return cxlr;
+	}
+
+	down_write(&cxl_region_rwsem);
+	p = &cxlr->params;
+	if (p->state >= CXL_CONFIG_INTERLEAVE_ACTIVE) {
+		dev_err(cxlmd->dev.parent,
+			"%s:%s: %s autodiscovery interrupted\n",
+			dev_name(&cxlmd->dev), dev_name(&cxled->cxld.dev),
+			__func__);
+		rc = -EBUSY;
+		goto err;
+	}
+
+	set_bit(CXL_REGION_F_AUTO, &cxlr->flags);
+
+	res = kmalloc(sizeof(*res), GFP_KERNEL);
+	if (!res) {
+		rc = -ENOMEM;
+		goto err;
+	}
+
+	*res = DEFINE_RES_MEM_NAMED(hpa->start, range_len(hpa),
+				    dev_name(&cxlr->dev));
+	rc = insert_resource(cxlrd->res, res);
+	if (rc) {
+		/*
+		 * Platform-firmware may not have split resources like "System
+		 * RAM" on CXL window boundaries see cxl_region_iomem_release()
+		 */
+		dev_warn(cxlmd->dev.parent,
+			 "%s:%s: %s %s cannot insert resource\n",
+			 dev_name(&cxlmd->dev), dev_name(&cxled->cxld.dev),
+			 __func__, dev_name(&cxlr->dev));
+	}
+
+	p->res = res;
+	p->interleave_ways = cxled->cxld.interleave_ways;
+	p->interleave_granularity = cxled->cxld.interleave_granularity;
+	p->state = CXL_CONFIG_INTERLEAVE_ACTIVE;
+
+	rc = sysfs_update_group(&cxlr->dev.kobj, get_cxl_region_target_group());
+	if (rc)
+		goto err;
+
+	dev_dbg(cxlmd->dev.parent, "%s:%s: %s %s res: %pr iw: %d ig: %d\n",
+		dev_name(&cxlmd->dev), dev_name(&cxled->cxld.dev), __func__,
+		dev_name(&cxlr->dev), p->res, p->interleave_ways,
+		p->interleave_granularity);
+
+	/* ...to match put_device() in cxl_add_to_region() */
+	get_device(&cxlr->dev);
+	up_write(&cxl_region_rwsem);
+
+	return cxlr;
+
+err:
+	up_write(&cxl_region_rwsem);
+	devm_release_action(port->uport, unregister_region, cxlr);
+	return ERR_PTR(rc);
+}
+
+int cxl_add_to_region(struct cxl_port *root, struct cxl_endpoint_decoder *cxled)
+{
+	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
+	struct range *hpa = &cxled->cxld.hpa_range;
+	struct cxl_decoder *cxld = &cxled->cxld;
+	struct cxl_root_decoder *cxlrd;
+	struct cxl_region_params *p;
+	struct cxl_region *cxlr;
+	bool attach = false;
+	struct device *dev;
+	int rc;
+
+	dev = device_find_child(&root->dev, &cxld->hpa_range,
+				match_decoder_by_range);
+	if (!dev) {
+		dev_err(cxlmd->dev.parent,
+			"%s:%s no CXL window for range %#llx:%#llx\n",
+			dev_name(&cxlmd->dev), dev_name(&cxld->dev),
+			cxld->hpa_range.start, cxld->hpa_range.end);
+		return -ENXIO;
+	}
+
+	cxlrd = to_cxl_root_decoder(dev);
+
+	/*
+	 * Ensure that if multiple threads race to construct_region() for @hpa
+	 * one does the construction and the others add to that.
+	 */
+	mutex_lock(&cxlrd->range_lock);
+	dev = device_find_child(&cxlrd->cxlsd.cxld.dev, hpa,
+				match_region_by_range);
+	if (!dev)
+		cxlr = construct_region(cxlrd, cxled);
+	else
+		cxlr = to_cxl_region(dev);
+	mutex_unlock(&cxlrd->range_lock);
+
+	if (IS_ERR(cxlr)) {
+		rc = PTR_ERR(cxlr);
+		goto out;
+	}
+
+	attach_target(cxlr, cxled, -1, TASK_UNINTERRUPTIBLE);
+
+	down_read(&cxl_region_rwsem);
+	p = &cxlr->params;
+	attach = p->state == CXL_CONFIG_COMMIT;
+	up_read(&cxl_region_rwsem);
+
+	if (attach) {
+		int rc = device_attach(&cxlr->dev);
+
+		/*
+		 * If device_attach() fails the range may still be active via
+		 * the platform-firmware memory map, otherwise the driver for
+		 * regions is local to this file, so driver matching can't fail.
+		 */
+		if (rc < 0)
+			dev_err(&cxlr->dev, "failed to enable, range: %pr\n",
+				p->res);
+	}
+
+	put_device(&cxlr->dev);
+out:
+	put_device(&cxlrd->cxlsd.cxld.dev);
+	return rc;
+}
+EXPORT_SYMBOL_NS_GPL(cxl_add_to_region, CXL);
+
 static int cxl_region_invalidate_memregion(struct cxl_region *cxlr)
 {
 	if (!test_bit(CXL_REGION_F_INCOHERENT, &cxlr->flags))
@@ -2111,6 +2567,15 @@ static int cxl_region_invalidate_memregion(struct cxl_region *cxlr)
 	return 0;
 }
 
+static int is_system_ram(struct resource *res, void *arg)
+{
+	struct cxl_region *cxlr = arg;
+	struct cxl_region_params *p = &cxlr->params;
+
+	dev_dbg(&cxlr->dev, "%pr has System RAM: %pr\n", p->res, res);
+	return 1;
+}
+
 static int cxl_region_probe(struct device *dev)
 {
 	struct cxl_region *cxlr = to_cxl_region(dev);
@@ -2144,6 +2609,18 @@ static int cxl_region_probe(struct device *dev)
 	switch (cxlr->mode) {
 	case CXL_DECODER_PMEM:
 		return devm_cxl_add_pmem_region(cxlr);
+	case CXL_DECODER_RAM:
+		/*
+		 * The region can not be manged by CXL if any portion of
+		 * it is already online as 'System RAM'
+		 */
+		if (walk_iomem_res_desc(IORES_DESC_NONE,
+					IORESOURCE_SYSTEM_RAM | IORESOURCE_BUSY,
+					p->res->start, p->res->end, cxlr,
+					is_system_ram) > 0)
+			return 0;
+		dev_dbg(dev, "TODO: hookup devdax\n");
+		return 0;
 	default:
 		dev_dbg(&cxlr->dev, "unsupported region mode: %d\n",
 			cxlr->mode);
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index ca76879af1de..c8ee4bb8cce6 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -261,6 +261,8 @@ resource_size_t cxl_rcrb_to_component(struct device *dev,
  * cxl_decoder flags that define the type of memory / devices this
  * decoder supports as well as configuration lock status See "CXL 2.0
  * 8.2.5.12.7 CXL HDM Decoder 0 Control Register" for details.
+ * Additionally indicate whether decoder settings were autodetected,
+ * user customized.
  */
 #define CXL_DECODER_F_RAM   BIT(0)
 #define CXL_DECODER_F_PMEM  BIT(1)
@@ -334,12 +336,22 @@ static inline const char *cxl_decoder_mode_name(enum cxl_decoder_mode mode)
 	return "mixed";
 }
 
+/*
+ * Track whether this decoder is reserved for region autodiscovery, or
+ * free for userspace provisioning.
+ */
+enum cxl_decoder_state {
+	CXL_DECODER_STATE_MANUAL,
+	CXL_DECODER_STATE_AUTO,
+};
+
 /**
  * struct cxl_endpoint_decoder - Endpoint  / SPA to DPA decoder
  * @cxld: base cxl_decoder_object
  * @dpa_res: actively claimed DPA span of this decoder
  * @skip: offset into @dpa_res where @cxld.hpa_range maps
  * @mode: which memory type / access-mode-partition this decoder targets
+ * @state: autodiscovery state
  * @pos: interleave position in @cxld.region
  */
 struct cxl_endpoint_decoder {
@@ -347,6 +359,7 @@ struct cxl_endpoint_decoder {
 	struct resource *dpa_res;
 	resource_size_t skip;
 	enum cxl_decoder_mode mode;
+	enum cxl_decoder_state state;
 	int pos;
 };
 
@@ -380,6 +393,7 @@ typedef struct cxl_dport *(*cxl_calc_hb_fn)(struct cxl_root_decoder *cxlrd,
  * @region_id: region id for next region provisioning event
  * @calc_hb: which host bridge covers the n'th position by granularity
  * @platform_data: platform specific configuration data
+ * @range_lock: sync region autodiscovery by address range
  * @cxlsd: base cxl switch decoder
  */
 struct cxl_root_decoder {
@@ -387,6 +401,7 @@ struct cxl_root_decoder {
 	atomic_t region_id;
 	cxl_calc_hb_fn calc_hb;
 	void *platform_data;
+	struct mutex range_lock;
 	struct cxl_switch_decoder cxlsd;
 };
 
@@ -436,6 +451,13 @@ struct cxl_region_params {
  */
 #define CXL_REGION_F_INCOHERENT 0
 
+/*
+ * Indicate whether this region has been assembled by autodetection or
+ * userspace assembly. Prevent endpoint decoders outside of automatic
+ * detection from being added to the region.
+ */
+#define CXL_REGION_F_AUTO 1
+
 /**
  * struct cxl_region - CXL region
  * @dev: This region's device
@@ -699,6 +721,8 @@ struct cxl_nvdimm_bridge *cxl_find_nvdimm_bridge(struct device *dev);
 #ifdef CONFIG_CXL_REGION
 bool is_cxl_pmem_region(struct device *dev);
 struct cxl_pmem_region *to_cxl_pmem_region(struct device *dev);
+int cxl_add_to_region(struct cxl_port *root,
+		      struct cxl_endpoint_decoder *cxled);
 #else
 static inline bool is_cxl_pmem_region(struct device *dev)
 {
@@ -708,6 +732,11 @@ static inline struct cxl_pmem_region *to_cxl_pmem_region(struct device *dev)
 {
 	return NULL;
 }
+static inline int cxl_add_to_region(struct cxl_port *root,
+				    struct cxl_endpoint_decoder *cxled)
+{
+	return 0;
+}
 #endif
 
 /*
diff --git a/drivers/cxl/port.c b/drivers/cxl/port.c
index a8d46a67b45e..d88518836c2d 100644
--- a/drivers/cxl/port.c
+++ b/drivers/cxl/port.c
@@ -30,6 +30,34 @@ static void schedule_detach(void *cxlmd)
 	schedule_cxl_memdev_detach(cxlmd);
 }
 
+static int discover_region(struct device *dev, void *root)
+{
+	struct cxl_endpoint_decoder *cxled;
+	int rc;
+
+	if (!is_endpoint_decoder(dev))
+		return 0;
+
+	cxled = to_cxl_endpoint_decoder(dev);
+	if ((cxled->cxld.flags & CXL_DECODER_F_ENABLE) == 0)
+		return 0;
+
+	if (cxled->state != CXL_DECODER_STATE_AUTO)
+		return 0;
+
+	/*
+	 * Region enumeration is opportunistic, if this add-event fails,
+	 * continue to the next endpoint decoder.
+	 */
+	rc = cxl_add_to_region(root, cxled);
+	if (rc)
+		dev_dbg(dev, "failed to add to region: %#llx-%#llx\n",
+			cxled->cxld.hpa_range.start, cxled->cxld.hpa_range.end);
+
+	return 0;
+}
+
+
 static int cxl_switch_port_probe(struct cxl_port *port)
 {
 	struct cxl_hdm *cxlhdm;
@@ -54,6 +82,7 @@ static int cxl_endpoint_port_probe(struct cxl_port *port)
 	struct cxl_memdev *cxlmd = to_cxl_memdev(port->uport);
 	struct cxl_dev_state *cxlds = cxlmd->cxlds;
 	struct cxl_hdm *cxlhdm;
+	struct cxl_port *root;
 	int rc;
 
 	cxlhdm = devm_cxl_setup_hdm(port);
@@ -78,7 +107,24 @@ static int cxl_endpoint_port_probe(struct cxl_port *port)
 		return rc;
 	}
 
-	return devm_cxl_enumerate_decoders(cxlhdm);
+	rc = devm_cxl_enumerate_decoders(cxlhdm);
+	if (rc)
+		return rc;
+
+	/*
+	 * This can't fail in practice as CXL root exit unregisters all
+	 * descendant ports and that in turn synchronizes with cxl_port_probe()
+	 */
+	root = find_cxl_root(&cxlmd->dev);
+
+	/*
+	 * Now that all endpoint decoders are successfully enumerated, try to
+	 * assemble regions from committed decoders
+	 */
+	device_for_each_child(&port->dev, root, discover_region);
+	put_device(&root->dev);
+
+	return 0;
 }
 
 static int cxl_port_probe(struct device *dev)

