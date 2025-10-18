Return-Path: <linux-acpi+bounces-17950-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B7FD2BEDA6E
	for <lists+linux-acpi@lfdr.de>; Sat, 18 Oct 2025 21:29:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 51B9D19C1DDC
	for <lists+linux-acpi@lfdr.de>; Sat, 18 Oct 2025 19:29:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 888142638BF;
	Sat, 18 Oct 2025 19:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZTkFSwGR"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD4AD1D618C;
	Sat, 18 Oct 2025 19:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760815756; cv=none; b=aJlSczgNm8J/5tIBtSNNNzNN6mjzWbMhROjkCa54+G6hvnOicSHa5ds1MZ2B4FQZdZtzhZ+d7c7x9iTdlhJAo/HFmXaHKha0L2TrnP0RC4Ab42SxeW1wFL0zLIPFwqrJa0Zd9NsAFvNJZgxP1XEepraNwIfKmn1Z/GYvegEqSLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760815756; c=relaxed/simple;
	bh=F4LIk+jkm6W3jPjl02rMXdfHGcgnHt5kO4c3gZniHPs=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=chMuB+SX1B/kHwM/5jqrEu40n52+Yjf4SH/UfuBkDbb1cAec22jIHtz43wNKM7U1mOTFjS4zHXCV5AfmmlFOEuBf3lEJNElPHpQ9arZE1k8aEIfPbX/ZXBx6i5M8VGE/ic7y5K7lgKCvkBstZzz5H9HGlYd6/q6aKAAfKFL/JwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZTkFSwGR; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760815756; x=1792351756;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=F4LIk+jkm6W3jPjl02rMXdfHGcgnHt5kO4c3gZniHPs=;
  b=ZTkFSwGRrB8OtXj06o9hqeUqQhqjKys7oTHBwXxuGL/a/SBQDfmOH7V1
   HC4lWtiqui2JzfbKeWRcjAQ9ZLiV163PdcLdfaghfmzgz8khQ928RiErb
   u7eJjjWwP6x4TrqXy6MzxpESISmreH6jMnhu2Aifsd7DnndQCD+fVlkgD
   Q++tmIPrk2Jkp5ks0J7ml8T+dsYT82RaCQg0A/WyZluuaRaGmA+d8+wYx
   X2hwDmVqYg6WOdMIhh3IayB/co6IN+6+3xDuGzd2czpO9WipRVCIBYp3f
   SYb8jKuz/FY7skRrr8ZxJfwRnMDJ/R+ZW2soq3+aPlPCf8TlNMOQpMhaX
   w==;
X-CSE-ConnectionGUID: GGMrRYadSOaa3aZWsFPidw==
X-CSE-MsgGUID: K7itmjRmQVmGqLSyj2xvVg==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="62914992"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="62914992"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2025 12:29:15 -0700
X-CSE-ConnectionGUID: cWemEssqRnOJ4cNJ38TGCA==
X-CSE-MsgGUID: +cyA2ftIQuSg4VdjQFp5wA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,239,1754982000"; 
   d="scan'208";a="213969835"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO ashevche-desk.local) ([10.245.244.194])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2025 12:29:11 -0700
Received: from andy by ashevche-desk.local with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1vACc0-00000000xXh-1YTV;
	Sat, 18 Oct 2025 22:29:08 +0300
Date: Sat, 18 Oct 2025 22:29:08 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Linus Walleij <linus.walleij@linaro.org>,
	Daniel Scally <djrscally@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Krzysztof Kozlowski <krzk@kernel.org>, linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH 2/9] software node: increase the reference of the swnode
 by its fwnode
Message-ID: <aPPqhI7KQMnidFc5@ashevche-desk.local>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Oct 06, 2025 at 03:00:17PM +0200, Bartosz Golaszewski wrote:
> 
> Once we allow software nodes to reference other kinds of firmware nodes,
> the node in args will no longer necessarily be a software node so bump
> its reference count using its fwnode interface.

Same remark, add a comment or expand a kernel doc, if exists, to cover this nuance.

-- 
With Best Regards,
Andy Shevchenko



