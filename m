Return-Path: <linux-acpi+bounces-20826-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YOkaFC5RgWmLFgMAu9opvQ
	(envelope-from <linux-acpi+bounces-20826-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Tue, 03 Feb 2026 02:36:46 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DD510D36C7
	for <lists+linux-acpi@lfdr.de>; Tue, 03 Feb 2026 02:36:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DB0763011879
	for <lists+linux-acpi@lfdr.de>; Tue,  3 Feb 2026 01:36:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D47E2741AC;
	Tue,  3 Feb 2026 01:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RLv93Bw6"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-yx1-f49.google.com (mail-yx1-f49.google.com [74.125.224.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 749E8242D7D
	for <linux-acpi@vger.kernel.org>; Tue,  3 Feb 2026 01:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770082580; cv=none; b=o9/k2sxFL5uoCKgLnHGMTzOjtfsOYXnoKbs2r7Wgufj7tmn4D8jlD1TQOf0UdyRaZQe0ns/OvlioMXNOUkAPfLHyRFNgQGkyUWjvCTqBkbL+8k7COhsg28vbcrCfkbsy8EIlI5IzkLq2dGLvsmvnZqROAhXhEPOtgI8tUWlxbfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770082580; c=relaxed/simple;
	bh=2X+mytXBtNSV0apIC0KsjvAvt2VlH2ZbcBkfrYklwOs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PqUlADEWIdsnCQbvSFnwb5PgC6Y24d8WqtMRsXBdKrUPpUXmYgKc8vfVEyBTtCfcZT4RaA8xJVyvEezTKnrGWSAQ7uHmnj6YoEaNB+0n4vd915w/f8U6pZuFu4XD7XlK6OERgehBBOtOLNznmYC9Oq4YrOkPMqV3epbb+pGRBrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RLv93Bw6; arc=none smtp.client-ip=74.125.224.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f49.google.com with SMTP id 956f58d0204a3-64938fce805so4547889d50.1
        for <linux-acpi@vger.kernel.org>; Mon, 02 Feb 2026 17:36:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770082578; x=1770687378; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IDGINNniODK4Zc3R8bth6pqq7qdppNjLL1gm7R6GyLM=;
        b=RLv93Bw6xpk89FZZDN9UOJBCxmu+ZX80fcvlX6bt8TqwUJTiClbdTH5AQD8E5w77/G
         EmANL4xl7htJb2EnggaR7Oey2IPQHsNxiJhn/qp1wRaN4TL9cFC2IaOwf80olBg7wgED
         Fl89qLbZ+dHAAjGRgL4KqL+UdRcPIWczq0jHo9rwVw4NVl6hy5Uon8bpCNIWOpXvn29N
         WYjhEg/iODYyxI4+zhoKTRsfw/GW7YfvfiamnYtVLIghpvMDOOyy6t+MJXT4cxjcPwkD
         KdiNUwbAjbe3Ea7Ku9JdabafkB+05C/KwUceMICFVY9+a40saVM2iBZ4/xO44EPHXENN
         nrfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770082578; x=1770687378;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IDGINNniODK4Zc3R8bth6pqq7qdppNjLL1gm7R6GyLM=;
        b=CJOzE0b/aA7ZVK4PcjHtd//0+rRUzroMOIJHtAJ/CrM3CDUHOwdxh/HrJkmTBGukIH
         yatIYiwpjIwj42sELKEZFmIXwKrnEu1q1HJj2oMLvFufNDUlMMW9GKfTpzaHQ7p8vloy
         nns6Sroh+n+eQCPJ4WW9ZWIylJdJp/s+oLi0VxqOxyUL13hp13/s+czzDeHuh4OtawSG
         Anvt7DTZaTquX1eSPv5sKKu6sVjVo7urhaOM5oEMnO0hdwO3XtRqmquGuCsNwaKb7O5q
         165Olis5W6snA+zlzQoAYKje2bHViCpyPiy3zjFXved6pH+GCj6R5xfjsm4lz6reAv5b
         jzYw==
X-Forwarded-Encrypted: i=1; AJvYcCUq6mxEWuzK+WxMWFD2SsTLyvelwPu9J+MNhCoVGbzmL0zagtO7N7FiBIf8sebL3atfxMeNMVbBPKIa@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6kHgDkwmJ50JM5TpgLfLHDgUzbYf+Ch4XUO12/IWfAf1FzpVK
	bDwq/fH8kMwY+6OiSxDfEQLd2h6jkAOdPDpcrgfQJyOhZ5PW7InpIJ8S
X-Gm-Gg: AZuq6aIucA7aruIhPh1qjKz8QlQa97mE/lmVI3LANeMm70jrcLn6asWl1B5MuV4wFK/
	Zp1Oq1Yzw+dr0FZX4rv1FmDi2P+kWTyhFLDx2fyAn5oeYDZdMqrivK85ZaATPhP5I+CEIxdg+HL
	n34W3edVfMJvH0NoeulpOXiAwPaG4HQghYZgv1TfEU+utrQ5YxibwT/BzJ8p6Ce+Dm9LnDTT3wT
	QaYyMi4qnl2qW0SRKfObZg2ZLR5/WJtxRjKNguQs0ns3bfwASJWRV6JzwblwGn7/LpZKYGxEJcQ
	uLwt7p2ktUsoPPdsV0UXL9meT+wRcep3jb3b+9PIM+t0hVn2HH71LFIHvPhL6zMyp+suquBQneZ
	0pMBz5hMZkmzXc9jaJX7I6p+sv8wfi2vPRqhrL2Rjxd32UB4vkVNELdW16sQ96WJ5/bLO5TXRQ3
	mCXXjjke6c+YtdAxM5f08g1wEOQ25usSRgGWhbdw==
X-Received: by 2002:a05:690e:408e:b0:649:523d:e701 with SMTP id 956f58d0204a3-649a852de09mr10271339d50.92.1770082578400;
        Mon, 02 Feb 2026 17:36:18 -0800 (PST)
Received: from ?IPV6:2600:6c56:7d00:582f::64e? ([2600:6c56:7d00:582f::64e])
        by smtp.googlemail.com with ESMTPSA id 956f58d0204a3-649d447df2bsm423325d50.4.2026.02.02.17.36.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Feb 2026 17:36:17 -0800 (PST)
Message-ID: <74f3e6cf-7c13-43e6-a8f6-2b46184b8ad6@gmail.com>
Date: Mon, 2 Feb 2026 19:36:14 -0600
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 4/7] ACPI: CPPC: add APIs and sysfs interface for
 min/max_perf
