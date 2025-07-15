Return-Path: <linux-acpi+bounces-15167-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C5043B05F48
	for <lists+linux-acpi@lfdr.de>; Tue, 15 Jul 2025 16:04:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CE81B1C4006E
	for <lists+linux-acpi@lfdr.de>; Tue, 15 Jul 2025 13:55:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCDCA2ECE91;
	Tue, 15 Jul 2025 13:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="K9bAKDmQ"
X-Original-To: linux-acpi@vger.kernel.org
Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 344E72ECE87;
	Tue, 15 Jul 2025 13:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752587172; cv=none; b=ge8wkEagtRSn3wLV2V/NfkorWytpGOwx2qkZ7X4yblpnxYQHs6xI96f+lRd92TlsktcCsVaJi4Cg17eUSQdwBuf6eibobpbeyb3jcV72epYGbzIrdmhK5mn9de37q5uScOWEVg6KDIK0dbdK3XHgrVi6dEhpUBhr7LvDTDM3QtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752587172; c=relaxed/simple;
	bh=ictygKc7JXDJwFnlUkhwxhLUlFLLZwMiK2g5NCq5k2o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=T7MQZDTU2qPzuOr9/C3fma5NvWGjuByvHAmqT5aYpsZ9Qq9YwlKAYdtiD2/p6weXr8nk4FVulhgduuCLJUMCylBcUsO2a5NL7VD4WSJS0krYzx5QPD1H2N0FFqyAUQPPPcQ3kcNgmAie0X7lNNugh0ByZ+0texMo0DI/0kU4K5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=K9bAKDmQ; arc=none smtp.client-ip=115.124.30.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1752587166; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=oGFXX7NuuNLNV+eZBHSE7PUrb+VhWWLJAcVsJrsbXgk=;
	b=K9bAKDmQCvVB5CTjXW9JsaJUtJlpKiyGJIBTeBKR7aX5FtXljDB70ZR5Qs/f/JT7fNgKDvA5e8d/nQI+24lAQTyZ7EOCwtP+s3HtOku7HFjdySgGrpZxTNYx/jTle1GLeJC4HNwG2obMnZaTT18ZgKdLVUAMIux2nXPo5BJtNfU=
