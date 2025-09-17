Return-Path: <linux-acpi+bounces-17060-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 457A5B7CA1C
	for <lists+linux-acpi@lfdr.de>; Wed, 17 Sep 2025 14:06:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 55E6A170D1B
	for <lists+linux-acpi@lfdr.de>; Wed, 17 Sep 2025 07:18:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1A3D29B8D8;
	Wed, 17 Sep 2025 07:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="I393PITb"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3969200127
	for <linux-acpi@vger.kernel.org>; Wed, 17 Sep 2025 07:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758093531; cv=none; b=J+RmuHYPb9KtDtQJ+y/kU/1OxS6fGIr3lhzt3NVu5ZX92gMJ5/eQ/LrI5AmqAz9HQnpVdgNk1ey9kSiJDAIftOrVjht+u7WOO8HKOD9spFE9hCslMB3cm0ULrgCVL25byTpiWnUGMpbJh7q1vrjrYBPDfxyEepvo8c8O7X+lJBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758093531; c=relaxed/simple;
	bh=50+qb005AuSDLzgcaa2+NUkdAW7oQHznclaqmxM5fcY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rmQMQxPet6RQj7QWG6Dg0UrJYn5F7pP/qXFHGCCsU/ZmNbUGmjtLTvS1IOQf7bKNHFCY9bKg77KDn6de/mjBpgKe7T0i6WE6vaOA21tYiZHgkbiJfoE8E8mYAXPDvrkQMtAZ9XP0jlEeq6nJ9LjrU23UtV/91HF95YZdxkBDYFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=I393PITb; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758093530; x=1789629530;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=50+qb005AuSDLzgcaa2+NUkdAW7oQHznclaqmxM5fcY=;
  b=I393PITbaL8CIn38B6VVVryP8APyAC8RkHW/o3RCrL1oDr4tkRaK4zrb
   OdYMPnEbEqb/gGYoxOA3JINqd/5rHuha3fatKIjM971Lw5xX8oTI58Hi5
   9CyAA0GKDK7xeOuIuShLiZgk3UNhnwWtnFp8b/ri0Kb7rcj+nd+pmA1yY
   buhJT2vjGPvFZS+nzLYWAqTNltr9hP0woVnlVWN31fK8nsdmOfD17nMvs
   iC101xor2YPVM/KSvs1lRgxcwKVPSoms7QTN821+CPvfyCQIZJYy5gvYU
   xHAKhZ0yl7OOKLkdYpofWEMk+aCuJNXKt0d2S/LHHqoeD69YWnCux5NwX
   Q==;
X-CSE-ConnectionGUID: YITWNjaOR4mUzfNkwJJG8w==
X-CSE-MsgGUID: mRRBaXB7QsamUCupyS1gOw==
X-IronPort-AV: E=McAfee;i="6800,10657,11555"; a="85829531"
X-IronPort-AV: E=Sophos;i="6.18,271,1751266800"; 
   d="scan'208";a="85829531"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2025 00:18:30 -0700
X-CSE-ConnectionGUID: RwUzLSx4RnucbEnwdut+LQ==
X-CSE-MsgGUID: HGn2HGd6Tb26mecGxgIokQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,271,1751266800"; 
   d="scan'208";a="205940210"
Received: from smile.fi.intel.com ([10.237.72.51])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2025 00:18:27 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1uymQq-00000003jqi-2qRV;
	Wed, 17 Sep 2025 10:18:24 +0300
Date: Wed, 17 Sep 2025 10:18:24 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: linux-acpi@vger.kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>, Daniel Scally <djrscally@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Danilo Krummrich <dakr@kernel.org>
Subject: Re: [PATCH 02/14] ACPI: property: Make acpi_get_next_subnode() static
Message-ID: <aMpgwBflzFNc-ubZ@smile.fi.intel.com>
References: <20250916160129.3955410-1-sakari.ailus@linux.intel.com>
 <20250916160129.3955410-3-sakari.ailus@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250916160129.3955410-3-sakari.ailus@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Sep 16, 2025 at 07:01:17PM +0300, Sakari Ailus wrote:
> acpi_get_next_subnode() is only used in drivers/acpi/property.c. Remove
> its prototype from include/linux/acpi.h and make it static.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

-- 
With Best Regards,
Andy Shevchenko



