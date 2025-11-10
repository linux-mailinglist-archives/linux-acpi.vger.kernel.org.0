Return-Path: <linux-acpi+bounces-18723-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8921C46182
	for <lists+linux-acpi@lfdr.de>; Mon, 10 Nov 2025 12:01:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 60EFA3A68B4
	for <lists+linux-acpi@lfdr.de>; Mon, 10 Nov 2025 11:01:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AC73306D48;
	Mon, 10 Nov 2025 11:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MoITomXm"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FA26306B00
	for <linux-acpi@vger.kernel.org>; Mon, 10 Nov 2025 11:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762772458; cv=none; b=S+1yUHHxN4vcg0TquCn3Zhk98hBLlrUJkX0LYf8R50u4EBbsQ+lJJxn/eGpe3VmB4KdiPVM3WW6e25oYSTskoego6y0Ue6+e/DXJe4km7IdYZsdtkAXsjfTmvgDPAVxQ0Wtn00pIRFADaDgOZoJMoDaG49OEESPmA/fRNcV/7kc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762772458; c=relaxed/simple;
	bh=j/sDhA1BE/crBk5MB3jz5Gyqsa0mwcEpYJuOnY+51Ws=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dZBcHE4xawL2Ct+JBnjZRPy29MzUFZ+fJOxva2wtWRUXF/obBga8ybnnD0d/3vEDUMO2rJA9U7OUmg4ZaKgvu1MSjJilYhBYS38S9+L2QjMwMZH+eIRKRSmXetoWwbYoz8fFLfI8eS2UfqcwMzF+5nTf7cJXhIQDO9OPJgrhPEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=MoITomXm; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-7af6a6f20easo2257361b3a.0
        for <linux-acpi@vger.kernel.org>; Mon, 10 Nov 2025 03:00:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1762772455; x=1763377255; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YrIRy6Lhq+4eE5yPFjSN9IOBDP8Cyczj9KXwJvvJFlc=;
        b=MoITomXmIdl0l9mMoc4ILl2St6hK1A4HMUb0F493E4DjqRtYRaaHWITxuqAxyq4ZMt
         Eux6VA/tuOY/Phh+AcSizGAkdWdmdFpuWDuTX4jh4eLo+zxAkadFZO+DnDH9dLRMMPvw
         KM5rJ8gPZho8vx/xWz9zYmHpGbiQ0u+pNqXNNOG+Ohb69SzBHy7dy9Deb0Mh1kyi6bDr
         BLIjiHLZZrloc2S58aturYja41JAsiGJcgCQg1UGb0GcsXEDi64d/pQE6WK7V4y/SvN6
         HDod5am68vwzf1U+U9hlWeSGUECILkPgFoMuE3rFPrySIu3Ue/zZb9jRtE69mO6FLLwU
         5Hag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762772455; x=1763377255;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YrIRy6Lhq+4eE5yPFjSN9IOBDP8Cyczj9KXwJvvJFlc=;
        b=IYHN7G6LmrUt28OXIQJlZ7zsEJ5nRHNq25CEAErYdBItNTbNGHNVtubapvrGwL4SBA
         AVg4fg7KE44x4a1Sk7wrs7IdXmHeqfZtceos/RpzvD8b+Y7F4w5cEeVVheHrKFyQ3AAK
         HHJHI3+G6XWVECiPPw8STW9HlHgpNZ2QVOCfrCCGJRThcHursxulGMF/hA20C+qkE1kK
         oz+SYAH1R3vDLbK8dKLxclZ3ND4wsV/WHK/QXxmGKm5JPBc4BDpn4W4fyl/zMQYT+ipR
         7J5VmdXXA5J1Hs7cnmU6vQRVYjcD4MRCPwtAxPHRR0JZL/+sEubRSzF2wyxA4wPc87XA
         K6SQ==
X-Forwarded-Encrypted: i=1; AJvYcCXU6W/95a+vB/N8OM8ja5cdZ+9sXJRmrYDM92S5ANccKLlJmiQKOXDrOqDnx7x/VVyTYvLoy1A/eZSX@vger.kernel.org
X-Gm-Message-State: AOJu0YzOaMNwDRsx+A0Ft1Tw58xmsHT1tqVS7PxXuAC1RD+lsY063l9h
	AHBTR7C1jxy2DlzEJUapZUJE2WF1t/t37zkrpNFH1pP9KzFiqO8Nf4kXYIVDEJe3IeA=
