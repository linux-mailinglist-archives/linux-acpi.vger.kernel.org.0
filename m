Return-Path: <linux-acpi+bounces-17219-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83393B94777
	for <lists+linux-acpi@lfdr.de>; Tue, 23 Sep 2025 07:45:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 551D2178A9C
	for <lists+linux-acpi@lfdr.de>; Tue, 23 Sep 2025 05:45:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24DB030F7F7;
	Tue, 23 Sep 2025 05:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SJsd3mIb"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C31A30EF84
	for <linux-acpi@vger.kernel.org>; Tue, 23 Sep 2025 05:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758606228; cv=none; b=bcEiYjOT0RV977IZ3BmoJEMsWAXQ72Q7MMK9w20KreX4Skes/f/Z658W4CdV8sahr8YNynwoVT+FwwC9bepLynuLtjM8a6WRiC5tWtYI3oYdxcFPQHf2tHALpvfDCXqgNVVTsDgI3Yj3Lcv/KO1zMrN9sZqQbVDJN5SeGDAbamQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758606228; c=relaxed/simple;
	bh=q4dqYEoDEdhAavVi8Cqa993KVwZCS3psbAUq/Ruamcs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bOWg9hYq5myvUbX1/MRKeTmC/8j7nby43rwIM48TXK1jpQ5W75TTv4lpgvlPLIWseoIKeKAa9JMOTFuFJb/nWRJhW5T5zatVKwEQ9GAUnG4QRNQNDqT71vkIQixRq1KZdVGXZL+DE6cQC+czGJIcolenoVYA+qW1BpxMUOQ02zw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SJsd3mIb; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758606227; x=1790142227;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=q4dqYEoDEdhAavVi8Cqa993KVwZCS3psbAUq/Ruamcs=;
  b=SJsd3mIb4My+exgcuQ9aUDsx4SfRuhyXW5ow6O37H3RUvDptqDqyjGtB
   FE/CWW4bxT+QrZkzGDlDRSgGgmU06DnOGw7scj0kjYMvwcfuTVzKFFJ3v
   iGBLXnqKiQP6c3dOsr63EtCrvIOBq9q0iQIxsQFK7/KGARnAgSSSjdfhl
   DoZL2JOxN3DvvuLhLidlp6FMTxZ7WEQ2hki78DK/p3ph1xbupI2e0kR9E
   882ftwhZvAW8sAKA/bBILtKAIE8R9d9fNaPbydBNtcNjsO9FMuCC/AzrN
   dYDvhnQV7tmw9djHG24LomMktoS/EebLfcmMRaWVizi6M9AJm2DHRV1sb
   Q==;
X-CSE-ConnectionGUID: uILJHCA2Tciy8r+nT1Ysew==
X-CSE-MsgGUID: y3EX6MFvSmi0gqFzUbmWrQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="64682463"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="64682463"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2025 22:43:46 -0700
X-CSE-ConnectionGUID: YfOwWWFrTLeeab1ocJJ+kw==
X-CSE-MsgGUID: p7p+WIoDSXykCffcYwuGvg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,287,1751266800"; 
   d="scan'208";a="213835837"
Received: from smile.fi.intel.com ([10.237.72.51])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2025 22:43:43 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1v0voT-00000005Ns5-0gzC;
	Tue, 23 Sep 2025 08:43:41 +0300
Date: Tue, 23 Sep 2025 08:43:40 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: linux-acpi@vger.kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>, Daniel Scally <djrscally@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Danilo Krummrich <dakr@kernel.org>
Subject: Re: [PATCH 07/14] driver core: Use fwnode_for_each_child_node()
 instead
Message-ID: <aNIzjHAGbHiAXgOC@smile.fi.intel.com>
References: <20250916160129.3955410-1-sakari.ailus@linux.intel.com>
 <20250916160129.3955410-8-sakari.ailus@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250916160129.3955410-8-sakari.ailus@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Sep 16, 2025 at 07:01:22PM +0300, Sakari Ailus wrote:
> fwnode_for_each_child_node() is now the same as
> fwnode_for_each_available_child_node() on all backends (OF, ACPI and
> swnode). In order to remove the available variants, switch the uses to
> non-available variants.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

-- 
With Best Regards,
Andy Shevchenko



