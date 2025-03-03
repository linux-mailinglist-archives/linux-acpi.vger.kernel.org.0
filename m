Return-Path: <linux-acpi+bounces-11728-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2472A4C046
	for <lists+linux-acpi@lfdr.de>; Mon,  3 Mar 2025 13:24:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E8D9C17033E
	for <lists+linux-acpi@lfdr.de>; Mon,  3 Mar 2025 12:24:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7909020F091;
	Mon,  3 Mar 2025 12:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="n5m6E1fg"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 087CD1F0E2C;
	Mon,  3 Mar 2025 12:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741004685; cv=none; b=WCDRcFTg6zHs8ZEOEE4E0Aq+d/rgSoygZpCJ+mEBpTRi2f9pQlkvEEKihMYCRBviXzDls5rWGbO0klrfsvYgwU+4bDiBrS08X1SR7YiNpKWZ6tUPXiBAzTTb4TnDeRH1MXqZpU9bEb183aLqbRGcq++wPuQoogsFAyyMxh7YlSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741004685; c=relaxed/simple;
	bh=j1ghf+0O9QJ9puRHnNXhg9N1r2ibOt2kzP+sia3x+c0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rNwVUbrKUzrAQv69uAzilwVi+e6fH5ue3uevu8Cw3Qb15rFkvLE1N9Hfu8u6k/+anJcgfUpMi/ZduPXa62TWjWaSs2iJnOxqlMVgGAhUGPlJGaTRqD1LN23he3RolkhvWhZZ0A/PfJdAaepKogDgOPoGmGc4ejPUY61I5i52aSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=n5m6E1fg; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741004684; x=1772540684;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=j1ghf+0O9QJ9puRHnNXhg9N1r2ibOt2kzP+sia3x+c0=;
  b=n5m6E1fgYJt+8ruOl8Eyr6HGGKlOQXFxUX74N1/PSoPH32uLwauZ9hvK
   NN9rDVakAaWGSIfir2Wl9LEaSqw3c3/RJFK4+fUAmSvPUzXTjUwGYYbWS
   x3itDJVCdOZfbuST95bVR6TDTFWkAr8DG+Yv9g4W+SoNiFY+VjiVC7L04
   tvXUL2Cxn65cYm+X5+Fc3ZC4UZrehzKO7QUWfl1B3g9ChduaS2L7Vi8kh
   8hnzH3ydKxbctsNK9DYUGXLTPgj38GkNFGHZdCeL/OI8PvntZnXenlFfq
   QtCgVFE7Y+hTDEJ4mZc7mCqZDtu5AKZZ4DfmTGomMAwGTNkLUTWXWyDR+
   g==;
X-CSE-ConnectionGUID: 9TOR9/80SJuFyH4xaMIgZw==
X-CSE-MsgGUID: 03Ko57+NRFGwB2TRgvKiVw==
X-IronPort-AV: E=McAfee;i="6700,10204,11362"; a="64320548"
X-IronPort-AV: E=Sophos;i="6.13,329,1732608000"; 
   d="scan'208";a="64320548"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2025 04:24:43 -0800
X-CSE-ConnectionGUID: bQufeDxFQFWMqaTx9aSf+Q==
X-CSE-MsgGUID: in9DvPjwRr+WBjh68L1d5Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,329,1732608000"; 
   d="scan'208";a="123136809"
Received: from smile.fi.intel.com ([10.237.72.58])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2025 04:24:39 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1tp4qZ-0000000GoLr-2PU1;
	Mon, 03 Mar 2025 14:24:35 +0200
Date: Mon, 3 Mar 2025 14:24:35 +0200
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
Message-ID: <Z8Wfgx2NjB-_AyR_@smile.fi.intel.com>
References: <cover.1740993491.git.mazziesaccount@gmail.com>
 <685cd1affabe50af45b767eeed9b9002d006b0fd.1740993491.git.mazziesaccount@gmail.com>
 <Z8WXqgxgFQC8b8vC@smile.fi.intel.com>
 <aacffceb-e9e8-412a-a624-568e6b10d586@gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aacffceb-e9e8-412a-a624-568e6b10d586@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, Mar 03, 2025 at 02:13:30PM +0200, Matti Vaittinen wrote:
> On 03/03/2025 13:51, Andy Shevchenko wrote:
> > On Mon, Mar 03, 2025 at 01:34:49PM +0200, Matti Vaittinen wrote:
> 
> > What about the second loop (in gfar_of_init)?
> > I mean perhaps we want to have fwnode_for_each_named_child_node()
> > and its device variant that may be also reused in the IIO code and here.
> 
> I agree the fwnode_for_each_named_child_node() would be useful. I think I
> said that already during the previous review rounds. There is plenty of code
> which could be converted to use it.


> This, however, is far more than I am willing to do in the context of a
> simple IIO driver addition. The "BD79124 ADC suupport" is already now 10
> patches, 2 of which are directly related to it.

But you already will have at least one user (IIO code) and second as in RFC.
I do not ask you to _add_ patches.

> I propose adding the for_each_named_child_node() as a separate series with
> bunch of users appended. That's be plenty of beans to count for those who
> like following the statistics :)

It would sound like an unneeded churn as we first introduce something that we
already know needs a refactoring.

-- 
With Best Regards,
Andy Shevchenko



