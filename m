Return-Path: <linux-acpi+bounces-16264-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D1081B3EE3C
	for <lists+linux-acpi@lfdr.de>; Mon,  1 Sep 2025 21:01:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2592B2C0C90
	for <lists+linux-acpi@lfdr.de>; Mon,  1 Sep 2025 19:01:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 529652EF653;
	Mon,  1 Sep 2025 19:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GYASmNv7"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07B8F255F5C;
	Mon,  1 Sep 2025 19:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756753251; cv=none; b=h/BYHUuMdu/1+hUjk2tvs+3pzXpfE8AgVF8YVeZLv8vrSIWGtnUnLvc+UiLpDAyClVrXBiYnGjafy9gtI/Y4ElVJ+qOFWxHwLgopnz0u6D+5JhkE5i+MKVVEvHHhNo8z2CHNBJnb+n46YTkQjMd2Q8fZubtZRku9tJT34ksG2YU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756753251; c=relaxed/simple;
	bh=ZYcVa6pfew9PsKaI1xeXZkcLuBBn9KyqN+Fvtm6NigE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iFOOTYDnXgOC3966cGc2DkIhkfdJ+8LprM+XgCkbWk5GpumjL43k1smtJ7JehSbwvyhjvs/EKiz+C/5HPqY6G+7EnEDMvbCDYoY9WlWRBg30Qk6SaKmEMYwAkSNs0stfLT35qp1TZLe3L1RTCzhnLJwIXjY4Hzz7SwgKgGJmTAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GYASmNv7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AB1EC4CEFD;
	Mon,  1 Sep 2025 19:00:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756753250;
	bh=ZYcVa6pfew9PsKaI1xeXZkcLuBBn9KyqN+Fvtm6NigE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=GYASmNv7BXhIajZZoRvb4roQdeLOHe6DZu39BcO1fk3XdoM5eh0VcfQtL0m3quuCc
	 VfY4RDvrJWzYdoloiXZ/XMOyb4IB/7MMqZ3ghTJuyJZRW1PUgkkBbgY8P8JDOArlJq
	 cXkUAIQvYhsH8rYA6x3c30QbChvUVyxG/UaEM3AIgw10wa8gAYZQ0yaXhuW019nYPq
	 QZo68hY25IpTFJm1aTzpcT3Qlgk+Q6Li0ieGq05XQ4rps9rWq76W2uTFb/2Qgrh7rb
	 g9ntoHeNuOJYgLM88vGuTC8GhWhQK0luo8wjjwGvatzvam+tBPCx3FDu8zAaztdpgb
	 0yOsZCtsOz68A==
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-74526ca7a46so1594431a34.2;
        Mon, 01 Sep 2025 12:00:50 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUJowj0XZxUqRWTJdUfNeM3puIr6LUHU01MMotlg4y9+zSyx5byRhwwYkVo7twG43M1y6GZoz+3qHdPlAw=@vger.kernel.org, AJvYcCVOFva7j06wBRntkPIloSY6XSBaMB0Un11iIEWqUVva9RJl82Yu4Qz4B3jWTr31ijlc+A/XROI522A=@vger.kernel.org, AJvYcCWCUAWptoHsmgVcUI+ZqQ6vs7MW47UfJISdoZIVOmg+Om+roCV7TLJCbKfwUOBhp+j208Uy/0RCllDy@vger.kernel.org, AJvYcCWpKVhUjRh39OfgOoJdVGA3UOhl6vjj7h5kalO2Q8nrDWY7FcDWEq3JcdBVnqe2HQAIgc7ZlX2g7pZM@vger.kernel.org, AJvYcCXZRWh8KyF7fuN6waQwvuLqacb3XfoEYCyrPfvsRxkoXvjhtMT/K8DM9FjQFemkxvkwJlb+A5VKcuhuZNvb@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5yb8uKr3+52nG1hhZH8qxRcrVMsjcQ2N3H6vFazznrilGlOEw
	gszJQcSWLxdbHZobI/VqJg56yHDkv7iH/kZTj4p1G1YqWGF6FE5PSn1oXbFo4+ARwdN8CkCluUn
	HcVsYgPkpVErTNqqIZmoCB+42jzVEtcc=
