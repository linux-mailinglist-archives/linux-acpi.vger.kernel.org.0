Return-Path: <linux-acpi+bounces-18269-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0ADC0C12E9F
	for <lists+linux-acpi@lfdr.de>; Tue, 28 Oct 2025 06:10:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2BFC6189E75B
	for <lists+linux-acpi@lfdr.de>; Tue, 28 Oct 2025 05:11:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D858226D1D;
	Tue, 28 Oct 2025 05:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TDOBR5lU"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA5CE1F4C8E
	for <linux-acpi@vger.kernel.org>; Tue, 28 Oct 2025 05:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761628242; cv=none; b=WmpJw4odjN2JwuJgh0mSSvT6qCvM44LkcGzBjKYikwvTumRBxbUYrJOIq4FCMhFzrux9AXauBB7pDBLD2qeVXAjYR/dRttiSQzxcOWm4cC8oqBoOdpAtnBT7WXwj0TT7gmZGex9TKDI2YZpsoNQsFFD6Yecf2z6cPyngaEExysg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761628242; c=relaxed/simple;
	bh=40O++wB2FKhQIcXBoArSMvDK9vuoqAHsWfkqxR3yAi4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pC4rGAgKBKLE8j95DFmGaMt3A+ZD3+g1+QbtrNkk3YPwObFq6C31MovYFVxJTWs0aWhsJx/xPifTgyRJF6cWFV+eu1k/7KrJBTLjuZX0G7dIH+exPO5r8Vjc9FnN225adjdV32u6+hBfBNK5E+3Lt8NFJ+fhNlTeh1r5Ib7250w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=TDOBR5lU; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-7a226a0798cso4511169b3a.2
        for <linux-acpi@vger.kernel.org>; Mon, 27 Oct 2025 22:10:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761628239; x=1762233039; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NCqr2A4tFWO56+nsiAFj8w8uU6z9HieZzNnrp5Dee6U=;
        b=TDOBR5lU1ufdTYooxd9Ha74HfkaaW81VQmvSjh8DAV16BTqYQ6X8VSliOU+XbUzjpo
         PFzFWQUcsK1XXwRLYBfnyySZuftIT7nth+xsGUgHoAJ6sHFXeFlQ56fsbp7cHI4G1Jch
         Sm+BlyxGJJqBOljD3kgMAeX/53rcUSmZyMJ4ogfa4HKTfvFBL+r0SjXYyMQ/kjwHeAu3
         I1DoiaASQBd2pi7iq23gKR/IiVe04ndGV3Vu5Bc9+HCXWgtdhi4DqRp3QEPObQFx12iV
         0pywAVwcmAIIS/CniwI5QaxtXA4OXuEYh6e1KR8pr7VjqKcyJh2DjJpkagJTgbUBE6yV
         LBfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761628239; x=1762233039;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NCqr2A4tFWO56+nsiAFj8w8uU6z9HieZzNnrp5Dee6U=;
        b=Hqxrjr7Yp+5kgRrxNXAUpP7G9VWzIK0V73y8G2N2rgJPHlvH2rSenytfBub38LZCIH
         e9t0Svrn04huh8u5JrBVxDicLQMGbNED03m0THlGKib90o5Sx6P94uejX15/LEbA2m9Q
         dFroNiFKAFeSqILdFB60eJtV34foGjU2wuztzBYQdF5UJO0ER2K5yqllb4CD8ua0K7yR
         8SSCEBpwgApowoV+LE7Jxh3QDyjguZ5KszDkqds5Sglygul7GugZ8orgBMp+MVgFiSDG
         CcUDWy9CChu8hRVtV7mxRfLh5ah5xGbrPAXljpS2wo6/WJm23RtOIWom21ekCKJeWmQD
         R/Ag==
X-Forwarded-Encrypted: i=1; AJvYcCV6g/x1/tkDW+BWIVU6yZhSr+ttGz5M63R8VdaggVN2rpe0mUxeGAXDl2MPMDamfiHeoyjT8mE1rIJY@vger.kernel.org
X-Gm-Message-State: AOJu0YybQCN1sxg0GmmxU0HXtPjop/uTu2+kOVmk+lJ+T6EUp8QGq0wv
	xNQBac7jj3e6BQuoNghuO2U3Sbei8qOaVtD/pDpZHDFMTF9+S4cZJDNmGt44z7YvPDI=
