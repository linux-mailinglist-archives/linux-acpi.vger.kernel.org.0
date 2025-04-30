Return-Path: <linux-acpi+bounces-13399-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BE76AA554D
	for <lists+linux-acpi@lfdr.de>; Wed, 30 Apr 2025 22:07:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E5D6D3A125E
	for <lists+linux-acpi@lfdr.de>; Wed, 30 Apr 2025 20:06:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10AC829CB20;
	Wed, 30 Apr 2025 20:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sGXtdOIs"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D82F829C341;
	Wed, 30 Apr 2025 20:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746043402; cv=none; b=fjWx7GatKQTLf7u1jsryPzIeTJb4XMN79EtHFa1wOs0Vf77qNfHAooX6VdYhRjOcGYNCxgkMdcFabSa/5mOfVzGyUySaDRjj72gwntuieYaxRyMgh6QWwZ4vmffIiQ/d9xw36KMOwFQtDMPihd/M4Sc0A0ZeeKILq7lUSU18kBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746043402; c=relaxed/simple;
	bh=NwkGTVS0PocVVimFJdrGAK87WACDEWoHwAWZ4ywRzNo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aSeyjcbDgTRtwsw6FA1iASS+TW6inVcbDVATTZAGubWIrORCIDBtEAo6wlxQsEFYZ+8cbl3x7uRM7BnBMSKYsTRUwzemTrkNedleGa3MmznAWUt6dBCJvBWrjXDGMalHi9lzLjshmNTRaGroeV5eBPMqOEFUldkyyQnuJ9N85IY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sGXtdOIs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 694E4C4CEF5;
	Wed, 30 Apr 2025 20:03:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746043401;
	bh=NwkGTVS0PocVVimFJdrGAK87WACDEWoHwAWZ4ywRzNo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=sGXtdOIsh95cJHlMJ2UvMYNq00VI1k0tUOUT8o+jwmfNBOiBD5Hz43nN12KbD+z1A
	 WJh8s/CwSa4vKwQyieZf4GpmaGw1DibvLQyYrAcawmxZ5u8T9z5fpOhnCVUKDx5+dZ
	 VUCHdTS+Xporl7tISdbYNDtETZHm0ffNF9LD5pjz/oMQW9U6LiiJb/wzo4r2Kzxpqm
	 96whW6qML7A3aFOUj2zlxPbO44i2YU1VeyrmWycr39pjqvd9y977mil+s0iCQeOyIJ
	 iI3//MkPerjXdl6K5HHd+Jya+nDST2Apv8BzB1DtdRIwJPsdiyloj4TM/MC5VYojRW
	 cTkLNGVDCXIag==
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-2da3c5729fcso211955fac.0;
        Wed, 30 Apr 2025 13:03:21 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU4gRMLN3RKOl6JxnQF+6oEqfrLQeYE1g/a2B3AwNQxLggkJR1NGTrj6xGH7NYf6wITxZ3pPu9evqgH@vger.kernel.org, AJvYcCWRvkUqRnLu6EsX44PE187A2zAUlwGlQeyTSirJw+Ygdd6IoruO0FV3LWE5TN2hlfESb94KSb02+8k=@vger.kernel.org, AJvYcCXLReoQTGWoiYwA0kyOl6+SzSvDWCHCq62P3FeciJWN0aETxhVmgem5Xomtue9Tm5PGlNZ0fgaQ0qxAzfqh@vger.kernel.org
X-Gm-Message-State: AOJu0YyntJUcnLxZM5FPAD90ULFTkLOFu1wRWxwrDuM3rUo6nWr7Ib+a
	570SwIAdc+WtlQsBNd48PkLQWfmnpRm8J2v8ODO9OvlEyT/s9X37Rbpl7z859cglO+cQ+Ehe7v1
	WQg6fTzfyJynX5lDkt+/cI474XQI=
X-Google-Smtp-Source: AGHT+IGhmLyBRn0IZdPfK6KM97JS9uw2zTeIkkXouEb91STcAV8rAa4Gk6jixae6PbBFOGyZRuGtQUMmrj+NP/8P2CA=
X-Received: by 2002:a05:6870:71cb:b0:2b3:55b3:e38 with SMTP id
 586e51a60fabf-2da69f21b34mr2403838fac.21.1746043400613; Wed, 30 Apr 2025
 13:03:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250411093855.982491-1-zhenglifeng1@huawei.com> <f6904bb1-f41f-4be9-92bb-92fec509a821@amd.com>
In-Reply-To: <f6904bb1-f41f-4be9-92bb-92fec509a821@amd.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 30 Apr 2025 22:03:09 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0gNZsv+sJ8OweGYE6bFTqD48g3JUJn_kL2m17Q2QX6p1w@mail.gmail.com>
X-Gm-Features: ATxdqUFlzi9fK4g3MpOxGzQvjbOGdDgFxNB6hIBF5J0ky9zNPfIg6Ulnwvdr2WA
Message-ID: <CAJZ5v0gNZsv+sJ8OweGYE6bFTqD48g3JUJn_kL2m17Q2QX6p1w@mail.gmail.com>
Subject: Re: [PATCH v7 0/8] Add functions for getting and setting registers
 related to autonomous selection in cppc_acpi
