Return-Path: <linux-acpi+bounces-3782-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A4BFB85DEC0
	for <lists+linux-acpi@lfdr.de>; Wed, 21 Feb 2024 15:21:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F25B281D32
	for <lists+linux-acpi@lfdr.de>; Wed, 21 Feb 2024 14:21:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDB237BB11;
	Wed, 21 Feb 2024 14:21:40 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F25A4C62;
	Wed, 21 Feb 2024 14:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708525300; cv=none; b=BPTqcgdOq7wNygizetmd6pYQTKvxeg5IiMVxx+ZHSgdwTTvcCzoLVpovdsEzz17oX86SJAxYTlf71haDa4D8ZspElBUP/fhTOohlrhw21dbJ/aRtfmNzGhOPvemJCXkuKXvpgeoqfefOA5Nnc6f3Fc8ugstD9HezEZ4OtkEMSfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708525300; c=relaxed/simple;
	bh=YwsNhLos5IF+HpOc8CL35aaw3xRztGJyd0Rg4VH16iw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PvHzb3BfaFEJWFiC3ZxATSWopg4iotpihYSLrmjfatUBXcvKPVGLaP8KRFuTEWZSgQOt0mX5cBzrE6S7RyklvKkkpG6LbeOPSAlBlr2LDsc3DA9okgzMHx6fnIKH1YjtrmfLz/xLOYeGVVHqlf8A28MmGyl3nebHfRNxQC9oFPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7722FFEC;
	Wed, 21 Feb 2024 06:22:16 -0800 (PST)
Received: from [10.57.11.178] (unknown [10.57.11.178])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1A67F3F762;
	Wed, 21 Feb 2024 06:21:36 -0800 (PST)
Message-ID: <08ab3e7b-c9af-4c07-bff9-1ae64f298eae@arm.com>
Date: Wed, 21 Feb 2024 14:21:52 +0000
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [rafael-pm:bleeding-edge] BUILD SUCCESS
 18e0452b740e01daf1abb498116ad89716bfd5bc
Content-Language: en-US
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: kernel test robot <lkp@intel.com>, linux-acpi@vger.kernel.org,
 devel@acpica.org, linux-pm@vger.kernel.org
References: <202402211643.99kLO5dl-lkp@intel.com>
From: Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <202402211643.99kLO5dl-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Rafael,

On 2/21/24 08:16, kernel test robot wrote:
> tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
> branch HEAD: 18e0452b740e01daf1abb498116ad89716bfd5bc  Merge branch 'acpi-scan' into bleeding-edge
> 
> Warning ids grouped by kconfigs:
> 
> gcc_recent_errors
> |-- arm64-defconfig
> |   |-- kernel-power-energy_model.c:warning:Function-parameter-or-struct-member-nr_states-not-described-in-em_dev_compute_costs
> |   `-- kernel-power-energy_model.c:warning:variable-nr_states-set-but-not-used
> |-- arm64-randconfig-001-20240221
> |   |-- kernel-power-energy_model.c:warning:Function-parameter-or-struct-member-nr_states-not-described-in-em_dev_compute_costs
> |   `-- kernel-power-energy_model.c:warning:variable-nr_states-set-but-not-used
> |-- i386-allmodconfig
> |   |-- kernel-power-energy_model.c:warning:Function-parameter-or-struct-member-nr_states-not-described-in-em_dev_compute_costs
> |   `-- kernel-power-energy_model.c:warning:variable-nr_states-set-but-not-used
> |-- i386-allyesconfig
> |   |-- kernel-power-energy_model.c:warning:Function-parameter-or-struct-member-nr_states-not-described-in-em_dev_compute_costs
> |   `-- kernel-power-energy_model.c:warning:variable-nr_states-set-but-not-used
> |-- i386-buildonly-randconfig-006-20240221
> |   |-- kernel-power-energy_model.c:warning:Function-parameter-or-struct-member-nr_states-not-described-in-em_dev_compute_costs
> |   `-- kernel-power-energy_model.c:warning:variable-nr_states-set-but-not-used
> |-- i386-randconfig-015-20240221
> |   |-- kernel-power-energy_model.c:warning:Function-parameter-or-struct-member-nr_states-not-described-in-em_dev_compute_costs
> |   `-- kernel-power-energy_model.c:warning:variable-nr_states-set-but-not-used
> |-- i386-randconfig-141-20240221
> |   |-- kernel-power-energy_model.c:warning:Function-parameter-or-struct-member-nr_states-not-described-in-em_dev_compute_costs
> |   `-- kernel-power-energy_model.c:warning:variable-nr_states-set-but-not-used
> |-- mips-allyesconfig
> |   |-- kernel-power-energy_model.c:warning:Function-parameter-or-struct-member-nr_states-not-described-in-em_dev_compute_costs
> |   `-- kernel-power-energy_model.c:warning:variable-nr_states-set-but-not-used
> |-- powerpc64-randconfig-002-20240221
> |   |-- kernel-power-energy_model.c:warning:Function-parameter-or-struct-member-nr_states-not-described-in-em_dev_compute_costs
> |   `-- kernel-power-energy_model.c:warning:variable-nr_states-set-but-not-used
> |-- powerpc64-randconfig-003-20240221
> |   |-- kernel-power-energy_model.c:warning:Function-parameter-or-struct-member-nr_states-not-described-in-em_dev_compute_costs
> |   `-- kernel-power-energy_model.c:warning:variable-nr_states-set-but-not-used
> |-- sparc64-randconfig-002-20240221
> |   |-- kernel-power-energy_model.c:warning:Function-parameter-or-struct-member-nr_states-not-described-in-em_dev_compute_costs
> |   `-- kernel-power-energy_model.c:warning:variable-nr_states-set-but-not-used
> `-- x86_64-buildonly-randconfig-002-20240221
>      |-- kernel-power-energy_model.c:warning:Function-parameter-or-struct-member-nr_states-not-described-in-em_dev_compute_costs
>      `-- kernel-power-energy_model.c:warning:variable-nr_states-set-but-not-used
> clang_recent_errors
> |-- i386-randconfig-014-20240221
> |   |-- kernel-power-energy_model.c:warning:Function-parameter-or-struct-member-nr_states-not-described-in-em_dev_compute_costs
> |   `-- kernel-power-energy_model.c:warning:variable-nr_states-set-but-not-used
> |-- riscv-allmodconfig
> |   |-- kernel-power-energy_model.c:warning:Function-parameter-or-struct-member-nr_states-not-described-in-em_dev_compute_costs
> |   `-- kernel-power-energy_model.c:warning:variable-nr_states-set-but-not-used
> |-- riscv-allyesconfig
> |   |-- kernel-power-energy_model.c:warning:Function-parameter-or-struct-member-nr_states-not-described-in-em_dev_compute_costs
> |   `-- kernel-power-energy_model.c:warning:variable-nr_states-set-but-not-used
> |-- x86_64-allmodconfig
> |   |-- kernel-power-energy_model.c:warning:Function-parameter-or-struct-member-nr_states-not-described-in-em_dev_compute_costs
> |   `-- kernel-power-energy_model.c:warning:variable-nr_states-set-but-not-used
> `-- x86_64-allyesconfig
>      |-- kernel-power-energy_model.c:warning:Function-parameter-or-struct-member-nr_states-not-described-in-em_dev_compute_costs
>      `-- kernel-power-energy_model.c:warning:variable-nr_states-set-but-not-used
> 
> elapsed time: 726m
> 

I have figured out the 2 places which trigger this. I'm going to send
a small patch to calm down those static checks.

Regards,
Lukasz

