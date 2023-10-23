Return-Path: <linux-acpi+bounces-843-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 991567D36E6
	for <lists+linux-acpi@lfdr.de>; Mon, 23 Oct 2023 14:37:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB2721C2094F
	for <lists+linux-acpi@lfdr.de>; Mon, 23 Oct 2023 12:37:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1581618E20
	for <lists+linux-acpi@lfdr.de>; Mon, 23 Oct 2023 12:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QWrKUow+"
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5DFD15E83
	for <linux-acpi@vger.kernel.org>; Mon, 23 Oct 2023 11:35:25 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59C20E8;
	Mon, 23 Oct 2023 04:35:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698060922; x=1729596922;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=oxQ99Lbr0YPXctAU2ZPK0KvWToc8S5g7FWzgOBc/tco=;
  b=QWrKUow+jFqrLzXHv4IDTJhzD73Gi6KQ6MlihK4encHmex+ZyJfKy3M9
   Wd6/Ip10maDr1TpRaxA7c79xkpIxAzgZxE5seYNdo1Wr5LHD08OiHichq
   HNeP7iPWLXqzwGTYKkmc+JGsTEcBBFsUHN/jxts78skVdgyWrjHgR/89z
   wGrmRbyYMVJTJRL64PCXskUwEqGJqeD//sD9I72Es1DpoTAO9x01rPwqo
   kQ2fPeQRk13IbwtGQ3hCXvzjzdVHjfyzPTlcPC/FBiHdFDzJTA6J9ycB3
   +lZmuNdzs5OCubbSnSLmmNDUcAQngY/2lMJyQWnBQjGjLgdblfStt5rIU
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10871"; a="377193012"
X-IronPort-AV: E=Sophos;i="6.03,244,1694761200"; 
   d="scan'208";a="377193012"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2023 04:35:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10871"; a="901779783"
X-IronPort-AV: E=Sophos;i="6.03,244,1694761200"; 
   d="scan'208";a="901779783"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2023 04:32:59 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97-RC2)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1qutDF-00000007vGe-48Ha;
	Mon, 23 Oct 2023 14:35:13 +0300
Date: Mon, 23 Oct 2023 14:35:13 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Raag Jadav <raag.jadav@intel.com>
Cc: rafael@kernel.org, len.brown@intel.com, robert.moore@intel.com,
	mika.westerberg@linux.intel.com, mark.rutland@arm.com,
	will@kernel.org, linux@roeck-us.net, Jonathan.Cameron@huawei.com,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
	acpica-devel@lists.linuxfoundation.org, linux-gpio@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-hwmon@vger.kernel.org,
	mallikarjunappa.sangannavar@intel.com, bala.senthil@intel.com
Subject: Re: [PATCH v2 2/6] pinctrl: intel: use acpi_dev_uid_match() for
 matching _UID
Message-ID: <ZTZacR86hSmV04M9@smile.fi.intel.com>
References: <20231023053530.5525-1-raag.jadav@intel.com>
 <20231023053530.5525-3-raag.jadav@intel.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231023053530.5525-3-raag.jadav@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, Oct 23, 2023 at 11:05:26AM +0530, Raag Jadav wrote:
> Convert manual _UID references to use the standard ACPI helper.

> Signed-off-by: Raag Jadav <raag.jadav@intel.com>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

As I asked you, please drop this one. It has a hidden logic that is not aligned
with acpi_dev_hid_uid_match(). Or revert to your v1 I assume.

-- 
With Best Regards,
Andy Shevchenko



