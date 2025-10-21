Return-Path: <linux-acpi+bounces-18041-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id CE8C3BF7312
	for <lists+linux-acpi@lfdr.de>; Tue, 21 Oct 2025 16:56:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 82E94501D55
	for <lists+linux-acpi@lfdr.de>; Tue, 21 Oct 2025 14:55:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DEC7340A71;
	Tue, 21 Oct 2025 14:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Op492MAh"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B88234026F;
	Tue, 21 Oct 2025 14:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761058512; cv=none; b=VeuB8TKJj8kMuHooGzpc4LfRwD7GBZ+fgya+RWdTD8wpEUyL+k1wfnn0mb1AFol+B3/tocBl4H1SFJXf8mJqNrlz2wkHFrtR3vzcHVe6cpt0RiW/FQGhGUqOQlRehhgLSPSu2MP5Hf3LZKTSTO8O/HNJwHjpnkbvTLUMNQ+qtu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761058512; c=relaxed/simple;
	bh=JVsFHDNltly00ia4WGi5anXLqu03Rde3Pkn3mw3Yix4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MNyV62+ccfI6SqcNVxM+5/zgHHpuZOMOcY9YF2umqCoepS6bHrp+Bq2Vb+2swn62viyD4Fgzerjnn1UMYU0J3m39FESsiOc33tRxdj7/HOMjg2DPDBFvRM6xeA8JS1Dv5iMqV+VJuVH2V9W2/jMnvcdLu57MsuQV3DHHbGVzJeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Op492MAh; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761058511; x=1792594511;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=JVsFHDNltly00ia4WGi5anXLqu03Rde3Pkn3mw3Yix4=;
  b=Op492MAhM/LOhBUJuZHOv6cxeMqG9LNTaNVce72d8ba7Y/WKCxHuXxYE
   XHM5F/9nMTW2lNm18ev6LQyymhgf+vWnIN/I1rJONNwNghCRU8Jz3koM6
   jPEs9XsSNjpGh7vS+NPmV7KWiyXp5zUX/dpxvBQgLu8+J8gFFHXUp6Fzs
   BA5kJS548jiNQznwD/h9SRHZvof1HhkP3Ud13USW0SEVfVQzzGlB61a93
   Bj5K4oTmLeps4O/yj3eq3wEub8IwDv04+eNw27Qw2ua1LuuduHt+4y0kL
   LWuLeKQDBSAQdAAHeceAXHbCdn2eqAjXHlfGpIgt0ptdX7hncGIKVArDh
   A==;
X-CSE-ConnectionGUID: 9saDnaPDS5WGKoztMze5WA==
X-CSE-MsgGUID: fk9ck4QoT8yzY2oY/cCAVg==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="62887789"
X-IronPort-AV: E=Sophos;i="6.19,245,1754982000"; 
   d="scan'208";a="62887789"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2025 07:55:10 -0700
X-CSE-ConnectionGUID: pltd7Bc6QTapEixRzxWiTg==
X-CSE-MsgGUID: VQE3++B5T1ep91WByBegFw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,245,1754982000"; 
   d="scan'208";a="182814518"
Received: from fpallare-mobl4.ger.corp.intel.com (HELO ashevche-desk.local) ([10.245.245.148])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2025 07:55:06 -0700
Received: from andy by ashevche-desk.local with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1vBDlO-00000001WRH-3tcr;
	Tue, 21 Oct 2025 17:55:02 +0300
Date: Tue, 21 Oct 2025 17:55:02 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Philipp Zabel <p.zabel@pengutronix.de>,
	Linus Walleij <linus.walleij@linaro.org>,
	Daniel Scally <djrscally@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>, linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH 7/9] reset: make the provider of reset-gpios the parent
 of the reset device
Message-ID: <aPeexuA1nu-7Asws@smile.fi.intel.com>
References: <20251006-reset-gpios-swnodes-v1-0-6d3325b9af42@linaro.org>
 <20251006-reset-gpios-swnodes-v1-7-6d3325b9af42@linaro.org>
 <95bbec130437846d4b902ce4161ccf0f33c26c59.camel@pengutronix.de>
 <CAMRc=Md_-mO=HqfncD-vJS6XzPJ+aTcBjSjtkxLH_h1=pNjCcg@mail.gmail.com>
 <075a4511a6ae4b047599757d41b559c6b7cf9d0f.camel@pengutronix.de>
 <CAMRc=Md4DUSuwv07EuBVDJbY1Uzezq+TONxyCvLtOHD=iFXrcQ@mail.gmail.com>
 <050d74d7619bdfdf5ca81d8914a2a8836a0d4e2e.camel@pengutronix.de>
 <CAMRc=MfPqRLFHPW988oMry7vVoTgtQHrxxND4=nr_40dOa5owg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMRc=MfPqRLFHPW988oMry7vVoTgtQHrxxND4=nr_40dOa5owg@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Oct 21, 2025 at 11:39:41AM +0200, Bartosz Golaszewski wrote:
> On Tue, Oct 21, 2025 at 11:31 AM Philipp Zabel <p.zabel@pengutronix.de> wrote:
> > On Di, 2025-10-21 at 11:27 +0200, Bartosz Golaszewski wrote:

[...]

> > No need to convert all existing drivers right away, but I'd like to see
> > a user that benefits from the conversion.
> >
> 
> The first obvious user will be the reset-gpio driver which will see
> its core code simplified as we won't need to cast between OF and
> fwnodes.

+1 to Bart's work. reset-gpio in current form is useless in all my cases
(it's OF-centric in 2025! We should not do that in a new code).

More over, conversion to reset-gpio from open coded GPIO APIs is a clear
regression and I want to NAK all those changes (if any already done) for
the discrete components that may be used outside of certainly OF-only niche of
the platforms.

-- 
With Best Regards,
Andy Shevchenko



