Return-Path: <linux-acpi+bounces-14146-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 61AC6ACE743
	for <lists+linux-acpi@lfdr.de>; Thu,  5 Jun 2025 01:44:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E714E3A9ACF
	for <lists+linux-acpi@lfdr.de>; Wed,  4 Jun 2025 23:44:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F6D42741A0;
	Wed,  4 Jun 2025 23:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fc99E2FI"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E98A6F073;
	Wed,  4 Jun 2025 23:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749080669; cv=none; b=K0lnBvqdVcU9JsyVzUSMbol65aQKg/ocvczg/X9k7X9iC1+n5bPbYMg5lLwu1LuaepKQ3V8mmHjxyFM0cOcvC9YGV2iqwZnck1Rin/7v2bJprqSYuCg5mBbzV8Ej1Pw76qViNW6Q2FUa3YwhPv+jZApeQ0/zo1M3oBpleJwPz1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749080669; c=relaxed/simple;
	bh=rwcuOfT1CA5poAxzq1khNwu+dKvGPkT+ivPyW0kINuA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CqThr9SZHyFwBvoHYGweC2MYedH57X3vSq5hgoZzOmZRu1L02CvYalnfmStgnIb97+FMCanju8B9pcArzvhFFkc/TX8mZioziocCOt5rCWMQP0NwdaBZt1r7ec/B2JrlyNrgBj3874bGlXjDXWKsiisE3lVIshsAosMHmqQ5YoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fc99E2FI; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749080667; x=1780616667;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=rwcuOfT1CA5poAxzq1khNwu+dKvGPkT+ivPyW0kINuA=;
  b=fc99E2FI2G9dizWLNTeJehK1xMxCiifDrjLEyOEEeG7/EgdzQjdLXLoj
   JzEGypmuVUE8lvhd6Ol2iNd5piC/v4OkA5hw8iuWQVGTyCaBpR1Nz4lMt
   gHwgdoON+RsgvZjLr6wRZtnL84YP3ZDTjDDzHkdSlo9H0034Swsqb0Kzr
   Ka/bpb0HrrGUQuD+sQ26bQAELE69GG3WKnwAH14lfFmM1b4dNequfjDOa
   9f7sfQSEZQ920L02ORvoc2doOZRewMXqHYOet6JJkUXRnRn0czqLGFoI3
   AT1Y7rGMBpifvJjrxBLfpSI/FR0LksPUIS3eV4tXIwTeTDjXKQRbfYbzr
   g==;
X-CSE-ConnectionGUID: D2R8QreUTcCkRUAwvSszKQ==
X-CSE-MsgGUID: dpwj04yQRTa5s4p4d5VVNA==
X-IronPort-AV: E=McAfee;i="6800,10657,11454"; a="54975317"
X-IronPort-AV: E=Sophos;i="6.16,210,1744095600"; 
   d="scan'208";a="54975317"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2025 16:44:26 -0700
X-CSE-ConnectionGUID: WJXhXchUQsmFazAPsiwa5g==
X-CSE-MsgGUID: OB62SZJpSyG16SNyMguRFw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,210,1744095600"; 
   d="scan'208";a="146274344"
Received: from agluck-desk3.sc.intel.com (HELO agluck-desk3) ([172.25.103.51])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2025 16:44:26 -0700
Date: Wed, 4 Jun 2025 16:44:25 -0700
From: "Luck, Tony" <tony.luck@intel.com>
To: Zaid Alali <zaidal@os.amperecomputing.com>
Cc: rafael@kernel.org, lenb@kernel.org, james.morse@arm.com, bp@alien8.de,
	kees@kernel.org, gustavoars@kernel.org, Jonathan.Cameron@huawei.com,
	sudeep.holla@arm.com, u.kleine-koenig@baylibre.com,
	jonathanh@nvidia.com, viro@zeniv.linux.org.uk, ira.weiny@intel.com,
	peterz@infradead.org, sthanneeru.opensrc@micron.com,
	gregkh@linuxfoundation.org, Benjamin.Cheatham@amd.com,
	dave.jiang@intel.com, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v8 0/7] Enable EINJv2 Support
Message-ID: <aEDaWWHKrM5hUt9M@agluck-desk3>
References: <20250604223804.842501-1-zaidal@os.amperecomputing.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250604223804.842501-1-zaidal@os.amperecomputing.com>

On Wed, Jun 04, 2025 at 03:37:57PM -0700, Zaid Alali wrote:
> The goal of this update is to allow the driver to simultaneously
> support EINJ and EINJv2. The implementation follows ACPI 6.6
> specs[1] that enables the driver to discover system capabilities
> through GET_ERROR_TYPE.
> 
> Link: https://uefi.org/specs/ACPI/6.6/18_Platform_Error_Interfaces.html#error-injection [1]
> 
> V8:
> 	*Update UI to use single value files for component array.
> 	*Update links to point to recent ACPI 6.6 spec release.
> 	*Updated commit messages and documentation patch.
> 	*Dropped the first two patches as they were merged via
> 	 ACPICA project.

Some of the Signed-off-by tags in this series are wrong. Partially
my fault for an offline exchange of patches with Zaid to get this
series cleaned up.

1	Could have a Reviewed-by: Tony Luck instead of Signed-off
2	Could have a Reviewed-by: Tony Luck instead of Signed-off
3	Could have a Reviewed-by: Tony Luck instead of Signed-off
4	I rewrote the commit message, could have a Reviewed-by: Tony Luck instead of Signed-off
5	My patch, but Zaid forwarded it, so it should have his Signed-off after mine
6	Zaid's Signed-off should be after my Sign/Co-developed
7	Zaid's Signed-off should be after my Sign/Co-developed

Apart from that, all seems good in this version.

-Tony

