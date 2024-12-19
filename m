Return-Path: <linux-acpi+bounces-10191-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4336D9F7C87
	for <lists+linux-acpi@lfdr.de>; Thu, 19 Dec 2024 14:38:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B750D1640A6
	for <lists+linux-acpi@lfdr.de>; Thu, 19 Dec 2024 13:37:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31ECC38FB9;
	Thu, 19 Dec 2024 13:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="oDxIuuUx"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 744BC18651
	for <linux-acpi@vger.kernel.org>; Thu, 19 Dec 2024 13:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734615438; cv=none; b=mHYtoQvkOynMuMZFlqaStV0Loo7wJl1Ni2fPmY92OGBle5qTcKRoY1rse2WKQZfx2ThfkqKEWNTUquOC0ynZ39nJGUZixi/M+7j224D/iXs61DF9n1mnpCiMK5yq7lO4Sk5nBunTm7/L7lvd1vqS+fwaxUhx9mgEkIDWhJQ/Hew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734615438; c=relaxed/simple;
	bh=NWO83RAind6gjopIuMTcFx5Ba0Hn3iyZwZwGzGI58KI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VBBx2MTXLS+7y8HKV2+UMIgKbP1FxHlKphwm3M0WwjK4VaCoocucL7PC9bbTN+H3lo2+FRi5lHSixWSjFw974+nggVJ2RkRGsHCYlUkaIq7qTXO4CQENgUsr9v4l6UHU/5I/jdlWB73zm68Ie8+1eXgzsFib2NCNUzyJqICOOd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=oDxIuuUx; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734615436; x=1766151436;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=NWO83RAind6gjopIuMTcFx5Ba0Hn3iyZwZwGzGI58KI=;
  b=oDxIuuUxajSXQ6pZ5GV4iKCJD/lAG9goPt/JWB3VebuzNiIUMEbrzZ78
   c+/plzPbqZwLyO9qYAoOlvhYCGht9MqOPhvWic699fOECT99TZVQYM1K0
   QgcaRU+3MCtlF1xwnSpv8vln9nexNyGIgZtIapKsLa0rgwXL82xeqXtWh
   0ekBavYpITiayJEB3x27mYwiQ2Xww0m/vFq6ggxzoy5MgeOlBbbz1ikGA
   TsLSJoobkNRB0aGSuw2E878pbgiDfrHZBsxPUKrSaj97sM8wbHGH21RFa
   aL6Zgz/QNnLNjXBoClKnv5NwAH4nHPQ83uex+OyzWjf2VVsM7xDIszoSC
   w==;
X-CSE-ConnectionGUID: mOv8B2Q+Rsm8kL2haWsZkQ==
X-CSE-MsgGUID: RvAWrrmdTGOdWX1Iij33IA==
X-IronPort-AV: E=McAfee;i="6700,10204,11290"; a="45722225"
X-IronPort-AV: E=Sophos;i="6.12,247,1728975600"; 
   d="scan'208";a="45722225"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2024 05:37:16 -0800
X-CSE-ConnectionGUID: TCZD0TzBTTu6qtdmwH6ORw==
X-CSE-MsgGUID: 2bCmcV0RQFC6QNG8/6FFYg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="98664009"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2024 05:37:15 -0800
Received: from kekkonen.localdomain (localhost [127.0.0.1])
	by kekkonen.fi.intel.com (Postfix) with ESMTP id 5870E11FA41;
	Thu, 19 Dec 2024 15:37:11 +0200 (EET)
Date: Thu, 19 Dec 2024 13:37:11 +0000
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: linux-acpi@vger.kernel.org, Len Brown <lenb@kernel.org>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Rob Herring <robh@kernel.org>, andriy.shevchenko@linux.intel.com
Subject: Re: [PATCH 1/1] ACPI: property: Consider data nodes as being
 available
Message-ID: <Z2QhhyduwdVItAbs@kekkonen.localdomain>
References: <20241218091622.914266-1-sakari.ailus@linux.intel.com>
 <CAJZ5v0jRLJEUS=-6Ciuy1O7KG2B8sSvKgtzcK+85umbefLU=UQ@mail.gmail.com>
 <Z2P2KegQlxYLd9sd@kekkonen.localdomain>
 <CAJZ5v0hkaR=1wDO3MuzSGWwryDUb+CBDupwm-kffdpYKPU8RDg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0hkaR=1wDO3MuzSGWwryDUb+CBDupwm-kffdpYKPU8RDg@mail.gmail.com>

Hi Rafael,

