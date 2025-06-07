Return-Path: <linux-acpi+bounces-14213-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A6A3AD0B74
	for <lists+linux-acpi@lfdr.de>; Sat,  7 Jun 2025 08:29:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A7D427A3169
	for <lists+linux-acpi@lfdr.de>; Sat,  7 Jun 2025 06:28:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66B5C1D63EF;
	Sat,  7 Jun 2025 06:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="no19+9x/"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4D3C1CFBA;
	Sat,  7 Jun 2025 06:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749277762; cv=none; b=soQ1nLam8xr/j3e/zuKPMgo75gNwRsxYjED1ArvgJO5Y+QiOsu9weUOCWoglfAXGIeljsJ1d2/EQ9hkOwYITXYwWVKSOWXvTiVJkoAhC3EknRV9fSyl6lcmWe++Ko8L9dYVZ4LlDW2PXcbMZrIkjAPP7f93CEdagSROLFTJnzhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749277762; c=relaxed/simple;
	bh=KhvKf0Okp3+QNBDD1wYxSwtwa9jnFP0ZRb0MhxFICkI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PeE0O/bIKGHTD/cH4kkgbNPfa0fPRPhp5MSqNOcvYcEMtT67bsbQJGieReXJak63xt9BaKgIoGOdnEB8spfAQFEyAeCPHaFCzfs+9TniE18scxH/m5IeuQ00o7C65oWd/evJcZwxK43+7rr2wdvRMST5TjqrdC3CJ1JAdfuN9hA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=no19+9x/; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749277761; x=1780813761;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=KhvKf0Okp3+QNBDD1wYxSwtwa9jnFP0ZRb0MhxFICkI=;
  b=no19+9x/smLMeEg9UWKTMN14yOPnm+TohXyjoBGXTHnOZW848Jsz0m/D
   kUvqmYcA8Au0ExBd+ru30GSsAzhL3kkVSF+CJc23XmKsqq4BGSCYQ9jSX
   nSm0cZGRrVSQfNYVDJ6V3CsNFTXSeAr2WdHYsWIBhaOeThsU3DKxv1A7I
   Ot6a5lU0ntRujDaWXPMGYQTaVefwVJM1Yz0dstFXS7gJ9pmSPUSr/3RUv
   J0XZOurSxw9bGzM5EvctWOHJnpQcWToCIVyPu/Zh2mBjfW2PwR7XvYrtl
   JS806qox96C/yaevWEnqJYJ/2lmyCNqCpnl34rHA+M5eWDNRPoYFr0HZz
   g==;
X-CSE-ConnectionGUID: DX6FVW1XRjqRxpexeCefcg==
X-CSE-MsgGUID: A+rlKyuRRbSAMyPYLsljJQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11456"; a="62467108"
X-IronPort-AV: E=Sophos;i="6.16,217,1744095600"; 
   d="scan'208";a="62467108"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2025 23:29:21 -0700
X-CSE-ConnectionGUID: jSw2Kz1UTMKFrurAeGYqiw==
X-CSE-MsgGUID: fzAZ/6riTQ+nfI23zMxFBw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,217,1744095600"; 
   d="scan'208";a="146534373"
Received: from lkp-server01.sh.intel.com (HELO e8142ee1dce2) ([10.239.97.150])
  by fmviesa010.fm.intel.com with ESMTP; 06 Jun 2025 23:29:16 -0700
Received: from kbuild by e8142ee1dce2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uNn3J-0005VN-0f;
	Sat, 07 Jun 2025 06:29:13 +0000
Date: Sat, 7 Jun 2025 14:28:37 +0800
From: kernel test robot <lkp@intel.com>
To: Igor Korotin <igor.korotin.linux@gmail.com>, ojeda@kernel.org,
	alex.gaynor@gmail.com, rafael@kernel.org,
	gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org, linux-acpi@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com,
	benno.lossin@proton.me, a.hindborg@kernel.org, aliceryhl@google.com,
	tmgross@umich.edu, dakr@kernel.org, lenb@kernel.org,
	wedsonaf@gmail.com, viresh.kumar@linaro.org, alex.hung@amd.com,
	dingxiangfei2009@gmail.com
Subject: Re: [PATCH v3 3/4] rust: platform: Add ACPI match table support to
 `Driver` trait
Message-ID: <202506071640.KIUrSBGt-lkp@intel.com>
References: <20250606170905.3881900-1-igor.korotin.linux@gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250606170905.3881900-1-igor.korotin.linux@gmail.com>

Hi Igor,

kernel test robot noticed the following build errors:

[auto build test ERROR on 9857af0fcff385c75433f2162c30c62eb912ef6d]

url:    https://github.com/intel-lab-lkp/linux/commits/Igor-Korotin/rust-acpi-add-acpi-DeviceId-abstraction/20250607-011123
base:   9857af0fcff385c75433f2162c30c62eb912ef6d
patch link:    https://lore.kernel.org/r/20250606170905.3881900-1-igor.korotin.linux%40gmail.com
patch subject: [PATCH v3 3/4] rust: platform: Add ACPI match table support to `Driver` trait
config: x86_64-buildonly-randconfig-001-20250607 (https://download.01.org/0day-ci/archive/20250607/202506071640.KIUrSBGt-lkp@intel.com/config)
compiler: clang version 20.1.2 (https://github.com/llvm/llvm-project 58df0ef89dd64126512e4ee27b4ac3fd8ddf6247)
rustc: rustc 1.78.0 (9b00956e5 2024-04-29)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250607/202506071640.KIUrSBGt-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202506071640.KIUrSBGt-lkp@intel.com/

All errors (new ones prefixed by >>):

>> error[E0425]: cannot find value `ACPI_TABLE` in this scope
   --> rust/doctests_kernel_generated.rs:3527:71
   |
   3527 |      const ACPI_ID_TABLE: Option<acpi::IdTable<Self::IdInfo>> = Some(&ACPI_TABLE);
   |                                                                       ^^^^^^^^^^ not found in this scope

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

