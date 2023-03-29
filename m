Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BEE96CF5C0
	for <lists+linux-acpi@lfdr.de>; Wed, 29 Mar 2023 23:59:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229560AbjC2V7F (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 29 Mar 2023 17:59:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229631AbjC2V7E (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 29 Mar 2023 17:59:04 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B4ED2D42;
        Wed, 29 Mar 2023 14:59:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680127144; x=1711663144;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=P4UXw9IN3l3kABiav7VesKbmtNbF0RyI0/oXrQ6HTsA=;
  b=NeKINmQnFY/fRWp5B3vT0b3dmwJvMfBRnijTb7YOcKH90MIM0MKQvWGo
   pU7qqHb7bP/s0+Y0qXdu3J7XQq7LePApjReHLygjhrsf5gUWTzqi1rZIo
   bpaEeLmk56kyp4RxTzFR4t8XuykvQ9D+6jpgFFCJVZ5X5LstIszKHHWFq
   VQLegrWxQ04AuEuVvdsB4yvoP4S8Fue4UYOYbhokhXiwUUWbA/UO0bTdd
   YYMp5hhUux42z/yEyRIHm5YXCx4QsJvMjle6yP8KiZwu/v4ncybFt/hHe
   4dCCXVfePYExOg49cOxbGbf9bunwcPtyWFjXkTGZx/fZ73P6tcCA1TZ2N
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10664"; a="324927781"
X-IronPort-AV: E=Sophos;i="5.98,301,1673942400"; 
   d="scan'208";a="324927781"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2023 14:59:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10664"; a="661761067"
X-IronPort-AV: E=Sophos;i="5.98,301,1673942400"; 
   d="scan'208";a="661761067"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO aschofie-mobl2) ([10.209.80.248])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2023 14:59:03 -0700
Date:   Wed, 29 Mar 2023 14:59:01 -0700
From:   Alison Schofield <alison.schofield@intel.com>
To:     Dave Jiang <dave.jiang@intel.com>
Cc:     linux-cxl@vger.kernel.org, linux-acpi@vger.kernel.org,
        dan.j.williams@intel.com, ira.weiny@intel.com,
        vishal.l.verma@intel.com, rafael@kernel.org, lukas@wunner.de
Subject: Re: [PATCH v2 06/21] cxl: Add callback to parse the DSLBIS subtable
 from CDAT
Message-ID: <ZCS0pShjnJM9v4vN@aschofie-mobl2>
References: <167995336797.2857312.539473939839316778.stgit@djiang5-mobl3>
 <167995347963.2857312.11781710463537827645.stgit@djiang5-mobl3>
 <ZCOJ8+k4K8jIco57@aschofie-mobl2>
 <4f51aade-faf2-fa63-2795-3207d82c14aa@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4f51aade-faf2-fa63-2795-3207d82c14aa@intel.com>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, Mar 29, 2023 at 01:59:12PM -0700, Dave Jiang wrote:
> 
> 
> On 3/28/23 5:44 PM, Alison Schofield wrote:
> > On Mon, Mar 27, 2023 at 02:44:39PM -0700, Dave Jiang wrote:
> > > Provide a callback to parse the Device Scoped Latency and Bandwidth
> > > Information Structure (DSLBIS) in the CDAT structures. The DSLBIS
> > > contains the bandwidth and latency information that's tied to a DSMAS
> > > handle. The driver will retrieve the read and write latency and
> > > bandwidth associated with the DSMAS which is tied to a DPA range.
> > > 
> > > Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> > > 
> > > ---
> > > v2:
> > > - Add size check to DSLIBIS table. (Lukas)
> > > - Remove unnecessary entry type check. (Jonathan)
> > > - Move data_type check to after match. (Jonathan)
> > > - Skip unknown data type. (Jonathan)
> > > - Add overflow check for unit multiply. (Jonathan)
> > > - Use dev_warn() when entries parsing fail. (Jonathan)
> > > ---
> > >   drivers/cxl/core/cdat.c |   41 +++++++++++++++++++++++++++++++++++++++++
> > >   drivers/cxl/cxlpci.h    |   34 +++++++++++++++++++++++++++++++++-
> > >   drivers/cxl/port.c      |    9 ++++++++-
> > >   3 files changed, 82 insertions(+), 2 deletions(-)
> > > 

snip

> > > --- a/drivers/cxl/port.c
> > > +++ b/drivers/cxl/port.c
> > > @@ -152,8 +152,15 @@ static int cxl_port_probe(struct device *dev)
> > >   			rc = cdat_table_parse_dsmas(port->cdat.table,
> > >   						    cxl_dsmas_parse_entry,
> > >   						    (void *)&dsmas_list);
> > > -			if (rc < 0)
> > > +			if (rc > 0) {
> > > +				rc = cdat_table_parse_dslbis(port->cdat.table,
> > > +							     cxl_dslbis_parse_entry,
> > > +							     (void *)&dsmas_list);
> > > +				if (rc <= 0)
> > > +					dev_warn(dev, "Failed to parse DSLBIS: %d\n", rc);
> > > +			} else {
> > >   				dev_warn(dev, "Failed to parse DSMAS: %d\n", rc);
> > > +			}
> > 
> > I see you touch this func more than once. Maybe some earlier nips and
> > tucks, makes this more readable.
> 
> Not sure what you mean.

I thought this was the same func, cxl_port_probe(), that I commented
on in the previous patch, so maybe it was already getting re-aligned.

> 
> > 
> > >   			dsmas_list_destroy(&dsmas_list);
> > >   		}
> > > 
> > > 
