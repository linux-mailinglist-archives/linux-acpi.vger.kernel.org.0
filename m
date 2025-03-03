Return-Path: <linux-acpi+bounces-11723-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 280ABA4BF58
	for <lists+linux-acpi@lfdr.de>; Mon,  3 Mar 2025 12:52:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 339C7166614
	for <lists+linux-acpi@lfdr.de>; Mon,  3 Mar 2025 11:51:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68CBA20C03C;
	Mon,  3 Mar 2025 11:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="c+O8bjEl"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3859204F6B;
	Mon,  3 Mar 2025 11:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741002676; cv=none; b=uPm7dUoOsTh0gV0Rvd2N8deaMCrnz9qLXJsUC3//yudLfhuMIBWpbVw81lZnNWT0P7MKpBZAWT56B9+/jCE1zKvTwhRlmondxL+k+1Q7Xj4PXqtFzd4Gl1YMDkBAbI6EAYeahM6fyxCuLqJQoCd/YM1BM4NL40IuuA2bXnAo/gk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741002676; c=relaxed/simple;
	bh=WqIKezHZkO7ZmKx+327v0on4OgffbWwg65hwUsgf0aA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N5Msm04zowrOeZDtvkpYV1tqVnzAWaaz4ilrPr8zH7IwKlIuo79NEwsF/JSMq+5H7H3IxSY8WMpzlIMOS83O1A7SXhnQa+CGCNcO9WN2rBdB/WhDALP9RrIcge5XTJyP+FlkV7kcpiaKlCc/C1QCzc6emm1nEPpLheYMEFzRCn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=c+O8bjEl; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741002675; x=1772538675;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=WqIKezHZkO7ZmKx+327v0on4OgffbWwg65hwUsgf0aA=;
  b=c+O8bjElb4Tb7fB3QkYCNX72101N28LUT/v0nuwnbsBBRhIHfTDd5zr1
   VEwaEwN16IKd2UlFenQfG1EIBwgMc1ACNAIO+iNacmQeEuCuInk7LSAai
   v2JJOBKLaf1uwmiPd0IsOXoVJM/1uJTDBuiO1gzpvUsZjk8e/mSx03qVa
   pp54hguPOYYbJLQA8R4Hd8RIxmoxhdKfNvmOSLAvIZ6x7cYL5EiSSZJoQ
   4Gv5fIZRF4biPONCXX0lKKHb0Mk48OW93XETrh3AdsphHq3UygXiFz0V2
   d9thTqOLbOeWJNDcQXbLA3qCg/l36oXSkloD1mIu33lhXCTwarN3pty4c
   Q==;
X-CSE-ConnectionGUID: QQo5mCAKSEiw4E8sZ5yw3w==
X-CSE-MsgGUID: FXHbyWANTyKqHybRDutf3Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11361"; a="42127243"
X-IronPort-AV: E=Sophos;i="6.13,329,1732608000"; 
   d="scan'208";a="42127243"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2025 03:51:15 -0800
X-CSE-ConnectionGUID: 3bwOHvTFSnOvwh1JtWxJ8g==
X-CSE-MsgGUID: EXDMC/eNTIm1xNQT/GlyKA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,329,1732608000"; 
   d="scan'208";a="118021008"
Received: from smile.fi.intel.com ([10.237.72.58])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2025 03:51:10 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1tp4KA-0000000Gnqn-1q5u;
	Mon, 03 Mar 2025 13:51:06 +0200
Date: Mon, 3 Mar 2025 13:51:06 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Matti Vaittinen <mazziesaccount@gmail.com>
Cc: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
	Daniel Scally <djrscally@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Claudiu Manoil <claudiu.manoil@nxp.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH RFC net-next v5 10/10] net: gianfar: Use
 device_get_child_node_count_named()
Message-ID: <Z8WXqgxgFQC8b8vC@smile.fi.intel.com>
References: <cover.1740993491.git.mazziesaccount@gmail.com>
 <685cd1affabe50af45b767eeed9b9002d006b0fd.1740993491.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <685cd1affabe50af45b767eeed9b9002d006b0fd.1740993491.git.mazziesaccount@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, Mar 03, 2025 at 01:34:49PM +0200, Matti Vaittinen wrote:
> We can avoid open-coding the loop construct which counts firmware child
> nodes with a specific name by using the newly added
> device_get_child_node_count_named().
> 
> The gianfar driver has such open-coded loop. Replace it with the
> device_get_child_node_count_named().

...

> It's fair to tell the pros and cons of this patch.
> The simplification is there, but it's not a big one. It comes with a cost
> of getting the property.h included in this driver which currently uses
> exclusively the of_* APIs.

I think it's a good step to the right direction. We might convert the rest
(at least I don't see much impediments while briefly looking into the code).

...

What about the second loop (in gfar_of_init)?
I mean perhaps we want to have fwnode_for_each_named_child_node()
and its device variant that may be also reused in the IIO code and here.

-- 
With Best Regards,
Andy Shevchenko



