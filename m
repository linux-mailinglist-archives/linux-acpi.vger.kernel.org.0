Return-Path: <linux-acpi+bounces-8210-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 737B49732AA
	for <lists+linux-acpi@lfdr.de>; Tue, 10 Sep 2024 12:25:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E7DD61F21412
	for <lists+linux-acpi@lfdr.de>; Tue, 10 Sep 2024 10:25:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4C30198E65;
	Tue, 10 Sep 2024 10:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OsaTnXvg"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-io1-f42.google.com (mail-io1-f42.google.com [209.85.166.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AB58192581;
	Tue, 10 Sep 2024 10:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725963566; cv=none; b=hFcg2poDhCteQ0k1QNOLNWOl4VLDwCTSu/aj6CfL66Z3mc7upHSM0WKisO6tJyc5vOkTvDumVXAl3iUJOYfA5zx75pAEbUz6Mzf6/+k6QyN/FT9t7x3UZOCIpPdk+hBjcABg2QMwOocmL4CGHmH6rDMFeSaUmolmLoYJfPuR8mA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725963566; c=relaxed/simple;
	bh=C95Ej2aQN/c62kFPmyAGaW0daCgItfMqNofPsPiXkUg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nEoW3D1Yk7N8vysUCD18TvEhHW2zeNHbXvFddeM5CzOXhFWr3feRmydbcSwheDmSTHMh9oISdkeWP4EJb/2l/BlIG/l4gOJ7nUUMR0HhWe2bHZdD0fwyrp4DcAq7WQCozAXTQORe0xQPziaYppz5kLuEQgf0zt6/lMNjuQ5Ji14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OsaTnXvg; arc=none smtp.client-ip=209.85.166.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f42.google.com with SMTP id ca18e2360f4ac-82cd93a6617so105659739f.3;
        Tue, 10 Sep 2024 03:19:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725963564; x=1726568364; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uCP0tRBOIy+wsaDTLfRdgyza+J/0n87KT7hpkg3zkHY=;
        b=OsaTnXvg/swFvcRGs4EW3Vt9Srv0e0leIeTQGS6+NovXD3PBwMnUntHo3U6vA15Jc2
         12BSnp6ugGfa8dorOqImNsz1v8QqeCObjbQRc3bUTZoLUZXoD6B0KvFwINJjhePcM1rZ
         2HDWnWpw1iSjhqh4JbDivdBQGK34BapSuKRrHMtSwvqwhEY/T7AtXMfB6D11a1pT4BzV
         Ta2dbk3cTcTGujor2IU2JlV84fo+S95oFi5C6G9QBir11rtB9R9+wmTo7nWVS3PDeosi
         XFIMmjaYAYCE9CYdFfHSPERSPbxSf9/V8eykMRW8l+yZPgoJV8jJW324qQiCSJEkB4Oh
         yJBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725963564; x=1726568364;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uCP0tRBOIy+wsaDTLfRdgyza+J/0n87KT7hpkg3zkHY=;
        b=dlhoLARY808VzqBnsqWg2iHgiqr+2P/yRy6BvMpIw6XJ3G/VBv76qJSiHupWunLpm6
         J3bRMrfbBD1NGpgcOXV0CnNOlMnx5ZzSCpSO7pch57NBS978HlpUuLz1D7dFaOupoETy
         bjyKq5Y3Qv3XQHaWisv3Sq81JjJ0DiO/5WcCWfQcXYDVOclRdy/qYs3PRgaSSQkvSSs0
         dIB6ya9Ge7ZXusG79ThjdHZd0NkKSP5prsVOrP609iYqgq2j9aqE1F2OPGFa7wLGkE6R
         HGtjKuMTa+LTCiiR9XkRXTwC8CB7liY3z1Dv+KKvcNfxReNtlUdNfR/c1tS4o7Pwecr+
         2mTw==
