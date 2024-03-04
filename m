Return-Path: <linux-acpi+bounces-4090-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EBACE870A9A
	for <lists+linux-acpi@lfdr.de>; Mon,  4 Mar 2024 20:21:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8CB631F226D4
	for <lists+linux-acpi@lfdr.de>; Mon,  4 Mar 2024 19:21:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F225179939;
	Mon,  4 Mar 2024 19:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="myfOtFTA"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 551E779924
	for <linux-acpi@vger.kernel.org>; Mon,  4 Mar 2024 19:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709580091; cv=none; b=jKxA9hgo+9XS/4aLmJ1RPOis358fpz+Gzc7nrVqp7lQ/EEe2t6phY82Wjn9z5FV3UIL1KSk+d+wz7FKtIuQ7BG0uHfBssRSZGd24fcXElKpxKeu2GzPZv+UTyJ6gjprpLEhPckm/dY9mTwWA0tbansLxyAu3rTV80wGRew5K/F8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709580091; c=relaxed/simple;
	bh=gfzpyk4WN6ewW9O6enJ5VcMMfIdDNkBC5+aZc3+Hi+U=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=kjjN22U2zFcoKTqRZF/oQNDTbo1NSVF5Gl/au77RAmefiwisWI5hm+Hx6MWE8iCy18URZealyO7oW+YJoruhnvOf9jrwRQe8xpkDv62r3EIVSPoE0OngO064/6OKaX8zkZNrSAdTMhiPrO9dxPvSK9Q77/ClxxnpMtayt5W6ZeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=myfOtFTA; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709580090; x=1741116090;
  h=message-id:date:mime-version:from:subject:to:cc:
   references:in-reply-to:content-transfer-encoding;
  bh=gfzpyk4WN6ewW9O6enJ5VcMMfIdDNkBC5+aZc3+Hi+U=;
  b=myfOtFTAFf8ah+9eejHxfHOBlUK/Ko5PYbM1WSHrNWCgTzu1Oxe/VdxF
   SvqvMxsUnLwD4uB0oYRfZnZ8Esnwo7cyRiMCzUrK3hZrkkRPGBnWpFMVf
   iKrSv7+1dN3Yon1CImbaiKxdufQ28i2PaOBq6S2IrrVdRazgDO/Jk+8cT
   dPnoUamu8yzJvktQzPPKB34F0vIYeg2ARU+CkY3ka9oY/F+ub5BjUAlSP
   h5fCKk2Xh6wRjNDB4vaqxft8N8KypzAQTSmzx8XCzdKbLF91Ze8DlBLrQ
   5nJk4zL0Z45LFw682aFpcCBMR1od6RlZQ7A58NnoBB4SRAsDtSsNNssot
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11003"; a="7909174"
X-IronPort-AV: E=Sophos;i="6.06,204,1705392000"; 
   d="scan'208";a="7909174"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2024 11:21:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,204,1705392000"; 
   d="scan'208";a="9684926"
Received: from cryoung-mobl2.amr.corp.intel.com (HELO [10.212.71.160]) ([10.212.71.160])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2024 11:21:29 -0800
Message-ID: <0d1b777e-bd95-4755-8e4c-ee37640d155b@linux.intel.com>
Date: Mon, 4 Mar 2024 10:57:39 -0600
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH v5 1/4] ACPI: NHLT: Reintroduce types the table consists
 of
To: Cezary Rojewski <cezary.rojewski@intel.com>, rafael@kernel.org
Cc: linux-acpi@vger.kernel.org, robert.moore@intel.com,
 amadeuszx.slawinski@linux.intel.com, andriy.shevchenko@linux.intel.com
References: <20240304161335.1734134-1-cezary.rojewski@intel.com>
 <20240304161335.1734134-2-cezary.rojewski@intel.com>
Content-Language: en-US
In-Reply-To: <20240304161335.1734134-2-cezary.rojewski@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


> +/* Values for link_type field above */
> +
> +#define ACPI_NHLT_LINKTYPE_HDA			0
> +#define ACPI_NHLT_LINKTYPE_DSP			1
> +#define ACPI_NHLT_LINKTYPE_PDM			2
> +#define ACPI_NHLT_LINKTYPE_SSP			3
> +#define ACPI_NHLT_LINKTYPE_SLIMBUS		4
> +#define ACPI_NHLT_LINKTYPE_SDW			5
> +#define ACPI_NHLT_LINKTYPE_UAOL			6

More than half of those values are not used. Is there really any benefit
in exposing them?

NHLT is really only useful for SSP and PDM...

> +
> +/* Values for device_id field above */
> +
> +#define ACPI_NHLT_DEVICEID_DMIC			0xAE20
> +#define ACPI_NHLT_DEVICEID_BT			0xAE30
> +#define ACPI_NHLT_DEVICEID_I2S			0xAE34
> +
> +/* Values for device_type field above */
> +
> +/* Device types unique to endpoint of link_type=PDM */
> +#define ACPI_NHLT_DEVICETYPE_PDM		0
> +#define ACPI_NHLT_DEVICETYPE_PDM_SKL		1

I never understood this _SKL part. is this used?

> +/* Device types unique to endpoint of link_type=SSP */
> +#define ACPI_NHLT_DEVICETYPE_BT			0
> +#define ACPI_NHLT_DEVICETYPE_FM			1
> +#define ACPI_NHLT_DEVICETYPE_MODEM		2
> +#define ACPI_NHLT_DEVICETYPE_CODEC		4


