Return-Path: <linux-acpi+bounces-18449-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 796E6C2B2ED
	for <lists+linux-acpi@lfdr.de>; Mon, 03 Nov 2025 11:57:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 18FD03BA838
	for <lists+linux-acpi@lfdr.de>; Mon,  3 Nov 2025 10:53:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74ABD3002BD;
	Mon,  3 Nov 2025 10:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="blv5rGTv"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99E252FFFB5;
	Mon,  3 Nov 2025 10:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762167217; cv=none; b=bZ7uHS6SWsTp5Sg7sIDX9LNwvuhUc7+f1Mn5McG8DUFY1O40V0dtpW9ts8kK38XRgk4791Kg6vk/vdMUJLw0Baw5okWpJ0WyxD5siM94ZNccp7E4uqanB+rR1pjvfRIgnL1WbEODLeAO5n1FAzQzYiucMUf4wd1faiFekBpXyJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762167217; c=relaxed/simple;
	bh=EJ0V25kCpi/5Xi2A3te8GkyzbOFSOwMV9SQ2dd0OBiQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OEEQIvYU0sjF+jFfHLvCBct86rRnG2CCfa1+entHTxEBhjVzt2sIRz1RJlr/H/AznZM4HzfOb/SNk8UEWKTUWa/Akbel1DaEmV5w/fP/+Np2T4UAKxsaD63vBXwBD1mi58rp8xWZCCAfm/rupRCNY5lzCDa8k8XKP+TrkZLj7mg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=blv5rGTv; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762167216; x=1793703216;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=EJ0V25kCpi/5Xi2A3te8GkyzbOFSOwMV9SQ2dd0OBiQ=;
  b=blv5rGTvCdZdPUjZNp9ER5d3QnaMKtYtJHdotWCVxSVDodw2KXDw/7RW
   o/l43wbVS+QLLD/x4HqB4zydArY70RAWbaigUsLDz4wWTZiLhAn8vb0dI
   QxCA/MSbHjzpUsi+bmp5Hk5a1uUWZ2WCg0R8qlulArYZnQn7K9v6EyVUn
   BZr6kNHPvPH/KuhjJEky/GNEyLOmi0MgeuawhxuafPkGxvqLJua+eWj7X
   UZSqESRClyawdQZw04i1jyUJ4ahS6qQU+pWJJ6bq3vQMjNs76Xc3AjwUD
   CFxckkaqnm4v9n/0mAbQWy9ur/bt3YdhjH/qrZmKFwy95mptJZdxcL1Vj
   g==;
X-CSE-ConnectionGUID: lNOd5nB9SGq8R9PJdrMDIw==
X-CSE-MsgGUID: J9pmb98/QW2BjEL+sDFPSQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11601"; a="66851977"
X-IronPort-AV: E=Sophos;i="6.19,276,1754982000"; 
   d="scan'208";a="66851977"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2025 02:53:35 -0800
X-CSE-ConnectionGUID: GhUZOkNXQ3i3QdI+LlCh+Q==
X-CSE-MsgGUID: ogPT3zmKRdStO+eCKYndPw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,276,1754982000"; 
   d="scan'208";a="186127240"
Received: from vpanait-mobl.ger.corp.intel.com (HELO kekkonen.fi.intel.com) ([10.245.245.27])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2025 02:53:32 -0800
Received: from kekkonen.localdomain (localhost [IPv6:::1])
	by kekkonen.fi.intel.com (Postfix) with SMTP id E412D120D07;
	Mon, 03 Nov 2025 12:53:32 +0200 (EET)
Date: Mon, 3 Nov 2025 12:53:32 +0200
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
Subject: Re: [PATCH v4 02/10] software node: increase the reference of the
 swnode by its fwnode
Message-ID: <aQiJrEQlMDPX4OdF@kekkonen.localdomain>
References: <20251103-reset-gpios-swnodes-v4-0-6461800b6775@linaro.org>
 <20251103-reset-gpios-swnodes-v4-2-6461800b6775@linaro.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251103-reset-gpios-swnodes-v4-2-6461800b6775@linaro.org>

On Mon, Nov 03, 2025 at 10:35:22AM +0100, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> Once we allow software nodes to reference other kinds of firmware nodes,
> the node in args will no longer necessarily be a software node so bump
> its reference count using its fwnode interface.
> 
> Acked-by: Linus Walleij <linus.walleij@linaro.org>
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Reviewed-by: Sakari Ailus <sakari.ailus@linux.intel.com>

-- 
Sakari Ailus

