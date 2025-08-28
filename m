Return-Path: <linux-acpi+bounces-16160-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B7FEB3A785
	for <lists+linux-acpi@lfdr.de>; Thu, 28 Aug 2025 19:16:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1746D1C86FBE
	for <lists+linux-acpi@lfdr.de>; Thu, 28 Aug 2025 17:16:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC74833EAF4;
	Thu, 28 Aug 2025 17:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EJzdxybn"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2B1B340D80
	for <linux-acpi@vger.kernel.org>; Thu, 28 Aug 2025 17:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756401321; cv=none; b=IobPqaZqHgtcAm0a02kMkIV2sWbHtxesTiSddvPm/njxwDpOxQKMMsqo3tnNqAXlVMAgOdFwxt1h3gfjZP0DcnZlUA63B9GFQ/EmNDGAxt9V5CcKCDQWirp8rSUQ7q/HT+aqBw6s4RtPkqBOFXOqYcQl31WaKz0KgF2tQDQRG2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756401321; c=relaxed/simple;
	bh=tjLq4yotJVvrKtVjK5XLYb7jE1fQQx1FF/sxrbky9es=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=BP6BiVXVlINbZdUjizqIR2C2mk/pirZJYbQpewDDr8WtLvSOoEmVF2qf0MG8BFPqjM0nqDhvHXXZplCK+Hm6X7Hyjup9xY/8IbLOW8AoRQx2CUQraxnSdTM+jZs363hyFQeHF+ciFjj23RTKW/f7wxRHp4A9AzhCdjMB0uwi0xU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EJzdxybn; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-3235e45b815so1393684a91.0
        for <linux-acpi@vger.kernel.org>; Thu, 28 Aug 2025 10:15:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756401319; x=1757006119; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=g/D1R1ws5ojuN4WG3pCUGyU24UMqyGj6lojr+YSYQ0c=;
        b=EJzdxybnyxlQrk6qJR558wtNekNbgws953L2pneIZYbmyp9tAmsnaz2aSuhIUBM5zr
         yym6Q3hOD+h86ma+8fB5UYxWC0FsSh8WsgByN6NGuhj5XPnYnWvTGq97mGOESOdqxB8M
         UO5/YFoyUcXdWdRme2wq/ulZFp8KXOMX/N5wcNQCirgFPfS9pE37lzw+nKFk5IrmnDbO
         G5sw2Dwq2cicHF4lperkYSyAoX2g6OycdnZ1FjYe/p8IEgXy13BJvrhiJGJwM3VA8ugT
         uPqiFjyVbr8N6oCUmphfD2rJa6OFoETW3Ncm5ZacDEJ+l20U+VrrmUTHcEPjkrroNkNZ
         4tIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756401319; x=1757006119;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=g/D1R1ws5ojuN4WG3pCUGyU24UMqyGj6lojr+YSYQ0c=;
        b=hgJNUcg3w72L3iVhWeuPlGr0U+ZqkJknVa8OqG6ND2lLAsueVbOvspa/NyVGMRuLxr
         Ze24LNVwo0Dv5G13/SOa7nSlw/ZU9AL01unRcSBQ4VnxrXxpL+9NAORTEWuPFjRnUu/i
         W+XizTsTl3/JsF3KfNM3Kz5cnn3j8lKv9l74xfgwQVDWcN7onj/C8KZsfBRyGsxFlaob
         lFH8j4iRDyFognOgkAPgPF2R/ICq2p0xgIyHOeOBnFEE96S1bKxnEDJMfOrc2+0eTElp
         h5HL4uTXaGoo+eNnO033ffCB7I2fSJVGyTgD/+RHsvI2yjxzKPqMdygJVW9U91kTu5qd
         Hj+A==
X-Forwarded-Encrypted: i=1; AJvYcCVnAXHnrhajW0QY4KRvskharMro69X4zse2m3m7OPaSytdXQuanY5sAKU4ppa2GkmK5aOYjEBOXm4Tj@vger.kernel.org
X-Gm-Message-State: AOJu0YwlbyYqAynHjd+ZkWHaCeL45byzUfTTiiGL6EZgcmiFwLD34NpI
	VU/PH+deJFUrRSiQc5h4XbxZHt3XRM0g3OuiQuYOGb0gzwuxRqBV19yFDXsNvmSC8pagmhhGKe8
	DUPbf4w==
