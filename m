Return-Path: <linux-acpi+bounces-14031-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E568CAC9801
	for <lists+linux-acpi@lfdr.de>; Sat, 31 May 2025 01:09:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E60411C044D8
	for <lists+linux-acpi@lfdr.de>; Fri, 30 May 2025 23:09:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2957128BAA3;
	Fri, 30 May 2025 23:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GlNTLfW8"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 804521D63D8;
	Fri, 30 May 2025 23:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748646575; cv=none; b=WR6SGTj/aeA0amT1OSNR0TjUCHBydUAbgDnzVb8kqeq+9vpgXmg8F3hmAlAY8HStK4bA8GcPc4QEnqS2xFvhuZMTlsr/OIlnFdBL0T64hrApJ4wIttCL20t13EE6a8JC+dLVlPCFmabMytnfnLu2VXGyvKT35iEAeHpCQSWKjK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748646575; c=relaxed/simple;
	bh=LoyjE9kdzjoi6fevHiJCdYiahDxSoe9dp4RhP57cdSs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ipA7zbQHamwvjuZ6G1PQEhvJGuUd9bWZCB4FdfwC+2KtIb3c18vz0ACaJzbUK+KVGReqjeKP6NEvtsaZ7pVPyYNlo+Hcdr5udPQvBey5QmNf+cELENR/BnXwFiviohNY1eKoV7o+EbBIxt4MwRKCGdb0QMebH4HqfyFXw5Hjcfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GlNTLfW8; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1748646573; x=1780182573;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=LoyjE9kdzjoi6fevHiJCdYiahDxSoe9dp4RhP57cdSs=;
  b=GlNTLfW8ubkwkGspOoogMz5HL3tpDkJvwprQqx467Vg4w68Cq4u5XvCg
   Onh2B9TFfjeRtPWhrmuWsYpvNSVqOKYII8iboixyKnQyhifgj3qoZf0In
   0mGhDxoLerD767vReRM8OTdpNEhKWz6L4oQ/YomcHv5LozA9nBI3n1Kpm
   SDZveGx9+woLagF4lDQOpP5NY2/9JajG+SA5oaY89EFwESV5YKMC4lxV1
   bKon5dGwvHc2CQ3hI8R1/yR7zIXeaHlEsHNNh0y3JOeEcVCIzWDKmNLd6
   IExH3k9GmqCFjBupeQ9inW19N/mHKEHK0OkHCLbnO/DGU7PiMnw5zK97M
   g==;
X-CSE-ConnectionGUID: gxiRDxEoRmmDfidzFrcZXA==
X-CSE-MsgGUID: Q4Wf3ucvQCeZc18X8ff4Dw==
X-IronPort-AV: E=McAfee;i="6700,10204,11449"; a="50618276"
X-IronPort-AV: E=Sophos;i="6.16,197,1744095600"; 
   d="scan'208";a="50618276"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 May 2025 16:09:33 -0700
X-CSE-ConnectionGUID: OK7YvfbETYid7DukXd+cRg==
X-CSE-MsgGUID: HAogEd4dS2+ky+skW9xPcg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,197,1744095600"; 
   d="scan'208";a="147885592"
Received: from agluck-desk3.sc.intel.com (HELO agluck-desk3) ([172.25.103.51])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 May 2025 16:09:33 -0700
Date: Fri, 30 May 2025 16:09:31 -0700
From: "Luck, Tony" <tony.luck@intel.com>
To: Borislav Petkov <bp@alien8.de>
Cc: Zaid Alali <zaidal@os.amperecomputing.com>, rafael@kernel.org,
	lenb@kernel.org, james.morse@arm.com, robert.moore@intel.com,
	Jonathan.Cameron@huawei.com, ira.weiny@intel.com,
	Benjamin.Cheatham@amd.com, dan.j.williams@intel.com, arnd@arndb.de,
	Avadhut.Naik@amd.com, john.allen@amd.com,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
	acpica-devel@lists.linux.dev
Subject: Re: [PATCH v7 9/9] ACPI: APEI: EINJ: Update the documentation for
 EINJv2 support
Message-ID: <aDo6q74ADqfUXjO3@agluck-desk3>
References: <20250506213814.2365788-1-zaidal@os.amperecomputing.com>
 <20250506213814.2365788-10-zaidal@os.amperecomputing.com>
 <20250530102711.GAaDmH_1O7lc6kuveY@fat_crate.local>
 <aDoal24J-BMTIBCq@agluck-desk3>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aDoal24J-BMTIBCq@agluck-desk3>

On Fri, May 30, 2025 at 01:52:41PM -0700, Luck, Tony wrote:
> On Fri, May 30, 2025 at 12:27:11PM +0200, Borislav Petkov wrote:
> > On Tue, May 06, 2025 at 02:38:13PM -0700, Zaid Alali wrote:
> There isn't a fancy "debugfs_create_x128_le()" helper to manage these
> 128-bit little endian numbers. So I've coded with the basic building
> blocks (though using copy_from_user() and copy_to_user() feels like
> back in the stone age). If there some helpers that I missed I'd be
> happy to see that part simplified.

simple_read_from_buffer() and simple_write_to_buffer() may be the
helpers that I didn't spot earlier.

-Tony

