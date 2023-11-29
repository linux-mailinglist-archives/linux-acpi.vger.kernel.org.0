Return-Path: <linux-acpi+bounces-1907-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D4FA7FD471
	for <lists+linux-acpi@lfdr.de>; Wed, 29 Nov 2023 11:39:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D8371C20FD0
	for <lists+linux-acpi@lfdr.de>; Wed, 29 Nov 2023 10:39:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F660199A5
	for <lists+linux-acpi@lfdr.de>; Wed, 29 Nov 2023 10:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="K+bFL8qf"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 314E2F5;
	Wed, 29 Nov 2023 01:01:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701248512; x=1732784512;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=jUfEMJcGPk/pC7rsEa3j89yXra3uK2XLsI3C0myADGQ=;
  b=K+bFL8qfFmlKh1ttGEsFUEZAFiFY9d04DIw8qK6wpWJgus4rMeXk39zJ
   GqPPTawDDUPx/ocm8YUxOA7p0ue7x5k/Oc//IYEiuTSzHzn45VLCsGm85
   vxZQvCTgBmrG8hD8GIMQP1ehZ7mYmQctXG9pCl5idyOiDxzGwEEy9KSrN
   uWzjrey9zrswmXIcRoqzkIoSUcjAN58OMowJjkCdLWkmbuPJp8gngsEEV
   P9Bi0ZI8ML0JRwRnnL48YGNViIkxM+goUq8H/DLh3vxpm8Gwuxs8C7sKh
   3RNGxUnULO3y1MGcQHg7HjVrT5h5sRbxc1gtcl2WBD20Dw54bP+CvqLib
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10908"; a="479328165"
X-IronPort-AV: E=Sophos;i="6.04,235,1695711600"; 
   d="scan'208";a="479328165"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2023 00:56:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10908"; a="942247871"
X-IronPort-AV: E=Sophos;i="6.04,235,1695711600"; 
   d="scan'208";a="942247871"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga005.jf.intel.com with ESMTP; 29 Nov 2023 00:56:01 -0800
Received: by black.fi.intel.com (Postfix, from userid 1001)
	id 9036B23A; Wed, 29 Nov 2023 10:56:00 +0200 (EET)
Date: Wed, 29 Nov 2023 10:56:00 +0200
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux ACPI <linux-acpi@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Michal Wilczynski <michal.wilczynski@intel.com>,
	Hans de Goede <hdegoede@redhat.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Mario Limonciello <mario.limonciello@amd.com>
Subject: Re: [RFT][PATCH v1] ACPI: OSL: Use a threaded interrupt handler for
 SCI
Message-ID: <20231129085600.GQ1074920@black.fi.intel.com>
References: <5745568.DvuYhMxLoT@kreacher>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5745568.DvuYhMxLoT@kreacher>

Hi Rafael,

On Mon, Nov 27, 2023 at 08:57:43PM +0100, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> In the current arrangement, all of the acpi_ev_sci_xrupt_handler() code
> is run as an interrupt handler for the SCI, in interrupt context.  Among
> other things, this causes it to run with local interrupts off which
> can be problematic if many GPEs are enabled and they are located in the
> I/O address space, for example (because in that case local interrupts
> will be off for the duration of all of the GPE hardware accesses carried
> out while handling an SCI combined and that may be quite a bit of time
> in extreme scenarios).
> 
> However, there is no particular reason why the code in question really
> needs to run in interrupt context and in particular, it has no specific
> reason to run with local interrupts off.  The only real requirement is
> to prevent multiple instences of it from running in parallel with each
> other, but that can be achieved regardless.
> 
> For this reason, use request_threaded_irq() instead of request_irq() for
> the ACPI SCI and pass IRQF_ONESHOT to it in flags to indicate that the
> interrupt needs to be masked while its handling thread is running so as
> to prevent it from re-triggering while it is being handled (and in
> particular until the final handled/not handled outcome is determined).
> 
> While at it, drop a redundant local variable from acpi_irq().
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
> 
> The code inspection and (necessarily limited) testing carried out by me
> are good indications that this should just always work, but there may
> be still some really odd platform configurations I'm overlooking, so if
> you have a way to give it a go, please do so.

Tried this on ADL-S and ADL-P systems that I have here and both work
just fine with the patch applied. I can see SCI interrupt count
increases in /proc/interrupts as expected. Did a couple of s2idle cycles
too, all good.

Tested-by: Mika Westerberg <mika.westerberg@linux.intel.com>

