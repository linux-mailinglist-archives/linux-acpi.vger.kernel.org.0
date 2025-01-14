Return-Path: <linux-acpi+bounces-10640-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 48A81A10ED8
	for <lists+linux-acpi@lfdr.de>; Tue, 14 Jan 2025 19:02:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 49B8F188B21A
	for <lists+linux-acpi@lfdr.de>; Tue, 14 Jan 2025 18:02:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E64920AF90;
	Tue, 14 Jan 2025 17:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="On0icLC/"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 104751FCD1A;
	Tue, 14 Jan 2025 17:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736877531; cv=none; b=aaLN470424nxKjpPVIsSnLi38FZsDkncs/M9PY9ZA1tPkVvvpyIkIVqDPJ7bm5FxGy2xlVJziuPOfwO4Wl2dJTYASGwkVr2vYxYVlUVOUC0bqIsW86dj/rSjQ0pzNS1cMqTgitpoh1zAME4QEmBVqjvojMFHszqPk/PM+qxcFCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736877531; c=relaxed/simple;
	bh=QMVdysp1bNs9gS/O+OM9aj9n+vRbf8P9M4FQlGF2t8A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VfOLCDkiOJ/grCbb76YEbVnBWVbmytNQxwUpumKMEtdUp6T0yIkGSe099rmJo21Dgkw+xDvV7bzKjnoWE6qnwOPY2K64jgp5mv3Va6X6lu7tYE+9cmov0rHH3PIqCghXvfiYBrYJtfAs5x0LlB5dTRmjPkTff8HbnnM4Bdk6qr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=On0icLC/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF29FC4CEE4;
	Tue, 14 Jan 2025 17:58:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736877530;
	bh=QMVdysp1bNs9gS/O+OM9aj9n+vRbf8P9M4FQlGF2t8A=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=On0icLC/K314f32KVZZHPFUJmcAVo2/8VsQF5Ju1aIbC6m9fUfHp2mi+HcZ+sYGyq
	 FJfnXWycuziAIXJEu70eRZZO9cAm4Osg6DtiroMzF2UrFN4Yf1M0kJidnjHWB4Xu7S
	 4k++KUKztZcgBvRZvxaxjahhvK5ECKX8lJD5c9WfnGull/LSKgtXJzEodYOT8bH76Z
	 swzvLSAFM+oawQg1BtJDcC6xxhdAH6atdRrQ8RkssKp1Ufd1wyI5TI6XmyxIAFgFtL
	 6p/rzUaJmOq9iuMIDZTigkuJcJD4hUm97TUQU0l8dZRyKAEvRtmS2vZ3juKFx2rZK5
	 ceBZeon2qA/wg==
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-3eb8559b6b0so3348132b6e.1;
        Tue, 14 Jan 2025 09:58:50 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUozn2Vcbban7nGb+LxirJss7UMJlbnRFmYeqOfPLiRF7YcnrB0bGhZHgGW2idcBu1nE6vhpcTgTWSQ@vger.kernel.org, AJvYcCWjtEnF8ITzlRvUXSVqNZDGJVwsOvrvpX0InD0ilpTp+xfrJzuozU+Fc14KN7emioNIf/LCCu5EHi/pJGNt@vger.kernel.org, AJvYcCXQPZoTA2tl//qQgyzFHZ5DtzxZexS8/2J9rx+ZV1FrhSSf9Tlce2GsR2Nbtlc8kOIaop/9P/ECY4I=@vger.kernel.org
X-Gm-Message-State: AOJu0YywBN4iXNuyvfYrRSxvvswCdbPk7gKRe3wRzhQkXZt23wxje3GO
	DqL5a1+waNH0HEgEvWVmVZKRme1o7t2mPTCnol5/HxBpEX627BS61rhVzBo3KjWvV12yXTfrTeP
	43s8eVSZZt9Sb5pBfA4njEjddz6s=
X-Google-Smtp-Source: AGHT+IFVH7/p7XT/F+M/730zJz1baSx0oUsDTd7oshF25Ya68iWu81vlpGzooaTacLKZJbSJtPbOVmxHPLBGn6N0arc=
X-Received: by 2002:a05:6808:3387:b0:3eb:5bf7:65d2 with SMTP id
 5614622812f47-3ef2ec9b534mr16576932b6e.25.1736877530029; Tue, 14 Jan 2025
 09:58:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250113122104.3870673-1-zhenglifeng1@huawei.com> <20250113122104.3870673-4-zhenglifeng1@huawei.com>
In-Reply-To: <20250113122104.3870673-4-zhenglifeng1@huawei.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 14 Jan 2025 18:58:39 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0jwqZ4A=eeHSXGHKpj-g+KFNWvgLB_yjM55Yk37LryrwQ@mail.gmail.com>
X-Gm-Features: AbW1kvblVD7sqUVmGZEwKFjQRVpCMUpuQrDYT3u49qGLCKszlrjGSJJ1fOt6yoI
Message-ID: <CAJZ5v0jwqZ4A=eeHSXGHKpj-g+KFNWvgLB_yjM55Yk37LryrwQ@mail.gmail.com>
Subject: Re: [PATCH v4 3/6] ACPI: CPPC: Add macros to generally implement
 registers getting and setting functions
To: Lifeng Zheng <zhenglifeng1@huawei.com>
Cc: rafael@kernel.org, lenb@kernel.org, robert.moore@intel.com, 
	viresh.kumar@linaro.org, mario.limonciello@amd.com, gautham.shenoy@amd.com, 
	ray.huang@amd.com, pierre.gondois@arm.com, acpica-devel@lists.linux.dev, 
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org, linuxarm@huawei.com, jonathan.cameron@huawei.com, 
	zhanjie9@hisilicon.com, lihuisong@huawei.com, hepeng68@huawei.com, 
	fanghao11@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 13, 2025 at 1:21=E2=80=AFPM Lifeng Zheng <zhenglifeng1@huawei.c=
om> wrote:
>
> Add CPPC_REG_VAL_READ() to implement registers getting functions.
>
> Add CPPC_REG_VAL_WRITE() to implement registers setting functions.
>
> Signed-off-by: Lifeng Zheng <zhenglifeng1@huawei.com>

I don't particularly like these macros as they will generally make it
harder to follow the code.

> ---
>  drivers/acpi/cppc_acpi.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
>
> diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
> index 571f94855dce..6326a1536cda 100644
> --- a/drivers/acpi/cppc_acpi.c
> +++ b/drivers/acpi/cppc_acpi.c
> @@ -1279,6 +1279,20 @@ static int cppc_set_reg_val(int cpu, enum cppc_reg=
s reg_idx, u64 val)
>         return cpc_write(cpu, reg, val);
>  }
>
> +#define CPPC_REG_VAL_READ(reg_name, reg_idx)           \
> +int cppc_get_##reg_name(int cpu, u64 *val)             \
> +{                                                      \
> +       return cppc_get_reg_val(cpu, reg_idx, val);     \
> +}                                                      \
> +EXPORT_SYMBOL_GPL(cppc_get_##reg_name)

What about if defining something like

#define CPPC_READ_REG_VAL(cpu, reg_name, val)
cppc_get_reg_val((cpu), CPPC_REG_IDX(reg_name), (val))

(and analogously for the WRITE_ part), where CPPC_REG_IDX(reg_name) is

#define CPPC_REG_IDX(reg_name)    CPPC_REG_##reg_name_IDX

and there are CPPC_REG_##reg_name_IDX macros defined for all register
names in use?

For example

#define CPPC_REG_desired_perf_IDX   DESIRED_PERF

