Return-Path: <linux-acpi+bounces-16166-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 18290B3B2D0
	for <lists+linux-acpi@lfdr.de>; Fri, 29 Aug 2025 08:00:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8F0F07AD8F6
	for <lists+linux-acpi@lfdr.de>; Fri, 29 Aug 2025 05:58:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 308D322759C;
	Fri, 29 Aug 2025 05:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="p514Sl+B"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE90A21D3E8
	for <linux-acpi@vger.kernel.org>; Fri, 29 Aug 2025 05:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756447192; cv=none; b=FEq8WyMtR3z/X+lZ3340w+0Opa5dEvUZCOXOkr/pIpEwx/HjqX7/bR47cIwcdlrWju9WHC60dCFKQxb2bergPHA2gcljF8Y8R48HSczcY7T/aPEi3HosE+WNX2rpa5DhmiuLpfi83JRRIzPCzJB/9nH3V5XPCDlQT9VaTStiY7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756447192; c=relaxed/simple;
	bh=3Us6gLaZK2VccDGA6IMnqvs0nFzgbS6I49Q/8l1+6ks=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bQ/EdmUhfx0okhJX8kOM5dnnTyKfPAK6e/3DvE9hXFs7qXKJgHxwhAyeRyKkOm8TPXAfmr4eHn5cDlQtnR3Rw6e/mzay2+O1K+Jm3/vP3MNd/gKDzU588pM50T5NeNQxKpLtbNxDYkkpyLDWSQQtTxQFhGO9SWm2bevEPan8vJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=p514Sl+B; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-7704f3c4708so2117091b3a.1
        for <linux-acpi@vger.kernel.org>; Thu, 28 Aug 2025 22:59:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756447188; x=1757051988; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Csp0y2UiuYBIoSGq3QglK9zewj1/hbg1F372AFvl94U=;
        b=p514Sl+BuFb2jJ5R5DjvdPuZbJD/3N094aXwj3h0r/jhqjJ8E7yP+k817tMndGWuRR
         FJyrpnjrOC1v44RKZW8+hYv/s/oQyyrlN51j6gPDRgosyonW7nobHk+dEVSc4NB36Yw4
         PuqLoIM2bQWrSvT363c+fY0yOV3vZSKbC+7dp3aQmV8szSfmyrtVMuT0C6uReUSabLLQ
         QNCTGNg39LLVhpXBLI27D+yN4JWIztFIMPiYxMxgFB1nTSvmERBka41rfpTaGJms0EBS
         6QVx0xOpRrajJT7Gzpak3rJcIdO5m+Vx4yWFoMbU026CqovfiV44HAzTUMYSrkn9uYWg
         J/Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756447188; x=1757051988;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Csp0y2UiuYBIoSGq3QglK9zewj1/hbg1F372AFvl94U=;
        b=lUu5fL8Il0QT35UIGnyCr+TAjbHJIn2AvbYdLG61hAlMhwFNEfUD9i7UqF1WcmbtO5
         VNIH1El3Z0Go1Wwab2quj7A1HWHB6h88aEQMTL9N1Ryw7TniEGiAmuGRpk+gQ01Yiy1+
         jA018yfvKJqSlay5uP2winRuUtD2VVv2zR/moLPs5NNI59gdlP5eAdndb1EI0EYh/Yao
         SnRPczFaabHeSFrIsbltqzDrIc/kqQt946IhP4GURV2qp5Z5OIkIyWxSIgzvqs8ekaUn
         qu+8C2wIuJuiBIXoDCS6hMbULVsraKgsCcoIN9leLfKnm8ju2OIpBrZnXzhr/OKcjaJt
         OVDg==
X-Forwarded-Encrypted: i=1; AJvYcCU2fShm96etrVAVvk7Xig+bcb4MhB+MA6Cx57yfz9JLGnX14oMSxvDlhoS4MgcxRV0XaGoFZxcvYxZX@vger.kernel.org
X-Gm-Message-State: AOJu0YzlN88MaW+3YF5DF4wgwagb7lIdsuUVi89SzpVDDNAP49dtdAW0
	ivn8PdR/7fu10kXW3OTR78p3eTc9ny01OQ6UpMnmSsPYp20f2cQ7zC8E63jSBKJ3XG0=
