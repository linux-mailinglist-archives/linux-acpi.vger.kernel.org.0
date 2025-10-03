Return-Path: <linux-acpi+bounces-17552-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FA06BB651A
	for <lists+linux-acpi@lfdr.de>; Fri, 03 Oct 2025 11:07:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7041A3AF920
	for <lists+linux-acpi@lfdr.de>; Fri,  3 Oct 2025 09:05:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A1C428643E;
	Fri,  3 Oct 2025 09:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dnzQGQut"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 494811D88D0;
	Fri,  3 Oct 2025 09:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759482357; cv=none; b=b2Q+gjf98gg0Ah8JPmGhFL6y5+lybreEFRPksRVEUWxEvGE8/kjW8YjvD0tMpSvDULQyOlxMlWDtQ2l+CZKhwOviBIABzzaCkMGIoT6WMDsLPpLIxlVZZgRCsOCYprGfY+LO+hL+pOm+g9ogCHQ4ONdrJytaGCl26W3gc7SHAxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759482357; c=relaxed/simple;
	bh=gefohxcrzzZYm62J79ROCkH82ZOaQJuYWgzpKFjrufs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p9KSAEMW7gr4m2mTUcCuX1l5tGoLVRezplAzdXECfWUTCuz7hVUECxw3wu+MITXE0dqGdPQ3oOoXSSYoNhf3Mdgs+aJJn3xTwTKIZbrfmk/GJKcZSooozNMbO4+g1u9MMICl0XfLOwEDFdfr7qXQrOOpOFr2hyxPt5oOewP57zQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dnzQGQut; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1759482355; x=1791018355;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=gefohxcrzzZYm62J79ROCkH82ZOaQJuYWgzpKFjrufs=;
  b=dnzQGQutnYFySwt3sp/l3OlnPP69A5Bqk2ThX3mPcTdZljaXiUQhCSZL
   pAYsWLu30qE/VkOcLLtBTZWUhpNYqTrsajbMcolM8RJviY4uGWhaKtsXO
   CL52eDdZ8NbBW1Al/X15lRKmASV/pW3Tn8I5RmotRcv9HHvBfcX/H+aji
   9t1wFlIPjG+mBJnYNKUv131ieQGmOUf96h0eWHM1Rq6baofPEGRaQPcyh
   VZpcf/2j2Y355g3YlrCWMbUvJwGrnUcfbv6W11dqh5B6moR4K61LXWYVq
   IahdCmY9ESOjHUHvvZ96J6Gdu7+NHjHcYdhSZzB1GjZzU2vY1AndE9Bp7
   A==;
X-CSE-ConnectionGUID: OQRvaHHnQEO9wplcqjJYNw==
X-CSE-MsgGUID: WSziOiixQMmmqqTfnZPDSw==
X-IronPort-AV: E=McAfee;i="6800,10657,11570"; a="60801143"
X-IronPort-AV: E=Sophos;i="6.18,312,1751266800"; 
   d="scan'208";a="60801143"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2025 02:05:53 -0700
X-CSE-ConnectionGUID: 26GSf5U+SGeo9v4Gz4X99g==
X-CSE-MsgGUID: NgK0KKJgTxaTXa84cPwZrA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,312,1751266800"; 
   d="scan'208";a="210227998"
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa001.fm.intel.com with ESMTP; 03 Oct 2025 02:05:51 -0700
Received: by black.igk.intel.com (Postfix, from userid 1001)
	id 6B68395; Fri, 03 Oct 2025 11:05:50 +0200 (CEST)
Date: Fri, 3 Oct 2025 11:05:50 +0200
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Markus Probst <markus.probst@posteo.de>
Cc: Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Mika Westerberg <westeri@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] gpio: of: make it possible to reference gpios probed in
 acpi in device tree
Message-ID: <20251003090550.GC2912318@black.igk.intel.com>
References: <20251002215759.1836706-1-markus.probst@posteo.de>
 <20251003045431.GA2912318@black.igk.intel.com>
 <940aad63e18a1415983a9b8f5e206f26a84c0299.camel@posteo.de>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <940aad63e18a1415983a9b8f5e206f26a84c0299.camel@posteo.de>

On Fri, Oct 03, 2025 at 08:44:12AM +0000, Markus Probst wrote:
> On Fri, 2025-10-03 at 06:54 +0200, Mika Westerberg wrote:
> > Hi,
> > 
> > On Thu, Oct 02, 2025 at 09:58:05PM +0000, Markus Probst wrote:
> > > sometimes it is necessary to use both acpi and device tree to
> > > declare
> > > devices. Not every gpio device driver which has an acpi_match_table
> > > has
> > > an of_match table (e.g. amd-pinctrl). Furthermore gpio is an device
> > > which
> > > can't be easily disabled in acpi and then redeclared in device
> > > tree, as
> > > it often gets used by other devices declared in acpi (e.g. via
> > > GpioInt or
> > > GpioIo). Thus a disable of acpi and migration to device tree is not
> > > always
> > > possible or very time consuming, while acpi by itself is very
> > > limited and
> > > not always sufficient. This won't affect most configurations, as
> > > most of
> > > the time either CONFIG_ACPI or CONFIG_OF gets enabled, not both.
> > 
> > Can you provide a real example where this kind of mixup can happen?
> In my specific usecase for the Synology DS923+, there are gpios for
> powering the usb vbus on (powered down by default), also for powering
> on sata disks. (defining a fixed-regulator for the usb vbus for
> example)

Okay regulators are Power Resources in ACPI.

> > The
> > ACPI ID PRP0001 specifically was added to allow using DT bindings in
> > ACPI
> > based systems.
> Hmm, would requiring patching of the acpi tables. Not sure if it would
> work with the fixed-regulator though, as it uses dev->of_node instead
> of dev->fwnode. I will try to see if I can make it work this way.

I think you can do this by using SSDT overlays instead of patching the
tables:

https://docs.kernel.org/admin-guide/acpi/ssdt-overlays.html

There is configfs interface too.

