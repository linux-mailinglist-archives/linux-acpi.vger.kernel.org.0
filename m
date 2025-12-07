Return-Path: <linux-acpi+bounces-19482-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E71BACABA7C
	for <lists+linux-acpi@lfdr.de>; Sun, 07 Dec 2025 23:38:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BE7903004C9F
	for <lists+linux-acpi@lfdr.de>; Sun,  7 Dec 2025 22:38:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EFB52EA473;
	Sun,  7 Dec 2025 22:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Fi1n0XF/"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CD9428B4FD;
	Sun,  7 Dec 2025 22:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765147108; cv=none; b=Dp7U80tuvRpTZsJOKLSIdh9IXjUprI0nhJ3Xbxcj8Au6SPUg5MQEO79pumg1BSHSsEchTv+Ik9cAMNU3e3tD8vpj1xadfYBHRO4dS5HxN/Amh6Cbnf+R87/ns6X4zEWAiEKQNH864hGq92g6EF8QuNyNch6TskmjL1O/WEZ/nv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765147108; c=relaxed/simple;
	bh=+ngbxpws5VsZ1WIpGjbQ722b/b9gYa1bOnWOBbWkhaM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PaT8WTj3WYAsJuzKEi9skKogql6tLKHWnaGuh7wnleVlXWfIn5p3GGYV9T7wcslFamHcIQGr/xzj/Nx8JGMPSrljewfT1Ex8WdX/FYaoxohjJf+4F5kp58yXBCTVNJOI9lneJ+gVZFKGFDXLT2ZLZ0Y7yce3LcT6FXt12pPsMK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Fi1n0XF/; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1765147107; x=1796683107;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=+ngbxpws5VsZ1WIpGjbQ722b/b9gYa1bOnWOBbWkhaM=;
  b=Fi1n0XF/+jNmMXNo6gU9mFCnDI5FoaDar8HNjM9jmATcI/6MFnr3ZLWx
   7o9v/wFp0/14V4vLQJx9KYg7CnqYDeH0mPBuRkRjKxraBgGx2EUHpsBmN
   POScXapkr2DM2ku+TwDHsjMDkVsJilzMRcFB0AEAv9Rn7el6U1hpPg9FD
   8MajYRVB9xU9BP1HiDDaZzCkhW1SXdWQDCZyCcgo7iyQhJ3f6H4ymob5L
   XbqEweG25cTYCc7YUN5gRDqEe8IVa5mEO8Xa5JLot6UWN4E341s7Eiuhg
   u9lzrNqCgd4b0RmADAC1SAI6+GwLpz0/FCWk3QCoYAkfKRx5OUqkzR8l9
   g==;
X-CSE-ConnectionGUID: Sv1JRMPlT5iFWYyHGpkVLQ==
X-CSE-MsgGUID: eCAHTlXbSXO+FdEKH2e54g==
X-IronPort-AV: E=McAfee;i="6800,10657,11635"; a="77779053"
X-IronPort-AV: E=Sophos;i="6.20,257,1758610800"; 
   d="scan'208";a="77779053"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2025 14:38:26 -0800
X-CSE-ConnectionGUID: EnEi7W0hQr6STAGcy6h8Sw==
X-CSE-MsgGUID: NWWprS3RSiedeG+RjWk2jg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,257,1758610800"; 
   d="scan'208";a="196550714"
Received: from abityuts-desk.ger.corp.intel.com (HELO localhost) ([10.245.244.218])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2025 14:38:23 -0800
Date: Mon, 8 Dec 2025 00:38:21 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Bartosz Golaszewski <brgl@kernel.org>
Cc: Askar Safin <safinaskar@gmail.com>,
	Mika Westerberg <westeri@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org, regressions@lists.linux.dev,
	Dell.Client.Kernel@dell.com, Mario Limonciello <superm1@kernel.org>,
	patches@lists.linux.dev, stable@vger.kernel.org
Subject: Re: [PATCH v2 1/1] gpiolib: acpi: Add quirk for Dell Precision 7780
Message-ID: <aTYB3aIfzR3tHxu6@smile.fi.intel.com>
References: <20251206180414.3183334-1-safinaskar@gmail.com>
 <20251206180414.3183334-2-safinaskar@gmail.com>
 <aTSlgoK0PcE937l1@smile.fi.intel.com>
 <CAMRc=Mca8oi7JpEiNajP+CbHhBhSb9fS4NqFz-aojcX1qmEzcA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMRc=Mca8oi7JpEiNajP+CbHhBhSb9fS4NqFz-aojcX1qmEzcA@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sun, Dec 07, 2025 at 08:12:13AM +0100, Bartosz Golaszewski wrote:
> On Sat, Dec 6, 2025 at 10:52 PM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> >
> > On Sat, Dec 06, 2025 at 06:04:13PM +0000, Askar Safin wrote:
> > > Dell Precision 7780 often wakes up on its own from suspend. Sometimes
> > > wake up happens immediately (i. e. within 7 seconds), sometimes it happens
> > > after, say, 30 minutes.
> >
> > Bart, up to you, if you want to take this. But I can do with a usual route via
> > my tree.
> 
> I already have a bunch of fixes queued for next week so I guess it'll
> be less hassle and the fastest option if I take it.

Cool, thanks!

-- 
With Best Regards,
Andy Shevchenko



