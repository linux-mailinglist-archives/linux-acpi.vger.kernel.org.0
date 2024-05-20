Return-Path: <linux-acpi+bounces-5894-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7345E8C993D
	for <lists+linux-acpi@lfdr.de>; Mon, 20 May 2024 09:25:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 26E58281388
	for <lists+linux-acpi@lfdr.de>; Mon, 20 May 2024 07:25:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB1461B813;
	Mon, 20 May 2024 07:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="r/ihDRJb"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6759317C6C
	for <linux-acpi@vger.kernel.org>; Mon, 20 May 2024 07:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716189919; cv=none; b=XmBntRcAL0TBfYBpWuVs7xgRO9PMzqEOIELMT4gTkvBwt9c7VQy0knAdb2ttS49irURpU2JaWqyBa3FFVjezLPm81eB8pe2X64Tgt+ThXuNLD0zkqDEKHEuVMBwqM9Eyz1fgx9Yl9brC4kRnGmI85Pd39E5ikdqi2RFYpeVx2yI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716189919; c=relaxed/simple;
	bh=+fObv7pYjpDl9fdzZP147nI7QMSBzyYiYdYAVlbJC1E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ExwW9jLr2O6xi1Zlqp9MXbnR+Lk6mcIw5r6Jp8fvKCP8vYxDpcnCb9j2WGrMShTM77SvSbcbBFEgYS3e1zA/poIbUxfgFvfljSu2RiJnIl/Tny+32+S788bRunCKB30ZTuOm/D4JJFzf+eJuK4EUajfyk+NfaxATDsjQKJplpSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=r/ihDRJb; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1ed0abbf706so62998845ad.2
        for <linux-acpi@vger.kernel.org>; Mon, 20 May 2024 00:25:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1716189916; x=1716794716; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SFdmcNpzRo2oo+yppr3+cUzOw6aLmc7VZ0+XNX0Zb1s=;
        b=r/ihDRJb0Z/gUar1t1tPHTiw949RFqYvJzblzQYOmyylS8U7OEAqeE30oIX7Ndg5oa
         ONWauew3GMAoeHKak8/xOvzaFRhjOD/MgGd/4RZT/X/JKKOuqhkX10Wzb1dBovFYDyMZ
         JRNt2PSpI3smbheIKWqCg6PIHEbMtM2t+HBPE2NyOp88JW6h552pMBawdggbo2U88Dv7
         8nx+iEbAUyNHpX5VJ7b1NKqcyl5uwupsidBJhSUeTO5KO4G0/fvTXsNN3mXJ9ogyGzLQ
         q1JzNTHDrhsV1w5vanWh2MMlNQoxVe2TRWu+FXcfUIgVdfH8Cp9MdMfYCMBhNWv5+hKb
         27PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716189916; x=1716794716;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SFdmcNpzRo2oo+yppr3+cUzOw6aLmc7VZ0+XNX0Zb1s=;
        b=NtrQP0FZ73AOXvWEdSIjN6hPZXTSGxONVlfplpiHU37GEqCcZhNelbnrfWxIdV+nEU
         SD/0IjV3QimrVjKffw1U3GNiS3poEF4H7Nhu9cGOt+VyJqhArFfuPpvGN5Xv4L0bPArc
         Yqkye5iZTw0jD2ouEMuIpi2pdQanKvCpYOSPY5LHETTEhFmX4TVHWDBRKDZjg09wyfUr
         MADYdgT+QCVu63uhrE5hAwmevL8+q1ob3cVtOqzVKcmpKMT//O8fOibADJ+JiCArqJXG
         jjU550G6FT931/rXsTCtYdm+Nh7GXlvdN6ObgsYBE1nVZJBCmRvtj6XMiGP9OilQGHfj
         WRYQ==
X-Forwarded-Encrypted: i=1; AJvYcCWxRgrrqI4bIaLTWaHDOap1ao9BJAZR+4e7UKXl2Ln3VegXxyGXFf7z02mhu76eD/LJL5Ysc2vpzDw20wTEEnw/RKlSqiDLvHVFYA==
X-Gm-Message-State: AOJu0YwwsesQjBqb5O7UKSgFS5Cuuy/GcE8AdGybJfzl/tqYl3pOI46w
	TjC3B8jGdeJ8+eUgIDvcQ1CWcEmu4G0+yGNc0c9ooi9wd/f9YLEL17reyEpkXDs=
X-Google-Smtp-Source: AGHT+IErwJLJcVq4YYoQHsxB+z/x6ysdEbBT7kYPibdEh7GbAAShwTr+CfGDco3v8nOOB3tK/ekTFA==
X-Received: by 2002:a17:902:c942:b0:1f2:f3dc:43ee with SMTP id d9443c01a7336-1f2f3dc4ddbmr56186065ad.3.1716189916472;
        Mon, 20 May 2024 00:25:16 -0700 (PDT)
Received: from localhost ([122.172.82.13])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ef0b9d385esm201022905ad.38.2024.05.20.00.25.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 May 2024 00:25:15 -0700 (PDT)
Date: Mon, 20 May 2024 12:55:13 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: liwei <liwei728@huawei.com>
Cc: rafael@kernel.org, lenb@kernel.org, Pierre.Gondois@arm.com,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
	liwei391@huawei.com
Subject: Re: [PATCH v2] cpufreq/cppc: fix perf_to_khz/khz_to_perf conversion
 exception
Message-ID: <20240520072513.vtlqwjbmxugvuppj@vireshk-i7>
References: <20240506075816.1325303-1-liwei728@huawei.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240506075816.1325303-1-liwei728@huawei.com>

On 06-05-24, 15:58, liwei wrote:
> When the nominal_freq recorded by the kernel is equal to the lowest_freq,
> and the frequency adjustment operation is triggered externally, there is
> a logic error in cppc_perf_to_khz()/cppc_khz_to_perf(), resulting in perf
> and khz conversion errors.
> 
> Fix this by adding the branch processing logic when nominal_freq is equal
> to lowest_freq.
> 
> Fixes: ec1c7ad47664 ("cpufreq: CPPC: Fix performance/frequency conversion")
> Signed-off-by: liwei <liwei728@huawei.com>
> ---
> v2:
>     - Fix similar issue in cppc_khz_to_perf()
> 
>  drivers/acpi/cppc_acpi.c | 22 +++++++++++++++++-----
>  1 file changed, 17 insertions(+), 5 deletions(-)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh

