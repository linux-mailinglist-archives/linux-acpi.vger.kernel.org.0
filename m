Return-Path: <linux-acpi+bounces-16131-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BAE8B3968C
	for <lists+linux-acpi@lfdr.de>; Thu, 28 Aug 2025 10:14:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 44CD11C2626E
	for <lists+linux-acpi@lfdr.de>; Thu, 28 Aug 2025 08:14:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C441B2D7DED;
	Thu, 28 Aug 2025 08:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="l/oj5KD7"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3B0BEEBB;
	Thu, 28 Aug 2025 08:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756368830; cv=none; b=P6h+yIskyWyokseRK+16isREtDiRsXyWefQlxAWkXJc7c4zlk6dVqV3lzkJrHaHIyO2rw+DPhtQwqTih//i4zzd+kNUPhG2PgxHJRjH+iA3WK94mixMOtr+kUyhdVV9knNGwzD4tho2yowtRREkFgB/oxG7EF97GtgxoI2ykSCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756368830; c=relaxed/simple;
	bh=0ec3aHc9rTQHwxagpGPLyfaYrEpAbfy9iYUSC/Xfnt8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cCJXxYn/e0xmZqRVtA+BorNtmZsadfA2cHQ/KuGbF0qfAxTX3g9blnDXDgx5vuRbtonfAndPUZeyepKgI1hHdBj5es6H/Jt/3R9SaHg4OrpznCYf+j+gsdjItEq0DZR5lNSADEfegXF79kJ23jI/AtP//szywf4RdBD6d4nT3aU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=l/oj5KD7; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756368829; x=1787904829;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=0ec3aHc9rTQHwxagpGPLyfaYrEpAbfy9iYUSC/Xfnt8=;
  b=l/oj5KD7g5UFinr3wbJnHpV/+iS3wuUUVnMWHl3qCUFY/Z6KMwXiGuqu
   iIRk/BkQUyZyU+psZ1ka62ndPZgu6Vm++El/aWOHGpEjNwtqfSo6hnAIT
   Ihi1dniE9c9TZxrxcfZpXPTzv5InTGDyKMVgOIO0X6ZUwDWMh7icoItCH
   +FiybSDHkZYS4imFzp1rZm74R0IDzrxUQtah46fipmkPlWhK5kJ4I87kR
   syIO5XGccgBUb7KTGmn/FsSOGUroOUq/m8ayzoDpKRLshsUMBaX2cCEfL
   aOyCpUtxOaiqMhQMiW7N+ZZIkGksvS3WvxzGUVgD2/0TiFl3WEkLNpx/+
   w==;
X-CSE-ConnectionGUID: kakF3BcyQW+fZCDIXn7rqA==
X-CSE-MsgGUID: wTZQ1/qZQqechapROMxoTQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="58572826"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="58572826"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2025 01:13:48 -0700
X-CSE-ConnectionGUID: 8SrWHMtZT7aMaJCdAOfRng==
X-CSE-MsgGUID: C+8UEnoeRVqsgr8OOcL9fg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,217,1751266800"; 
   d="scan'208";a="169573392"
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa007.fm.intel.com with ESMTP; 28 Aug 2025 01:13:46 -0700
Received: by black.igk.intel.com (Postfix, from userid 1001)
	id 0879094; Thu, 28 Aug 2025 10:13:45 +0200 (CEST)
Date: Thu, 28 Aug 2025 10:13:45 +0200
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Daniel Tang <danielzgtg.opensource@gmail.com>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: Re: [PATCH v2] acpi: TAD: Add missing sysfs_remove_group for
 ACPI_TAD_RT
Message-ID: <20250828081345.GV476609@black.igk.intel.com>
References: <7674021.TlGXAFRqVo@daniel-desktop3>
 <20250828051203.GU476609@black.igk.intel.com>
 <2881298.hMirdbgypa@daniel-desktop3>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2881298.hMirdbgypa@daniel-desktop3>

On Thu, Aug 28, 2025 at 01:38:14AM -0400, Daniel Tang wrote:
> Previously, after `rmmod acpi_tad`, `modprobe acpi_tad` would fail
> with this dmesg:
> 
> sysfs: cannot create duplicate filename '/devices/platform/ACPI000E:00/time'
> Call Trace:
>  <TASK>
>  dump_stack_lvl+0x6c/0x90
>  dump_stack+0x10/0x20
>  sysfs_warn_dup+0x8b/0xa0
>  sysfs_add_file_mode_ns+0x122/0x130
>  internal_create_group+0x1dd/0x4c0
>  sysfs_create_group+0x13/0x20
>  acpi_tad_probe+0x147/0x1f0 [acpi_tad]
>  platform_probe+0x42/0xb0
>  </TASK>
> acpi-tad ACPI000E:00: probe with driver acpi-tad failed with error -17
> 
> Fixes: 3230b2b3c1ab ("ACPI: TAD: Add low-level support for real time capability")
> Signed-off-by: Daniel Tang <danielzgtg.opensource@gmail.com>

Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>

