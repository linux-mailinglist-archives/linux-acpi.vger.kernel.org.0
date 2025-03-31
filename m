Return-Path: <linux-acpi+bounces-12561-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D68EA766F7
	for <lists+linux-acpi@lfdr.de>; Mon, 31 Mar 2025 15:36:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7FFB21888AD4
	for <lists+linux-acpi@lfdr.de>; Mon, 31 Mar 2025 13:36:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7237C1E9906;
	Mon, 31 Mar 2025 13:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FL6zXpUm"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64A781DFE0A
	for <linux-acpi@vger.kernel.org>; Mon, 31 Mar 2025 13:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743428160; cv=none; b=gZideu53DTO4txEPyA3DJo6yPV4OKGuwqOZglL9htuma0l6TxZ2rOEedCjnq8EihhCcoZewKGL4DIaMvA/i92f3vVBytd/749VZfuqkRwBJmZeWUC2LtAVSFCBRpKFz4JptLNVxEyVd4buNQZZup1p/ulZ2M1yT74mFtFcp6AC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743428160; c=relaxed/simple;
	bh=bO1FxvzNYOXE/044zu8ipld/JsujrmvPRnwF+bKx7+I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R6Ual/GDYdMlihIUgA3KqN/Wo/cWD0U3rxLBAd80tzlwk/lryJ2OcA+mz1dtXssthSLJzVRPf8fEgLQdD6nsIgGYu3T/GULYD3q2bRlG/V6ZKGIgl8MTGvZyJ4fK+BQSL0/5v8/htcziD9nQJHlcNmJyxNn8oQy6A2jnRUETIvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FL6zXpUm; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1743428158; x=1774964158;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=bO1FxvzNYOXE/044zu8ipld/JsujrmvPRnwF+bKx7+I=;
  b=FL6zXpUmNkaET6iA/RLETEhKLLaBre8pIRqGGn7uORHuExs/CINh06vG
   ISV/HvVrQRYwphPiegOAam1LL6KqeCdtdERFCJODAHm2p/RyY5I1bDeOH
   iDOiHNw0Dxku5qJZwOFSqm0iUxboehPSckOdyn5c33HPtxEryox/WULXX
   v3rddduewfyOv54PwfAgF/8hb2K2bGHnIapac9j9tuMcUNOUkqMqwaZ3Z
   DoHpHStRJCWzpTD4e/5+AEXzJrAl/43V4mQZ+DAnZF88pVZUGVTaSnzMo
   4VIWJQrd0pi8D81oaBWHSNDJMlYUNt0+KF+3vj3OE1W6PoFz5y7ewiIjO
   w==;
X-CSE-ConnectionGUID: VzFc/ZKVRemi6OH47javDA==
X-CSE-MsgGUID: gFIzCzq/TCCftrnbm1nQmA==
X-IronPort-AV: E=McAfee;i="6700,10204,11390"; a="44624084"
X-IronPort-AV: E=Sophos;i="6.14,290,1736841600"; 
   d="scan'208";a="44624084"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2025 06:35:57 -0700
X-CSE-ConnectionGUID: luRBL6s7Qg2k0AICNgrUKQ==
X-CSE-MsgGUID: DGTlPupdQkW7ff2mXoWGyA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,290,1736841600"; 
   d="scan'208";a="131094441"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2025 06:35:57 -0700
Received: from kekkonen.localdomain (localhost [127.0.0.1])
	by kekkonen.fi.intel.com (Postfix) with ESMTP id C945511F9AC;
	Mon, 31 Mar 2025 16:35:53 +0300 (EEST)
Date: Mon, 31 Mar 2025 13:35:53 +0000
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: linux-acpi@vger.kernel.org,
	"Wysocki, Rafael J" <rafael.j.wysocki@intel.com>,
	Len Brown <lenb@kernel.org>
Subject: Re: [PATCH 1/1] ACPI: property: Fix REF STR... reference parsing
Message-ID: <Z-qaOXTRS7z_He62@kekkonen.localdomain>
References: <20250331121836.2495903-1-sakari.ailus@linux.intel.com>
 <CAJZ5v0jGCaJLTka57nB6mx4VDxZJUBVBbGV=7HdKKpf+7jCvjw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0jGCaJLTka57nB6mx4VDxZJUBVBbGV=7HdKKpf+7jCvjw@mail.gmail.com>

