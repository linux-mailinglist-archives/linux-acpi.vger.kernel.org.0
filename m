Return-Path: <linux-acpi+bounces-5753-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE25E8C298D
	for <lists+linux-acpi@lfdr.de>; Fri, 10 May 2024 19:50:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7DD4C2869BC
	for <lists+linux-acpi@lfdr.de>; Fri, 10 May 2024 17:50:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F7841B285;
	Fri, 10 May 2024 17:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SzZyoRd0"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0668717C7F;
	Fri, 10 May 2024 17:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715363437; cv=none; b=F5g+qOyV0PM+1nAtqGSfYS3O/+cjgxHezETuF50/ipQW2mVq+iedDRqbesriV7fwl/+G6GrMDclxM+Q1H9rHWd34UXJaJe3RNLmR/lPa7+59w6UQOzAn1n/mSxC5iCg9S/aTqz8FBW4032NpXAA4il26XUwpgrAy+qeizW8M0xM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715363437; c=relaxed/simple;
	bh=LH3ma9kabQkMoptj6dmpENxipMXJcBlX0fBO5XwwGTk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dbG1iSuBzMiIPnm2ENlFP/36nH+8onCUhQ1779QX5MFG7+2qqIeJ4LzcTS65QGYpVHGKBkfTxEnqsxacaHxZeqG5EcNm5E5V0JSbmrWV009kpkNB9q8t3s1strZkXGlm1cfiU9JBSRZtlrSpRW38sfmF03l7RaXxsNg4F6k4/40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SzZyoRd0; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715363435; x=1746899435;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=LH3ma9kabQkMoptj6dmpENxipMXJcBlX0fBO5XwwGTk=;
  b=SzZyoRd0YFwJC7SWsvRzS0FvH7p7GMg4AUMI4hmQNJFVg2Lfpqbt8/KU
   qswtkUDnVQwwZtJJ/gsLkcMWrXGuoC7yQnpM3YqSmYskxkXvYAM58vkoO
   Cr5lcEzv+qPFA58QwHCsRydukLVLpE7CwCnS4vjLylsGdDVB6YfjvJeof
   sKN6zdvORxO1Z9ROWmVgMBRL9s/qdpUC1+oNpz4vG7G6GicGBQtCNCd/b
   tBYzoRqHp8iHNUuBdQxkRpRI/KZfWqHkWmSGjEu9n/cHbhOIg+LjLoJM5
   Gn+LGMUSJnS1zbsDnUVjiZRLnsYkfZKiMheWXAt7thpdBx6K78TeV9PmP
   Q==;
X-CSE-ConnectionGUID: VsQn48lSTmK4pzWxgZCUrg==
X-CSE-MsgGUID: CrNroRcyRgGSwSXykqFyAg==
X-IronPort-AV: E=McAfee;i="6600,9927,11069"; a="11520917"
X-IronPort-AV: E=Sophos;i="6.08,151,1712646000"; 
   d="scan'208";a="11520917"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2024 10:50:34 -0700
X-CSE-ConnectionGUID: wyYjuQEFTUe2nLo9LTRGeQ==
X-CSE-MsgGUID: Z/kqLkQ7Q5iCCPTQ1N2Nqg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,151,1712646000"; 
   d="scan'208";a="67174972"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2024 10:50:32 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1s5UO5-00000006CbM-0TN8;
	Fri, 10 May 2024 20:50:29 +0300
Date: Fri, 10 May 2024 20:50:28 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: Armin Wolf <W_Armin@gmx.de>, "Rafael J. Wysocki" <rafael@kernel.org>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Linux ACPI <linux-acpi@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Hans de Goede <hdegoede@redhat.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>
Subject: Re: [PATCH v1 1/2] ACPI: EC: Install address space handler at the
 namespace root
Message-ID: <Zj5eZKgpg3LFpne8@smile.fi.intel.com>
References: <5787281.DvuYhMxLoT@kreacher>
 <4926735.31r3eYUQgx@kreacher>
 <ac04c433-b0ac-4b82-b8eb-98ac16f872d8@gmx.de>
 <CAJZ5v0g_NjGHRvhm-N5vQFnOsqnxExSq99v8n_B_6ANoaCga0w@mail.gmail.com>
 <568291fc-fd79-4f08-9eb7-aed7f5a32345@gmx.de>
 <Zj5ZdcQeaTo9ImT4@smile.fi.intel.com>
 <0cdf0af6-851b-4781-83fe-99320c35544f@amd.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0cdf0af6-851b-4781-83fe-99320c35544f@amd.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Fri, May 10, 2024 at 12:40:05PM -0500, Mario Limonciello wrote:
