Return-Path: <linux-acpi+bounces-17953-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B3043BEDAE0
	for <lists+linux-acpi@lfdr.de>; Sat, 18 Oct 2025 21:42:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 688E6588074
	for <lists+linux-acpi@lfdr.de>; Sat, 18 Oct 2025 19:42:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4BF627B4EB;
	Sat, 18 Oct 2025 19:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="e7xpRtMr"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4F60258CD7
	for <linux-acpi@vger.kernel.org>; Sat, 18 Oct 2025 19:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760816525; cv=none; b=CiL3HpGqFb3Wi8zrA9+B3gqF6EZQx+Kgv7x4ei+2mmVOLMr7UtfV+MIylLdme5HNLW2NdLoyW6Vb0dAc+qXd6IjqYreBrWFo/L6u1nCuEDEvW0Kz6jLK/FIyBwku9HQDLHNizvZHRwfPgBtBWVW/g2sRTIqo9yYtJ0Bgt8GedF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760816525; c=relaxed/simple;
	bh=idEEexIy0jcU5hGyyRkh1rB4xxTSnD9JShQTbt6rlsU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BHa/bxQOOdGVxX17YZZk5XcGx0HDecElJa45Y9txprnYkSQ5jfM7hFpI35JMn9LxUk2X5b/doMZe+iUMaJAvH6cLNbFPr/Lzn9bUJaXtlSrOwBsZaWxrg6niNHrZ2YXP2kPwKM7QmhbBQq6l3MJNJ2aNzHPCGsUx2T0jdjCAsoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=e7xpRtMr; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760816524; x=1792352524;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=idEEexIy0jcU5hGyyRkh1rB4xxTSnD9JShQTbt6rlsU=;
  b=e7xpRtMr1faW6bPvDUAQad9kefx5ym+TDaVKk3gutY1fDSWiWFEstXXj
   U2UwTmPlSPyUixtaY4g7Sy6+6FNfHUYgLle59DZVQt7iuuV6W9/s7Wdow
   a0gxRE6vRxhNzN5/PUFWDzIa3sGbrGYJ6RNO2wt7BsyQxlpLQ8YBAWxGf
   4g47EX8cSRrjYXKu5kfN0nn0RTLJIcUZbkSuOZuECDkLoch/ZEW/ajKgJ
   hvmfWNnewULg4pazpUJrhSzQUVM5gUxr3m4d2wjL67GsM3LYN+4nK+NwG
   ZzCUB9caJg7iyqTyFTp8li5rk2O9IRNz1qqxVBdQ64+UFFDnd/rappZua
   g==;
X-CSE-ConnectionGUID: Jn+XnwbtT1mfSUM2X6tvqw==
X-CSE-MsgGUID: bdHmzBj8T36ROQ6+SJh8uA==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="74437554"
X-IronPort-AV: E=Sophos;i="6.19,239,1754982000"; 
   d="scan'208";a="74437554"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2025 12:42:03 -0700
X-CSE-ConnectionGUID: YA8YdIizRFyi5RLQXCL0dw==
X-CSE-MsgGUID: hUwmKGetTIyPA5+ctSJ5yQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,239,1754982000"; 
   d="scan'208";a="183487036"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO ashevche-desk.local) ([10.245.244.194])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2025 12:42:01 -0700
Received: from andy by ashevche-desk.local with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1vACoQ-00000000xhj-39e1;
	Sat, 18 Oct 2025 22:41:58 +0300
Date: Sat, 18 Oct 2025 22:41:58 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Jonas Gorski <jonas.gorski@gmail.com>
Cc: linux-acpi@vger.kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: i2c-mux ACPI parent device references in example
Message-ID: <aPPthnO3bKFhTN3A@ashevche-desk.local>
References: <48d0fb45-096c-4caa-b51c-753c2f17f018@gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <48d0fb45-096c-4caa-b51c-753c2f17f018@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Oct 08, 2025 at 11:14:37AM +0200, Jonas Gorski wrote:
> Hi,
> 
> I'm currently trying to wrap my head around describing devices via SSDT.
> 
> While reading Documentation/firmware-guide/acpi/i2c-muxes.rst, the
> references used for the devices behind the mux confuse me a bit.
> 
> The tree from the example is:
> 
>     Device (SMB1)
>     {
>         Device (MUX0)
>         {
>             Device (CH00)
>             {
>                 Device (CLIA)
>                 {
>                     Name (_CRS, ResourceTemplate () {
>                         I2cSerialBus (0x50, ControllerInitiated, I2C_SPEED,
>                                     AddressingMode7Bit, "\\_SB.SMB1.CH00", 0x00,
>                                     ResourceConsumer,,)
>                     }
>                 }
>             }
> 
>             Device (CH01)
>             {
>                 Device (CLIB)
>                 {
>                     Name (_CRS, ResourceTemplate () {
>                         I2cSerialBus (0x50, ControllerInitiated, I2C_SPEED,
>                                     AddressingMode7Bit, "\\_SB.SMB1.CH01", 0x00,
>                                     ResourceConsumer,,)
>                     }
>                 }
>             }
>         }
>     }
> 
> 
> Is there a ".MUX0" missing in the references, or is it correct that it is not
> present?
> 
> E.g. should it be "\\_SB.SMB1.MUX0.CH00" instead of "\\_SB.SMB1.CH00"?
> 
> FWIW, the references were changed from relative to absolute in e65cb011349e
> ("Documentation: ACPI: Fix parent device references").

Oh, seems to me like a miss from my side. Thanks for a good catch!
Can you send a formal fix patch?

-- 
With Best Regards,
Andy Shevchenko



