Return-Path: <linux-acpi+bounces-14748-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61FB7AEA715
	for <lists+linux-acpi@lfdr.de>; Thu, 26 Jun 2025 21:43:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 54A9B3BEB8F
	for <lists+linux-acpi@lfdr.de>; Thu, 26 Jun 2025 19:41:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9512C2F2344;
	Thu, 26 Jun 2025 19:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FUW7W0U5"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 143312F0C57;
	Thu, 26 Jun 2025 19:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750966675; cv=none; b=X7kwiikSreuaTyAyIvg1XL/ZBYA4y4Gi0CzuXyEzy/CYje5Jk29UESNGAQfuqVYf3gfSbP2Fg1VVDUMUwWRGJyUSsjKykFt8M03R85zmJbvwqD7PzEJxIhnweSpZWzWCzSi96TlPHiFB+iB6Xop8vwIrMv3Z5P++Xr5M9RcwmrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750966675; c=relaxed/simple;
	bh=/l8zD1E5pieTO6zRx0WY8HgKTDqPjhK81dadYrxqSEI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NNBGfNBtR1E738uJjBTjOhOHv3AwyCgeKfUlVvZw+30w4UT7xiaLoxfhgee3PPHhup1G6Dn/FA7/KNnHspBVaZg30P5YCWPNRsecZWA/OONruJ4WiF/sB1DpLoD/bH07dV6olWgRNcJu5ApAXB7AgMOVypV/1im8J8Bf3nXPoCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FUW7W0U5; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750966675; x=1782502675;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=/l8zD1E5pieTO6zRx0WY8HgKTDqPjhK81dadYrxqSEI=;
  b=FUW7W0U5JsJvE51hhzEWPMwKAznhgsOzXLtNQoCfXX2SmWiN5ApeQio/
   7udqbvtq9O+DyhsEMJ5y3pq3qN86wWT55zy90k1y7jpCWLj99KOni2Vaq
   DOGFIIvFSfel8K8ccxagoy6hcq6TBWEcjt7LqYSGc0mfevqO3yEMH8F92
   8RVLxNqpqawCPvOG89hXXGWwXySyHBYKHeNdl7D7+5WQ9gohp80JbSh4o
   iLoTFK+tk93gWjBQWrdt0xcSmRY8Ida5oCuZ2QDrJIQyNW2rXgdjLucRT
   jTnOb/b8RRNM/h8g1uVlluIuBCF5WM9oKyIssxmcs943VlNesqR8nsaZ0
   A==;
X-CSE-ConnectionGUID: C318PTx0SaOCngelqo2n1A==
X-CSE-MsgGUID: xpsUYR2cSjaW9F6OWZxEnw==
X-IronPort-AV: E=McAfee;i="6800,10657,11476"; a="53241251"
X-IronPort-AV: E=Sophos;i="6.16,268,1744095600"; 
   d="scan'208";a="53241251"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2025 12:37:54 -0700
X-CSE-ConnectionGUID: cxiJiHnNR96mlENndFKEQg==
X-CSE-MsgGUID: Mx4Ck3xcTuWHMQ+1TSGLPw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,268,1744095600"; 
   d="scan'208";a="158346011"
Received: from smile.fi.intel.com ([10.237.72.52])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2025 12:37:51 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1uUsPr-0000000AGs2-3YEo;
	Thu, 26 Jun 2025 22:37:47 +0300
Date: Thu, 26 Jun 2025 22:37:47 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Mario Limonciello <superm1@kernel.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Hans de Goede <hansg@kernel.org>,
	Mika Westerberg <westeri@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	"open list:GPIO ACPI SUPPORT" <linux-gpio@vger.kernel.org>,
	"open list:GPIO ACPI SUPPORT" <linux-acpi@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:INPUT (KEYBOARD, MOUSE, JOYSTICK, TOUCHSCREEN)..." <linux-input@vger.kernel.org>,
	Mario Limonciello <mario.limonciello@amd.com>
Subject: Re: [PATCH v3 4/4] Input: Don't send fake button presses to wake
 system
Message-ID: <aF2hi1q2QK6LAKIW@smile.fi.intel.com>
References: <20250625215813.3477840-1-superm1@kernel.org>
 <20250625215813.3477840-5-superm1@kernel.org>
 <710f7c04-0099-4611-b2ea-4dd4219ad5e2@kernel.org>
 <23f30094-68cc-47fe-86e0-5289cb41e940@kernel.org>
 <rn2kp5tog2agvswva2ipqq2ytiqdcgccnocudsg6ckwfh4roei@provk2g6dita>
 <363c2b92-4bfc-4537-9fca-025eef09526f@kernel.org>
 <nxticocp26r5mmpkttritw76h5igw7bdpus6zaf5krkso2h5xy@wna6m2quekfi>
 <cbbf0caf-82ce-4427-9844-b11e0f5cacdb@kernel.org>
 <obpakvzyludc4jskqzyxf65dhqds7ie3jkbfsqdve32ouuaili@xvogkmwvbmbf>
 <bf97081a-e766-405e-9385-3657135b8c0f@kernel.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bf97081a-e766-405e-9385-3657135b8c0f@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Jun 26, 2025 at 01:55:29PM -0500, Mario Limonciello wrote:

Mario, I see that this discussion takes longer than expected, however I agree
that adding debounce call in GPIO ACPI lib is right thing to do independently
on the outcome of this discussion. So, I have looked into the code and think
that the patches do not need to be squashed. I have some tweaks and I would
like to take your patches as two separate entities and add my code on top.
I will cook something tomorrow and send out based on this version of yours.

P.S. TWIMC, It's only about the code that touches gpiolib-acpi.

-- 
With Best Regards,
Andy Shevchenko



