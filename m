Return-Path: <linux-acpi+bounces-20674-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iNSUHWrneGmHtwEAu9opvQ
	(envelope-from <linux-acpi+bounces-20674-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Tue, 27 Jan 2026 17:27:22 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D15B397BF1
	for <lists+linux-acpi@lfdr.de>; Tue, 27 Jan 2026 17:27:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5F711301A73C
	for <lists+linux-acpi@lfdr.de>; Tue, 27 Jan 2026 16:27:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C501361DA3;
	Tue, 27 Jan 2026 16:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tbPfsQ0j"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59E1D36165A
	for <linux-acpi@vger.kernel.org>; Tue, 27 Jan 2026 16:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769531239; cv=none; b=Ks78Si18pvBI973C5SbphqRczS3ZM0DwoDsJ3Mx/beEfUM9iqJLmLWpY4y0JFKJesRliEKH2A69Ec9X/JAPI32G9csj8qLGxwNfOWEBuUIuv9oIfNbM3gL0AIjCZZK641dBaPmjkzacV6tepFVjRASSbNKwfoOmlOjhluyhW4Y4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769531239; c=relaxed/simple;
	bh=BWXp9go9XfwSeW0YCc/iImV8Xt/lH6uEAIKNCqQ8bHk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LagQtgjwImPZCo/mlDeIP+ODB3/Y6Nl9jvAKPCXUZ6sFgd358E+MmwEHhlunfgymxKisra5YP4KSp/Xi17FrZwOZsU58MI2OomQDextbqc0CaXlGdD0cCiC0bKgMtUzJ/3PpXbV9G1vlosDZT/sjnt/HXVvWHlbVzr40cjGwjhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tbPfsQ0j; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAFF2C16AAE
	for <linux-acpi@vger.kernel.org>; Tue, 27 Jan 2026 16:27:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769531239;
	bh=BWXp9go9XfwSeW0YCc/iImV8Xt/lH6uEAIKNCqQ8bHk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=tbPfsQ0jvKjqDadmAxnw4cxgLq2iOgtsopUYjRsZYeDlmgS0HemYTrxL4xcrC6hzP
	 5aqJ4bB+ivCwlfZuEtb81LDNxCaKctH+A6DFxVczaUWDMJruOCASRthGTQh+XuUI6e
	 eGg+3Bhm+ktRpQ3lm/49C6P5lbHHc5RMnwP6UKQU7crHz53hdL41VfO9Hz+TSJ7bBs
	 cj6yEkM4H5hoJhVGUVaddK1243RiErhqPRkhNXY0Rwlf+LWVRabEjVzoyLYD7keyVR
	 DvXgrx+BSUSPUV4v/OWBwL2GrzqjwoHbYrBr56s0uaCAj1Vg1OhBFzqQQLwmmePAHF
	 mAnux6qepiv0Q==
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-662f30d3f1fso271536eaf.1
        for <linux-acpi@vger.kernel.org>; Tue, 27 Jan 2026 08:27:18 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWYp3o+yC/6PQ3T0c8ACfsC6KaQKlp/k59QTlIg9JoXH4VQqOV7HdW7/X252TemjG4bwWs5vJnbdBt3@vger.kernel.org
X-Gm-Message-State: AOJu0YxDXfll643QigM122MPlkdS6Lhr3/5slBnB1OV+nSf0yYIGpv4T
	XA4EzvZs2kWdu0lX3Jw7RlH2EgMyshiWr7YCBQK7OjMyJm0t+faHN7kEI2XNREcwYspdsCRGPsd
	a/P+OeNSUAqmJF0obS12sfp0O9CfDPbU=
X-Received: by 2002:a05:6820:440f:b0:659:9a49:8edc with SMTP id
 006d021491bc7-662f205e135mr934882eaf.16.1769531238024; Tue, 27 Jan 2026
 08:27:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260120145623.2959636-1-sumitg@nvidia.com> <20260120145623.2959636-3-sumitg@nvidia.com>
In-Reply-To: <20260120145623.2959636-3-sumitg@nvidia.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 27 Jan 2026 17:27:07 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0i-fgbpfd-iHcNNtnFU79Whs+Maknx3ou4oNOADzAZmxg@mail.gmail.com>
X-Gm-Features: AZwV_QjSIa14EzdtQMBjWmzIWxgVIX9AlsvjWJH35lHYiUt_r6wvkA4ONqxelYY
Message-ID: <CAJZ5v0i-fgbpfd-iHcNNtnFU79Whs+Maknx3ou4oNOADzAZmxg@mail.gmail.com>
Subject: Re: [PATCH v6 2/9] ACPI: CPPC: Clean up cppc_perf_caps and
 cppc_perf_ctrls structs
To: Sumit Gupta <sumitg@nvidia.com>
Cc: rafael@kernel.org, viresh.kumar@linaro.org, pierre.gondois@arm.com, 
	zhenglifeng1@huawei.com, ionela.voinescu@arm.com, lenb@kernel.org, 
	robert.moore@intel.com, corbet@lwn.net, rdunlap@infradead.org, 
	ray.huang@amd.com, gautham.shenoy@amd.com, mario.limonciello@amd.com, 
	perry.yuan@amd.com, zhanjie9@hisilicon.com, linux-pm@vger.kernel.org, 
	linux-acpi@vger.kernel.org, linux-doc@vger.kernel.org, 
	acpica-devel@lists.linux.dev, linux-kernel@vger.kernel.org, 
	linux-tegra@vger.kernel.org, treding@nvidia.com, jonathanh@nvidia.com, 
	vsethi@nvidia.com, ksitaraman@nvidia.com, sanjayc@nvidia.com, 
	nhartman@nvidia.com, bbasu@nvidia.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20674-lists,linux-acpi=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_TWELVE(0.00)[28];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rafael@kernel.org,linux-acpi@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-acpi];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,arm.com:email,mail.gmail.com:mid]
X-Rspamd-Queue-Id: D15B397BF1
X-Rspamd-Action: no action

On Tue, Jan 20, 2026 at 3:57=E2=80=AFPM Sumit Gupta <sumitg@nvidia.com> wro=
te:
>
> - Remove redundant energy_perf field from 'struct cppc_perf_caps' as
>   the same is available in 'struct cppc_perf_ctrls' which is used.
> - Move the 'auto_sel' field from 'struct cppc_perf_caps' to
>   'struct cppc_perf_ctrls' as it represents a control register.
>
> Reviewed-by: Pierre Gondois <pierre.gondois@arm.com>
> Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
> ---
>  include/acpi/cppc_acpi.h | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/include/acpi/cppc_acpi.h b/include/acpi/cppc_acpi.h
> index 4bcdcaf8bf2c..6573a759eb8d 100644
> --- a/include/acpi/cppc_acpi.h
> +++ b/include/acpi/cppc_acpi.h
> @@ -119,8 +119,6 @@ struct cppc_perf_caps {
>         u32 lowest_nonlinear_perf;
>         u32 lowest_freq;
>         u32 nominal_freq;
> -       u32 energy_perf;
> -       bool auto_sel;
>  };
>
>  struct cppc_perf_ctrls {
> @@ -128,6 +126,7 @@ struct cppc_perf_ctrls {
>         u32 min_perf;
>         u32 desired_perf;
>         u32 energy_perf;
> +       bool auto_sel;
>  };
>
>  struct cppc_perf_fb_ctrs {
> --

It looks like this patch and the next one can be applied independently
of the other patches in the series.

Do you want me to do that?

