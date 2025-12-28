Return-Path: <linux-acpi+bounces-19876-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A9FECE571B
	for <lists+linux-acpi@lfdr.de>; Sun, 28 Dec 2025 21:19:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3A8DC3003FA6
	for <lists+linux-acpi@lfdr.de>; Sun, 28 Dec 2025 20:19:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05D7F242D98;
	Sun, 28 Dec 2025 20:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XT6nrZMY"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2562923A99F;
	Sun, 28 Dec 2025 20:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766953145; cv=none; b=Z0rX9UkGRV0kAC9s25WHuRpDKdnMTJ0FByYePagJW6j6mrP0NgyJ5BtWwwNRXmIDpHeX3fpG2cu9Ay0BzS+zHQHBkettpM8Lesg+VcfjRaWgFuWKYYBbk27wVLm58tfZvNGUgEI54m9AQlwnIJbocg/W4vur362lJx4cLM8lZm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766953145; c=relaxed/simple;
	bh=8t5lrEHLVXdzxCQ7lbdjPuFbDrZOVrVoUrHfuWRs5yg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PPqH65yyB06YE2i4u/YBTcEa9mHHzdMWUfjinIL2l1ZT1ntuby+sq61xSCsneNIlY7KJe+WFljmaEQ/Cdf38J+78KvCFj21xNqK04Tyzbckz1RjbXVriSfCwubgNM+UoIpwhe8FYdG5XQ+A6zKPHPHF+a7+xJeMtfu0sZ5HwKrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XT6nrZMY; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1766953145; x=1798489145;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=8t5lrEHLVXdzxCQ7lbdjPuFbDrZOVrVoUrHfuWRs5yg=;
  b=XT6nrZMYsVh2jfy+Ned0xIAwcAh8GOpJGewzC8JnLzpVSeGRW7i1yR6b
   Nk+Vlf3SIjToZITAXsWmq4ug1lM5lAerI79DIzIngXeVpr0FgfEfRhITg
   WxdN+kJtQZkDc+FADuSYFvj951MTYFMhBmpyUdoMfJOT5L2jDrg1lHAz+
   aTDqYWTrJex7e/pATYWdc9+rwpxGAf9n5Dpj2sfsjb2VKKSXHHpFo9rZ1
   mwCU0TdOZu1/IoPPyxMAmVGTjp6eMfHkltoKr+gXKzfETY5PXTChXZ8MG
   O8xIctoSLZnPN3kI3Je+JFbaj7+2zj73tPwAZdLDlgOlzkOIeCKc9j3ye
   Q==;
X-CSE-ConnectionGUID: TBnl3K7iTuqXMasaaFlG3g==
X-CSE-MsgGUID: Wng9veUISueXmrrisvBhFg==
X-IronPort-AV: E=McAfee;i="6800,10657,11655"; a="72208065"
X-IronPort-AV: E=Sophos;i="6.21,184,1763452800"; 
   d="scan'208";a="72208065"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Dec 2025 12:19:04 -0800
X-CSE-ConnectionGUID: IFXlJILpR+2tr84QElvJFw==
X-CSE-MsgGUID: uWSz9DOCQku6xn4ZE3vU8Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,184,1763452800"; 
   d="scan'208";a="238186925"
Received: from abityuts-desk.ger.corp.intel.com (HELO localhost) ([10.245.244.236])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Dec 2025 12:19:03 -0800
Date: Sun, 28 Dec 2025 22:19:00 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linux ACPI <linux-acpi@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Hans de Goede <hansg@kernel.org>
Subject: Re: [PATCH v1] ACPI: sysfs: Add device cid attribute for exposing
 _CID lists
Message-ID: <aVGQtNsm0hDgRR0m@smile.fi.intel.com>
References: <2812426.mvXUDI8C0e@rafael.j.wysocki>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2812426.mvXUDI8C0e@rafael.j.wysocki>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Dec 12, 2025 at 09:52:44PM +0100, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Add a new sysfs attribute called "cid" under struct acpi_device for
> exposing the list of compatible device IDs returned by the device's
> _CID object, if present.
> 
> The new attribute will be present only if the _CID object is present.

...

> +static ssize_t cid_show(struct device *dev, struct device_attribute *attr,
> +			char *buf)
> +{
> +	struct acpi_device *acpi_dev = to_acpi_device(dev);
> +	struct acpi_device_info *info = NULL;
> +	ssize_t len = 0;
> +
> +	acpi_get_object_info(acpi_dev->handle, &info);
> +	if (!info)
> +		return 0;
> +
> +	if (info->valid & ACPI_VALID_CID) {
> +		struct acpi_pnp_device_id_list *cid_list = &info->compatible_id_list;
> +		int i;
> +
> +		for (i = 0; i < cid_list->count - 1; i++)
> +			len += sysfs_emit(buf, "%s,", cid_list->ids[i].string);
> +
> +		len += sysfs_emit(buf, "%s\n", cid_list->ids[i].string);

You definitely meant to use sysfs_emit_at().

> +	}
> +
> +	kfree(info);
> +
> +	return len;
> +}
> +static DEVICE_ATTR_RO(cid);

Do wee have any ABI documentation for these sysfs attributes?
If so, it needs to be updated, otherwise perhaps create one?

-- 
With Best Regards,
Andy Shevchenko