On Thu, Dec 19, 2024 at 12:25:22PM +0100, Rafael J. Wysocki wrote:
> Hi Sakari,
> 
> On Thu, Dec 19, 2024 at 11:32 AM Sakari Ailus
> <sakari.ailus@linux.intel.com> wrote:
> >
> > Hi Rafael,
> >
> > Thanks for the review.
> >
> > On Wed, Dec 18, 2024 at 12:07:52PM +0100, Rafael J. Wysocki wrote:
> > > On Wed, Dec 18, 2024 at 10:16 AM Sakari Ailus
> > > <sakari.ailus@linux.intel.com> wrote:
> > > >
> > > > Years after fwnode_device_is_available() was introduced, new functions
> > > > making use of the function on data nodes have been added, such as
> > > > fwnode_for_each_available_child_node(), it becomes apparent that returning
> > > > "false" for all child nodes on ACPI wasn't a workable option.
> > >
> > > Can you describe the problem in a bit more detail?
> >
> > How about:
> 
> This is better IMV.  At least it actually matches my understanding of the issue.
> 
> > Years after fwnode_device_is_available() was introduced, new functions
> > making use of the data node availability information have been added, such
> > as fwnode_for_each_available_child_node().
> 
> I would rephrase the sentence above as follows:
> 
> "New functions making use of the data node availability information,
> like fwnode_for_each_available_child_node(), have been added years
> after fwnode_device_is_available() was introduced."

Looks good to me.

> 
> > To enumerate the data nodes in
> > various ways specific to those functions, the node availability test needs
> > to pass.
> >
> > On ACPI, there is no explicit information on this
> 
> I guess by "this" you mean the availability of the data (non-device) nodes?

Yes. I'll use:

On ACPI, there is no explicit data node availbility information in the
first place and the original fwnode_device_is_available() implementation
simply returns false.

> 
> > in the first place and
> > the original fwnode_device_is_available() implementation simply returnes
> 
> returns
> 
> > false. This leads to the new functions enumerating only available nodes to
> > never return any nodes on ACPI.
> 
> I'd say "This causes new functions that only enumerate available nodes
> to never return any nodes on ACPI for leaf devices that have child
> data nodes."

Ack.

> 
> > On DT side most access functions, even
> > those without "_available" part, did only operate on available nodes.
> 
> On the DT side, :device_is_available points to
> of_device_is_available() that calls __of_device_is_available() which
> returns "true" for all nodes without the "status" property, so if I'm
> not mistaken, on the DT side fwnode_device_is_available() will return
> "true" for any nodes without the "status" property.
> 
> I would say something like this:
> 
> "However, on the DT side, fwnode_device_is_available() returns "true"
> for all nodes without the "status" property which are analogous to the
> ACPI data nodes, so there is a difference in behavior between DT and
> ACPI in that respect."

That's also true. I'll use that, dropping the quotes from "true".

The commit message would be, in its entirety:

New functions making use of the data node availability information, like
fwnode_for_each_available_child_node(), have been added years after
fwnode_device_is_available() was introduced. To enumerate the data nodes
in various ways specific to those functions, the node availability test
needs to pass.

On ACPI, there is no explicit data node availbility information in the
first place and the original fwnode_device_is_available() implementation
simply returns false. This causes new functions that only enumerate
available nodes to never return any nodes on ACPI for leaf devices that
have child data nodes.

However, on the DT side, fwnode_device_is_available() returns true
for all nodes without the "status" property which are analogous to the
ACPI data nodes, so there is a difference in behavior between DT and
ACPI in that respect.

Thus from now on, return true from fwnode_device_is_available() on all ACPI
data nodes.

> 
> > Thus from now on, return true from fwnode_device_is_available() on all ACPI
> > data nodes.
> >
> > >
> > > > On DT side most access functions, even those without "_available" part,
> > > > did only operate on available nodes. That wasn't the case on ACPI where
> > > > only device node availability is known explicitly.
> > > >
> > > > Thus from now on, return true from fwnode_device_is_available() on all
> > > > ACPI data nodes.
> > > >
> > > > Fixes: 2294b3af05e9 ("device property: Introduce fwnode_device_is_available()")
> > >
> > > Do you want people to backport this patch?
> >
> > Good question.
> >
> > There are just a couple of drivers using the new fwnode_*_available()
> > functions and I think they're used on DT-based platforms *currently*. So
> > nothing is broken right now as far as I can see (but likely will be in some
> > time without the patch).
> >
> > I guess just dropping Fixes: is an alternative, this wasn't really a bug
> > honestly. Backporting shouldn't hurt either though.
> 
> Yes, I would drop the Fixes: tag.  If need be, the "stable" people can
> be asked directly to pick it up, but it's better to avoid automatic
> backporting of it IMV.

I agree.

> 
> > >
> > > > Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
> > > > ---
> > > >  drivers/acpi/property.c | 2 +-
> > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > >
> > > > diff --git a/drivers/acpi/property.c b/drivers/acpi/property.c
> > > > index 80a52a4e66dd..1ee81e771ae6 100644
> > > > --- a/drivers/acpi/property.c
> > > > +++ b/drivers/acpi/property.c
> > > > @@ -1492,7 +1492,7 @@ acpi_graph_get_remote_endpoint(const struct fwnode_handle *__fwnode)
> > > >  static bool acpi_fwnode_device_is_available(const struct fwnode_handle *fwnode)
> > > >  {
> > > >         if (!is_acpi_device_node(fwnode))
> > > > -               return false;
> > > > +               return true;
> > > >
> > > >         return acpi_device_is_present(to_acpi_device_node(fwnode));
> > > >  }
> > > >
> > > > base-commit: 7fa366f1b6e376c38966faa42da7f0f2e013fdab
> >

-- 
Kind regards,

Sakari Ailus

