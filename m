Return-Path: <linux-acpi+bounces-19465-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 79950CAA99E
	for <lists+linux-acpi@lfdr.de>; Sat, 06 Dec 2025 17:02:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0025A3099A15
	for <lists+linux-acpi@lfdr.de>; Sat,  6 Dec 2025 16:02:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FF43270545;
	Sat,  6 Dec 2025 16:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mC1WvCt4"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D23BA1E1A3B;
	Sat,  6 Dec 2025 16:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765036954; cv=none; b=KgII1jQOSwF46T25bSKyDebyXweMp1cqv7XBjUsdK5Z5fdjWa3mdPeNQQuAqhTUnWFDpR/Gr+21yVRECYbA9im0HPqL3pLLIn2fuoT0kvBQi6qChhnWEQ/cqLQ4OEasBjWfEAZ7bQACHU0TegfNomwadJhgj9VQpNlK23WHgg/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765036954; c=relaxed/simple;
	bh=94q+qc1TplBd7hHy3zyI7SGEZwWr3jlomXhia+UB3uM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jSuKSSFcg15KGkizjUBxzMPmMGAj/P3nwYc/b8/TPSxmSr2wSGDaH1hveKDR3qsFYGz/ebsU2DjQp175X3y4bIxAPwy8+5WKP29umm82LW1pj71ntH5yTrruBQPVlojtwO3B7QdcnNPErg5cQ8siYFkEOwQk1R+PMtxSh3yUff0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mC1WvCt4; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1765036953; x=1796572953;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=94q+qc1TplBd7hHy3zyI7SGEZwWr3jlomXhia+UB3uM=;
  b=mC1WvCt4A+fs45rtfYYqxiINnOSsL+TMSJrkrh+pjF4uQRF7iqx7wCZ5
   pNtDpn01fUBkzGLNNpfFN7VNDUT8tucROtKw2A3Ry1sdXWJ7dbrp+Ghuy
   Vq8+2wvbxQQyjcuFofyo8uEfB48p27OMLEpj69sy9A9R1ABd0Z5bnhjcr
   zFS1pSC4BnEaxKd1bHT/FSogUV4c1tFBem62lpKxbbd+vvSZNZmnT84pW
   p/4FHBiAQiXA026AAjU+FGazJQzzDKNkoZJheAtMGNEvihxeKAhfT7bgZ
   b3dmIw86A+TegHIbt/ZCyv6/KiApCi+3/2KBcIS5QtTUmgAos8JLwR8jX
   Q==;
X-CSE-ConnectionGUID: UhEEOAvZQHuhyeObLwCgUA==
X-CSE-MsgGUID: odjSeQ/1SB+UhiL1nNQzkw==
X-IronPort-AV: E=McAfee;i="6800,10657,11634"; a="54591193"
X-IronPort-AV: E=Sophos;i="6.20,255,1758610800"; 
   d="scan'208";a="54591193"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2025 08:02:32 -0800
X-CSE-ConnectionGUID: T3T0pLcrTICNHj2wfo7sMA==
X-CSE-MsgGUID: ZMiITB9HSMGuGIBz///18A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,255,1758610800"; 
   d="scan'208";a="199995427"
Received: from dhhellew-desk2.ger.corp.intel.com (HELO localhost) ([10.245.244.204])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2025 08:02:29 -0800
Date: Sat, 6 Dec 2025 18:02:25 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Askar Safin <safinaskar@gmail.com>
Cc: Mika Westerberg <westeri@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@kernel.org>, linux-gpio@vger.kernel.org,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
	regressions@lists.linux.dev, Dell.Client.Kernel@dell.com,
	Mario Limonciello <superm1@kernel.org>, patches@lists.linux.dev,
	Askar Safin <safinaskar@zohomail.com>, stable@vger.kernel.org
Subject: Re: [PATCH] gpiolib: acpi: Add quirk for Dell Precision 7780
Message-ID: <aTRTkYMuA279jXD3@smile.fi.intel.com>
References: <20251205230724.2374682-1-safinaskar@gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251205230724.2374682-1-safinaskar@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Dec 05, 2025 at 10:32:42PM +0000, Askar Safin wrote:
> Dell Precision 7780 often wakes up on its own from suspend. Sometimes
> wake up happens immediately (i. e. within 7 seconds), sometimes it happens
> after, say, 30 minutes.

Thanks for the patch, it looks quite good. See my comments below.

...

> Reported-by: Askar Safin <safinaskar@zohomail.com>
> Tested-by: Askar Safin <safinaskar@gmail.com>

I believe it's the same person in both cases as the author of the patch.
As Bart said, just drop these tags, it makes little sense to have them.

...

> +		/*
> +		 * Spurious wakeups, likely from touchpad controller
> +		 * Dell Precision 7780
> +		 * Found in BIOS 1.24.1

Not sure if we also want BIOS version, probably it's more important than Board
Name, but okay, we may not know without trying if any other users need the same
quirk or will suffer from it (if BIOS version is different).

> +		 * Found in touchpad firmware, installed by Dell Touchpad Firmware Update Utility version 1160.4196.9, A01
> +		 * ( Dell-Touchpad-Firmware-Update-Utility_VYGNN_WIN64_1160.4196.9_A00.EXE ),
> +		 * released on 11 Jul 2024
> +		 *
> +		 * https://lore.kernel.org/linux-i2c/197ae95ffd8.dc819e60457077.7692120488609091556@zohomail.com/
> +		 */
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
> +			DMI_MATCH(DMI_PRODUCT_FAMILY, "Precision"),
> +			DMI_MATCH(DMI_PRODUCT_NAME, "Precision 7780"),
> +			DMI_MATCH(DMI_BOARD_NAME, "0C6JVW"),
> +		},
> +		.driver_data = &(struct acpi_gpiolib_dmi_quirk) {
> +			.ignore_wake = "VEN_0488:00@355",
> +		},
> +	},

With tags removed, feel free to add my
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Note, it's your responsibility to carry the given tags as long as there were
no significant changes in the patch. That said, I expect to see a v2
without your 2 tags and with mine that I gave above. No code changes for now.

-- 
With Best Regards,
Andy Shevchenko



