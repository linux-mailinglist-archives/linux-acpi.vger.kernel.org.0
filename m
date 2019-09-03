Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E6530A6644
	for <lists+linux-acpi@lfdr.de>; Tue,  3 Sep 2019 12:10:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726946AbfICKKS (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 3 Sep 2019 06:10:18 -0400
Received: from mga18.intel.com ([134.134.136.126]:13332 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726840AbfICKKR (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 3 Sep 2019 06:10:17 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Sep 2019 03:10:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,462,1559545200"; 
   d="scan'208";a="198739312"
Received: from kuha.fi.intel.com ([10.237.72.53])
  by fmsmga001.fm.intel.com with SMTP; 03 Sep 2019 03:10:14 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Tue, 03 Sep 2019 13:10:13 +0300
Date:   Tue, 3 Sep 2019 13:10:13 +0300
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Sakari Ailus <sakari.ailus@linux.intel.com>
Cc:     Petr Mladek <pmladek@suse.com>, linux-kernel@vger.kernel.org,
        rafael@kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-acpi@vger.kernel.org, devicetree@vger.kernel.org,
        Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v5 05/11] device property: Add fwnode_get_name for
 returning the name of a node
Message-ID: <20190903101013.GA23603@kuha.fi.intel.com>
References: <20190902135732.23455-1-sakari.ailus@linux.intel.com>
 <20190902135732.23455-6-sakari.ailus@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190902135732.23455-6-sakari.ailus@linux.intel.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Sakari,

On Mon, Sep 02, 2019 at 04:57:26PM +0300, Sakari Ailus wrote:
> diff --git a/drivers/base/swnode.c b/drivers/base/swnode.c
> index 951e7efd47c23..a4a0f5b80bad3 100644
> --- a/drivers/base/swnode.c
> +++ b/drivers/base/swnode.c
> @@ -515,6 +515,25 @@ static int software_node_read_string_array(const struct fwnode_handle *fwnode,
>  						propname, val, nval);
>  }
>  
> +static const char *
> +software_node_get_name(const struct fwnode_handle *fwnode)
> +{
> +	const struct software_node *softnode = to_software_node(fwnode);
> +	const struct swnode *swnode = software_node_to_swnode(softnode);

Why not just:

        struct swnode *swnode = to_swnode(fwnode);

> +	struct fwnode_handle *parent;
> +
> +	if (!swnode)
> +		return "(null)";
> +
> +	parent = fwnode_get_parent(&swnode->fwnode);
> +	if (!parent)
> +		return "";

Please note that there is no root software node object (the kset is
the root), so you will get "" with most nodes. I'm assuming that is
not the intention, or is it?

> +	fwnode_handle_put(parent);
> +
> +	return kobject_name(&swnode->kobj);
> +}
> +
>  static struct fwnode_handle *
>  software_node_get_parent(const struct fwnode_handle *fwnode)
>  {
> @@ -615,6 +634,7 @@ static const struct fwnode_operations software_node_ops = {
>  	.property_present = software_node_property_present,
>  	.property_read_int_array = software_node_read_int_array,
>  	.property_read_string_array = software_node_read_string_array,
> +	.get_name = software_node_get_name,
>  	.get_parent = software_node_get_parent,
>  	.get_next_child_node = software_node_get_next_child,
>  	.get_named_child_node = software_node_get_named_child_node,

thanks,

-- 
heikki
