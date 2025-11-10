Return-Path: <linux-acpi+bounces-18722-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B7B2DC4613F
	for <lists+linux-acpi@lfdr.de>; Mon, 10 Nov 2025 11:56:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 61EDC189359B
	for <lists+linux-acpi@lfdr.de>; Mon, 10 Nov 2025 10:56:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CAC3307AE9;
	Mon, 10 Nov 2025 10:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gKaBLUd8"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C251306D47
	for <linux-acpi@vger.kernel.org>; Mon, 10 Nov 2025 10:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762772181; cv=none; b=umXgahuVGpjYNBmbGpAzS+jecZ4rqFE51qkQ3cRawAHrlrrFthMXgTNwR+v972BjM9wsOlk8f/qRJY9uAAiNA/EltLpYAdUfkbxZBr2tJtjI2acPPauZLlILyePjPMGHFzL9M1wnBEIZJr48XSnvJQZ1YKcVcMuqLDbeGFrENzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762772181; c=relaxed/simple;
	bh=dEl+crxWx0Ue6Eap9IyJQOsh+WWdfuIJZKBgNUUOskU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bK4nsf/JCJ92yZ/jFM1AO29DqaH4Ku5BKGkCUegl5r5e/KJU0I45lbO5szCc4KpesprAT/MhYDQJtBzJYQyaxLqnZI7UBh1enCJk5z093RegeG6VIPeqoOo2qklkYUx9X8xvi8ex9ljSjz2JaeuI8oS3B/nvdepO/YXY5n468sw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=gKaBLUd8; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-7a435a3fc57so3001140b3a.1
        for <linux-acpi@vger.kernel.org>; Mon, 10 Nov 2025 02:56:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1762772178; x=1763376978; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HOTgQEUB8GcmpUQcmIkml8fFvXO2yWgEKzXQF7vCTcc=;
        b=gKaBLUd8yrvPVoLyJ80CXi/2i4l/MtEV6mMzBU+Z3JHKX6VOOOfpEhRPfPP8aXEGG2
         TUcf/VMxLyuXljSA+kw8vdEhmUvbjSYf6E7jMeKqHx+HRb9kL7LhIry6g0WMkUFe7x4+
         kRUdnLOR+EjcklQaG5iJ/fCBbmUbZLJy96sQZDrHS/cmCJPfPqJNlZzyt/ytOGIoMISw
         1Lir7UTb14vlK3asD6EnW+PeZmBiZiCNKY6gjsxcrEaX9B6kFcukVIMxH4TqeKLqjyuQ
         uEZNNfA9wkKrK0oKfqqA6g5mOeLXvfHGWgIxeSkkg/qkB+A6ExHOdwDy9v/KaL3/AnNo
         eoUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762772178; x=1763376978;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HOTgQEUB8GcmpUQcmIkml8fFvXO2yWgEKzXQF7vCTcc=;
        b=vlaqKcvBOHfPVlqjZOUSk4FL/Z7dNOf15Py88Inlq2pnCRzCGJ6NqIkT31GVz3XEOl
         2cemhshV43YF+m9Lz1+8+JIfdpcVrwN0ph5qWIQ7yr2kffF7TDwb8J8KN6D3Qkdu5/R7
         bgxqv2bYrVbi6Pkagd0WrRXWeCHQoXT6F2CG30FSNAYq6KZ+kov5ub/b0WXj3fy3pGLQ
         TZi0WjHwUU0bS3G/z2Yi+8/56riT/A09qEPyBpZZs9WT3z3R697pY4EsoBDehHLRshHz
         IiwmGgmVhS0LO+Tlbw9gwd0VwvGrgGvyuEDeIWfO7ZQ2du2rV6EjW8Yvwo1i7jBXqEJe
         g0jQ==
X-Forwarded-Encrypted: i=1; AJvYcCU5vrlSgCSWSYMlsE9IgpDsjUUWZJclT7EjenkYp4qRD8T56aUx76HL5IRn/CLV3KP4OiUzkouJDBDA@vger.kernel.org
X-Gm-Message-State: AOJu0YyVa+vVkJkbJJquKhlvAcDfbm8sAz9d3z0HUzdp8TIcWd/CrtTC
	bLPx2ue+h0QgCJ2XSqn915ZGX2ZhWKylPtdbQ2cpSK4c/PR9Sk/Q2phKsAAw8RL8z08=
