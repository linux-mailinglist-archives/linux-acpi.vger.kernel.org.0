Return-Path: <linux-acpi+bounces-17376-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 76F28BA666F
	for <lists+linux-acpi@lfdr.de>; Sun, 28 Sep 2025 04:41:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B314F189AB5D
	for <lists+linux-acpi@lfdr.de>; Sun, 28 Sep 2025 02:42:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 885A3246773;
	Sun, 28 Sep 2025 02:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jiZ0EPF+"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A1F92EAE3;
	Sun, 28 Sep 2025 02:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759027309; cv=none; b=CnrYhA69iW+zTE1LsBy9avyQ/RVf8jmY1mmxqXLtyM0dl+hfqWCY1ZGXeAB3punTJkt++3/DSqN7q31IYPBrQewtIHN/Po/kRyS9JM6hRWd5Z+XlYhFXMDCvqcDosI7Umdjlhv/rZ7u/oFfX/MTiBOfFU0Ko2rYa2E9PtJrV5xM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759027309; c=relaxed/simple;
	bh=db4TECFXLKKxoml+/1ANgAREeYxKSZ8KoIcUM3RKyVI=;
	h=Date:From:To:Cc:Subject:Message-ID; b=Ai4l6/V1LG8iJA6cBUASTdPwRTRL/rj5jgSU2idVUijdJzirnkpRCrSBHvaCZZQezi8Yyy8g6c3zRs2QEJw6P6yR29GFBUbZz4ZlABikXa6ZzLX5YKvWn1yqw9R8XFHz0vkgxJAVVRXTn6uWFBZWZPnGl6LkTShTxg2zYAHVRus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jiZ0EPF+; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1759027307; x=1790563307;
  h=date:from:to:cc:subject:message-id;
  bh=db4TECFXLKKxoml+/1ANgAREeYxKSZ8KoIcUM3RKyVI=;
  b=jiZ0EPF+sftn+SAklbcw7ipw/aSqzbmc62zPP13mBghQfdCWf9WCprH5
   1co/AHS+I9AaVQQHi5s2zw3hVeafVfBAwI1TZVk4Riiri7GvCLODI1LgW
   i+0rncYPf5kGlQrBFW5g51HW1ItiPGltevVezHqyZCJGKbMISLUEgCXsf
   BiiXcHB+XkCMjtreS+auXdYFuJ6lFf4Q4XSxrOCs8j9wrOUPKXuD9cssi
   arPd8Y4QiqDorVcNncIqnZE77oh9/95Pz5X5BSI1KSpOmhGlXHveLJous
   6FV8S9ti0Ebh4T6ladpitRjIDlU5rpqQD+AlvD8S6UjNswA67dIPGvngm
   g==;
X-CSE-ConnectionGUID: 09V+dKLRRQ2QrxPb4Krc6Q==
X-CSE-MsgGUID: VikuzAWMRrqsD+Mtbk1XAQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="65123262"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="65123262"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2025 19:41:46 -0700
X-CSE-ConnectionGUID: prHibRQ7THmdKmK/mvlU5w==
X-CSE-MsgGUID: T8MDDhaQTgSfwJ2NoQ3eGw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,298,1751266800"; 
   d="scan'208";a="177058699"
Received: from lkp-server02.sh.intel.com (HELO 84c55410ccf6) ([10.239.97.151])
  by orviesa006.jf.intel.com with ESMTP; 27 Sep 2025 19:41:45 -0700
Received: from kbuild by 84c55410ccf6 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1v2hM6-0007Tz-0v;
	Sun, 28 Sep 2025 02:41:42 +0000
Date: Sun, 28 Sep 2025 10:41:03 +0800
From: kernel test robot <lkp@intel.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org
Subject: [rafael-pm:bleeding-edge] BUILD REGRESSION
 95b83771c9f38207ff42311ccc4739db76d19f33
Message-ID: <202509281031.vIbhNy5N-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
branch HEAD: 95b83771c9f38207ff42311ccc4739db76d19f33  Merge branch 'pm-core-next' into bleeding-edge

