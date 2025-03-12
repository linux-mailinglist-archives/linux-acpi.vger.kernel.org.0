Return-Path: <linux-acpi+bounces-12118-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E43FA5DBAA
	for <lists+linux-acpi@lfdr.de>; Wed, 12 Mar 2025 12:36:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1576F3B4073
	for <lists+linux-acpi@lfdr.de>; Wed, 12 Mar 2025 11:36:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FF2A23BD13;
	Wed, 12 Mar 2025 11:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="h6+2M7m6"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D7FA1E51EE;
	Wed, 12 Mar 2025 11:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741779382; cv=none; b=ZRz67NSt/m3cbztMvNxnUtivee+0NrsYwOZX9P8NT4D7L5ozk1B6q4Yh10xPFH6uI7s9u7WXWx/AWDdJhGZrAdom1Jpq3PlMftmZhJIRl3hCNrVNQ7I90HXVVkl2q6gaOvYHQql2nRM1P7yJ1ZS9OjVxxG9ieB81TjhUwI7x6Kc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741779382; c=relaxed/simple;
	bh=smuwPilPoSGBkymto7bgxCwZ/rQ5k9wabH4RRs3dx1s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Kr2Usgi3BhEkBCJdSrL4hm4UkLfFQ+gMCo2fdeit10g7i8DvZEl719qmc9ypbhNl+sclFZL5uQZtmPZ0LuvIYoldx0Ctuvjc/a9TivnfKzL51PRHCSMR0/Uy+4KJ4u7ss8fxHgkdZFl6OUiCrAZJ8Xr21DlSSB1i9yZVIuATPeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=h6+2M7m6; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741779380; x=1773315380;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=smuwPilPoSGBkymto7bgxCwZ/rQ5k9wabH4RRs3dx1s=;
  b=h6+2M7m6ZMmNuGP5gl5fjAFhOi0HKo/pkN5vin+gJBRWBdVRrJR0T9eL
   DXkaGg2lq45xwMeXcon9Tlcznca3wDXQ/a/87e28cMI9FFEhB3O88j1HI
   OCLKrC6DXqWN20mhwq3Hgo8RYSjuDb/HUJFuqREGZAue7i7KmE9XM81wr
   H47ZRO4aHHsSbJye4hbM7TGtEU+c6+o2BW1X6mOEUuKiBJiSAwHF/T+Fj
   obzyPs7g8l7xh4AnudQ+VfwoEJCLO/wskZkFAHumtzpl7Ae0ICoU69E9H
   l1BzOvLVWBl+OK1WPEkGJ5vSuXckyy1fCP3ZIGG0wgjegVGVUcFnTDf0s
   w==;
X-CSE-ConnectionGUID: tMIc3FpkTEGXGrvw3rzQXA==
X-CSE-MsgGUID: 7ctUeFbxSa2Bzrmk9q4l9w==
X-IronPort-AV: E=McAfee;i="6700,10204,11370"; a="53493916"
X-IronPort-AV: E=Sophos;i="6.14,241,1736841600"; 
   d="scan'208";a="53493916"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2025 04:36:18 -0700
X-CSE-ConnectionGUID: bKra/XWiTBKqiCxinkqa+g==
X-CSE-MsgGUID: 5vdcSzAeTCKnGviiYkvASw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,241,1736841600"; 
   d="scan'208";a="125798747"
Received: from kuha.fi.intel.com ([10.237.72.152])
  by orviesa005.jf.intel.com with SMTP; 12 Mar 2025 04:36:13 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Wed, 12 Mar 2025 13:36:12 +0200
Date: Wed, 12 Mar 2025 13:36:12 +0200
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
Subject: Re: [PATCH v1 1/4] device property: Split
 fwnode_get_child_node_count()
Message-ID: <Z9FxrD8cVTfpqxon@kuha.fi.intel.com>
References: <20250310150835.3139322-1-andriy.shevchenko@linux.intel.com>
 <20250310150835.3139322-2-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250310150835.3139322-2-andriy.shevchenko@linux.intel.com>

On Mon, Mar 10, 2025 at 04:54:51PM +0200, Andy Shevchenko wrote:
> The new helper is introduced to allow counting the child firmware nodes
> of their parent without requiring a device to be passed. This also makes
> the fwnode and device property API more symmetrical with the rest.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
>  drivers/base/property.c  | 12 ++++++------
>  include/linux/property.h |  7 ++++++-
>  2 files changed, 12 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/base/property.c b/drivers/base/property.c
> index c1392743df9c..805f75b35115 100644
> --- a/drivers/base/property.c
> +++ b/drivers/base/property.c
> @@ -928,22 +928,22 @@ bool fwnode_device_is_available(const struct fwnode_handle *fwnode)
>  EXPORT_SYMBOL_GPL(fwnode_device_is_available);
>  
>  /**
> - * device_get_child_node_count - return the number of child nodes for device
> - * @dev: Device to count the child nodes for
> + * fwnode_get_child_node_count - return the number of child nodes for a given firmware node
> + * @fwnode: Pointer to the parent firmware node
>   *
> - * Return: the number of child nodes for a given device.
> + * Return: the number of child nodes for a given firmware node.
>   */
> -unsigned int device_get_child_node_count(const struct device *dev)
> +unsigned int fwnode_get_child_node_count(const struct fwnode_handle *fwnode)
>  {
>  	struct fwnode_handle *child;
>  	unsigned int count = 0;
>  
> -	device_for_each_child_node(dev, child)
> +	fwnode_for_each_child_node(fwnode, child)
>  		count++;
>  
>  	return count;
>  }
> -EXPORT_SYMBOL_GPL(device_get_child_node_count);
> +EXPORT_SYMBOL_GPL(fwnode_get_child_node_count);
>  
>  bool device_dma_supported(const struct device *dev)
>  {
> diff --git a/include/linux/property.h b/include/linux/property.h
> index e214ecd241eb..bc5bfc98176b 100644
> --- a/include/linux/property.h
> +++ b/include/linux/property.h
> @@ -208,7 +208,12 @@ DEFINE_FREE(fwnode_handle, struct fwnode_handle *, fwnode_handle_put(_T))
>  int fwnode_irq_get(const struct fwnode_handle *fwnode, unsigned int index);
>  int fwnode_irq_get_byname(const struct fwnode_handle *fwnode, const char *name);
>  
> -unsigned int device_get_child_node_count(const struct device *dev);
> +unsigned int fwnode_get_child_node_count(const struct fwnode_handle *fwnode);
> +
> +static inline unsigned int device_get_child_node_count(const struct device *dev)
> +{
> +	return fwnode_get_child_node_count(dev_fwnode(dev));
> +}
>  
>  static inline int device_property_read_u8(const struct device *dev,
>  					  const char *propname, u8 *val)
> -- 
> 2.47.2

-- 
heikki