X-Gm-Gg: ASbGncuQCBxxkt9UQDZvSaMr6cXFKtWW2zGRUjFaxnDJsZLmdVJ+RybZAiHGXAzrS4S
	Bm8Cm0ICP6651cY+3LLkRin18da67+3mHLPgsW6F0JKrUd8ZYspYcTDfmE1kr3ls7PQj8Aju5qg
	6kDt1OoIIIBMggyDWfiHckx3l6V/BJccHDddXAjdYxv9GfWhnLZEqHK3H8et7Ll9dhnV1+c3Emm
	j8QPxVpGHe4KNSY8CbJdqrf9wkkl0fSSHoJmZoOYA0lUdbgNqELd8AiOKCzou+bf9ClLK1jdQEt
	0cBW9lFqxfrfwQAlPrN+T6DZM2Wwj1wEpB0JOTarnb1aTuD3yumlYvpO0NHalclGIt9p+8a2hkP
	R/6GfvtE8c2gB2zPNWIjuauxylJ88sAJ6oKyHdErhuvYcUT4pwqQJJP4d5f291MGaGxgY64GPBi
	CJflbRoS5Bowg=
X-Google-Smtp-Source: AGHT+IELCZjjS9db2GOOi5gG1D3fReIWK6Fsulo/YaMjMnn+TlgjP5Y2DF6HQCR7hzQBYtF9UG4Urg==
X-Received: by 2002:a17:902:d551:b0:27e:ec72:f6d with SMTP id d9443c01a7336-297e53e7af3mr99902655ad.11.1762772178225;
        Mon, 10 Nov 2025 02:56:18 -0800 (PST)
Received: from localhost ([122.172.86.94])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-297fe688c96sm49938925ad.58.2025.11.10.02.56.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Nov 2025 02:56:17 -0800 (PST)
Date: Mon, 10 Nov 2025 16:26:15 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Sumit Gupta <sumitg@nvidia.com>
Cc: rafael@kernel.org, lenb@kernel.org, robert.moore@intel.com, 
	corbet@lwn.net, pierre.gondois@arm.com, zhenglifeng1@huawei.com, 
	rdunlap@infradead.org, ray.huang@amd.com, gautham.shenoy@amd.com, 
	mario.limonciello@amd.com, perry.yuan@amd.com, ionela.voinescu@arm.com, 
	zhanjie9@hisilicon.com, linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org, 
	linux-doc@vger.kernel.org, acpica-devel@lists.linux.dev, linux-kernel@vger.kernel.org, 
	linux-tegra@vger.kernel.org, treding@nvidia.com, jonathanh@nvidia.com, vsethi@nvidia.com, 
	ksitaraman@nvidia.com, sanjayc@nvidia.com, nhartman@nvidia.com, bbasu@nvidia.com
Subject: Re: [PATCH v4 1/8] cpufreq: CPPC: Add generic helpers for sysfs
 show/store
Message-ID: <s5xt53i6c5wryje5x6zlq75r3lx6nxb7pat6umnghpnldi4p2h@jaeew4iimdd3>
References: <20251105113844.4086250-1-sumitg@nvidia.com>
 <20251105113844.4086250-2-sumitg@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251105113844.4086250-2-sumitg@nvidia.com>

On 05-11-25, 17:08, Sumit Gupta wrote:
> diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
> -static ssize_t show_auto_act_window(struct cpufreq_policy *policy, char *buf)
> +static ssize_t cppc_cpufreq_sysfs_show_u64(unsigned int cpu, int (*get_func)(int, u64 *), char *buf)
>  {
>  	u64 val;
> -	int ret;
> -
> -	ret = cppc_get_auto_act_window(policy->cpu, &val);
> +	int ret = get_func(cpu, &val);

Why no casting required here, when you need it ... 

> -static ssize_t store_auto_act_window(struct cpufreq_policy *policy,
> -				     const char *buf, size_t count)
> +static ssize_t cppc_cpufreq_sysfs_store_u64(unsigned int cpu, int (*set_func)(int, u64),
> +					    const char *buf, size_t count)
>  {
> -	u64 usec;
> +	u64 val;
>  	int ret;
>  
> -	ret = kstrtou64(buf, 0, &usec);
> +	ret = kstrtou64(buf, 0, &val);
>  	if (ret)
>  		return ret;
>  
> -	ret = cppc_set_auto_act_window(policy->cpu, usec);
> -	if (ret)
> -		return ret;
> +	ret = set_func((int)cpu, val);

... here ?

-- 
viresh

