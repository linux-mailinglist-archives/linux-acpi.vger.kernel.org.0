Return-Path: <linux-acpi+bounces-16227-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FFE3B3D979
	for <lists+linux-acpi@lfdr.de>; Mon,  1 Sep 2025 08:08:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2734F189A83D
	for <lists+linux-acpi@lfdr.de>; Mon,  1 Sep 2025 06:08:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADDF0212556;
	Mon,  1 Sep 2025 06:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iAAxsV4N"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0728D53363;
	Mon,  1 Sep 2025 06:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756706886; cv=none; b=exxux7CiGT2gVABDYAPJ5AbvhEkqEhfQ3w3czGnGDc2wKTLGuBnab939+efmqpmV1MnJLAxSXTJ9uJzzJmQd+j3mVRmw0Ip5rBxuTK4UMlnCohT21ZXKIh+WLS2B1hDvPMmxIMc/7e/rafD/UZT5dSmJWslPcqTWR7hTIlgbBDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756706886; c=relaxed/simple;
	bh=uEfigO7TZVKB6kWdETLllWt7Ig/hQdmbf1Idqr3Flk4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bknMG2t0GOcH3MkYuNO5HwXvfqfTdE+afm3/LuDV/lezb3srCOTyAzw6806p744Gc7uFMTq1597fz6Qhyitugp8IQML1e9BSCbyeylmkOtpnSzTG7HCnANA14Nxh1pha+OPN6ydKrFFoN8dErkiYwWakbGoEvRQoEzL+sHmm85c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iAAxsV4N; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756706885; x=1788242885;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=uEfigO7TZVKB6kWdETLllWt7Ig/hQdmbf1Idqr3Flk4=;
  b=iAAxsV4NFCJoZ1rq3DajnE0ckdl0BFrEtaiKe77kIA8Vrc7uIZT64m8l
   501w5Hd7OkXFcZtStFiQElef76PIiJUcNK6m0uNVslUcwSlju2SORDCEG
   Dy2xYNS1g8SfpK0BlR8ywV5IJg9VxiROvvctmtc/7nwUJY/Hc+aTzBC7M
   P1BXRCwxXDFkm7PyPsm1SkJqhJpYU50Hr1BSpuXn+QmW09p1CmWpMV3f3
   soSIgjNPs9ppRssUO73943wsDmhJCmNgCYqI1ncpaeyaPm4dsgbXfAOJz
   h3WR/OcKjTkCXwmXY1eeTL4fHoRtq1DyK+SzVjW9hAq3Z8acAvTsyvXSb
   g==;
X-CSE-ConnectionGUID: mf7W8SemSX+NJPAsgDQV+Q==
X-CSE-MsgGUID: n9wzFv87SIeVuslC5p+t/g==
X-IronPort-AV: E=McAfee;i="6800,10657,11539"; a="69492683"
X-IronPort-AV: E=Sophos;i="6.18,225,1751266800"; 
   d="scan'208";a="69492683"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2025 23:08:04 -0700
X-CSE-ConnectionGUID: 7FmlVyPVSJuUGDrrXlPQFQ==
X-CSE-MsgGUID: xzC92j0cQf2ONOc5jJLl7g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,225,1751266800"; 
   d="scan'208";a="201806493"
Received: from smile.fi.intel.com ([10.237.72.52])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2025 23:08:02 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1usxhv-0000000AGvH-1aKA;
	Mon, 01 Sep 2025 09:07:59 +0300
Date: Mon, 1 Sep 2025 09:07:59 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org, Mika Westerberg <westeri@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Antheas Kapenekakis <lkml@antheas.dev>
Subject: Re: [PATCH v1] gpiolib: acpi: Ignore touchpad wakeup on GPD G1619-05
Message-ID: <aLU4P48kU3f9yK8o@smile.fi.intel.com>
References: <20250827175842.3697418-1-lkml@antheas.dev>
 <CAMRc=MdQY4mmfAPA2SorkjCdjpx7DSwF5rRUvnRPb9G1o5aaLw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMRc=MdQY4mmfAPA2SorkjCdjpx7DSwF5rRUvnRPb9G1o5aaLw@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sat, Aug 30, 2025 at 09:51:19PM +0200, Bartosz Golaszewski wrote:
> On Wed, Aug 27, 2025 at 8:00 PM Antheas Kapenekakis <lkml@antheas.dev> wrote:
> >
> > Same issue as G1619-04 in commit 805c74eac8cb ("gpiolib: acpi: Ignore
> > touchpad wakeup on GPD G1619-04"), Strix Point lineup uses 05.
> >
> > Signed-off-by: Antheas Kapenekakis <lkml@antheas.dev>
> > ---
> 
> Andy, should I take it directly through the GPIO tree?

Nope, I have already something, I will take it, thanks!

-- 
With Best Regards,
Andy Shevchenko



