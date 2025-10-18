Return-Path: <linux-acpi+bounces-17951-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 82B03BEDAAD
	for <lists+linux-acpi@lfdr.de>; Sat, 18 Oct 2025 21:35:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4D1BA4EDADE
	for <lists+linux-acpi@lfdr.de>; Sat, 18 Oct 2025 19:35:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8394264628;
	Sat, 18 Oct 2025 19:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cBvGCRbd"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDDDC23B0;
	Sat, 18 Oct 2025 19:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760816107; cv=none; b=bWk4kzLz5LIp9OjBcXR555bxwoyL1+yhy2ssGHq31lEvEvuM05xFfx1gi8jaz0U0etRYhkuF2s7kuqPP/j6vsB3kAxkgHovXAOASPIeuuTP3kRgTLdgOKDt+cbxxFIh7AAwsKrat+xPozLTV6puG7+iWw+ZVkQutyUjnGh+aA+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760816107; c=relaxed/simple;
	bh=VMuYQstmRoCQLSHxXuDemKBVDyJvOfvpY44SHdocNOQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QkSJBcpefrXt7EYf3r9YsSZvHP73IsUhzWUexDvWGnxiw3QrAXIqpOm8kWNTAFWdaiyF2yWmXcMmoQsrNgaFctEHCFnUYaaI6O4m3T31x07u1U1GLbxBcXchsJpKSElNocSM5lnzDUdoY+5VXYnv15VrxY902nP2HPTBhyMWqi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cBvGCRbd; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760816105; x=1792352105;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=VMuYQstmRoCQLSHxXuDemKBVDyJvOfvpY44SHdocNOQ=;
  b=cBvGCRbdftaUjcgb/QV8O6yMydA3it0rKTGE6LxnUl8SZbqX/muYnsMz
   34h3POpCoGjnvuBG+6xrQeyz7X8KdVw2W/TbksBA3Fp9Zd8G2z3xaZjCM
   qH7BVtlpt62OZk9ykk/PYWrAS8Z81rY8GoiRRDX1i2SRpAbVFwZmaYjAf
   FNXOrjhX/TLQQ+p545ZyolULKD5WSRvh2KazdoW12o+rfybVmqFuwavN6
   TDsihG5cDhxhHET+Hq6G+iGtF5RS5Hb1yiKwNbLz3EwTkdYp7VgJZb+NE
   HU8jBCytQHO4xNIcH0zhDl7k/yOXuTGp8LRp6Yi8rQO05xPFgly9mlBFC
   Q==;
X-CSE-ConnectionGUID: TeProFagRMuHwW3zwlolyQ==
X-CSE-MsgGUID: +LRnVs53SNm2D+3ebKiPig==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="73280638"
X-IronPort-AV: E=Sophos;i="6.19,239,1754982000"; 
   d="scan'208";a="73280638"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2025 12:35:04 -0700
X-CSE-ConnectionGUID: 7nOrqJbhSuyNk3wcgrGmQw==
X-CSE-MsgGUID: 9twOXuV2Q/WnVdmRrUj23g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,239,1754982000"; 
   d="scan'208";a="182952090"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO ashevche-desk.local) ([10.245.244.194])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2025 12:35:02 -0700
Received: from andy by ashevche-desk.local with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1vAChf-00000000xbz-3CH9;
	Sat, 18 Oct 2025 22:34:59 +0300
Date: Sat, 18 Oct 2025 22:34:59 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Sunil V L <sunilvl@ventanamicro.com>
Cc: Thomas Richard <thomas.richard@bootlin.com>, rafael@kernel.org,
	regressions@lists.linux.dev, lenb@kernel.org,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
	apatel@ventanamicro.com,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Daniele Cleri <DanieleCleri@aaeon.eu>
Subject: Re: [REGRESSION] in 6.18-rc1, failed to query a GPIO using a name in
 ACPI
Message-ID: <aPPr42qP-NEmGO5v@ashevche-desk.local>
References: <c321423b-3cdb-41a5-9939-dc5c846cfcd4@bootlin.com>
 <aPFwPR2A0CN6k1Vl@sunil-laptop>
 <1241f2b6-9b4e-4623-8a83-77db8774ac32@bootlin.com>
 <aPIUMoDxW-yl2nPm@sunil-laptop>
 <aPPnC6gSP4r46gBV@ashevche-desk.local>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aPPnC6gSP4r46gBV@ashevche-desk.local>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sat, Oct 18, 2025 at 10:14:19PM +0300, Andy Shevchenko wrote:
> On Fri, Oct 17, 2025 at 03:32:26PM +0530, Sunil V L wrote:
> > On Fri, Oct 17, 2025 at 10:50:05AM +0200, Thomas Richard wrote:

Seems I have had an issue with my email, and everything is now fine.

> > I'll send out the patch shortly and include your Tested-by tag.
> > 
> > Apologies for the earlier issue, and thank you for your help.
> 
> I haven't received anything. Have you sent anything? Am I Cc'ed?

-- 
With Best Regards,
Andy Shevchenko



