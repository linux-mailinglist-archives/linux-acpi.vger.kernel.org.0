Return-Path: <linux-acpi+bounces-1348-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 87F3C7E5201
	for <lists+linux-acpi@lfdr.de>; Wed,  8 Nov 2023 09:32:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 31F24B20E09
	for <lists+linux-acpi@lfdr.de>; Wed,  8 Nov 2023 08:32:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E233DDBA
	for <lists+linux-acpi@lfdr.de>; Wed,  8 Nov 2023 08:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bOWlFGsF"
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAC8DD28E
	for <linux-acpi@vger.kernel.org>; Wed,  8 Nov 2023 07:36:37 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B0D612B
	for <linux-acpi@vger.kernel.org>; Tue,  7 Nov 2023 23:36:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699428997; x=1730964997;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=6yvD8OQcTusgIkNEfjl1aaRmRmsTs6gntTbWvUWBcHo=;
  b=bOWlFGsFArp6qlF1zaRm7seU/ma/397yuMdaSYZsKh68umpctwiPI0B/
   SGtstHXQrzHIbiZ4RZmFif4LCzuy6tw6RcO5be+nRUHfob/Is6Q20Q0Hn
   2ozK3OnCcS0HidY+H5rmjtNQlcXBnokg+h9//k2unYgEosWXMswHWY5p2
   60rVY6wDvrXedDjWAYMhjrDnbW5mSbGmDj2DvBTMjxcoLO4FDxwol2HTy
   jENBjrFiXLQ9szXROuxwZm+471QmpPlcsbVdbDbH8pAhgsH9XlzHICDPt
   jToazWTexscjE7iT+79jSKTrCE51GIM8UDWVAXdpCIlLk7Ylgr6uudF04
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10887"; a="456205474"
X-IronPort-AV: E=Sophos;i="6.03,285,1694761200"; 
   d="scan'208";a="456205474"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2023 23:36:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10887"; a="828876744"
X-IronPort-AV: E=Sophos;i="6.03,285,1694761200"; 
   d="scan'208";a="828876744"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by fmsmga008.fm.intel.com with SMTP; 07 Nov 2023 23:36:33 -0800
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Wed, 08 Nov 2023 09:36:32 +0200
Date: Wed, 8 Nov 2023 09:36:32 +0200
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: linux-acpi@vger.kernel.org, andriy.shevchenko@linux.intel.com,
	Daniel Scally <djrscally@gmail.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v4 2/3] software node: Let args be NULL in
 software_node_get_reference_args
Message-ID: <ZUs6gNk/wEqhj1EZ@kuha.fi.intel.com>
References: <20231103083625.1229008-1-sakari.ailus@linux.intel.com>
 <20231103083625.1229008-3-sakari.ailus@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231103083625.1229008-3-sakari.ailus@linux.intel.com>

On Fri, Nov 03, 2023 at 10:36:24AM +0200, Sakari Ailus wrote:
> fwnode_get_property_reference_args() may not be called with args argument
> NULL and while OF already supports this. Add the missing NULL check.
> 
> The purpose is to be able to count the references.
> 
> Fixes: b06184acf751 ("software node: Add software_node_get_reference_args()")
> Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
>  drivers/base/swnode.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/base/swnode.c b/drivers/base/swnode.c
> index 1886995a0b3a..079bd14bdedc 100644
> --- a/drivers/base/swnode.c
> +++ b/drivers/base/swnode.c
> @@ -541,6 +541,9 @@ software_node_get_reference_args(const struct fwnode_handle *fwnode,
>  	if (nargs > NR_FWNODE_REFERENCE_ARGS)
>  		return -EINVAL;
>  
> +	if (!args)
> +		return 0;
> +
>  	args->fwnode = software_node_get(refnode);
>  	args->nargs = nargs;
>  
> -- 
> 2.39.2

-- 
heikki

