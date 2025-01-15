Return-Path: <linux-acpi+bounces-10668-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A27A0A11AD4
	for <lists+linux-acpi@lfdr.de>; Wed, 15 Jan 2025 08:23:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD346188842E
	for <lists+linux-acpi@lfdr.de>; Wed, 15 Jan 2025 07:23:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72CD41DB12B;
	Wed, 15 Jan 2025 07:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cz3wv406"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3E816AA1;
	Wed, 15 Jan 2025 07:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736925794; cv=none; b=Xcd/zQFaVueE61T8nx6h89i/01+2MYY2zkOPkerBkGBfubMDoyOBLGvAMp8r+Yo+tq/euZkW8qtjOrvGMIG5NtKHK5ivU84Iw7HLIXWDp6CnDA5jm7p4HPdabkswyQK4rMVTy+sc9EDTNapeHd8cjI2zQiR+ZmMOyUIbAws+iyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736925794; c=relaxed/simple;
	bh=B4Ril12uBwyFI07ASKOTFLTaZFboKxElHYnBAkXG3wg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=edrAgZzqUAwVtGhHV6kp/uEgxIiiXXpmEPgfbWt4Z8mLv09j9BjimNsrVy114q4cKuN1Fr9N2dBj4mUT6OxRzSQeeakVkMpTNtT2NgDMYiW0dDNub8xJygiCLcw4i5rn+1ayfxTIqm6AfddxvkkjyVzrWf+3J80RRf6NZOsQAu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cz3wv406; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736925793; x=1768461793;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=B4Ril12uBwyFI07ASKOTFLTaZFboKxElHYnBAkXG3wg=;
  b=cz3wv4060j77lotMho5tWpIvZn6SVQiYB5p+LVU7R3FcRZT0SPoEeiGf
   QyqR8k+qHJlDthR4A3BhRDBegIAFHesKbFym96in892bgp91JOAfqPlRy
   nHEcGRFrCDKcH0t7DKToylzlfNC3mmvoX735y3IoyCpKCQ3ysaOO/CN+5
   k0tKOfmO6Sq/oKHYXg8fbeFst0zA/ZaC4yu5fnruGzbbRHRxXdvQS3OZU
   cBK1ZplmHKHA5Gb94LjvsaDq/ST4y2kf0AQrWRBkDlsP1b12d3gC867/A
   6wgZyPpZX4jJmVslf6xPLUlhjjywunxZyBoZuB6TZR2JTEHMrXif04OHl
   A==;
X-CSE-ConnectionGUID: yUW8/mUZSOCe+4XfKRzpNQ==
X-CSE-MsgGUID: 7EDwdNzFS6uVrA42mvBYew==
X-IronPort-AV: E=McAfee;i="6700,10204,11315"; a="41011429"
X-IronPort-AV: E=Sophos;i="6.12,316,1728975600"; 
   d="scan'208";a="41011429"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2025 23:23:12 -0800
X-CSE-ConnectionGUID: AUyMUMZbSXulfnbuMXz7cA==
X-CSE-MsgGUID: 0lTouJH/T5aP8LUU62H7YQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="105531792"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2025 23:23:09 -0800
Received: from kekkonen.localdomain (localhost [127.0.0.1])
	by kekkonen.fi.intel.com (Postfix) with SMTP id 3D23611F8B3;
	Wed, 15 Jan 2025 09:23:06 +0200 (EET)
Date: Wed, 15 Jan 2025 07:23:06 +0000
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Daniel Scally <djrscally@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Saravana Kannan <saravanak@google.com>, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 1/2] device property: Split property reading bool and
 presence test ops
Message-ID: <Z4diWj--mEX6YsrI@kekkonen.localdomain>
References: <20250109-dt-type-warnings-v1-0-0150e32e716c@kernel.org>
 <20250109-dt-type-warnings-v1-1-0150e32e716c@kernel.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250109-dt-type-warnings-v1-1-0150e32e716c@kernel.org>

On Thu, Jan 09, 2025 at 01:42:05PM -0600, Rob Herring (Arm) wrote:
> The fwnode/device property API currently implement
> (fwnode|device)_property_read_bool() with (fwnode|device)_property_present().
> That does not allow having different behavior depending on the backend.
> 
> Specifically, the usage of (fwnode|device)_property_read_bool() on
> non-boolean properties is deprecated on DT. In order to add a warning
> on this deprecated use, these 2 APIs need separate ops for the backend.
> 
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>

Thanks!

Reviewed-by: Sakari Ailus <sakari.ailus@linux.intel.com>

-- 
Sakari Ailus