X-Gm-Gg: ASbGncuHW/es+NPXA8WmK9XX6U9fNUwMievksMdRBrgCw622DhZUxaVjO729onT3J/B
	qk83JvNVZHIsoimgk5sLNIHkSSwYry6J8DOpYTQVGL7R8JL8je4Eivc/QokfHKvD/1DhGssfnBN
	bx1Mh7YZHd45E4KWh9Btb1koG3cMirNB17uMzqwO27U2TEEtKzy1UUiEXPLN43xfIhkbxXDWWFz
	L5amBJRPwteGSwtRoORZtIcIIxtc+I+A8sS3XcarryKwZowQAlN7VGpR4PdwuEgF85h+cOhqxtu
	ZIpI1LeKQasMeu6Vu10UK74f2schY1SYN5g3jpgbELgEa5HUP6ZsqLi0O0yusvEvvLMrFEsfFmJ
	NxzWLB0HVmvbsVHgjcKfqZPIWG1R+VHcIo68kW7bXvrjg4FTx+l3Z86UNP+tb4kuawj39GhoWnj
	LKkdoOfVBraLw=
X-Google-Smtp-Source: AGHT+IGOFDbu7mquDmNhSqV97BdY6cG6MLgvb5Xp7QodBHXn8La7j+gNEL/xmdVl7cozIyrmwIAy9g==
X-Received: by 2002:a05:6a21:3291:b0:350:1872:7023 with SMTP id adf61e73a8af0-353a4163b2bmr9937463637.55.1762772455121;
        Mon, 10 Nov 2025 03:00:55 -0800 (PST)
Received: from localhost ([122.172.86.94])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7b0c963586fsm11304602b3a.10.2025.11.10.03.00.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Nov 2025 03:00:54 -0800 (PST)
Date: Mon, 10 Nov 2025 16:30:52 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Sumit Gupta <sumitg@nvidia.com>, pierre.gondois@arm.com, 
	zhanjie9@hisilicon.com, ionela.voinescu@arm.com, beata.michalska@arm.com
Cc: rafael@kernel.org, lenb@kernel.org, robert.moore@intel.com, 
	corbet@lwn.net, zhenglifeng1@huawei.com, rdunlap@infradead.org, 
	ray.huang@amd.com, gautham.shenoy@amd.com, mario.limonciello@amd.com, 
	perry.yuan@amd.com, linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org, 
	linux-doc@vger.kernel.org, acpica-devel@lists.linux.dev, linux-kernel@vger.kernel.org, 
	linux-tegra@vger.kernel.org, treding@nvidia.com, jonathanh@nvidia.com, vsethi@nvidia.com, 
	ksitaraman@nvidia.com, sanjayc@nvidia.com, nhartman@nvidia.com, bbasu@nvidia.com
Subject: Re: [PATCH v4 0/8] Enhanced autonomous selection and improvements
Message-ID: <hjrcoq7dapqcodk3iiyvjeuq3cwvyccqr4wnlcoi6eduqg5ahf@tszrjvfnkjux>
References: <20251105113844.4086250-1-sumitg@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251105113844.4086250-1-sumitg@nvidia.com>

On 05-11-25, 17:08, Sumit Gupta wrote:
> This patch series enhances the ACPI CPPC CPUFREQ driver with
> comprehensive support for autonomous performance selection, expanded
> runtime control interfaces and improvements.
> 
> It adds support for below:
> - Expose sysfs to read/write the Minimum/Maximum Performance Registers
>   using frequency (kHz), with internal conversion to performance values.
>   Also, update the policy min/max accordingly.
>     /sys/.../cpufreq/policy*/min_perf and max_perf
> 
> - Expose sysfs to read/write the Performance Limited Register.
>     /sys/.../cpufreq/policy*/perf_limited
> 
> - When toggling autonomous selection, synchronize the policy limits
>   by updating the policy min/max.
> 
> - System-wide autonomous mode configuration via 'auto_sel_mode' boot
>   parameter. Mode can be switched dynamically on individual CPUs.
> 
> - Generic sysfs helper functions to reduce code duplication.
> 
> The patches are grouped as below:
> - Patch 1, 2 & 3: Improvements. Can be applied independently.
> - Patch 4: Sysfs to update min/max_perf. Can be applied independently.
> - Patch 5: Sysfs to update perf_limited. Can be applied independently.
> - Patch 6: add sysfs documentation. Depends on 'Patch 4 and 5'.
> - Patch 7: sync policy min/max with auto_select. Depends on 'Patch 4'.
> - Patch 8: Boot Parameter Support. Depends on 'Patch 4 and 7'.

Beata/Ionela/Jie, any feedback on the CPPC changes ?

-- 
viresh

