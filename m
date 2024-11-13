Return-Path: <linux-acpi+bounces-9530-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 914759C683D
	for <lists+linux-acpi@lfdr.de>; Wed, 13 Nov 2024 05:51:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 308EC28532E
	for <lists+linux-acpi@lfdr.de>; Wed, 13 Nov 2024 04:51:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8502716D9AA;
	Wed, 13 Nov 2024 04:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="my525b8f"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69FDC1531C8;
	Wed, 13 Nov 2024 04:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731473507; cv=none; b=A75QpPiaPeSbU+l718R3NjQR3GRMTAaiccyvd4l0P1QIzz20ub0kl7NPzXIfuajQVQStRq2o4AQiSYQR7nCOFfH4fdMALDFj10jERoNBc49GXtG2YcUcODmNUBSw705pOCeqa1iLYu8hhWW9y4uNrDIpMAzFzHLYmo2ndV/HTRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731473507; c=relaxed/simple;
	bh=/1pRHDRrAZ9iIpgY02t018pfdsaFQcMvD4hdZMbo7HU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ksB7lCMg/40/kdcpWxgCADvc5bnEdNldIaExL00usu6sTWPb0FkDBKCiEpizjGLo1/bLrcvFKkSHpxmOqgoktC/pEe57wYil2+YNJsVeGqHjhIK8wwFVbcBSObp6isj9SbEHBoe0xzTRdg9xtBzqAKblI4wJwVB4FRba4oT217o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=my525b8f; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731473504; x=1763009504;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=/1pRHDRrAZ9iIpgY02t018pfdsaFQcMvD4hdZMbo7HU=;
  b=my525b8fTuK9mWUDIApCLvb5ceZTRv3cWfnCIkIw00FyatQAJPTBXnH9
   CjudvjkhcYM2K0uhZ0w1B+lgLI6tKovhd14X6jCEdNdR/tTP6be3cqT74
   vaomgmE7o7tOUMgh92qOwpTkJH3UDEmbjW/ceqeSba43e07hT6aXG57A6
   b6W1YvZJ1bdPEinKl7ffPvWM6hnf6r70gGc/K5UKGiv0msT4H0m7vFZ84
   +rCfGQvlLRR00P0RUcR0vIlPn1qu2O48e5x6bC6FR8t083KKzKONTIMfV
   KVlUYqXvDFlQ+ClEtL0eUTrAaGMoLtBMwYa56mvPiaKHK9IvwcMiS5eLA
   g==;
X-CSE-ConnectionGUID: NDFbj/vuTh66TdvzTxGAIg==
X-CSE-MsgGUID: Da7KH1rKTsaiMoYTCAXmKA==
X-IronPort-AV: E=McAfee;i="6700,10204,11254"; a="30746307"
X-IronPort-AV: E=Sophos;i="6.12,150,1728975600"; 
   d="scan'208";a="30746307"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2024 20:51:43 -0800
X-CSE-ConnectionGUID: XRPXDymmT0C0dzE/kkXdkA==
X-CSE-MsgGUID: hvvj7OAnTYm4tn+HILU6Lw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,150,1728975600"; 
   d="scan'208";a="92518723"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO aschofie-mobl2.lan) ([10.125.111.153])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2024 20:51:43 -0800
Date: Tue, 12 Nov 2024 20:51:41 -0800
From: Alison Schofield <alison.schofield@intel.com>
To: Suraj Sonawane <surajsonawane0215@gmail.com>
Cc: dan.j.williams@intel.com, vishal.l.verma@intel.com,
	dave.jiang@intel.com, ira.weiny@intel.com, rafael@kernel.org,
	lenb@kernel.org, nvdimm@lists.linux.dev, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzbot+7534f060ebda6b8b51b3@syzkaller.appspotmail.com
Subject: Re: [PATCH v2] acpi: nfit: vmalloc-out-of-bounds Read in
 acpi_nfit_ctl
Message-ID: <ZzQwXXSwioLsG8vv@aschofie-mobl2.lan>
References: <20241112052035.14122-1-surajsonawane0215@gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241112052035.14122-1-surajsonawane0215@gmail.com>

On Tue, Nov 12, 2024 at 10:50:35AM +0530, Suraj Sonawane wrote:
> Fix an issue detected by syzbot with KASAN:
> 
> BUG: KASAN: vmalloc-out-of-bounds in cmd_to_func drivers/acpi/nfit/
> core.c:416 [inline]
> BUG: KASAN: vmalloc-out-of-bounds in acpi_nfit_ctl+0x20e8/0x24a0
> drivers/acpi/nfit/core.c:459
> 
> The issue occurs in `cmd_to_func` when the `call_pkg->nd_reserved2`
> array is accessed without verifying that `call_pkg` points to a
> buffer that is sized appropriately as a `struct nd_cmd_pkg`. This
> could lead to out-of-bounds access and undefined behavior if the
> buffer does not have sufficient space.
> 
> To address this issue, a check was added in `acpi_nfit_ctl()` to
> ensure that `buf` is not `NULL` and `buf_len` is greater than or
> equal to `sizeof(struct nd_cmd_pkg)` before casting `buf` to
> `struct nd_cmd_pkg *`. This ensures safe access to the members of
> `call_pkg`, including the `nd_reserved2` array.
> 
> This change preventing out-of-bounds reads.
> 
> Reported-by: syzbot+7534f060ebda6b8b51b3@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=7534f060ebda6b8b51b3
> Tested-by: syzbot+7534f060ebda6b8b51b3@syzkaller.appspotmail.com
> Fixes: 2d5404caa8c7 ("Linux 6.12-rc7")
> Signed-off-by: Suraj Sonawane <surajsonawane0215@gmail.com>

Suraj,

The fixes tag needs to be where the issue originated, not
where you discovered it (which I'm guessing was using 6.12-rc7).

Here's how I find the tag:

$ git blame drivers/acpi/nfit/core.c | grep call_pkg | grep buf
ebe9f6f19d80d drivers/acpi/nfit/core.c (Dan Williams       2019-02-07 14:56:50 -0800  458) 		call_pkg = buf;

$ git log -1 --pretty=fixes ebe9f6f19d80d
Fixes: ebe9f6f19d80 ("acpi/nfit: Fix bus command validation")

I think ^ should be your Fixes tag. 



snip

> 

