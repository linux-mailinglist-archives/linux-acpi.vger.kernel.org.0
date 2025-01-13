Return-Path: <linux-acpi+bounces-10538-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B3E74A0B1E5
	for <lists+linux-acpi@lfdr.de>; Mon, 13 Jan 2025 09:58:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 813953A170A
	for <lists+linux-acpi@lfdr.de>; Mon, 13 Jan 2025 08:58:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9039F234995;
	Mon, 13 Jan 2025 08:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MLV+6VMt"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3C63234977;
	Mon, 13 Jan 2025 08:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736758710; cv=none; b=ohO/Xfn43PJl391K5SM9qbRpT440Y2rl66F8vCZboFV72ujwrIT/qH+ni0j9NxvOEhceoknl/kvq+B+ZFsNf2+MLykxvzsxJp9k6brfDkxbZ1NfGZXlJclfdUTDxd9dDe2Y8GRXaUA6Dy8QGgAa2Wj0Z1av8fKdAeYAAf7385eg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736758710; c=relaxed/simple;
	bh=znVu+5gy+maCefTc3reOTU8DE8LP8hUstI581NvFkLM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iuuIZ7wjg7bfSVX4cn4EU0QCvJJH+qkMKUprGxJ8eyErha6ApNegID1Omk1SqDyvVGSLedDRgg/xOvYPwMF7F1Tzptz5qM7xgaAzHsQNM/wrHwvlMs3dT0VMRXnj7SkElu3BijD2ur+SZr7F+mThl8pNKZ1aKCfKJuZShY5FQA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MLV+6VMt; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736758709; x=1768294709;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=znVu+5gy+maCefTc3reOTU8DE8LP8hUstI581NvFkLM=;
  b=MLV+6VMtaYJpztCQbgxxWH/EFsriroCjKdOU2fJwAXOsEgUOEgGR08Cn
   YfyIKLxDHNAuJJJICPAe7psZbo7O7+I4DsucbBo7iae06IUmwwais7fjJ
   Fb59nmDlrzKT/qa96ae7wojBPV83yXFaGdAw0tc51Uv2OJzRUvNZAL8W1
   WY0GLpWMb+CQzbaLgWxDvsJnvfkmBVySCPp63EIJWp7EEEHdanndBNina
   q0SYuHF4co2llc+luPu/KO6cAwHcDs7cjc8Qg+PZbVJXisF1kjKXsyW2r
   GqOHsb5UFEi6vPf3csxlwXYyI7pRIvRueScldpRsM5BhOQvWShDzYTYRT
   g==;
X-CSE-ConnectionGUID: EN4PQb02S4acgtYCEclsJA==
X-CSE-MsgGUID: M/HtR1h/Q5mHheifFvgi2Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11313"; a="36912180"
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; 
   d="scan'208";a="36912180"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2025 00:58:28 -0800
X-CSE-ConnectionGUID: CYJRBPEcQuSM5tQTJHE6BA==
X-CSE-MsgGUID: BIMdS1L6Qkmfyo+F8uFUUg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="109046033"
Received: from unknown (HELO smile.fi.intel.com) ([10.237.72.154])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2025 00:58:25 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1tXGH9-00000000OjI-0dN6;
	Mon, 13 Jan 2025 10:58:23 +0200
Date: Mon, 13 Jan 2025 10:58:22 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
	Daniel Scally <djrscally@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Saravana Kannan <saravanak@google.com>, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 0/2] device property: Warn on
 (of|fwnode|device)_property_read_bool() for non-boolean properties
Message-ID: <Z4TVrob9K401tCNK@smile.fi.intel.com>
References: <20250109-dt-type-warnings-v1-0-0150e32e716c@kernel.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250109-dt-type-warnings-v1-0-0150e32e716c@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Jan 09, 2025 at 01:42:04PM -0600, Rob Herring (Arm) wrote:
> This series makes using (of|fwnode|device)_property_read_bool() on 
> non-boolean properties give a warning when used with DT. This has been 
> deprecated behavior for a while now. Soon we will add yet another 
> variant of this function with a Rust binding[1].
> 
> Why not put the warning in the fwnode code? The fwnode code doesn't know 
> the property's type as that depends on the firmware. For DT, a boolean 
> is a property with no value.
> 
> Perhaps the ACPI backend should have a warning too? I looked briefly at 
> it, but I don't have a clue how or if that can be detected. Doesn't look 
> like there's a specific type for booleans. In any case, that would be an 
> additional change on top of this series.

ACPI doesn't have such a concept, i.e. there is no separate "boolean" type.
All properties must have a value, we just ignore its content in case of
_read_bool() API, so from ACPI perspective this _read_bool() is purely SW
concept.

-- 
With Best Regards,
Andy Shevchenko



