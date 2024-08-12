Return-Path: <linux-acpi+bounces-7539-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EE9D594F5C4
	for <lists+linux-acpi@lfdr.de>; Mon, 12 Aug 2024 19:24:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A6881F21C68
	for <lists+linux-acpi@lfdr.de>; Mon, 12 Aug 2024 17:24:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80FE1188007;
	Mon, 12 Aug 2024 17:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RRauf0Fx"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E36A91804F;
	Mon, 12 Aug 2024 17:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723483481; cv=none; b=CrgHYeCRlf2eT9w5CvHK8ud00TokXYCMVG54h1Nd386LmSINQsJO85Pv3yzoGGScYqz2A79dcfCrF/TjYe+WrJwxi/bP1w/FJCAuG10NXr2z/9t5DlnY7BY+Z+4D/3MJOoMar879LyWmjen4/8ItaGcC+TcC1DkgXS8UjJAmKR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723483481; c=relaxed/simple;
	bh=muVd1FuJJevJKNII3TSAT6+y02C3te2AdDuHpsHZ0yU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VfLEE5+DY4UP9aN8k7yq4yYoXxldJDxW9IAEl3kw/mFRhu3xq84/iy27QAZVIJhqs67/XhcDuzvUQZewOepv15CxS+spnUZWKHaGYOs1U20acPoq0HeqQd+Hxi8PYrcrWBcmIQNi3P1XI1S5L2IkSblFgCy8jJJfTghrjbgGTJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RRauf0Fx; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723483480; x=1755019480;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=muVd1FuJJevJKNII3TSAT6+y02C3te2AdDuHpsHZ0yU=;
  b=RRauf0FxqqcXtwi75nzt2rfbjkEKffgNnePMeZspw26iucfJFxboDUkY
   Qddlq/r2JalV9OeutnPPCkkNDxMoEeOW0JaPHDTUGQ/V0T7IKFWMfq07W
   ykQ5+A2lubBxbjNGjK12hAa6/PP3/w9qBOedyaXyHJs9FT+ghfioGsgbG
   ltmsXiJ8yR9ZpnJbBoOE9GlaEzitytJQ+M9ieTzPTEtqQ1d0ai3ykfSbb
   4SnFQV2EqhS7J9R6ERjW6AoxLe472nyrvkvv1vgF/GyhfUMf86y7GD+1o
   f/smSLXyjL54UtESVp2wBF/ZURm2SbDEJOVADMZPhedghqtMSUw0id0sh
   A==;
X-CSE-ConnectionGUID: MXFgJLxKRXiDKv7FOu6iFA==
X-CSE-MsgGUID: yi00V8XfRReVoZHYTtBZwQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11162"; a="39123457"
X-IronPort-AV: E=Sophos;i="6.09,283,1716274800"; 
   d="scan'208";a="39123457"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2024 10:24:39 -0700
X-CSE-ConnectionGUID: GQBStyC2TcyHGpvGGxlE2g==
X-CSE-MsgGUID: gJHZXCzHTjmPhzxkhr9RsA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,283,1716274800"; 
   d="scan'208";a="62990701"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2024 10:24:37 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1sdYmZ-0000000EQZW-1nJS;
	Mon, 12 Aug 2024 20:24:35 +0300
Date: Mon, 12 Aug 2024 20:24:35 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
Cc: rafael@kernel.org, lenb@kernel.org, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Sanket Goswami <Sanket.Goswami@amd.com>
Subject: Re: [PATCH v2] ACPI: APD: Add AMDI0015 as platform device
Message-ID: <ZrpFU6wFyQDykSlO@smile.fi.intel.com>
References: <20240812144018.360847-1-Shyam-sundar.S-k@amd.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240812144018.360847-1-Shyam-sundar.S-k@amd.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, Aug 12, 2024 at 08:10:18PM +0530, Shyam Sundar S K wrote:
> Add AMDI0015 to the ACPI APD support list to ensure correct clock settings
> for the I3C device on the latest AMD platforms.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
from the ACPI ID perspective.

-- 
With Best Regards,
Andy Shevchenko



