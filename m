Return-Path: <linux-acpi+bounces-14449-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E02AADF166
	for <lists+linux-acpi@lfdr.de>; Wed, 18 Jun 2025 17:30:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5CD533B5C5B
	for <lists+linux-acpi@lfdr.de>; Wed, 18 Jun 2025 15:29:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B61D72EF9BF;
	Wed, 18 Jun 2025 15:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Cauo37mP"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1232B2EE5FA;
	Wed, 18 Jun 2025 15:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750260615; cv=none; b=uTNAsyokG8mzUKPbqKQ0DRwVBiming8gmoCD4zGcFal/wf0h06KBzujPQIJ1hnNcXnN8EQ06GlK2X3L5QM0Y+DYCw6VEs6IoIIXR7RNP/rkInc/Bob5XxjslhlP3pMmpZ8eusx9SYPoXcAp/KU77t0veiGNlTU3d52a3YGXePrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750260615; c=relaxed/simple;
	bh=uao6iLRPS+RTJHDF89A0xuDY5D9OIKEScQYTHr7q75E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GVSHyhj8RDl1XQwWl+PMsmWTAkXwb7nl6SoHPn76gpVZsYGbTQGQCCQq5X0bYHaWcixnBdLitw3337+yyJFfy5Z0xaTe58T8O6XKM57x9vW9z503WBqLuSy7sKRQXV6tJEu3B252KBnlwPIv/PiRZbgbSacxAJvAJ17JDOuX7RQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Cauo37mP; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750260615; x=1781796615;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=uao6iLRPS+RTJHDF89A0xuDY5D9OIKEScQYTHr7q75E=;
  b=Cauo37mPmfnhltCQReygwvYaMqbaKHZM7GSFyVi3b76KUVvl31E45ZkR
   bjpGAF245Xj/jixbc0wTMndG8xWZSwdNA/tCNVwuOgqoG4Wgcp92lZlAP
   1LYlhptF6vfBN5kKHmL1qIyQs1uCQaCs+XWtF9MIhVXAqY1olmAy7JQzZ
   Sj/SKuq8ifp2WFYyx9NH85X5NGPTFuIJ4zUESR97h4rgmv256ysUALopA
   QoNjQc51H8utYSl95FI+m5k7L7DDn2yl+3IeKHeT+UC92WsWG3srwQ0ob
   pTRxS9l6skC6qW1FasoSByj7TV0gAX8W5oZaWHYRHRrAvKCQLmiUBaS6N
   A==;
X-CSE-ConnectionGUID: 2YMvwS7sTGSmOmhI92JXfQ==
X-CSE-MsgGUID: 6IZ1fGxxSdSVkAopi1XA/A==
X-IronPort-AV: E=McAfee;i="6800,10657,11468"; a="56165192"
X-IronPort-AV: E=Sophos;i="6.16,246,1744095600"; 
   d="scan'208";a="56165192"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2025 08:30:14 -0700
X-CSE-ConnectionGUID: jODERCniRByzQhhkPOAnww==
X-CSE-MsgGUID: rczAkcBSQmazkneLo4/xcg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,246,1744095600"; 
   d="scan'208";a="150180111"
Received: from agluck-desk3.sc.intel.com (HELO agluck-desk3) ([172.25.103.51])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2025 08:30:12 -0700
Date: Wed, 18 Jun 2025 08:30:10 -0700
From: "Luck, Tony" <tony.luck@intel.com>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Zaid Alali <zaidal@os.amperecomputing.com>, rafael@kernel.org,
	lenb@kernel.org, james.morse@arm.com, bp@alien8.de, kees@kernel.org,
	gustavoars@kernel.org, Jonathan.Cameron@huawei.com,
	sudeep.holla@arm.com, jonathanh@nvidia.com,
	u.kleine-koenig@baylibre.com, viro@zeniv.linux.org.uk,
	ira.weiny@intel.com, alison.schofield@intel.com,
	dan.j.williams@intel.com, gregkh@linuxfoundation.org,
	peterz@infradead.org, dave.jiang@intel.com,
	Benjamin.Cheatham@amd.com, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v9 5/7] ACPI: APEI: EINJ: Create debugfs files to enter
 device id and syndrome
Message-ID: <aFLbgkhB5Q4ZbAZl@agluck-desk3>
References: <20250612231327.84360-1-zaidal@os.amperecomputing.com>
 <20250612231327.84360-6-zaidal@os.amperecomputing.com>
 <3a143d53-8731-4afc-9117-bac49ea96db1@suswa.mountain>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3a143d53-8731-4afc-9117-bac49ea96db1@suswa.mountain>

On Wed, Jun 18, 2025 at 06:21:39PM +0300, Dan Carpenter wrote:
> On Thu, Jun 12, 2025 at 04:13:25PM -0700, Zaid Alali wrote:
> > +static ssize_t u128_read(struct file *f, char __user *buf, size_t count, loff_t *off)
> > +{
> > +	char output[2 * COMPONENT_LEN + 1];
> > +	u8 *data = f->f_inode->i_private;
> > +	int i;
> > +
> > +	if (*off >= sizeof(output))
> > +		return 0;
> 
> No need for this check.  simple_read_from_buffer() will do the
> right thing.

True. But why waste cycles populating the output buffer
when it will be ignored? The normal flow here is that
a user will likely try to read a <stdio.h> sized buffer
and get back 33 bytes. Then read again to find EOF. That
second read doesn't need to do all the "sprintf()"s.

> regards,
> dan carpenter
> 
> > +
> > +	for (i = 0; i < COMPONENT_LEN; i++)
> > +		sprintf(output + 2 * i, "%.02x", data[COMPONENT_LEN - i - 1]);
> > +	output[2 * COMPONENT_LEN] = '\n';
> > +
> > +	return simple_read_from_buffer(buf, count, off, output, sizeof(output));
> > +}

-Tony

