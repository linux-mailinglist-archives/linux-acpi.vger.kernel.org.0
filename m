Return-Path: <linux-acpi+bounces-17952-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B76DCBEDABC
	for <lists+linux-acpi@lfdr.de>; Sat, 18 Oct 2025 21:38:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 71CD758709E
	for <lists+linux-acpi@lfdr.de>; Sat, 18 Oct 2025 19:38:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28ED8264628;
	Sat, 18 Oct 2025 19:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TBkY8ims"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B2E81E32D6;
	Sat, 18 Oct 2025 19:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760816289; cv=none; b=Fj+Ukdx5v6aJza4E3G+6IPlT+SdlcXikAgWhraJ0HlWpzJPo9/eMw+a3cmJwCGyK+V2S9mrXEr9Xrq7Uyqp0ocYs/B6WWR9S+D775c4aK630ALOF3XaxDUAVM5L7Bo9XPPSI9b/m1/EVCw2vPaSQ3d5mWQ+yTPL0nuVHfmqX/bM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760816289; c=relaxed/simple;
	bh=7NlNetwI7fF5pNrJ9dvbTyrdsC4GvtBuMKlNr/2UEyE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BL56FIUdvPlt9b6y6UQSPzsa3qGherWjGy7tNdg+iXtmeIL+LcAFlP00PEKpj9jjmvK85yddSW66AqXceoaBVMV4AAwQOfRQ3m7gOumeu+T2Y6aL/gBRQEPydAM21O3wrH7bomTpw0TZNhzDcMyJVO1MY/SWMR5kbUH/h/hjPIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TBkY8ims; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760816288; x=1792352288;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=7NlNetwI7fF5pNrJ9dvbTyrdsC4GvtBuMKlNr/2UEyE=;
  b=TBkY8imsb9VQ2QRF7tzYAeZVSQXo1JwYv9uGRfHstIG6ZRJx1oS+sIyb
   clPC2j4SkBuYudQRR0fARXlHqHYnI+Jn+NYxdC1mVOOMIPYhVkvMiAy46
   T0xdaFz7yJ1qfed0HA00vlIXfcTyObfRXDacLb4ywpT5wjCyh4eS9z+vi
   l8cRQlGcEVbzTOQb0cMqgKgClDV39l7RRjulXi6qw2HXsJgUDiX7CTpZs
   wM9LowFVlWBs9417v9bKyi0EFbLxp8VoNlYAvVwEqsYRuIoD1vG8TfQK6
   TGokA5ASqPO8u+4VU5VG3njfUFS6EHT9nFKqZNDxl6QeoC9TfFiQf+HiF
   w==;
X-CSE-ConnectionGUID: 9IdovZchQNi1uW+7CRHGxw==
X-CSE-MsgGUID: qKI+k2ykSBSSAvdqYfDqSg==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="85619091"
X-IronPort-AV: E=Sophos;i="6.19,239,1754982000"; 
   d="scan'208";a="85619091"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2025 12:38:06 -0700
X-CSE-ConnectionGUID: 2e+cihEERgG8BCyn7NFBog==
X-CSE-MsgGUID: DJiUfvSLRCa3AUfwXY9iaQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,239,1754982000"; 
   d="scan'208";a="182547110"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO ashevche-desk.local) ([10.245.244.194])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2025 12:38:04 -0700
Received: from andy by ashevche-desk.local with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1vACkb-00000000xf6-04SJ;
	Sat, 18 Oct 2025 22:38:01 +0300
Date: Sat, 18 Oct 2025 22:38:00 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Sunil V L <sunilvl@ventanamicro.com>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>, Paul Walmsley <pjw@kernel.org>,
	Jassi Brar <jassisinghbrar@gmail.com>,
	Anup Patel <apatel@ventanamicro.com>,
	Thomas Richard <thomas.richard@bootlin.com>
Subject: Re: [PATCH] ACPI: property: Fix argument order in
 __acpi_node_get_property_reference()
Message-ID: <aPPsmKRcB9YKYNGB@ashevche-desk.local>
References: <20251017100744.71871-1-sunilvl@ventanamicro.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251017100744.71871-1-sunilvl@ventanamicro.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Oct 17, 2025 at 03:37:44PM +0530, Sunil V L wrote:
> A refactoring bug introduced an argument order mistake in the call to
> acpi_fwnode_get_reference_args() from __acpi_node_get_property_reference().
> This caused incorrect behavior when resolving ACPI property references.
> 
> Fix the issue by correcting the argument order.

Thanks for a fix which looks good to me,
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

-- 
With Best Regards,
Andy Shevchenko



