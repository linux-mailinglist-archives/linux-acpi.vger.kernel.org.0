Return-Path: <linux-acpi+bounces-13959-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1047EAC8501
	for <lists+linux-acpi@lfdr.de>; Fri, 30 May 2025 01:33:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 06C174E21AD
	for <lists+linux-acpi@lfdr.de>; Thu, 29 May 2025 23:33:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F22B61F9A8B;
	Thu, 29 May 2025 23:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LibHDXoG"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63B6FB67F;
	Thu, 29 May 2025 23:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748561626; cv=none; b=dtCG0rvyqvMBJPA7blWaMuMtbXvr/uyjFszovYstZvFMQSyfpPVRkk8KvsYBSMFYtJbKQn+zYP2MRb3Ba2TKb7UMPxwTuqOu1ASO1SmH51dB+5YeRRrQ7caLm9ogfrJx80SjiXZ2fcBjWVCdKtJaJFVZmbZWlkxh+SSm+U9//gg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748561626; c=relaxed/simple;
	bh=F5kC2T+fQRVkShX/0xHqMLA779YOSE1H8edcWM3ERg4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BLFKqQwvcnxPLm8YJ39TcXPATDSebTMqXw8+sfJ/NNwzeT8oTUtwMrZr9KStwoFPEYxSnrdKVExH2TOYwXxTq2RcPl6kErMY9zKnFnZLLmISCrxhKkEEQT5L8KXAX4ZaiSUPnYHd5SRVW5lrIkICTYyvkvk+RGwhVin94H1ZQxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LibHDXoG; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1748561625; x=1780097625;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=F5kC2T+fQRVkShX/0xHqMLA779YOSE1H8edcWM3ERg4=;
  b=LibHDXoG8Cck+7FfVZojTAEUdM4rYt8+mko/Ol1dN0GcfRVO+1x2pF69
   7uYHZsqHYRCJZ2cSp7sUN//QfZBBVpBwesi9taYt4TGhDLqzBJFwtQTw5
   H2jVMi46mERrogpFm8/xN2wYbkRyOwaD8Z+xV2JfAOvqQla0ktF8jfbL4
   otnCQQ/JJuzX7tGyIaJs51rbV4Wlwyten8rjLdoOJv811Z8z+0QeLd8zD
   Z3LLYPViZ9i73THNRF+r7bi7+K+SCn7uNCj2p0ifVwi7rYUzJcEeGolY1
   +zU2E2oU0CdGtRfJvpZBbCZo/J32zclGCE6kDoDQpr8XU6ysDuezrLPn7
   w==;
X-CSE-ConnectionGUID: 3cthqj9LTHSPeeEff4Wieg==
X-CSE-MsgGUID: gCoqkBRURmmk0kHBKOAOqA==
X-IronPort-AV: E=McAfee;i="6700,10204,11448"; a="76038523"
X-IronPort-AV: E=Sophos;i="6.16,194,1744095600"; 
   d="scan'208";a="76038523"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2025 16:33:44 -0700
X-CSE-ConnectionGUID: 89wOSwpoStC2dKBA3sLkAQ==
X-CSE-MsgGUID: kn6bkt0gRp2PCMkVHB6A2A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,194,1744095600"; 
   d="scan'208";a="148864299"
Received: from agluck-desk3.sc.intel.com (HELO agluck-desk3) ([172.25.103.51])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2025 16:33:44 -0700
Date: Thu, 29 May 2025 16:33:43 -0700
From: "Luck, Tony" <tony.luck@intel.com>
To: Zaid Alali <zaidal@os.amperecomputing.com>
Cc: rafael@kernel.org, lenb@kernel.org, james.morse@arm.com, bp@alien8.de,
	robert.moore@intel.com, Jonathan.Cameron@huawei.com,
	ira.weiny@intel.com, Benjamin.Cheatham@amd.com,
	dan.j.williams@intel.com, arnd@arndb.de, Avadhut.Naik@amd.com,
	u.kleine-koenig@pengutronix.de, john.allen@amd.com,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
	acpica-devel@lists.linux.dev
Subject: Re: [PATCH v7 9/9] ACPI: APEI: EINJ: Update the documentation for
 EINJv2 support
Message-ID: <aDju183CpNozCj1-@agluck-desk3>
References: <20250506213814.2365788-1-zaidal@os.amperecomputing.com>
 <20250506213814.2365788-10-zaidal@os.amperecomputing.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250506213814.2365788-10-zaidal@os.amperecomputing.com>

On Tue, May 06, 2025 at 02:38:13PM -0700, Zaid Alali wrote:
> +  # echo 0x12345000 > param1			# Set memory address for injection
> +  # echo 0xfffffffffffff000 > param2		# Range - anywhere in this page
> +  # comp_arr="0x1 0x2				# Fill in the component array
> +    >0x1 0x4
> +    >0x2 0x4"
> +  # echo "$comp_arr" > einjv2_component_array

Seems complex (and may confuse people as the ">" in the lines setting
up the comp_arr are secondary prompts from bash, not part if the input).

If they miss the "" around $comp_arr in the last line they will
get all the values on one line which will be rejected with -EINVAL
during injection.

This works better (and is shorter too!):

# echo -e '0x1 0x2\n0x1 0x4\n0x2 0x4\n\0' > einjv2_component_array

I think explicitly terminating the input with '\0' is needed (and that
the kernel should NOT zero out the einjv2_component_array blob
on each injection.  That's unlike the other einj paramaters which
are "sticky". The user can repeat the same injection without resetting
all the parameters each time, just "echo 1 > error_inject" to do the
same thing again.

-Tony

