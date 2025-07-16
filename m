Return-Path: <linux-acpi+bounces-15175-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 52656B06BDD
	for <lists+linux-acpi@lfdr.de>; Wed, 16 Jul 2025 05:04:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 688F13B5253
	for <lists+linux-acpi@lfdr.de>; Wed, 16 Jul 2025 03:04:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D684027586E;
	Wed, 16 Jul 2025 03:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="FOQ+HQqG"
X-Original-To: linux-acpi@vger.kernel.org
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55D21275118;
	Wed, 16 Jul 2025 03:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752635078; cv=none; b=mCCKnAY/q+JYwFGa0LbWlw8UY3LNHZINZzDR1UUEA0Fe6drI9xEgAo6V/IWCusMNOVonxreiyvANVoNlZy86XW07o57wkYId1jZqv0P4OzBwrXYBNXKxJGlVYQQrI1evicAvoMAZ0gq00KgM0ORe/FhhHO51I1buYxw2dasTAwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752635078; c=relaxed/simple;
	bh=ghDhaR0c6hTsusUYN/do7KgBwZkbeEBUhV5TVSwbOuM=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=R4n2LMUNU/otccOyLDb+C387K7nL/Ntc/4a8z38yCW5FY/9QGcOBdDgbClVMPN2lQGyJleDRqXPZi6ip79T/wnL2hGPQVMqMDJYGGlj3QQw2db392IKzeWWM4YXwgCg1mylUY0qYO1TTX0PN3cAmz91qLZpVHym2mq4xj5xOejw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=FOQ+HQqG; arc=none smtp.client-ip=115.124.30.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1752635071; h=Message-ID:Date:MIME-Version:From:Subject:To:Content-Type;
	bh=bz/gT2zU2lHgaYtQPft6aSJWRjBtEX5KzBsJPznda0c=;
	b=FOQ+HQqGkgI/n59A9mF6LN+bPGDKgk9RHF9mDliwuf8HfYpdqA7CQyTu31mbJUdeMgdy6rSpyfacBenQc4rrWKGn6LOZZNwJRGmi5vpzpfGb+YcZRYxO0x//oZ8tiPpcsSTGJZZyeZV7enWN7UOLcR+J4a+B5hg0HiRnekJBHY0=
Received: from 30.246.162.71(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0Wj2Cz4n_1752635068 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 16 Jul 2025 11:04:29 +0800
Message-ID: <b4c39a87-c5a4-4525-b598-61fc28a8dc36@linux.alibaba.com>
Date: Wed, 16 Jul 2025 11:04:28 +0800
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Shuai Xue <xueshuai@linux.alibaba.com>
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
References: <20250714171040.GOaHU6EKH2xxSZFnZd@fat_crate.local>
 <SJ1PR11MB6083C38E6DA922E05E1748D6FC54A@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <20250714173556.GQaHU__LL6IUIPCDIW@fat_crate.local>
 <aHWC-J851eaHa_Au@agluck-desk3>
 <20250715082939.GAaHYRc3Yn49jyvYzc@fat_crate.local>
 <kyprjdilgyz3xgw3slnrsemptnpp6h75mipv6a3lgp2dmwqekg@s7azbepy7nu2>
 <20250715103125.GFaHYt_TnFQW6ti0ST@fat_crate.local>
 <vs5x5qvw2veurxdljmdiumqpseze2myx6quw3rmt7li7d3dbin@duoky4z44zzz>
 <20250715125327.GGaHZPRz9QLNNO-7q8@fat_crate.local>
 <68b6961c-4443-48a8-a7f7-ed94f3352d7d@linux.alibaba.com>
 <p2iytcdfvgm74zif6ihd7gs4kuaeza4b4p52cr5ya4upabiome@kr3yy7fjznwe>
In-Reply-To: <p2iytcdfvgm74zif6ihd7gs4kuaeza4b4p52cr5ya4upabiome@kr3yy7fjznwe>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/7/16 01:25, Breno Leitao 写道:
> Hello Shuai,
> 
> On Tue, Jul 15, 2025 at 09:46:03PM +0800, Shuai Xue wrote:
>>> It would be really good to sync with other cloud providers here so that we can
>>> do this one solution which fits all. Lemme CC some other folks I know who do
>>> cloud gunk and leave the whole mail for their pleasure.
>>>
>>> Newly CCed folks, you know how to find the whole discussion. :-)
>>>
>>> Thx.
>>
>>
>> For the purpose of counting, how about using the cmdline of rasdaemon?
> 
> How do you manage it at a large fleet of hosts? Do you have rasdaemon
> logging always and how do you correlate with kernel crashes? At Meta, we
> have an a "clues" tag for each crash, and one of the tags is Machine
> Check Exception (MCE), which is parsed from dmesg right now (with the
> regexp I shared earlier).

We deploy rasdaemon on each individual node, and then collect the
rasdaemon logs centrally. At the same time, we collect out-of-band
error logs. We aggregate and count the types and occurrences of errors,
and finally use empirical thresholds for operational alerts. The crash
analysis service consumes these alert messages.

> 
> My plan with this patch is to have a counter for hardware errors that
> would be exposed to the crashdump. So, post-morten analyzes tooling can
> easily query if there are hardware errors and query RAS information in
> the right databases, in case it seems a smoking gun.

I see your point. But does using a single ghes_recovered_errors counter
to track all corrected and non-fatal errors for CPU, memory, and PCIe
really help?

> 
> Do you have any experience with this type of automatic correlation?

Please see my reply above.

> 
> Thanks for your insights,
> --breno

Thanks.
Shuai


