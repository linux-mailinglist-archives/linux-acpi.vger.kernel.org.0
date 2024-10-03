Return-Path: <linux-acpi+bounces-8546-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C8D7798E971
	for <lists+linux-acpi@lfdr.de>; Thu,  3 Oct 2024 07:40:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8DD732854BB
	for <lists+linux-acpi@lfdr.de>; Thu,  3 Oct 2024 05:40:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F16D838384;
	Thu,  3 Oct 2024 05:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="y/M0wME3"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D3C82110E
	for <linux-acpi@vger.kernel.org>; Thu,  3 Oct 2024 05:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727934047; cv=none; b=hpPa4JQviB4XsspZ5U6imi5aqr5a3UKy+IwTaFtJSJIN3FXrJxfsqTvZ0B1lKz50KJokabAbUFmkBCeQiWCAcPRYWRpHh8R3sSu+maR36F0VsNwbwd2cYXQFbHugjkHtDR75YmMAthr1tO/mfNzRxG/PPjuQOKCVaDZcMymxKME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727934047; c=relaxed/simple;
	bh=dnU4L/oEz0wymbgKZ4nhTdG9a6a4cXDE5YaEfelUT0w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QmEx0qGAvzahkapNoS0IqiQzhGMcy1dOFN1hJQ3jxTEG05KE7YPlxtZdPMqfmzujhPDza+SiC7sRcn2z/v9E3n6z0xMfHzATltvtuPKUMNZM6RM2Si4k3UH/75xK+xv5Cu2FuYww8PTycCaRsUA0v+r/1OfU3FJiSqheoqY4e+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=y/M0wME3; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-20b6458ee37so5276665ad.1
        for <linux-acpi@vger.kernel.org>; Wed, 02 Oct 2024 22:40:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1727934046; x=1728538846; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=x2c2so/LfztFajhVVrCfFRGf6/mFzkkOggzllbzK5Jo=;
        b=y/M0wME3PuWoZp0bF/cOCpRWzrsTkqzDOVefixtCMHorBj47V1SFiGHkGpiBYFZoo2
         oqXkfYVqN9rFYACoeRp1g3ukMn4gnHw/6GH83XUqjRK7CbTHr9+9F6VTjtOGdwGAFr+f
         I/qUHEP6EK9lyPLYTF5d2/44qVvPoiUjiCHQ9steT0qDS30WMHilC2cVKknSqM6L+sn7
         4/zsb0XLp3dUsHpbaAZYYVSCSElU6T1A+jdbsEKqxLoNVH2Dbar8iKSZ5YfL+uBCY6In
         IDw+RKX4hmFIdTz+MBBnoEju8RK8XJ652Xh8NCOZUhdF969qkksur6LiTU0RlqeOJ889
         mEuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727934046; x=1728538846;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x2c2so/LfztFajhVVrCfFRGf6/mFzkkOggzllbzK5Jo=;
        b=eG1keeLUaPT08iOnlbUiokeKicurhS00vHhEBoVwqBVeuysdyHmNs4FGJdPvBqv11g
         bBCgMJaBKmf4/MT5BI34fLg/bEBRpC3ipaE38WOsi+N0eOkZPM/scu5xBwh/UJDapMCD
         oA6faUOFGjWWNCQ1pz7BDztnXy9OlVnFx7y4ngIE6FTHCh/X9F9VeS9HO6C85BYPNirm
         ASq9VzcPbtCx+3iz2pGC6/BQ0INsR34qQGTxrQXCPZBUM73iOcanLxh2i7bfntF1/QYW
         z321BILYrMPFOkG1YAwO9FL6lmFEbNiGyyTY1fci108uQVSTDB0N4KLWGa5Ne58Mky0Q
         mSZA==
X-Forwarded-Encrypted: i=1; AJvYcCXptZi9X/WXxlGEHIEnAZQ8fu94X9QdCd2l61eOU5k3bGQ+1DK1SPJjE2ry6+wd3mVis2yNhQ/EhvC2@vger.kernel.org
X-Gm-Message-State: AOJu0YxlzJK+hBdRrdVBz9+jZjRGuhSE2xqpa4zmi9WHxEI6qjEqemje
	SEPOMU9fz+F6WFb4XZG8MTPTyLRgYRYuKHHBNWiGuxNr3HKmHuac7hUXncsVLdM=
X-Google-Smtp-Source: AGHT+IEcGgL7uF1src79jD8rHbjth6x1KA9onYNeT5aMNy4ktHVaQ33uT8b19o8yEH5ZSrE0/PFkgA==
X-Received: by 2002:a17:903:41cf:b0:20b:419e:9f15 with SMTP id d9443c01a7336-20bc5a5cff3mr71019945ad.46.1727934045744;
        Wed, 02 Oct 2024 22:40:45 -0700 (PDT)
Received: from localhost ([122.172.83.237])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20beefb2e2asm2060535ad.234.2024.10.02.22.40.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2024 22:40:44 -0700 (PDT)
Date: Thu, 3 Oct 2024 11:10:42 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Jie Zhan <zhanjie9@hisilicon.com>
Cc: rafael@kernel.org, ionela.voinescu@arm.com, beata.michalska@arm.com,
	wangxiongfeng2@huawei.com, linux-pm@vger.kernel.org,
	linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linuxarm@huawei.com, jonathan.cameron@huawei.com,
	wanghuiqiang@huawei.com, zhenglifeng1@huawei.com,
	lihuisong@huawei.com, yangyicong@huawei.com, liaochang1@huawei.com,
	zengheng4@huawei.com
Subject: Re: [PATCH v4 0/2] cppc_cpufreq: Rework ->get() error handling when
 cores are idle
Message-ID: <20241003054042.t463fqivfk6immen@vireshk-i7>
References: <20240929033214.1039485-1-zhanjie9@hisilicon.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240929033214.1039485-1-zhanjie9@hisilicon.com>

On 29-09-24, 11:32, Jie Zhan wrote:
> CPPC feedback counters can be unchanged or 0 when cores are idle, e.g.
> clock-gated or power-gated.  In such case, get the latest desired perf for
> calculating frequency.
> 
> Also, the HiSilicon CPPC workaround can now be removed as it can be handled
> by the common code.
> 
> ---
> v4:
> - Some additional comments as suggested. No functions changes.

Merged with following diff to fix the warning.

diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
index ae3424cb3335..fd3e328a2d57 100644
--- a/drivers/cpufreq/cppc_cpufreq.c
+++ b/drivers/cpufreq/cppc_cpufreq.c
@@ -38,13 +38,13 @@ static bool boost_supported;

 static struct cpufreq_driver cppc_cpufreq_driver;

+#ifdef CONFIG_ACPI_CPPC_CPUFREQ_FIE
 static enum {
        FIE_UNSET = -1,
        FIE_ENABLED,
        FIE_DISABLED
 } fie_disabled = FIE_UNSET;

-#ifdef CONFIG_ACPI_CPPC_CPUFREQ_FIE
 module_param(fie_disabled, int, 0444);
 MODULE_PARM_DESC(fie_disabled, "Disable Frequency Invariance Engine (FIE)");

-- 
viresh