> On 5/10/2024 12:29, Andy Shevchenko wrote:
> > On Fri, May 10, 2024 at 06:52:41PM +0200, Armin Wolf wrote:
> > > Am 10.05.24 um 18:41 schrieb Rafael J. Wysocki:
> > > > On Fri, May 10, 2024 at 6:10 PM Armin Wolf <W_Armin@gmx.de> wrote:
> > > > > Am 10.05.24 um 16:03 schrieb Rafael J. Wysocki:
> > > > > 
> > > > > > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > > > > > 
> > > > > > It is reported that _DSM evaluation fails in ucsi_acpi_dsm() on Lenovo
> > > > > > IdeaPad Pro 5 due to a missing address space handler for the EC address
> > > > > > space:
> > > > > > 
> > > > > >     ACPI Error: No handler for Region [ECSI] (000000007b8176ee) [EmbeddedControl] (20230628/evregion-130)
> > > > > > 
> > > > > > This happens because the EC driver only registers the EC address space
> > > > > > handler for operation regions defined in the EC device scope of the
> > > > > > ACPI namespace while the operation region being accessed by the _DSM
> > > > > > in question is located beyond that scope.
> > > > > > 
> > > > > > To address this, modify the ACPI EC driver to install the EC address
> > > > > > space handler at the root of the ACPI namespace.
> > > > > > 
> > > > > > Note that this change is consistent with some examples in the ACPI
> > > > > > specification in which EC operation regions located outside the EC
> > > > > > device scope are used (for example, see Section 9.17.15 in ACPI 6.5),
> > > > > > so the current behavior of the EC driver is arguably questionable.
> > > > > Hi,
> > > > > 
> > > > > the patch itself looks good to me, but i wonder what happens if multiple
> > > > > ACPI EC devices are present. How would we handle such a situation?
> > > > I'm wondering if this is a theoretical question or do you have any
> > > > existing or planned systems in mind?
> > > > 
> > > > ec_read(), ec_write() and ec_transaction() use only the first EC that
> > > > has been found anyway.
> > > 
> > > Its a theoretical question, i do not know of any systems which have more than
> > > one ACPI EC device.
> > 
> > The specification is clear about this case in the "ACPI Embedded Controller
> > Interface Specification":
> > 
> >   "The ACPI standard supports multiple embedded controllers in a system,
> >    each with its own resources. Each embedded controller has a flat
> >    byte-addressable I/O space, currently defined as 256 bytes."
> > 
> > However, I haven't checked deeper, so it might be a leftover in the documentation.
> > 
> > The OperationRegion() has no reference to the EC (or in general, device) which
> > we need to speak to. The only possibility to declare OpRegion() for the second+
> > EC is to use vendor specific RegionSpace, AFAIU. So, even if ACPI specification
> > supports 2+ ECs, it doesn't support OpRegion():s for them under the same
> > RegionSpace.
> > 
> > That said, the commit message might be extended to summarize this, but at
> > the same time I see no way how this series can break anything even in 2+ ECs
> > environments.
> 
> It's deviating from the patch, but in practice /why/ would you even want to
> have a design with two ECs?  In general that is going to mean a much more
> complex state machine with synchronizing the interaction between both of
> them and the host.
> 
> Understanding the benefit of such a design might make it easier to
> hypothesize impacts.

First that comes to my mind (but hypothetical), is the separate CPU/EC add-on
cards. If the main firmware somehow supports all of these add-on platforms,
it might need to handle 2+ ECs.

Again, it might be ACPI specification issue. For instance, the cited piece
doesn't tell about 16-bit EC accesses.

> > > This patch would prevent any ACPI ECs other than the first one from probing,
> > > since they would fail to register their address space handler.
> > > I am just curious if/how we want to handle such situations.

-- 
With Best Regards,
Andy Shevchenko