X-Google-Smtp-Source: AGHT+IEgfCMAj/kPGbx0Dj2C82B+XByTzBEnlSaJgGQHGzaozLp7T19v0PG28aEIfyLg5E6WkydfWYNcBOM=
X-Received: from pjhk31.prod.google.com ([2002:a17:90a:4ca2:b0:327:9b90:7a79])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:1dc3:b0:327:cec7:b8c6
 with SMTP id 98e67ed59e1d1-327cec7cb53mr1738031a91.32.1756401318775; Thu, 28
 Aug 2025 10:15:18 -0700 (PDT)
Date: Thu, 28 Aug 2025 10:15:17 -0700
In-Reply-To: <874d821e-8ea3-40ac-921b-c19bb380a456@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250827023202.10310-1-zhangzihuan@kylinos.cn>
 <20250827023202.10310-3-zhangzihuan@kylinos.cn> <aK8Sd30K64mbN1Nt@google.com> <874d821e-8ea3-40ac-921b-c19bb380a456@kylinos.cn>
Message-ID: <aLCOpfNkcQN9P-Wa@google.com>
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 28, 2025, Zihuan Zhang wrote:
> > Hmm, this is technically buggy.  __free() won't invoke put_cpufreq_poli=
cy() until
> > policy goes out of scope, and so using __free() means the code is effec=
tively:
> >=20
> > 		if (IS_ENABLED(CONFIG_CPU_FREQ)) {
> > 			struct cpufreq_policy *policy;
> > 			int cpu;
> >=20
> > 			cpu =3D get_cpu();
> > 			policy =3D cpufreq_cpu_get(cpu);
> > 			if (policy && policy->cpuinfo.max_freq)
> > 				max_tsc_khz =3D policy->cpuinfo.max_freq;
> > 			put_cpu();
> >=20
> > 			if (policy)
> > 				cpufreq_cpu_put(policy);
> > 		}

...

> Yes, this will indeed change the execution order.
> Can you accept that?=20

No, because it's buggy.

> Personally, I don=E2=80=99t think it=E2=80=99s ideal either.
>=20
> 		if (IS_ENABLED(CONFIG_CPU_FREQ)) {
>  			int cpu;
> 			cpu =3D get_cpu();
> 			{
> 				struct cpufreq_policy *policy __free(put_cpufreq_policy) =3D cpufreq_=
cpu_get(cpu);
> 				if (policy && policy->cpuinfo.max_freq)
> 					max_tsc_khz =3D policy->cpuinfo.max_freq;
> 			}
> 			put_cpu();
>=20
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 }
>=20
> Other places may also have the same issue,
>=20
> maybe we should consider introducing a macro to handle this properly,
> so that initialization and cleanup are well defined without changing
> the existing order unexpected.
>=20
> like this:
>=20
> #define WITH_CPUFREQ_POLICY(cpu) {\
>=20
> for(struct cpufreq_policy *policy __free(put_cpufreq_policy) =3D  \
> 			cpufreq_cpu_get(cpu);			\
> 			policy;)
>=20
> Then Use it:
>=20
> 		if (IS_ENABLED(CONFIG_CPU_FREQ)) {
>  			int cpu;
> 			cpu =3D get_cpu();
> 			WITH_CPUFREQ_POLICY(cpu){
> 				if (policy->cpuinfo.max_freq)
> 					max_tsc_khz =3D policy->cpuinfo.max_freq;
> 			}
> 			put_cpu();

This all feels very forced, in the sense that we have a shiny new tool and =
are
trying to use it everywhere without thinking critically about whether or no=
t
doing so is actually an improvement.

At a glance, this is literally the only instance in the entire kernel where=
 the
CPU to use is grabbed immediately before the policy.
=20
  $ git grep -B 20 cpufreq_cpu_get | grep -e get_cpu -e smp_processor_id
  arch/x86/kvm/x86.c-			cpu =3D get_cpu();
  drivers/cpufreq/cppc_cpufreq.c-static int cppc_get_cpu_power(struct devic=
e *cpu_dev,
  drivers/cpufreq/cppc_cpufreq.c-static int cppc_get_cpu_cost(struct device=
 *cpu_dev, unsigned long KHz,
  drivers/cpufreq/mediatek-cpufreq-hw.c-mtk_cpufreq_get_cpu_power(struct de=
vice *cpu_dev, unsigned long *uW,

Probably because KVM's usage is rather bizarre and honestly kind of dumb.  =
But
KVM has had this behavior for 15+ years, so as weird as it is, I'm not incl=
ined
to change it without a really, really strong reason to do so, e.g. to itera=
te
over all CPUs or something.

So given that this is the only intance of the problem patter, I think it ma=
kes
sense to leave KVM as-is, and not spend a bunch of time trying to figure ou=
t how
to make KVM's usage play nice with __free().

