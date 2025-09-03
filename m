Return-Path: <linux-acpi+bounces-16305-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69B40B414B8
	for <lists+linux-acpi@lfdr.de>; Wed,  3 Sep 2025 08:11:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4AE25166F94
	for <lists+linux-acpi@lfdr.de>; Wed,  3 Sep 2025 06:11:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5D3B2D73A3;
	Wed,  3 Sep 2025 06:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OhG5GB8k"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6977014A9B;
	Wed,  3 Sep 2025 06:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756879884; cv=none; b=Zgzdbz6ipTNQqxQhNpB/yv5prUeNfNYtUesg/g98hcy35PtrkB9/ldfp7JcgkPDQgKCKvh/AehNLpRePni4mIQSNDwTRrxphHEp/WRQ7PEZO3m8A8q35zNNpLkv7we1vOOD9tq+y/NYq28Qh0am5miBExgCSmgTl9ZKG2o/pqiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756879884; c=relaxed/simple;
	bh=DEWGVqilbGOs6UgUqJ9p5sDy7a3JODRL7uL+KLdqaDM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OPnVd3hRkVLVhRB/XvU8TtxT8JJhKuRF7IMLT+GLHTxTKQ2ft66vlUdG4xTSq1CJarohMPt/bQ3CgZNZNSRfluRDWiP7D9CrPG+Jn5QwIcmWXw/aDoIpv1pDYJclMI/pAo2/T7N1PEHLhhzfDCt9xmYKl1Jr+m21yWZn3dHxOqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OhG5GB8k; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2C74C4CEF0;
	Wed,  3 Sep 2025 06:11:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756879884;
	bh=DEWGVqilbGOs6UgUqJ9p5sDy7a3JODRL7uL+KLdqaDM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=OhG5GB8keEQ58YNgxAI/Sjc1rocLhOfxCLl/XZwlEzS1WCwat/fRihODLk7ZhvcWr
	 H3XYzOgamWZw2UP1IcvzjzFaTBdCBESmwBjW57Q0I4QlZ/cxF1rW0y5KmmG5aM1SZs
	 0uwLCKpyV6hM1ZLubZDbjoGbQOQY4z6fZm3zXiREW8Xa2eaDBHXBu8+MrVOXj9aNfo
	 pqJnCWRxzZG176Yw/RX5egzLS+IB1ebxgjYZCtkELZ6V0YgtZVtdAYK9klO4OCqnRM
	 DQ1ON/yN8nE1oOUXnkRR5ccXnOp7joOzEV/f+6jB4MMYU965FZbZcYRzziTXfVhat1
	 LzBIkLuy7dzZg==
Message-ID: <04ca5584-b10e-465d-bbda-627b7f743ce9@kernel.org>
Date: Wed, 3 Sep 2025 08:11:12 +0200
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 12/12] PM: EM: Use scope-based cleanup helper
To: Zihuan Zhang <zhangzihuan@kylinos.cn>
Cc: airlied@gmail.com, alim.akhtar@samsung.com, beata.michalska@arm.com,
 ben.horgan@arm.com, bp@alien8.de, catalin.marinas@arm.com,
 cw00.choi@samsung.com, daniel.lezcano@kernel.org,
 dave.hansen@linux.intel.com, dri-devel@lists.freedesktop.org,
 edubezval@gmail.com, festevam@gmail.com, imx@lists.linux.dev,
 intel-gfx@lists.freedesktop.org, j-keerthy@ti.com,
 jani.nikula@linux.intel.com, kernel@pengutronix.de,
 kyungmin.park@samsung.com, lenb@kernel.org, linux-acpi@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-omap@vger.kernel.org, linux-pm@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, lukasz.luba@arm.com, mpe@ellerman.id.au,
 myungjoo.ham@samsung.com, pavel@kernel.org, ptsm@linux.microsoft.com,
 rafael@kernel.org, rodrigo.vivi@intel.com, rui.zhang@intel.com,
 s.hauer@pengutronix.de, shawnguo@kernel.org, simona@ffwll.ch,
 srinivas.pandruvada@linux.intel.com, sudeep.holla@arm.com,
 sumitg@nvidia.com, thierry.reding@gmail.com, tursulin@ursulin.net,
 viresh.kumar@linaro.org, will@kernel.org, yangyicong@hisilicon.com,
 zhenglifeng1@huawei.com
References: <b38e64cc-4971-4e71-931c-820453aa91a7@kernel.org>
 <20250903021230.1044454-1-zhangzihuan@kylinos.cn>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 a/A=
In-Reply-To: <20250903021230.1044454-1-zhangzihuan@kylinos.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 03/09/2025 04:12, Zihuan Zhang wrote:
>> You are not improving the source code here. This is not how to use
>>  __free() and you clearly do not understand the source code.
> 
> Sorry for the problem, policy should be assigned after cpumask_test_cpu().
> 
> I actually realized earlier that __free() only frees at the end of the variable’s lifetime. 
> I had suggested using a braced macro in cpufreq.h to allow immediate release after use, 
> but I understand the maintainer’s advice to “keep it simple” and will follow that.
> 
>> What's more, you did not use standard tools which would tell you this is
>> buggy and wrong.
> 
> Could you please let me know which standard tools you recommend for detecting such issues? 
> 
> I’d like to use them to avoid similar mistakes in the future.
All standard tools used for kernel development, sparse, smatch, clang,
coccinelle, see my talk from OSSE25.

Best regards,
Krzysztof