To: Mario Limonciello <mario.limonciello@amd.com>, Lifeng Zheng <zhenglifeng1@huawei.com>
Cc: lenb@kernel.org, robert.moore@intel.com, viresh.kumar@linaro.org, 
	gautham.shenoy@amd.com, ray.huang@amd.com, perry.yuan@amd.com, 
	pierre.gondois@arm.com, sumitg@nvidia.com, acpica-devel@lists.linux.dev, 
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org, linuxarm@huawei.com, jonathan.cameron@huawei.com, 
	zhanjie9@hisilicon.com, lihuisong@huawei.com, cenxinghai@h-partners.com, 
	hepeng68@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 11, 2025 at 8:18=E2=80=AFPM Mario Limonciello
<mario.limonciello@amd.com> wrote:
>
> On 4/11/2025 4:38 AM, Lifeng Zheng wrote:
> > The patch series is organized in two parts:
> >
> >   - patch 1-6 refactor out the general CPPC register get and set functi=
ons
> >     in cppc_acpi.c
> >
> >   - patches 7-8 add functions for getting and setting values of auto_se=
l,
> >     energy_perf and auto_act_window in cppc_acpi.c
> >
> > Changelog:
> >
> > v7:
> >
> >   - Fix some typos
> >   - Add check of null pointer in cppc_get_reg_val(),
> >     cppc_get_auto_act_window() and cppc_get_auto_sel()
> >   - Replace ternary operator with logical expression in cppc_get_reg_va=
l()
> >
> > v6:
> >
> >   - Remove the last patch, will resent it in the future after reaching =
an
> >     agreement with Sumit
> >   - split patch 3 into 2 smaller patches
> >   - Remove the printing of reg_idx in cppc_get_reg_val() and
> >     cppc_set_reg_val()
> >   - Change the logic for determing whether a register is supported in
> >     cppc_get_reg_val() and cppc_set_reg_val()
> >
> > v5:
> >
> >   - add more explanation to the commit logs and comments
> >   - change REG_OPTIONAL from bin to hex
> >   - split patch 2 into 3 smaller patches
> >   - remove CPPC_REG_VAL_READ() and CPPC_REG_VAL_WRITE() macros
> >   - move the modification part in patch 5 into a separate patch
> >   - rename the sysfs file from "energy_perf" to
> >     energy_performance_preference_val
> >
> > v4:
> >
> >   - add REG_OPTIONAL and IS_OPTIONAL_CPC_REG to judge if a cpc register=
 is
> >     an optional one
> >   - check whether the register is optional before CPC_SUPPORTED check i=
n
> >     cppc_get_reg_val() and cppc_set_reg_val()
> >   - check the register's type in cppc_set_reg_val()
> >   - add macros to generally implement registers getting and setting
> >     functions
> >   - move some logic codes from cppc_cpufreq.c to cppc_acpi.c
> >   - replace cppc_get_auto_sel_caps() by cppc_get_auto_sel()
> >
> > v3:
> >
> >   - change cppc_get_reg() and cppc_set_reg() name to cppc_get_reg_val()=
 and
> >     cppc_set_reg_val()
> >   - extract cppc_get_reg_val_in_pcc() and cppc_set_reg_val_in_pcc()
> >   - return the result of cpc_read() in cppc_get_reg_val()
> >   - add pr_debug() in cppc_get_reg_val_in_pcc() when pcc_ss_id < 0
> >   - rename 'cpunum' to 'cpu' in cppc_get_reg_val()
> >   - move some macros from drivers/cpufreq/cppc_cpufreq.c to
> >     include/acpi/cppc_acpi.h with a CPPC_XXX prefix
> >
> > v2:
> >
> >   - fix some incorrect placeholder
> >   - change kstrtoul to kstrtobool in store_auto_select
> >
> > ---
> > Discussions of previous versions:
> > v1: https://lore.kernel.org/all/20241114084816.1128647-1-zhenglifeng1@h=
uawei.com/
> > v2: https://lore.kernel.org/all/20241122062051.3658577-1-zhenglifeng1@h=
uawei.com/
> > v3: https://lore.kernel.org/all/20241216091603.1247644-1-zhenglifeng1@h=
uawei.com/
> > v4: https://lore.kernel.org/all/20250113122104.3870673-1-zhenglifeng1@h=
uawei.com/
> > v5: https://lore.kernel.org/all/20250206131428.3261578-1-zhenglifeng1@h=
uawei.com/
> > v6: https://lore.kernel.org/all/20250409065703.1461867-1-zhenglifeng1@h=
uawei.com/
> >
> > Lifeng Zheng (8):
> >    ACPI: CPPC: Add IS_OPTIONAL_CPC_REG macro to judge if a cpc_reg is
> >      optional
> >    ACPI: CPPC: Optimize cppc_get_perf()
> >    ACPI: CPPC: Rename cppc_get_perf() to cppc_get_reg_val()
> >    ACPI: CPPC: Extract cppc_get_reg_val_in_pcc()
> >    ACPI: CPPC: Add cppc_set_reg_val()
> >    ACPI: CPPC: Refactor register value get and set ABIs
> >    ACPI: CPPC: Modify cppc_get_auto_sel_caps() to cppc_get_auto_sel()
> >    ACPI: CPPC: Add three functions related to autonomous selection
> >
> >   drivers/acpi/cppc_acpi.c     | 313 +++++++++++++++++++++-------------=
-
> >   drivers/cpufreq/amd-pstate.c |   3 +-
> >   include/acpi/cppc_acpi.h     |  30 +++-
> >   3 files changed, 219 insertions(+), 127 deletions(-)
> >
>
> Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>

All patches in the series applied as 6.16 material, thanks!

