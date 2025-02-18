Return-Path: <linux-acpi+bounces-11271-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 416C3A3A734
	for <lists+linux-acpi@lfdr.de>; Tue, 18 Feb 2025 20:18:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F576163857
	for <lists+linux-acpi@lfdr.de>; Tue, 18 Feb 2025 19:18:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 027AF17A2FE;
	Tue, 18 Feb 2025 19:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NgNG4J78"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C64B421B9E3;
	Tue, 18 Feb 2025 19:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739906277; cv=none; b=fT2VC4x3pQcqNt4vN0pdCCtbylO7qrSGf6SwpIRBTxDCHFZtEwtHfZrlq75tqmvM972munBEPc9VwpXhavMP/F6RBm0URuX0+cZ0aGryGtWdk/acVXv7OfInIiRx7J+dT8PY49kjbyWm3guZtqmrg9wLpsCn2jPXHr0fex0X+HE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739906277; c=relaxed/simple;
	bh=Okr34aKUyByTgMrq3BUiBcdCK3Tgwa9jn3l+JQLmqWI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bOOWe8fuGnwPAEY/D0f+0TH2T4/DUvabZ4FjGrOPpYON+BaM5DvET+wngryiA6J7yQ4KuBDLeBSdTJAP4UdhX7RzcW5xCdW8HqlSgY7/7cbxkxJ3YpmHBtGS0SkB5rC7g4viIPL06o6zo/TQ2bor8JEhMYaEFg0SShTEtiNZHg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NgNG4J78; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4835BC4CEE4;
	Tue, 18 Feb 2025 19:17:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739906277;
	bh=Okr34aKUyByTgMrq3BUiBcdCK3Tgwa9jn3l+JQLmqWI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=NgNG4J784DDjNhQl+yWyPwZWwNozAPCEK7J12ulNQC4wX0iXq86wvHd8WMvO9DUpg
	 FSEE8kcl2pcfw71CHwgC/xAJS0TBmuimz+/XNm86QGRcy3QC7jvmMwnOnvnPcHR8MS
	 Foq/6ouhP2rzW/+7GQ0ZFt3gsIKLmxNvRcTdjy2AcmZA8NpCaDekR8Rl+sX0hrx6IP
	 1v6CbWm2ULvrf/iyFb2B2QFCYSFeqn4pC18Y8xZRoo0vXy6IaTuhANHNDZBOIRU2gi
	 305Ca8sojAVg7R1BqruSsJdZ3jvrXprikuh39U4M+o1qfwCTrOOxlPFHfzstoFb/bV
	 H2sy+HTd/SZNw==
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-3f37207259bso1397639b6e.1;
        Tue, 18 Feb 2025 11:17:57 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUv8jjgDkURK2jGgRm1iVUUHdcxXQIAo9FZRNl5cYnouETOSZx0uRz8f0EdqmPxG1/jo2d4eGW/L8cY@vger.kernel.org, AJvYcCV2e7znZLZcqDMoXgzQZlpEdKRkBfRYtPD2Zj36fbKuxw+8iHjZ0M+n1hNLENxdjN+XcyWWy7F1zbWHu2mY@vger.kernel.org, AJvYcCXrSRdPlMH+6CPCHvsLLhxonvTnliAoHKqum4dhmCFoz7XLzA7U/a2Rbcdki5KyfR8tuxFZ+d5AnhM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKxT0kZnMG76GfibECCOVVgTqbzxwZH6pbDLuvBs2a4K3IM9+t
	DRjPQcDugATvg7PmfQQ6wO9wcKObI8s+QDUFnG09GPMgb9TmS+KWk3pl0xL9c/hojfSYvaq2Ap6
	rXKlVYTfpi5WznADyBPIUZEHhrho=
X-Google-Smtp-Source: AGHT+IE11iyyMeBw/VMtJQQmRZ5BdbepoHXAD4Hl2n6hzj1swyyMTfhVLwBTksLrkoVda+oAF13P9TqZzn+9gPy5epw=
X-Received: by 2002:a05:6808:f90:b0:3f3:d9e2:73c8 with SMTP id
 5614622812f47-3f3eb11b313mr8215252b6e.30.1739906276561; Tue, 18 Feb 2025
 11:17:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250206131428.3261578-1-zhenglifeng1@huawei.com> <0097a9a3-fe61-4200-9a54-5a9c81d3219c@huawei.com>
