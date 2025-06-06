Return-Path: <linux-acpi+bounces-14184-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 684D8ACFBF3
	for <lists+linux-acpi@lfdr.de>; Fri,  6 Jun 2025 06:28:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC8BC189948F
	for <lists+linux-acpi@lfdr.de>; Fri,  6 Jun 2025 04:28:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D9361DE887;
	Fri,  6 Jun 2025 04:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ihkyY6R/"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C15D3234;
	Fri,  6 Jun 2025 04:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749184095; cv=none; b=cek1S1Mti4O69g9XDwozkx1nHRdd9B887A1SqngxJh0a90uYoWKKD6JB4SyTNGvkTdnAk2iZ2k/MyllLR+c7KVMCiZT3q6N8hzd4ICMitotFFrUt3y3ZOIgGX80xktPxwkXr5mCYV3dOJMfyaW8ESxwo4MjLiV9e/TKKHdyJi3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749184095; c=relaxed/simple;
	bh=9Gyg33hqhbnXrEaxdUutoGy/DPXrhX0kl0SjpeBRIB0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZTiiNZWBOFbLmz6+MRDrK1PuhgOmOI3ox+6qP96SNr5asw+UvW5B+RlyJCm6NRXuQ09Dyix817dPLB9yMvqwwZjf2VQtX3d1rkzXtkb/9Q2FiMxDFceHX2p42pl1fxdnUq2fcdana3SpMT3/exURh28BuJo/kEqNu7/snw4ogW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ihkyY6R/; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749184093; x=1780720093;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=9Gyg33hqhbnXrEaxdUutoGy/DPXrhX0kl0SjpeBRIB0=;
  b=ihkyY6R/rx23xzFpcSFeS5fcVOmvy3JJb+sM1sh4T4wF4P0P6TL2oxFk
   25ATTZEQrTKJ2Ij5OxxgHo+/OVaKKAEGq/uS2q9pMoW/wdyqQoyerdJEU
   EpNSOMhRx9JfOyLx3x7UeSIpKS0Ko9E94m6w0LmMHnStMJwWFSjE9FZpY
   zCvIGpFsajBLegiWbTQRlvL6ovreAk35tXOZhrv8y310/s4AZCywU1Fzp
   nTIeghPYvEFJfJxwAdLmg/hgGu+1NbALBluADCUkXN27fk0fWlZyhAW27
   giZRpG147L0CbQ4SU2tUnPndq7o4fvsyZ+KGR6tvXonKc5yBjElGDzDsw
   w==;
X-CSE-ConnectionGUID: J4R0TdOETTS74TgeX6YoOA==
X-CSE-MsgGUID: vOj2DCx1RY62uBtpmk2o5g==
X-IronPort-AV: E=McAfee;i="6800,10657,11455"; a="38958111"
X-IronPort-AV: E=Sophos;i="6.16,214,1744095600"; 
   d="scan'208";a="38958111"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2025 21:28:12 -0700
X-CSE-ConnectionGUID: /C4I0hPvTW6lOY9red7p/g==
X-CSE-MsgGUID: KDyzMU7zSQy32t/M5w9/aA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,214,1744095600"; 
   d="scan'208";a="145653438"
Received: from lkp-server01.sh.intel.com (HELO e8142ee1dce2) ([10.239.97.150])
  by fmviesa007.fm.intel.com with ESMTP; 05 Jun 2025 21:28:07 -0700
Received: from kbuild by e8142ee1dce2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uNOgX-0004jp-0d;
	Fri, 06 Jun 2025 04:28:05 +0000
Date: Fri, 6 Jun 2025 12:27:24 +0800
From: kernel test robot <lkp@intel.com>
To: Ricardo Ribalda <ribalda@chromium.org>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Hans de Goede <hdegoede@redhat.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Hans Verkuil <hverkuil@xs4all.nl>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
	devicetree@vger.kernel.org, linux-gpio@vger.kernel.org,
	linux-acpi@vger.kernel.org, Ricardo Ribalda <ribalda@chromium.org>
Subject: Re: [PATCH v2 04/12] media: ipu-bridge: Use v4l2_fwnode_device_parse
 helper
Message-ID: <202506061223.m9fBRBFN-lkp@intel.com>
References: <20250605-uvc-orientation-v2-4-5710f9d030aa@chromium.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250605-uvc-orientation-v2-4-5710f9d030aa@chromium.org>

Hi Ricardo,

kernel test robot noticed the following build errors:

[auto build test ERROR on 5e1ff2314797bf53636468a97719a8222deca9ae]

url:    https://github.com/intel-lab-lkp/linux/commits/Ricardo-Ribalda/media-uvcvideo-Always-set-default_value/20250606-015643
base:   5e1ff2314797bf53636468a97719a8222deca9ae
patch link:    https://lore.kernel.org/r/20250605-uvc-orientation-v2-4-5710f9d030aa%40chromium.org
patch subject: [PATCH v2 04/12] media: ipu-bridge: Use v4l2_fwnode_device_parse helper
config: riscv-randconfig-002-20250606 (https://download.01.org/0day-ci/archive/20250606/202506061223.m9fBRBFN-lkp@intel.com/config)
compiler: riscv64-linux-gcc (GCC) 8.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250606/202506061223.m9fBRBFN-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202506061223.m9fBRBFN-lkp@intel.com/

All errors (new ones prefixed by >>, old ones prefixed by <<):

WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/fpga/tests/fpga-mgr-test.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/fpga/tests/fpga-bridge-test.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/fpga/tests/fpga-region-test.o
>> ERROR: modpost: "v4l2_fwnode_device_parse" [drivers/media/pci/intel/ipu-bridge.ko] undefined!

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

