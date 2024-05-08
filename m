Return-Path: <linux-acpi+bounces-5657-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5090E8BFD07
	for <lists+linux-acpi@lfdr.de>; Wed,  8 May 2024 14:21:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0AAD92810DD
	for <lists+linux-acpi@lfdr.de>; Wed,  8 May 2024 12:21:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5798783CBB;
	Wed,  8 May 2024 12:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SAIQY3kP"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D85AE7D405
	for <linux-acpi@vger.kernel.org>; Wed,  8 May 2024 12:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715170865; cv=none; b=aOQ72gPWe0voXo51o8ZVoAgB9agYyL2xbwWtCBP2s0Vs1SQ/45Ityqd69LRMe8BX5TlwZc/DCbBQlOyNDQgoPAlgxSrl9rFlCQIpDOLeR5bDYovFvgB5DS2CR+t+MO2RD3B3t+XRV5GYhSZhauHac5Y0+MkREeAFRLImpmjfJ74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715170865; c=relaxed/simple;
	bh=XHYHk6h7rjAg4SlC+GlVGq+w7hRUI5AYJFJZ3GuIpmk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sgLXbOK2srmnaq7VwFRTHbZDKi2s3cyZK39EAmgp9sC6gnWDWUdCsU7VQ2yb07CK18tfwVdb7pVPt3/ojBdpBUqAgH4LZN5Dx2bltfEv5WXzIFQ1jYwRpPT11mHxi6Moc6eC3TBAZsGe2UNZJJDIYV6Ze8+SwpRXcgniCfmkJ50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SAIQY3kP; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715170864; x=1746706864;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=XHYHk6h7rjAg4SlC+GlVGq+w7hRUI5AYJFJZ3GuIpmk=;
  b=SAIQY3kPlnDNWQ1u0oE4l1D/CshiXvjXjXW+1lprr9bDJsl5rvYVSxfp
   goGZ4XtFqwweh8s6cDfxL4vFo30Ua7MkGUi9lhZDfDenY88O2ANSb+4yM
   RAnXu9Xt3gW7lXnHsCb3GRclAAoICpDp6UXazl6WhGoHmtCJbZbzFXeWp
   ZIxs1cNQCj1R+0joht4irSnq79llOcZF8WZqqHGhc68yVvwTdCjD1kvo2
   HEVQ1XBocXwxh/ijGwzE+TW9qXGjhK9bJO/NOjQ3YKRQ/XYP6EAraY7Sq
   ti2J7K1iI34CV8cQWMUScHqvar9qWKOTQbreT91CcrTUnaddWtCBgHt3T
   A==;
X-CSE-ConnectionGUID: PuLwfhgyR9C+BtkceluFNA==
X-CSE-MsgGUID: uagCD4yPRPekvAXFaYxhNA==
X-IronPort-AV: E=McAfee;i="6600,9927,11066"; a="14818855"
X-IronPort-AV: E=Sophos;i="6.08,145,1712646000"; 
   d="scan'208";a="14818855"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2024 05:21:03 -0700
X-CSE-ConnectionGUID: qsOlES5LTMWltWZPTwRQ/w==
X-CSE-MsgGUID: PTVzuUm2RVus5Rmuer4Iqg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,145,1712646000"; 
   d="scan'208";a="29390662"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by orviesa007.jf.intel.com with SMTP; 08 May 2024 05:21:00 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Wed, 08 May 2024 15:20:59 +0300
Date: Wed, 8 May 2024 15:20:59 +0300
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Len Brown <lenb@kernel.org>, Robert Moore <robert.moore@intel.com>,
	linux-acpi@vger.kernel.org, acpica-devel@lists.linux.dev
Subject: Re: Missing default handler for the EmbeddedControl OpRegion
Message-ID: <ZjtuKzqpfKFbRaUi@kuha.fi.intel.com>
References: <Zi+0whTvDbAdveHq@kuha.fi.intel.com>
 <CAJZ5v0iAMG251n6yg-h6KCUywK2vSg4sX3FTnOuxcLaEvUwFPQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0iAMG251n6yg-h6KCUywK2vSg4sX3FTnOuxcLaEvUwFPQ@mail.gmail.com>

On Mon, May 06, 2024 at 07:45:07PM +0200, Rafael J. Wysocki wrote:
> Hi,
> 
> On Mon, Apr 29, 2024 at 4:55 PM Heikki Krogerus
> <heikki.krogerus@linux.intel.com> wrote:
> >
> > Hi,
> >
> > There's a bug that is caused by an EmbeddedControl OpRegion which is
> > declared inside the scope of a specific USB Type-C device (PNP0CA0):
> > https://bugzilla.kernel.org/show_bug.cgi?id=218789
> 
> And in this bug you are essentially proposing to install the EC
> OpRegion handler at the namespace root instead of the EC device.
> 
> This sounds reasonable, although AFAICS this is a matter of modifying
> the EC driver (before the EC OpRegion handler is installed by the EC
> drvier, ACPICA has no way to handle EC address space accesses anyway).
> 
> > It looks like that's not the only case where that OpRegion ID is used
> > outside of the EC device scope. There is at least one driver in Linux
> > Kernel (drivers/platform/x86/wmi.c) that already has a custom handler
> > for the EmbeddedControl OpRegion, and based on a quick search, the
> > problem "Region EmbeddedControl (ID=3) has no handler" has happened
> > with some other devices too.
> 
> AFAICS, installing the EC address space handler at the EC device
> object itself is not based on any sound technical arguments, it's just
> been always done this way in Linux.  It's quite possible that the EC
> address space handler should have been installed at the namespace root
> from the outset.

Okay, thank you for the explanation. So can we simply change it like
this (I may have still misunderstood something)?

diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
index 02255795b800..6b9dd27171ee 100644
--- a/drivers/acpi/ec.c
+++ b/drivers/acpi/ec.c
@@ -1488,7 +1488,7 @@ static int ec_install_handlers(struct acpi_ec *ec, struct acpi_device *device,
 
        if (!test_bit(EC_FLAGS_EC_HANDLER_INSTALLED, &ec->flags)) {
                acpi_ec_enter_noirq(ec);
-               status = acpi_install_address_space_handler_no_reg(ec->handle,
+               status = acpi_install_address_space_handler_no_reg(ACPI_ROOT_OBJECT,
                                                                   ACPI_ADR_SPACE_EC,
                                                                   &acpi_ec_space_handler,
                                                                   NULL, ec);
@@ -1497,7 +1497,7 @@ static int ec_install_handlers(struct acpi_ec *ec, struct acpi_device *device,
                        return -ENODEV;
                }
                set_bit(EC_FLAGS_EC_HANDLER_INSTALLED, &ec->flags);
-               ec->address_space_handler_holder = ec->handle;
+               ec->address_space_handler_holder = ACPI_ROOT_OBJECT;
        }
 
        if (call_reg && !test_bit(EC_FLAGS_EC_REG_CALLED, &ec->flags)) {

thanks,

-- 
heikki

