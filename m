Return-Path: <linux-acpi+bounces-12902-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AC51A82691
	for <lists+linux-acpi@lfdr.de>; Wed,  9 Apr 2025 15:44:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC2A0168C24
	for <lists+linux-acpi@lfdr.de>; Wed,  9 Apr 2025 13:44:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1335525DAE8;
	Wed,  9 Apr 2025 13:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="a2daIIyr"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAA8425DD0E;
	Wed,  9 Apr 2025 13:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744206290; cv=none; b=JV93SjsNav+KFSdO4E0XYovuMvur4tckYPwyVDgJ033NxehTlYfEndTpMYfylqRedHAbEvAx08YMD4nGm+Xx4kjenXFAo41fveO74iHfklxrAhL3xzjjHajHEKLRBSoWVjGpihW974y09U8+wNWJvBhsdcAQySNicn0eoXBSrHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744206290; c=relaxed/simple;
	bh=83YVMS2hsr3Awe8gA4+dCoPdIwMkXe+5JQPCgLuOiks=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uwHuUzBVMA70W5zu1Qb/Y3LnVHMRrsqWwj4kG4ZIUSwkevTakytyqH5Qg7LrFQOnP+bJmiyGwfvqz5DKbbgKxnRPayhznyIZeciJIJU/Jjh6YC0AtcRxQwFhoxof0EtttFug/P3C1wn6epSIYjvbU5oyEgjGZ1x2lP3dXyA3FLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=a2daIIyr; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744206288; x=1775742288;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=83YVMS2hsr3Awe8gA4+dCoPdIwMkXe+5JQPCgLuOiks=;
  b=a2daIIyrrpdMy5C4gWg9NOOFHPnmzMuWKMslQX0cD19DaL+62s8+IPNH
   yfKi57hUm5wKdSYtKfPyu8tkS11G9VPPmVEHi9hqY7vLUf3np30obT3Zw
   ZhN0y9suyuPG7moOM1GocK9bKjp2YNf4oFMpneKjg354z6hzyPTa1b80g
   pdzhy6DzSMPjxwbrNfCwdwJ7sCFUyPYwiTRX6LFY5mMy2z92Mgh1tXfIx
   eHpSUlTWfYKCin/sdoIFs8nTpemWHuefw8hq+pe2tgbQj1lUXSIF5u4mR
   2XW5tg0OuAqqdJK+VLDAmv4n7okc+/ER83wccFvxUmgMGLa4E6UKM9X14
   A==;
X-CSE-ConnectionGUID: NVQ5lt1eSQShCou4KkPk8Q==
X-CSE-MsgGUID: +Cb3bAw0SempgsCZ9w1Lvg==
X-IronPort-AV: E=McAfee;i="6700,10204,11397"; a="33288450"
X-IronPort-AV: E=Sophos;i="6.15,200,1739865600"; 
   d="scan'208";a="33288450"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2025 06:44:47 -0700
X-CSE-ConnectionGUID: R8aZaGi2RNmyO6MKGreazQ==
X-CSE-MsgGUID: +e8U61ruQxqEwtHbGLbChg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,200,1739865600"; 
   d="scan'208";a="129549769"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa008.jf.intel.com with ESMTP; 09 Apr 2025 06:44:45 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
	id D4FBE5CE; Wed, 09 Apr 2025 16:44:43 +0300 (EEST)
Date: Wed, 9 Apr 2025 16:44:43 +0300
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org, Mika Westerberg <westeri@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>
Subject: Re: [PATCH v1 0/2] gpiolib: acpi: Fix missing info filling
Message-ID: <20250409134443.GT3152277@black.fi.intel.com>
References: <20250409132942.2550719-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250409132942.2550719-1-andriy.shevchenko@linux.intel.com>

On Wed, Apr 09, 2025 at 04:27:52PM +0300, Andy Shevchenko wrote:
> Kees reported that code, while being refactored, missed the point of
> filling the info structure which supplies GPIO flags to the upper layer.
> Indeed, without that part the GPIO expander get no IRQ on Intel Edison,
> for example. Fix this in this series.
> 
> Andy Shevchenko (2):
>   gpiolib: acpi: Use temporary variable for struct acpi_gpio_info
>   gpiolib: acpi: Make sure we fill struct acpi_gpio_info

Both,

Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>

