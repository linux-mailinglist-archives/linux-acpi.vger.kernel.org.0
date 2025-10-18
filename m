Return-Path: <linux-acpi+bounces-17948-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 71155BED896
	for <lists+linux-acpi@lfdr.de>; Sat, 18 Oct 2025 21:15:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2AB463AFF01
	for <lists+linux-acpi@lfdr.de>; Sat, 18 Oct 2025 19:15:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42E0A28689F;
	Sat, 18 Oct 2025 19:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Qg1v2T9j"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39A47284884;
	Sat, 18 Oct 2025 19:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760814915; cv=none; b=um+cZj/Q33YOVb5hvqannQ6jsH4p6SWPpLh/HR4fNTDwLmzKokXZJh0aJwSS1bwqMzUZBRpdfpneYSYPW5L2JzUyVH3ws4QDCB8/EIfeqAC9YS03iNHrNBnV7WwSP6F0eygTrzWNVZW3AZs2JzmYgRkcGhYbpCLxhViMW3LnqOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760814915; c=relaxed/simple;
	bh=VuwPRwSEQqLLQEvzxOVyL1G5Oz7ZIElCYk3x2ZPzKEM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=ito9wg4v6QnAAeOS8x/hrcvdZHB83Ps1yEUg2jzA2834Ek3LzJ4TK0XNpj28w7cs1HaISvPnbYeP6FHNQnwarXGCaoAGJ12qYIaD/3BXC6MdTkglk9iPVCGHdMO5/i7R3WwikLLk8lgtFRquJD+OZHAv7R0KctPH/NTN0mh80jI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Qg1v2T9j; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760814913; x=1792350913;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=VuwPRwSEQqLLQEvzxOVyL1G5Oz7ZIElCYk3x2ZPzKEM=;
  b=Qg1v2T9j7QMVuZOivuc258n9ohLq307BFbNb1Xs3AUE8yUeaBACfQAJR
   PkqaUHIOOT6hyGUpQcFqz4c9xI6fB6hbAPqSQ+HRXUJPVYfjNy83au9Fh
   XxuqH446wl+v3uaAgMZKSqM+qu4989lILi15ORLkZNSBJAuCNzt/+mG+2
   ZyDwzwAKdWoqMF0vI6ctf3KOthgDHab1BwVwZZNeiN9tde2NE7pzsiWdJ
   PsaR3/UnjoxxVzRwvCKXhYbqse0n12L9yJg6ivjvJ5tjr+8kfuR00zq4g
   KMkDT7tpwEFSN2GXZeTps/WZGrCFY3gbMwwX059Al7YHMHgMvb7WSE6qD
   w==;
X-CSE-ConnectionGUID: CIfd0wXJSqy8luOXeRuShg==
X-CSE-MsgGUID: Gr9tZe5fShu1xkjL0ZMciA==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="74113764"
X-IronPort-AV: E=Sophos;i="6.19,239,1754982000"; 
   d="scan'208";a="74113764"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2025 12:15:12 -0700
X-CSE-ConnectionGUID: uYEu1oFISoOkeQQQK8e0kA==
X-CSE-MsgGUID: PgzFC4n8QyCTDcq4Fs4+dQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,239,1754982000"; 
   d="scan'208";a="213968581"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO ashevche-desk.local) ([10.245.244.194])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2025 12:15:09 -0700
Received: from andy by ashevche-desk.local with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1vACOQ-00000000xM3-3a2s;
	Sat, 18 Oct 2025 22:15:06 +0300
Date: Sat, 18 Oct 2025 22:15:06 +0300
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
Subject: Re: [PATCH 1/9] software node: read the reference args via the
 fwnode API
Message-ID: <aPPnOnZPfGxzIg6x@ashevche-desk.local>
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


On Mon, Oct 06, 2025 at 03:00:16PM +0200, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> Once we allow software nodes to reference all kinds of firmware nodes,
> the refnode here will no longer necessarily be a software node so read
> its proprties going through its fwnode implementation.

This needs a comment in the code.

-- 
With Best Regards,
Andy Shevchenko



