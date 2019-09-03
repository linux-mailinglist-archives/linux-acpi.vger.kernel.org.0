Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 67328A6750
	for <lists+linux-acpi@lfdr.de>; Tue,  3 Sep 2019 13:24:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728094AbfICLYS (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 3 Sep 2019 07:24:18 -0400
Received: from mga03.intel.com ([134.134.136.65]:18313 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727077AbfICLYS (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 3 Sep 2019 07:24:18 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Sep 2019 04:24:17 -0700
X-IronPort-AV: E=Sophos;i="5.64,462,1559545200"; 
   d="scan'208";a="207053380"
Received: from paasikivi.fi.intel.com ([10.237.72.42])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Sep 2019 04:24:15 -0700
Received: by paasikivi.fi.intel.com (Postfix, from userid 1000)
        id 6BB9320375; Tue,  3 Sep 2019 14:24:13 +0300 (EEST)
Date:   Tue, 3 Sep 2019 14:24:13 +0300
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     Petr Mladek <pmladek@suse.com>, linux-kernel@vger.kernel.org,
        rafael@kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-acpi@vger.kernel.org, devicetree@vger.kernel.org,
        Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v5 05/11] device property: Add fwnode_get_name for
 returning the name of a node
Message-ID: <20190903112413.GQ5475@paasikivi.fi.intel.com>
References: <20190902135732.23455-1-sakari.ailus@linux.intel.com>
 <20190902135732.23455-6-sakari.ailus@linux.intel.com>
 <20190903101013.GA23603@kuha.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190903101013.GA23603@kuha.fi.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Moi,

Thanks for the comments.

On Tue, Sep 03, 2019 at 01:10:13PM +0300, Heikki Krogerus wrote:
> Hi Sakari,
> 
> On Mon, Sep 02, 2019 at 04:57:26PM +0300, Sakari Ailus wrote:
> > diff --git a/drivers/base/swnode.c b/drivers/base/swnode.c
> > index 951e7efd47c23..a4a0f5b80bad3 100644
> > --- a/drivers/base/swnode.c
> > +++ b/drivers/base/swnode.c
> > @@ -515,6 +515,25 @@ static int software_node_read_string_array(const struct fwnode_handle *fwnode,
> >  						propname, val, nval);
> >  }
> >  
> > +static const char *
> > +software_node_get_name(const struct fwnode_handle *fwnode)
> > +{
> > +	const struct software_node *softnode = to_software_node(fwnode);
> > +	const struct swnode *swnode = software_node_to_swnode(softnode);
> 
> Why not just:
> 
>         struct swnode *swnode = to_swnode(fwnode);

Fixed.

> 
> > +	struct fwnode_handle *parent;
> > +
> > +	if (!swnode)
> > +		return "(null)";
> > +
> > +	parent = fwnode_get_parent(&swnode->fwnode);
> > +	if (!parent)
> > +		return "";
> 
> Please note that there is no root software node object (the kset is
> the root), so you will get "" with most nodes. I'm assuming that is
> not the intention, or is it?

Good point.

In practice this will happen rarely outside the tests, but indeed the root
node would usually not be a software node. I'll drop the above three lines
checking for the parent node, and change nodes created in the test
accordingly.

-- 
Terveisin,

Sakari Ailus
sakari.ailus@linux.intel.com
