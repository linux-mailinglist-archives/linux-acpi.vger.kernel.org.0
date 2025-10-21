Return-Path: <linux-acpi+bounces-18016-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 63225BF4C2C
	for <lists+linux-acpi@lfdr.de>; Tue, 21 Oct 2025 08:54:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 212DC18C0110
	for <lists+linux-acpi@lfdr.de>; Tue, 21 Oct 2025 06:55:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 089C425EF81;
	Tue, 21 Oct 2025 06:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XzFP7tjr"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E628D21CC4D;
	Tue, 21 Oct 2025 06:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761029670; cv=none; b=LALN2nFeNylHJwdX1ZSeQnSSRCEPMii0GlRulHCeU9SfceIZZdX7HX2oxHedriIppewv+SyCFLMphdqFGo49nWTtPWdf9JmeUNLfUuVxpVkQCAfAzmnN5jjBcWKzDQD669r+4O9cOFzZG6btIHI6Qug79+FMb3R5XU21KrndzEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761029670; c=relaxed/simple;
	bh=vkMgVinL1FWJax5SX3F9UQ4Nigg3RGZN5Nl0dik2QxU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nUG1Wh7NgOx5Qhiy80VXPJFoWGvihjyGxb8MF0QVifkCbIDWaKGMZoxbSnqYGLRSLUxs3e1IZJoB2+5YxK8vcqI9LAqIb+Q2vPqvVX6fbFwjs6pAOTxsg3rEMl5MAPCzJ+KGOUWMft9HrDI9nlzYLgkb0k4x+owo5N3gEYXApRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XzFP7tjr; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761029669; x=1792565669;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=vkMgVinL1FWJax5SX3F9UQ4Nigg3RGZN5Nl0dik2QxU=;
  b=XzFP7tjr+BKXep8frvdSEPFCaW6WDg0HnpF7OTofmSzAzVl3SKtCYZ1V
   udTihOs6PfoZvCBG52CoicyF7/+7seA2Ylz9o4Kcj6YTvKN1hsDlsuxA8
   o5OkdByhvHAyaYZuP1Djtu9ir/LtE/KYkMQIXvf3fBUhNJv8iC6a2WwRT
   Qakkatbde2rMKh+Ye+0ZYjAN/HHyUs6Qedl6xJzYl2K7VeorFjY940tbe
   QjYOZGavIwRt/PBtWr2XXTnwFW/nvpleNilQPTfLZRoJuYUkirCSlPueg
   SB758d0RsuJ1PO52JlzFZzHdHZQIsuKozUpDxCNCNuAjrptpxuSGFdOfE
   g==;
X-CSE-ConnectionGUID: 2pXPLhm2QEa5ZqYeqr0uDQ==
X-CSE-MsgGUID: j0XHH7wLQjyxCXNpFXBk2w==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="80588517"
X-IronPort-AV: E=Sophos;i="6.19,244,1754982000"; 
   d="scan'208";a="80588517"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2025 23:54:28 -0700
X-CSE-ConnectionGUID: tYWKjjtsTyam8fPAp6flPw==
X-CSE-MsgGUID: w/bwCdy6Qvil0IP3vj40Uw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,244,1754982000"; 
   d="scan'208";a="183999477"
Received: from egrumbac-mobl6.ger.corp.intel.com (HELO kekkonen.fi.intel.com) ([10.245.245.134])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2025 23:54:25 -0700
Received: from kekkonen.localdomain (localhost [IPv6:::1])
	by kekkonen.fi.intel.com (Postfix) with ESMTP id 861E411FCC3;
	Tue, 21 Oct 2025 09:54:22 +0300 (EEST)
Date: Tue, 21 Oct 2025 09:54:22 +0300
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6 krs, Bertel Jungin Aukio 5, 02600 Espoo
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Daniel Scally <djrscally@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Krzysztof Kozlowski <krzk@kernel.org>, linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH 3/9] software node: allow referencing firmware nodes
Message-ID: <aPcuHpYCM22NZ7S_@kekkonen.localdomain>
References: <20251006-reset-gpios-swnodes-v1-0-6d3325b9af42@linaro.org>
 <20251006-reset-gpios-swnodes-v1-3-6d3325b9af42@linaro.org>
 <aO1dBgPZfDJTsPfE@smile.fi.intel.com>
 <CAMRc=MfOoHn+mLRpQBEsC3g5sM=VZBgVffsm68CAXJBHffPxdA@mail.gmail.com>
 <aPYJeqFY_9YV9AQn@ashevche-desk.local>
 <CAMRc=McBTgnQXkPoOUYC=PDDwFXuVqfMFuiwZTW7ODb6owJbeg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMRc=McBTgnQXkPoOUYC=PDDwFXuVqfMFuiwZTW7ODb6owJbeg@mail.gmail.com>

Hi Bartosz, Andy,

On Mon, Oct 20, 2025 at 01:26:59PM +0200, Bartosz Golaszewski wrote:
> On Mon, Oct 20, 2025 at 12:05 PM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> >
> > > >
> > > > Can't we always have an fwnode reference?
> > >
> > > Unfortunately no. A const struct software_node is not yet a full
> > > fwnode, it's just a template that becomes an actual firmware node when
> > > it's registered with the swnode framework. However in order to allow
> > > creating a graph of software nodes before we register them, we need a
> > > way to reference those templates and then look them up internally in
> > > swnode code.
> >
> > Strange that you need this way. The IPU3 bridge driver (that creates a graph of
> > fwnodes at run-time for being consumed by the respective parts of v4l2
> > framework) IIRC has no such issue. Why your case is different?
> >
> 
> From what I can tell the ipu-bridge driver only references software
> nodes (as struct software_node) from other software nodes. I need to
> reference ANY implementation of firmware node from a software node.

Yes, the IPU bridge only references software nodes.

I might use two distinct pointers instead of an union and an integer field
that tells which type is the right one. I don't expect more such cases
here; it's either a software node or an fwnode handle (ACPI or OF node).

-- 
Regards,

Sakari Ailus

