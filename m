Return-Path: <linux-acpi+bounces-11080-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F580A31E45
	for <lists+linux-acpi@lfdr.de>; Wed, 12 Feb 2025 06:52:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 138617A3241
	for <lists+linux-acpi@lfdr.de>; Wed, 12 Feb 2025 05:51:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F310D1FBEA6;
	Wed, 12 Feb 2025 05:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="H2BIC3GF"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 267D71FBEA1;
	Wed, 12 Feb 2025 05:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739339485; cv=none; b=M8qoV+/HmO+eDpMyTvuDUqJ5PqSAhH9wKbDza+imjuCizb4tf5O2WglifmrcXxfBKyQ2hsaU57bC3ji86IQabVtirCjT5idH3jTUfw1xJIuzIsxqIb2kD75ouswbr1Un52BTrCfKel1rrGemscmy6DXMVhqJb9rKNXXlGjH7ZRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739339485; c=relaxed/simple;
	bh=WiPSLwyekIgOvheGbxfgpUahDc4J1nc6fcB/ziPf8v0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XL2BJu29soE6DTdew2jIZaIq+t4UlLMlxZUJ9TTQ43x0Dttu+T7I2agGWKJKcfSRdpPjSzlibguG7o14pkOaOe6vH5cgHm8HgJKZZAFCDyERRs+KKI3Sx7dO+6LooWUB3lzk3qWliwRkOcDtF3/4L2s5PmsRgUn5S4jJU9IB/60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=H2BIC3GF; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739339484; x=1770875484;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=WiPSLwyekIgOvheGbxfgpUahDc4J1nc6fcB/ziPf8v0=;
  b=H2BIC3GFu8sF5/2XvfGfFxAvJoYHmfrH9h2HNeS5xKAV6VqzSF5EDdSE
   +7tu2A0eZh3ltomKB8XG3kYIXSUXtV6jD6b/dZ5aDEZpfBYw/Q++aGr05
   QD9zNRm++wElldtVJZ0jNP6Qgb9BbsmW90esennHL479SbVFifSgBiDTv
   fHewChxDRer+gWgyhdyJnWsfhtCEEoLz81pyVCYmLMIbKViqXJiI1M2Zz
   UHf1qNEg20xfr7N5BRwsZD/3J+GurgVhIosOp4OvmzNWWQy4SmTVXjA08
   tqfys1DNO0ORmPSRJ1GbyVAWCeXNzkwDZw8R4MUUtNeltWPXNRJnT2s4H
   A==;
X-CSE-ConnectionGUID: ojnAq7mYRZSen9h5yghPcw==
X-CSE-MsgGUID: /xWg67i9Q/qNr3V5BSeE+w==
X-IronPort-AV: E=McAfee;i="6700,10204,11342"; a="27581221"
X-IronPort-AV: E=Sophos;i="6.13,279,1732608000"; 
   d="scan'208";a="27581221"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2025 21:51:23 -0800
X-CSE-ConnectionGUID: CkI2eLKMRT2JNmxPWLfk2g==
X-CSE-MsgGUID: 4nB4NpbVRmmV7UheVQJo0A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,279,1732608000"; 
   d="scan'208";a="112552560"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa006.fm.intel.com with ESMTP; 11 Feb 2025 21:51:21 -0800
Received: by black.fi.intel.com (Postfix, from userid 1001)
	id D71C011E; Wed, 12 Feb 2025 07:51:19 +0200 (EET)
Date: Wed, 12 Feb 2025 07:51:19 +0200
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Mario Limonciello <superm1@kernel.org>
Cc: mario.limonciello@amd.com, westeri@kernel.org,
	andriy.shevchenko@linux.intel.com, linus.walleij@linaro.org,
	brgl@bgdev.pl, stable@vger.kernel.org, Delgan <delgan.py@gmail.com>,
	linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org
Subject: Re: [PATCH] gpiolib: acpi: Add a quirk for Acer Nitro ANV14
Message-ID: <20250212055119.GB3713119@black.fi.intel.com>
References: <20250211203222.761206-1-superm1@kernel.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250211203222.761206-1-superm1@kernel.org>

On Tue, Feb 11, 2025 at 02:32:01PM -0600, Mario Limonciello wrote:
> From: Mario Limonciello <mario.limonciello@amd.com>
> 
> Spurious immediate wake up events are reported on Acer Nitro ANV14. GPIO 11 is
> specified as an edge triggered input and also a wake source but this pin is
> supposed to be an output pin for an LED, so it's effectively floating.
> 
> Block the interrupt from getting set up for this GPIO on this device.
> 
> Cc: stable@vger.kernel.org
> Reported-and-tested-by: Delgan <delgan.py@gmail.com>
> Close: https://gitlab.freedesktop.org/drm/amd/-/issues/3954
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>

Acked-by: Mika Westerberg <westeri@kernel.org>