X-Google-Smtp-Source: AGHT+IF5SaCmHwNGeJ545FabBGFRvWTGFT8zu6kM/v3+zLeQSnjYj3JgLDBA/Na6A5xsnHIoN5OKyg7BUGvdwPDyFD4=
X-Received: by 2002:a05:6830:6aa3:b0:745:46d6:e73f with SMTP id
 46e09a7af769-74569d764bamr4473355a34.1.1756753249708; Mon, 01 Sep 2025
 12:00:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250823200121.1320197-1-sumitg@nvidia.com> <20250823200121.1320197-2-sumitg@nvidia.com>
 <CAJZ5v0jXq48petXAcf1prb5iuHbh3i8XREJBscs88xs5RY_j=A@mail.gmail.com> <694a85ad-8b55-42e9-91fe-06d40fe8facd@nvidia.com>
In-Reply-To: <694a85ad-8b55-42e9-91fe-06d40fe8facd@nvidia.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 1 Sep 2025 21:00:38 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0ipt=zDDORjuHzuerfLryZO5NE1RpPfnADeWEqi6kyv6Q@mail.gmail.com>
X-Gm-Features: Ac12FXyb-_bL-3aCu5Q9p5j1OqNhu9RwBJNUi80YwR1oSvxk_jkaXysXbT37dzA
Message-ID: <CAJZ5v0ipt=zDDORjuHzuerfLryZO5NE1RpPfnADeWEqi6kyv6Q@mail.gmail.com>
Subject: Re: [PATCH v2 1/7] ACPI: CPPC: add perf control read API and clarify naming
To: Sumit Gupta <sumitg@nvidia.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, viresh.kumar@linaro.org, lenb@kernel.org, 
	robert.moore@intel.com, corbet@lwn.net, pierre.gondois@arm.com, 
	zhenglifeng1@huawei.com, ray.huang@amd.com, gautham.shenoy@amd.com, 
	mario.limonciello@amd.com, perry.yuan@amd.com, linux-pm@vger.kernel.org, 
	linux-acpi@vger.kernel.org, linux-doc@vger.kernel.org, 
	acpica-devel@lists.linux.dev, linux-kernel@vger.kernel.org, 
	linux-tegra@vger.kernel.org, treding@nvidia.com, jonathanh@nvidia.com, 
	vsethi@nvidia.com, ksitaraman@nvidia.com, sanjayc@nvidia.com, 
	bbasu@nvidia.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 1, 2025 at 3:46=E2=80=AFPM Sumit Gupta <sumitg@nvidia.com> wrot=
e:
>
>
> On 26/08/25 00:03, Rafael J. Wysocki wrote:
> > External email: Use caution opening links or attachments
> >
> >
> > On Sat, Aug 23, 2025 at 10:02=E2=80=AFPM Sumit Gupta <sumitg@nvidia.com=
> wrote:
> >> Add cppc_get_perf_ctrls() to read performance control register values.
> >> Rename existing APIs for clarity as:
> >> - To distinguish between:
> >>    - Feedback counters (fb_ctrs): Read-only performance monitoring dat=
a.
> >>    - Performance controls (perf_ctrls): Read-write config registers.
> >> - cppc_set_epp_perf() updates both EPP and Autonomous Selection.
> >>
> >> API's renamed:
> >> - cppc_set_perf() to cppc_set_perf_ctrls().
> >> - cppc_get_perf_ctrs() to cppc_get_perf_fb_ctrs().
> >> - cppc_get_perf_ctrs_sample() to cppc_get_perf_fb_ctrs_sample().
> >> - cppc_set_epp_perf() to cppc_set_epp_and_autosel().
> >> Remove redundant energy_perf field from 'struct cppc_perf_caps' since
> >> the same information is available in 'struct cppc_perf_ctrls' which is
> >> actively used.
> >>
> >> All existing callers are updated to maintain compatibility.
> >
> > First, this is too much in one patch IMV and second, I honestly don't
> > see a reason for the renames above.
> >
> > This generally makes tracking the code changes history harder.
> >
> > Thanks!
>
> Did the renaming for clarity and better readability.
> If we don't want to do that then i can drop the renaming and keep other
> changes.

Please do.

> Also, split this patch into two as below:
>          Patch1: Add cppc_get_perf() API.
>
>          Patch2:
>            - Update both EPP and Autonomous Selection in
> cppc_set_epp_perf().
>            - Remove redundant energy_perf field from 'struct
> cppc_perf_caps'.

Sounds reasonable to me.

Thanks!

