Return-Path: <linux-acpi+bounces-2645-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0727C82014E
	for <lists+linux-acpi@lfdr.de>; Fri, 29 Dec 2023 21:04:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 339831C2151B
	for <lists+linux-acpi@lfdr.de>; Fri, 29 Dec 2023 20:04:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C96E13AE4;
	Fri, 29 Dec 2023 20:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XInHIqWO"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E805013FEB;
	Fri, 29 Dec 2023 20:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703880255; x=1735416255;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=siQA8/0+M4/ceWeLQMir0svD/a4NJWgTzFwGS9kJ6gY=;
  b=XInHIqWOUUio31AyjNzr22gwHch7hO48l9ewSwoTn9XeBxgNqkyvWsaa
   Ohk3VDCwe+RGcFAsVp76UfWA3mWGb4hxhR4Ono50/O5xqr6NRHPtvz8cV
   YcXhgtpaa62G/dea7hYjmwf4euwjadJnMpGP7vcrnHYmK9o4G23203/ZX
   n7F9fndzVa3TrNApQuL0g5w8E2d/3MWQMCxoejkBuX09BfBYar6crDv9M
   HzufTuGlWyO/2hAez347x+oLMHBd7g/BT/hdb6oHLgLHZx9Y0/NoCJQmu
   GLKYEAbe6yOJEus6qf2B0kof0ZBhHg0qFXllWPSbeUwBUfzgOp592oUAq
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10938"; a="18221319"
X-IronPort-AV: E=Sophos;i="6.04,316,1695711600"; 
   d="scan'208";a="18221319"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Dec 2023 12:04:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10938"; a="1110243884"
X-IronPort-AV: E=Sophos;i="6.04,316,1695711600"; 
   d="scan'208";a="1110243884"
Received: from mbsalah-mobl.amr.corp.intel.com (HELO aschofie-mobl2) ([10.255.228.28])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Dec 2023 12:04:12 -0800
Date: Fri, 29 Dec 2023 12:04:10 -0800
From: Alison Schofield <alison.schofield@intel.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Len Brown <lenb@kernel.org>, Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>, linux-cxl@vger.kernel.org,
	linux-acpi@vger.kernel.org, "Huang, Ying" <ying.huang@intel.com>
Subject: Re: [PATCH v2] ACPI: NUMA: Fix overlap when extending memblks to
 fill CFMWS
Message-ID: <ZY8mOkPKResWyY4f@aschofie-mobl2>
References: <20231223001044.1401226-1-alison.schofield@intel.com>
 <CAJZ5v0jLkeTMDsatHB_uabj3yuyQswPm1nve=sv=kE=96qcpcg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0jLkeTMDsatHB_uabj3yuyQswPm1nve=sv=kE=96qcpcg@mail.gmail.com>

On Fri, Dec 29, 2023 at 06:43:26PM +0100, Rafael J. Wysocki wrote:
> On Sat, Dec 23, 2023 at 1:10 AM <alison.schofield@intel.com> wrote:
> >
> > From: Alison Schofield <alison.schofield@intel.com>
> >
> > When the BIOS only partially describes a CFMWS Window in the SRAT
> > the acpi driver uses numa_fill_memblks() to extend existing memblk(s)
> > to fill the entire CFMWS Window, thereby applying the proximity domain
> > to the entire CFMWS.
> >
> > The calculation of the memblks to fill has an off-by-one error, that
> > causes numa_init to fail when it sees the overlap:
> >
> > [] ACPI: SRAT: Node 0 PXM 0 [mem 0x00000000-0x7fffffff]
> > [] ACPI: SRAT: Node 0 PXM 0 [mem 0x100000000-0xffffffffff]
> > [] ACPI: SRAT: Node 1 PXM 1 [mem 0x10000000000-0x1ffffffffff]
> > [] node 0 [mem 0x100000000-0xffffffffff] overlaps with node 1 [mem 0x100000000-0x1ffffffffff]
> >
> > Fix by making the 'end' parameter to numa_fill_memblks() exclusive.
> >
> > Fixes: 8f1004679987 ("ACPI/NUMA: Apply SRAT proximity domain to entire CFMWS window")
> > Reported-by: "Huang, Ying" <ying.huang@intel.com>
> > Suggested-by: Dan Williams <dan.j.williams@intel.com>
> > Signed-off-by: Alison Schofield <alison.schofield@intel.com>
> > ---
> >
> > Changes in v2:
> > - Send to ACPI maintainer, reviewer, and mailing list.
> >
> >
> >  drivers/acpi/numa/srat.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/acpi/numa/srat.c b/drivers/acpi/numa/srat.c
> > index 12f330b0eac0..b99062f7c412 100644
> > --- a/drivers/acpi/numa/srat.c
> > +++ b/drivers/acpi/numa/srat.c
> > @@ -308,7 +308,7 @@ static int __init acpi_parse_cfmws(union acpi_subtable_headers *header,
> >
> >         cfmws = (struct acpi_cedt_cfmws *)header;
> >         start = cfmws->base_hpa;
> > -       end = cfmws->base_hpa + cfmws->window_size;
> > +       end = cfmws->base_hpa + cfmws->window_size - 1;
> >
> >         /*
> >          * The SRAT may have already described NUMA details for all,
> >
> > base-commit: b85ea95d086471afb4ad062012a4d73cd328fa86
> > --
> 
> Applied as 6.8 material, thanks!

Sorry Rafael - this patch is bad.  Can you back it out?

I got some feedback here that showed this breaks a subsequent call
to numa_add_memblks().
https://lore.kernel.org/linux-cxl/ZYyozZcK9g4JE11B@aschofie-mobl2/T/#m16f13cafc186c7ebbf6037b3ae0e3ae572a83f77

ATM I expect this will lead to a fix in x86/mm/numa, not ACPI.

My apologies for messing up the mailing list and causing this confusion.

Alison





