Return-Path: <linux-acpi+bounces-16109-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 41E92B38488
	for <lists+linux-acpi@lfdr.de>; Wed, 27 Aug 2025 16:13:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB02D681CD4
	for <lists+linux-acpi@lfdr.de>; Wed, 27 Aug 2025 14:13:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C88835A2B2;
	Wed, 27 Aug 2025 14:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dWTiy0/i"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D691835A2A1
	for <linux-acpi@vger.kernel.org>; Wed, 27 Aug 2025 14:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756303995; cv=none; b=Ipq0mMbFDO9vxEX2/eaq9gBfSDWLZvNy0uYAyzU2/NLpNg0hPitgXlbnrd3NFOculsM2lGS/H3zJJ3e5Buf/mwXsTL0UZiXSWE/mRSFnw7YGopp9VDN8tnInH/td8aUDO1qdlNjX7sAYmxoiVapA7UnIVnKU73wf/gbZ77dIScg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756303995; c=relaxed/simple;
	bh=DbwcQqcSgOgf9ZSwsPbdu37ylfuV2VigX8RYWvus3Uo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=SQ/cbDw4lOhaA69ixlWjeCid8EdtA5y/zJr/3ePulMsZqbuhFe2EbxqIsufqNwK2yxL8dK5NR+Dwj1h6lIeV6BnOfUB+mPl3H2AuL/qb0J3aDQ+ZJB2oDF5Q6dfJ6L8IfMLQgCbFeJa46LTmMju3CL1faq6q+psa36aqayz0K6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dWTiy0/i; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-24895637fe1so10658565ad.2
        for <linux-acpi@vger.kernel.org>; Wed, 27 Aug 2025 07:13:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756303993; x=1756908793; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=oT9Qx0pL0526DK73EqyoLYw0wsYmSjn2bOtkKWj9+LI=;
        b=dWTiy0/irckCaQzk1WuEdn1/rIGs7BUH5HtaVC4UoJeOx0TpCeqeE6kk77pxAcqrnj
         8LojKUuALAEpPlTJymXuhPzon4uOCNgzVgt0TkOgA6Z6gJ5ao7qNO5a0VaRMShCbvqEb
         7Z62nl5DvJ20RiK5OTGZ86B3DOv8vFnsYY+sJzLivJ/iGpVMmBOsweBiRfyJ/72qPJCX
         PwBUcRJOon6Uj9jfopwF3gsWHxnnuYseo58d2oMPKXgA5TBeCfN+sZsEs6MYpfkwete7
         EjDMl/KFvG2qvR/qwNw21N6nT6u+87ofdLzjCfMKz7iNC8r3Su2x+Dx8A/RBkzH8CXtw
         fv/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756303993; x=1756908793;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oT9Qx0pL0526DK73EqyoLYw0wsYmSjn2bOtkKWj9+LI=;
        b=A1gaa25ivC+kaV2ZeGZFZNHTTACvSGx1xxGn9mpV6/MyaLARVHsByFo667kZZHxCXR
         qXmnuvHoWmzjSYS44tRPiECjyENCtznODdflj2mEcBHhSHInQblm5y6YxoOl81flREIv
         MXnr0B/SdZ+Aoa6O1fMo/biamllk/9JKnJIH5AM01393QIPamsTXjKgjzTo3gd6+2FAx
         g/Ljn3WDytpMQaU7waCQLFcUV50m4JMwWzHFb9ILeMLt/I29Otnj0U5ON/qAcjLHOKts
         dI0NpbuFFdobxBaf4RgsQfcPDV6ubDOAENOHRDNd9tim7N7j1yUqF7xae/CCN7kaqBoj
         NTEg==
X-Forwarded-Encrypted: i=1; AJvYcCUP9aAvkUZX2rsDymUIF/3809JaM5hZq/XhlJjfhy6lC7fuWGXJE22mn3C4Kg0JCYj95328R1xrfjGs@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/e9rO7NB+XHby9nsJNpG2DlGLPh15pAEoRdQoTrE6jqvt+1Rg
	MbPKHeY6jv2OgKVdacK1DuPV4ZO1B/xCRHTS1U6E0k+/O50W7iJoIjdxvCGibiUaPAPGnbvzKmL
	aVHtA1Q==
X-Google-Smtp-Source: AGHT+IGTSg2J3odWqRi5DzWDmdBYNRXtpWLMNIy0mlgNYPFM/YLwHCJkE7ruCavXPIcZq+6RDeJTdDhPxa4=
X-Received: from plan10.prod.google.com ([2002:a17:903:404a:b0:248:7792:b8da])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:1a8e:b0:246:620:a0b9
 with SMTP id d9443c01a7336-2462efcaaa3mr229124795ad.61.1756303993097; Wed, 27
 Aug 2025 07:13:13 -0700 (PDT)
Date: Wed, 27 Aug 2025 07:13:11 -0700
In-Reply-To: <20250827023202.10310-3-zhangzihuan@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250827023202.10310-1-zhangzihuan@kylinos.cn> <20250827023202.10310-3-zhangzihuan@kylinos.cn>
Message-ID: <aK8Sd30K64mbN1Nt@google.com>
Subject: Re: [PATCH v2 02/18] KVM: x86: Use __free(put_cpufreq_policy) for
 policy reference