Error/Warning (recently discovered and may have been fixed):

    https://lore.kernel.org/oe-kbuild-all/202509280052.07wgnjdw-lkp@intel.com
    https://lore.kernel.org/oe-kbuild-all/202509280108.zOEjD8fx-lkp@intel.com

    drivers/acpi/battery.c:1267:2: warning: label followed by a declaration is a C23 extension [-Wc23-extensions]
    drivers/cpufreq/cpufreq-dt.c:107:24: error: use of undeclared identifier 'CPUFREQ_DEFAULT_TRANSITION_LATENCY_NS'
    drivers/cpufreq/cpufreq-dt.c:107:38: error: 'CPUFREQ_DEFAULT_TRANSITION_LATENCY_NS' undeclared (first use in this function); did you mean 'CPUFREQ_DEFAULT_TANSITION_LATENCY_NS'?
    drivers/cpufreq/imx6q-cpufreq.c:445:24: error: use of undeclared identifier 'CPUFREQ_DEFAULT_TRANSITION_LATENCY_NS'
    drivers/cpufreq/mediatek-cpufreq-hw.c:312:13: error: use of undeclared identifier 'CPUFREQ_DEFAULT_TRANSITION_LATENCY_NS'
    drivers/cpufreq/mediatek-cpufreq-hw.c:312:27: error: 'CPUFREQ_DEFAULT_TRANSITION_LATENCY_NS' undeclared (first use in this function); did you mean 'CPUFREQ_DEFAULT_TANSITION_LATENCY_NS'?
    drivers/cpufreq/scmi-cpufreq.c:297:13: error: use of undeclared identifier 'CPUFREQ_DEFAULT_TRANSITION_LATENCY_NS'
    drivers/cpufreq/scmi-cpufreq.c:297:27: error: 'CPUFREQ_DEFAULT_TRANSITION_LATENCY_NS' undeclared (first use in this function); did you mean 'CPUFREQ_DEFAULT_TANSITION_LATENCY_NS'?
    drivers/cpufreq/scpi-cpufreq.c:160:13: error: use of undeclared identifier 'CPUFREQ_DEFAULT_TRANSITION_LATENCY_NS'
    drivers/cpufreq/scpi-cpufreq.c:160:27: error: 'CPUFREQ_DEFAULT_TRANSITION_LATENCY_NS' undeclared (first use in this function); did you mean 'CPUFREQ_DEFAULT_TANSITION_LATENCY_NS'?
    drivers/cpufreq/spear-cpufreq.c:185:38: error: use of undeclared identifier 'CPUFREQ_DEFAULT_TRANSITION_LATENCY_NS'
    drivers/cpufreq/spear-cpufreq.c:185:52: error: 'CPUFREQ_DEFAULT_TRANSITION_LATENCY_NS' undeclared (first use in this function); did you mean 'CPUFREQ_DEFAULT_TANSITION_LATENCY_NS'?
    error[E0425]: cannot find value `CPUFREQ_DEFAULT_TRANSITION_LATENCY_NS` in crate `bindings`

Error/Warning ids grouped by kconfigs:

recent_errors
|-- arm-allmodconfig
|   |-- drivers-cpufreq-cpufreq-dt.c:error:CPUFREQ_DEFAULT_TRANSITION_LATENCY_NS-undeclared-(first-use-in-this-function)
|   |-- drivers-cpufreq-mediatek-cpufreq-hw.c:error:CPUFREQ_DEFAULT_TRANSITION_LATENCY_NS-undeclared-(first-use-in-this-function)
|   |-- drivers-cpufreq-scmi-cpufreq.c:error:CPUFREQ_DEFAULT_TRANSITION_LATENCY_NS-undeclared-(first-use-in-this-function)
|   |-- drivers-cpufreq-scpi-cpufreq.c:error:CPUFREQ_DEFAULT_TRANSITION_LATENCY_NS-undeclared-(first-use-in-this-function)
|   `-- drivers-cpufreq-spear-cpufreq.c:error:CPUFREQ_DEFAULT_TRANSITION_LATENCY_NS-undeclared-(first-use-in-this-function)
|-- arm-allyesconfig
|   |-- drivers-cpufreq-cpufreq-dt.c:error:CPUFREQ_DEFAULT_TRANSITION_LATENCY_NS-undeclared-(first-use-in-this-function)
|   |-- drivers-cpufreq-mediatek-cpufreq-hw.c:error:CPUFREQ_DEFAULT_TRANSITION_LATENCY_NS-undeclared-(first-use-in-this-function)
|   |-- drivers-cpufreq-scmi-cpufreq.c:error:CPUFREQ_DEFAULT_TRANSITION_LATENCY_NS-undeclared-(first-use-in-this-function)
|   |-- drivers-cpufreq-scpi-cpufreq.c:error:CPUFREQ_DEFAULT_TRANSITION_LATENCY_NS-undeclared-(first-use-in-this-function)
|   `-- drivers-cpufreq-spear-cpufreq.c:error:CPUFREQ_DEFAULT_TRANSITION_LATENCY_NS-undeclared-(first-use-in-this-function)
|-- arm-integrator_defconfig
|   `-- drivers-cpufreq-cpufreq-dt.c:error:use-of-undeclared-identifier-CPUFREQ_DEFAULT_TRANSITION_LATENCY_NS
|-- arm-mvebu_v7_defconfig
|   `-- drivers-cpufreq-cpufreq-dt.c:error:use-of-undeclared-identifier-CPUFREQ_DEFAULT_TRANSITION_LATENCY_NS
|-- arm-randconfig-001-20250927
|   |-- drivers-cpufreq-cpufreq-dt.c:error:use-of-undeclared-identifier-CPUFREQ_DEFAULT_TRANSITION_LATENCY_NS
|   |-- drivers-cpufreq-scmi-cpufreq.c:error:use-of-undeclared-identifier-CPUFREQ_DEFAULT_TRANSITION_LATENCY_NS
|   `-- drivers-cpufreq-scpi-cpufreq.c:error:use-of-undeclared-identifier-CPUFREQ_DEFAULT_TRANSITION_LATENCY_NS
|-- arm64-allmodconfig
|   |-- drivers-acpi-battery.c:warning:label-followed-by-a-declaration-is-a-C23-extension-Wc23-extensions
|   |-- drivers-cpufreq-cpufreq-dt.c:error:use-of-undeclared-identifier-CPUFREQ_DEFAULT_TRANSITION_LATENCY_NS
|   |-- drivers-cpufreq-imx6q-cpufreq.c:error:use-of-undeclared-identifier-CPUFREQ_DEFAULT_TRANSITION_LATENCY_NS
|   |-- drivers-cpufreq-mediatek-cpufreq-hw.c:error:use-of-undeclared-identifier-CPUFREQ_DEFAULT_TRANSITION_LATENCY_NS
|   |-- drivers-cpufreq-scmi-cpufreq.c:error:use-of-undeclared-identifier-CPUFREQ_DEFAULT_TRANSITION_LATENCY_NS
|   |-- drivers-cpufreq-scpi-cpufreq.c:error:use-of-undeclared-identifier-CPUFREQ_DEFAULT_TRANSITION_LATENCY_NS
|   `-- drivers-cpufreq-spear-cpufreq.c:error:use-of-undeclared-identifier-CPUFREQ_DEFAULT_TRANSITION_LATENCY_NS
|-- arm64-randconfig-003-20250927
|   `-- drivers-cpufreq-spear-cpufreq.c:error:use-of-undeclared-identifier-CPUFREQ_DEFAULT_TRANSITION_LATENCY_NS
|-- i386-allmodconfig
|   |-- drivers-cpufreq-cpufreq-dt.c:error:CPUFREQ_DEFAULT_TRANSITION_LATENCY_NS-undeclared-(first-use-in-this-function)
|   |-- drivers-cpufreq-mediatek-cpufreq-hw.c:error:CPUFREQ_DEFAULT_TRANSITION_LATENCY_NS-undeclared-(first-use-in-this-function)
|   |-- drivers-cpufreq-scmi-cpufreq.c:error:CPUFREQ_DEFAULT_TRANSITION_LATENCY_NS-undeclared-(first-use-in-this-function)
|   |-- drivers-cpufreq-scpi-cpufreq.c:error:CPUFREQ_DEFAULT_TRANSITION_LATENCY_NS-undeclared-(first-use-in-this-function)
|   `-- drivers-cpufreq-spear-cpufreq.c:error:CPUFREQ_DEFAULT_TRANSITION_LATENCY_NS-undeclared-(first-use-in-this-function)
|-- i386-allyesconfig
|   |-- drivers-cpufreq-cpufreq-dt.c:error:CPUFREQ_DEFAULT_TRANSITION_LATENCY_NS-undeclared-(first-use-in-this-function)
|   |-- drivers-cpufreq-mediatek-cpufreq-hw.c:error:CPUFREQ_DEFAULT_TRANSITION_LATENCY_NS-undeclared-(first-use-in-this-function)
|   |-- drivers-cpufreq-scmi-cpufreq.c:error:CPUFREQ_DEFAULT_TRANSITION_LATENCY_NS-undeclared-(first-use-in-this-function)
|   |-- drivers-cpufreq-scpi-cpufreq.c:error:CPUFREQ_DEFAULT_TRANSITION_LATENCY_NS-undeclared-(first-use-in-this-function)
|   `-- drivers-cpufreq-spear-cpufreq.c:error:CPUFREQ_DEFAULT_TRANSITION_LATENCY_NS-undeclared-(first-use-in-this-function)
|-- i386-buildonly-randconfig-004-20250927
|   `-- drivers-cpufreq-mediatek-cpufreq-hw.c:error:use-of-undeclared-identifier-CPUFREQ_DEFAULT_TRANSITION_LATENCY_NS
|-- i386-defconfig
|   `-- drivers-acpi-battery.c:warning:label-followed-by-a-declaration-is-a-C23-extension-Wc23-extensions
|-- i386-randconfig-141-20250928
|   |-- drivers-acpi-battery.c:warning:label-followed-by-a-declaration-is-a-C23-extension-Wc23-extensions
|   `-- drivers-cpufreq-cpufreq-dt.c:error:use-of-undeclared-identifier-CPUFREQ_DEFAULT_TRANSITION_LATENCY_NS
|-- loongarch-allmodconfig
|   |-- drivers-acpi-battery.c:warning:label-followed-by-a-declaration-is-a-C23-extension-Wc23-extensions
|   |-- drivers-cpufreq-cpufreq-dt.c:error:use-of-undeclared-identifier-CPUFREQ_DEFAULT_TRANSITION_LATENCY_NS
|   |-- drivers-cpufreq-mediatek-cpufreq-hw.c:error:use-of-undeclared-identifier-CPUFREQ_DEFAULT_TRANSITION_LATENCY_NS
|   |-- drivers-cpufreq-scmi-cpufreq.c:error:use-of-undeclared-identifier-CPUFREQ_DEFAULT_TRANSITION_LATENCY_NS
|   |-- drivers-cpufreq-scpi-cpufreq.c:error:use-of-undeclared-identifier-CPUFREQ_DEFAULT_TRANSITION_LATENCY_NS
|   `-- drivers-cpufreq-spear-cpufreq.c:error:use-of-undeclared-identifier-CPUFREQ_DEFAULT_TRANSITION_LATENCY_NS
|-- loongarch-allyesconfig
|   |-- drivers-acpi-battery.c:warning:label-followed-by-a-declaration-is-a-C23-extension-Wc23-extensions
|   |-- drivers-cpufreq-cpufreq-dt.c:error:use-of-undeclared-identifier-CPUFREQ_DEFAULT_TRANSITION_LATENCY_NS
|   |-- drivers-cpufreq-mediatek-cpufreq-hw.c:error:use-of-undeclared-identifier-CPUFREQ_DEFAULT_TRANSITION_LATENCY_NS
|   |-- drivers-cpufreq-scmi-cpufreq.c:error:use-of-undeclared-identifier-CPUFREQ_DEFAULT_TRANSITION_LATENCY_NS
|   |-- drivers-cpufreq-scpi-cpufreq.c:error:use-of-undeclared-identifier-CPUFREQ_DEFAULT_TRANSITION_LATENCY_NS
|   `-- drivers-cpufreq-spear-cpufreq.c:error:use-of-undeclared-identifier-CPUFREQ_DEFAULT_TRANSITION_LATENCY_NS
|-- loongarch-randconfig-002-20250927
|   `-- drivers-acpi-battery.c:warning:label-followed-by-a-declaration-is-a-C23-extension-Wc23-extensions
|-- powerpc-allmodconfig
|   |-- drivers-cpufreq-cpufreq-dt.c:error:CPUFREQ_DEFAULT_TRANSITION_LATENCY_NS-undeclared-(first-use-in-this-function)
|   |-- drivers-cpufreq-mediatek-cpufreq-hw.c:error:CPUFREQ_DEFAULT_TRANSITION_LATENCY_NS-undeclared-(first-use-in-this-function)
|   |-- drivers-cpufreq-scmi-cpufreq.c:error:CPUFREQ_DEFAULT_TRANSITION_LATENCY_NS-undeclared-(first-use-in-this-function)
|   |-- drivers-cpufreq-scpi-cpufreq.c:error:CPUFREQ_DEFAULT_TRANSITION_LATENCY_NS-undeclared-(first-use-in-this-function)
|   `-- drivers-cpufreq-spear-cpufreq.c:error:CPUFREQ_DEFAULT_TRANSITION_LATENCY_NS-undeclared-(first-use-in-this-function)
|-- powerpc-allyesconfig
|   |-- drivers-cpufreq-cpufreq-dt.c:error:use-of-undeclared-identifier-CPUFREQ_DEFAULT_TRANSITION_LATENCY_NS
|   |-- drivers-cpufreq-mediatek-cpufreq-hw.c:error:use-of-undeclared-identifier-CPUFREQ_DEFAULT_TRANSITION_LATENCY_NS
|   |-- drivers-cpufreq-scmi-cpufreq.c:error:use-of-undeclared-identifier-CPUFREQ_DEFAULT_TRANSITION_LATENCY_NS
|   |-- drivers-cpufreq-scpi-cpufreq.c:error:use-of-undeclared-identifier-CPUFREQ_DEFAULT_TRANSITION_LATENCY_NS
|   `-- drivers-cpufreq-spear-cpufreq.c:error:use-of-undeclared-identifier-CPUFREQ_DEFAULT_TRANSITION_LATENCY_NS
|-- powerpc64-randconfig-002-20250927
|   `-- drivers-cpufreq-cpufreq-dt.c:error:CPUFREQ_DEFAULT_TRANSITION_LATENCY_NS-undeclared-(first-use-in-this-function)
|-- riscv-allmodconfig
|   |-- drivers-acpi-battery.c:warning:label-followed-by-a-declaration-is-a-C23-extension-Wc23-extensions
|   |-- drivers-cpufreq-cpufreq-dt.c:error:use-of-undeclared-identifier-CPUFREQ_DEFAULT_TRANSITION_LATENCY_NS
|   |-- drivers-cpufreq-mediatek-cpufreq-hw.c:error:use-of-undeclared-identifier-CPUFREQ_DEFAULT_TRANSITION_LATENCY_NS
|   |-- drivers-cpufreq-scmi-cpufreq.c:error:use-of-undeclared-identifier-CPUFREQ_DEFAULT_TRANSITION_LATENCY_NS
|   |-- drivers-cpufreq-scpi-cpufreq.c:error:use-of-undeclared-identifier-CPUFREQ_DEFAULT_TRANSITION_LATENCY_NS
|   `-- drivers-cpufreq-spear-cpufreq.c:error:use-of-undeclared-identifier-CPUFREQ_DEFAULT_TRANSITION_LATENCY_NS
|-- riscv-allyesconfig
|   |-- drivers-cpufreq-cpufreq-dt.c:error:use-of-undeclared-identifier-CPUFREQ_DEFAULT_TRANSITION_LATENCY_NS
|   |-- drivers-cpufreq-mediatek-cpufreq-hw.c:error:use-of-undeclared-identifier-CPUFREQ_DEFAULT_TRANSITION_LATENCY_NS
|   |-- drivers-cpufreq-scmi-cpufreq.c:error:use-of-undeclared-identifier-CPUFREQ_DEFAULT_TRANSITION_LATENCY_NS
|   |-- drivers-cpufreq-scpi-cpufreq.c:error:use-of-undeclared-identifier-CPUFREQ_DEFAULT_TRANSITION_LATENCY_NS
|   `-- drivers-cpufreq-spear-cpufreq.c:error:use-of-undeclared-identifier-CPUFREQ_DEFAULT_TRANSITION_LATENCY_NS
|-- riscv-randconfig-002-20250927
|   |-- drivers-cpufreq-cpufreq-dt.c:error:CPUFREQ_DEFAULT_TRANSITION_LATENCY_NS-undeclared-(first-use-in-this-function)
|   |-- drivers-cpufreq-mediatek-cpufreq-hw.c:error:CPUFREQ_DEFAULT_TRANSITION_LATENCY_NS-undeclared-(first-use-in-this-function)
|   |-- drivers-cpufreq-scmi-cpufreq.c:error:CPUFREQ_DEFAULT_TRANSITION_LATENCY_NS-undeclared-(first-use-in-this-function)
|   |-- drivers-cpufreq-scpi-cpufreq.c:error:CPUFREQ_DEFAULT_TRANSITION_LATENCY_NS-undeclared-(first-use-in-this-function)
|   `-- drivers-cpufreq-spear-cpufreq.c:error:CPUFREQ_DEFAULT_TRANSITION_LATENCY_NS-undeclared-(first-use-in-this-function)
|-- sh-allmodconfig
|   |-- drivers-cpufreq-cpufreq-dt.c:error:CPUFREQ_DEFAULT_TRANSITION_LATENCY_NS-undeclared-(first-use-in-this-function)
|   |-- drivers-cpufreq-mediatek-cpufreq-hw.c:error:CPUFREQ_DEFAULT_TRANSITION_LATENCY_NS-undeclared-(first-use-in-this-function)
|   |-- drivers-cpufreq-scmi-cpufreq.c:error:CPUFREQ_DEFAULT_TRANSITION_LATENCY_NS-undeclared-(first-use-in-this-function)
|   `-- drivers-cpufreq-spear-cpufreq.c:error:CPUFREQ_DEFAULT_TRANSITION_LATENCY_NS-undeclared-(first-use-in-this-function)
|-- sh-allyesconfig
|   |-- drivers-cpufreq-cpufreq-dt.c:error:CPUFREQ_DEFAULT_TRANSITION_LATENCY_NS-undeclared-(first-use-in-this-function)
|   |-- drivers-cpufreq-mediatek-cpufreq-hw.c:error:CPUFREQ_DEFAULT_TRANSITION_LATENCY_NS-undeclared-(first-use-in-this-function)
|   |-- drivers-cpufreq-scmi-cpufreq.c:error:CPUFREQ_DEFAULT_TRANSITION_LATENCY_NS-undeclared-(first-use-in-this-function)
|   `-- drivers-cpufreq-spear-cpufreq.c:error:CPUFREQ_DEFAULT_TRANSITION_LATENCY_NS-undeclared-(first-use-in-this-function)
|-- sparc-allmodconfig
|   |-- drivers-cpufreq-cpufreq-dt.c:error:CPUFREQ_DEFAULT_TRANSITION_LATENCY_NS-undeclared-(first-use-in-this-function)
|   |-- drivers-cpufreq-mediatek-cpufreq-hw.c:error:CPUFREQ_DEFAULT_TRANSITION_LATENCY_NS-undeclared-(first-use-in-this-function)
|   |-- drivers-cpufreq-scmi-cpufreq.c:error:CPUFREQ_DEFAULT_TRANSITION_LATENCY_NS-undeclared-(first-use-in-this-function)
|   |-- drivers-cpufreq-scpi-cpufreq.c:error:CPUFREQ_DEFAULT_TRANSITION_LATENCY_NS-undeclared-(first-use-in-this-function)
|   `-- drivers-cpufreq-spear-cpufreq.c:error:CPUFREQ_DEFAULT_TRANSITION_LATENCY_NS-undeclared-(first-use-in-this-function)
|-- x86_64-allmodconfig
|   |-- drivers-acpi-battery.c:warning:label-followed-by-a-declaration-is-a-C23-extension-Wc23-extensions
|   |-- drivers-cpufreq-cpufreq-dt.c:error:use-of-undeclared-identifier-CPUFREQ_DEFAULT_TRANSITION_LATENCY_NS
|   |-- drivers-cpufreq-mediatek-cpufreq-hw.c:error:use-of-undeclared-identifier-CPUFREQ_DEFAULT_TRANSITION_LATENCY_NS
|   |-- drivers-cpufreq-scmi-cpufreq.c:error:use-of-undeclared-identifier-CPUFREQ_DEFAULT_TRANSITION_LATENCY_NS
|   |-- drivers-cpufreq-scpi-cpufreq.c:error:use-of-undeclared-identifier-CPUFREQ_DEFAULT_TRANSITION_LATENCY_NS
|   `-- drivers-cpufreq-spear-cpufreq.c:error:use-of-undeclared-identifier-CPUFREQ_DEFAULT_TRANSITION_LATENCY_NS
|-- x86_64-allyesconfig
|   |-- drivers-acpi-battery.c:warning:label-followed-by-a-declaration-is-a-C23-extension-Wc23-extensions
|   |-- drivers-cpufreq-cpufreq-dt.c:error:use-of-undeclared-identifier-CPUFREQ_DEFAULT_TRANSITION_LATENCY_NS
|   |-- drivers-cpufreq-mediatek-cpufreq-hw.c:error:use-of-undeclared-identifier-CPUFREQ_DEFAULT_TRANSITION_LATENCY_NS
|   |-- drivers-cpufreq-scmi-cpufreq.c:error:use-of-undeclared-identifier-CPUFREQ_DEFAULT_TRANSITION_LATENCY_NS
|   |-- drivers-cpufreq-scpi-cpufreq.c:error:use-of-undeclared-identifier-CPUFREQ_DEFAULT_TRANSITION_LATENCY_NS
|   `-- drivers-cpufreq-spear-cpufreq.c:error:use-of-undeclared-identifier-CPUFREQ_DEFAULT_TRANSITION_LATENCY_NS
`-- x86_64-rhel-9.4-rust
    `-- error-E0425:cannot-find-value-CPUFREQ_DEFAULT_TRANSITION_LATENCY_NS-in-crate-bindings

