Return-Path: <linux-acpi+bounces-12189-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85F95A5F4A2
	for <lists+linux-acpi@lfdr.de>; Thu, 13 Mar 2025 13:35:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 834227A3757
	for <lists+linux-acpi@lfdr.de>; Thu, 13 Mar 2025 12:34:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 792282571BF;
	Thu, 13 Mar 2025 12:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VLkathLw"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F36686EB7C;
	Thu, 13 Mar 2025 12:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741869321; cv=none; b=MZAHirVQjfPfYkA5eAJ8MiE8tpndqxIgQc6f2Kt3nWI1tgTS4kwXCKAbngS78yf6gaqn+sGRWKmKPfh0HosbagxtNkIinMenjG8+7nXbDzXtfEEIKmSNzUkezwjT8ZiZLL6szXvl5c53BVuAsUrm8Ev0Qidh9JG+xSlXzyZKQiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741869321; c=relaxed/simple;
	bh=PhTETEVW/Hp3YYNn7mzXNielvRoPM7TY9acHre9g67c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DGiGXjEvquhGV17BVUwCyRpGKzTDdZUP7kd2gPWJQ4s0m86MwyTJoz0GvxkL+Sne3Ob95TgEgs3EzYLkWahmoGbep9ykCuJAbsaKn/Cj8R+vPTzOZLEQ/APry7/BbkV+b5fhlvhfbyaQiZxEpfVsTB3o+KQwSNGebqmI2xE0Nso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VLkathLw; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741869320; x=1773405320;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=PhTETEVW/Hp3YYNn7mzXNielvRoPM7TY9acHre9g67c=;
  b=VLkathLw4bKSsmxUilTI6boWpRhDe/CkRKCBRLgOoBmIPEN6tK7PuHHO
   ukjcXQw7gA4ImvxrpG6Lrff9/EIUmIY9en4WqFj7Ntfk9op+8WpLPjDwr
   IzC0Gmp4dugB3O3OtVs42nTFXPekkH47wlOlZg5Bo3j+jOkQiKx55fmvq
   l8m2W0BOX7ajor3AlEwxgGuJoEq3JR1IhE/1hzzuMEwbz1EuQolIZafuL
   8Zu4+/jOXyUN+gEPocN4N4kXErDH8u4zk6FRniX9pXzewo3opvwDBDtnl
   VoQ71fJTURmhLrwRSidgj6N85W0YmqS9Rgu7nUo60UI3w1rzj2pTR1aV9
   A==;
X-CSE-ConnectionGUID: XmBGa6nPR+aTuZuufc/wwg==
X-CSE-MsgGUID: vM3FY2m+TBGECBmu3uiszg==
X-IronPort-AV: E=McAfee;i="6700,10204,11372"; a="53619443"
X-IronPort-AV: E=Sophos;i="6.14,244,1736841600"; 
   d="scan'208";a="53619443"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2025 05:35:19 -0700
X-CSE-ConnectionGUID: B+RhSLqZQE6wlexCjdJ3dQ==
X-CSE-MsgGUID: X1HyK6sSQ0+4jGi51J558w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,244,1736841600"; 
   d="scan'208";a="120933692"
Received: from smile.fi.intel.com ([10.237.72.58])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2025 05:35:15 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1tshmJ-00000002Aer-2VdL;
	Thu, 13 Mar 2025 14:35:11 +0200
Date: Thu, 13 Mar 2025 14:35:11 +0200
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
Subject: Re: [PATCH v7 net-next 09/10] net: gianfar: Use
 device_get_child_node_count_named()
Message-ID: <Z9LQ__rJiRsZOr7-@smile.fi.intel.com>
References: <cover.1741849323.git.mazziesaccount@gmail.com>
 <b587e36467941f27e1273a9cf2cf3b0783bbb5fc.1741849323.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b587e36467941f27e1273a9cf2cf3b0783bbb5fc.1741849323.git.mazziesaccount@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Mar 13, 2025 at 09:20:10AM +0200, Matti Vaittinen wrote:
> We can avoid open-coding the loop construct which counts firmware child
> nodes with a specific name by using the newly added
> device_get_child_node_count_named().
> 
> The gianfar driver has such open-coded loop. Replace it with the
> device_get_child_node_count_named().

FWIW,
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

-- 
With Best Regards,
Andy Shevchenko



