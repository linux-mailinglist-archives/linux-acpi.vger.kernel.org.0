Return-Path: <linux-acpi+bounces-16171-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 263D6B3B358
	for <lists+linux-acpi@lfdr.de>; Fri, 29 Aug 2025 08:26:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 89F86161BA9
	for <lists+linux-acpi@lfdr.de>; Fri, 29 Aug 2025 06:26:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76CD123C507;
	Fri, 29 Aug 2025 06:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tRxUklAE"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF3E523BCF0
	for <linux-acpi@vger.kernel.org>; Fri, 29 Aug 2025 06:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756448789; cv=none; b=pfh2fWQHZ0zJahHZt1b8ZYX8iHb0K4PPyd4TKvVM+yg5suWLK4/FjEKV7XcSqXsGB3GF4iBhhOeQ2wiWC3Kfz9L2m6+XlkD6uzYzXaU1w+5AtfWJ5T2SCWWcCw3WWh0xUnhgN5wcGM4+IYzpYkgHn0orPblriTjbjVejttXBoy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756448789; c=relaxed/simple;
	bh=fAwq717gxOG/gzksvHcfVeqsyH5k6BHHvFVv/kB6CwU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kzQYy8dSwQsk+R7T1wPAm+5+GDN7KYjaxFPw8BKkV/dTFgDzzTyXGXfr8ZxGhPjsH/5g0x9dKRamTY7qyE8h2zH9YZyuq2Ujis2XwA3lmdNKGU1ESMaw0w2WX1IDI4kzasVTy+oLONgQVn60cfR1caDf1dKFv75BzY8cErfrq4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=tRxUklAE; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-32326e2f0b3so1420907a91.2
        for <linux-acpi@vger.kernel.org>; Thu, 28 Aug 2025 23:26:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756448787; x=1757053587; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=FcWNphyv+aV6VigruYXsycpBhyL4rRdrU3NDODM9P5A=;
        b=tRxUklAEuzasI1s6Lx3jlhz8OcQE+0enb6h0YDY5HN2tcCHLotxk3ezgMcqrkt3Knk
         awzj2x6qCHsapRtXpBizhUz/o+aTOuw+Lhri5MMTlXuwQeMbaIfE4FQ/ErAIk1xDMN99
         BKAvR4KmbqeteBgOpx8B5F6mC4+9BN6gVvuvTyjeumqUOlLnaB9tTwTNEsYnCASWeh81
         rqcMxpcOjttiJDuNQ58rSn1WG9GF49dFTULEtamhoAp9q1G4xOTYsVdHB7FW5Jswf5bM
         6m7I7xNOtFa1txrICmEztSRnWOwZCC2/zHc34Bk0svK6asUIm9/dET3VBtZ9uDN96ZJ5
         bWwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756448787; x=1757053587;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FcWNphyv+aV6VigruYXsycpBhyL4rRdrU3NDODM9P5A=;
        b=mH1c2f4rDnflovX1WEqVRDMZKQuexLXsMmn4mfxLPuvp6pu4sXEvurO06oNpgvw3VN
         SZI0SIHBDibPICjBiSCvP6Cq3C2IpmMqy+ZXX4LP+J34GaiZbcbPf6rWUAqEhpB3pk44
         3Jq8j1n4T9RgFQsagaNCwFcdGuPNF5JhLO/9S2C+9eVZ+2Kl6dc/p9w/urfu/WfetQS8
         atbj8HC/nP0OXGeKe40j7UNGBfrGqBKvA1T7nNp1uOxU/JW/UaLAUIBJ6QkuDPdM+K6K
         LIa90PftF6b6K293fZXp+1WRqk2dtv+ypZiAC4zIehDlzXXnwXikjrOaYvE19jwJzmuo
         6JMw==
X-Forwarded-Encrypted: i=1; AJvYcCUk41qytyy+9FrWB5ZW6Wz6Lj83brmMAGT2wcykBZAPN4SvfTt9C5TA7IBgAfSUqU1Q7fcmfvXZlTsV@vger.kernel.org
X-Gm-Message-State: AOJu0YzsgYqJnA9oOeTU6IKnrxIz0Nfsv/fsP0Rgew+ul2PCs5eZ9yXb
	/mvp2gz4JXDGEI1M9xQw9/TBMzJolPiew4fH+nGDU1UuKEZAf8mbfyMi99E7AlC35gc=
X-Gm-Gg: ASbGncsgha/vEAxmJK6YqpMB1/nhbDgqiAFTXwrQgKiXgDEykSRE9zI5Ql0Af7AtxtT
	6FadMLeaNS4nEdPPS6Yrl3S+PRVSAXKjBzn0/kRGCwV/L6/ogvOXbM+RASp8mKKlUoZtHqnM6+H
	suwM+qUtY2PgxbuzviwkBZ+4ShOLB5q+FjGglo7bLbdPCYNR0qPKYfnrSkqWG3A6YTOyToScr1G
	XGwNrN0AQSXNbXCN2tEyhkPvgMky5VCa3ToCQ3olLhDJIrWvDidxZDisq+1O34XvaPz0WoNq17P
	3PqJwpAduQgJklbFkoN7CF4uYY0ujRUDva2xd3KS5Gxgq0ANGisrVuwgOD8aN6GRj5Z/HbPPC/8
	faf0kQdvqoJtnG6GZs41uwlaY
X-Google-Smtp-Source: AGHT+IFHYb22k9tJefksk8Ol8WzLcbkUpFNWBPL7w5JQ2Y92t38N6cXrTs0utCYM4huh3xQWCdkxbA==
X-Received: by 2002:a17:90b:57ce:b0:31f:210e:e34a with SMTP id 98e67ed59e1d1-32515eacfddmr32147827a91.8.1756448787009;
        Thu, 28 Aug 2025 23:26:27 -0700 (PDT)
Received: from localhost ([122.172.87.165])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3276fcd4bd6sm6984417a91.15.2025.08.28.23.26.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Aug 2025 23:26:26 -0700 (PDT)
Date: Fri, 29 Aug 2025 11:56:24 +0530
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
Message-ID: <20250829062624.jalqqsigs7hanf7i@vireshk-i7>
References: <20250827023202.10310-1-zhangzihuan@kylinos.cn>
 <20250827023202.10310-5-zhangzihuan@kylinos.cn>
 <20250829055944.ragfnh62q2cuew3e@vireshk-i7>
 <4bd55a08-62bb-46c4-bfb6-a3375ce37e79@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4bd55a08-62bb-46c4-bfb6-a3375ce37e79@kylinos.cn>

On 29-08-25, 14:16, Zihuan Zhang wrote:
> Thanks for applying the patch!
> 
> I’ve been thinking further — instead of using __free directly, maybe we
> could introduce a small macro wrapper around it to make the release scope
> more controllable and consistent.
> 
> Link:
> https://lore.kernel.org/all/6174bcc8-30f5-479b-bac6-f42eb1232b4d@kylinos.cn/
> 
> Do you think this would be a better approach, or should we just stick with
> the current use of __free?

Lets keep it simple for now and use __free directly. And keep this
similar with other parts of the kernel.

-- 
viresh

