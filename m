Return-Path: <linux-acpi+bounces-20041-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 48F38D00D23
	for <lists+linux-acpi@lfdr.de>; Thu, 08 Jan 2026 04:14:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DAAC1301E142
	for <lists+linux-acpi@lfdr.de>; Thu,  8 Jan 2026 03:11:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B9DE2C08BC;
	Thu,  8 Jan 2026 03:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ANgSuIWn"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81CE129DB8F
	for <linux-acpi@vger.kernel.org>; Thu,  8 Jan 2026 03:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767841861; cv=none; b=oIC0HV2dL8yNLU3CxAgeTlwXXVSaPFl0ZHN91vvqC8BoZtuYv2KFmyPaIxQvhjUGhaZXhxjGlZPISXl9GifyoEPVbyUAhsZGDSoiC4QTgUXgXLWwMQTSuzDvC9wMxTuPJz1kXdL23jKrX1gJuHfHYAyTKky95wmYHK7xOtPJNdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767841861; c=relaxed/simple;
	bh=SdqVF3LD7jpBjbdm83nwVaJWKtKSkKhzurj2RKWv7nw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZbKMmAQeHvCJaf4czInobnzxss08yluffzxOH51lGxmtGbss2pNbPur8ZXdPqo//A0cCIDfqwDIw9MMe4ocRuRwHF53J+UeAxIFesTP+oKbWaPPQ9xtcaisV5CN9i9PD7ZxvGxBiEzRIm/TxxA1aZ/wRrIVS7FUKrOSyOXJKwY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ANgSuIWn; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-29f102b013fso28538535ad.2
        for <linux-acpi@vger.kernel.org>; Wed, 07 Jan 2026 19:10:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1767841859; x=1768446659; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=W4wKAGkCZEe39pTChgi73m7wO7Ejxj689GXAAP95ccw=;
        b=ANgSuIWnHIYArQxIOtZmcjWWa8g9vwYK39XEMEmfwF9YgycnYH1Y+IGa9yG91lxruL
         x5L3v3aOQnqo+hgPy/ee/P30iKnsNduoUID4UIVxZJnhmwSpHRyxKnFPtSotQRoJ45Dh
         XY2zeKJsD8EQrvkA+2h9acNhvXSXifTuDpYQ7RBkqjBlRROYhdgvKZx8ZY6cfKi3Tazz
         Kr+mG9sxl2p2IoybK7lOOF49Vfa5WURZw/65pixyyY/Tf51FGQU36BSm5bcqEHN4L9vI
         CnsPsJa3USRiyHsy1vv6D2KZVJrmH2GZ15uBO11W/tawN883T5xZsHra85JJiQUe2pk/
         hiUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767841859; x=1768446659;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W4wKAGkCZEe39pTChgi73m7wO7Ejxj689GXAAP95ccw=;
        b=uwnQuYk8TSDZ6F3Cg3Bc5nikASN2HsA4ZbGgE1PjXRzDwmYPN08YrmxzRbL/JFjmlK
         YDIH4wFAxRWHH9RJw5PjZk+vDdyHjdaUNp1yoPURHJcvA1fC7vfy28K63NBxHsflAr4x
         8ouBb0ZjhVlD9yj7G10a91zfLIIXqPVFnNky4ebzitZbKa8eXtIL/0DdLpXFkgvDDQSN
         cHW5dmKBZzjoUV7MRrjfSZMj1nqtGtxcY0oHeZNucUc6ANj6poZsVPBkk/s/D9GH83Bv
         CU4s8yi7/i6dTfWYoVs+QG9rsnd4xzM4wsGXv1lDr8UdFHxtHZWhMZdII5+WdqXEYHH4
         /4pg==
X-Forwarded-Encrypted: i=1; AJvYcCUynt4VaLNEResJH5GdMQQJWCVheDLDSeqUrMz3BWQ/V9QWgEH8ylpFFORcihR3Kum7t5TNyAmgWPmR@vger.kernel.org
X-Gm-Message-State: AOJu0Yxs7EAg6ZMEQckLDRmO//5gHiSafU/xFn01qVi/8je2qx0o8bp+
	YRQ5qEvTEfp2kHAF4LuH/g16aqoWjxrO1BeBbOo0PrEWkqEPcPY2giAJzNignmMLLUw=