Hi Rafael,

On Mon, Mar 31, 2025 at 03:19:07PM +0200, Rafael J. Wysocki wrote:
> On Mon, Mar 31, 2025 at 2:18 PM Sakari Ailus
> <sakari.ailus@linux.intel.com> wrote:
> >
> > Restore parsing of ACPI data node references consisting of a device node
> > reference followed by one or more child data node names.
> >
> > Fixes: 9880702d123f ("ACPI: property: Support using strings in reference properties")
> > Cc: stable@vger.kernel.org # for 6.8 and later
> > Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
> > ---
> > Hi Rafael,
> >
> > It seems that support for REF STR... references got accidentally removed
> > when pure STR reference were added. The former are documented in
> > Documentation/firmware-guide/acpi/dsd/graph.rst .
> 
> It would be good to provide an ASL example that is not parsed as
> expected before the change and will be parsed correctly after it.
> 
> Admittedly, I can't quite recall the history leading to the above
> commit, but this paragraphs is present in its changelog:
> 
> "Also remove the mechanism allowing data nodes to be referenced
>  indirectly, with the help of an object reference pointing to the
>  "ancestor" device and a path relative to it (this mechanism is not
>  expected to be in use in any production platform firmware in the field)."
> 
> so the change in question appears to be intentional rather than accidental.

Right. This still continues to be documented in
Documentation/firmware-guide/acpi/dsd/graph.rst as noted in my previous
e-mail. A sample ASL snippet is can also be found in the same file. I only
noticed this when I tried to use such references.

The other option indeed is to change the documentation and hope no-one
depends on it.

> 
> >  drivers/acpi/property.c | 23 ++++++++++++++++++++---
> >  1 file changed, 20 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/acpi/property.c b/drivers/acpi/property.c
> > index 436019d96027..4e3202a0b305 100644
> > --- a/drivers/acpi/property.c
> > +++ b/drivers/acpi/property.c
> > @@ -807,10 +807,27 @@ acpi_fwnode_get_named_child_node(const struct fwnode_handle *fwnode,
> >  static int acpi_get_ref_args(struct fwnode_reference_args *args,
> >                              struct fwnode_handle *ref_fwnode,
> >                              const union acpi_object **element,
> > -                            const union acpi_object *end, size_t num_args)
> > +                            const union acpi_object *end, size_t num_args,
> > +                            bool follow_strings)
> >  {
> >         u32 nargs = 0, i;
> >
> > +       /*
> > +        * Parse REF STR... references by following named child nodes below the
> > +        * device node pointed by REF.
> > +        */
> > +       if (follow_strings) {
> > +               for (; (*element) < end && (*element)->type == ACPI_TYPE_STRING;
> > +                    (*element)++) {
> > +                       const char *child_name = (*element)->string.pointer;
> > +
> > +                       ref_fwnode = acpi_fwnode_get_named_child_node(ref_fwnode,
> > +                                                                     child_name);
> > +                       if (!ref_fwnode)
> > +                               return -EINVAL;
> > +               }
> > +       }
> > +
> >         /*
> >          * Assume the following integer elements are all args. Stop counting on
> >          * the first reference (possibly represented as a string) or end of the
> > @@ -999,7 +1016,7 @@ int __acpi_node_get_property_reference(const struct fwnode_handle *fwnode,
> >
> >                         ret = acpi_get_ref_args(idx == index ? args : NULL,
> >                                                 acpi_fwnode_handle(device),
> > -                                               &element, end, num_args);
> > +                                               &element, end, num_args, true);
> >                         if (ret < 0)
> >                                 return ret;
> >
> > @@ -1017,7 +1034,7 @@ int __acpi_node_get_property_reference(const struct fwnode_handle *fwnode,
> >
> >                         ret = acpi_get_ref_args(idx == index ? args : NULL,
> >                                                 ref_fwnode, &element, end,
> > -                                               num_args);
> > +                                               num_args, false);
> >                         if (ret < 0)
> >                                 return ret;
> >

-- 
Regards,

Sakari Ailus

