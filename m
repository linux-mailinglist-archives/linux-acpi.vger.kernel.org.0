Return-Path: <linux-acpi+bounces-12119-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 91D4AA5DBAF
	for <lists+linux-acpi@lfdr.de>; Wed, 12 Mar 2025 12:36:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D8F3189CA39
	for <lists+linux-acpi@lfdr.de>; Wed, 12 Mar 2025 11:37:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FE4923E335;
	Wed, 12 Mar 2025 11:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NTKDesOH"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AB2B125B9;
	Wed, 12 Mar 2025 11:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741779414; cv=none; b=BTANKzYkG3RrI0uhQxQ9vEf6G0q3Q/mZdK/XUv4+kWt7fiJFz/O9+PKWJ9nt0j8X3kjDbxLbOCA5ZhqDsRIjOs9ENptQsThVX/OyBGqYxfEotIN46dsTL84J8V0DgnM/72FJcfOGu1GktwHX79I9WQmGMpyneQrlzfK6nAFuhI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741779414; c=relaxed/simple;
	bh=FroqwxIZyxWRy8NxvaPvPbyYXAPIL2q9WyJPpH0RPSg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fA25mca34MXTKZ21bvPcZoi18V/FRMlXU557NzQDoRIOHQAR7FkAxjkx+Vnayr/BZDdu0JUxo+MRxzEfl5gj5iITzTzeTtP3tnT9JdGU2RQcz/v8Y0rd3UpgUMX09W93jk7yjE8cLGn9na7vl1zNXwGi21cyjBceteZ+FX4Rgoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NTKDesOH; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741779412; x=1773315412;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=FroqwxIZyxWRy8NxvaPvPbyYXAPIL2q9WyJPpH0RPSg=;
  b=NTKDesOHtbZwDpTgRd4Q0t053owpfPIhIaGmFb6OD9mc0wTtmi1sEWIv
   HwEnf4zQEMRuxGcEMMrDrwx2CTfqYznJ3WpPpUrTystEOSezqdo29lzlH
   Wna1Cqqt29OUWPTdivLOaqnlPz3tns/kI1+DOdfntkmW6UIWpmLbnNqMK
   uCssiWMME2OnMXemlW1g52fkWyM4SaIJSQfxq6TAUeMoOzLY5Xk0kooIA
   v47rfh8c2DXpCRu816jjVIf5GZZnINKQW5UEt+AVI57QnqpM8qCWo4dXb
   OIBNDKIoBrrPomomvN/ILQ1PxzD3UDtUeIc2BPiyjrey6LyTuow7j74Oo
   Q==;
X-CSE-ConnectionGUID: bGJizVzWQ+OKLs+IrFuQ9g==
X-CSE-MsgGUID: +yLE7NjjTvOiF0GyFsGZlw==
X-IronPort-AV: E=McAfee;i="6700,10204,11370"; a="30435652"
X-IronPort-AV: E=Sophos;i="6.14,241,1736841600"; 
   d="scan'208";a="30435652"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2025 04:36:51 -0700
X-CSE-ConnectionGUID: fGXdclrDSciibe9q+Rtoxw==
X-CSE-MsgGUID: sx2y6Q16R1eOzj0C7o4Ymw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,241,1736841600"; 
   d="scan'208";a="120635886"
Received: from kuha.fi.intel.com ([10.237.72.152])
  by fmviesa007.fm.intel.com with SMTP; 12 Mar 2025 04:36:45 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Wed, 12 Mar 2025 13:36:44 +0200
Date: Wed, 12 Mar 2025 13:36:44 +0200
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rob Herring (Arm)" <robh@kernel.org>,
	Markus Elfring <elfring@users.sourceforge.net>,
	Jakob Riepler <jakob+lkml@paranoidlabs.org>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-leds@vger.kernel.org, linux-usb@vger.kernel.org,
	Daniel Scally <djrscally@gmail.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>, Lee Jones <lee@kernel.org>,
	Pavel Machek <pavel@kernel.org>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	Jonathan Cameron <jic23@kernel.org>
Subject: Re: [PATCH v1 4/4] usb: typec: tcpm: Use
 fwnode_get_child_node_count()
Message-ID: <Z9FxzECvo5o7zaVH@kuha.fi.intel.com>
References: <20250310150835.3139322-1-andriy.shevchenko@linux.intel.com>
 <20250310150835.3139322-5-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250310150835.3139322-5-andriy.shevchenko@linux.intel.com>

On Mon, Mar 10, 2025 at 04:54:54PM +0200, Andy Shevchenko wrote:
> Since fwnode_get_child_node_count() was split from its device property
> counterpart, we may utilise it in the driver and drop custom implementation.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
>  drivers/usb/typec/tcpm/tcpm.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
> index 9c455f073233..8ca2e26752fb 100644
> --- a/drivers/usb/typec/tcpm/tcpm.c
> +++ b/drivers/usb/typec/tcpm/tcpm.c
> @@ -7166,7 +7166,7 @@ static void tcpm_fw_get_timings(struct tcpm_port *port, struct fwnode_handle *fw
>  
>  static int tcpm_fw_get_caps(struct tcpm_port *port, struct fwnode_handle *fwnode)
>  {
> -	struct fwnode_handle *capabilities, *child, *caps = NULL;
> +	struct fwnode_handle *capabilities, *caps = NULL;
>  	unsigned int nr_src_pdo, nr_snk_pdo;
>  	const char *opmode_str;
>  	u32 *src_pdo, *snk_pdo;
> @@ -7232,9 +7232,7 @@ static int tcpm_fw_get_caps(struct tcpm_port *port, struct fwnode_handle *fwnode
>  	if (!capabilities) {
>  		port->pd_count = 1;
>  	} else {
> -		fwnode_for_each_child_node(capabilities, child)
> -			port->pd_count++;
> -
> +		port->pd_count = fwnode_get_child_node_count(capabilities);
>  		if (!port->pd_count) {
>  			ret = -ENODATA;
>  			goto put_capabilities;
> -- 
> 2.47.2

-- 
heikki

