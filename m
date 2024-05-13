Return-Path: <linux-acpi+bounces-5791-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E65C8C3E89
	for <lists+linux-acpi@lfdr.de>; Mon, 13 May 2024 12:02:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8E5831C21600
	for <lists+linux-acpi@lfdr.de>; Mon, 13 May 2024 10:02:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F360A1494AC;
	Mon, 13 May 2024 10:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Iql2DocK"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B815148FE3;
	Mon, 13 May 2024 10:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715594547; cv=none; b=Nahfg73Jbd5agbmDMVOXxhp4LTHT0Ma6Wh+1uGMtAtVOr9demCbYrLrp56FeDES/CRi+vnLvEQewafYBkJATcP6R2WylZuwDCRI8K+EjdUfBNUp63SO98T2O5BTfvZCXGiuoXWaGxznp/H/neCbsFleVyNwW6O9JYCDlhFZPtL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715594547; c=relaxed/simple;
	bh=5RJo2efqIsOq0LaQL2+3JeSim/PagDwzxqGWls+Q+Wo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rZhiwIX3D1BLlUoK7YwtKPYZWMLPWTK0tJAIsvIo4LQ8Q5zq/Fj2wpVzszRR5NsrhGGrkjUXiLq6W5MLdwVaeYOOhKwW+/7CVpp51ixa8qurPPv91DmUuTQ45zDHBIa7G7k72tVNQg9yIL9fE4eih+oliEru0xKaTCby8jkmqmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Iql2DocK; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715594547; x=1747130547;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=5RJo2efqIsOq0LaQL2+3JeSim/PagDwzxqGWls+Q+Wo=;
  b=Iql2DocKu7o1D6rivz8LtagH+WNQV0B5tAqtaIkUDvXmyQdykR1cNlW1
   W4Q947APu2KG/0ZgNdSRnDxUaagB7fI9mGHIvZawKeo0EWYBT+m80beRN
   hMQxhaa0duYN8qSpHGhxvnV8W7R3mtCP2KhyoCu8jcDtdtvFXzvj8PYwN
   zyX0v+2oWWtDhCqIjqIS1rj4CTgnhDfRkuTI9hEA/4ndNZ9hUAK+FmT4g
   d3CifDbYGogt/ylHSyhPLfM7x99QXndLigoVjYNw/MEZCSgAOBbPLKEa/
   9/295bXMfcyVGkjhCTl5emEeMP/lMrsufHHczmFL6D8AOeioi3nIJFeSh
   Q==;
X-CSE-ConnectionGUID: UYPuHdV7RLKkbhMzvPiodw==
X-CSE-MsgGUID: u2n1WeRiSQWw1v7pB4SqHg==
X-IronPort-AV: E=McAfee;i="6600,9927,11071"; a="29035499"
X-IronPort-AV: E=Sophos;i="6.08,158,1712646000"; 
   d="scan'208";a="29035499"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2024 03:02:26 -0700
X-CSE-ConnectionGUID: XZ8//4WYSEqnxisAoI+O1g==
X-CSE-MsgGUID: XhoLT09UShK78x2xbYxvOA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,158,1712646000"; 
   d="scan'208";a="30131181"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2024 03:02:24 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1s6SVg-000000074ry-2Vlj;
	Mon, 13 May 2024 13:02:20 +0300
Date: Mon, 13 May 2024 13:02:20 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Laura Nao <laura.nao@collabora.com>
Cc: mika.westerberg@linux.intel.com, linus.walleij@linaro.org,
	brgl@bgdev.pl, kernel@collabora.com, linux-kernel@vger.kernel.org,
	linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	"kernelci.org bot" <bot@kernelci.org>
Subject: Re: [PATCH] gpiolib: acpi: Move ACPI device NULL check to
 acpi_can_fallback_to_crs()
Message-ID: <ZkHlLLLoagsYlll7@smile.fi.intel.com>
References: <20240513095610.216668-1-laura.nao@collabora.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240513095610.216668-1-laura.nao@collabora.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, May 13, 2024 at 11:56:10AM +0200, Laura Nao wrote:
> Following the relocation of the function call outside of
> __acpi_find_gpio(), move the ACPI device NULL check to
> acpi_can_fallback_to_crs().

Thank you, I'll add this to my tree as we have already the release happened.
I will be available after v6.10-rc1 is out.

-- 
With Best Regards,
Andy Shevchenko



