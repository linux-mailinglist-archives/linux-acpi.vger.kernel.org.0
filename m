Return-Path: <linux-acpi+bounces-14181-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A5CEACFAAD
	for <lists+linux-acpi@lfdr.de>; Fri,  6 Jun 2025 03:19:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 39E1E170221
	for <lists+linux-acpi@lfdr.de>; Fri,  6 Jun 2025 01:19:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E859273F9;
	Fri,  6 Jun 2025 01:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DybYdh9S"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8C5E8C0E;
	Fri,  6 Jun 2025 01:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749172737; cv=none; b=nFII+NeNNUxTPOX3GjWO2c6ahMEMKFNaRIIyq88tbtinef9jZdaYWMyNkaIJz+ew2yFX/cT/j8Qv4Q2j5Ngw6n2L3vuMBmFG2V7twrGF0bIVYYC9p3up+7f7UJdKL8Hmnlr+maWyt+YSXkeqU67AGBvLu99wKc86lwkG+tTqUcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749172737; c=relaxed/simple;
	bh=5ANy1on2fzZ35lbPi1IAXLj13vHKSzD+X1aeMjgxbOU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oNdFgbND8FzHHSe6UJmSHS9+Xirt6UdXBmb2dNUpYbTnukfvqXV3jhh3EYEH+jnpJvBONDlgpXnKJfDDLZuVm++cE1qdanrT2cYQ1oiMnV7cJkn3TpilXmkOj9UPAbzev2sST3EYVWA1O2PaAslG/U1yvpMiuO8VtZzwLWbvJkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DybYdh9S; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749172735; x=1780708735;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=5ANy1on2fzZ35lbPi1IAXLj13vHKSzD+X1aeMjgxbOU=;
  b=DybYdh9SiDVWbghBa4NAM3jt3aXdW/Zb6UOWi9q/p68r7h+AyIIHoIJY
   50AGAu8iWAxeCnuXmHGNpHNM8uwVmHFqS1hywFPL9A8XIfLJ6YbiarXrd
   fjNwrAvanivFy6bWwtOI2fGldBvMlQZYoGUh/qQOBWwRZUSj14pRYohPq
   uCBfIwzBjHISL5BwqkmV7n5Zft/AYf/8UoEMKR7SL2sj3UaSMGqfWfA5A
   ZwBcdaMl9P/TS3iR1jMKetUvNDW+XtiLVgFl0Oh4XPxk9ra4O+VbBWBOG
   vTke+nCj/6Ef8HSyw2XriFu6ih5g5sgG70R07wPhB6fuy7Ut2jZRKNLRI
   Q==;
X-CSE-ConnectionGUID: hJ9qw4P4QKqckhU+nmWrrQ==
X-CSE-MsgGUID: vU7R8ylFQC62z9p9veb//Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11455"; a="51393130"
X-IronPort-AV: E=Sophos;i="6.16,213,1744095600"; 
   d="scan'208";a="51393130"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2025 18:18:54 -0700
X-CSE-ConnectionGUID: EryJAv3KT6iDNrLgn8bU7w==
X-CSE-MsgGUID: pJlUijYkQpaQqO4YjcQajA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,213,1744095600"; 
   d="scan'208";a="146183893"
Received: from lkp-server01.sh.intel.com (HELO e8142ee1dce2) ([10.239.97.150])
  by fmviesa010.fm.intel.com with ESMTP; 05 Jun 2025 18:18:48 -0700
Received: from kbuild by e8142ee1dce2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uNLjK-0004bh-0Q;
	Fri, 06 Jun 2025 01:18:46 +0000
Date: Fri, 6 Jun 2025 09:17:59 +0800
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
Subject: Re: [PATCH v2 1/5] rust: acpi: add `acpi::DeviceId` abstraction
Message-ID: <202506060925.Thw3s9xE-lkp@intel.com>
References: <20250605162326.3659046-1-igor.korotin.linux@gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250605162326.3659046-1-igor.korotin.linux@gmail.com>

Hi Igor,

kernel test robot noticed the following build errors:

[auto build test ERROR on char-misc/char-misc-testing]
[also build test ERROR on char-misc/char-misc-next char-misc/char-misc-linus linus/master v6.15 next-20250605]
[cannot apply to rust/rust-next driver-core/driver-core-testing driver-core/driver-core-next driver-core/driver-core-linus]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Igor-Korotin/rust-acpi-add-acpi-DeviceId-abstraction/20250606-042551
base:   char-misc/char-misc-testing
patch link:    https://lore.kernel.org/r/20250605162326.3659046-1-igor.korotin.linux%40gmail.com
patch subject: [PATCH v2 1/5] rust: acpi: add `acpi::DeviceId` abstraction
config: x86_64-rhel-9.4-rust (https://download.01.org/0day-ci/archive/20250606/202506060925.Thw3s9xE-lkp@intel.com/config)
compiler: clang version 18.1.8 (https://github.com/llvm/llvm-project 3b5b5c1ec4a3095ab096dd780e84d7ab81f3d7ff)
rustc: rustc 1.78.0 (9b00956e5 2024-04-29)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250606/202506060925.Thw3s9xE-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202506060925.Thw3s9xE-lkp@intel.com/

All errors (new ones prefixed by >>):

   PATH=/opt/cross/clang-18/bin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
   INFO PATH=/opt/cross/rustc-1.78.0-bindgen-0.65.1/cargo/bin:/opt/cross/clang-18/bin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
   /usr/bin/timeout -k 100 12h /usr/bin/make KCFLAGS= -Wno-error=return-type -Wreturn-type -funsigned-char -Wundef W=1 --keep-going LLVM=1 -j32 -C source O=/kbuild/obj/consumer/x86_64-rhel-9.4-rust ARCH=x86_64 SHELL=/bin/bash rustfmtcheck
   make: Entering directory '/kbuild/src/consumer'
   make[1]: Entering directory '/kbuild/obj/consumer/x86_64-rhel-9.4-rust'
>> Diff in rust/kernel/acpi.rs at line 59:
            $crate::module_device_table!("acpi", $module_table_name, $table_name);
        };
    }
   -
    
>> Diff in rust/kernel/acpi.rs at line 59:
            $crate::module_device_table!("acpi", $module_table_name, $table_name);
        };
    }
   -
    
   make[2]: *** [Makefile:1826: rustfmt] Error 123
   make[2]: Target 'rustfmtcheck' not remade because of errors.
   make[1]: Leaving directory '/kbuild/obj/consumer/x86_64-rhel-9.4-rust'
   make[1]: *** [Makefile:248: __sub-make] Error 2
   make[1]: Target 'rustfmtcheck' not remade because of errors.
   make: *** [Makefile:248: __sub-make] Error 2
   make: Target 'rustfmtcheck' not remade because of errors.
   make: Leaving directory '/kbuild/src/consumer'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

