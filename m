Return-Path: <linux-acpi+bounces-10057-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E13399EBB44
	for <lists+linux-acpi@lfdr.de>; Tue, 10 Dec 2024 21:56:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C6D22828C6
	for <lists+linux-acpi@lfdr.de>; Tue, 10 Dec 2024 20:56:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E528A22E408;
	Tue, 10 Dec 2024 20:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="j9AdDqLp"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 217F122CBDC;
	Tue, 10 Dec 2024 20:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733864200; cv=none; b=C2Kgf2RDQPYEHIfRcnBlFzqddL0SjRtWQDuzVg3oN6Xv6kNezEVcvByzf1VXhgRxVqdfqxhv3tkKp8KsBqRpK7imSFA5otPZaK6sldQYt36Rk2YdoBF6DsuwADcP4KuBTqxf1pCsnmOvxbTHxGA8zyOdxS2SvkH+sTmg2nTrAyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733864200; c=relaxed/simple;
	bh=+trftT/A5eeKZmoRuAbn6h89guEn6f9AB4cq8MitB/g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jkvxac5Yp15xlLi8TrT++SSPXgJgbWma7sko0eTS1PvAozob+9+CxiWq1OcZf7DeDUi5TTipq5dwzZasC//PSKQJXaJZhNWsMpaSJFBDzLNq0bj0tyBzGzbjFboXWYTHb8CgtepTLv0xGP4Nx6Z3PiKYCKehhjt55FANX8qtIFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=j9AdDqLp; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733864200; x=1765400200;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=+trftT/A5eeKZmoRuAbn6h89guEn6f9AB4cq8MitB/g=;
  b=j9AdDqLp+YgvZa/uy15pdK//mxolQRPoH6r881v6KE7VXyyTRLsJw489
   TgxHNO2g9xCyRRkgZxlq5uer1SZJzQhxZWeDlI4xuq5QnGcC0yC5PXvrm
   uGsrF4GfPzNEMPsKEnVOnazebTuzCj670zYPeraOsohyysz4IEnRMN5ka
   uvQE0Lp0pq7BmlO4rnG8amUOgh4GtQ7H9hO1p73LCcCSWF5smmLBoWN0s
   cjUqt7U3wF6ENcIShAM1DEikV6HSwz44DCYfBg1cYX5uCX2XtaKGmBH5s
   h4OczGr/bOyzUSwQJO3zmoa4SN7uzx0vsEWhGdWIon9N8QP3f8OoN3BHt
   w==;
X-CSE-ConnectionGUID: /Hu34bG6S5GNYjmwUiDYRg==
X-CSE-MsgGUID: l/J2We1DRc6jqANm35ougg==
X-IronPort-AV: E=McAfee;i="6700,10204,11282"; a="37915895"
X-IronPort-AV: E=Sophos;i="6.12,223,1728975600"; 
   d="scan'208";a="37915895"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Dec 2024 12:56:39 -0800
X-CSE-ConnectionGUID: 50u5dATqRFyaflnCQ/LHVw==
X-CSE-MsgGUID: v5uzMed6QuiUyLTvHJuKxg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,223,1728975600"; 
   d="scan'208";a="100034841"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Dec 2024 12:56:36 -0800
Received: from kekkonen.localdomain (localhost [127.0.0.1])
	by kekkonen.fi.intel.com (Postfix) with SMTP id A77AC11F81D;
	Tue, 10 Dec 2024 22:56:33 +0200 (EET)
Date: Tue, 10 Dec 2024 20:56:33 +0000
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
Subject: Re: [PATCH v3 4/7] ACPI: header: implement acpi_device_handle when
 !ACPI
Message-ID: <Z1irAT0KVwqhBSSZ@kekkonen.localdomain>
References: <20241210-fix-ipu-v3-0-00e409c84a6c@chromium.org>
 <20241210-fix-ipu-v3-4-00e409c84a6c@chromium.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241210-fix-ipu-v3-4-00e409c84a6c@chromium.org>

Hi Ricardo,

On Tue, Dec 10, 2024 at 07:56:01PM +0000, Ricardo Ribalda wrote:
> Provide an implementation of acpi_device_handle that can be used when
> CONFIG_ACPI is not set.
> 
> Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> ---
>  include/linux/acpi.h | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/include/linux/acpi.h b/include/linux/acpi.h
> index 05f39fbfa485..59a5d110ff54 100644
> --- a/include/linux/acpi.h
> +++ b/include/linux/acpi.h
> @@ -787,6 +787,12 @@ const char *acpi_get_subsystem_id(acpi_handle handle);
>  #define acpi_dev_hid_uid_match(adev, hid2, uid2)	(adev && false)
>  
>  struct fwnode_handle;
> +struct acpi_device;
> +
> +static inline acpi_handle acpi_device_handle(struct acpi_device *adev)
> +{
> +	return NULL;
> +}
>  
>  static inline bool acpi_dev_found(const char *hid)
>  {
> 

Please remove the extra forward declaration of struct acpi_device a few
lines below this.

With that,

Reviewed-by: Sakari Ailus <sakari.ailus@linux.intel.com>

-- 
Regards,

Sakari Ailus

