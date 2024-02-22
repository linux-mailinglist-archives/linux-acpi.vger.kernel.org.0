Return-Path: <linux-acpi+bounces-3853-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37FD885F80B
	for <lists+linux-acpi@lfdr.de>; Thu, 22 Feb 2024 13:24:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E20A028AE22
	for <lists+linux-acpi@lfdr.de>; Thu, 22 Feb 2024 12:24:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3C7A5FBAC;
	Thu, 22 Feb 2024 12:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CdtoxS5Z"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5777B55C28
	for <linux-acpi@vger.kernel.org>; Thu, 22 Feb 2024 12:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708604632; cv=none; b=ss1f4xWrFabxKqfOOQS92QdWp4lNVGLCgMekbECWNVdh2AL9SQwSPgfIiGRS9SDxZJjxQODBq8KRTYxmYQqtLkB9bnbUiDIOVltkhyBkctpX+fUuTg0nzxX6Nw5pgcFdcrhsTvde4NAU2uklvhC32biHoaKXpYNUZJcoRu7KyTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708604632; c=relaxed/simple;
	bh=7qo3+hrMoVGrilqWdP7PcIKv3mA4uvCCCzTog8JqbsI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PwcZU20w4JdTbUiwO/WtMN+AHm77pLExg+sMMTau500mA4H+Wmp7SZD6yqNt1+UCdpB9E7pjlymfjSUzUcHWPchFgPwsO71QZvlWwORoR0EK2Sr6SyeEZ/xKYCmHpibhu7DRkSg0+UJZpCPX5jU3kxY9y2IPKiazXlpwMHyJCDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CdtoxS5Z; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708604630; x=1740140630;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=7qo3+hrMoVGrilqWdP7PcIKv3mA4uvCCCzTog8JqbsI=;
  b=CdtoxS5Zh4PrzX41Hl/VENgSRUIsVwRlOsNmtmM3/vYrCCmlpmUf1BvQ
   +er9RGEq812jKyi1bkSR281NDabSNWyC6LHGtDTgWUZWK8B8PB8hjgzFB
   IlLYXKX1dgDdOvOgkdqSrwD7Lsz18p6dXGKxXxvU67B/WsCuo1itH2pRj
   oPjibHA1ugpqtL2j9X9odcCytkYVfq3DCoevktqGEwX7CfLCcxw0u0jLG
   7rjawBWtbsRvfJh+ewzXF/SGU9ADJQFuvaMv9GtIA7lWfgbMNZw2w50Fq
   sKCu/CXX/eSdvkDZ4/MDSERyAWVQhLf/a4O3fJFtKAO2AX0PTdUOMK5fu
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10991"; a="20376894"
X-IronPort-AV: E=Sophos;i="6.06,177,1705392000"; 
   d="scan'208";a="20376894"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2024 04:23:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,177,1705392000"; 
   d="scan'208";a="5848090"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2024 04:23:48 -0800
Received: from kekkonen.localdomain (localhost [127.0.0.1])
	by kekkonen.fi.intel.com (Postfix) with ESMTP id 9492C11F81D;
	Thu, 22 Feb 2024 14:23:44 +0200 (EET)
Date: Thu, 22 Feb 2024 12:23:44 +0000
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: linux-acpi@vger.kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>
Subject: Re: [PATCH v2 2/2] ACPI: property: Ignore bad graph port nodes on
 Dell XPS 9315
Message-ID: <Zdc80LP2T6pjYHiA@kekkonen.localdomain>
References: <20240213134606.383817-1-sakari.ailus@linux.intel.com>
 <20240213134606.383817-3-sakari.ailus@linux.intel.com>
 <ZdUl2eg8hM5RkrOL@surfacebook.localdomain>
 <ZdWes9XxXG1PzYJZ@kekkonen.localdomain>
 <CAHp75VdJMQ1HUMHWmtkSLH=m0KQYqpcEpDGb6cVbxYw_iNPwTA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHp75VdJMQ1HUMHWmtkSLH=m0KQYqpcEpDGb6cVbxYw_iNPwTA@mail.gmail.com>

