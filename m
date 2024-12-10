Return-Path: <linux-acpi+bounces-10061-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 845729EBB79
	for <lists+linux-acpi@lfdr.de>; Tue, 10 Dec 2024 22:04:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 53FF01888E8C
	for <lists+linux-acpi@lfdr.de>; Tue, 10 Dec 2024 21:04:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E49C6230248;
	Tue, 10 Dec 2024 21:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NEl7kcqO"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 624F322FAE5;
	Tue, 10 Dec 2024 21:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733864643; cv=none; b=UzRhiw/3GCnqTkQPkP/UiN3TrmRebb//hIQR95KwLi7mTjohaG1c63S9LIJQ7Fj5ucUDChMPF9a7mD1pqC0/v8egBZ4zrcMlYTm15oqVez+P7Z5Y2OiyKUUq72Tv8OWjattWTITN8sPipepRnwQDOTC95m/iCWe+GzEpwHq30no=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733864643; c=relaxed/simple;
	bh=HW6gUWGZLgC6Eh05ba6OQszfv3GouJ3PbIM+/rVXuQ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DJ0qFfh5SoBfJPrMhDB/2WZezWzquekTDyCAj9fW2hvzz6Pi5V/LsnElvyFk8m96f0Myf7EUtWAtCkq1/xXQCXj0ZH4mkPWrLZhNzX2OepKgKl9xLDTWgc//Abz2dDLvvKwA/Kp+hQVq08meiMWSapdg2pFK2c74mMjKWpGG78w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NEl7kcqO; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733864643; x=1765400643;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=HW6gUWGZLgC6Eh05ba6OQszfv3GouJ3PbIM+/rVXuQ0=;
  b=NEl7kcqOSCcsd/YrQ/K6D15M0/1Z06LKDbAzK4nIqlIgN0R8NZIUzDKm
   cVIwx0ACLdeIFPvLAxoJ2lOK7wTUrL7lUaXNjwD8GBkjaJv5gKOxpTNAp
   eblnVjqHUqMbauLsHlGIhbG3IrMpMr+XyTnVK4vG6MCpDvrfryok1/qk9
   m/Ksl5P+5rk2Fl7jgr5dGJUnjCBh90I25+5zn9y3VN50VabV5oG3bn2Ht
   TKtMInWFej+ZCnNaHV2MQSSMkxS+VSmeJPz1LHxq1NZOaGHRZQRJZ5l9c
   nRiSj1QLa+qm65Qy0fBcNHzIvQ6D0dl2RW6OWPGgkdqyz7fMOsjO8n4sZ
   A==;
X-CSE-ConnectionGUID: 7jB/RBHQT1e2N9/EL5imQw==
X-CSE-MsgGUID: NuU5Mx3pRxyMClA1bcFgWg==
X-IronPort-AV: E=McAfee;i="6700,10204,11282"; a="33956437"
X-IronPort-AV: E=Sophos;i="6.12,223,1728975600"; 
   d="scan'208";a="33956437"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Dec 2024 13:04:02 -0800
X-CSE-ConnectionGUID: oYeu5EDDSU+CTCSt0fTasw==
X-CSE-MsgGUID: JD/8Z31pRGaouGOXvTNVjQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,223,1728975600"; 
   d="scan'208";a="126438011"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Dec 2024 13:03:59 -0800
Received: from kekkonen.localdomain (localhost [127.0.0.1])
	by kekkonen.fi.intel.com (Postfix) with SMTP id CE59F11F81D;
	Tue, 10 Dec 2024 23:03:56 +0200 (EET)
Date: Tue, 10 Dec 2024 21:03:56 +0000
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: Ricardo Ribalda <ribalda@chromium.org>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>, Robert Moore <robert.moore@intel.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-acpi@vger.kernel.org, acpica-devel@lists.linux.dev,
	kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v3 1/7] media: ipu-bridge: Fix warning when !ACPI
Message-ID: <Z1isvGLLwr7jmW5k@kekkonen.localdomain>
References: <20241210-fix-ipu-v3-0-00e409c84a6c@chromium.org>
 <20241210-fix-ipu-v3-1-00e409c84a6c@chromium.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241210-fix-ipu-v3-1-00e409c84a6c@chromium.org>

Hi Ricardo,

On Tue, Dec 10, 2024 at 07:55:58PM +0000, Ricardo Ribalda wrote:
> One of the quirks that we introduced to build with !ACPI && COMPILE_TEST
> throws the following smatch warning:
> drivers/media/pci/intel/ipu-bridge.c:752 ipu_bridge_ivsc_is_ready() warn: iterator 'i' not incremented
> 
> Fix it by replacing the condition.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/r/202411221147.N6w23gDo-lkp@intel.com/
> Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> Closes: https://lore.kernel.org/r/202411221147.N6w23gDo-lkp@intel.com/
> Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>

I've picked this to my tree and I'll take the last one, too, once the rest
reaches the media tree.

-- 
Regards,

Sakari Ailus

