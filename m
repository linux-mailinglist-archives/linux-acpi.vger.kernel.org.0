Return-Path: <linux-acpi+bounces-15208-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6937AB0832C
	for <lists+linux-acpi@lfdr.de>; Thu, 17 Jul 2025 05:04:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AC2FF7A62FB
	for <lists+linux-acpi@lfdr.de>; Thu, 17 Jul 2025 03:02:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E6F31C3F36;
	Thu, 17 Jul 2025 03:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="x7oG0JCb"
X-Original-To: linux-acpi@vger.kernel.org
Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A84A72E370C;
	Thu, 17 Jul 2025 03:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752721440; cv=none; b=fES/+M0eFxxiaF0ME4UCwh2Vw170RhggKR5RQ4UAIEHtpPrHADzjit5bFVP6XwZMvRGKYGZoiRbwwR3lxM9L1yk/cEqL157qpBjBlwnywxekrdKvJgZUWVwNyNQcVWm7G3n1kntH3SZi3B/Kz7WI9JlbxHIz7aFCMqJr/mjMFOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752721440; c=relaxed/simple;
	bh=MA7DhgnrHAFOSfD3Z71cnWoWC9q9bvXHQq62SUa7Hj8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kJTebhOMul5mURoN/5W0znVl1ZaB3oDWm1bCakLlZ4EPEGbqLqsv9aX+Rd6zWtL9zh0+/3yv2HiO54KnrwlWK3QCSLra3vzQIdK9gReT5k/sHjfHdnFm0WS7ew7b6Xo/85CyLMTpA5EAv1Gwmvj94MbSgkUq83Gse+iHr1MjIC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=x7oG0JCb; arc=none smtp.client-ip=115.124.30.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1752721434; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=y27C67f1ZvJH371/Jn25fxn30qg7QY+upPRPKPMQK4A=;
	b=x7oG0JCb/5z2EJl8yt/bopBChjZ9wgMCThaaG1/EziPWklUlAFv5yXDI4cFBCssGfSWn1X4xhgZ1Q70Pw0GfcVmGafsYYTuID6QhupwNEDNSmglXYMB6AOij2hj0nIvb6xkunxU1ldhEc+pbyJx9VjH7o16hPDs8buwjeK7zsOE=
Received: from 30.246.162.71(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0Wj6dHlv_1752721419 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 17 Jul 2025 11:03:51 +0800
Message-ID: <58f3242a-e52a-46a9-9a99-3887eeaa1285@linux.alibaba.com>
Date: Thu, 17 Jul 2025 11:03:51 +0800
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ghes: Track number of recovered hardware errors
To: Breno Leitao <leitao@debian.org>
Cc: Borislav Petkov <bp@alien8.de>, Alexander Graf <graf@amazon.com>,
 Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
 Peter Gonda <pgonda@google.com>, "Luck, Tony" <tony.luck@intel.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
 James Morse <james.morse@arm.com>, "Moore, Robert" <robert.moore@intel.com>,
 "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "acpica-devel@lists.linux.dev" <acpica-devel@lists.linux.dev>,
 "kernel-team@meta.com" <kernel-team@meta.com>
References: <20250714173556.GQaHU__LL6IUIPCDIW@fat_crate.local>
 <aHWC-J851eaHa_Au@agluck-desk3>
 <20250715082939.GAaHYRc3Yn49jyvYzc@fat_crate.local>
 <kyprjdilgyz3xgw3slnrsemptnpp6h75mipv6a3lgp2dmwqekg@s7azbepy7nu2>
 <20250715103125.GFaHYt_TnFQW6ti0ST@fat_crate.local>
 <vs5x5qvw2veurxdljmdiumqpseze2myx6quw3rmt7li7d3dbin@duoky4z44zzz>
 <20250715125327.GGaHZPRz9QLNNO-7q8@fat_crate.local>
 <68b6961c-4443-48a8-a7f7-ed94f3352d7d@linux.alibaba.com>
 <p2iytcdfvgm74zif6ihd7gs4kuaeza4b4p52cr5ya4upabiome@kr3yy7fjznwe>
 <b4c39a87-c5a4-4525-b598-61fc28a8dc36@linux.alibaba.com>
 <ckn7d3e3xynnup4bbombn7z7xxvld3a7xmqpg4pzp57qebywfc@t2yrn3zqmnje>
From: Shuai Xue <xueshuai@linux.alibaba.com>
In-Reply-To: <ckn7d3e3xynnup4bbombn7z7xxvld3a7xmqpg4pzp57qebywfc@t2yrn3zqmnje>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/7/16 20:42, Breno Leitao 写道:
> hello Shuai,
> 
> On Wed, Jul 16, 2025 at 11:04:28AM +0800, Shuai Xue wrote:
>>> My plan with this patch is to have a counter for hardware errors that
>>> would be exposed to the crashdump. So, post-morten analyzes tooling can
>>> easily query if there are hardware errors and query RAS information in
>>> the right databases, in case it seems a smoking gun.
>>
>> I see your point. But does using a single ghes_recovered_errors counter
>> to track all corrected and non-fatal errors for CPU, memory, and PCIe
>> really help?
> 
> It provides a quick indication that hardware issues have occurred, which
> can prompt the operator to investigate further via RAS events.
> 
> That said, Tony proposed a more robust approach—categorizing and
> tracking errors by their source. This would involve maintaining separate
> counters for each source using an counter per enum type:
> 
> 	enum recovered_error_sources {
> 		ERR_GHES,
> 		ERR_MCE,
> 		ERR_AER,
> 		...
> 		ERR_NUM_SOURCES
> 	};
> 
> See more at: https://lore.kernel.org/all/aHWC-J851eaHa_Au@agluck-desk3/
> 
> Do you think this would help you by any chance?
> 
> Thanks
> --breno


Personally, I think this approach would be more helpful. Additionally, I
suggest not mixing CEs (Correctable Errors) and UEs (Uncorrectable
Errors) together. This is especially important for memory errors, as CEs
occur much more frequently than UEs, but their impact is much smaller.

Thanks.
Shuai