From: Sean Christopherson <seanjc@google.com>
To: Zihuan Zhang <zhangzihuan@kylinos.cn>
Cc: "Rafael J . wysocki" <rafael@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Paolo Bonzini <pbonzini@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
	Markus Mayer <mmayer@broadcom.com>, Florian Fainelli <florian.fainelli@broadcom.com>, 
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, 
	Krzysztof Kozlowski <krzk@kernel.org>, Alim Akhtar <alim.akhtar@samsung.com>, 
	Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, 
	MyungJoo Ham <myungjoo.ham@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, 
	Chanwoo Choi <cw00.choi@samsung.com>, Jani Nikula <jani.nikula@linux.intel.com>, 
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>, 
	Tvrtko Ursulin <tursulin@ursulin.net>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, Daniel Lezcano <daniel.lezcano@kernel.org>, 
	Sascha Hauer <s.hauer@pengutronix.de>, Shawn Guo <shawnguo@kernel.org>, 
	Eduardo Valentin <edubezval@gmail.com>, Keerthy <j-keerthy@ti.com>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	zhenglifeng <zhenglifeng1@huawei.com>, "H . Peter Anvin" <hpa@zytor.com>, Zhang Rui <rui.zhang@intel.com>, 
	Len Brown <lenb@kernel.org>, Nicholas Piggin <npiggin@gmail.com>, 
	Christophe Leroy <christophe.leroy@csgroup.eu>, Lukasz Luba <lukasz.luba@arm.com>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, Beata Michalska <beata.michalska@arm.com>, 
	Fabio Estevam <festevam@gmail.com>, Pavel Machek <pavel@kernel.org>, Sumit Gupta <sumitg@nvidia.com>, 
	Prasanna Kumar T S M <ptsm@linux.microsoft.com>, Sudeep Holla <sudeep.holla@arm.com>, 
	Yicong Yang <yangyicong@hisilicon.com>, linux-pm@vger.kernel.org, x86@kernel.org, 
	kvm@vger.kernel.org, linux-acpi@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, linux-samsung-soc@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-tegra@vger.kernel.org, 
	intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
	imx@lists.linux.dev, linux-omap@vger.kernel.org, 
	linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Wed, Aug 27, 2025, Zihuan Zhang wrote:
> Replace the manual cpufreq_cpu_put() with __free(put_cpufreq_policy)
> annotation for policy references. This reduces the risk of reference
> counting mistakes and aligns the code with the latest kernel style.
> 
> No functional change intended.
> 
> Signed-off-by: Zihuan Zhang <zhangzihuan@kylinos.cn>
> ---
>  arch/x86/kvm/x86.c | 10 ++++------
>  1 file changed, 4 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index a1c49bc681c4..2a825f4ec701 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -9492,16 +9492,14 @@ static void kvm_timer_init(void)
>  		max_tsc_khz = tsc_khz;
>  
>  		if (IS_ENABLED(CONFIG_CPU_FREQ)) {
> -			struct cpufreq_policy *policy;
> +			struct cpufreq_policy *policy __free(put_cpufreq_policy);
>  			int cpu;
>  
>  			cpu = get_cpu();
>  			policy = cpufreq_cpu_get(cpu);
> -			if (policy) {
> -				if (policy->cpuinfo.max_freq)
> -					max_tsc_khz = policy->cpuinfo.max_freq;
> -				cpufreq_cpu_put(policy);
> -			}
> +			if (policy && policy->cpuinfo.max_freq)
> +				max_tsc_khz = policy->cpuinfo.max_freq;
> +
>  			put_cpu();

Hmm, this is technically buggy.  __free() won't invoke put_cpufreq_policy() until
policy goes out of scope, and so using __free() means the code is effectively:

		if (IS_ENABLED(CONFIG_CPU_FREQ)) {
			struct cpufreq_policy *policy;
			int cpu;

			cpu = get_cpu();
			policy = cpufreq_cpu_get(cpu);
			if (policy && policy->cpuinfo.max_freq)
				max_tsc_khz = policy->cpuinfo.max_freq;
			put_cpu();

			if (policy)
				cpufreq_cpu_put(policy);
		}

That's "fine" because the policy isn't truly referenced after preemption is
disabled, the lifecycle of the policy doesn't rely on preemption being disabled,
and KVM doesn't actually care which CPU is used to get the max frequency, i.e.
this would technically be "fine" too:

		if (IS_ENABLED(CONFIG_CPU_FREQ)) {
			struct cpufreq_policy *policy;
			int cpu;

			cpu = get_cpu();
			policy = cpufreq_cpu_get(cpu);
			put_cpu();

			if (policy && policy->cpuinfo.max_freq)
				max_tsc_khz = policy->cpuinfo.max_freq;

			if (policy)
				cpufreq_cpu_put(policy);
		}

But given that the code we have today is perfectly readable, I don't see any
reason to switch to __free() given that's it's technically flawed.  So I'm very
strongly inclined to skip this patch and keep things as-is.

