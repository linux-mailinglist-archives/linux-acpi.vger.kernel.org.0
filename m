Return-Path: <linux-acpi+bounces-16423-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58A51B460FC
	for <lists+linux-acpi@lfdr.de>; Fri,  5 Sep 2025 19:50:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1370C3BBC19
	for <lists+linux-acpi@lfdr.de>; Fri,  5 Sep 2025 17:50:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00041309EFC;
	Fri,  5 Sep 2025 17:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="MeAap+sk"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFD4D23E342;
	Fri,  5 Sep 2025 17:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757094634; cv=none; b=fDiDMerTFXUrZKqzCgOmyZuVGOnLy65PFOMhrZcNUrYvcBYgJYJi74h7voTMOGqRQERcMW5aEFglN2bUbzyxD+k72/wtvuLF4k6Vag3v+tTAdIYWfN4gppr/e7yLqe6zqVq13QiKygCATgXMGFGKaPqkCBEXEqjS5y9YABaQIn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757094634; c=relaxed/simple;
	bh=fEvOC+Hb5Uih6l7ipb42YGCKy5ESrhPsjYdJkhOP85s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PqmmsWYgbF+n6GcRUOsOuOagNvKVmvXsKeE8RucJsQuC9YCFVYuVaKgaogy/DjsEmwgEiN0KE1k1xztgp/JjZJrPIcV5C3jbWAdP37fGX5Z/nhcwUA1xotVz1sKGYV1YzAtNCAw+D5mVwwrVZq0ejsHyFo3e3SKGGMiZNYGHTRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=MeAap+sk; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 34ABD40E016D;
	Fri,  5 Sep 2025 17:50:28 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 5uOUeExJDHzu; Fri,  5 Sep 2025 17:50:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1757094622; bh=nvYUl9QmXcZhGV7LDMivTR1R7SodOASqEywSNEZXCFc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MeAap+sk+VdwfyCrswiOc5REIH3s9U7SaP0ra9piDtNpViHKJrjiiXC+OYwbEnjcT
	 vwbogjD2xQul6ZxKUnv7+8p/uvByda2LQ9ycJvqg+iaTvEDQdy9sJBj06686iAO05u
	 LYk91Odqh2reQIDbVXE62GJ/SEHiShROwNqiWov8ZplEJ8dGU2H1o2LOqjuJUFPYnH
	 Hl+/PMD8BvMWnnq9L74fYprFl1mAEdcKlMLwU1XuOaLLcme2lQlb8wB1EKeF1Wkr4w
	 LPM1FpPt6mnOkHIE9/9ieU3LBDgDcugFeP301vE3tSOReDbOxcanvOnV9REpx/V79V
	 kfDbtKEyGS+YKgf0/TkIDFi8HgFuTi+wPxplFJsKSbpkO+19/x25dNs7Yx2ChXhYA9
	 nPABWcUYMaDxUwaTEk4fUX6JFbTPtsJX7TaU/qqXqIhLRLk9YuaagdbqQjdSVL1ZPz
	 bVURNzkLucbI0Ny6oLRtekjNLnYlGwfAjPpE9J1xw8qkQ6Ea7DOkkTa1/3ISF7wWw4
	 8G4tfgbnQEIkhkmQlAQseuKbvB3XWcCxvk0N/X8c1Ep28yuffQIMOl3KMycFMzcT1s
	 76pK91UNExnVDSeaQTE2egOD0fCWDWZkFiJ4UCsr4k78nblHLZu4xXeaf2cCLYd3/h
	 Ka+nU1Z9wTcsmovkAE+m7C4c=
Received: from zn.tnic (p5de8ed27.dip0.t-ipconnect.de [93.232.237.39])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with UTF8SMTPSA id EFA6B40E00DE;
	Fri,  5 Sep 2025 17:49:34 +0000 (UTC)
Date: Fri, 5 Sep 2025 19:49:28 +0200
From: Borislav Petkov <bp@alien8.de>
To: Zihuan Zhang <zhangzihuan@kylinos.cn>
Cc: "Rafael J . wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	MyungJoo Ham <myungjoo.ham@samsung.com>,
	Kyungmin Park <kyungmin.park@samsung.com>,
	Chanwoo Choi <cw00.choi@samsung.com>,
	Jani Nikula <jani.nikula@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Tvrtko Ursulin <tursulin@ursulin.net>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Daniel Lezcano <daniel.lezcano@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Shawn Guo <shawnguo@kernel.org>,
	Eduardo Valentin <edubezval@gmail.com>, Keerthy <j-keerthy@ti.com>,
	Ben Horgan <ben.horgan@arm.com>,
	zhenglifeng <zhenglifeng1@huawei.com>,
	Zhang Rui <rui.zhang@intel.com>, Len Brown <lenb@kernel.org>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Beata Michalska <beata.michalska@arm.com>,
	Fabio Estevam <festevam@gmail.com>, Pavel Machek <pavel@kernel.org>,
	Sumit Gupta <sumitg@nvidia.com>,
	Prasanna Kumar T S M <ptsm@linux.microsoft.com>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Yicong Yang <yangyicong@hisilicon.com>, linux-pm@vger.kernel.org,
	linux-acpi@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org,
	intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
	imx@lists.linux.dev, linux-omap@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 0/6] cpufreq: use __free() for all cpufreq_cpu_get()
 references
Message-ID: <20250905174928.GFaLsiqKV36JDowX94@fat_crate.local>
References: <20250905132413.1376220-1-zhangzihuan@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250905132413.1376220-1-zhangzihuan@kylinos.cn>

On Fri, Sep 05, 2025 at 09:24:07PM +0800, Zihuan Zhang wrote:
> This patchset converts all remaining cpufreq users to rely on the
> __free(put_cpufreq_policy) annotation for policy references, instead of
> calling cpufreq_cpu_put() manually.

Sep 01 Zihuan Zhang ( :8.6K|) [PATCH v3 00/12] cpufreq: use __free() for all cpufreq_cpu_get() references
Sep 03 Zihuan Zhang ( :  65|) [PATCH v4 00/10] cpufreq: use __free() for all cpufreq_cpu_get() references
Sep 05 Zihuan Zhang ( :8.3K|) [PATCH v5 0/6] cpufreq: use __free() for all cpufreq_cpu_get() references

Please stop the spamming. While waiting, go read how this kernel process thing
works:

From: Documentation/process/submitting-patches.rst

Don't get discouraged - or impatient
------------------------------------

After you have submitted your change, be patient and wait.  Reviewers are
busy people and may not get to your patch right away.

Once upon a time, patches used to disappear into the void without comment,
but the development process works more smoothly than that now.  You should
receive comments within a week or so; if that does not happen, make sure
that you have sent your patches to the right place.  Wait for a minimum of
one week before resubmitting or pinging reviewers - possibly longer during
busy times like merge windows.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