On Wed, Feb 21, 2024 at 05:33:36PM +0200, Andy Shevchenko wrote:
> On Wed, Feb 21, 2024 at 8:56 AM Sakari Ailus
> <sakari.ailus@linux.intel.com> wrote:
> > I think Rafael has already applied this but I can send a new patch...
> 
> Depends if it's final or can be dropped.
> If the former is the case, follow ups, please.
> 
> > On Wed, Feb 21, 2024 at 12:21:13AM +0200, andy.shevchenko@gmail.com wrote:
> > > Tue, Feb 13, 2024 at 03:46:06PM +0200, Sakari Ailus kirjoitti:
> 
> ...
> 
> > > >  void acpi_mipi_scan_crs_csi2(void);
> > > >  void acpi_mipi_init_crs_csi2_swnodes(void);
> > > >  void acpi_mipi_crs_csi2_cleanup(void);
> > >
> > > + blank line?
> >
> > The usa of blank lines elsewhere in the file is consistent with the above.
> > These are all related.
> 
> Naming does not suggest that. I see either naming or semantic tights
> issues here. Hence the proposal to have a blank line.
> 
> > > > +bool acpi_graph_ignore_port(acpi_handle handle);
> 
> ...
> 
> > > > +static const struct dmi_system_id dmi_ignore_port_nodes[] = {
> > > > +   {
> > > > +           .matches = {
> > > > +                   DMI_EXACT_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
> > > > +                   DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "XPS 9315"),
> > > > +           },
> > > > +   },
> > > > +   { 0 }
> > >
> > > 0 is not needed. Moreover, it's a bit unusual.
> >
> > But also required by the C standard.
> 
> We have a lot of code that doesn't use that (yet this is valid C23,
> and yes I know that we rely on C11).

The current compilers support it and I guess we'll switch to C23 at some
point. I can drop the 0.

> 
> > > > +};
> 
> ...
> 
> > > > +static const char *strnext(const char *s1, const char *s2)
> > > > +{
> > > > +   s1 = strstr(s1, s2);
> > > > +
> > > > +   if (!s1)
> > > > +           return NULL;
> > > > +
> > > > +   return s1 + strlen(s2);
> > > > +}
> > >
> > > NIH str_has_prefix() ?
> >
> > It doesn't do the same thing. Yes, it could be used, but the code looks
> > cleaner with this.
> 
> "Not Invented Here" was even at Nokia times, why do we repeat our mistakes?

As I noted previously, while str_has_prefix() could be used, it would make
the code in the caller harder to read. Changes may be needed to that code
later on as this isn't the only system with the issue so readability does
count.

> 
> ...
> 
> > > > +/**
> > > > + * acpi_graph_ignore_port - Tell whether a port node should be ignored
> > > > + * @handle: The ACPI handle of the node (which may be a port node)
> > > > + *
> > > > + * Returns true if a port node should be ignored and the data to that should
> > >
> > > Please, run kernel-doc validation and fix the warnings.
> >
> > Running kernel-doc on the file doesn't produce any here.
> 
> You haven't run it correctly?
> 
> $ scripts/kernel-doc -v -none -Wall drivers/acpi/mipi-disco-img.c
> drivers/acpi/mipi-disco-img.c:163: info: Scanning doc for function
> acpi_mipi_check_crs_csi2
> drivers/acpi/mipi-disco-img.c:384: info: Scanning doc for function
> acpi_mipi_scan_crs_csi2
> drivers/acpi/mipi-disco-img.c:703: info: Scanning doc for function
> acpi_mipi_init_crs_csi2_swnodes
> drivers/acpi/mipi-disco-img.c:718: info: Scanning doc for function
> acpi_mipi_crs_csi2_cleanup
> drivers/acpi/mipi-disco-img.c:749: info: Scanning doc for function
> acpi_graph_ignore_port
> drivers/acpi/mipi-disco-img.c:759: warning: No description found for
> return value of 'acpi_graph_ignore_port'
> 1 warnings

Ah, I guess it was -Wall option that was required to produce the warning.
I'll address it.

> 
> > > > + * come from other sources instead (Windows ACPI definitions and
> > > > + * ipu-bridge). This is currently used to ignore bad port nodes related to IPU6
> > > > + * ("IPU?") and camera sensor devices ("LNK?") in certain Dell systems with
> > > > + * Intel VSC.
> > > > + */
> 

-- 
Regards,

Sakari Ailus