Received: from 30.246.162.71(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0Wj0gJ8-_1752587163 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 15 Jul 2025 21:46:04 +0800
Message-ID: <68b6961c-4443-48a8-a7f7-ed94f3352d7d@linux.alibaba.com>
Date: Tue, 15 Jul 2025 21:46:03 +0800
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ghes: Track number of recovered hardware errors
To: Borislav Petkov <bp@alien8.de>, Breno Leitao <leitao@debian.org>,
 Alexander Graf <graf@amazon.com>,
 Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
 Peter Gonda <pgonda@google.com>, "Luck, Tony" <tony.luck@intel.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
 James Morse <james.morse@arm.com>, "Moore, Robert" <robert.moore@intel.com>,
 "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "acpica-devel@lists.linux.dev" <acpica-devel@lists.linux.dev>,
 "kernel-team@meta.com" <kernel-team@meta.com>
References: <20250714-vmcore_hw_error-v1-1-8cf45edb6334@debian.org>
 <20250714171040.GOaHU6EKH2xxSZFnZd@fat_crate.local>
 <SJ1PR11MB6083C38E6DA922E05E1748D6FC54A@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <20250714173556.GQaHU__LL6IUIPCDIW@fat_crate.local>
 <aHWC-J851eaHa_Au@agluck-desk3>
 <20250715082939.GAaHYRc3Yn49jyvYzc@fat_crate.local>
 <kyprjdilgyz3xgw3slnrsemptnpp6h75mipv6a3lgp2dmwqekg@s7azbepy7nu2>
 <20250715103125.GFaHYt_TnFQW6ti0ST@fat_crate.local>
 <vs5x5qvw2veurxdljmdiumqpseze2myx6quw3rmt7li7d3dbin@duoky4z44zzz>
 <20250715125327.GGaHZPRz9QLNNO-7q8@fat_crate.local>
From: Shuai Xue <xueshuai@linux.alibaba.com>
In-Reply-To: <20250715125327.GGaHZPRz9QLNNO-7q8@fat_crate.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/7/15 20:53, Borislav Petkov 写道:
> On Tue, Jul 15, 2025 at 05:02:39AM -0700, Breno Leitao wrote:
>> Hello Borislav,
>>
>> On Tue, Jul 15, 2025 at 12:31:25PM +0200, Borislav Petkov wrote:
>>> On Tue, Jul 15, 2025 at 03:20:35AM -0700, Breno Leitao wrote:
>>>> For instance, If every investigation (as you suggested above) take just
>>>> a couple of minutes, there simply wouldn’t be enough hours in the day,
>>>> even working 24x7, to keep up with the volume.
>>>
>>> Well, first of all, it would help considerably if you put the use case in the
>>> commit message.
>>
>> Sorry, my bad. I can do better if we decide that this is worth pursuing.
>>
>>> Then, are you saying that when examining kernel crashes, you don't look at
>>> I find that hard to believe.
>>
>> We absolutely do examine kernel messages when investigating crashes, and
>> over time we've developed an extensive set of regular expressions to
>> identify relevant errors.
>>
>> In practice, what you're describing is very similar to the workflow we
>> already use. For example, here are just a few of the regex patterns we
>> match in dmesg, grouped by category:
>>
>>      (r"Machine check: Processor context corrupt", "cpu"),
>>      (r"Kernel panic - not syncing: Panicing machine check CPU died", "cpu"),
>>      (r"Machine check: Data load in unrecoverable area of kernel", "memory"),
>>      (r"Instruction fetch error in kernel", "memory"),
>>      (r"\[Hardware Error\]: +section_type: memory error", "memory"),
>>      (r"EDAC skx MC\d: HANDLING MCE MEMORY ERROR", "memory"),
>>      (r"\[Hardware Error\]:   section_type: general processor error", "cpu"),
>>      (r"UE memory read error on", "memory"),
>>
>> And that’s just a partial list. We have 26 regexps for various issues,
>> and I wouldn’t be surprised if other large operators use a similar
>> approach.
>>
>> While this system mostly works, there are real advantages to
>> consolidating this logic in the kernel itself, as I’m proposing:
>>
>>      * Reduces the risk of mistakes
>>      	- Less chance of missing changes or edge cases.
>>
>>      * Centralizes effort
>> 	- Users don’t have to maintain their own lists; the logic lives
>> 	  closer to the source of truth.
>>
>>      * Simplifies maintenance
>> 	- Avoids the constant need to update regexps if message strings
>> 	  change.
>>
>>      * Easier validation
>> 	- It becomes straightforward to cross-check that all relevant
>> 	  messages are being captured.
>>
>>      * Automatic accounting
>> 	- Any new or updated messages are immediately reflected.
>>
>>      * Lower postmortem overhead
>> 	- Requires less supporting infrastructure for crash analysis.
>>
>>      * Netconsole support
>> 	- Makes this status data available via netconsole, which is
>> 	  helpful for those users.
> 
> Yap, this is more like it. Those sound to me like good reasons to have this
> additional logging.
> 
> It would be really good to sync with other cloud providers here so that we can
> do this one solution which fits all. Lemme CC some other folks I know who do
> cloud gunk and leave the whole mail for their pleasure.
> 
> Newly CCed folks, you know how to find the whole discussion. :-)
> 
> Thx.


For the purpose of counting, how about using the cmdline of rasdaemon?

$ ras-mc-ctl --summary
Memory controller events summary:
         Uncorrected on DIMM Label(s): 'SOCKET 1 CHANNEL 1 DIMM 0 DIMM1' 
location: 0:18:-1:-1 errors: 1

PCIe AER events summary:
         2 Uncorrected (Non-Fatal) errors: Completion Timeout

ARM processor events summary:
         CPU(mpidr=0x81090100) has 1 errors
         CPU(mpidr=0x810e0000) has 1 errors
         CPU(mpidr=0x81180000) has 1 errors
         CPU(mpidr=0x811a0000) has 1 errors
         CPU(mpidr=0x811c0000) has 1 errors
         CPU(mpidr=0x811d0300) has 1 errors
         CPU(mpidr=0x811f0100) has 1 errors
         CPU(mpidr=0x81390300) has 1 errors
         CPU(mpidr=0x813a0200) has 1 errors

No devlink errors.
Disk errors summary:
         0:0 has 60 errors
         0:2048 has 7 errors
         0:66304 has 2162 errors
Memory failure events summary:
         Recovered errors: 24

@Breno, Is rasdaemon not enough for your needs?


AFAICS, it is easier to extend more statistical metrics, like PR 205 
[1]. Also, it is easier to carry out releases and changes than with the 
kernel in the production environment.


Thanks.
Shuai

[1] 
https://github.com/mchehab/rasdaemon/pull/205/commits/391d67bc7d17443d00db96850e56770451126a0e


