Return-Path: <linux-acpi+bounces-597-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D7A57C5E72
	for <lists+linux-acpi@lfdr.de>; Wed, 11 Oct 2023 22:36:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 774F81C20A7C
	for <lists+linux-acpi@lfdr.de>; Wed, 11 Oct 2023 20:36:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D516C219FE
	for <lists+linux-acpi@lfdr.de>; Wed, 11 Oct 2023 20:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="R3P1qcKY"
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B289212E64
	for <linux-acpi@vger.kernel.org>; Wed, 11 Oct 2023 19:19:33 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A861A92
	for <linux-acpi@vger.kernel.org>; Wed, 11 Oct 2023 12:19:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697051971; x=1728587971;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=UHqMhmNK8/htFSTg2JYqqH8j5mmsDz2UJ5n2D2v/9Ys=;
  b=R3P1qcKYohXrB34CP+kBCaLn/jLc2N7ohSz9A4KkWB1Lc58vmM/+XbuC
   WAB5uUSS5MwTjvYJc+8HsRq/cnAzUyOxxD/qGxMqnriescfMCeyxzMWUD
   7HOUZKWph7fi00Ixuu1JjLbnQzKCfQr/FVd3cataltAvkXllCLA9Up+3T
   JRpGO5HyTVdYa3wetYC225s+LrjQmOYRzb1XTZOkEEn9k/cCzRC3vNDqU
   76ahrkUUjz9rVLWFhQe1cKcFBBWff8jU6rkGFV5exKESo5TWZET3U4QX2
   9kmlJXwNWaxfj8eGY4S6d2Z3KBeGHj0avhSNiA3iV0GQ/q1cdO95ZU/eK
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10860"; a="384598488"
X-IronPort-AV: E=Sophos;i="6.03,216,1694761200"; 
   d="scan'208";a="384598488"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2023 12:19:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10860"; a="897769433"
X-IronPort-AV: E=Sophos;i="6.03,216,1694761200"; 
   d="scan'208";a="897769433"
Received: from lkp-server02.sh.intel.com (HELO f64821696465) ([10.239.97.151])
  by fmsmga001.fm.intel.com with ESMTP; 11 Oct 2023 12:17:43 -0700
Received: from kbuild by f64821696465 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1qqejv-0002cT-0a;
	Wed, 11 Oct 2023 19:19:27 +0000
Date: Thu, 12 Oct 2023 03:18:51 +0800
From: kernel test robot <lkp@intel.com>
To: Ken Xue <Ken.Xue@amd.com>, andriy.shevchenko@linux.intel.com,
	linux-acpi@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, rafael@kernel.org, cwhuang@linux.org.tw,
	Ken Xue <Ken.Xue@amd.com>
Subject: Re: [PATCH V5] acpi: trigger wakeup key event from power button
Message-ID: <202310120000.LkRVKBZN-lkp@intel.com>
References: <20231007075433.555715-1-Ken.Xue@amd.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231007075433.555715-1-Ken.Xue@amd.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
	SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi Ken,

kernel test robot noticed the following build errors:

[auto build test ERROR on b483d3b8a54a544ab8854ca6dbb8d99c423b3ba4]

url:    https://github.com/intel-lab-lkp/linux/commits/Ken-Xue/acpi-trigger-wakeup-key-event-from-power-button/20231007-163549
base:   b483d3b8a54a544ab8854ca6dbb8d99c423b3ba4
patch link:    https://lore.kernel.org/r/20231007075433.555715-1-Ken.Xue%40amd.com
patch subject: [PATCH V5] acpi: trigger wakeup key event from power button
config: loongarch-randconfig-002-20231011 (https://download.01.org/0day-ci/archive/20231012/202310120000.LkRVKBZN-lkp@intel.com/config)
compiler: loongarch64-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231012/202310120000.LkRVKBZN-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202310120000.LkRVKBZN-lkp@intel.com/

All errors (new ones prefixed by >>):

   loongarch64-linux-ld: drivers/acpi/button.o: in function `acpi_power_button_wakeup':
>> button.c:(.text+0x44): undefined reference to `input_event'
>> loongarch64-linux-ld: button.c:(.text+0x58): undefined reference to `input_event'
   loongarch64-linux-ld: button.c:(.text+0x6c): undefined reference to `input_event'
   loongarch64-linux-ld: button.c:(.text+0x8c): undefined reference to `input_event'
   loongarch64-linux-ld: drivers/acpi/button.o: in function `acpi_button_notify':
   button.c:(.text+0x200): undefined reference to `input_event'
   loongarch64-linux-ld: drivers/acpi/button.o:button.c:(.text+0x214): more undefined references to `input_event' follow
   loongarch64-linux-ld: drivers/acpi/button.o: in function `.L42':
>> button.c:(.text+0x3ac): undefined reference to `input_allocate_device'
   loongarch64-linux-ld: drivers/acpi/button.o: in function `.L52':
>> button.c:(.text+0x60c): undefined reference to `input_free_device'
   loongarch64-linux-ld: drivers/acpi/button.o: in function `.L53':
>> button.c:(.text+0x67c): undefined reference to `input_set_capability'
>> loongarch64-linux-ld: button.c:(.text+0x68c): undefined reference to `input_set_capability'
   loongarch64-linux-ld: drivers/acpi/button.o: in function `.L58':
   button.c:(.text+0x6a0): undefined reference to `input_set_capability'
   loongarch64-linux-ld: drivers/acpi/button.o: in function `.L59':
   button.c:(.text+0x6b4): undefined reference to `input_set_capability'
   loongarch64-linux-ld: drivers/acpi/button.o: in function `.L60':
>> button.c:(.text+0x6c0): undefined reference to `input_register_device'
   loongarch64-linux-ld: drivers/acpi/button.o: in function `.L63':
>> button.c:(.text+0x6e0): undefined reference to `input_unregister_device'
   loongarch64-linux-ld: drivers/acpi/button.o: in function `.L87':
   button.c:(.text+0x7f8): undefined reference to `input_unregister_device'
   loongarch64-linux-ld: drivers/acpi/button.o: in function `.L99':
   button.c:(.text+0x89c): undefined reference to `input_event'
   loongarch64-linux-ld: button.c:(.text+0x8b0): undefined reference to `input_event'
   loongarch64-linux-ld: drivers/acpi/button.o: in function `.L97':
   button.c:(.text+0x8c4): undefined reference to `input_event'
   loongarch64-linux-ld: button.c:(.text+0x8d8): undefined reference to `input_event'

Kconfig warnings: (for reference only)
   WARNING: unmet direct dependencies detected for ACPI_BUTTON
   Depends on [m]: ACPI [=y] && INPUT [=m]
   Selected by [y]:
   - ACPI_SYSTEM_POWER_STATES_SUPPORT [=y] && ACPI [=y]

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

