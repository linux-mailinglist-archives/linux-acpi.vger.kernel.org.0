Return-Path: <linux-acpi+bounces-10680-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5343BA12234
	for <lists+linux-acpi@lfdr.de>; Wed, 15 Jan 2025 12:13:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8F3DE1888899
	for <lists+linux-acpi@lfdr.de>; Wed, 15 Jan 2025 11:13:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA2A91EEA20;
	Wed, 15 Jan 2025 11:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="djdd+Tiv"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ADEF248BB9;
	Wed, 15 Jan 2025 11:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736939589; cv=none; b=n42nloRqURDwrJiK9rs8Zvnai3jMb1s8P3wQGnOs3EbJ5C7haMSwvSLXpDpjru34kJhn6v4+VhZMcVdho90eq8/xizBP6wSPZfgRvYaGu+rNYgNy/3MB58hf3rMXa3LCy+346iIBoku8IBRVd6bkvgM2Vzl3QC1HHjRqaZelWqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736939589; c=relaxed/simple;
	bh=6jO4WiPBhFzgyb9GhdkgahEyUDYbh3P2ioXyxGAwVdw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=m8jBLfaqSfdNUADT4tesgL6ciMN/aHAzBrelzxxoClh3WzCivG3F/FWFavs+Xk1pqlNEPzFHdhTJGD7+gfXxvDyofPLByATYwyGNPoTesj9JC/pSC1/pdds4Cpjc/pytIAlagYV521sX2O8ga0XTGHrfjzTZQGEqCJ2dhuigrTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=djdd+Tiv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23620C4CEE2;
	Wed, 15 Jan 2025 11:13:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736939589;
	bh=6jO4WiPBhFzgyb9GhdkgahEyUDYbh3P2ioXyxGAwVdw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=djdd+TivZehmhPLpPa4kJZz1+1z7/jt7y/q8s7pcUVQ0XE7AgDNQ/c3m+ICnbvMuD
	 lRMAXCi4jKbjH8de34O9BIT+bRBJQOnltJD655VBtdT3Qfpp1+EZROiWBA38Ybsm5s
	 gSrjMZRaz1X9yEsSyrZbf4Cc5j5xsUPq5EnxgpDn/pIHhUySnXPj/MBeon4a4BLEp3
	 JpDZpuNsiz3YRiu3fDY4IcRO1q0/nZVaEuWzxjM4xTMEo9aeG4/mzPN9AO518PCLoz
	 NFfYVo/qtARRITXmuRpsHpE300Ql2UVV018us7d6KeA6xTL//cWAg8jx7WU1+urNEN
	 vql5fiqTXQm9w==
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-3eb8559b6b0so3761316b6e.1;
        Wed, 15 Jan 2025 03:13:09 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWcfkI+Ykwt/k5EpyLZj6LsbNTKyaTVj9W1fyPO0TEC+gBW+Jjy4yK8v2NSBWkLYzGHrClGsd1H+oFoH1bZ@vger.kernel.org, AJvYcCWwF+/y3LK44aOCrhBS1kOZ9CD5f5qWK9ktlwNLlZK27aBhwGiEyl/JdWcGlQzMbDVtloL3DKcqTuc=@vger.kernel.org, AJvYcCXjG3BP+qn6txmyVPUbEwCNNYL3SiFaUQF07u4Q6rmeQoOvwL8A9F33GrugLGneHLq5XQfrcHTp3q/D@vger.kernel.org
X-Gm-Message-State: AOJu0YxW6A90PdioAUQkRwXUbGGpCpwbz/nt4t91csrvutZ07yI21u+r
	pQ9ZBeTDwuztGKH01BbieCU7wAfFKnddhJiX5qKe0t97kzKMJ+uOHvJswnHg14sgl7qYNivzpsR
	NAEPT4cCHpi4CKaMxwc3Oo3LHPjs=
X-Google-Smtp-Source: AGHT+IHnnDdSk0+UGjbtKgUlEIzX22igfm/NGfH82JBFguw7/RwNA1HP/MBV1bCC8lSJ8ui81Ri8tBig7u5Nt4aXNpU=
X-Received: by 2002:a05:6808:3095:b0:3eb:a602:62b1 with SMTP id
 5614622812f47-3ef2ec43a84mr18858448b6e.17.1736939588258; Wed, 15 Jan 2025
 03:13:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250113122104.3870673-1-zhenglifeng1@huawei.com>
 <20250113122104.3870673-4-zhenglifeng1@huawei.com> <CAJZ5v0jwqZ4A=eeHSXGHKpj-g+KFNWvgLB_yjM55Yk37LryrwQ@mail.gmail.com>
 <10a624c3-66c1-420c-860d-2ef9104b59d8@huawei.com>
