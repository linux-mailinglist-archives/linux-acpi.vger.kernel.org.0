Return-Path: <linux-acpi+bounces-17386-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 727BDBA83E7
	for <lists+linux-acpi@lfdr.de>; Mon, 29 Sep 2025 09:29:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 145CA3A89FA
	for <lists+linux-acpi@lfdr.de>; Mon, 29 Sep 2025 07:29:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1484F2C029B;
	Mon, 29 Sep 2025 07:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZRX0INB5"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B1ED2BEC26
	for <linux-acpi@vger.kernel.org>; Mon, 29 Sep 2025 07:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759130939; cv=none; b=JSLrRwkROf1tnFvW52aqt6kIFmMnn/ClWxdQhXPW1mIsZcYnVTNOJY06gzPvM+aVkhoc3alTkZAUjkBBaQWu/VdHlrzb15epvbklXO/ccjapNRL2u+xilOmHQHQU1kMw1fJ0b7HyBlVqYuDYPHtUxHWfzm0WD353ULYqDrhewO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759130939; c=relaxed/simple;
	bh=7F4Bd412NUjkHLR4AZb/VhkbRK5cWLJC7xh1AlsvUNs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h7v8Q5JWOzihZXBP3pdOEffM7Yv7lQbKaDZF9SVTMNwYpxIpZ3AM5xVxlGrOEcHilSb/3W1yHkBfHvFqIJo9AchiUeFE5h9OXmQC/r34Dz/41dJxCBDCYcemkIbwRfuJJHQ/BlBleOiPtjjDkWSe6M+wHbezi6VU+i6m4sT5MEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ZRX0INB5; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-26e68904f0eso42386935ad.0
        for <linux-acpi@vger.kernel.org>; Mon, 29 Sep 2025 00:28:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1759130935; x=1759735735; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vUgMt/Iu4HigVywPOVpy02As/ACdmcQ/LQX8wXFvh6s=;
        b=ZRX0INB5ednEuV6egMHPHfQXIVcrMHwCk3izCYJVrJfRq0aHh49niegTpoLK2GZ5hp
         0Ksx/55lEPd16bu6L104h6AMAybWD4QfZwY5UE+k1lK5i5vr24XcECN8WDPL/o8sToDQ
         NRuvuw3mzMhz6Ecta54WtJgC1uOj7L/mmCEFl26BqszKdVCrWC+EbLB2KAzj7xE4J5yl
         nHOvh1WqnLlGAbS8EZNwD17hHrobPc/ThmaRjpYFNt0UY9BlrWQ3xTAkTjwvIra9X1SN
         fO7nXlJctLWAfhsJCA+1yYpqca7/bBW2fKgVOor27Y0Ir18zqnICIXOZApoF2AcoVlWn
         nMEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759130936; x=1759735736;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vUgMt/Iu4HigVywPOVpy02As/ACdmcQ/LQX8wXFvh6s=;
        b=erMRDyAxAMYrr6qLTRc0yoGVBho2d8dIBGtBJX2emYRlU6vM6AaMQP6XASLm1WXAfl
         LlMSoej700i1diLhpKQLa1BJfr4YO2Rc/zi5f9bLiprkT1ScWXFTizM/0HCkhTv7vTb+
         oSzb8dy+yU6IATEJeLyaAQBUASQLZTL6yrZXdearJHwXEw3UVAza5kcHMsLRyA0Wt0Ze
         01V1zZrzwCE9L8NYtEI3hSnStDGj8HMlAb2UkoJ1JUeR+UbI6fjNApLqZdHdv2HzoTTR
         wQV/uG2/Wg/wtGMyMDfBrPQ8pnBObOhf7axqAgY25HLXVZhUo23J9+VvqvXH3ZUys4c+
         hM2w==
X-Forwarded-Encrypted: i=1; AJvYcCVMRTvUT2KX2Z7H0a7IYwky60n4FjsBIH/OrFa9cNW2sdEBQ6rhrilH8NArK6UxLdKgl3sHCsR6RJSi@vger.kernel.org
X-Gm-Message-State: AOJu0YwX/ETvPrJejigmN2WoCmkPYPlsi9w3MxiLBiz2DJeuEVoiRdle
	Cmv0n3RICj3ffun/TbunZGlayc8rS1VIZcRruX7816EChRY/ZygetI1O2qmDqXRjx9w=
X-Gm-Gg: ASbGncvKbcngPBWLguGHAm7Pmiz4JE3Gg6LcCGbe6+sVKPWExyueOnZ0JQKjjNGRK6R
	8tPpQDHq6ND+4M/zCsZ5foS+EsLuPjPI1CzRP8Hb8CFtPKWf2dqHhoa5hXDW6hL+B6bNFZntBXh
	yMXX5PBaYwFboJDiiMeSZJFT+JSc7RpLusyGXawdyQJnlZfEshrWi2SgTi6WGWTwxZFr9uhgq28
	robspYBq3a1BipH5OB/ICa0vjqREoX+NR8nttpT9w8NpzuYfQb/MA1vBqi4XLGhaH8oLdZ9BTSf
	5F+B4o3TMXM/sysmfqqLXx8E6V11JRhTrK7Em4zwNC8ui6cnfEam8NeyVa+phyFzkcz9+OJYJSk
	U7ffUN8HgXzLTAznAJ1YTvCve
X-Google-Smtp-Source: AGHT+IFV04UkDk6nLUCSmgZN+tUyoArW1g8+WIB0WCKL3KwMarnJ2CKoOoUMLY19056+D/VsX/c/Zg==
X-Received: by 2002:a17:902:e890:b0:24c:a269:b6d5 with SMTP id d9443c01a7336-27ed493e891mr151642625ad.0.1759130935564;
        Mon, 29 Sep 2025 00:28:55 -0700 (PDT)
Received: from localhost ([122.172.87.183])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-27ed6997ae3sm123206695ad.106.2025.09.29.00.28.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Sep 2025 00:28:55 -0700 (PDT)
Date: Mon, 29 Sep 2025 12:58:52 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linux PM <linux-pm@vger.kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Qais Yousef <qyousef@layalina.io>,
	LKML <linux-kernel@vger.kernel.org>,
	Prashanth Prakash <pprakash@codeaurora.org>,
	Pierre Gondois <pierre.gondois@arm.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Linux ACPI <linux-acpi@vger.kernel.org>
Subject: Re: [PATCH v1 0/4] cpufreq: Fixes and cleanups related to
 CPUFREQ_ETERNAL
Message-ID: <20250929072852.2krpxwaq2uxwj6cp@vireshk-i7>
References: <8605612.T7Z3S40VBb@rafael.j.wysocki>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8605612.T7Z3S40VBb@rafael.j.wysocki>

On 25-09-25, 17:42, Rafael J. Wysocki wrote:
> Hi All,
> 
> The first patch in this series is meant to address the failure discussed in
> 
> https://lore.kernel.org/linux-pm/20250922125929.453444-1-shawnguo2@yeah.net/
> 
> but in a different way than proposed by Shawn.
> 
> The second one is a CPPC cpufreq driver fix preventing it from using an
> overly large transition delay in the cases when that delay cannot be
> obtained from the platform firmware.
> 
> Patch [3/4] makes CPPC use a specific symbol instead of CPUFREQ_ETERNAL for
> signaling error conditions while attempting to retrieve a transition latency
> value from the platform firmware.
> 
> The last patch removes CPUFREQ_ETERNAL (which has no users any more) from
> cpufreq, including all references to it in cpufreq documentation.

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh

