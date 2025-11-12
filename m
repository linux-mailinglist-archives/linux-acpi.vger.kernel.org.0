Return-Path: <linux-acpi+bounces-18806-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD5E5C52E20
	for <lists+linux-acpi@lfdr.de>; Wed, 12 Nov 2025 16:05:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5FDF74A6B97
	for <lists+linux-acpi@lfdr.de>; Wed, 12 Nov 2025 14:49:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3AD432C93E;
	Wed, 12 Nov 2025 14:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mMrqqJnV"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41A912C0291;
	Wed, 12 Nov 2025 14:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762958548; cv=none; b=ZxQWi6Vyrc8uhSrbb2kWLKB+UWENagMJB4pfVj0eVe2S+a+58jM3EsYiiGCy1WKuha2LJiJr2olfv4YXpXdhVMiPdqJ/su8qdh170NOe0djGqiXEsThBEHvoJJnyDdSThVC9KUIJqcrNzVszN2soGaB0GXt84ByC0SGhyzv+F+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762958548; c=relaxed/simple;
	bh=2xPu+tGjTlqnZqdYCqpWi5WR088t5dU8WW6n7sq6sr8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YS2TMiy2PVMxLMdjuJf+m2yCqMu3ccQB5gdWaHX9RcewuI7WASRhjf0LknXREwmmQrza76OVIdwdcFGmuvXXNKU55uyUy7CpyuozriwyClWCE4gURbXG+m5Tp+icOO2H2g6YQzKLnIZnVg6bnc9LgwCfP0owEloE+vMBmsQsCeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mMrqqJnV; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762958547; x=1794494547;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=2xPu+tGjTlqnZqdYCqpWi5WR088t5dU8WW6n7sq6sr8=;
  b=mMrqqJnVYwVLDCWik7NS0F8d5XhF19WO3dZa73h0GJKBMxUXbqemP7YX
   WH7UtBntZWOE1CS0jLvU/sO4Egg0om3dt4+AWs0B521cBOzY1TA0AjWH+
   QSTj3qTlWtA5ArV6Y/S0P1Cnoa3eU1MC/V0O/TePNCYrHZmVA3MMr/wU+
   PFGXsI6uC2Hrnvs/F1FClfSN81SVitWFj7RwlArQRhJScIoKkoAobDpKE
   MVwoWw3ny+5nDWIga7bzVjQ6nLq7xL4KxQIdpizKxYoMIjWH19tJ7IaQk
   fF9rVZNPzQ2L/a7NU8WuExdtfHMi7IB00pA9yodPeQQETa7NJ8MjJ74Bt
   Q==;
X-CSE-ConnectionGUID: IQwL43rYRuGkTHTXlENM5A==
X-CSE-MsgGUID: vVCZY85bR328s3jjwno6DA==
X-IronPort-AV: E=McAfee;i="6800,10657,11611"; a="76479664"
X-IronPort-AV: E=Sophos;i="6.19,299,1754982000"; 
   d="scan'208";a="76479664"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2025 06:42:26 -0800
X-CSE-ConnectionGUID: HVgINgL/Q6ymdYwvsk1bCA==
X-CSE-MsgGUID: 43gqJIMmRKqPPW5U2Zvjug==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,299,1754982000"; 
   d="scan'208";a="193628214"
Received: from smoticic-mobl1.ger.corp.intel.com (HELO kekkonen.fi.intel.com) ([10.245.244.214])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2025 06:42:25 -0800
Received: from kekkonen.localdomain (localhost [IPv6:::1])
	by kekkonen.fi.intel.com (Postfix) with ESMTP id 8F57D12055E;
	Wed, 12 Nov 2025 16:42:21 +0200 (EET)
Date: Wed, 12 Nov 2025 16:42:21 +0200
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6 krs, Bertel Jungin Aukio 5, 02600 Espoo
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Haotian Zhang <vulab@iscas.ac.cn>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ACPI: property: Fix fwnode refcount leak in
 acpi_fwnode_graph_parse_endpoint()
Message-ID: <aRSczeIXvymTQN3D@kekkonen.localdomain>
References: <20251111075000.1828-1-vulab@iscas.ac.cn>
 <CAJZ5v0gs8nor-fgwcY8x4bkd9Swiu8yJn9296U7RHRnQUYDpdA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0gs8nor-fgwcY8x4bkd9Swiu8yJn9296U7RHRnQUYDpdA@mail.gmail.com>

Hi Rafael, Haotian,

On Wed, Nov 12, 2025 at 02:48:30PM +0100, Rafael J. Wysocki wrote:
> On Tue, Nov 11, 2025 at 8:50 AM Haotian Zhang <vulab@iscas.ac.cn> wrote:
> >
> > acpi_fwnode_graph_parse_endpoint() calls fwnode_get_parent() to obtain the
> > parent fwnode but returns without calling fwnode_handle_put() on it. This
> > leads to a fwnode refcount leak and prevents the parent node from being
> > released properly.
> >
> > Call fwnode_handle_put() on the parent fwnode before returning to
> > fix the leak.
> >
> > Fixes: 3b27d00e7b6d ("device property: Move fwnode graph ops to firmware specific locations")
> > Signed-off-by: Haotian Zhang <vulab@iscas.ac.cn>
> > ---
> >  drivers/acpi/property.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/drivers/acpi/property.c b/drivers/acpi/property.c
> > index 1b997a5497e7..7f8790e8dc4e 100644
> > --- a/drivers/acpi/property.c
> > +++ b/drivers/acpi/property.c
> > @@ -1714,6 +1714,7 @@ static int acpi_fwnode_graph_parse_endpoint(const struct fwnode_handle *fwnode,
> >         if (fwnode_property_read_u32(fwnode, "reg", &endpoint->id))
> >                 fwnode_property_read_u32(fwnode, "endpoint", &endpoint->id);
> >
> > +       fwnode_handle_put(port_fwnode);

I'd add a newline here.

> >         return 0;
> >  }
> >
> > --
> 
> Andy, Sakari, this looks like a genuine fix to me, any comments?

Thanks for cc'ing me.

On ACPI fwnode_handle_put() is a nop, and presumably a parent of an ACPI
node is an ACPI node as well. So this doesn't change fwnode refcounting but
is nevertheless a good thing to do for API usage correctness.

Reviewed-by: Sakari Ailus <sakari.ailus@linux.intel.com>

-- 
Kind regards,

Sakari Ailus