X-Gm-Gg: ASbGncvpMYjnQ0wxnPvSnxhOmVgfJ34oqk8jIuJtnG1jqHIIdmQuUmdKCZZMew3g8yF
	udrYjD+csplldju4DfAnnY5LxZSTGAm+CLv1KbZtuC71mG8xruXqda7YmqSt74F0p4EYR1JC4sc
	0R+j3ifySou2F8dHSXy64kpQnueREJGa8KII+KPMw5rSsZ6XgXKuusQHlPXj62xkFNFcpHSb/pg
	BbnrDFN66Y3EcXw1usvqNm1SP4TWQ8g6MXeQkL5jdkSAsAFSeQZcuSPYoKlO7lxyQMrAd7Q2SUu
	V+Mpb719bQLWEzSZOFrwB9bbdRprfb6PtLRrOrRSv7Cq4dalHPFs1SRK/U50mkO3i1HT9UVO4kJ
	FUGFSIhjsZDC2X8cm0QV9jcBkvDS3K43I4oA=
X-Google-Smtp-Source: AGHT+IFsar3WOaSA9RKNM7TPFf9gG0iXTxdUF2CW8raU1SyelgEQswrlDbapLb2rA7PUFkb3M17NCQ==
X-Received: by 2002:a05:6a00:10d5:b0:772:2850:783d with SMTP id d2e1a72fcca58-772285079c4mr3285667b3a.22.1756447188084;
        Thu, 28 Aug 2025 22:59:48 -0700 (PDT)
Received: from localhost ([122.172.87.165])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7722a2b14c1sm1263485b3a.31.2025.08.28.22.59.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Aug 2025 22:59:47 -0700 (PDT)
Date: Fri, 29 Aug 2025 11:29:44 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Zihuan Zhang <zhangzihuan@kylinos.cn>
Cc: "Rafael J . wysocki" <rafael@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Markus Mayer <mmayer@broadcom.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	MyungJoo Ham <myungjoo.ham@samsung.com>,
	Kyungmin Park <kyungmin.park@samsung.com>,
	Chanwoo Choi <cw00.choi@samsung.com>,
	Jani Nikula <jani.nikula@linux.intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Tvrtko Ursulin <tursulin@ursulin.net>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Daniel Lezcano <daniel.lezcano@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Shawn Guo <shawnguo@kernel.org>,
	Eduardo Valentin <edubezval@gmail.com>, Keerthy <j-keerthy@ti.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	zhenglifeng <zhenglifeng1@huawei.com>,
	"H . Peter Anvin" <hpa@zytor.com>, Zhang Rui <rui.zhang@intel.com>,
	Len Brown <lenb@kernel.org>, Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Beata Michalska <beata.michalska@arm.com>,
	Fabio Estevam <festevam@gmail.com>, Pavel Machek <pavel@kernel.org>,
	Sumit Gupta <sumitg@nvidia.com>,
	Prasanna Kumar T S M <ptsm@linux.microsoft.com>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Yicong Yang <yangyicong@hisilicon.com>, linux-pm@vger.kernel.org,
	x86@kernel.org, kvm@vger.kernel.org, linux-acpi@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, linux-samsung-soc@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-tegra@vger.kernel.org,
	intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
	imx@lists.linux.dev, linux-omap@vger.kernel.org,
	linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 04/18] cpufreq: brcmstb-avs-cpufreq: Use
 __free(put_cpufreq_policy) for policy reference
Message-ID: <20250829055944.ragfnh62q2cuew3e@vireshk-i7>
References: <20250827023202.10310-1-zhangzihuan@kylinos.cn>
 <20250827023202.10310-5-zhangzihuan@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250827023202.10310-5-zhangzihuan@kylinos.cn>

On 27-08-25, 10:31, Zihuan Zhang wrote:
> Replace the manual cpufreq_cpu_put() with __free(put_cpufreq_policy)
> annotation for policy references. This reduces the risk of reference
> counting mistakes and aligns the code with the latest kernel style.
> 
> No functional change intended.
> 
> Signed-off-by: Zihuan Zhang <zhangzihuan@kylinos.cn>
> ---
>  drivers/cpufreq/brcmstb-avs-cpufreq.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)

Applied. Thanks.

-- 
viresh

