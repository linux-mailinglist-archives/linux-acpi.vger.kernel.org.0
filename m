Return-Path: <linux-acpi+bounces-14454-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59DB2ADF697
	for <lists+linux-acpi@lfdr.de>; Wed, 18 Jun 2025 21:06:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E8D204A1CE9
	for <lists+linux-acpi@lfdr.de>; Wed, 18 Jun 2025 19:06:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03081207E1D;
	Wed, 18 Jun 2025 19:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MYRg7pu4"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C96D33085A0;
	Wed, 18 Jun 2025 19:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750273605; cv=none; b=Y40O9PRbdfhCdC81WShxxTw6Lo3Sbo1ELTmQNXDad9UkQFvcj55qzlgvu5DcnVg3pL/qfh6ehLjqBM4CHnaq/rQpDTxIMOLTo9gQzTWnXghy0pfC7tzG9nrthTO3CfuzY6vD7q6nrmEIubOHs2Y9YgKYqchBOwV527V/l8mD7fM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750273605; c=relaxed/simple;
	bh=EHmiysc4K5wFAmpABIog2DSAWbEeaG2Fbtlw/lbgzZU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UoM1xuEYH6OtiRLUzkUw0GexjaNXRg0dYWb2iIyz6w2LsE6Qq118xMuOk2e6Ku9YK9iZ0TsiqjaN+6XRadBGFiyB9aWA61FGY9Cd/kw8PMjM3Th+PH/cuSX+T3l9sKK32trWuuWnh0dwI/VXRtCVmDlprufS7eDgSV9rSQs7/iQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MYRg7pu4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 456D9C4CEE7;
	Wed, 18 Jun 2025 19:06:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750273605;
	bh=EHmiysc4K5wFAmpABIog2DSAWbEeaG2Fbtlw/lbgzZU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=MYRg7pu4mQudGg+o8zANIqWe0R7Pm6I4h4TpH/dIyr/1nXcV9nhP3VfyyUIf7QYeE
	 OYEURR5eikNl/sNhlmL/oEbLZyB4x0GEtwjFUXrInYlQKkqalRgXDF7rScgsuNiWUR
	 b5Hfp1JJr2kZehk6dDnu2/zEsiXo/2iQBXh4yo8L/wQhvGSDQcoqhDSJOcURga3+bf
	 zQ6WTsXVHPGaH2MDHDgW20iTyyHr8EEEE9IGqs0TLhA9wcsqx3Jo9v3aRPVA2+JHRB
	 neanNkD++1zYD/8LqqekBtJ6cT/hGWTCxS87iDBksYJ5TOg7YmNuIi47sJ8vT3IZIp
	 q3YZrcLXjmiGg==
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-6060a70ba80so441eaf.2;
        Wed, 18 Jun 2025 12:06:45 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVMOS4m6apZ8acPX2DMTFS1Leuw6AbGpOK5ZJjnPK3V0Uy0u9k+JMUC1g7qqiR+enIzvfDPta700uifvOhw@vger.kernel.org, AJvYcCXppFvSjHf9sWp0es41v6b62hBv15qJPzp38sk7I4WBrl8pk8+JlEbEDNh6ykDkW0v3b5PUsv/9UdWx@vger.kernel.org, AJvYcCXpqJ8FlMnvK/VaTx//dFoFp3c89PmJOzlOR5yNQiS7e7BqDRaJ+ZYorQXL4bUBQYgNddPTGfS0wQs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzqJoXg4c9K+dLcN+x4O71AA5XB5q6jWaR/CJu1U62mKXiQ55IA
	BHds1VGDD/VlJX5DtPAWX43HlUWtLwNEXhSuEVOTWpjvHbtOzpU39Ll/uJakbzYQIaBFa0Zk2wD
	Y0SFHsgPZcVYQYIN+zGHGJBs5I3q0hPs=
X-Google-Smtp-Source: AGHT+IFDAhZp4oOZmcVULYoPnu3Ouw/DcQLKRdnhxYk96qIBfbDhtVKhqkWyeJRSQzQaJkZHv0Pl/v4xe0PLXQADyAU=
X-Received: by 2002:a05:6820:823:b0:611:2c55:3a4f with SMTP id
 006d021491bc7-6112c553b7emr5048981eaf.2.1750273604624; Wed, 18 Jun 2025
 12:06:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250526113057.3086513-1-zhenglifeng1@huawei.com> <9c82abca-0772-444c-8122-59a953c83984@huawei.com>
In-Reply-To: <9c82abca-0772-444c-8122-59a953c83984@huawei.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 18 Jun 2025 21:06:32 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0hyMANsOwskEUi1c3XB+heE6z0_-Dk1nqnw-SbZ0dM3zA@mail.gmail.com>
X-Gm-Features: AX0GCFu09GYGv3-1LtFQtFZlu_rSLSPXEyv-4bIne3RWnOaGRgRR2K9KgIagK-A
Message-ID: <CAJZ5v0hyMANsOwskEUi1c3XB+heE6z0_-Dk1nqnw-SbZ0dM3zA@mail.gmail.com>
Subject: Re: [PATCH 0/3] cpufreq: CPPC: Some optimizations for cppc_cpufreq.c.
To: "zhenglifeng (A)" <zhenglifeng1@huawei.com>, viresh.kumar@linaro.org
Cc: robert.moore@intel.com, lenb@kernel.org, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, linuxarm@huawei.com, 
	jonathan.cameron@huawei.com, zhanjie9@hisilicon.com, lihuisong@huawei.com, 
	yubowen8@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 17, 2025 at 4:33=E2=80=AFAM zhenglifeng (A) <zhenglifeng1@huawe=
i.com> wrote:
>
> Gentle ping.
>
> On 2025/5/26 19:30, Lifeng Zheng wrote:
> > This patch series makes some minor optimizations for cppc_cpufreq.c to
> > makes codes cleaner.
> >
> > Lifeng Zheng (3):
> >   cpufreq: CPPC: Remove cpu_data_list
> >   cpufreq: CPPC: Return void in populate_efficiency_class()
> >   cpufreq: CPPC: Remove forward declaration of
> >     cppc_cpufreq_register_em()
> >
> >  drivers/cpufreq/cppc_cpufreq.c | 59 +++++++++-------------------------
> >  include/acpi/cppc_acpi.h       |  1 -
> >  2 files changed, 15 insertions(+), 45 deletions(-)

I've started to process this because it has been sent to linux-acpi
and then I realized that Viresh should take it, but since I've applied
it already, I may as well queue it up for 6.17.

Viresh, please let me know if you have any concerns about it.

Thanks!

