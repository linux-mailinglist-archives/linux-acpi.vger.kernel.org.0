Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 23FDBA36C6
	for <lists+linux-acpi@lfdr.de>; Fri, 30 Aug 2019 14:27:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727967AbfH3M1l (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 30 Aug 2019 08:27:41 -0400
Received: from mga17.intel.com ([192.55.52.151]:12352 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726969AbfH3M1l (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 30 Aug 2019 08:27:41 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 30 Aug 2019 05:27:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,447,1559545200"; 
   d="scan'208";a="198026261"
Received: from kuha.fi.intel.com ([10.237.72.53])
  by fmsmga001.fm.intel.com with SMTP; 30 Aug 2019 05:27:27 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Fri, 30 Aug 2019 15:27:26 +0300
Date:   Fri, 30 Aug 2019 15:27:26 +0300
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Sakari Ailus <sakari.ailus@linux.intel.com>
Cc:     Petr Mladek <pmladek@suse.com>, linux-kernel@vger.kernel.org,
        rafael@kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-acpi@vger.kernel.org, devicetree@vger.kernel.org,
        Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v3 02/10] software node: Make argument to
 to_software_node const
Message-ID: <20190830122726.GB1636@kuha.fi.intel.com>
References: <20190829101043.24963-1-sakari.ailus@linux.intel.com>
 <20190829101043.24963-3-sakari.ailus@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190829101043.24963-3-sakari.ailus@linux.intel.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, Aug 29, 2019 at 01:10:35PM +0300, Sakari Ailus wrote:
> to_software_node() does not need to modify the fwnode_handle it operates
> on; therefore make it const. This allows passing a const fwnode_handle to
> to_software_node().
> 
> Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>

OK by me.

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com

> ---
>  drivers/base/swnode.c    | 4 ++--
>  include/linux/property.h | 3 ++-
>  2 files changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/base/swnode.c b/drivers/base/swnode.c
> index a7cb41812cfda..951e7efd47c23 100644
> --- a/drivers/base/swnode.c
> +++ b/drivers/base/swnode.c
> @@ -71,9 +71,9 @@ software_node_to_swnode(const struct software_node *node)
>  	return swnode;
>  }
>  
> -const struct software_node *to_software_node(struct fwnode_handle *fwnode)
> +const struct software_node *to_software_node(const struct fwnode_handle *fwnode)
>  {
> -	struct swnode *swnode = to_swnode(fwnode);
> +	const struct swnode *swnode = to_swnode(fwnode);
>  
>  	return swnode ? swnode->node : NULL;
>  }
> diff --git a/include/linux/property.h b/include/linux/property.h
> index 5a910ad795910..421c76e53708d 100644
> --- a/include/linux/property.h
> +++ b/include/linux/property.h
> @@ -418,7 +418,8 @@ struct software_node {
>  };
>  
>  bool is_software_node(const struct fwnode_handle *fwnode);
> -const struct software_node *to_software_node(struct fwnode_handle *fwnode);
> +const struct software_node *
> +to_software_node(const struct fwnode_handle *fwnode);
>  struct fwnode_handle *software_node_fwnode(const struct software_node *node);
>  
>  int software_node_register_nodes(const struct software_node *nodes);
> -- 
> 2.20.1

thanks,

-- 
heikki
