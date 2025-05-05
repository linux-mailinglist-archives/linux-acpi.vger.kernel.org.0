Return-Path: <linux-acpi+bounces-13460-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 79CA0AA999C
	for <lists+linux-acpi@lfdr.de>; Mon,  5 May 2025 18:45:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 79F881882DD2
	for <lists+linux-acpi@lfdr.de>; Mon,  5 May 2025 16:46:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61DA326A0DD;
	Mon,  5 May 2025 16:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="finMZF8p"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F21726A08A;
	Mon,  5 May 2025 16:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746463536; cv=none; b=bE0Da3EOS+BV8YsYmA7YQF6cySSdaZgoOKZ7jTFRc38C6Q0AZohGIGRSHAGEtHThrEGorUvcCATEIACbQJj38Y9Ez9yiTFQNqnnNM/y5BDnsgY00/V/mA9yLDanWCUGSFPn552UtUYnjGQqpP7QPIZloG2CU3rUjsk1dq2JgXq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746463536; c=relaxed/simple;
	bh=Gv4eXUFcTvYjiREWJuTpviSsOck/71/pfvOrAJ08xBA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pD6B8IsYsVCxkwamTWph13B2GCJhbUKvbmSp53zih/Qr9GgOWbw/40BuREoYPDrjIDnh/VLi5FAuSSEVPsNfJlhU6yMXUqvmh4U5JquSZnIBa6bkch9bsEqlGxh/sf6XB5e+4iTs7FYqGaU+PgjI9dX+sT/D8kfjJqfGjbvIuaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=finMZF8p; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746463535; x=1777999535;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Gv4eXUFcTvYjiREWJuTpviSsOck/71/pfvOrAJ08xBA=;
  b=finMZF8p3oBaM7DGRWxODMgl6uIZascLxtoEV9gvcNmkMW0gJLd+RlIw
   Fe8LfnLpO1adbkhEnhNkSMOxCbK5nUwEKtW9IBt2AS5rGPbxWVZcJJZ8z
   MDAviA5bFd9ay/ckS7g+gXktZZ9iPVye3iHEwD92Z7b6wrfoarO9mgjXt
   XPP41UhqyI0q3rEP4Vir8TGAxXXkxkSPYTitxwiblkHguc2MyUZhBTKrY
   EA1ZQAahfLecDcZDYc1W164vltLcKu9InrawN/0tEWUscxzijk8pMxVqT
   26VEQW6VctcNxOQrTGNkRHqhO4AGTZw6vA8FNS7xVh5NBBCBgiuCGBhfj
   w==;
X-CSE-ConnectionGUID: CEhEnXlJTqCxTyWcVXTAew==
X-CSE-MsgGUID: 79UlazR+Rk+Elowy/Sa1Lw==
X-IronPort-AV: E=McAfee;i="6700,10204,11424"; a="73476309"
X-IronPort-AV: E=Sophos;i="6.15,264,1739865600"; 
   d="scan'208";a="73476309"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2025 09:45:34 -0700
X-CSE-ConnectionGUID: D8zJdc8VQa+ox6D5OxLR9g==
X-CSE-MsgGUID: WeV00H7URdqTAJ00dVst6Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,264,1739865600"; 
   d="scan'208";a="135236023"
Received: from agluck-desk3.sc.intel.com (HELO agluck-desk3) ([172.25.222.70])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2025 09:45:34 -0700
Date: Mon, 5 May 2025 09:45:26 -0700
From: "Luck, Tony" <tony.luck@intel.com>
To: Fenghua Yu <fenghuay@nvidia.com>
Cc: rafael@kernel.org, lenb@kernel.org,
	Anil Keshavamurthy <anil.s.keshavamurthy@intel.com>,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
	patches@lists.linux.dev
Subject: Re: [PATCH v4 4/4] ACPI: Add documentation for exposing MRRM data
Message-ID: <aBjrJvs-wuViTOSI@agluck-desk3>
References: <20250429202412.380637-1-tony.luck@intel.com>
 <20250429202412.380637-5-tony.luck@intel.com>
 <a5a6e279-82ec-4282-9cf2-6ec4a77a38f1@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a5a6e279-82ec-4282-9cf2-6ec4a77a38f1@nvidia.com>

On Sun, May 04, 2025 at 11:34:51PM -0700, Fenghua Yu wrote:
> Hi, Tony,
> 
> On 4/29/25 13:24, Tony Luck wrote:
> > Initial implementation provides enumeration of the address ranges
> > NUMA node numbers, and BIOS assigned region IDs for each range.
> > 
> > Signed-off-by: Tony Luck <tony.luck@intel.com>
> > ---
> >   Documentation/ABI/testing/sysfs-firmware-acpi | 21 +++++++++++++++++++
> >   1 file changed, 21 insertions(+)
> > 
> > diff --git a/Documentation/ABI/testing/sysfs-firmware-acpi b/Documentation/ABI/testing/sysfs-firmware-acpi
> > index 5249ad5a96d9..fffba38f9ce1 100644
> > --- a/Documentation/ABI/testing/sysfs-firmware-acpi
> > +++ b/Documentation/ABI/testing/sysfs-firmware-acpi
> > @@ -248,3 +248,24 @@ Description:
> >   		  # cat ff_pwr_btn
> >   		  7	enabled
> > +What:		/sys/firmware/acpi/memory_ranges/rangeX
> > +Date:		February 2025
> > +Contact:	Tony Luck <tony.luck@intel.com>
> > +Description:
> > +		On systems with the ACPI MRRM table reports the
> > +		parameters for each range.
> 
> Is there a need to explain what's "X" here? The "X" is not a number directly
> reported by MRRM, right?
> 
> Maybe something like "range ID is enumerated from MRRM starting from 0."?

I'm not sure about this one. "X" in the ABI documentation files is a
standard notation for "there are several of these with a number for
each". When the number does refer to some physical object, then there
may be a need to describe it. But if it is simply a counter to give a
separate name for each one of some repeating thing ... then I don't
think it helps to add additional explanation.

> 
> > +
> > +		base: Starting system physical address.
> > +
> > +		length: Length of this range in bytes.
> > +
> > +		node: NUMA node that this range belongs to. Negative numbers
> > +		indicate that the node number could not be determined (e.g
> > +		for an address range that is reserved for future hot add of
> > +		memory).
> > +
> > +		local_region_id: ID associated with access by agents
> > +		local to this range of addresses.
> > +
> > +		remote_region_id: ID associated with access by agents
> > +		non-local to this range of addresses.
> 
> Thanks.
> 
> -Fenghua

-Tony