X-Gm-Gg: AY/fxX7JEt6mAJTLshlThRl27F0z3GJ32AHsFtmUhRApS3isVJKit26uyrUbB2S1vkL
	JsJtjxnHtNFPjp3zSL6cvPEz2sPqpbagci94JI7xz57P01S5fL9/GlCTCvsQiBd0uQWKHZwO3eo
	ViDr8/HXezmwwdKhP5EkUow11Gyfj6VASwjRrcIFnQTXieaoSASQvTykVk8aFzSdHdJdwYRaD9H
	Y+bTJXiPXaWjoG88rDbgvOGG3CIbnzqNSNKWbSxVKhyvsrmxkWotDgTLXEYqARzP4CgIOw5g/so
	vzwdtS8aTQpuyTL9kg0usU+IF5BIZanRTjynqKp+xuuL4Hl3GQXboBg5BFMU7yL+C5ZRPqav5qg
	hJ5JK4eD1D1zEGNCODo1qkpce814M0UpW9hihjuaYSXuw6LKE3om33guf92mbUIzhN7yeZbDhq7
	mmHaUPc0lYtog=
X-Google-Smtp-Source: AGHT+IF2GALJIvh/2Rj4DhZwH99ewpTJcYda51Qr0IK1kRHh6QlqlfYPgE0EbGL75vFlvU/nTxL8+A==
X-Received: by 2002:a17:903:32d1:b0:298:3892:3279 with SMTP id d9443c01a7336-2a3ee4363abmr40555275ad.17.1767841858523;
        Wed, 07 Jan 2026 19:10:58 -0800 (PST)
Received: from localhost ([122.172.80.63])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a3f3115682sm26328735ad.55.2026.01.07.19.10.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jan 2026 19:10:57 -0800 (PST)
Date: Thu, 8 Jan 2026 08:40:55 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Jie Zhan <zhanjie9@hisilicon.com>
Cc: rafael@kernel.org, ionela.voinescu@arm.com, beata.michalska@arm.com, 
	pierre.gondois@arm.com, zhenglifeng1@huawei.com, linux-pm@vger.kernel.org, 
	linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linuxarm@huawei.com, 
	jonathan.cameron@huawei.com, prime.zeng@hisilicon.com, yubowen8@huawei.com, 
	lihuisong@huawei.com, zhangpengjie2@huawei.com, wangzhi12@huawei.com
Subject: Re: [PATCH v5 0/3] cpufreq: CPPC: Update FIE arch_freq_scale in
 ticks for non-PCC regs
Message-ID: <6pvkd3y43bscjkw7seyszxazu3fnowogfckp27o6yuupriiuqg@vsol4t42o3uy>
References: <20251223072119.3372582-1-zhanjie9@hisilicon.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251223072119.3372582-1-zhanjie9@hisilicon.com>

On 23-12-25, 15:21, Jie Zhan wrote:
> Currently, the CPPC Frequency Invariance Engine (FIE) is invoked from the
> scheduler tick but defers the update of arch_freq_scale to a separate
> thread because cppc_get_perf_ctrs() would sleep if the CPC regs are in PCC.
> 
> However, this deferred update mechanism is unnecessary and introduces extra
> overhead for non-PCC register spaces (e.g. System Memory or FFH), where
> accessing the regs won't sleep and can be safely performed from the tick
> context.
> 
> Furthermore, with the CPPC FIE registered, it throws repeated warnings of
> "cppc_scale_freq_workfn: failed to read perf counters" on our platform with
> the CPC regs in System Memory and a power-down idle state enabled.  That's
> because the remote CPU can be in a power-down idle state, and reading its
> perf counters returns 0.  Moving the FIE handling back to the scheduler
> tick process makes the CPU handle its own perf counters, so it won't be
> idle and the issue would be inherently solved.
> 
> To address the above issues, update arch_freq_scale directly in ticks for
> non-PCC regs and keep the deferred update mechanism for PCC regs.
> 
> We have tested this on Kunpeng SoCs with the CPC regs both in System Memory
> and FFH.  More tests on other platforms are welcome (typically with the
> regs in PCC).
> 
> Changelog:
> v5:
> - Minor cleanup of cppc_perf_ctrs_in_pcc_cpu() (Thanks to Rafael).
> - Add a function description for cppc_perf_ctrs_in_pcc_cpu().
> - Pick up tags from Lifeng and Pierre, Thanks!

Applied. Thanks.

-- 
viresh

