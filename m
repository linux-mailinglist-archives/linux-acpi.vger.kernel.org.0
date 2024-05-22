Return-Path: <linux-acpi+bounces-5939-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 600FF8CC081
	for <lists+linux-acpi@lfdr.de>; Wed, 22 May 2024 13:45:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 149E31F234C6
	for <lists+linux-acpi@lfdr.de>; Wed, 22 May 2024 11:45:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 935411386A0;
	Wed, 22 May 2024 11:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Z7FJXUsA"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E0ED138487;
	Wed, 22 May 2024 11:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716378356; cv=none; b=blbcg9mqRdRz3UW5dREoOiF8dEW1ai+rAprsdh55Cm5l7w67NgttOCTS9QyVPk4xtxVB/i2yWCSLIx+z+WYtRLrAAkuBAhi01EbD5DABWD6Tf9e1Yjzqy4WkIEtD9lPgjIsnljSBVfytokzi7GPRynU0wlukCPM3s/L1P9sIxOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716378356; c=relaxed/simple;
	bh=ICV6GljQ7Sgq/Zq6JUYO8rUFP/lR5nau+4dSAfkL3QY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r9ddQM2FrO1nTPEMgu4tBKB7dC2BAZyRnkXkMotydZfgyxDBhNxKz5G0hw7JFMY/eTzoOjJYvryl2WOGaJy904Nl9POrEOo9BZ0/vlrA0t2VNrWfJxRVZ47gb9uy6p7KjL+AIU7aFcuTVwR2OBeFBBjGq/8vvXdhJRGbMzISGFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Z7FJXUsA; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716378354; x=1747914354;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ICV6GljQ7Sgq/Zq6JUYO8rUFP/lR5nau+4dSAfkL3QY=;
  b=Z7FJXUsAG1RIJdC0MK8OgiBoznd1Fe5Z03JQWLXIRUssEg4B8ROgxK47
   SHJt6xod7nV45m39ThsSY8XyQym6WF6q9fr7TyKxAbpK7rFKGhW8KD12u
   zyvNsfvgx/BHlz0whKo/A+YDl7vjrkkbdSF/abfYIgj2S8c7zHNm5nBov
   UJSZj/I3Z3kjbBLSZYHvkEBBUD2Bm8kvIogcpp1eYbx2u5uaR3pTdbJ3H
   gdhvEUjOgvtKPMbzehoCoR2tPIlgfzjDI07vLhrUwCeGj9TqI8XKj3UA7
   tGSevW+u8CrNtUAXFi0ZT6nbXuPH4e+DbRzGF1mn02nGfMc6xZww7dIKZ
   A==;
X-CSE-ConnectionGUID: EqhkKViDQkO6XUZx2UnYVQ==
X-CSE-MsgGUID: Y3MwNYQOT02UQJxzv/VNwQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11079"; a="24028353"
X-IronPort-AV: E=Sophos;i="6.08,179,1712646000"; 
   d="scan'208";a="24028353"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2024 04:45:53 -0700
X-CSE-ConnectionGUID: /rVueyWSSiSQQcKSh9ZbZw==
X-CSE-MsgGUID: nkCAExt/Rx20edeyFI3Q9g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,179,1712646000"; 
   d="scan'208";a="38216636"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2024 04:45:51 -0700
Received: from kekkonen.localdomain (localhost [127.0.0.1])
	by kekkonen.fi.intel.com (Postfix) with SMTP id C689611F82A;
	Wed, 22 May 2024 14:45:48 +0300 (EEST)
Date: Wed, 22 May 2024 11:45:48 +0000
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Daniel Scally <djrscally@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Jean Delvare <jdelvare@suse.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Antoniu Miclaus <antoniu.miclaus@analog.com>,
	Jonathan Cameron <jic23@kernel.org>, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org
Subject: Re: [PATCH 1/2] device property: introduce
 fwnode_for_each_available_child_node_scoped()
Message-ID: <Zk3a7FpzNzwYfXWw@kekkonen.localdomain>
References: <20240522-fwnode_for_each_available_child_node_scoped-v1-0-1188b0da12dc@gmail.com>
 <20240522-fwnode_for_each_available_child_node_scoped-v1-1-1188b0da12dc@gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240522-fwnode_for_each_available_child_node_scoped-v1-1-1188b0da12dc@gmail.com>

Hi Javier,

On Wed, May 22, 2024 at 11:18:07AM +0200, Javier Carrasco wrote:
> Add a scoped version of fwnode_for_each_available_child_node() following
> the approach recently taken for other loops that handle child nodes like
> for_each_child_of_node_scoped() or device_for_each_child_node_scoped(),
> which are based on the __free() auto cleanup handler to remove the need
> for fwnode_handle_put() on early loop exits.
> 
> Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
> ---
>  include/linux/property.h | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/include/linux/property.h b/include/linux/property.h
> index 61fc20e5f81f..bcc3dda5a9d8 100644
> --- a/include/linux/property.h
> +++ b/include/linux/property.h
> @@ -168,6 +168,11 @@ struct fwnode_handle *fwnode_get_next_available_child_node(
>  	for (child = fwnode_get_next_available_child_node(fwnode, NULL); child;\
>  	     child = fwnode_get_next_available_child_node(fwnode, child))
>  
> +#define fwnode_for_each_available_child_node_scoped(fwnode, child)	\
> +	for (struct fwnode_handle *child __free(fwnode_handle) =	\
> +		fwnode_get_next_available_child_node(fwnode, NULL);	\
> +	     child; child = fwnode_get_next_available_child_node(fwnode, child))
> +
>  struct fwnode_handle *device_get_next_child_node(const struct device *dev,
>  						 struct fwnode_handle *child);
>  

Reviewed-by: Sakari Ailus <sakari.ailus@linux.intel.com>

-- 
Sakari Ailus