To: Sumit Gupta <sumitg@nvidia.com>, "zhenglifeng (A)"
 <zhenglifeng1@huawei.com>, pierre.gondois@arm.com
Cc: rafael@kernel.org, viresh.kumar@linaro.org, ionela.voinescu@arm.com,
 lenb@kernel.org, robert.moore@intel.com, corbet@lwn.net,
 rdunlap@infradead.org, ray.huang@amd.com, gautham.shenoy@amd.com,
 mario.limonciello@amd.com, perry.yuan@amd.com, zhanjie9@hisilicon.com,
 linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org,
 linux-doc@vger.kernel.org, acpica-devel@lists.linux.dev,
 linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
 treding@nvidia.com, jonathanh@nvidia.com, vsethi@nvidia.com,
 ksitaraman@nvidia.com, sanjayc@nvidia.com, nhartman@nvidia.com,
 bbasu@nvidia.com
References: <20260129104817.3752340-1-sumitg@nvidia.com>
 <20260129104817.3752340-5-sumitg@nvidia.com>
 <4432fa04-e67c-422a-aae4-2938be431985@huawei.com>
 <c96312c7-b13f-4f5c-9512-cc0382c1c77b@nvidia.com>
Content-Language: en-US
From: Russell Haley <yumpusamongus@gmail.com>
In-Reply-To: <c96312c7-b13f-4f5c-9512-cc0382c1c77b@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20826-lists,linux-acpi=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[28];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yumpusamongus@gmail.com,linux-acpi@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-acpi];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: DD510D36C7
X-Rspamd-Action: no action

On 1/31/26 7:58 AM, Sumit Gupta wrote:
> 
> On 31/01/26 09:36, zhenglifeng (A) wrote:
>> External email: Use caution opening links or attachments
>>
>>
>> Hi Sumit,
>>
>> I am thinking that maybe it is better to call these two sysfs interface
>> 'min_freq' and 'max_freq' as users read and write khz instead of raw
>> value.
> 
> Thanks for the suggestion.
> Kept min_perf/max_perf to match the CPPC register names
> (MIN_PERF/MAX_PERF), making it clear to users familiar with
> CPPC what's being controlled.
> The kHz unit is documented in the ABI.
> 
> Thank you,
> Sumit Gupta

On my x86 machine with kernel 6.18.5, the kernel is exposing raw values:

> grep . /sys/devices/system/cpu/cpu0/acpi_cppc/*
/sys/devices/system/cpu/cpu0/acpi_cppc/feedback_ctrs:ref:342904018856568
del:437439724183386
/sys/devices/system/cpu/cpu0/acpi_cppc/guaranteed_perf:63
/sys/devices/system/cpu/cpu0/acpi_cppc/highest_perf:88
/sys/devices/system/cpu/cpu0/acpi_cppc/lowest_freq:0
/sys/devices/system/cpu/cpu0/acpi_cppc/lowest_nonlinear_perf:36
/sys/devices/system/cpu/cpu0/acpi_cppc/lowest_perf:1
/sys/devices/system/cpu/cpu0/acpi_cppc/nominal_freq:3900
/sys/devices/system/cpu/cpu0/acpi_cppc/nominal_perf:62
/sys/devices/system/cpu/cpu0/acpi_cppc/reference_perf:62
/sys/devices/system/cpu/cpu0/acpi_cppc/wraparound_time:18446744073709551615

It would be surprising for a nearby sysfs interface with very similar
names to use kHz instead.

Thanks,

Russell Haley

