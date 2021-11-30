Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 050A5463AED
	for <lists+linux-acpi@lfdr.de>; Tue, 30 Nov 2021 17:03:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229783AbhK3QHN (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 30 Nov 2021 11:07:13 -0500
Received: from mga01.intel.com ([192.55.52.88]:37541 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243333AbhK3QHM (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 30 Nov 2021 11:07:12 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10183"; a="260204733"
X-IronPort-AV: E=Sophos;i="5.87,276,1631602800"; 
   d="scan'208";a="260204733"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2021 08:02:40 -0800
X-IronPort-AV: E=Sophos;i="5.87,276,1631602800"; 
   d="scan'208";a="559641609"
Received: from smile.fi.intel.com ([10.237.72.184])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2021 08:02:39 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1ms5ZX-000bQg-4V;
        Tue, 30 Nov 2021 18:01:35 +0200
Date:   Tue, 30 Nov 2021 18:01:34 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Sakari Ailus <sakari.ailus@linux.intel.com>
Cc:     linux-acpi@vger.kernel.org, heikki.krogerus@linux.intel.com,
        rafael@kernel.org,
        /tmp/small/0000-cover-letter.patch@punajuuri.localdomain
Subject: Re: [PATCH 5/7] device property: Implement
 fwnode_graph_get_endpoint_count()
Message-ID: <YaZK3m37RpcQeSnO@smile.fi.intel.com>
References: <20211130153250.935726-1-sakari.ailus@linux.intel.com>
 <20211130153250.935726-5-sakari.ailus@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211130153250.935726-5-sakari.ailus@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, Nov 30, 2021 at 05:32:48PM +0200, Sakari Ailus wrote:
> Add fwnode_graph_get_endpoint_count() function to provide generic
> implementation of of_graph_get_endpoint_count(). The former by default
> only counts endpoints to available devices which is consistent with the
> rest of the fwnode graph API. By providing FWNODE_GRAPH_DEVICE_DISABLED
> flag, also unconnected endpoints and endpoints to disabled devices are
> counted.

...

> +	fwnode_graph_for_each_endpoint(fwnode, ep) {
> +		if (!(flags & FWNODE_GRAPH_DEVICE_DISABLED) &&
> +		    !fwnode_graph_remote_available(ep))
> +			continue;

> +		count++;

Can't it be more straightforward to write it as

		if (flags & FWNODE_GRAPH_DEVICE_DISABLED ||
		    fwnode_graph_remote_available(ep))
			count++;

?

> +	}

-- 
With Best Regards,
Andy Shevchenko


