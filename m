Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B2B32A5625
	for <lists+linux-acpi@lfdr.de>; Mon,  2 Sep 2019 14:34:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730059AbfIBMeg (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 2 Sep 2019 08:34:36 -0400
Received: from mga06.intel.com ([134.134.136.31]:28972 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729942AbfIBMeg (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 2 Sep 2019 08:34:36 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 Sep 2019 05:34:35 -0700
X-IronPort-AV: E=Sophos;i="5.64,459,1559545200"; 
   d="scan'208";a="183299004"
Received: from paasikivi.fi.intel.com ([10.237.72.42])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 Sep 2019 05:34:33 -0700
Received: by paasikivi.fi.intel.com (Postfix, from userid 1000)
        id 3D7FD20B48; Mon,  2 Sep 2019 15:34:31 +0300 (EEST)
Date:   Mon, 2 Sep 2019 15:34:31 +0300
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Petr Mladek <pmladek@suse.com>, linux-kernel@vger.kernel.org,
        rafael@kernel.org, linux-acpi@vger.kernel.org,
        devicetree@vger.kernel.org, Rob Herring <robh@kernel.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>
Subject: Re: [PATCH v4 04/11] device property: Add functions for accessing
 node's parents
Message-ID: <20190902123431.GK5475@paasikivi.fi.intel.com>
References: <20190902083240.20367-1-sakari.ailus@linux.intel.com>
 <20190902083240.20367-5-sakari.ailus@linux.intel.com>
 <20190902101426.GB2680@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190902101426.GB2680@smile.fi.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Andy,

On Mon, Sep 02, 2019 at 01:14:26PM +0300, Andy Shevchenko wrote:
> On Mon, Sep 02, 2019 at 11:32:33AM +0300, Sakari Ailus wrote:
> > Add two convenience functions for accessing node's parents:
> > 
> > fwnode_count_parents() returns the number of parent nodes a given node
> > has. fwnode_get_nth_parent() returns node's parent at a given distance
> > from the node itself.
> > 
> 
> Much better now, thanks!
> 
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> 
> though one question below.

Thanks!

...

> > +/**
> > + * fwnode_get_nth_parent - Return an nth parent of a node
> > + * @fwnode: The node the parent of which is requested
> > + * @depth: Distance of the parent from the node
> > + *
> > + * Returns the nth parent of a node. If @depth is 0, the functionality is
> > + * equivalent to fwnode_handle_get(). For @depth == 1, it is fwnode_get_parent()
> > + * and so on.
> > + *
> > + * The caller is responsible for calling fwnode_handle_put() for the returned
> > + * node.
> > + */
> > +struct fwnode_handle *fwnode_get_nth_parent(struct fwnode_handle *fwnode,
> > +					    unsigned int depth)
> > +{
> > +	unsigned int i;
> > +
> > +	fwnode_handle_get(fwnode);
> > +
> > +	for (i = 0; i < depth && fwnode; i++)
> > +		fwnode = fwnode_get_next_parent(fwnode);
> > +
> 
> If 'fnode == NULL' and 'i < depth', shan't we return some kind of error?

How about adding to the comment, after the first sentence of the
description:

	If there is no parent at the requested depth, NULL is returned.

-- 
Sakari Ailus
sakari.ailus@linux.intel.com
