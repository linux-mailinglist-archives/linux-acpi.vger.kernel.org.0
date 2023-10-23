Return-Path: <linux-acpi+bounces-842-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5A707D36E3
	for <lists+linux-acpi@lfdr.de>; Mon, 23 Oct 2023 14:36:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8FBEF281584
	for <lists+linux-acpi@lfdr.de>; Mon, 23 Oct 2023 12:36:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 452FD18E25
	for <lists+linux-acpi@lfdr.de>; Mon, 23 Oct 2023 12:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GpeRF5J2"
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C0AC15E84
	for <linux-acpi@vger.kernel.org>; Mon, 23 Oct 2023 11:34:28 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F288FDB;
	Mon, 23 Oct 2023 04:34:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698060867; x=1729596867;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=tqBRMH+HCKcZFWm9PPVshLhZLM8RB9RreHNxWsejEpE=;
  b=GpeRF5J2ku/ors3c3v/VZykPAGN4sNLr9ixkS5aw+0yphXeUyAt/aJL/
   aTJ/fiVhACTrWliYVug1+UNB6CQHX6XLz5QqohOVZOdCqCSAyqjqTlwb8
   lCCXGDtblBr9sjhJb1Rbj01q3Lr+s3OIjAb54XswEtiPjYWdjhywEgI8k
   a2Kmfx2ChMpumwiPjf9O3TFTQLIxHYHCjxDmTJmLMUO6n5bu9Mnom0Kyc
   Mpm1QUhLwEkL8/bDoaRjeMQzvH3OfAGwgkPst021quAC9AwqC6nei1PxT
   m+fA/ljgG73rUPW0yP3r6QRMKfujys8SvZXJUN/nSmecrkCFCXbgeseZh
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10871"; a="385699658"
X-IronPort-AV: E=Sophos;i="6.03,244,1694761200"; 
   d="scan'208";a="385699658"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2023 04:34:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10871"; a="874679412"
X-IronPort-AV: E=Sophos;i="6.03,244,1694761200"; 
   d="scan'208";a="874679412"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2023 04:34:22 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97-RC2)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1qutCN-00000007vFo-0lkP;
	Mon, 23 Oct 2023 14:34:19 +0300
Date: Mon, 23 Oct 2023 14:34:18 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Raag Jadav <raag.jadav@intel.com>
Cc: rafael@kernel.org, len.brown@intel.com, robert.moore@intel.com,
	mika.westerberg@linux.intel.com, mark.rutland@arm.com,
	will@kernel.org, linux@roeck-us.net, Jonathan.Cameron@huawei.com,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
	acpica-devel@lists.linuxfoundation.org, linux-gpio@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-hwmon@vger.kernel.org,
	mallikarjunappa.sangannavar@intel.com, bala.senthil@intel.com
Subject: Re: [PATCH v2 1/6] ACPI: utils: Introduce acpi_dev_uid_match() for
 matching _UID
Message-ID: <ZTZaOqCt7MbylTv+@smile.fi.intel.com>
References: <20231023053530.5525-1-raag.jadav@intel.com>
 <20231023053530.5525-2-raag.jadav@intel.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231023053530.5525-2-raag.jadav@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, Oct 23, 2023 at 11:05:25AM +0530, Raag Jadav wrote:
> Introduce acpi_dev_uid_match() helper that matches the device with
> supplied _UID string.

...

> Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Sorry, I suggested another helper. Please either drop this tag, or change
helper to what I suggested (as in your v1 I assume).

-- 
With Best Regards,
Andy Shevchenko



