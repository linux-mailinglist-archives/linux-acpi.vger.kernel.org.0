Return-Path: <linux-acpi+bounces-10188-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D4A79F79A5
	for <lists+linux-acpi@lfdr.de>; Thu, 19 Dec 2024 11:32:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6252F7A1A97
	for <lists+linux-acpi@lfdr.de>; Thu, 19 Dec 2024 10:32:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F33A217657;
	Thu, 19 Dec 2024 10:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="R9SLBIKu"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A9677082B
	for <linux-acpi@vger.kernel.org>; Thu, 19 Dec 2024 10:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734604337; cv=none; b=RBjCq/JpNo42MWKPeIOqhdtYjzw6hxd6h2Y4+2oiom9wfsiH4XWWQ4eLsIhYsop+JZxMUFMOQ4Meiy0rSScJO6Gei8cAOgfo+IoHF1/AvONaohmVFBkWRNaQeZXrzbrKlUsMUCB25Axggst3pebACR3SsgTN0EQw5pEFnUNozDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734604337; c=relaxed/simple;
	bh=zG2Xavuz8MqyDAoQmeXexU9/4+2ohB8n9xkIOKnVeKM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LhIP+8S328s0MUYVZ8AWD4eAxRiXYy3VJc38WMBYYX2WKOfjmTiHppn0EzA4UvyQaE1upPoukXqGJeaBBJH5WcZ0OruOrjA9HaRgiFqtHbWIV/o5LJg65c8x8tXlks8CruxDqWbcgfBmMne+54Bvsn0dCBaouRKi7qwavWkjiJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=R9SLBIKu; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734604335; x=1766140335;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=zG2Xavuz8MqyDAoQmeXexU9/4+2ohB8n9xkIOKnVeKM=;
  b=R9SLBIKuq6uw8itFaL8aJEh8r4UT4+EoDj6fOu42ypxCf91vhwYRc5kc
   O/0d6M2MPCurgg2th/Vk3bgocUwOaW08KhuxeGVnMbO6t8ne17jaLFoaA
   dO/CeSlZU9tO5R8qRVutYsEnmhqtFUoy0mZ2OCUa1VOQpu9O4Uk1o7hii
   yniSpaDQ3xff3ZnMhjW7hx0F+itX4BkszFWMuLF4b5Z1Nb75w+38aBcny
   dcC4K7VfsERxg48//6k1vF9HSXtQ7lNYXF+C8qEDhd2Lu0DtPsFY685CC
   0U1xIoLeLeXNFVFVcImXdb8aiirlNZZGnvsrq+FCJVvCZBVoqWxzvyC+h
   g==;
X-CSE-ConnectionGUID: JaJ2nBaIQtGJZkgKKbCNew==
X-CSE-MsgGUID: wwh5jC4ATAmOcNq4v0Kvrw==
X-IronPort-AV: E=McAfee;i="6700,10204,11290"; a="22698012"
X-IronPort-AV: E=Sophos;i="6.12,247,1728975600"; 
   d="scan'208";a="22698012"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2024 02:32:14 -0800
X-CSE-ConnectionGUID: tbUiO1D0SJynij19q2tdBA==
X-CSE-MsgGUID: MVM7zDtlS9+nyEtqh9sT9Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="97983322"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2024 02:32:13 -0800
Received: from kekkonen.localdomain (localhost [127.0.0.1])
	by kekkonen.fi.intel.com (Postfix) with ESMTP id BCEF411FA41;
	Thu, 19 Dec 2024 12:32:09 +0200 (EET)
Date: Thu, 19 Dec 2024 10:32:09 +0000
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: linux-acpi@vger.kernel.org, Len Brown <lenb@kernel.org>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Rob Herring <robh@kernel.org>, andriy.shevchenko@linux.intel.com
Subject: Re: [PATCH 1/1] ACPI: property: Consider data nodes as being
 available
Message-ID: <Z2P2KegQlxYLd9sd@kekkonen.localdomain>
References: <20241218091622.914266-1-sakari.ailus@linux.intel.com>
 <CAJZ5v0jRLJEUS=-6Ciuy1O7KG2B8sSvKgtzcK+85umbefLU=UQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0jRLJEUS=-6Ciuy1O7KG2B8sSvKgtzcK+85umbefLU=UQ@mail.gmail.com>

Hi Rafael,

Thanks for the review.

On Wed, Dec 18, 2024 at 12:07:52PM +0100, Rafael J. Wysocki wrote:
> On Wed, Dec 18, 2024 at 10:16 AM Sakari Ailus
> <sakari.ailus@linux.intel.com> wrote:
> >
> > Years after fwnode_device_is_available() was introduced, new functions
> > making use of the function on data nodes have been added, such as
> > fwnode_for_each_available_child_node(), it becomes apparent that returning
> > "false" for all child nodes on ACPI wasn't a workable option.
> 
> Can you describe the problem in a bit more detail?

How about:

Years after fwnode_device_is_available() was introduced, new functions
making use of the data node availability information have been added, such
as fwnode_for_each_available_child_node(). To enumerate the data nodes in
various ways specific to those functions, the node availability test needs
to pass.

On ACPI, there is no explicit information on this in the first place and
the original fwnode_device_is_available() implementation simply returnes
false. This leads to the new functions enumerating only available nodes to
never return any nodes on ACPI. On DT side most access functions, even
those without "_available" part, did only operate on available nodes.

Thus from now on, return true from fwnode_device_is_available() on all ACPI
data nodes.

> 
> > On DT side most access functions, even those without "_available" part,
> > did only operate on available nodes. That wasn't the case on ACPI where
> > only device node availability is known explicitly.
> >
> > Thus from now on, return true from fwnode_device_is_available() on all
> > ACPI data nodes.
> >
> > Fixes: 2294b3af05e9 ("device property: Introduce fwnode_device_is_available()")
> 
> Do you want people to backport this patch?

Good question.

There are just a couple of drivers using the new fwnode_*_available()
functions and I think they're used on DT-based platforms *currently*. So
nothing is broken right now as far as I can see (but likely will be in some
time without the patch).

I guess just dropping Fixes: is an alternative, this wasn't really a bug
honestly. Backporting shouldn't hurt either though.

> 
> > Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
> > ---
> >  drivers/acpi/property.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/acpi/property.c b/drivers/acpi/property.c
> > index 80a52a4e66dd..1ee81e771ae6 100644
> > --- a/drivers/acpi/property.c
> > +++ b/drivers/acpi/property.c
> > @@ -1492,7 +1492,7 @@ acpi_graph_get_remote_endpoint(const struct fwnode_handle *__fwnode)
> >  static bool acpi_fwnode_device_is_available(const struct fwnode_handle *fwnode)
> >  {
> >         if (!is_acpi_device_node(fwnode))
> > -               return false;
> > +               return true;
> >
> >         return acpi_device_is_present(to_acpi_device_node(fwnode));
> >  }
> >
> > base-commit: 7fa366f1b6e376c38966faa42da7f0f2e013fdab

-- 
Kind regards,

Sakari Ailus

