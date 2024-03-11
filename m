Return-Path: <linux-acpi+bounces-4245-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A2E6B877E29
	for <lists+linux-acpi@lfdr.de>; Mon, 11 Mar 2024 11:35:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DE4AFB21AEC
	for <lists+linux-acpi@lfdr.de>; Mon, 11 Mar 2024 10:35:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE5CD383B5;
	Mon, 11 Mar 2024 10:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="E4KKoKOU"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2109538DF1
	for <linux-acpi@vger.kernel.org>; Mon, 11 Mar 2024 10:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710153299; cv=none; b=QrlV2v2v+IS0ss9Sqguosg6mO8X+U4wa1a0T8jIaF0J3o6UEetCKJk8GuLs5Bxl83aY0VvFTvw3bZpF7kjjx21L6tdCYbNhLhnnaasVp2Gl8ZrD2U3aE7DOhrhCwvH3EYCIhFavQg3+psvu6PEZK6rGwkHqisNTPTg5Bsv3uCcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710153299; c=relaxed/simple;
	bh=JgoYuk+MFS8Av2MYDeQUOjEj4pGYFiYWNLKYecK25wo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=udG9bjJFFLE/lDKuh50MXd13LgmrYcZXzWgv55j/C+MfsoaiJTTZV8XOF2RdfnnYC2TAgr55RAk03GAXU0CTQhPfByP/JYoQXRwezbcdZ8vbnt4cq3TKUwGT4RHkm8IIQX+fFk+NKk2Ik37e08nVH96Ty6uPa4NzS3PxkIUT6Ck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=E4KKoKOU; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710153298; x=1741689298;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=JgoYuk+MFS8Av2MYDeQUOjEj4pGYFiYWNLKYecK25wo=;
  b=E4KKoKOUPsfescxbIM7I5Jrk4QlCUFEmS6L3eiQNsDgG6VW25RQyn7WV
   PESQ/uu5TCDGyDCBAiA+dw+inFFDE+VbUsPqLhJsC8D037Q4Jk1Ms4ra2
   Fys+w+MnGvpqzG5M0WeuPkI8PGxxf1KsPJKSUfCEbyzxMPIka5bglkZRl
   maEHSb5wJKqmnObY/T0KLB1DheBPoPaymsJ3pG7gQ/MmwKM/SSFjOsRli
   NrEfgCdsTreO0g6RrbSqZbSnbve62EzwA3K8Qty5zVDzpVNG2dikNNirt
   XE3UgXlid4eTKlLo/y3fLABriK19at9VwkxKJtD5E+Nvn6YwFJ9D0KczA
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11009"; a="7753006"
X-IronPort-AV: E=Sophos;i="6.07,116,1708416000"; 
   d="scan'208";a="7753006"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2024 03:34:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11009"; a="914355157"
X-IronPort-AV: E=Sophos;i="6.07,116,1708416000"; 
   d="scan'208";a="914355157"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2024 03:34:55 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rjczd-0000000BavB-1ElD;
	Mon, 11 Mar 2024 12:34:53 +0200
Date: Mon, 11 Mar 2024 12:34:52 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Cezary Rojewski <cezary.rojewski@intel.com>
Cc: rafael@kernel.org, linux-acpi@vger.kernel.org, robert.moore@intel.com,
	amadeuszx.slawinski@linux.intel.com,
	pierre-louis.bossart@linux.intel.com
Subject: Re: [PATCH v7 0/4] ACPI: NHLT: Access and query helpers
Message-ID: <Ze7eTF63Ig3lmY_3@smile.fi.intel.com>
References: <20240311101658.2343816-1-cezary.rojewski@intel.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240311101658.2343816-1-cezary.rojewski@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, Mar 11, 2024 at 11:16:54AM +0100, Cezary Rojewski wrote:
> The goal of this patchset is to refactor existing interface of
> Non HDAudio Link Table (NHLT) table so it becomes useful for the Intel
> AudioDSP sound-drivers. Right now the useful duplicate resides in
> sound/hda/intel-nhlt.c.
> 
> The API takes form of query functions that help access device or
> audio-format configuration space. This information can be then utilized
> by a sound-driver to perform necessary programming and facilitate
> streaming over I2S/PDM interfaces. Once the series is merged, existing
> sound-drivers can move from utilizing sound/hda/intel-nhlt.c to this
> very code and ultimately the former file can be removed.
> 
> Paired with equivalent change on ACPICA [1].
> 
> -
> 
> Non HDAudio Link Table (NHLT) is designed to separate hardware-related
> description (registers) from AudioDSP firmware-related one i.e.:
> pipelines and modules that together make up the audio stream on Intel
> DSPs. This task is important as same set of hardware registers can be
> used with different topologies and vice versa, same topology could be
> utilized with different set of hardware. As the hardware registers
> description is directly tied to specific platform, intention is to have
> such description part of low-level firmware e.g.: BIOS.
> 
> The initial design has been provided in early Sky Lake (SKL) days. The
> audio architecture goes by the name cAVS. SKL is a representative of
> cAVS 1.5. The table helps describe endpoint capabilities ever since.
> While Raptor Lake (RPL) is the last of cAVS architecture - cAVS 2.5 to
> be precise - its successor, the ACE architecture which begun with
> Meteor Lake (MTL) inherited the design for all I2S and PDM
> configurations. These two configurations are the primary targets for
> NHLT table.
> 
> Due to naming conflicts with existing code, several structs are named
> 'nhlt2' rather than 'nhlt'. Last patch cleans the situation up.

FWIW, I am fine with this version esp. taking into account the specification
and ACPICA work,

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

-- 
With Best Regards,
Andy Shevchenko



