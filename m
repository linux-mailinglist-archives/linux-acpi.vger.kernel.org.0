Return-Path: <linux-acpi+bounces-872-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0795C7D4E07
	for <lists+linux-acpi@lfdr.de>; Tue, 24 Oct 2023 12:37:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 42E8A1C20B3C
	for <lists+linux-acpi@lfdr.de>; Tue, 24 Oct 2023 10:37:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A58711FDF
	for <lists+linux-acpi@lfdr.de>; Tue, 24 Oct 2023 10:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="d2pycOIe"
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D331E20B0B
	for <linux-acpi@vger.kernel.org>; Tue, 24 Oct 2023 09:29:00 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8B7E2120;
	Tue, 24 Oct 2023 02:28:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698139726; x=1729675726;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=TSB8pAAViMB/8p//BjKSeKwLOijnQ7uOJx1vlqPV8yg=;
  b=d2pycOIegWmaiBPuhL0h9V7Rwvf6X6JJnSDd7LFcZcEP+mQgcROs44xe
   FZVMWHkKU83iek/6+K3s5qtX4BwU7UbjUfUGbzWj6jOLbHXJCAl0C8+3W
   u92kotQVO487mJ13BTNdSKp4wb5PDv0x2VtaC2LZi44VGuQBg4dy0pDJU
   6Y033a/ed2f8KMgUPJTBeD0cumS7orMMBPIa49yhnSbsTY1s+avs5u+zs
   G5YOI42yKFQTrslzzrVB1IIWQyXvROqbPfODyrsOJh6+YkQMatK1gI6NM
   yav9LWgJerxpxlae412EFRx/KuSvMohp15v1L4m9PCqnT8BsCiGII9CzS
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10872"; a="451251855"
X-IronPort-AV: E=Sophos;i="6.03,247,1694761200"; 
   d="scan'208";a="451251855"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2023 02:28:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10872"; a="1089786072"
X-IronPort-AV: E=Sophos;i="6.03,247,1694761200"; 
   d="scan'208";a="1089786072"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga005.fm.intel.com with ESMTP; 24 Oct 2023 02:28:40 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
	id 55BD794; Tue, 24 Oct 2023 12:28:39 +0300 (EEST)
Date: Tue, 24 Oct 2023 12:28:39 +0300
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Raag Jadav <raag.jadav@intel.com>
Cc: rafael@kernel.org, len.brown@intel.com, robert.moore@intel.com,
	andriy.shevchenko@linux.intel.com, mark.rutland@arm.com,
	will@kernel.org, linux@roeck-us.net, Jonathan.Cameron@huawei.com,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
	acpica-devel@lists.linuxfoundation.org, linux-gpio@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-hwmon@vger.kernel.org,
	mallikarjunappa.sangannavar@intel.com, bala.senthil@intel.com
Subject: Re: [PATCH v3 1/6] ACPI: utils: Introduce acpi_dev_uid_match() for
 matching _UID
Message-ID: <20231024092839.GE3208943@black.fi.intel.com>
References: <20231024062018.23839-1-raag.jadav@intel.com>
 <20231024062018.23839-2-raag.jadav@intel.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231024062018.23839-2-raag.jadav@intel.com>

On Tue, Oct 24, 2023 at 11:50:13AM +0530, Raag Jadav wrote:
> +/**
> + * acpi_dev_uid_match - Match device by supplied UID
> + * @adev: ACPI device to match.
> + * @uid2: Unique ID of the device.
> + *
> + * Matches UID in @adev with given @uid2.
> + *
> + * Returns:
> + *  - %true if matches.
> + *  - %false otherwise.

Nit: these actually do not get formatted like above so you can just
write it as

Returns: %true in case UIDs match, %false otherwise.

If it is even needed, I think it is pretty obvious from the function
name what it returns.

