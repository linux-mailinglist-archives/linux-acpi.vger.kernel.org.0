Return-Path: <linux-acpi+bounces-5747-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 18E128C2945
	for <lists+linux-acpi@lfdr.de>; Fri, 10 May 2024 19:30:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C2BCC1F2345D
	for <lists+linux-acpi@lfdr.de>; Fri, 10 May 2024 17:30:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8789E18637;
	Fri, 10 May 2024 17:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nu1ZwXKF"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB2331803E;
	Fri, 10 May 2024 17:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715362192; cv=none; b=b1oDGQyZAv5QahBwluUWI5tthWqFw0HwJXM1Icm2NTs/Hh5ycT5EirC8/N8KP4sKHVl6ke/LHOBGlclkoLNkuvapmQhvzHTDDEqKs1UsYd03ikePU84RXUC1er6tiMTCol+wLIb2i4UHj1TcpyIAokY6x3nKwm3hi3XWklu5hQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715362192; c=relaxed/simple;
	bh=IM62IdPqbbrlf+47zTF5+ZxS3VRQFBoG3MfekHn4a/U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GE9s0fSk6DbgCQvfBD6P+4i9nkh+cvQ9dExOikUCPBiT5P+ZMJXQ9t9VGY1wRFVotud5iHwjxpext6djoBX85T/HmzCV5PnIMa0E3UiUCnLY9ToCnCmrUeouaDj4Jd/v5LPr0MsaLcum1i/nm8NZMqXdOieDt4vuGyJKeVECZtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nu1ZwXKF; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715362191; x=1746898191;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=IM62IdPqbbrlf+47zTF5+ZxS3VRQFBoG3MfekHn4a/U=;
  b=nu1ZwXKFFAJO3TKJTw931isF9e4QymDjViqY+YPU8kkYSbpGqkjJAvl0
   Y4eSD/XhTU5o8mYaWlGn/UFSW1hVtA6yyQkG3kj6XpZAnqP7Jj4oIYjkF
   4x0dc/8ae7thRs/lKwUyXWbg0RryVeoWRq2PwU5Uyqc+ODffL8Bar34i8
   D03W69x7zAnpXM/0TS3eRqLwdpYMsojEOhr1rQZJxlsFXLP0uAjH+SLC4
   XiXAQD7FrpH7EOvRLcBSKpgCIsQIylsy+Z8iACdSFR+vFoSiIBkWNN0JO
   pKgV7FUH+F8iY+kJpTLdOulMmOh6ESuKkk1pROumTi4H59GgoCSOJo7KP
   A==;
X-CSE-ConnectionGUID: 80blKQsbS66pvmy0u/ApAw==
X-CSE-MsgGUID: Mnm9o9LIQj2JWfh3MBuipQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11069"; a="22027872"
X-IronPort-AV: E=Sophos;i="6.08,151,1712646000"; 
   d="scan'208";a="22027872"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2024 10:29:31 -0700
X-CSE-ConnectionGUID: sDHCGTWoTJmE9w8BfTRgNQ==
X-CSE-MsgGUID: eVUVpjMgSY+xnt7w2pOhVQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,151,1712646000"; 
   d="scan'208";a="30066357"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2024 10:29:29 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1s5U3i-00000006C8e-0vd6;
	Fri, 10 May 2024 20:29:26 +0300
Date: Fri, 10 May 2024 20:29:25 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Armin Wolf <W_Armin@gmx.de>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Linux ACPI <linux-acpi@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Hans de Goede <hdegoede@redhat.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>
Subject: Re: [PATCH v1 1/2] ACPI: EC: Install address space handler at the
 namespace root
Message-ID: <Zj5ZdcQeaTo9ImT4@smile.fi.intel.com>
References: <5787281.DvuYhMxLoT@kreacher>
 <4926735.31r3eYUQgx@kreacher>
 <ac04c433-b0ac-4b82-b8eb-98ac16f872d8@gmx.de>
 <CAJZ5v0g_NjGHRvhm-N5vQFnOsqnxExSq99v8n_B_6ANoaCga0w@mail.gmail.com>
 <568291fc-fd79-4f08-9eb7-aed7f5a32345@gmx.de>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <568291fc-fd79-4f08-9eb7-aed7f5a32345@gmx.de>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Fri, May 10, 2024 at 06:52:41PM +0200, Armin Wolf wrote:
> Am 10.05.24 um 18:41 schrieb Rafael J. Wysocki:
> > On Fri, May 10, 2024 at 6:10 PM Armin Wolf <W_Armin@gmx.de> wrote:
> > > Am 10.05.24 um 16:03 schrieb Rafael J. Wysocki:
> > > 
> > > > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > > > 
> > > > It is reported that _DSM evaluation fails in ucsi_acpi_dsm() on Lenovo
> > > > IdeaPad Pro 5 due to a missing address space handler for the EC address
> > > > space:
> > > > 
> > > >    ACPI Error: No handler for Region [ECSI] (000000007b8176ee) [EmbeddedControl] (20230628/evregion-130)
> > > > 
> > > > This happens because the EC driver only registers the EC address space
> > > > handler for operation regions defined in the EC device scope of the
> > > > ACPI namespace while the operation region being accessed by the _DSM
> > > > in question is located beyond that scope.
> > > > 
> > > > To address this, modify the ACPI EC driver to install the EC address
> > > > space handler at the root of the ACPI namespace.
> > > > 
> > > > Note that this change is consistent with some examples in the ACPI
> > > > specification in which EC operation regions located outside the EC
> > > > device scope are used (for example, see Section 9.17.15 in ACPI 6.5),
> > > > so the current behavior of the EC driver is arguably questionable.
> > > Hi,
> > > 
> > > the patch itself looks good to me, but i wonder what happens if multiple
> > > ACPI EC devices are present. How would we handle such a situation?
> > I'm wondering if this is a theoretical question or do you have any
> > existing or planned systems in mind?
> > 
> > ec_read(), ec_write() and ec_transaction() use only the first EC that
> > has been found anyway.
> 
> Its a theoretical question, i do not know of any systems which have more than
> one ACPI EC device.

The specification is clear about this case in the "ACPI Embedded Controller
Interface Specification":

 "The ACPI standard supports multiple embedded controllers in a system,
  each with its own resources. Each embedded controller has a flat
  byte-addressable I/O space, currently defined as 256 bytes."

However, I haven't checked deeper, so it might be a leftover in the documentation.

The OperationRegion() has no reference to the EC (or in general, device) which
we need to speak to. The only possibility to declare OpRegion() for the second+
EC is to use vendor specific RegionSpace, AFAIU. So, even if ACPI specification
supports 2+ ECs, it doesn't support OpRegion():s for them under the same
RegionSpace.

That said, the commit message might be extended to summarize this, but at
the same time I see no way how this series can break anything even in 2+ ECs
environments.

> This patch would prevent any ACPI ECs other than the first one from probing,
> since they would fail to register their address space handler.
> I am just curious if/how we want to handle such situations.

-- 
With Best Regards,
Andy Shevchenko



