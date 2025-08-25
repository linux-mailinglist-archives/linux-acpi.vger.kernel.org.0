Return-Path: <linux-acpi+bounces-16050-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A67B7B34A71
	for <lists+linux-acpi@lfdr.de>; Mon, 25 Aug 2025 20:34:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D3AE176378
	for <lists+linux-acpi@lfdr.de>; Mon, 25 Aug 2025 18:34:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 680E63054E5;
	Mon, 25 Aug 2025 18:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F8n0lf5Y"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A904279788;
	Mon, 25 Aug 2025 18:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756146851; cv=none; b=e+3JofjxEBRmzqKQMPpj53I75iQnirnKDrk90vx6ffvyjWEL01kElmf3r66kZveW4h1N6MwgBRnfwHDumkzUwxqrTKLadC0qTBeKS29xxNnnaxtMCik6rF8vWjy/KOjMhpgMs/sgj0cPBO9Ckz4OfqSfI+NlJLNRYq8KdXJB+oo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756146851; c=relaxed/simple;
	bh=Ht6Ty4HMgHXkptKsvwVhVc6YUizCpYenVMcNjJ3Igh4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ttm2ALLaw9QDSGumRX5Zjczi9yOGdiBR+dPUb7hHwdJCxLiXq/OI6u0jv8aYUgHC8DUKPy8/OV3UpTGYh09cK0VIoRsOk+B7R9niT+6TV1A4gkTj9pH1gr/GgA/c5Yq41zzDWFkAyCsBeixTvwSp1VNAaf8t4YiA8CZvFfAWACI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F8n0lf5Y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6D8BC4CEF1;
	Mon, 25 Aug 2025 18:34:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756146850;
	bh=Ht6Ty4HMgHXkptKsvwVhVc6YUizCpYenVMcNjJ3Igh4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=F8n0lf5YKeHt/GO6Xj7K7p1qqX6rfSeF2zPNsWMx+codVZ+d2dyL6ZM2ceQe5Z+bf
	 hcWig4vuK+f8Z3pa/tCPP+WOC4txtC9G5UQC8f3PmM94edV1Nb22Inf2ReEE76bOyz
	 vqbvTO2wv0qDlZrWSAWN4bT+9D2AlmoW9bPXCslKXpJKmJZ1AhRKneVOcGNOyvXm9O
	 QIdsrytl4dt71qeO4+sPHZTVvDTnfC50HiPkiCdzReLpHrikX/vGbqstvInoPlTLwC
	 1sRNr0EtKuIaXjheocguQ8g3MnEb7x+8itq5jCwRqZF1JuzSvWKw6+VampOE7xDWKs
	 AZfgWzdtfjWIw==
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-74381ee9bc9so3629612a34.1;
        Mon, 25 Aug 2025 11:34:10 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUINPynOL4E1FRx5Z6BDEJMv+OyeBO6H647D+0UCcZESosL1SuK8JZfNAeGYZeiQv587lo9fxp/OAo=@vger.kernel.org, AJvYcCVtDarQP85ySNHYAi/7ShAls1zffv+EZosSL6DVa1D7dkMiJfN4mju7zgKTOnvHE/LJXeYCBU+HVxLt@vger.kernel.org, AJvYcCWa2i0B9kbnkxOioXgBGqIl7xAsZFfo0Uz9D1W0gMqQYdtZBcst1nE+6Mx8f1Rol9Z9zaXFk689JsqBW7I=@vger.kernel.org, AJvYcCWlDvQ8HZCPllAsqMnz1SWvoooLyYYM9E/xJ0+S2JEIxy0+SWhs3sbj/MEctr+gJIqRv6drGIEQcOixHZnL@vger.kernel.org, AJvYcCX39rGIyxX0MF1jW/sw5daP4/SUxdOoNepPuKNK7JRHI4wvYscDGsONQG8hbMLYJ9My0h5UVt+GpKhw@vger.kernel.org
X-Gm-Message-State: AOJu0YwAeAGWGaGmobIUGUQfiQJN27Nj8qEgZwMw/eetA+rKTWRB/wxb
	KIv36rMXhYHMmiwjLf2sj3Ikj9ey1WrtTUD5mypxbvqHSC7ZDwUsDoms74e+exu6AYuzz91AbNV
	NWSWAM0FPK6RdA9B45e3UnCWOAaFRRns=
X-Google-Smtp-Source: AGHT+IHOdqhSf16jWGRcPAvbxlN2ZXUmIBB2uN/1WgJfcSLIG0m4VCECUYlhKbhCRJEh4XlchnV+Lnmjn5HMlKfQ8Mk=
X-Received: by 2002:a05:6830:d89:b0:742:fadb:1cfe with SMTP id
 46e09a7af769-74500a6c5c9mr5751454a34.23.1756146850090; Mon, 25 Aug 2025
 11:34:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250823200121.1320197-1-sumitg@nvidia.com> <20250823200121.1320197-2-sumitg@nvidia.com>
In-Reply-To: <20250823200121.1320197-2-sumitg@nvidia.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 25 Aug 2025 20:33:59 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0jXq48petXAcf1prb5iuHbh3i8XREJBscs88xs5RY_j=A@mail.gmail.com>
X-Gm-Features: Ac12FXzGQmMPPTj9b7D4No9vjaMddzqO9PMsplBUU_t1OqXhbaRHMZ7Y9l1HfgA
Message-ID: <CAJZ5v0jXq48petXAcf1prb5iuHbh3i8XREJBscs88xs5RY_j=A@mail.gmail.com>
Subject: Re: [PATCH v2 1/7] ACPI: CPPC: add perf control read API and clarify naming
To: Sumit Gupta <sumitg@nvidia.com>
Cc: rafael@kernel.org, viresh.kumar@linaro.org, lenb@kernel.org, 
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

On Sat, Aug 23, 2025 at 10:02=E2=80=AFPM Sumit Gupta <sumitg@nvidia.com> wr=
ote:
>
> Add cppc_get_perf_ctrls() to read performance control register values.
> Rename existing APIs for clarity as:
> - To distinguish between:
>   - Feedback counters (fb_ctrs): Read-only performance monitoring data.
>   - Performance controls (perf_ctrls): Read-write config registers.
> - cppc_set_epp_perf() updates both EPP and Autonomous Selection.
>
> API's renamed:
> - cppc_set_perf() to cppc_set_perf_ctrls().
> - cppc_get_perf_ctrs() to cppc_get_perf_fb_ctrs().
> - cppc_get_perf_ctrs_sample() to cppc_get_perf_fb_ctrs_sample().
> - cppc_set_epp_perf() to cppc_set_epp_and_autosel().

> Remove redundant energy_perf field from 'struct cppc_perf_caps' since
> the same information is available in 'struct cppc_perf_ctrls' which is
> actively used.
>
> All existing callers are updated to maintain compatibility.

First, this is too much in one patch IMV and second, I honestly don't
see a reason for the renames above.

This generally makes tracking the code changes history harder.

Thanks!

