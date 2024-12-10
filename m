Return-Path: <linux-acpi+bounces-10055-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44E799EBB2A
	for <lists+linux-acpi@lfdr.de>; Tue, 10 Dec 2024 21:53:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 137DB2837E3
	for <lists+linux-acpi@lfdr.de>; Tue, 10 Dec 2024 20:53:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9BD522B584;
	Tue, 10 Dec 2024 20:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="i8/+jfRV"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 827D523ED69;
	Tue, 10 Dec 2024 20:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733864021; cv=none; b=of843BJWseePSAwnjaljTqO1H6ecUEG9I1dfgDZpmkWCpZS1Iq4uhnNTuBb057MO0nYB+fe9teijVu4SIQMIhAzH+Z9Wo/EYBpcnRTHIHdt1uOoLA+bnvY8HhyVEjFDvL0JgOq9tVz0QSueMu2JVTqQJ1ddMpMF16ZSC71JbJPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733864021; c=relaxed/simple;
	bh=31LfL6mjPS1xsStD1eGVuT27O7F4GBZV6V514vOglIo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XgyECGWgA9gKBBfhK7hX3uI7P9B8VjhZMnP02rD7docl1VlHM5rQ+oJvs2QhUstJ1MZSR9pmOueD7SfX8J7SQvt6i/gx/jP7RlHjbVVRATa5RMdZ6smRcCShCuX+YfLloh+cmmeGOMY5WLR0gwnM9MOWGZsNQpmW6kHQ6gIqFzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=i8/+jfRV; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733864020; x=1765400020;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=31LfL6mjPS1xsStD1eGVuT27O7F4GBZV6V514vOglIo=;
  b=i8/+jfRVGLQbOLwg5jQG6zcrvWf9YJ4zbTkvhrx6GqctsmLIOrWiDj3Z
   zSmtWpcA15mnkQfD4+Ch7XeSZTmyOiv563of1YZnW9WAuLNdBO11LxGu0
   ILCv9uR/IksZE2l6odF9C5oz8zVENeYTXQnFyurKyKMcH7t+C41O+2BoH
   rAg7vvuvC0RUZnkX137oSRp77xwKzTjZo+7Afh4u2nwclS9QtHh6kdcon
   YngI71q08ygblO37/qFyQGCoDVMeomW1Enr/PuD/e9AHkOM17zhbSdHII
   g8JDKfSvzYTDq/dk443GRI+NaWyrk93GMIuZNc6J32ludunFenzJgiUV5
   A==;
X-CSE-ConnectionGUID: T6R20B+gQp+98YtG2KrfGQ==
X-CSE-MsgGUID: lqeVwX3dTiWRJcktL69gmg==
X-IronPort-AV: E=McAfee;i="6700,10204,11282"; a="34366428"
X-IronPort-AV: E=Sophos;i="6.12,223,1728975600"; 
   d="scan'208";a="34366428"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Dec 2024 12:53:39 -0800
X-CSE-ConnectionGUID: rKdIPVNVQySlVifuPUcJYA==
X-CSE-MsgGUID: 6dcOQfZqSXmw5eYrhAUzLg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="100583305"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Dec 2024 12:53:37 -0800
Received: from kekkonen.localdomain (localhost [127.0.0.1])
	by kekkonen.fi.intel.com (Postfix) with SMTP id 7ED5E11F81D;
	Tue, 10 Dec 2024 22:53:33 +0200 (EET)
Date: Tue, 10 Dec 2024 20:53:33 +0000
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
Subject: Re: [PATCH v3 3/7] ACPI: bus: implement
 acpi_get_physical_device_location when !ACPI
Message-ID: <Z1iqTe5_tiJ_ehzU@kekkonen.localdomain>
References: <20241210-fix-ipu-v3-0-00e409c84a6c@chromium.org>
 <20241210-fix-ipu-v3-3-00e409c84a6c@chromium.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241210-fix-ipu-v3-3-00e409c84a6c@chromium.org>

Hi Ricardo,

On Tue, Dec 10, 2024 at 07:56:00PM +0000, Ricardo Ribalda wrote:
> Provide an implementation of acpi_get_physical_device_location that can
> be used when CONFIG_ACPI is not set.
> 
> Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> 
> dasadsd

Yes?

Apart from this,

Reviewed-by: Sakari Ailus <sakari.ailus@linux.intel.com>

> 
> Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>

-- 
Regards,

Sakari Ailus

