Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08C3B2DEA53
	for <lists+linux-acpi@lfdr.de>; Fri, 18 Dec 2020 21:38:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727292AbgLRUiT (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 18 Dec 2020 15:38:19 -0500
Received: from mga02.intel.com ([134.134.136.20]:46793 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725910AbgLRUiT (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 18 Dec 2020 15:38:19 -0500
IronPort-SDR: doEqL8q4X8ifN6RU6EYrU4q5be2CnNLqwhM6Jn7AXGZAktdPvCDQeEu7rysPSiDqHXdS0o3OL9
 n85zkTZbdUBw==
X-IronPort-AV: E=McAfee;i="6000,8403,9839"; a="162552123"
X-IronPort-AV: E=Sophos;i="5.78,431,1599548400"; 
   d="scan'208";a="162552123"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Dec 2020 12:36:33 -0800
IronPort-SDR: CJGGsgjAnED17c7rHYmqR189sjRUg428iZbJS01yIwtKb/2js5v66dvmM7+PG2bXoXTZCA4RJ6
 B02vIPGoFyZw==
X-IronPort-AV: E=Sophos;i="5.78,431,1599548400"; 
   d="scan'208";a="339143177"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Dec 2020 12:36:27 -0800
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1kqMVE-00FgLb-BC; Fri, 18 Dec 2020 22:37:28 +0200
Date:   Fri, 18 Dec 2020 22:37:28 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Daniel Scally <djrscally@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-media@vger.kernel.org, devel@acpica.org, rjw@rjwysocki.net,
        lenb@kernel.org, gregkh@linuxfoundation.org, yong.zhi@intel.com,
        sakari.ailus@linux.intel.com, bingbu.cao@intel.com,
        tian.shu.qiu@intel.com, mchehab@kernel.org, robert.moore@intel.com,
        erik.kaneda@intel.com, pmladek@suse.com, rostedt@goodmis.org,
        sergey.senozhatsky@gmail.com, linux@rasmusvillemoes.dk,
        laurent.pinchart+renesas@ideasonboard.com,
        jacopo+renesas@jmondi.org, kieran.bingham+renesas@ideasonboard.com,
        linus.walleij@linaro.org, heikki.krogerus@linux.intel.com,
        kitakar@gmail.com, jorhand@linux.microsoft.com
Subject: Re: [PATCH v2 06/12] software_node: Add support for fwnode_graph*()
 family of functions
Message-ID: <20201218203728.GC4077@smile.fi.intel.com>
References: <20201217234337.1983732-1-djrscally@gmail.com>
 <20201217234337.1983732-7-djrscally@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201217234337.1983732-7-djrscally@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, Dec 17, 2020 at 11:43:31PM +0000, Daniel Scally wrote:
> From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> 
> This implements the remaining .graph_* callbacks in the
> fwnode operations structure for the software nodes. That makes
> the fwnode_graph*() functions available in the drivers also
> when software nodes are used.
> 
> The implementation tries to mimic the "OF graph" as much as
> possible, but there is no support for the "reg" device
> property. The ports will need to have the index in their
> name which starts with "port@" (for example "port@0", "port@1",
> ...) and endpoints will use the index of the software node
> that is given to them during creation. The port nodes can
> also be grouped under a specially named "ports" subnode,
> just like in DT, if necessary.
> 
> The remote-endpoints are reference properties under the
> endpoint nodes that are named "remote-endpoint".

...

> +	while ((port = software_node_get_next_child(parent, old))) {
> +		if (!strncmp(to_swnode(port)->node->name, "port", 4))
> +			return port;
> +		old = port;
> +	}

Dunno if we need defines for port and its length here.

...

> +	ret = kstrtou32(swnode->parent->node->name + 5, 10, &endpoint->port);

But here at least comment is needed what 5 means ('port@' I suppose).

> +	if (ret)
> +		return ret;


-- 
With Best Regards,
Andy Shevchenko


