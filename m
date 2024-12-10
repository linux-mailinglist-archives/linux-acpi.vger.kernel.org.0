Return-Path: <linux-acpi+bounces-10060-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C1759EBB6D
	for <lists+linux-acpi@lfdr.de>; Tue, 10 Dec 2024 22:02:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6AB69284AA8
	for <lists+linux-acpi@lfdr.de>; Tue, 10 Dec 2024 21:02:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9F5722FAE4;
	Tue, 10 Dec 2024 21:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Fxo4z5fE"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D07B22FAD8;
	Tue, 10 Dec 2024 21:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733864572; cv=none; b=q5MGzpXjiT1hdcOik2ASYFVxeFBhBVl4G1N3iDGtx2ghfKN4x5JaRMKdLG6yKS2PqfG7ruJEYozemm0xwC57jfFcUszVcetU5V4rpOvGYLXzhTPwWm8bxmQTFt8X/WEN8QO/z2MS4ohutgEpciqNjWvL7bcLfwLcd+lh+Asm91s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733864572; c=relaxed/simple;
	bh=0aFXEEDvOspF3yGOUKT5Xg7eGq7/dR3C61JGAgBxTzg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fjRlutObDQJNsOFqVjLpyBfPOfxafzsqa1BKCEnzG/4hxQgyCw+KaOGwkoJ01BuVluiiytRE+BpE/MEDegBwHaA5Z4mmJzVM3AOI53srfDZu+NVNhSNwboHFVRTvJoPNIKHjkTGfY5sz6nB9+NFgbhRqZs7dg+xnk9navH0rsQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Fxo4z5fE; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733864571; x=1765400571;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=0aFXEEDvOspF3yGOUKT5Xg7eGq7/dR3C61JGAgBxTzg=;
  b=Fxo4z5fEO8lLlDQoFz123lFeEqPWKrUiuGXB5g3T/Xu62/wcOCOcF04Z
   dj1kOhHhGKblxT2d+Hy0neXsMkVBBUjNhP+0Z+mrhplBNhLOrp09AyoPn
   saVPAz8Dq3sm4HusPkmfzjVZBn9paCOx6+0oOjx3fYeymrAzdWQGnrkJq
   RDOSdgRYdE1OtiAPBjCA3QPWADqeHN+7hK+73gub5f8/YFVMHuRWDziEr
   u/dEkjoDataV6uKc4RUk17hIWqyQ6ZvngzZakaCnBmpyyBHcp7TM9qnZo
   A/OUqAk6ZlqyDQJf04xFZpp4RLg6nK0oT4+lWulnJgyx09+Zxs1/S0foG
   A==;
X-CSE-ConnectionGUID: +tiRi5cjTDy1tDmMuHYoAg==
X-CSE-MsgGUID: Tu8pkaIhTleNijW/zWsetA==
X-IronPort-AV: E=McAfee;i="6700,10204,11282"; a="59619670"
X-IronPort-AV: E=Sophos;i="6.12,223,1728975600"; 
   d="scan'208";a="59619670"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Dec 2024 13:02:51 -0800
X-CSE-ConnectionGUID: sDHT2JsISpmcNR9dM8JtqQ==
X-CSE-MsgGUID: NBRpMquyTbKN01UI9mWCew==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,223,1728975600"; 
   d="scan'208";a="95365057"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Dec 2024 13:02:48 -0800
Received: from kekkonen.localdomain (localhost [127.0.0.1])
	by kekkonen.fi.intel.com (Postfix) with SMTP id C3A6711F81D;
	Tue, 10 Dec 2024 23:02:45 +0200 (EET)
Date: Tue, 10 Dec 2024 21:02:45 +0000
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
Subject: Re: [PATCH v3 2/7] ACPI: bus: implement for_each_acpi_dev_match when
 !ACPI
Message-ID: <Z1isdXr_o-6ZhDMh@kekkonen.localdomain>
References: <20241210-fix-ipu-v3-0-00e409c84a6c@chromium.org>
 <20241210-fix-ipu-v3-2-00e409c84a6c@chromium.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241210-fix-ipu-v3-2-00e409c84a6c@chromium.org>

Hi Ricardo,

On Tue, Dec 10, 2024 at 07:55:59PM +0000, Ricardo Ribalda wrote:
> Provide an implementation of for_each_acpi_dev_match that can be used
> when CONFIG_ACPI is not set.
> 
> The condition `false && hid && uid && hrv` is used to avoid "variable
> not used" warnings.
> 
> Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> ---
>  include/acpi/acpi_bus.h | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
> index b2e377b7f337..eaafca41cf02 100644
> --- a/include/acpi/acpi_bus.h
> +++ b/include/acpi/acpi_bus.h
> @@ -1003,6 +1003,9 @@ static inline int unregister_acpi_bus_type(void *bus) { return 0; }
>  
>  static inline int acpi_wait_for_acpi_ipmi(void) { return 0; }
>  
> +#define for_each_acpi_dev_match(adev, hid, uid, hrv)			\
> +	for (adev = NULL; false && (hid) && (uid) && (hrv);)

There should be a space after the semicolon. I guess this might depend on
who you ask. Either way,

Reviewed-by: Sakari Ailus <sakari.ailus@linux.intel.com>

> +
>  #endif				/* CONFIG_ACPI */
>  
>  #endif /*__ACPI_BUS_H__*/
> 

-- 
Regards,

Sakari Ailus

