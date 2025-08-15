Return-Path: <linux-acpi+bounces-15722-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DC0CFB27959
	for <lists+linux-acpi@lfdr.de>; Fri, 15 Aug 2025 08:45:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9DC2CA03571
	for <lists+linux-acpi@lfdr.de>; Fri, 15 Aug 2025 06:45:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 433762C21E3;
	Fri, 15 Aug 2025 06:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fBCjPZQF"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9524F2C15BD;
	Fri, 15 Aug 2025 06:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755240322; cv=none; b=W3L4CWac5JdIdfc0ZBkzkHwwnrwf84SD0u1KuifLhZ/+ZJ/rMBHk7xPFZCGQVtEHNcKopUBiiKfhkoJv3Z0BY7RIjN1NbiZ60LVnzpthSD990msYAs4bi67KqjK+Yk2zH11rzVKOQb359G1DQ1fOz+tSRdiZKCHi9eg9S75kd4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755240322; c=relaxed/simple;
	bh=MYE1I+Y9r0/NPl4ub3Lc0QdIr5DN1sM52jISYOoZgQ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W1G0uH1yTkGDrPvPzVioALRXy/wqnRaeoLeaBPQaFzv/eItgrL4nSlG9Qy1FOjZPiwU/1NwHNi6z3Xozlcv8EMF2qVCWGuvZa8TB5QyH3jVt4eR6ppq9Vi+xETuv+/wP41OGSOjbMtpBXEq21qnJUzIohso9UQUMSwhFDJT8Zck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fBCjPZQF; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755240321; x=1786776321;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=MYE1I+Y9r0/NPl4ub3Lc0QdIr5DN1sM52jISYOoZgQ8=;
  b=fBCjPZQFDzBUP9S/olEEeBf93BPu9ue20aChtkXGvvGKKIcywwS2C5VI
   x8LlmXvEI7AQ9AB/pGw/2r6z67j6M/XdMivCVhrs0Af+ok3f/fnTU2WAf
   qo0iKxNXiEf9cETcsacRwirr4nisqxSeNDQBop2bkjJd7vio4nGVCmpt4
   /PzXVuUcEcoOOG++6ODBx5MvKC16oPTIY3Sq8cT8GW0PEIad23J/7ec+N
   dUoPrHIBf5CdEpGQyKUb1LvZBdDdV+nSIuR2VNWJavFteuwBwxfBgliQZ
   c9HeWd6GglfYbIKwlX2vmix7KInEYfMDT8eqfN8Ee20O+KSmznZgybDLN
   Q==;
X-CSE-ConnectionGUID: 8S83+e1vSfuQDn4jKnsVYA==
X-CSE-MsgGUID: a7sx3pHjSW2BjG/b+xC3Pw==
X-IronPort-AV: E=McAfee;i="6800,10657,11522"; a="56773545"
X-IronPort-AV: E=Sophos;i="6.17,290,1747724400"; 
   d="scan'208";a="56773545"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2025 23:45:20 -0700
X-CSE-ConnectionGUID: IpXSybBiR4+pZHXhKcMuFw==
X-CSE-MsgGUID: mrygeseET7+TlHGeWlM+Hw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,290,1747724400"; 
   d="scan'208";a="166868987"
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa006.fm.intel.com with ESMTP; 14 Aug 2025 23:45:17 -0700
Received: by black.igk.intel.com (Postfix, from userid 1001)
	id 8EC2693; Fri, 15 Aug 2025 08:45:16 +0200 (CEST)
Date: Fri, 15 Aug 2025 08:45:16 +0200
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: "Mario Limonciello (AMD)" <superm1@kernel.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Mika Westerberg <westeri@kernel.org>,
	"open list:GPIO ACPI SUPPORT" <linux-gpio@vger.kernel.org>,
	"open list:GPIO ACPI SUPPORT" <linux-acpi@vger.kernel.org>,
	"open list:INPUT (KEYBOARD, MOUSE, JOYSTICK, TOUCHSCREEN)..." <linux-input@vger.kernel.org>,
	Amit Chaudhari <amitchaudhari@mac.com>
Subject: Re: [PATCH 1/2] gpiolib: acpi: Add quirk for ASUS ProArt PX13
Message-ID: <20250815064516.GG476609@black.igk.intel.com>
References: <20250814183430.3887973-1-superm1@kernel.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250814183430.3887973-1-superm1@kernel.org>

On Thu, Aug 14, 2025 at 01:34:29PM -0500, Mario Limonciello (AMD) wrote:
> The ASUS ProArt PX13 has a spurious wakeup event from the touchpad
> a few moments after entering hardware sleep.  This can be avoided
> by preventing the touchpad from being a wake source.
> 
> Add to the wakeup ignore list.
> 
> Reported-by: Amit Chaudhari <amitchaudhari@mac.com>
> Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/4482
> Tested-by: Amit Chaudhari <amitchaudhari@mac.com>
> Signed-off-by: Mario Limonciello (AMD) <superm1@kernel.org>

Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>

