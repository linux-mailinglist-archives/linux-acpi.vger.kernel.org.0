Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F698463F74
	for <lists+linux-acpi@lfdr.de>; Tue, 30 Nov 2021 21:40:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235281AbhK3Un6 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 30 Nov 2021 15:43:58 -0500
Received: from mga09.intel.com ([134.134.136.24]:7985 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233340AbhK3Un6 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 30 Nov 2021 15:43:58 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10184"; a="236136418"
X-IronPort-AV: E=Sophos;i="5.87,277,1631602800"; 
   d="scan'208";a="236136418"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2021 12:40:37 -0800
X-IronPort-AV: E=Sophos;i="5.87,277,1631602800"; 
   d="scan'208";a="654308172"
Received: from paasikivi.fi.intel.com ([10.237.72.42])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2021 12:40:36 -0800
Received: from paasikivi.fi.intel.com (localhost [127.0.0.1])
        by paasikivi.fi.intel.com (Postfix) with SMTP id 5076C20399;
        Tue, 30 Nov 2021 22:40:34 +0200 (EET)
Date:   Tue, 30 Nov 2021 22:40:34 +0200
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-acpi@vger.kernel.org, heikki.krogerus@linux.intel.com,
        rafael@kernel.org
Subject: Re: [PATCH 7/7] device property: Drop fwnode_graph_get_remote_node()
Message-ID: <YaaMQoJbXzyuCgQR@paasikivi.fi.intel.com>
References: <20211130153250.935726-1-sakari.ailus@linux.intel.com>
 <20211130153250.935726-7-sakari.ailus@linux.intel.com>
 <YaZLydKDBV9w+ve5@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YaZLydKDBV9w+ve5@smile.fi.intel.com>
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Andy,

On Tue, Nov 30, 2021 at 06:05:29PM +0200, Andy Shevchenko wrote:
> On Tue, Nov 30, 2021 at 05:32:50PM +0200, Sakari Ailus wrote:
> > fwnode_graph_get_remote_node() is only used by the tegra-video driver.
> > Convert it to use newer fwnode_graph_get_endpoint_by_id() and drop
> > now-unused fwnode_graph_get_remote_node().
> 
> ...
> 
> > -		remote = fwnode_graph_get_remote_node(fwnode, chan->portnos[0],
> > -						      0);
> > -		if (!remote)
> > +		struct fwnode_handle *ep, *remote;
> > +
> > +		ep = fwnode_graph_get_endpoint_by_id(fwnode,
> > +						     chan->portnos[0], 0, 0);
> 
> What makes you to move portnos to the next line? It's pretty much under 80.

It is. But the endpoint, the following argument, is closely related to the
port number. For that reason I'd prefer to keep it as-is.

-- 
Sakari Ailus