X-Forwarded-Encrypted: i=1; AJvYcCUCRCj5Ol4Ydve9rAVS+lG//BVlY0myxWVDK+1Lp5OTda7QFdReum7GStGWE63pQBOC/Zg6WwtnG1s=@vger.kernel.org, AJvYcCUW/zKluJ3wlA3YYgJqFf4/jDUxSg50AkXe/dxVU/BJdD2nUHnwqeqi0fKFCdLZ1XxTue+O0KZDU00A9T2L@vger.kernel.org, AJvYcCXTgdaL6OGGBrLCDR64nGuH0Hgvp/Jbi3ad3cASiICjX6rcjnGCYnJ5RErdv30dVhLveOdhkHOYZ/E2@vger.kernel.org
X-Gm-Message-State: AOJu0YyMj7QZ6Tb5q/g7Zc837HikHUiHpKJ02RA/H8hqOI8QxYfIyxUs
	pf77RISwttPWU+v6LG6087sd8tIdWODMrt8NkvNKEBu2uOrfoBfS
X-Google-Smtp-Source: AGHT+IFi1zaBeOZjTw7d0VSukZgvKaIGbeZUF6nMC8+GShKRqhjV0ugGd0V2/z6AnmzzjrVOyAAYnw==
X-Received: by 2002:a05:6602:1693:b0:824:d5d2:2c8f with SMTP id ca18e2360f4ac-82a96171bf6mr1274984839f.1.1725963564155;
        Tue, 10 Sep 2024 03:19:24 -0700 (PDT)
Received: from ?IPV6:2600:6c56:7d00:582f::64e? ([2600:6c56:7d00:582f::64e])
        by smtp.googlemail.com with ESMTPSA id ca18e2360f4ac-82aa733a317sm200522139f.4.2024.09.10.03.19.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Sep 2024 03:19:23 -0700 (PDT)
Message-ID: <53f402cb-1a0d-4b48-b92a-e968ea77a138@gmail.com>
Date: Tue, 10 Sep 2024 05:19:20 -0500
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 10/11] cpufreq: amd-pstate: Add documentation for
 `amd_pstate_hw_prefcore`
To: Mario Limonciello <superm1@kernel.org>,
 "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
 Perry Yuan <perry.yuan@amd.com>
Cc: Borislav Petkov <bp@alien8.de>,
 "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
 "Rafael J . Wysocki" <rafael@kernel.org>,
 "open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)"
 <linux-kernel@vger.kernel.org>, "open list:ACPI"
 <linux-acpi@vger.kernel.org>,
 "open list:CPU FREQUENCY SCALING FRAMEWORK" <linux-pm@vger.kernel.org>,
 Mario Limonciello <mario.limonciello@amd.com>
References: <20240905163007.1350840-1-superm1@kernel.org>
 <20240905163007.1350840-11-superm1@kernel.org>
Content-Language: en-US
From: Russell Haley <yumpusamongus@gmail.com>
In-Reply-To: <20240905163007.1350840-11-superm1@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/5/24 11:30 AM, Mario Limonciello wrote:
> From: Mario Limonciello <mario.limonciello@amd.com>
> 
> Explain that the sysfs file represents both preferred core being
> enabled by the user and supported by the hardware.
> 
> Reviewed-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
> v2->v3:
>  * Add tag
> ---
>  Documentation/admin-guide/pm/amd-pstate.rst | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/Documentation/admin-guide/pm/amd-pstate.rst b/Documentation/admin-guide/pm/amd-pstate.rst
> index e13915c540648..d5c050ea390dc 100644
> --- a/Documentation/admin-guide/pm/amd-pstate.rst
> +++ b/Documentation/admin-guide/pm/amd-pstate.rst
> @@ -263,6 +263,11 @@ lowest non-linear performance in `AMD CPPC Performance Capability
>  <perf_cap_>`_.)
>  This attribute is read-only.
>  
> +``amd_pstate_hw_prefcore``
> +
> +Whether the platform supports the preferred core feature and it has been
> +enabled. This attribute is read-only.
> +
>  ``energy_performance_available_preferences``
>  
>  A list of all the supported EPP preferences that could be used for

I notice I am confused. If the attribute is read only, how can it be
enabled by the user?

