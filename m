Return-Path: <linux-acpi+bounces-18544-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 074DAC35F0D
	for <lists+linux-acpi@lfdr.de>; Wed, 05 Nov 2025 14:58:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D96218C80B9
	for <lists+linux-acpi@lfdr.de>; Wed,  5 Nov 2025 13:58:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBAB0320CAE;
	Wed,  5 Nov 2025 13:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AlxKmqfx"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3549315D2E;
	Wed,  5 Nov 2025 13:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762351093; cv=none; b=UtCZ7O4xzngLwwYFVo18gWCM/wBpN6egcdrXQn6cV4W+qbgmDLPhVwst8PGxkpBvrHUkMwvavabhMGbKoMi2gb3fj5YCpx50BJX+qfLTqwURK6XY38ITytg4Oz3lWjb9fqeQ6G+Jrumw5QvbxzhHdanViVlMPK2Fd3a33KctFt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762351093; c=relaxed/simple;
	bh=eqQC6z9cdB6up/IayN1Dg2lChZQVrnO6m2KSS1GZctE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XjXG+0aVK7RRnHQctI4NKVkgy+R5HKj9sIJWIDrcmE2F0cMuRuy/GSys+a+pn5mfnFlwuRMMRV3iw/0qM/FSJ+y/9E2DIdLFwS/erq1mbx7UtlbkcqNJS/42+9rgnwjMYFssu1ZQGD3rDvwTJ7FQqdUec99NbeWO7OV3Avp0rsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AlxKmqfx; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762351092; x=1793887092;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=eqQC6z9cdB6up/IayN1Dg2lChZQVrnO6m2KSS1GZctE=;
  b=AlxKmqfxB3FurlUt6k9Qb20uPAsD2qSbeLFJwsLlc1ui/qvKY0aGzvil
   EC4Ibw8+0Fgm1nmLMR+WU8SeOYzwLEHi14QBs285aBFpdatdiiDKm+MIi
   z8tTTGFEzKlEdFmLnaS9EH9VHcLVqV97JlWmHiSU/HnpnK/e+SOVkd2j2
   JUADC5aLdZOZhRa5RVnD8nIBZPAOQO/o1hyYtaNFu+vhUkCBrES7ftpe7
   1SlrruJAFkanMYv9/jyuQxXn5O2AidJNmIIFLKyf2fEwybp4DwVZxhRX4
   lDZfzmVLT+KInSnjEan36rZe+yI/j8hGKHb0XwdJKFSiia8KEBH5fhsJE
   A==;
X-CSE-ConnectionGUID: efaDqBj+RKWd9zn17OtxGA==
X-CSE-MsgGUID: MaMb9SKkQWayb//5ukezwA==
X-IronPort-AV: E=McAfee;i="6800,10657,11603"; a="89926021"
X-IronPort-AV: E=Sophos;i="6.19,281,1754982000"; 
   d="scan'208";a="89926021"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2025 05:58:11 -0800
X-CSE-ConnectionGUID: AmSljmC9TgKMbgt4D1Stow==
X-CSE-MsgGUID: MZLX9/npQgOrg22HbiotuQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,281,1754982000"; 
   d="scan'208";a="187409733"
Received: from ldmartin-desk2.corp.intel.com (HELO ashevche-desk.local) ([10.124.221.135])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2025 05:58:08 -0800
Received: from andy by ashevche-desk.local with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1vGe1S-00000005ni1-2OB1;
	Wed, 05 Nov 2025 15:58:02 +0200
Date: Wed, 5 Nov 2025 15:58:01 +0200
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
Subject: Re: [PATCH v5 4/8] gpio: swnode: allow referencing GPIO chips by
 firmware nodes
Message-ID: <aQtX6WUjvksdZeku@smile.fi.intel.com>
References: <20251105-reset-gpios-swnodes-v5-0-1f67499a8287@linaro.org>
 <20251105-reset-gpios-swnodes-v5-4-1f67499a8287@linaro.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251105-reset-gpios-swnodes-v5-4-1f67499a8287@linaro.org>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Nov 05, 2025 at 09:47:35AM +0100, Bartosz Golaszewski wrote:
> 
> When doing a software node lookup, we require both the fwnode that
> references a GPIO chip as well as the node associated with that chip to
> be software nodes. However, we now allow referencing generic firmware
> nodes from software nodes in driver core so we should allow the same in
> GPIO core. Make the software node name check optional and dependent on
> whether the referenced firmware node is a software node. If it's not,
> just continue with the lookup.

Makes sense,
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

-- 
With Best Regards,
Andy Shevchenko