elapsed time: 835m

configs tested: 119
configs skipped: 4

tested configs:
alpha                             allnoconfig    gcc-15.1.0
alpha                            allyesconfig    gcc-15.1.0
arc                              allmodconfig    gcc-15.1.0
arc                               allnoconfig    gcc-15.1.0
arc                              allyesconfig    gcc-15.1.0
arc                   randconfig-001-20250927    gcc-10.5.0
arc                   randconfig-002-20250927    gcc-13.4.0
arm                              allmodconfig    gcc-15.1.0
arm                               allnoconfig    clang-22
arm                              allyesconfig    gcc-15.1.0
arm                       aspeed_g4_defconfig    clang-22
arm                      integrator_defconfig    clang-22
arm                        multi_v5_defconfig    gcc-15.1.0
arm                        mvebu_v7_defconfig    clang-22
arm                   randconfig-001-20250927    clang-18
arm                   randconfig-002-20250927    clang-16
arm                   randconfig-003-20250927    gcc-8.5.0
arm                   randconfig-004-20250927    gcc-10.5.0
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-15.1.0
arm64                 randconfig-001-20250927    gcc-8.5.0
arm64                 randconfig-002-20250927    gcc-11.5.0
arm64                 randconfig-003-20250927    clang-22
arm64                 randconfig-004-20250927    gcc-9.5.0
csky                              allnoconfig    gcc-15.1.0
csky                  randconfig-001-20250927    gcc-15.1.0
csky                  randconfig-002-20250927    gcc-13.4.0
hexagon                          allmodconfig    clang-17
hexagon                           allnoconfig    clang-22
hexagon                          allyesconfig    clang-22
hexagon               randconfig-001-20250927    clang-22
hexagon               randconfig-002-20250927    clang-22
i386                             allmodconfig    gcc-14
i386                              allnoconfig    gcc-14
i386                             allyesconfig    gcc-14
i386        buildonly-randconfig-001-20250927    clang-20
i386        buildonly-randconfig-002-20250927    gcc-14
i386        buildonly-randconfig-003-20250927    clang-20
i386        buildonly-randconfig-004-20250927    clang-20
i386        buildonly-randconfig-005-20250927    gcc-12
i386        buildonly-randconfig-006-20250927    clang-20
i386                                defconfig    clang-20
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-22
loongarch             randconfig-001-20250927    gcc-15.1.0
loongarch             randconfig-002-20250927    clang-18
m68k                             allmodconfig    gcc-15.1.0
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    gcc-15.1.0
m68k                          atari_defconfig    gcc-15.1.0
microblaze                       allmodconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    gcc-15.1.0
microblaze                          defconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    gcc-11.5.0
nios2                 randconfig-001-20250927    gcc-9.5.0
nios2                 randconfig-002-20250927    gcc-11.5.0
openrisc                          allnoconfig    gcc-15.1.0
openrisc                         allyesconfig    gcc-15.1.0
parisc                           allmodconfig    gcc-15.1.0
parisc                            allnoconfig    gcc-15.1.0
parisc                           allyesconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20250927    gcc-9.5.0
parisc                randconfig-002-20250927    gcc-11.5.0
parisc64                            defconfig    gcc-15.1.0
powerpc                          allmodconfig    gcc-15.1.0
powerpc                           allnoconfig    gcc-15.1.0
powerpc                          allyesconfig    clang-22
powerpc               randconfig-001-20250927    gcc-13.4.0
powerpc               randconfig-002-20250927    clang-22
powerpc               randconfig-003-20250927    gcc-8.5.0
powerpc64             randconfig-001-20250927    clang-22
powerpc64             randconfig-002-20250927    gcc-15.1.0
powerpc64             randconfig-003-20250927    gcc-12.5.0
riscv                            allmodconfig    clang-22
riscv                             allnoconfig    gcc-15.1.0
riscv                            allyesconfig    clang-16
riscv                 randconfig-001-20250927    clang-22
riscv                 randconfig-002-20250927    gcc-15.1.0
s390                             allmodconfig    clang-18
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.1.0
s390                  randconfig-001-20250927    clang-22
s390                  randconfig-002-20250927    clang-22
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                    randconfig-001-20250927    gcc-15.1.0
sh                    randconfig-002-20250927    gcc-15.1.0
sh                          rsk7201_defconfig    gcc-15.1.0
sparc                            allmodconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                               defconfig    gcc-15.1.0
sparc                 randconfig-001-20250927    gcc-11.5.0
sparc                 randconfig-002-20250927    gcc-11.5.0
sparc64               randconfig-001-20250927    gcc-15.1.0
sparc64               randconfig-002-20250927    gcc-8.5.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    gcc-14
um                    randconfig-001-20250927    gcc-14
um                    randconfig-002-20250927    clang-22
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250927    gcc-14
x86_64      buildonly-randconfig-002-20250927    clang-20
x86_64      buildonly-randconfig-003-20250927    clang-20
x86_64      buildonly-randconfig-004-20250927    gcc-14
x86_64      buildonly-randconfig-005-20250927    gcc-14
x86_64      buildonly-randconfig-006-20250927    clang-20
x86_64                              defconfig    gcc-14
x86_64                          rhel-9.4-rust    clang-20
xtensa                           alldefconfig    gcc-15.1.0
xtensa                            allnoconfig    gcc-15.1.0
xtensa                randconfig-001-20250927    gcc-8.5.0
xtensa                randconfig-002-20250927    gcc-10.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

