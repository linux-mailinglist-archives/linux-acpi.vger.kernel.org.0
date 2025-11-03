Return-Path: <linux-acpi+bounces-18447-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A5C2C2B28E
	for <lists+linux-acpi@lfdr.de>; Mon, 03 Nov 2025 11:53:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 06660343801
	for <lists+linux-acpi@lfdr.de>; Mon,  3 Nov 2025 10:53:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C2782FFFA7;
	Mon,  3 Nov 2025 10:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="g4qRr20L"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACED42FD1DD;
	Mon,  3 Nov 2025 10:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762167202; cv=none; b=Bvdmr/hKBEtsjapecNEprzG8F+032JxyhT+aa3FXKd2/3P0oTgjegB/ACbEqG+Pw34E4A7A/hIWu3Flj1BpcNyJJhSHo1q3kiNyx4Kx8xchA3T7sytPWF9zkgTKSaHk3SIh2AEN79V5NIdW3FwSsEqwyQ5whx/B/jXs1C10adSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762167202; c=relaxed/simple;
	bh=LvrLeebeThEjajSskzduJGv2IgAdw0JjxMI1Op5x2ZI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AyAk7anDzbHwITu+blk3nCrl4ypOr4rocjkxxA/1c9rL/9lSViDgX8C0WqTjVIZUofaQUKMEhLnW+qIUgVhrbpB7KPP3IMgJERtsXIVcLNRJcSzEoZfO6fPH5JbFlDYUgb1tZzOFNmwkwhqUerKftmI33Q1mrnYdXQqlJWIjz5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=g4qRr20L; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762167201; x=1793703201;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=LvrLeebeThEjajSskzduJGv2IgAdw0JjxMI1Op5x2ZI=;
  b=g4qRr20LQpBZCKeKEhLfF1xjTpDd7EsaWVoHu6e04o6Rx0r5VE5PGUla
   7WesFoTLEs9vmuH9yQn0uSlnKGQaa12gYlmHsvplZsyNEATbi6behYqXI
   ywHBVNK7liubl2AOvjQB/7tbE5BdzuBa7rtaBoOkW1zMKK4txnbY1tB4R
   Pm9nnbry0txUKZlputHFACgXxSEu49cDEXfFPVqfO726avEHFJObXBdnc
   QMrSsoFGYzg8cDoEb2+XJjIEhb1NrXiVY0EkT64TuCoeptt9GPbtErJh9
   k9+eOCAw9ePZ20qduUNuVR5Ueki3UgmqFA7BZJ9jnaZpe+lze0cJcAoX7
   g==;
X-CSE-ConnectionGUID: R61n3f2EQEa3qgcyi8DxWQ==
X-CSE-MsgGUID: Elwv9j0MT/O3bjapRnUnZQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11601"; a="75686467"
X-IronPort-AV: E=Sophos;i="6.19,276,1754982000"; 
   d="scan'208";a="75686467"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2025 02:53:20 -0800
X-CSE-ConnectionGUID: rb9znT5MSW6AOiYIfzKztA==
X-CSE-MsgGUID: 16llHiBuT7mjYw13Ga3lsg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,276,1754982000"; 
   d="scan'208";a="186710372"
Received: from vpanait-mobl.ger.corp.intel.com (HELO kekkonen.fi.intel.com) ([10.245.245.27])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2025 02:53:17 -0800
Received: from kekkonen.localdomain (localhost [IPv6:::1])
	by kekkonen.fi.intel.com (Postfix) with SMTP id 9E713120D07;
	Mon, 03 Nov 2025 12:53:18 +0200 (EET)
Date: Mon, 3 Nov 2025 12:53:18 +0200
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6 krs, Bertel Jungin Aukio 5, 02600 Espoo
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Linus Walleij <linus.walleij@linaro.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Daniel Scally <djrscally@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Krzysztof Kozlowski <krzk@kernel.org>, linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH v4 01/10] software node: read the reference args via the
 fwnode API
Message-ID: <aQiJnnVYYD8kvsdI@kekkonen.localdomain>
References: <20251103-reset-gpios-swnodes-v4-0-6461800b6775@linaro.org>
 <20251103-reset-gpios-swnodes-v4-1-6461800b6775@linaro.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251103-reset-gpios-swnodes-v4-1-6461800b6775@linaro.org>

On Mon, Nov 03, 2025 at 10:35:21AM +0100, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> Once we allow software nodes to reference all kinds of firmware nodes,
> the refnode here will no longer necessarily be a software node so read
> its proprties going through its fwnode implementation.
> 
> Acked-by: Linus Walleij <linus.walleij@linaro.org>
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Reviewed-by: Sakari Ailus <sakari.ailus@linux.intel.com>

-- 
Sakari Ailus

