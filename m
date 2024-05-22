Return-Path: <linux-acpi+bounces-5937-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CB4AF8CC052
	for <lists+linux-acpi@lfdr.de>; Wed, 22 May 2024 13:34:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 86B3A28390D
	for <lists+linux-acpi@lfdr.de>; Wed, 22 May 2024 11:34:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34A1382C6B;
	Wed, 22 May 2024 11:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gk3ZfjmA"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDDF956B72;
	Wed, 22 May 2024 11:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716377688; cv=none; b=RGMKwCUcjdQhiQoxwhckNEmppjXvvdRpfDZbjzJtANbbACXrm42mGYumcSrE6IeeiOHTjsjh+ZYBDmvgyaNLfTLZrDE3IR0FZy7EEu4xKK7mbWGgKv3PMqWcbZrmAoXc9h/rpIfGYkdSCavT2JjCBQcmj4lh7QHkfsd7AjcP7xE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716377688; c=relaxed/simple;
	bh=SqZv+J0FOQDs0+Dw6WcXgcuK2MUV7Z4FZPlHttKhaq0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J3XSgyACU7WD7BJeho6P41VcaQx8EKyewb/xa9yDBLcOgxj4coST/NUWsfnCDiTzTtatJ+yfrYuH2n1dH+tMbot4sZYCG2i7tSIqwY7hfMsahaZIv2HQsVjlAPopR42jqjZVBte2NVOP2/7/9mJxF+OK1NFE8m0QJ84TBXZXilo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gk3ZfjmA; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716377687; x=1747913687;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=SqZv+J0FOQDs0+Dw6WcXgcuK2MUV7Z4FZPlHttKhaq0=;
  b=gk3ZfjmA4x1NHT24yb7pw43BdE78t67e0fQU0PofxWvqyZJo33Yo9NAl
   xpqficiV+SG5HrSWbxOB/vsUC1sEG9DjRmWMEtRG4DCHZ7k4HVbcgS4Gp
   SKlGlRbFXOVXrO+JYJNiMc2Si3TiIJbrfb2QEW7shwYQ8eL9+lHLvfG/U
   F5mP/KVmrgO0GlOqnGNRTn+qVkNiYU8ZLisdyE5APicoAEw8rC8rzUBQN
   ps/ipk9vSHi/mjFhEctH77ngnnjkeAwXNRPIIwXVv6b8bqfs8zsEmwBwQ
   kUcf+GDDyDUw7DNqNG4iOlZQd5oU/iD6pLaISqifWT43w+SloKBpjpbFN
   A==;
X-CSE-ConnectionGUID: 96KBdVvWQpuCP0dbYht1WQ==
X-CSE-MsgGUID: hysNcxrITaGWbnG3Oc0heA==
X-IronPort-AV: E=McAfee;i="6600,9927,11079"; a="16450062"
X-IronPort-AV: E=Sophos;i="6.08,179,1712646000"; 
   d="scan'208";a="16450062"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2024 04:34:46 -0700
X-CSE-ConnectionGUID: K5DYVZXATbK33baoP3EKVA==
X-CSE-MsgGUID: tBt9SnjkQxyCPbbg6PBdMg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,179,1712646000"; 
   d="scan'208";a="37841772"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2024 04:34:43 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1s9kEy-00000009xO1-2DqT;
	Wed, 22 May 2024 14:34:40 +0300
Date: Wed, 22 May 2024 14:34:40 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Scally <djrscally@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Jean Delvare <jdelvare@suse.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Antoniu Miclaus <antoniu.miclaus@analog.com>,
	Jonathan Cameron <jic23@kernel.org>, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org
Subject: Re: [PATCH 1/2] device property: introduce
 fwnode_for_each_available_child_node_scoped()
Message-ID: <Zk3YUJjJ34FYo5NJ@smile.fi.intel.com>
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
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, May 22, 2024 at 11:18:07AM +0200, Javier Carrasco wrote:
> Add a scoped version of fwnode_for_each_available_child_node() following
> the approach recently taken for other loops that handle child nodes like
> for_each_child_of_node_scoped() or device_for_each_child_node_scoped(),
> which are based on the __free() auto cleanup handler to remove the need
> for fwnode_handle_put() on early loop exits.

OK as long as we have users.
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

-- 
With Best Regards,
Andy Shevchenko



