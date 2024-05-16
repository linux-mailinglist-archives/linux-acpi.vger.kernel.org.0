Return-Path: <linux-acpi+bounces-5864-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB2FF8C748F
	for <lists+linux-acpi@lfdr.de>; Thu, 16 May 2024 12:22:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A4B19285FE6
	for <lists+linux-acpi@lfdr.de>; Thu, 16 May 2024 10:22:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 370C0143897;
	Thu, 16 May 2024 10:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Vr05ToeO"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F5BD143754;
	Thu, 16 May 2024 10:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715854962; cv=none; b=f+Zto/GiaQKG1INs+/Yah7a3ss2nC8UEsk/kplDk9I+OgfNkIlqvsvKIwaFBkL2OfXCzCHa7dDm2n7kDsmdyWSAl2IQoOYb2LeWW7yste6NjO6CKpgZv9HHAnTweeyaYljIxunMVWgSz2Ul1kwdMtzV+GF2ewEk3hzOKS4ZF8kA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715854962; c=relaxed/simple;
	bh=BLPAeblABOilq5kJ3p/YGJA7GN0zNg8QLaWn0ZaZTbY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=owNTaiafPSPwZoMB6mH0bOH1K6q54BlyWr02Q7q+xXntIn1ujg5HgxfzJyxZm9zhyCREkVmg53HmtqV5gFix/Swkup5DOP4lHu1Js0Ht4uExOIG+wcKXfMDp2evEL90dHv6bijzno9WmXya8bjSHujDss6qphMzspdvLnaPFRKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Vr05ToeO; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715854961; x=1747390961;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=BLPAeblABOilq5kJ3p/YGJA7GN0zNg8QLaWn0ZaZTbY=;
  b=Vr05ToeOYP52a7Mof67Xt1H2LtGtIIOpiSd4vze3BV2YnUtMPA5r8zUm
   GWI+h4KTIHUSkLONQisiLemNiE6UWkmWUWKaxvAIzAxzv9FPyDt6j816Z
   qKqIXIkj8Y0DdB29a/vBE4qGeSCu01Fb1boS3amdNAPrU6oXzp/tjElvW
   8t511EqBT1Kf+CC1PERlNP4+fXKfSh1443Q+6u3SLYcCZjYRzULmDGMrl
   HXlvLwS8XKHk7reNU/BQoe8wo6bMfA1RPaXjApqvKHEoeQXDR4sTgQopm
   P57LsqcGop2ahrj7SAGNasFSC0rEZCFN4AjpHZi5upDxke/Qu0Z4RLx+9
   w==;
X-CSE-ConnectionGUID: 6Jstdw2iQRqR1Cy0xBcW9Q==
X-CSE-MsgGUID: l8Ia2LY8QtGBrzdk35zBqA==
X-IronPort-AV: E=McAfee;i="6600,9927,11074"; a="22534941"
X-IronPort-AV: E=Sophos;i="6.08,164,1712646000"; 
   d="scan'208";a="22534941"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2024 03:22:40 -0700
X-CSE-ConnectionGUID: wSrC33eIQmC2ooLPw7gl9A==
X-CSE-MsgGUID: jBbc5RiUTYyuIx2E4njqfw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,164,1712646000"; 
   d="scan'208";a="31487212"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2024 03:22:38 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1s7YFv-000000080Un-1oY1;
	Thu, 16 May 2024 13:22:35 +0300
Date: Thu, 16 May 2024 13:22:35 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux ACPI <linux-acpi@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Hans de Goede <hdegoede@redhat.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Armin Wolf <w_armin@gmx.de>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>
Subject: Re: [PATCH v2 1/2] ACPI: EC: Install address space handler at the
 namespace root
Message-ID: <ZkXea4fdJwgvu0Hm@smile.fi.intel.com>
References: <12437901.O9o76ZdvQC@kreacher>
 <6046110.lOV4Wx5bFT@kreacher>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6046110.lOV4Wx5bFT@kreacher>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, May 15, 2024 at 09:40:54PM +0200, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> It is reported that _DSM evaluation fails in ucsi_acpi_dsm() on Lenovo
> IdeaPad Pro 5 due to a missing address space handler for the EC address
> space:
> 
>  ACPI Error: No handler for Region [ECSI] (000000007b8176ee) [EmbeddedControl] (20230628/evregion-130)
> 
> This happens because if there is no ECDT, the EC driver only registers
> the EC address space handler for operation regions defined in the EC
> device scope of the ACPI namespace while the operation region being
> accessed by the _DSM in question is located beyond that scope.
> 
> To address this, modify the ACPI EC driver to install the EC address
> space handler at the root of the ACPI namespace for the first EC that
> can be found regardless of whether or not an ECDT is present.
> 
> Note that this change is consistent with some examples in the ACPI
> specification in which EC operation regions located outside the EC
> device scope are used (for example, see Section 9.17.15 in ACPI 6.5),
> so the current behavior of the EC driver is arguably questionable.

...

> -		status = acpi_install_address_space_handler_no_reg(ec->handle,
> +		status = acpi_install_address_space_handler_no_reg(scope_handle,
>  								   ACPI_ADR_SPACE_EC,
>  								   &acpi_ec_space_handler,
>  								   NULL, ec);

Looking at this...

>  		if (ACPI_FAILURE(acpi_remove_address_space_handler(
> +						scope_handle,
> +						ACPI_ADR_SPACE_EC,
> +						&acpi_ec_space_handler)))

...and this, I believe you can move scope_handle to the previous line and align
the rest for the sake of consistency and slightly better readability.

-- 
With Best Regards,
Andy Shevchenko



