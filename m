Return-Path: <linux-acpi+bounces-13792-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BC5E2ABBC03
	for <lists+linux-acpi@lfdr.de>; Mon, 19 May 2025 13:09:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E4F8C189C27F
	for <lists+linux-acpi@lfdr.de>; Mon, 19 May 2025 11:10:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99600274657;
	Mon, 19 May 2025 11:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CFNHHAqj"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26B381DE4FB;
	Mon, 19 May 2025 11:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747652985; cv=none; b=SlKaR5f2pcA3HetOvwix4d+cfdo0pCqRfQZ/MZDa6hBFz9yb15lQ9X8PrrbrJcjC2DnUOnkldv1Gl1ii0FtJrCKHJNSBTwbFkeCK095UYOK3H6FLcUvYzfmqv6rJOASZXGbsBPub7b+PPiScACamK4N1PGg8EM4BZIb8JZ3q+38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747652985; c=relaxed/simple;
	bh=y4ntHkQCP4Q2hIijIfddgLtb16Yzrq9xJ/8RIcvyu/I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y5IJrmJvka3GOPH+kQXgIXXNxzAS0dQO6rcfdZavTrOzDxeN9VSQHbbaN068rlw1u2XbXiFduhkY+oxrZW4px8C9A0K9rP5eEuX2VtVIUL9hRWOBeXikg05LsCvDwzVAHfPBCeh2tXmEM1pPVDe0eWXW0LC3yf1xi2hKb574+b8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CFNHHAqj; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747652984; x=1779188984;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=y4ntHkQCP4Q2hIijIfddgLtb16Yzrq9xJ/8RIcvyu/I=;
  b=CFNHHAqjdwTz4/ic0jprqMrCq+C6n/b4z7y83VX+XH5s35zNxtwXI/Te
   BJ47J3L19w38ToG8mVfaQ/9jBr6Hzoe3eglmEC8e61PAZ01IojN61Sw88
   ChCNLLTkZbqp/CPy4u4lbEbidPs0FCr8Y579b/QWCZAvD6g+rVKtSdbnz
   IutLdARJwHP7dVIukTKtsGPiXnaeb7JOg2OThNrw7JduH+tkWGllgSm7y
   UNRfBqtyFu13Onw8rneJTZqQYppxxC2bggK9N3iB+GAPErSdiLQjHd7uu
   H0KRnZkqMjAwb5ltJsMDs5rzywfp1HUYhKxzzIkrEuHGsopqEvGJTESXZ
   A==;
X-CSE-ConnectionGUID: jKm9f5loQJ+w1xAcJv/Cng==
X-CSE-MsgGUID: fz7ihnU/QGG5CsPrcSwR2A==
X-IronPort-AV: E=McAfee;i="6700,10204,11437"; a="66961319"
X-IronPort-AV: E=Sophos;i="6.15,300,1739865600"; 
   d="scan'208";a="66961319"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2025 04:09:43 -0700
X-CSE-ConnectionGUID: GMjboc34Tzu4yAH3PHop9Q==
X-CSE-MsgGUID: DOlxpAMTTZ+wQyelNCEa6g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,300,1739865600"; 
   d="scan'208";a="144590228"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa004.fm.intel.com with ESMTP; 19 May 2025 04:09:41 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
	id 1DCDA26F; Mon, 19 May 2025 14:09:40 +0300 (EEST)
Date: Mon, 19 May 2025 14:09:40 +0300
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Lukas Bulwahn <lbulwahn@redhat.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Mika Westerberg <westeri@kernel.org>,
	Hans de Goede <hdegoede@redhat.com>, linux-gpio@vger.kernel.org,
	linux-acpi@vger.kernel.org, kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Lukas Bulwahn <lukas.bulwahn@redhat.com>
Subject: Re: [PATCH] MAINTAINERS: adjust file entry in GPIO ACPI SUPPORT
Message-ID: <20250519110940.GW88033@black.fi.intel.com>
References: <20250519065557.659674-1-lukas.bulwahn@redhat.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250519065557.659674-1-lukas.bulwahn@redhat.com>

On Mon, May 19, 2025 at 08:55:57AM +0200, Lukas Bulwahn wrote:
> From: Lukas Bulwahn <lukas.bulwahn@redhat.com>
> 
> Commit babb541af627 ("gpiolib: acpi: Move quirks to a separate file")
> splits drivers/gpio/gpiolib-acpi.c into two files, gpiolib-acpi-core.c and
> gpiolib-acpi-quirks.c, but misses to adjust the file entry in GPIO ACPI
> SUPPORT.
> 
> Adjust the file entry after this splitting into the two files.
> 
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@redhat.com>

Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>

