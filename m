Return-Path: <linux-acpi+bounces-18553-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B731FC3693F
	for <lists+linux-acpi@lfdr.de>; Wed, 05 Nov 2025 17:09:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B6851A212B0
	for <lists+linux-acpi@lfdr.de>; Wed,  5 Nov 2025 16:00:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B83BD333446;
	Wed,  5 Nov 2025 16:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q1GS72Zr"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8850B33343D;
	Wed,  5 Nov 2025 16:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762358428; cv=none; b=pI/yo+Y+phs5A0FDbpYs+d2ZIVxj2oAsNedekyk9lJSvaPo2gFpgsNd2tAEFUBiXVoAt1QyweEP3vctItv7KRF5nfO1QQTxmk+VEhZWW6AI9joP3x7k7k+BdqGNFIEM4oHcgfWmwhJRd8YueGgVDxWVJ6jDZq+TzLK2JhAvpM04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762358428; c=relaxed/simple;
	bh=QDwOSjuGqHxR2tFeoqzVBgZh1UGkHD1E/jr70OrfSUk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=STsMV3svT5ubtREqOR13NYuM5ErNDUJbPZKLg4VEd+54En+/cmh6yaTSzOXzwJDt9wv+QBKFvSw63UvRxl1ya3/F3Jeh0tzpHWPaSC8aIIklnnoMqc/tzAo7gQLVWNd+/8300Lu1Ey7H7TP/3pSd8LdtKfcj1N+qIRYKBl4bvEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q1GS72Zr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 136E6C4CEF5;
	Wed,  5 Nov 2025 16:00:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762358428;
	bh=QDwOSjuGqHxR2tFeoqzVBgZh1UGkHD1E/jr70OrfSUk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Q1GS72ZrJB/rCT58NrVsIO4qtyuJORUH/uYUgHdo+sAxAnoLzx+XEQD09lCsBMOva
	 KbToYUsKRdf2q7zftVuVYRyryuKXh8sFxWzhgcUQXCxB30k6WhlhrN+JjT4SSRgtiO
	 yZVi6pL5wjpizGVA1RREJodxsCOCi/nohp9RzwapEwZRuFE5B8vP0+SVFort/9hxv4
	 lres1KOI/G9SDk+j2ZVzJphk7YDRiPaH0JbNA1NH+IO+v/LnAfLOalZGTIZ1pLwBUB
	 BetfVd56FBVOR0yOCNM9F75HZBYeWFAccJcdWAu/7JnblMbBIrfhuRdrDBF8iO5O6U
	 CtNdDZdo+BYKg==
Message-ID: <1f6c7144-9b4e-4252-b62e-71c348f11827@kernel.org>
Date: Wed, 5 Nov 2025 10:00:25 -0600
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] ACPI: CPPC: Fixes to limit actions to online CPUs
To: "Gautham R. Shenoy" <gautham.shenoy@amd.com>,
 "Rafael J . Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
 Yunhui Cui <cuiyunhui@bytedance.com>, Jeremy Linton <jeremy.linton@arm.com>,
 Viresh Kumar <viresh.kumar@linaro.org>,
 Ionela Voinescu <ionela.voinescu@arm.com>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
 Christopher Harris <chris.harris79@gmail.com>, linux-pm@vger.kernel.org
References: <20251105143851.4251-1-gautham.shenoy@amd.com>
Content-Language: en-US
From: "Mario Limonciello (AMD) (kernel.org)" <superm1@kernel.org>
In-Reply-To: <20251105143851.4251-1-gautham.shenoy@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 11/5/2025 8:38 AM, Gautham R. Shenoy wrote:
> Hello,
> 
> Christopher Harris reported a regression between v6.10 to v6.11 that
> the amd-pstate driver failed to load even when the commandline had
> "amd_pstate=passive"
> (https://lore.kernel.org/lkml/CAM+eXpdDT7KjLV0AxEwOLkSJ2QtrsvGvjA2cCHvt1d0k2_C4Cw@mail.gmail.com/)
> 
> On debugging the issue it was observed that when the commandline
> contains "nosmt=force", the CPPC code fails when performing certain
> checks such as checking for the presence of preferred cores and
> validity of the _CPC object since it iterates through all "present"
> CPUs while the object state was populated only for "online" CPUs.
> 
> This patchset contains fixes to address this issue.
> 
> The first two patches in the series address the issue reported by
> Chris.
> 
> Patches 3 and 4 harden the code in a couple of more functions which
> iterated through the present CPUs when it is more apt to restrict the
> operations to online CPUs
> 
> 
> 
> Gautham R. Shenoy (4):
>    ACPI: CPPC: Detect preferred core availability on online CPUs
>    ACPI: CPPC: Check _CPC validity for only the online CPUs
>    ACPI: CPPC: Perform fast check switch only for online CPUs
>    ACPI: CPPC: Limit perf ctrs in PCC check only to online CPUs
> 
>   arch/x86/kernel/acpi/cppc.c | 2 +-
>   drivers/acpi/cppc_acpi.c    | 6 +++---
>   2 files changed, 4 insertions(+), 4 deletions(-)
> 

The series looks good to me.

Reviewed-by: Mario Limonciello (AMD) <superm1@kernel.org>

But I would say I noticed we are also using for_each_present_cpu() in 
amd-pstate with amd_pstate_change_mode_without_dvr_change().

Should that also get a similar change?