X-Gm-Gg: ASbGnctHgutj7KsJ90w/tJkCKbtm8qN70y+R8btC3sMgfNlkasWGPslraTV0M0v0+2X
	/SWYDAcxc+t8Cah8qI93ZGgMXEHs6MnJDtnt1s7FaA57eXdD/A3JjqCCYEh4NJ0LFkmx3BCrfan
	9KJId64PLVK3m3xU/jKEyOeHkmAiXdpOWgO64/7jExI9MRszgfo6w/0Qxu3+NClj6l+65IoVaJf
	/kc9M5bWKp5kxvMSuuVGo5swsO8VG5kqfGlKh7Hh4YHb8N6mBsfUZxurYzqJBm24x4m+cfTMBon
	R8ZDv6EEvjEAT2TnuBT+vyrekxPhUDx4oCNIwD2ZN2d24lTxa6XgKmlPH9R/Ve2exMufuC+osSe
	QDLMkBD7VGJzSJinhuCLJfziqIYmJ3NuWsugyjZ/LGPgAtyApUdTFDHlSgiEFbeEyoUfO8K3JR2
	SkNA==
X-Google-Smtp-Source: AGHT+IH3PzOT/Gzd4Jq84gD+JDZaE7asS8taydUlJ6e8s64E1mDRpk69qEQv1J7IkKuekdlAsY/POA==
X-Received: by 2002:a05:6a00:4f93:b0:7a2:7157:6d95 with SMTP id d2e1a72fcca58-7a441bde05dmr3061529b3a.14.1761628238847;
        Mon, 27 Oct 2025 22:10:38 -0700 (PDT)
Received: from localhost ([122.172.87.183])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a41408e617sm10106630b3a.67.2025.10.27.22.10.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Oct 2025 22:10:37 -0700 (PDT)
Date: Tue, 28 Oct 2025 10:40:35 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Jie Zhan <zhanjie9@hisilicon.com>
Cc: rafael@kernel.org, ionela.voinescu@arm.com, beata.michalska@arm.com, 
	zhenglifeng1@huawei.com, linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linuxarm@huawei.com, jonathan.cameron@huawei.com
Subject: Re: [PATCH v2 1/2] cpufreq: CPPC: Don't warn if FIE init fails to
 read counters
Message-ID: <h2k4enovkvyasxkf3s6ceslpdnhhuvems3jmmv6a2q2zg4nsap@tlsqppgiszwo>
References: <20250828110212.2108653-1-zhanjie9@hisilicon.com>
 <20250828110212.2108653-2-zhanjie9@hisilicon.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250828110212.2108653-2-zhanjie9@hisilicon.com>

On 28-08-25, 19:02, Jie Zhan wrote:
> During the CPPC FIE initialization, reading perf counters on offline cpus
> should be expected to fail.  Don't warn on this case.
> 
> Also, change the error log level to debug since FIE is optional.
> 
> Co-developed-by: Bowen Yu <yubowen8@huawei.com>
> Signed-off-by: Bowen Yu <yubowen8@huawei.com> # Changing loglevel to debug
> Signed-off-by: Jie Zhan <zhanjie9@hisilicon.com>
> ---
>  drivers/cpufreq/cppc_cpufreq.c | 12 +++---------
>  1 file changed, 3 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
> index 4a17162a392d..7724318b3415 100644
> --- a/drivers/cpufreq/cppc_cpufreq.c
> +++ b/drivers/cpufreq/cppc_cpufreq.c
> @@ -144,16 +144,10 @@ static void cppc_cpufreq_cpu_fie_init(struct cpufreq_policy *policy)
>  		init_irq_work(&cppc_fi->irq_work, cppc_irq_work);
>  
>  		ret = cppc_get_perf_ctrs(cpu, &cppc_fi->prev_perf_fb_ctrs);
> -		if (ret) {
> -			pr_warn("%s: failed to read perf counters for cpu:%d: %d\n",
> +		if (ret && cpu_online(cpu)) {
> +			pr_debug("%s: failed to read perf counters for cpu:%d: %d\n",
>  				__func__, cpu, ret);
> -
> -			/*
> -			 * Don't abort if the CPU was offline while the driver
> -			 * was getting registered.
> -			 */
> -			if (cpu_online(cpu))
> -				return;
> +			return;

diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
index 7724318b3415..5a30c1ec0cdd 100644
--- a/drivers/cpufreq/cppc_cpufreq.c
+++ b/drivers/cpufreq/cppc_cpufreq.c
@@ -144,6 +144,11 @@ static void cppc_cpufreq_cpu_fie_init(struct cpufreq_policy *policy)
                init_irq_work(&cppc_fi->irq_work, cppc_irq_work);
 
                ret = cppc_get_perf_ctrs(cpu, &cppc_fi->prev_perf_fb_ctrs);
+
+               /*
+                * Don't abort as the CPU was offline while the driver was
+                * getting registered.
+                */
                if (ret && cpu_online(cpu)) {
                        pr_debug("%s: failed to read perf counters for cpu:%d: %d\n",
                                __func__, cpu, ret);

Applied with this diff.

-- 
viresh