In-Reply-To: <0097a9a3-fe61-4200-9a54-5a9c81d3219c@huawei.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 18 Feb 2025 20:17:45 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0hP9a8g8UR2oPyivP1C65=csR245PSHay+nOx3vkoKoaA@mail.gmail.com>
X-Gm-Features: AWEUYZkgrfYy0ha5UC1R_2_bCqZ7xDXpbb42jW2c9EZZuVtbfizHgfedEgRK23s
Message-ID: <CAJZ5v0hP9a8g8UR2oPyivP1C65=csR245PSHay+nOx3vkoKoaA@mail.gmail.com>
Subject: Re: [PATCH v5 0/8] Support for autonomous selection in cppc_cpufreq
To: "zhenglifeng (A)" <zhenglifeng1@huawei.com>
Cc: rafael@kernel.org, lenb@kernel.org, robert.moore@intel.com, 
	viresh.kumar@linaro.org, mario.limonciello@amd.com, gautham.shenoy@amd.com, 
	ray.huang@amd.com, pierre.gondois@arm.com, acpica-devel@lists.linux.dev, 
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org, linuxarm@huawei.com, yumpusamongus@gmail.com, 
	srinivas.pandruvada@linux.intel.com, jonathan.cameron@huawei.com, 
	zhanjie9@hisilicon.com, lihuisong@huawei.com, hepeng68@huawei.com, 
	fanghao11@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 13, 2025 at 2:55=E2=80=AFAM zhenglifeng (A) <zhenglifeng1@huawe=
i.com> wrote:
>
> On 2025/2/6 21:14, Lifeng Zheng wrote:
> > Add sysfs interfaces for CPPC autonomous selection in the cppc_cpufreq
> > driver.
> >
> > The patch series is organized in two parts:
> >
> >  - patch 1-5 refactor out the general CPPC register get and set functio=
ns
> >    in cppc_acpi.c
> >
> >  - patches 6-8 expose sysfs files for users to control CPPC autonomous
> >    selection when supported
> >
> > Changelog:
> >
> > v5:
> >
> >  - add more explanation to the commit logs and comments
> >  - change REG_OPTIONAL from bin to hex
> >  - split patch 2 into 3 smaller patches
> >  - remove CPPC_REG_VAL_READ() and CPPC_REG_VAL_WRITE() macros
> >  - move the modification part in patch 5 into a separate patch
> >  - rename the sysfs file from "energy_perf" to
> >    energy_performance_preference_val
> >
> > v4:
> >
> >  - add REG_OPTIONAL and IS_OPTIONAL_CPC_REG to judge if a cpc register =
is
> >    an optional one
> >  - check whether the register is optional before CPC_SUPPORTED check in
> >    cppc_get_reg_val() and cppc_set_reg_val()
> >  - check the register's type in cppc_set_reg_val()
> >  - add macros to generally implement registers getting and setting
> >    functions
> >  - move some logic codes from cppc_cpufreq.c to cppc_acpi.c
> >  - replace cppc_get_auto_sel_caps() by cppc_get_auto_sel()
> >
> > v3:
> >
> >  - change cppc_get_reg() and cppc_set_reg() name to cppc_get_reg_val() =
and
> >    cppc_set_reg_val()
> >  - extract cppc_get_reg_val_in_pcc() and cppc_set_reg_val_in_pcc()
> >  - return the result of cpc_read() in cppc_get_reg_val()
> >  - add pr_debug() in cppc_get_reg_val_in_pcc() when pcc_ss_id < 0
> >  - rename 'cpunum' to 'cpu' in cppc_get_reg_val()
> >  - move some macros from drivers/cpufreq/cppc_cpufreq.c to
> >    include/acpi/cppc_acpi.h with a CPPC_XXX prefix
> >
> > v2:
> >
> >  - fix some incorrect placeholder
> >  - change kstrtoul to kstrtobool in store_auto_select
> >
> > Lifeng Zheng (8):
> >   ACPI: CPPC: Add IS_OPTIONAL_CPC_REG macro to judge if a cpc_reg is
> >     optional
> >   ACPI: CPPC: Optimize cppc_get_perf()
> >   ACPI: CPPC: Rename cppc_get_perf() to cppc_get_reg_val()
> >   ACPI: CPPC: Add cppc_set_reg_val()
> >   ACPI: CPPC: Refactor register value get and set ABIs
> >   ACPI: CPPC: Modify cppc_get_auto_sel_caps() to cppc_get_auto_sel()
> >   ACPI: CPPC: Add three functions related to autonomous selection
> >   cpufreq: CPPC: Support for autonomous selection in cppc_cpufreq
> >
> >  .../ABI/testing/sysfs-devices-system-cpu      |  54 ++++
> >  drivers/acpi/cppc_acpi.c                      | 303 +++++++++++-------
> >  drivers/cpufreq/amd-pstate.c                  |   3 +-
> >  drivers/cpufreq/cppc_cpufreq.c                | 109 +++++++
> >  include/acpi/cppc_acpi.h                      |  30 +-
> >  5 files changed, 372 insertions(+), 127 deletions(-)
> >
>
> Gentle ping.

OK, so I'm wondering how this is related to the patch series at

https://lore.kernel.org/linux-acpi/20250211103737.447704-1-sumitg@nvidia.co=
m/

> Attach discussions of previous versions:
> v1: https://lore.kernel.org/all/20241114084816.1128647-1-zhenglifeng1@hua=
wei.com/
> v2: https://lore.kernel.org/all/20241122062051.3658577-1-zhenglifeng1@hua=
wei.com/
> v3: https://lore.kernel.org/all/20241216091603.1247644-1-zhenglifeng1@hua=
wei.com/
> v4: https://lore.kernel.org/all/20250113122104.3870673-1-zhenglifeng1@hua=
wei.com/
>

