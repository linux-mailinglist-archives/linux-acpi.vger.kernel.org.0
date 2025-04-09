Return-Path: <linux-acpi+bounces-12927-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B1931A8307E
	for <lists+linux-acpi@lfdr.de>; Wed,  9 Apr 2025 21:25:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 99C21462160
	for <lists+linux-acpi@lfdr.de>; Wed,  9 Apr 2025 19:25:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E296D1E503C;
	Wed,  9 Apr 2025 19:25:38 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53119165F1A;
	Wed,  9 Apr 2025 19:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744226738; cv=none; b=nAPZvlHZnFQug3DIpCERegDs5ehqIVc3+DA/NBgxfhL+YBEWchQPxSmkxYAfEE8l/F6GiwhUSLW6txIPWqWmJBo+GE8diSXZgRDZNdwNDLhmMl0y45CI2av3PVE7kNq0ZrcJa1AdiRvAS4ICpt30dWW30UKFFov/Oso/OIZ4ldI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744226738; c=relaxed/simple;
	bh=Ysj3nuOh7CwY62QEP9McBgLiwll5Fv8qypJTov/oVpk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iY/X4kFo+NSE1rN/Eg8DSrCrF7vE/xUTdsNq5uhG2P6bR1AiwyO87blI2dKG/H9t4f/8SydsH9lYKkLJrv+BgWYdOWcHqXdhdich6t0LqxIXJDRQl3SIZuzIrx/MTcSjJ+cbtsUipHXYy7UWcMToFVUYvp2WaNC63wvoGengd2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com; spf=none smtp.mailfrom=foss.arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=foss.arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 19F3E15A1;
	Wed,  9 Apr 2025 12:25:37 -0700 (PDT)
Received: from bogus (unknown [10.57.41.33])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B72F83F694;
	Wed,  9 Apr 2025 12:25:34 -0700 (PDT)
Date: Wed, 9 Apr 2025 20:25:31 +0100
From: Sudeep Holla <sudeep.holla@arm.com>
To: kernel test robot <lkp@intel.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Sudeep Holla <sudeep.holla@arm.com>, linux-acpi@vger.kernel.org,
	devel@acpica.org, linux-pm@vger.kernel.org,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [rafael-pm:bleeding-edge 39/52]
 drivers/acpi/apei/einj-core.c:877:43: error: expected identifier
Message-ID: <20250409-wine-swift-of-tempest-eae2cb@sudeepholla>
References: <202504100128.AjbVDQgK-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202504100128.AjbVDQgK-lkp@intel.com>

On Thu, Apr 10, 2025 at 02:10:04AM +0800, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
> head:   089d4e79e2c932faef79e0061cb874000f755009
> commit: 4ec052af63c58a62a896508cc5f8a0a2f516a590 [39/52] ACPI: APEI: EINJ: Transition to the faux device interface
> config: x86_64-buildonly-randconfig-001-20250409 (https://download.01.org/0day-ci/archive/20250410/202504100128.AjbVDQgK-lkp@intel.com/config)
> compiler: clang version 20.1.2 (https://github.com/llvm/llvm-project 58df0ef89dd64126512e4ee27b4ac3fd8ddf6247)
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250410/202504100128.AjbVDQgK-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202504100128.AjbVDQgK-lkp@intel.com/
> 
> All errors (new ones prefixed by >>):
> 
> >> drivers/acpi/apei/einj-core.c:877:43: error: expected identifier
>      877 | module_faux_driver(acpi_einj, einj_probe, __exit_p(einj_remove), true);
>          |                                           ^
>    include/linux/init.h:397:21: note: expanded from macro '__exit_p'
>      397 | #define __exit_p(x) NULL
>          |                     ^
>    include/linux/stddef.h:8:14: note: expanded from macro 'NULL'
>        8 | #define NULL ((void *)0)
>          |              ^
> >> drivers/acpi/apei/einj-core.c:877:1: error: type specifier missing, defaults to 'int'; ISO C99 and later do not support implicit int [-Wimplicit-int]
>      877 | module_faux_driver(acpi_einj, einj_probe, __exit_p(einj_remove), true);
>          | ^
>          | int
> >> drivers/acpi/apei/einj-core.c:877:19: error: a function declaration without a prototype is deprecated in all versions of C [-Werror,-Wstrict-prototypes]
>      877 | module_faux_driver(acpi_einj, einj_probe, __exit_p(einj_remove), true);
>          |                   ^                                                  
>          |                                                                      void
>    3 errors generated.
> 
> 
> vim +877 drivers/acpi/apei/einj-core.c
> 
>    876	
>  > 877	module_faux_driver(acpi_einj, einj_probe, __exit_p(einj_remove), true);
>    878	
>

The macro module_faux_driver() was not merged as most of the users I
posted in v2 of the series depend on modprobe and modalias and that
doesn't work with faux devices.

If this ACPI APEI EINJ also needs that support we can't use faux device.
But I think this doesn't have modalias, so v1 of this change[1] which
doesn't  introduce/use the macro module_faux_driver() can be used instead.

Sorry for the noise with v2.

-- 
Regards,
Sudeep

[1] https://lore.kernel.org/all/20250317-plat2faux_dev-v1-8-5fe67c085ad5@arm.com/

