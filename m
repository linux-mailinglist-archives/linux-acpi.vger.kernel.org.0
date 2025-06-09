Return-Path: <linux-acpi+bounces-14231-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ABC8DAD187B
	for <lists+linux-acpi@lfdr.de>; Mon,  9 Jun 2025 08:07:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 99F9C3A8C77
	for <lists+linux-acpi@lfdr.de>; Mon,  9 Jun 2025 06:07:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A892218BBB9;
	Mon,  9 Jun 2025 06:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FdWFB4T+"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B1C0C2EF;
	Mon,  9 Jun 2025 06:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749449243; cv=none; b=bb/cZXMo2AigwcOTTAZvl/M469nopfR59U5aavE3TGVAzHIXvw+Jbp3PlGcSM5HypfGOT47d8X0Cd28bLKQjwJzh+QgKPQFym0mSoaw+64HqhvCrtSxLlakQQV0hTIoNNoSiISY+bMQg0hevVlAZrMDeNBHxV+gMQOAL/6v/9OM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749449243; c=relaxed/simple;
	bh=QA0igcJkHnKFPJrn48iHey+Gnufxa+beVjKFor6/b3o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZxUaXJWhp9H3WtnWtVKlOivmkKOdRLzzEydgeT3scUsYzZiErzuLXr/NVAyoxGEHLAZZq1ptT7dFQKZqMYFOxFiJHcTCjSNqnbX2eSFJuNlug8gJ/ZJk/VZug0lf7b5u1LB8PvcikBaNjZ75FHQfuylgzoHWyyQatlf9/4fN3OI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FdWFB4T+; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749449242; x=1780985242;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=QA0igcJkHnKFPJrn48iHey+Gnufxa+beVjKFor6/b3o=;
  b=FdWFB4T+CgWP/6El4htCQZc9qAqmdzEW1ZlSLQ8M+1A1MEuSNYqfy/H0
   NF39/ZWYCYFNWCUQYHHev9CZFbNbAOlJC5R8o7oZWozH0rT0dHYmNLWUm
   PnGdBg5PPKiDs9usrExzJ+PEkLlH+8/NNh9NBb4QYrqUrRdAQCNH7LeiX
   fHIgso0C4T30OIaC59gVWQYpsweummwvkvu5xDDqkOobPGB+YVozM0XPO
   V2NcQ+pEdrd3k5mxaJAVBUQCiFmBMK/aHLcg5bXpCNOFr2n/LuXKQx+Bq
   0fX2DGKF0UW+gDkre2BefoqNHqeJcR0S/JJj4ZUJU5EhB0PUQUQJwpC1S
   w==;
X-CSE-ConnectionGUID: X8A1gIgvRmqi9jjHB06XaQ==
X-CSE-MsgGUID: bw0Vhd9hTc2EI6kzAFpiwg==
X-IronPort-AV: E=McAfee;i="6800,10657,11458"; a="69075107"
X-IronPort-AV: E=Sophos;i="6.16,221,1744095600"; 
   d="scan'208";a="69075107"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2025 23:07:21 -0700
X-CSE-ConnectionGUID: idwBHfMQR++LSpaCbOXetw==
X-CSE-MsgGUID: W42gSgsfQVih+U0VP5uAAw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,221,1744095600"; 
   d="scan'208";a="177354111"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa002.jf.intel.com with ESMTP; 08 Jun 2025 23:07:19 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
	id 99D941BC; Mon, 09 Jun 2025 09:07:17 +0300 (EEST)
Date: Mon, 9 Jun 2025 09:07:17 +0300
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Mario Limonciello <superm1@kernel.org>
Cc: mario.limonciello@amd.com, westeri@kernel.org,
	andriy.shevchenko@linux.intel.com, linus.walleij@linaro.org,
	brgl@bgdev.pl, linux-gpio@vger.kernel.org,
	linux-acpi@vger.kernel.org
Subject: Re: [PATCH] gpiolib: acpi: Add a quirk for Acer Nitro V15
Message-ID: <20250609060717.GF88033@black.fi.intel.com>
References: <20250609023424.372827-1-superm1@kernel.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250609023424.372827-1-superm1@kernel.org>

On Sun, Jun 08, 2025 at 09:34:08PM -0500, Mario Limonciello wrote:
> From: Mario Limonciello <mario.limonciello@amd.com>
> 
> It is reported that on Acer Nitro V15 suspend only works properly if the
> keyboard backlight is turned off. In looking through the issue Acer Nitro
> V15 has a GPIO (#8) specified in _AEI but it has no matching notify device
> in _EVT. The values for GPIO #8 change as keyboard backlight is turned on
> and off.
> 
> This makes it seem that GPIO #8 is actually supposed to be solely for
> keyboard backlight.  Turning off the interrupt for this GPIO fixes the issue.
> Add a quirk that does just that.
> 
> Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/4169
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>

Acked-by: Mika Westerberg <westeri@kernel.org>

