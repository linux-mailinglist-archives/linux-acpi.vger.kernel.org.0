Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BDB42DFB7D
	for <lists+linux-acpi@lfdr.de>; Mon, 21 Dec 2020 12:28:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726196AbgLUL1g (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 21 Dec 2020 06:27:36 -0500
Received: from mga03.intel.com ([134.134.136.65]:16561 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725907AbgLUL1g (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 21 Dec 2020 06:27:36 -0500
IronPort-SDR: 8trWpxcyvhZLqpxlZUTtwQ3/XH0FoeeeE/RsRcF0v1CsjEUYWGru11nYuMZNLUqvlxCPiySgNE
 fE88+RlQJquw==
X-IronPort-AV: E=McAfee;i="6000,8403,9841"; a="175811325"
X-IronPort-AV: E=Sophos;i="5.78,436,1599548400"; 
   d="scan'208";a="175811325"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Dec 2020 03:25:50 -0800
IronPort-SDR: Ruzlnmfcv9D1b7FsVnR64liNeineniqLbyQ/pLIu2fSbduGK6T9jBHtkTqcX239cJEUN41NB7C
 UpEroqRA8Zsw==
X-IronPort-AV: E=Sophos;i="5.78,436,1599548400"; 
   d="scan'208";a="563511809"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Dec 2020 03:25:44 -0800
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1krJKu-00GJki-KA; Mon, 21 Dec 2020 13:26:44 +0200
Date:   Mon, 21 Dec 2020 13:26:44 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Sakari Ailus <sakari.ailus@linux.intel.com>
Cc:     Daniel Scally <djrscally@gmail.com>, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-media@vger.kernel.org,
        devel@acpica.org, rjw@rjwysocki.net, lenb@kernel.org,
        gregkh@linuxfoundation.org, yong.zhi@intel.com,
        bingbu.cao@intel.com, tian.shu.qiu@intel.com, mchehab@kernel.org,
        robert.moore@intel.com, erik.kaneda@intel.com, pmladek@suse.com,
        rostedt@goodmis.org, sergey.senozhatsky@gmail.com,
        linux@rasmusvillemoes.dk,
        laurent.pinchart+renesas@ideasonboard.com,
        jacopo+renesas@jmondi.org, kieran.bingham+renesas@ideasonboard.com,
        linus.walleij@linaro.org, heikki.krogerus@linux.intel.com,
        kitakar@gmail.com, jorhand@linux.microsoft.com,
        kernel test robot <lkp@intel.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [PATCH v2 05/12] software_node: unregister software_nodes in
 reverse order
Message-ID: <20201221112644.GJ4077@smile.fi.intel.com>
References: <20201217234337.1983732-1-djrscally@gmail.com>
 <20201217234337.1983732-6-djrscally@gmail.com>
 <20201221092116.GG26370@paasikivi.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201221092116.GG26370@paasikivi.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, Dec 21, 2020 at 11:21:16AM +0200, Sakari Ailus wrote:
> On Thu, Dec 17, 2020 at 11:43:30PM +0000, Daniel Scally wrote:
> > To maintain consistency with software_node_unregister_nodes(), reverse
> > the order in which the software_node_unregister_node_group() function
> > unregisters nodes.

...

> >  void software_node_unregister_node_group(const struct software_node **node_group)
> >  {
> > -	unsigned int i;
> > +	unsigned int i = 0;
> >  
> >  	if (!node_group)
> >  		return;
> >  
> > -	for (i = 0; node_group[i]; i++)
> > +	while (node_group[i]->name)
> 
> Why is this change made? node_group is a NULL-terminated array, and the
> above accesses the name pointer on each entry before checking the entry is
> non-NULL. Or do I miss something here?

I believe it's a copy'n'paste typo.

> > +		i++;
> > +
> > +	while (i--)
> >  		software_node_unregister(node_group[i]);
> >  }

-- 
With Best Regards,
Andy Shevchenko


