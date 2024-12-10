Return-Path: <linux-acpi+bounces-10058-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 064B69EBB48
	for <lists+linux-acpi@lfdr.de>; Tue, 10 Dec 2024 21:58:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 173F72842E0
	for <lists+linux-acpi@lfdr.de>; Tue, 10 Dec 2024 20:58:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0ACC22B5B0;
	Tue, 10 Dec 2024 20:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ffjRKAlk"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B3D922B5A0;
	Tue, 10 Dec 2024 20:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733864282; cv=none; b=VFSUVeiPheC39DjYQWBcqy945rYcBSPxsDOKB0yY8v22pE0+lXPpKuE4BfVyqR2ioxwJUu0Q+30QdFkgDzJGjSlMPxFzTEK+l2tcuNTSMSrI8lJyTqcf7M3mdwSLpY49ls77Tt3b2/OjnbujjCUHauzCArenKx6tveX9J1YszGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733864282; c=relaxed/simple;
	bh=h2+0IkWaRrqPvKSnyfZPLowW7wCGAgvE4o3XhsiAVT8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Dq3U4VLgb/spaXLkjnI++fpZmiusCcIfEy6OqE7GjRddEhY/D0HgfpTzu5njrsJColcCEfs+HHcCGDXeEEZZFu2jjWSXJKXdXaPNf6SoHT9bQtStaUAfPig9WpswTHmssMLqV3dSaMCVxRTNd6NX/yFSONG3XnaPCdxEgv0g+LA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ffjRKAlk; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733864282; x=1765400282;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=h2+0IkWaRrqPvKSnyfZPLowW7wCGAgvE4o3XhsiAVT8=;
  b=ffjRKAlkdlP7s/yU8u8kZwSvcteDq/Aot1RGIOHukHZl8nOBINWVE3WV
   fhLFvSuaGot+E1W76vlDjcKcb1XPsKaox5DHyBWKxAJCZxt2anr3TQ142
   pd68pdmoq0EEK5wmD663p0WMgoG5VChOQk1kvnHF9+NU5qcKd7Po44EBc
   VQawj+usWB3pSyyT0Q16HXeh0Mo+xLRpBRnSq+WNjUosXjQjR7S+aktgo
   m2ZV7+8kp4g/4qrK9baDmOofhfuXBuDvVs02gS2TSoUa/b/CD7UPEzTlO
   Z6VnBfxDsdHCFp+M7RhhaDZT54sgJ2YwtQS2DMotPKC53bhpVXMeXPsJq
   w==;
X-CSE-ConnectionGUID: SjWIhFFSRkipNtaO1jw1iA==
X-CSE-MsgGUID: c4ZW7IZtToi0mC6rYaOEOQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11282"; a="34366749"
X-IronPort-AV: E=Sophos;i="6.12,223,1728975600"; 
   d="scan'208";a="34366749"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Dec 2024 12:58:01 -0800
X-CSE-ConnectionGUID: EYvCa/ZyS66zF9Q7MuElLQ==
X-CSE-MsgGUID: p4Sggb35QqC6g5K1RkOKMw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="100584737"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Dec 2024 12:57:59 -0800
Received: from kekkonen.localdomain (localhost [127.0.0.1])
	by kekkonen.fi.intel.com (Postfix) with SMTP id F3E5B11F81D;
	Tue, 10 Dec 2024 22:57:55 +0200 (EET)
Date: Tue, 10 Dec 2024 20:57:55 +0000
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: Ricardo Ribalda <ribalda@chromium.org>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>, Robert Moore <robert.moore@intel.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-acpi@vger.kernel.org, acpica-devel@lists.linux.dev
Subject: Re: [PATCH v3 5/7] ACPI: bus: implement for_each_acpi_consumer_dev
 when !ACPI
Message-ID: <Z1irUz66IMsZuRFE@kekkonen.localdomain>
References: <20241210-fix-ipu-v3-0-00e409c84a6c@chromium.org>
 <20241210-fix-ipu-v3-5-00e409c84a6c@chromium.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241210-fix-ipu-v3-5-00e409c84a6c@chromium.org>

On Tue, Dec 10, 2024 at 07:56:02PM +0000, Ricardo Ribalda wrote:
> Provide an implementation of for_each_acpi_consumer_dev that can be use
> used when CONFIG_ACPI is not set.
> 
> The expression `false && supplier` is used to avoid "variable not used"
> warnings.
> 
> Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>

Reviewed-by: Sakari Ailus <sakari.ailus@linux.intel.com>

-- 
Sakari Ailus

