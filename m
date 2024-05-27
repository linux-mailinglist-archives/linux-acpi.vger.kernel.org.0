Return-Path: <linux-acpi+bounces-6009-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5823D8D087E
	for <lists+linux-acpi@lfdr.de>; Mon, 27 May 2024 18:29:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EED791F21A0E
	for <lists+linux-acpi@lfdr.de>; Mon, 27 May 2024 16:29:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D148461FC9;
	Mon, 27 May 2024 16:28:58 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B62717E91C;
	Mon, 27 May 2024 16:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716827338; cv=none; b=qgdjkc8HHx64Z0bQdG3+OqdvZcs60IhvRmBE8BC4XZmVHHJWSXIniArdOOY7UL60vZaj7AeO49OxnSTNM7gSc5JCNCXk72DAQ+G24l2OY8cWdiBt0HUPB6gUpT3Hf8cgIrWWrOUU4CHHFkd0wNh3NaspTMicQxItKeInsGIgDtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716827338; c=relaxed/simple;
	bh=tenOVureWXg27A/BRhhEdtjSgdb2iCP2DVRnVahKpPk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mrP0jS29tFOXumDl4OaoyTRmLKvo90ractauoZAzC+9FNAcGeTxoVvIiSxJzf0uFDYUB52A15LryV62PvmLeDRf9z0IW3qNgQoU7Ph1m+9pRQV/yuG+Iq5T0Qu33JG5UFtsgtkBmxE6VstkgCQjcPZujb2Hf16UHRldQXRuv2Vg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=fail smtp.mailfrom=gmail.com; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=gmail.com
X-CSE-ConnectionGUID: 3kOW+QshRp2cQBpvXH/mbw==
X-CSE-MsgGUID: 4bRUBYHhTRKlFm67aVp6Hw==
X-IronPort-AV: E=McAfee;i="6600,9927,11085"; a="23821203"
X-IronPort-AV: E=Sophos;i="6.08,193,1712646000"; 
   d="scan'208";a="23821203"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2024 09:28:56 -0700
X-CSE-ConnectionGUID: u7ozXfdDQlyZg0xj64Fwpg==
X-CSE-MsgGUID: 6BCTSqMYT8SubiDMHSGfnQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,193,1712646000"; 
   d="scan'208";a="34694966"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2024 09:28:52 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andy.shevchenko@gmail.com>)
	id 1sBdDN-0000000BJxg-3Sai;
	Mon, 27 May 2024 19:28:49 +0300
Date: Mon, 27 May 2024 19:28:49 +0300
From: Andy Shevchenko <andy.shevchenko@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Javier Carrasco <javier.carrasco.cruz@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Scally <djrscally@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Jean Delvare <jdelvare@suse.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Antoniu Miclaus <antoniu.miclaus@analog.com>,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hwmon@vger.kernel.org, Rob Herring <robh@kernel.org>,
	devicetree@vger.kernel.org
Subject: Re: [PATCH v2 3/3] hwmon: (ltc2992) Use
 fwnode_for_each_available_child_node_scoped()
Message-ID: <ZlS0wcbBXvSS26Qz@smile.fi.intel.com>
References: <20240523-fwnode_for_each_available_child_node_scoped-v2-0-701f3a03f2fb@gmail.com>
 <20240523-fwnode_for_each_available_child_node_scoped-v2-3-701f3a03f2fb@gmail.com>
 <20240526144851.493dd3f2@jic23-huawei>
 <ZlSY8tjYm5g9bEJ_@surfacebook.localdomain>
 <20240527155717.58292509@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240527155717.58292509@jic23-huawei>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, May 27, 2024 at 03:57:17PM +0100, Jonathan Cameron wrote:
> On Mon, 27 May 2024 17:30:10 +0300
> Andy Shevchenko <andy.shevchenko@gmail.com> wrote:
> > Sun, May 26, 2024 at 02:48:51PM +0100, Jonathan Cameron kirjoitti:
> > > On Thu, 23 May 2024 17:47:16 +0200
> > > Javier Carrasco <javier.carrasco.cruz@gmail.com> wrote:

...

> > > This looks like another instances of the lack of clarify about 
> > > what device_for_each_child_node[_scoped]() guarantees about node availability.
> > > On DT it guarantees the node is available as ultimately calls
> > > of_get_next_available_child()
> > > 
> > > On ACPI it doesn't (I think).
> > > For swnode, there isn't an obvious concept of available.
> > > 
> > > It would be much better if we reached some agreement on this and
> > > hence could avoid using the fwnode variants just to get the _available_ form
> > > as done here.  
> > 
> > > Or just add the device_for_each_available_child_node[_scoped]()
> > > and call that in almost all cases.  
> > 
> > device_for_each*() _implies_ availability. You need to talk to Rob about all
> > this. The design of the device_for_each*() was exactly done in accordance with
> > his suggestions...
> 
> Does it imply that for ACPI? I can't find a query of _STA in the callbacks
> (which is there for the for fwnode_*available calls.

IIRC for ACPI/swnode the availability is always "yes" as long as property can
be found. Basically it means the fwnode_*() == fwnode_*available() for these
back-ends.

AFAIU ACPI concept here is that once parsed and namespaced (in terms of putting
the respective part of description table into ACPI namespace) it's lways
available. Otherwise it's not, but at the same time the respective child node
(property) may not be found

> Mind you it wouldn't be the first time I've missed something in the ACPI parsing
> code, so maybe it is there indirectly.

I might have a weak memory, but see my understanding above.

> I know from previous discussions that the DT version was intentional, but
> I'm nervous that the same assumptions don't apply to ACPI.
> 
> > > In generic code, do we ever want to walk unavailable child nodes?  
> > 
> > ...which are most likely like your question here, i.e. why we ever need to
> > traverse over unavailable nodes.

-- 
With Best Regards,
Andy Shevchenko



