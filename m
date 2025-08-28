Return-Path: <linux-acpi+bounces-16129-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 97CE8B392CA
	for <lists+linux-acpi@lfdr.de>; Thu, 28 Aug 2025 07:12:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C3B836739D
	for <lists+linux-acpi@lfdr.de>; Thu, 28 Aug 2025 05:12:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 898E125A633;
	Thu, 28 Aug 2025 05:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DnX+4w1R"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F26D7AD4B;
	Thu, 28 Aug 2025 05:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756357928; cv=none; b=rVraKEIqPKHlO5GyIya/+sKw/PokveQ+FB/F0iY1fSquNf4mw5k6R9Xf0H147auE2gnQNNrqB++guARvEmbR39Ei8vytnjno4Sk3802I4uUM5fS3hvokkaEz8ZhX/l23/UYZa/tkthanulx6JZ1jDrw4VDhKLm5P6vEtyieIViI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756357928; c=relaxed/simple;
	bh=NDimriK083IDEh4OZI4yZL9rze1oWDctlICit+4ShoQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hNqooR++Ku4qcxjKMWFpT4FxTrarZB56Z1Nrt1KJNyJfBeyH370qzcLO9YOAD7xlN3d71Bp5JPlE9S2eWT/Y82/c/UdqeB9q/q3ihEZc0UI9rCqfCSyOTtsJDijqct/lHQaZFATbmN4x9Er4zkgQTF3nsEiDQzfz55+azi4jM9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DnX+4w1R; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756357927; x=1787893927;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=NDimriK083IDEh4OZI4yZL9rze1oWDctlICit+4ShoQ=;
  b=DnX+4w1RimC8PzJA7tnIi3osPRp1JMQBgfcoTerrHoTzOKt6/1k5zP0S
   76XU3yD78r6Xv1tO2oApdiPLJk6ZVOzugAVG/LIEN9hpg7IsINA+b6Zwv
   l5A8jpIEdws9WifjZCrOvSOCuAoVZk/03voNwFYDsPqEG0anUEgbD/EDo
   MUWR3eRzDmGDruZCwe5kZeyH87WxyuKXTnHDRncU6k+0qNhxDBSgXKA3C
   NSujMzNF+4q9KdazOgSMlRhYS8K797IEgdmy1QEIJ2mfHMkrJlDPPv/sk
   1xTb5lt7+xPt69jxmG7Oks6pyf5CM/WNurbiViZ7xGyOHthXfDKn1B9wp
   A==;
X-CSE-ConnectionGUID: hgtJ5CnUQHaF6R2h33Jq5A==
X-CSE-MsgGUID: ZEOtQ5hxR+GrT0eik0+b4g==
X-IronPort-AV: E=McAfee;i="6800,10657,11535"; a="69326693"
X-IronPort-AV: E=Sophos;i="6.18,217,1751266800"; 
   d="scan'208";a="69326693"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2025 22:12:06 -0700
X-CSE-ConnectionGUID: 4JCAKCIWQJq1dM2q4Vdc5A==
X-CSE-MsgGUID: 2no36DNOSYS3O2bt9QKq+w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,217,1751266800"; 
   d="scan'208";a="169314361"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa010.jf.intel.com with ESMTP; 27 Aug 2025 22:12:05 -0700
Received: by black.igk.intel.com (Postfix, from userid 1001)
	id 9EAE594; Thu, 28 Aug 2025 07:12:03 +0200 (CEST)
Date: Thu, 28 Aug 2025 07:12:03 +0200
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Daniel Tang <danielzgtg.opensource@gmail.com>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: Re: [PATCH] acpi: TAD: Add missing sysfs_remove_group for ACPI_TAD_RT
Message-ID: <20250828051203.GU476609@black.igk.intel.com>
References: <7674021.TlGXAFRqVo@daniel-desktop3>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <7674021.TlGXAFRqVo@daniel-desktop3>

On Wed, Aug 27, 2025 at 06:51:41PM -0400, Daniel Tang wrote:
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
> Fixes: 3230b2b3c1ab5a0d3f99d5850bfdc4bf48d11cdd ("ACPI: TAD: Add low-level support for real time capability")

You should shorten this hash to 12 or so chars. Otherwise looks good.

> Signed-off-by: Daniel Tang <danielzgtg.opensource@gmail.com>
> ---
>  drivers/acpi/acpi_tad.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/acpi/acpi_tad.c b/drivers/acpi/acpi_tad.c
> index 91d7d90c47da..33418dd6768a 100644
> --- a/drivers/acpi/acpi_tad.c
> +++ b/drivers/acpi/acpi_tad.c
> @@ -565,6 +565,9 @@ static void acpi_tad_remove(struct platform_device *pdev)
>  
>  	pm_runtime_get_sync(dev);
>  
> +	if (dd->capabilities & ACPI_TAD_RT)
> +		sysfs_remove_group(&dev->kobj, &acpi_tad_time_attr_group);
> +
>  	if (dd->capabilities & ACPI_TAD_DC_WAKE)
>  		sysfs_remove_group(&dev->kobj, &acpi_tad_dc_attr_group);
>  
> -- 
> 2.48.1
> 

