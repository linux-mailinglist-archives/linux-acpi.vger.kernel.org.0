Return-Path: <linux-acpi+bounces-930-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65FCE7D58FC
	for <lists+linux-acpi@lfdr.de>; Tue, 24 Oct 2023 18:43:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 93546B20F97
	for <lists+linux-acpi@lfdr.de>; Tue, 24 Oct 2023 16:43:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 032293AC19
	for <lists+linux-acpi@lfdr.de>; Tue, 24 Oct 2023 16:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cRyadCB2"
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7420237164;
	Tue, 24 Oct 2023 15:27:48 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9CEB1703;
	Tue, 24 Oct 2023 08:27:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698161267; x=1729697267;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=QFA2DdN62232OLAj/aEsT34+urZDgALMxgXqOKHV1s0=;
  b=cRyadCB2+L3BzeZ1iEy/80ZlB/UiecLmryAiLohfbzlO1QmQuDKNQbww
   jyfuhMkdCEVDd4IjqEMMlAhSHszPtVa5PtjbpfhO+7glxkIMug41CQ24Q
   oAmSr9IpAR49Ngw7Fx99WoJqG0Q6tu/yhGgluhBHhU/bBt/A5J7bscWnL
   4WS2RNFC8Eo7HVurbuJW7adgmpMhlEv4GReeZTnhWC89sOy0QLU8ftSS/
   RzsrlQe3CKNotq17bpAQB6CM9xhIyqCz+jYVSH0E44+YSZ6Pc+Sl3A1If
   Ag5HTL9YLxi4WlQlJJ+ZGT+2ghI4RVEpD1q2y/Nh03Nk/+qbOL6ZOx9V5
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10873"; a="451317466"
X-IronPort-AV: E=Sophos;i="6.03,248,1694761200"; 
   d="scan'208";a="451317466"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2023 08:24:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10873"; a="762127871"
X-IronPort-AV: E=Sophos;i="6.03,248,1694761200"; 
   d="scan'208";a="762127871"
Received: from agluck-desk3.sc.intel.com (HELO agluck-desk3) ([172.25.222.74])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2023 08:24:22 -0700
Date: Tue, 24 Oct 2023 08:24:21 -0700
From: Tony Luck <tony.luck@intel.com>
To: Jeshua Smith <jeshuas@nvidia.com>
Cc: keescook@chromium.org, gpiccoli@igalia.com, rafael@kernel.org,
	lenb@kernel.org, james.morse@arm.com, bp@alien8.de,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org, linux-tegra@vger.kernel.org,
	treding@nvidia.com, jonathanh@nvidia.com
Subject: Re: [PATCH V2] ACPI: APEI: Use ERST timeout for slow devices
Message-ID: <ZTfhpRRA4bga0qSI@agluck-desk3>
References: <20230712223448.145079-1-jeshuas@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230712223448.145079-1-jeshuas@nvidia.com>

On Wed, Jul 12, 2023 at 10:34:48PM +0000, Jeshua Smith wrote:
> Slow devices such as flash may not meet the default 1ms timeout value,
> so use the ERST max execution time value that they provide as the
> timeout if it is larger.
> 
> Signed-off-by: Jeshua Smith <jeshuas@nvidia.com>

> +/* ERST Exec max timings */
> +#define ERST_EXEC_TIMING_MAX_MASK      0xFFFFFFFF00000000
> +#define ERST_EXEC_TIMING_MAX_SHIFT     32

I've recently become a fan of <linux/bitfield.h> I think this would
be easier on the eyes as:

#define ERST_EXEC_TIMING_MAX	GENMASK_ULL(63, 32)

> +static inline u64 erst_get_timeout(void)
> +{
> +	u64 timeout = FIRMWARE_TIMEOUT;
> +
> +	if (erst_erange.attr & ERST_RANGE_SLOW) {
> +		timeout = ((erst_erange.timings & ERST_EXEC_TIMING_MAX_MASK) >>
> +			ERST_EXEC_TIMING_MAX_SHIFT) * NSEC_PER_MSEC;

then this becomes:

		timeout = FIELD_GET(ERST_EXEC_TIMING_MAX, erst_erange.timings) *
			  NSEC_PER_MSEC;

> +		if (timeout < FIRMWARE_TIMEOUT)
> +			timeout = FIRMWARE_TIMEOUT;

But that's just a matter of style.  Otherwise the patch looks fine.

Reviewed-by: Tony Luck <tony.luck@intel.com>

-Tony

