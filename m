Return-Path: <linux-acpi+bounces-8934-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C4F19AD26C
	for <lists+linux-acpi@lfdr.de>; Wed, 23 Oct 2024 19:21:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 551AB1C218B2
	for <lists+linux-acpi@lfdr.de>; Wed, 23 Oct 2024 17:21:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D2A51CEEA5;
	Wed, 23 Oct 2024 17:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PFPG915a"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF4451CC8AA;
	Wed, 23 Oct 2024 17:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729704058; cv=none; b=ZKIo3OoiEsMFq3kd2mGRSHHYXP4nR6/e8fzZ/+elhtYwCOIF1MwydxC9RjS0FPQsvOPoWxIc7I5r7EGWW6rbC0m7BOP9M2HsW6euTVNJsoC7sh1yMVEN7fkN9qLPwWSccMnMkVRLo9vrndjzfDxhN/zUy9sV2CfWsGE5K03M3Fk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729704058; c=relaxed/simple;
	bh=ez8ql2SG1sc2hyGeYZeeLamv0TSCW3Far16SATtP3TQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eFVTINtgXzX1NSwkXT8JB7c1Dck0D2rnfJw56Uy1sYsWxKTq+hJZu6cPYBMI6m7Hp+A7cRmnEzGdSLGUZJxRdcyWUWwyyd02ivwLnSMQ7lPkB8dTIEEt5v3HWB5BvN39IWGlwQfIjWvRGhKwK3zW2JaySHsUGz7wBTgz7gimFho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PFPG915a; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729704057; x=1761240057;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ez8ql2SG1sc2hyGeYZeeLamv0TSCW3Far16SATtP3TQ=;
  b=PFPG915aJzLWXlov0GTMR0GxWjsGKnPECWhdnUl1froW8of61n/IUpcG
   TKa41hNeoegjWtwxUqyank8OPkV1cQyAmh16mvpJZ8ltbhA0/hwoP946C
   TO0Na9RHvOhyDYX2KuNm4+EVSKxXaQASZqU//QzxV/sHV3ZWSdP42g7v7
   9Rd617sjNINWaDSYIkoCWjCOQnDPrmD5fmtDo6i+BRUk6uPu8H+nUpQCa
   z31XD9LcuUh21gTj/HT+0JhvwO5ylpxFrnRd0fPp4wBmbIq6NSyJ+cOxJ
   xqT1aakQLyP5O4v65GOz2rtrfmG53tqSaortDbCqCJwP+fO5osknr19sD
   w==;
X-CSE-ConnectionGUID: jdS2Hrr9Ra6sgJIGd1F51A==
X-CSE-MsgGUID: S2C2s2bsQTibzUylJlUr5A==
X-IronPort-AV: E=McAfee;i="6700,10204,11234"; a="40699845"
X-IronPort-AV: E=Sophos;i="6.11,226,1725346800"; 
   d="scan'208";a="40699845"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2024 10:20:56 -0700
X-CSE-ConnectionGUID: n0/Zq1N5S6K3OWgFcL7fRQ==
X-CSE-MsgGUID: Ks1ydMzRTv+uDrJjR+RNSw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,226,1725346800"; 
   d="scan'208";a="111089977"
Received: from agluck-desk3.sc.intel.com ([172.25.222.70])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2024 10:20:56 -0700
Date: Wed, 23 Oct 2024 10:20:54 -0700
From: Tony Luck <tony.luck@intel.com>
To: Zaid Alali <zaidal@os.amperecomputing.com>
Cc: rafael@kernel.org, lenb@kernel.org, james.morse@arm.com, bp@alien8.de,
	robert.moore@intel.com, dan.j.williams@intel.com,
	Jonathan.Cameron@huawei.com, Benjamin.Cheatham@amd.com,
	Avadhut.Naik@amd.com, viro@zeniv.linux.org.uk, arnd@arndb.de,
	ira.weiny@intel.com, dave.jiang@intel.com,
	sthanneeru.opensrc@micron.com, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org, acpica-devel@lists.linux.dev
Subject: Re: [PATCH 8/8] ACPI: APEI: EINJ: Update the documentation for
 EINJv2 support
Message-ID: <ZxkwdinS4lbBX0mi@agluck-desk3.sc.intel.com>
References: <20241022213429.1561784-1-zaidal@os.amperecomputing.com>
 <20241022213429.1561784-9-zaidal@os.amperecomputing.com>
 <Zxgq33pNuWBvadet@agluck-desk3.sc.intel.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zxgq33pNuWBvadet@agluck-desk3.sc.intel.com>

On Tue, Oct 22, 2024 at 03:44:47PM -0700, Tony Luck wrote:
> On Tue, Oct 22, 2024 at 02:34:29PM -0700, Zaid Alali wrote:
> > +  # cd /sys/kernel/debug/apei/einj
> > +  # cat available_error_type			# See which errors can be injected
> > +  0x00000002	Processor Uncorrectable non-fatal
> > +  0x00000008	Memory Correctable
> > +  0x00000010	Memory Uncorrectable non-fatal
> > +  0x00000001	EINJV2 Processor Error
> > +  0x00000002	EINJV2 Memory Error
> 
> This seems confusing to me. Is 0x00000002 the code for a V1 processor
> uncorrectable, or a V2 memory error? It seems that the "error_type" file
> is interpreted differently depending on what is written to the "flags"
> file.

Maybe the confusion would be removed if the "error_type"
file is changed from using a hex number to using a string
which the einj driver parses.

Hex values are parsed as before as legacy EINJ types. To specify
a V2 EINJ type the user does:

# echo V2_0x2 > error_type

and EINJ driver then knows to treat the code as a V2 type (instead
of using a bit written to the flags file).

For consistency the available_error_type would show the V2_ prefix

# cat available_error_type                       # See which errors can be injected
0x00000002	Processor Uncorrectable non-fatal
0x00000008	Memory Correctable
0x00000010	Memory Uncorrectable non-fatal
V2_0x00000001	EINJV2 Processor Error
V2_0x00000002	EINJV2 Memory Error

-Tony


