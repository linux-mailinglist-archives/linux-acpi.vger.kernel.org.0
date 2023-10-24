Return-Path: <linux-acpi+bounces-873-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D14347D4E0D
	for <lists+linux-acpi@lfdr.de>; Tue, 24 Oct 2023 12:37:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0CB6F1C20B3C
	for <lists+linux-acpi@lfdr.de>; Tue, 24 Oct 2023 10:37:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F06026280
	for <lists+linux-acpi@lfdr.de>; Tue, 24 Oct 2023 10:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cEbSB0Hh"
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39CCE2421E
	for <linux-acpi@vger.kernel.org>; Tue, 24 Oct 2023 09:30:25 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 689E9198A;
	Tue, 24 Oct 2023 02:30:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698139818; x=1729675818;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=mSD40iH+sPX+DrU5ENcXUhxksvpVp9Sfw5JZjf5AJFA=;
  b=cEbSB0HhGd5FKGuA2NJOQxdMb7ZKRypszTrQ9THJLwAhbH1P7sgg4yt4
   gv6VpdWWCPXumRaDbvVoDxjmyk3xvAuMK1VzLxasqGj+98j5cevmB+5rO
   JX2JwenP5GkvtXJVxfAC44NIvX2p1JHJDHY+v+Aj65it/y9S9drPQGhdN
   pZM66Taw25/7qvZN25TT+TAycNza9gC6ExE2aafOQhsIYk4hhcl8wrPib
   xysPfCNrZ5X5K0bK5jF4Ze7jbq1L354gkHjFDl7D0UU9chnL5xxiXUYm1
   L28qh2O11r4u6JQFRhtNqOuigdbObCrLKMBOysJe1SYwGROThN+XL644g
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10872"; a="8570434"
X-IronPort-AV: E=Sophos;i="6.03,247,1694761200"; 
   d="scan'208";a="8570434"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2023 02:30:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10872"; a="708224038"
X-IronPort-AV: E=Sophos;i="6.03,247,1694761200"; 
   d="scan'208";a="708224038"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga003.jf.intel.com with ESMTP; 24 Oct 2023 02:30:11 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
	id 6358894; Tue, 24 Oct 2023 12:30:10 +0300 (EEST)
Date: Tue, 24 Oct 2023 12:30:10 +0300
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Raag Jadav <raag.jadav@intel.com>
Cc: rafael@kernel.org, len.brown@intel.com, robert.moore@intel.com,
	andriy.shevchenko@linux.intel.com, mark.rutland@arm.com,
	will@kernel.org, linux@roeck-us.net, Jonathan.Cameron@huawei.com,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
	acpica-devel@lists.linuxfoundation.org, linux-gpio@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-hwmon@vger.kernel.org,
	mallikarjunappa.sangannavar@intel.com, bala.senthil@intel.com
Subject: Re: [PATCH v3 0/6] Refine _UID references across kernel
Message-ID: <20231024093010.GF3208943@black.fi.intel.com>
References: <20231024062018.23839-1-raag.jadav@intel.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231024062018.23839-1-raag.jadav@intel.com>

On Tue, Oct 24, 2023 at 11:50:12AM +0530, Raag Jadav wrote:
> This series refines _UID references across kernel by:
> 
> - Extracting _UID matching functionality from acpi_dev_hid_uid_match()
>   helper and introducing it as a separate acpi_dev_uid_match() helper.
> 
> - Converting manual _UID references to use the standard ACPI helpers.
> 
> Changes since v2:
> - Drop review tags as suggested by Andy.
> 
> Changes since v1:
> - Change acpi_dev_uid_match() to return false in case of NULL argument.
> - Drop accepted patches.
> 
> Raag Jadav (6):
>   ACPI: utils: Introduce acpi_dev_uid_match() for matching _UID
>   pinctrl: intel: use acpi_dev_uid_match() for matching _UID
>   ACPI: utils: use acpi_dev_uid_match() for matching _UID
>   ACPI: x86: use acpi_dev_uid_match() for matching _UID
>   hwmon: nct6775: use acpi_dev_hid_uid_match() for matching _HID and
>     _UID
>   perf: arm_cspmu: use acpi_dev_hid_uid_match() for matching _HID and
>     _UID

For the series,

Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>

>  drivers/acpi/utils.c                  | 34 ++++++++++++++++++++++-----
>  drivers/acpi/x86/utils.c              |  3 +--
>  drivers/hwmon/nct6775-platform.c      |  4 +---
>  drivers/perf/arm_cspmu/arm_cspmu.c    |  8 +++----
>  drivers/pinctrl/intel/pinctrl-intel.c |  2 +-

This pinctrl one is also fine by me so if Andy does not have objections,
feel free to add my,

Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>

>  include/acpi/acpi_bus.h               |  1 +
>  include/linux/acpi.h                  |  5 ++++
>  7 files changed, 40 insertions(+), 17 deletions(-)
> 
> 
> base-commit: a4ed5bffbeb19cfb7e21ac3b3f09d7bfe39a849b
> -- 
> 2.17.1

