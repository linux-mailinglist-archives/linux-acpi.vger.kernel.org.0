Return-Path: <linux-acpi+bounces-5786-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F8578C3CE9
	for <lists+linux-acpi@lfdr.de>; Mon, 13 May 2024 10:10:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 403E41C20E71
	for <lists+linux-acpi@lfdr.de>; Mon, 13 May 2024 08:10:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5354E146D62;
	Mon, 13 May 2024 08:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mA4E3sfP"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF411146D5C;
	Mon, 13 May 2024 08:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715587853; cv=none; b=C6iuOSIauaBccfTGHK3fgPGfLWJtECKkq2DtsIa/wm/5j8mnePUCbciYUn/GP6Atjbr4k7dNYVKdSaobmFRagrBNdSwedX+r2wCED38rsqpePhB4/qmUsUuIm/2f879KQGLjSG6kSarYb7N5dqTIeniCvR36aBG8ecSmCuT9Bfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715587853; c=relaxed/simple;
	bh=9Xl6ZnpRjbLqgEIOfR/WmGiIuKENpUxi5oIg/QNWiuY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XKk1g/TakFbEw2MIm+oyKNp/LkDnH0+IJTfVy6ygBdiwllzxrj6tF5kaKGThTEs5iG/WNySONVsY7Tjg4o1x/lqgW0W5rbeB7hVKUCzuWWESOqsdr9fa2zXhLs/i5LrBVu7EKMIkhuVvXBZWBx1nQkKI+dlgdk6aQceBfyZ+T40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mA4E3sfP; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715587851; x=1747123851;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=9Xl6ZnpRjbLqgEIOfR/WmGiIuKENpUxi5oIg/QNWiuY=;
  b=mA4E3sfPWhl0xygKEQqBsciI2zkuCHrc8PxU6EIkGqzC76Bcqj0HC9ea
   W36T+4FNm8SfHuYg+zTtmDcCHmmoe9HyKknOrkNYdXBE2tQTA3bmIIOHA
   ZHSGc43R+iSGT57YudzF6oOBTM0LL6qRw8apeDwQD6IM+mBm//7zGtK7C
   i+/aq3g1J7teyeKDl5AKj+3cYAJhWo16nsbob0fbXtwwLONSr8CnxPb+y
   xVkbu7OvJAMbB6AnHPTVFmVX21FKKFUPnGlFHvdqM+UaqD/PuHzE508q7
   jSQeJeYkBI8LYo2ofSvpNozmQw5iu139asWdczVH7JUuVQzHohNuHqu+W
   g==;
X-CSE-ConnectionGUID: fgpUd4oXQw+Em6TYhg+Spw==
X-CSE-MsgGUID: jj3B2kptRleYM+o4mpcLDg==
X-IronPort-AV: E=McAfee;i="6600,9927,11071"; a="11386765"
X-IronPort-AV: E=Sophos;i="6.08,157,1712646000"; 
   d="scan'208";a="11386765"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2024 01:10:50 -0700
X-CSE-ConnectionGUID: uMdisb5AQlWF6mIm6DAd6Q==
X-CSE-MsgGUID: Q9VYS43YQaiOW2uszhAwug==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,157,1712646000"; 
   d="scan'208";a="35023308"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by orviesa005.jf.intel.com with SMTP; 13 May 2024 01:10:48 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Mon, 13 May 2024 11:10:46 +0300
Date: Mon, 13 May 2024 11:10:46 +0300
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux ACPI <linux-acpi@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Hans de Goede <hdegoede@redhat.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Armin Wolf <w_armin@gmx.de>
Subject: Re: [PATCH v1 0/2] ACPI: EC: Install EC address space handler at the
 namespace root
Message-ID: <ZkHLBsGqT2A7wTmR@kuha.fi.intel.com>
References: <5787281.DvuYhMxLoT@kreacher>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5787281.DvuYhMxLoT@kreacher>

On Fri, May 10, 2024 at 04:01:41PM +0200, Rafael J. Wysocki wrote:
> Hi Everyone,
> 
> This is a follow up for the discussion in:
> 
> https://lore.kernel.org/linux-acpi/CAJZ5v0hiXdv08PRcop7oSYqgr_g5rwzRTj7HgdNCCGjXeV44zA@mail.gmail.com/T/#t
> 
> Patch [1/2] is a resend of the patch posted in the thread above and patch [2/2]
> removes the custom EC address space handler from the WMI driver as it should
> not be necessary any more.

For the series:

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

Thanks Rafael!

-- 
heikki

