Return-Path: <linux-acpi+bounces-16128-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE201B392C6
	for <lists+linux-acpi@lfdr.de>; Thu, 28 Aug 2025 07:10:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9EA19684D33
	for <lists+linux-acpi@lfdr.de>; Thu, 28 Aug 2025 05:10:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D1C1227E9B;
	Thu, 28 Aug 2025 05:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RmsSA2p3"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BFF4AD4B;
	Thu, 28 Aug 2025 05:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756357844; cv=none; b=TZ1dYbXyPKePU+dXIQBMTSZEyRDpb6EYQ/OYvigPCsVNDT1R8pAQkeE8JCyLvnu2n2Ga20puMagh1x9tsj+gXc6jlawfJcB76+b4isgwmoFwvtpiYJleRzysv58D7prnBRx6ceIPKFoBW0hkYIgUWwCpW8tYwa7HbH5WFMn2gXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756357844; c=relaxed/simple;
	bh=hYuzW/b5tw73H+pYWRUvLnELjNQzmmtpnxTVoViYqGY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gt1YKBKa7H9ulNYIPXD/b4FLKD5Xbw6tvE4XMqrykBbhv+Y7QnOIRQ6udHD6+NN71gAugG9VZGBV439P0W3dLe0rnE/k/xGwj5bUkHAY8+g4NRcw+nlUw5kOo4Mtu/nCUzVrYSb8VWGulOfHoPnY2Gx7pYucnd8Qnpo2qzd2VVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RmsSA2p3; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756357844; x=1787893844;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=hYuzW/b5tw73H+pYWRUvLnELjNQzmmtpnxTVoViYqGY=;
  b=RmsSA2p3Rd7MuTixHpO1/QKp6R9P7oEP/h54iykcjW0c/HE+eEFM18mR
   lDFB5k6tnSNiGfvxDtcldpifx1297V2v0faZKxX8MSG6lnJyevYWM+P8V
   oM91fDhcWh1cPs/7YqHYfHxpM/IwvBPRtgGvCK3/0jEGM/LnUTKiS2G+z
   oKCz00ZpPggqV7Crs5ZqkV57Daz7q/0E+IQdDPEoi7Oy65KEEfgxjWLoc
   3qWjRv9QB/cfuBkrJFyYlSd9aUGO6esTEzd1jgOs1Qvlmnc5mfkbKmbB7
   KMV486NggUvRl0li2BzjRJ0RyKPXd7WSwODRjdQV7p8AaLY69Pq06Ty4W
   g==;
X-CSE-ConnectionGUID: Fr5eodzbSte1mmyPXZDJEw==
X-CSE-MsgGUID: 5e1SkLOSQGmlw+PGLorVUA==
X-IronPort-AV: E=McAfee;i="6800,10657,11535"; a="69210915"
X-IronPort-AV: E=Sophos;i="6.18,217,1751266800"; 
   d="scan'208";a="69210915"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2025 22:10:42 -0700
X-CSE-ConnectionGUID: zWmwx2OuTp2zyrHSWeuh3Q==
X-CSE-MsgGUID: rk/YRmOgSfqMJ8bwB3HAhg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,217,1751266800"; 
   d="scan'208";a="169920528"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa007.jf.intel.com with ESMTP; 27 Aug 2025 22:10:40 -0700
Received: by black.igk.intel.com (Postfix, from userid 1001)
	id 2CF0194; Thu, 28 Aug 2025 07:10:38 +0200 (CEST)
Date: Thu, 28 Aug 2025 07:10:38 +0200
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Antheas Kapenekakis <lkml@antheas.dev>
Cc: linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org, Mika Westerberg <westeri@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Mario Limonciello <mario.limonciello@amd.com>
Subject: Re: [PATCH v1] gpiolib: acpi: Ignore touchpad wakeup on GPD G1619-05
Message-ID: <20250828051038.GT476609@black.igk.intel.com>
References: <20250827175842.3697418-1-lkml@antheas.dev>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250827175842.3697418-1-lkml@antheas.dev>

On Wed, Aug 27, 2025 at 07:58:42PM +0200, Antheas Kapenekakis wrote:
> Same issue as G1619-04 in commit 805c74eac8cb ("gpiolib: acpi: Ignore
> touchpad wakeup on GPD G1619-04"), Strix Point lineup uses 05.
> 
> Signed-off-by: Antheas Kapenekakis <lkml@antheas.dev>

Reviewed-by: Mika Westerberg <westeri@kernel.org>

