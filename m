Return-Path: <linux-acpi+bounces-931-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 664567D58FE
	for <lists+linux-acpi@lfdr.de>; Tue, 24 Oct 2023 18:43:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 95B181C20326
	for <lists+linux-acpi@lfdr.de>; Tue, 24 Oct 2023 16:43:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0115C3B291
	for <lists+linux-acpi@lfdr.de>; Tue, 24 Oct 2023 16:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mwVzgn+5"
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C74A273E1;
	Tue, 24 Oct 2023 15:43:00 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77D4BA3;
	Tue, 24 Oct 2023 08:42:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698162179; x=1729698179;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=TR0MsODDCDld/9hD7QPnERhiZ/gxH5leUiM0oaDfwbI=;
  b=mwVzgn+5pw/LzBLPCXjnMT/FmEnuYa0rlpvb2Q/bvSJS41OQI5FFi5m7
   30Lm3rSBC9e0FfQpUeRG6c4qMqv/ZMSuzsCqpWt4b5+xTtvF8Zsm7ssby
   YgV3UmamB4JuZScqA1oKNb2B206VpyeclqpO+jogJuoPDqoZIfw7W6AkR
   9hGojjKAu8Ul8lM/oIXXNscpb3UGxu51TYb6J1EqFAoBMqq47awDljmGU
   vwaTo20gJnJPUHvMl3/gZrmAnsc9w/9RcmEUEScs17NH84qaAH6qGl/2P
   GL6EcdsuJmwYSoo/jDkY1Dv8aDjRjYivDOiRxu53hnDwmC9nDjRjJHQPe
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10873"; a="389946496"
X-IronPort-AV: E=Sophos;i="6.03,248,1694761200"; 
   d="scan'208";a="389946496"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2023 08:36:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10873"; a="1089891583"
X-IronPort-AV: E=Sophos;i="6.03,248,1694761200"; 
   d="scan'208";a="1089891583"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2023 08:32:44 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97-RC3)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1qvJOa-00000008Jsh-3eUI;
	Tue, 24 Oct 2023 18:32:40 +0300
Date: Tue, 24 Oct 2023 18:32:40 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Russell King <rmk+kernel@armlinux.org.uk>
Cc: linux-pm@vger.kernel.org, loongarch@lists.linux.dev,
	linux-acpi@vger.kernel.org, linux-arch@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-riscv@lists.infradead.org, kvmarm@lists.linux.dev,
	x86@kernel.org, linux-csky@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-ia64@vger.kernel.org,
	linux-parisc@vger.kernel.org, Salil Mehta <salil.mehta@huawei.com>,
	Jean-Philippe Brucker <jean-philippe@linaro.org>,
	jianyong.wu@arm.com, justin.he@arm.com,
	James Morse <james.morse@arm.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Yury Norov <yury.norov@gmail.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Thomas Gleixner <tglx@linutronix.de>,
	Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 38/39] cpumask: Add enabled cpumask for present CPUs that
 can be brought online
Message-ID: <ZTfjmM3nmeh+D5w/@smile.fi.intel.com>
References: <ZTffkAdOqL2pI2la@shell.armlinux.org.uk>
 <E1qvJBk-00AqSW-R8@rmk-PC.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1qvJBk-00AqSW-R8@rmk-PC.armlinux.org.uk>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Tue, Oct 24, 2023 at 04:19:24PM +0100, Russell King wrote:
> From: James Morse <james.morse@arm.com>
> 
> The 'offline' file in sysfs shows all offline CPUs, including those
> that aren't present. User-space is expected to remove not-present CPUs
> from this list to learn which CPUs could be brought online.
> 
> CPUs can be present but not-enabled. These CPUs can't be brought online
> until the firmware policy changes, which comes with an ACPI notification
> that will register the CPUs.
> 
> With only the offline and present files, user-space is unable to
> determine which CPUs it can try to bring online. Add a new CPU mask
> that shows this based on all the registered CPUs.

...

> +static ssize_t print_cpus_enabled(struct device *dev,
> +				  struct device_attribute *attr, char *buf)
> +{
> +	return sysfs_emit(buf, "%*pbl\n", cpumask_pr_args(cpu_enabled_mask));
> +}
> +static DEVICE_ATTR(enabled, 0444, print_cpus_enabled, NULL);

Hmm... DEVICE_ATTR_RO() ?

-- 
With Best Regards,
Andy Shevchenko



