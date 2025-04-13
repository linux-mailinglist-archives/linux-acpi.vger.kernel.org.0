Return-Path: <linux-acpi+bounces-12989-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CFF68A87241
	for <lists+linux-acpi@lfdr.de>; Sun, 13 Apr 2025 17:01:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DEA9E171C1B
	for <lists+linux-acpi@lfdr.de>; Sun, 13 Apr 2025 15:01:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A69B1DBB03;
	Sun, 13 Apr 2025 15:01:11 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDF4A42A96;
	Sun, 13 Apr 2025 15:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744556471; cv=none; b=P80mYS2pgoGWaR/IF9JMJeKRiY1TNRwEw1PLA7fLyCIv2nefykntj+WwDR8DHjQHLgPbscV8RhufNrFXStbMZBcs7g3S11+2o5mC1JWZrhfOzE5vRl9njcx2JDiro28NprSb4Px3sGDfbz7Tz7NsfaRZRbR9aTSovOHgKYG3PN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744556471; c=relaxed/simple;
	bh=MLCahKN631+WNkldw2jLxaUYbwf6sXr69XSXOpUPgdI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l+563s8otmQBwimnVUW6lJRg46ssBWANqTrejBu8IHNYpEmj6HohSdBJPZcT7jG89b9GrXWa3MKFIuULyyDg4yh0NbWZX/yjsqkjo/h0VFz4oyOL8h37fuPDv75+zC2Te62w7bbk/HtaCn94VEdZdyQWVpo74eWFC+g2YSwqbwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com; spf=none smtp.mailfrom=foss.arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=foss.arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9A71C1063;
	Sun, 13 Apr 2025 08:01:01 -0700 (PDT)
Received: from bogus (unknown [10.57.41.33])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 045333F66E;
	Sun, 13 Apr 2025 08:01:00 -0700 (PDT)
Date: Sun, 13 Apr 2025 16:00:57 +0100
From: Sudeep Holla <sudeep.holla@arm.com>
To: kernel test robot <lkp@intel.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Sudeep Holla <sudeep.holla@arm.com>, linux-acpi@vger.kernel.org,
	devel@acpica.org, linux-pm@vger.kernel.org,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [rafael-pm:bleeding-edge 44/52]
 drivers/cpuidle/cpuidle-psci.c:437:54: error: expected identifier
Message-ID: <20250413-brawny-certain-bullmastiff-da71fa@sudeepholla>
References: <202504121050.dgHmFeWe-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202504121050.dgHmFeWe-lkp@intel.com>

Hi Rafael,

On Sat, Apr 12, 2025 at 10:36:41AM +0800, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
> 

[...]

> >> drivers/cpuidle/cpuidle-psci.c:437:54: error: expected identifier
>      437 | module_faux_driver(psci_cpuidle, psci_cpuidle_probe, NULL, true);
>          |                                                      ^
>    include/linux/stddef.h:8:14: note: expanded from macro 'NULL'
>        8 | #define NULL ((void *)0)
>          |              ^
> >> drivers/cpuidle/cpuidle-psci.c:437:1: error: type specifier missing, defaults to 'int'; ISO C99 and later do not support implicit int [-Wimplicit-int]
>      437 | module_faux_driver(psci_cpuidle, psci_cpuidle_probe, NULL, true);
>          | ^
>          | int
> >> drivers/cpuidle/cpuidle-psci.c:437:19: error: a function declaration without a prototype is deprecated in all versions of C [-Werror,-Wstrict-prototypes]
>      437 | module_faux_driver(psci_cpuidle, psci_cpuidle_probe, NULL, true);
>          |                   ^                                            
>          |                                                                void
>    3 errors generated.
> 
> 
> vim +437 drivers/cpuidle/cpuidle-psci.c
> 
>    436	
>  > 437	module_faux_driver(psci_cpuidle, psci_cpuidle_probe, NULL, true);
> 

I think you asked me correctly on v1 [1] to pick up, but I assume with
patchwork, may be you picked up v2 instead. The link in the commit log is
pointing at v2.

-- 
Regards,
Sudeep

[1] https://lore.kernel.org/all/20250317-plat2faux_dev-v1-1-5fe67c085ad5@arm.com/

