Return-Path: <linux-acpi+bounces-14182-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A722ACFADF
	for <lists+linux-acpi@lfdr.de>; Fri,  6 Jun 2025 03:51:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 50D5A178ADD
	for <lists+linux-acpi@lfdr.de>; Fri,  6 Jun 2025 01:51:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93A051A3029;
	Fri,  6 Jun 2025 01:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FzAMIT6z"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AE9F195FE8;
	Fri,  6 Jun 2025 01:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749174659; cv=none; b=QpnrdkGzejRjY0IhILN+rRhd/fk/wgnXCUXwH7xQyBw40URVe1SXhdk90gUsOYIfA6Bxrv7wlcoaeQwJUljYiTZWQDzvQBPkc50tquHccto3mJEZ/sgTzNZxNbz+HVJaL8nJXUJwyoV9rjrzpri7SF1TDmO5LiFpFfXZDD9pS20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749174659; c=relaxed/simple;
	bh=N05hR/hxwfDBOUnGdQrZDfk14X/CwEcpp+IGoFxatVU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sWV5/pCfUh1vWdEfmmtQSHATm24GI8+3b17WLl9IdRoggRPU+7kpii6ieCB/mbw9gpWz9GeGbVBsVo8xsR+PyffSNS+JyCMHFQcSTblqPPCnX7BZyXj6Z+6Om528LxgHqy3GcE9SjW5/GrLDmPk0zvoueU9F9wj0S892TCTF4Wk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FzAMIT6z; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749174657; x=1780710657;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=N05hR/hxwfDBOUnGdQrZDfk14X/CwEcpp+IGoFxatVU=;
  b=FzAMIT6z/ZGGrYPlWDRiOyovF7htXFx9E+JGwKULkhWwNmaZ0oeZm0ql
   QRm3vmw4PQ/VMbBuM5dG9a9G1+T1WN+p+DmDp/8C4riWJqZmSf3uc0SBF
   7serjF7xQL2SlKMnMfbq3+XBOWUoGIYy3Ppheml46oULexlBKmf20JEnr
   ORYrdAln82cKVIWX5lEE/K5Ssb6ehDTGOwK1QgOvuUMiMK0HleeDKHTCX
   RVsGyGuC1R0rsrBj07qfU0W7WdbNqlN/MQcoQRELeIMwvyHdB4z26S3Xe
   qb7k8zrmD2aq+aGgYawcYfoEn53IZZdj+g/2y8hZorirTfiAglcj/KXM7
   Q==;
X-CSE-ConnectionGUID: lYNSpG20T8un92epqQphlg==
X-CSE-MsgGUID: vYZWQZyCQCCLLmFerFnY5A==
X-IronPort-AV: E=McAfee;i="6800,10657,11455"; a="51020260"
X-IronPort-AV: E=Sophos;i="6.16,213,1744095600"; 
   d="scan'208";a="51020260"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2025 18:50:57 -0700
X-CSE-ConnectionGUID: HG5uRUl6TOafNSK4RUho7w==
X-CSE-MsgGUID: rFJR7U6qTuizDoxEFvDV1Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,213,1744095600"; 
   d="scan'208";a="150514856"
Received: from lkp-server01.sh.intel.com (HELO e8142ee1dce2) ([10.239.97.150])
  by orviesa003.jf.intel.com with ESMTP; 05 Jun 2025 18:50:52 -0700
Received: from kbuild by e8142ee1dce2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uNMEL-0004dV-0J;
	Fri, 06 Jun 2025 01:50:49 +0000
Date: Fri, 6 Jun 2025 09:50:46 +0800
From: kernel test robot <lkp@intel.com>
To: Igor Korotin <igor.korotin.linux@gmail.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>, Rob Herring <robh@kernel.org>,
	Saravana Kannan <saravanak@google.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-acpi@vger.kernel.org, devicetree@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>, Len Brown <lenb@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Wedson Almeida Filho <wedsonaf@gmail.com>,
	Alex Hung <alex.hung@amd.com>, Tamir Duberstein <tamird@gmail.com>,
	FUJITA Tomonori <fujita.tomonori@gmail.com>,
	Xiangfei Ding <dingxiangfei2009@gmail.com>,
	Igor Korotin <igor.korotin.linux@gmail.com>
Subject: Re: [PATCH v2 3/5] rust: driver: Add ACPI id table support to
 Adapter trait
Message-ID: <202506060941.Q8GECvnj-lkp@intel.com>
References: <20250605165109.3663553-1-igor.korotin.linux@gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250605165109.3663553-1-igor.korotin.linux@gmail.com>

Hi Igor,

kernel test robot noticed the following build errors:

[auto build test ERROR on char-misc/char-misc-testing]
[also build test ERROR on char-misc/char-misc-next char-misc/char-misc-linus v6.15]
[cannot apply to rust/rust-next driver-core/driver-core-testing driver-core/driver-core-next driver-core/driver-core-linus linus/master next-20250605]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Igor-Korotin/rust-acpi-add-acpi-DeviceId-abstraction/20250606-042551
base:   char-misc/char-misc-testing
patch link:    https://lore.kernel.org/r/20250605165109.3663553-1-igor.korotin.linux%40gmail.com
patch subject: [PATCH v2 3/5] rust: driver: Add ACPI id table support to Adapter trait
config: x86_64-rhel-9.4-rust (https://download.01.org/0day-ci/archive/20250606/202506060941.Q8GECvnj-lkp@intel.com/config)
compiler: clang version 18.1.8 (https://github.com/llvm/llvm-project 3b5b5c1ec4a3095ab096dd780e84d7ab81f3d7ff)
rustc: rustc 1.78.0 (9b00956e5 2024-04-29)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250606/202506060941.Q8GECvnj-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202506060941.Q8GECvnj-lkp@intel.com/

All errors (new ones prefixed by >>):

   PATH=/opt/cross/clang-18/bin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
   INFO PATH=/opt/cross/rustc-1.78.0-bindgen-0.65.1/cargo/bin:/opt/cross/clang-18/bin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
   /usr/bin/timeout -k 100 12h /usr/bin/make KCFLAGS= -Wno-error=return-type -Wreturn-type -funsigned-char -Wundef W=1 --keep-going LLVM=1 -j32 -C source O=/kbuild/obj/consumer/x86_64-rhel-9.4-rust ARCH=x86_64 SHELL=/bin/bash rustfmtcheck
   make: Entering directory '/kbuild/src/consumer'
   make[1]: Entering directory '/kbuild/obj/consumer/x86_64-rhel-9.4-rust'
   Diff in rust/kernel/acpi.rs at line 59:
            $crate::module_device_table!("acpi", $module_table_name, $table_name);
        };
    }
   -
    
>> Diff in rust/kernel/driver.rs at line 6:
    //! register using the [`Registration`] class.
    
>>  use crate::error::{Error, Result};
   -use crate::{device, of, acpi, str::CStr, try_pin_init, types::Opaque, ThisModule};
   +use crate::{acpi, device, of, str::CStr, try_pin_init, types::Opaque, ThisModule};
    use core::pin::Pin;
    use pin_init::{pin_data, pinned_drop, PinInit};
    
   Diff in rust/kernel/driver.rs at line 211:
        /// associated with a [`device::Device`].
        fn id_info(dev: &device::Device) -> Option<&'static Self::IdInfo> {
            // SAFETY: `id_info` is called from `Adapter::probe_callback` with a valid `dev` argument.
   -        let fwnode = unsafe{ (*dev.as_raw()).fwnode};
   +        let fwnode = unsafe { (*dev.as_raw()).fwnode };
    
            // SAFETY: `bindings::is_acpi_device_node` checks `fwnode` before accessing `fwnode->ops`,
            // and only compares it with the address of `acpi_device_fwnode_ops`.
>> Diff in rust/kernel/platform.rs at line 5:
    //! C header: [`include/linux/platform_device.h`](srctree/include/linux/platform_device.h)
    
    use crate::{
   -    acpi,
   -    bindings, device, driver,
   +    acpi, bindings, device, driver,
        error::{to_result, Result},
        of,
        prelude::*,
   Diff in rust/kernel/acpi.rs at line 59:
            $crate::module_device_table!("acpi", $module_table_name, $table_name);
        };
    }
   -
    
>> Diff in rust/kernel/platform.rs at line 5:
    //! C header: [`include/linux/platform_device.h`](srctree/include/linux/platform_device.h)
    
    use crate::{
   -    acpi,
   -    bindings, device, driver,
   +    acpi, bindings, device, driver,
        error::{to_result, Result},
        of,
        prelude::*,
>> Diff in rust/kernel/driver.rs at line 6:
    //! register using the [`Registration`] class.
    
>>  use crate::error::{Error, Result};
   -use crate::{device, of, acpi, str::CStr, try_pin_init, types::Opaque, ThisModule};
   +use crate::{acpi, device, of, str::CStr, try_pin_init, types::Opaque, ThisModule};
    use core::pin::Pin;
    use pin_init::{pin_data, pinned_drop, PinInit};
    
   Diff in rust/kernel/driver.rs at line 211:
        /// associated with a [`device::Device`].
        fn id_info(dev: &device::Device) -> Option<&'static Self::IdInfo> {
            // SAFETY: `id_info` is called from `Adapter::probe_callback` with a valid `dev` argument.
   -        let fwnode = unsafe{ (*dev.as_raw()).fwnode};
   +        let fwnode = unsafe { (*dev.as_raw()).fwnode };
    
            // SAFETY: `bindings::is_acpi_device_node` checks `fwnode` before accessing `fwnode->ops`,
            // and only compares it with the address of `acpi_device_fwnode_ops`.
   make[1]: Leaving directory '/kbuild/obj/consumer/x86_64-rhel-9.4-rust'
   make[2]: *** [Makefile:1826: rustfmt] Error 123
   make[1]: *** [Makefile:248: __sub-make] Error 2
   make[2]: Target 'rustfmtcheck' not remade because of errors.
   make[1]: Target 'rustfmtcheck' not remade because of errors.
   make: *** [Makefile:248: __sub-make] Error 2
   make: Target 'rustfmtcheck' not remade because of errors.
   make: Leaving directory '/kbuild/src/consumer'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

