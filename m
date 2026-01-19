Return-Path: <linux-acpi+bounces-20428-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AD71AD3B4DC
	for <lists+linux-acpi@lfdr.de>; Mon, 19 Jan 2026 18:49:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2FE003008CBD
	for <lists+linux-acpi@lfdr.de>; Mon, 19 Jan 2026 17:49:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C1B332E12E;
	Mon, 19 Jan 2026 17:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OkUuL1e7"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C23BA29BDB4
	for <linux-acpi@vger.kernel.org>; Mon, 19 Jan 2026 17:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768844961; cv=none; b=YucAyW0ndxHDC+GDDL4RT+vQPIM/Y2K44KP4WTTAcWrgzvXRNkMh8uQPRyAR0Q+jf3WLOc26Pgn+j465kKisAyaMPDBogEQLNJSgj0nzzzWjrNgvOulnlClK1snMb7c3xvLdhbXrs0EMF8Q7cbDVNtYa8nu8qR1lGrKo47hiakY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768844961; c=relaxed/simple;
	bh=Ykzuhr3ib32HJsTkEqWFoPzKfCDyuSUjSpZsz0qJoVE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=muho2Eu3maEwZZM35XA7CYjQ2PBMSDuhg+SGr9NaxSAojeR8l5iMGPvMJpqMfu46F+WHD5ydmpC2SuqG8GVO8VLGD1F99OjBwPvQy0GScOBe0qAc4tNriqpBSiAI0GwOOHDdNkZpmKcpscXw+6NAzidch+fZF42+htU8NujrWO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OkUuL1e7; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768844959; x=1800380959;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Ykzuhr3ib32HJsTkEqWFoPzKfCDyuSUjSpZsz0qJoVE=;
  b=OkUuL1e7NOsAe2nX/4zN3XJVzHeD6y5sFU3wzN2wZXSNZshGmUWWGDNk
   vhFAl28jpuPgAgUXqUY0gNc2NuqCdmreOaKU7lrISjDUsUByZYD6OEDHJ
   xk+i2OPu3ELXAe3SjmoFltpfuKiR5ah1B2og4DXObHB88gOrRdR0swe0w
   Wko9IxAimxW2VJq7P4BgInx8B/0wFfy0D3MAMYg11EK4fWL+IdC8SPHgi
   sXYoPLPgeAvm8XeXiLpGs5hYrjoBZHhMbqWEQHzSHb0jVHXddvbAIaQy4
   slRe8Lf1btQQzlRpS6adJQfY/EKRo2wJ2mQD7TWpKtAqpXFZ39h3K6R/g
   A==;
X-CSE-ConnectionGUID: tviIFAnVRQGQKQyCYT96vA==
X-CSE-MsgGUID: IyADvrIORKy+vskA4+oGXw==
X-IronPort-AV: E=McAfee;i="6800,10657,11676"; a="70221318"
X-IronPort-AV: E=Sophos;i="6.21,238,1763452800"; 
   d="scan'208";a="70221318"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2026 09:49:19 -0800
X-CSE-ConnectionGUID: J+zoWjvKTMW7ByYoov3Y6g==
X-CSE-MsgGUID: F37MgUo6S/W7lXLFvCHvlQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,238,1763452800"; 
   d="scan'208";a="205070465"
Received: from egrumbac-mobl6.ger.corp.intel.com (HELO localhost) ([10.245.244.37])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2026 09:49:17 -0800
Date: Mon, 19 Jan 2026 19:49:14 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Ivan Vecera <ivecera@redhat.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>, linux-acpi@vger.kernel.org
Subject: Re: [Question] Best practice for ACPI representation of
 DPLL/Ethernet dependencies (SyncE)
Message-ID: <aW5umnz8RdQiIzoi@smile.fi.intel.com>
References: <3bf214b9-8691-44f7-aa13-8169276a6c2b@redhat.com>
 <aWgAfsycBDc0mlFv@smile.fi.intel.com>
 <16e32f1c-8419-44cf-9da8-4c0cae6165e7@redhat.com>
 <aWjpQhGyHXXjsx2b@smile.fi.intel.com>
 <6debcd61-c60e-4436-8e31-c3210528b755@redhat.com>
 <aW5mn9pXYOU-3djd@smile.fi.intel.com>
 <a7b9b269-94a2-436d-b51a-cc2ffc98ea69@lunn.ch>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a7b9b269-94a2-436d-b51a-cc2ffc98ea69@lunn.ch>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Jan 19, 2026 at 06:43:55PM +0100, Andrew Lunn wrote:
> > P.S. Currently I can consider this as Plan B if we found no other better designs.
> > However it would be nice to see some review from network people, such as
> > Andrew Lunn and Vladimir Oltean. They know much more about networking HW
> > topologies and they have an expertise in ACPI.
> 
> I've been reviewing the DT parts. And the DT Maintainers are also
> looking at the patches.
> 
> But the question being addressed here is, do we want an ACPI binding,
> following ACPI guidelines etc. Or is it OK to just stuff the DT
> binding as is into ACPI tables?  No native ACPI binding?

It depends. If [6] was trying to address what [7] describes in the specification
and if the current problem with clock fits into all this, perhaps we need to
finalize the work started in [6].

> Putting DT into ACPI seems to be accepted when there is a long
> established DT binding, but ACPI has nothing. Which is common for
> networking with SoCs and Linux driving the hardware, not firmware. But
> this is all new, its a new DT binding, should there also be a new ACPI
> binding?

Yeah, I understood that point. Unfortunately I'm not so fluent in the Clock
related parts in ACPI, and I remember that Niyas did something in the area
while he was working for Linaro. Personally, I was interested only in pin
control integration part, so I haven't ever looked into other (missing)
parts he tried to develop.

-- 
With Best Regards,
Andy Shevchenko