In-Reply-To: <10a624c3-66c1-420c-860d-2ef9104b59d8@huawei.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 15 Jan 2025 12:12:57 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0jmZy0tNO7Btc9-A0rfzL5jPp2ZEH99bEX00cEi3z+XcQ@mail.gmail.com>
X-Gm-Features: AbW1kvbIZPwFXAmyiLrc7Lroo3xglhf9zN2VVd-BjjjHc-QrsQ-2BYDR3RYvtEs
Message-ID: <CAJZ5v0jmZy0tNO7Btc9-A0rfzL5jPp2ZEH99bEX00cEi3z+XcQ@mail.gmail.com>
Subject: Re: [PATCH v4 3/6] ACPI: CPPC: Add macros to generally implement
 registers getting and setting functions
To: "zhenglifeng (A)" <zhenglifeng1@huawei.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, lenb@kernel.org, robert.moore@intel.com, 
	viresh.kumar@linaro.org, mario.limonciello@amd.com, gautham.shenoy@amd.com, 
	ray.huang@amd.com, pierre.gondois@arm.com, acpica-devel@lists.linux.dev, 
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org, linuxarm@huawei.com, jonathan.cameron@huawei.com, 
	zhanjie9@hisilicon.com, lihuisong@huawei.com, hepeng68@huawei.com, 
	fanghao11@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 15, 2025 at 9:59=E2=80=AFAM zhenglifeng (A) <zhenglifeng1@huawe=
i.com> wrote:
>
> On 2025/1/15 1:58, Rafael J. Wysocki wrote:
>
> > On Mon, Jan 13, 2025 at 1:21=E2=80=AFPM Lifeng Zheng <zhenglifeng1@huaw=
ei.com> wrote:
> >>
> >> Add CPPC_REG_VAL_READ() to implement registers getting functions.
> >>
> >> Add CPPC_REG_VAL_WRITE() to implement registers setting functions.
> >>
> >> Signed-off-by: Lifeng Zheng <zhenglifeng1@huawei.com>
> >
> > I don't particularly like these macros as they will generally make it
> > harder to follow the code.
> >
> >> ---
> >>  drivers/acpi/cppc_acpi.c | 14 ++++++++++++++
> >>  1 file changed, 14 insertions(+)
> >>
> >> diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
> >> index 571f94855dce..6326a1536cda 100644
> >> --- a/drivers/acpi/cppc_acpi.c
> >> +++ b/drivers/acpi/cppc_acpi.c
> >> @@ -1279,6 +1279,20 @@ static int cppc_set_reg_val(int cpu, enum cppc_=
regs reg_idx, u64 val)
> >>         return cpc_write(cpu, reg, val);
> >>  }
> >>
> >> +#define CPPC_REG_VAL_READ(reg_name, reg_idx)           \
> >> +int cppc_get_##reg_name(int cpu, u64 *val)             \
> >> +{                                                      \
> >> +       return cppc_get_reg_val(cpu, reg_idx, val);     \
> >> +}                                                      \
> >> +EXPORT_SYMBOL_GPL(cppc_get_##reg_name)
> >
> > What about if defining something like
> >
> > #define CPPC_READ_REG_VAL(cpu, reg_name, val)
> > cppc_get_reg_val((cpu), CPPC_REG_IDX(reg_name), (val))
> >
> > (and analogously for the WRITE_ part), where CPPC_REG_IDX(reg_name) is
> >
> > #define CPPC_REG_IDX(reg_name)    CPPC_REG_##reg_name_IDX
> >
> > and there are CPPC_REG_##reg_name_IDX macros defined for all register
> > names in use?
> >
> > For example
> >
> > #define CPPC_REG_desired_perf_IDX   DESIRED_PERF
>
> What about keeping these two macros but replace reg_idx with
> CPPC_REG_IDX(reg_name)? With this, the only needed parameter for these tw=
o
> macros is reg_name.

The problem is that looking up functions defined through macros is
hard when somebody wants to know what they do, so I'd prefer to avoid
doing that.

