Return-Path: <linux-acpi+bounces-18532-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F69FC356AD
	for <lists+linux-acpi@lfdr.de>; Wed, 05 Nov 2025 12:43:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9BA62465570
	for <lists+linux-acpi@lfdr.de>; Wed,  5 Nov 2025 11:39:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BDE63101D0;
	Wed,  5 Nov 2025 11:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jh99mVay"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC2152D239B;
	Wed,  5 Nov 2025 11:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762342713; cv=none; b=NivAN4t8KkpL4Om/dqx1G0IWIsxMF6GUAsErVivpSujaAQ8mOf/MkAe+BRWTeJmnzKMm5+3Wtj/dYtp0bVPht3fHV0ydkv25pBMjiX5PruKu+wPPazkilZnTigFYZCTCFvReYDijwZtptWxliR5HYkjc0rFuLyyCb4MaLJy5cmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762342713; c=relaxed/simple;
	bh=r1MggjRa5LTArtaThr0VKYwN5EsmTnjnEk6Qf6sztao=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L6EWzq0gd6c+ZTn5xg2egY8QIw01l2QKdCa2qLSdULZPGTCV953isZwpzUcRKCpWicarxvPj7IjCwIZ0w+sv/1FOG3+z31H6Mp1xlKStEXWGubmmD4OV2VknD7gbFA+gRHV59vc9mLA+2RjKTMBzG/xiYxRYYtA7rUe/GKqtZfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jh99mVay; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762342711; x=1793878711;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=r1MggjRa5LTArtaThr0VKYwN5EsmTnjnEk6Qf6sztao=;
  b=jh99mVayV7bDupmpO74HdlVPAbMyDr1jyYJVnALuT/Bg0FgQAGizEwVe
   ax5xwpdzwnK3Mx1j0z/smwYUavnReXBmN2rOrVeMH2nq68n2dBfPm4N/6
   LkcnGJBjpj07zBhsVexONw9iaIwnqiraFhLh2ztCF8akRNn1j0jffutju
   iQkCBCnsR0TuJBRw+K9YghTTi1JWgiVmnbCtkwLdah2v043pPm882GhXm
   IXn851xel1CnprW8hNPpjc4f134eQoL378pxZSzUnV5dSaqds+hgIznLh
   qTkAefnDyWOBp2bj91bT7XougIXtkuQ2E/u/y4m6d2/cHd1/ex1LdutNk
   w==;
X-CSE-ConnectionGUID: Ovl0zT8gQLahbWtgL2QFbg==
X-CSE-MsgGUID: wgwoyk37QWmlV17PRRR0GA==
X-IronPort-AV: E=McAfee;i="6800,10657,11603"; a="63658960"
X-IronPort-AV: E=Sophos;i="6.19,281,1754982000"; 
   d="scan'208";a="63658960"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2025 03:38:30 -0800
X-CSE-ConnectionGUID: aDX//h26STOPPRKOXcZhcg==
X-CSE-MsgGUID: 0bi4mw+RThuqog22QGIMDQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,281,1754982000"; 
   d="scan'208";a="224679250"
Received: from ldmartin-desk2.corp.intel.com (HELO ashevche-desk.local) ([10.124.221.135])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2025 03:38:26 -0800
Received: from andy by ashevche-desk.local with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1vGbqH-00000005lGe-0J8H;
	Wed, 05 Nov 2025 13:38:21 +0200
Date: Wed, 5 Nov 2025 13:38:20 +0200
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
Subject: Re: [PATCH v5 3/8] software node: allow referencing firmware nodes
Message-ID: <aQs3LJtrYMLPUSwU@smile.fi.intel.com>
References: <20251105-reset-gpios-swnodes-v5-0-1f67499a8287@linaro.org>
 <20251105-reset-gpios-swnodes-v5-3-1f67499a8287@linaro.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251105-reset-gpios-swnodes-v5-3-1f67499a8287@linaro.org>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Nov 05, 2025 at 09:47:34AM +0100, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> At the moment software nodes can only reference other software nodes.
> This is a limitation for devices created, for instance, on the auxiliary
> bus with a dynamic software node attached which cannot reference devices
> the firmware node of which is "real" (as an OF node or otherwise).
> 
> Make it possible for a software node to reference all firmware nodes in
> addition to static software nodes. To that end: add a second pointer to
> struct software_node_ref_args of type struct fwnode_handle. The core
> swnode code will first check the swnode pointer and if it's NULL, it
> will assume the fwnode pointer should be set.
> 
> Software node graphs remain the same, as in: the remote endpoints still
> have to be software nodes.

All my worries have been addressed, thanks.
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

-- 
With Best Regards,
Andy Shevchenko



