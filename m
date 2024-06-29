Return-Path: <linux-acpi+bounces-6674-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CBE6B91CB28
	for <lists+linux-acpi@lfdr.de>; Sat, 29 Jun 2024 07:04:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0AB8B1C20EA2
	for <lists+linux-acpi@lfdr.de>; Sat, 29 Jun 2024 05:04:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8271A18EAB;
	Sat, 29 Jun 2024 05:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="Z7bjp8LG"
X-Original-To: linux-acpi@vger.kernel.org
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24E3D1878;
	Sat, 29 Jun 2024 05:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719637446; cv=none; b=KQI/Dwr+iIEQ38fNb7KKjNFVWrD2/SJGXwY8EqM68fQhBaevfJUn+0GHE5gzwMeiPrY9x0FWAMWDAUsDYnTyuugIKEvltSrkKX0bPtw0hhuTqVEC62ckaDwO4tut8eNP0ex72dqdAOCZnodEkF85koYKbkjWK9cTkEAJBSj9u0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719637446; c=relaxed/simple;
	bh=Ew3CzrP4sds7rkfWAmQRF2bIaPS0r7QoSeNAlsAKIvI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iFapu9I5FPIM4ZTn6U+TuqU2aPTmpjvBHTggGxhq/7J8UwV8pVigjLeK+elff+SHAiDaPBaRRoF4E+HJ3ipXMmnPb2UHFH4qdW8KsXQUwi1msmwsrxvnFnOg55shJrSJj0gGd1WHw5OpcQEDGwvZrA2cwl8LfbLWWpu2Rt2JgUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=Z7bjp8LG; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:From:Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:
	Content-Type:Content-Transfer-Encoding:Content-ID:Content-Description:
	In-Reply-To:References; bh=oPJwtSUem7PZa4g8UE7kzgB6Pml8aKz79buErMxrQ74=;
	t=1719637444; x=1720069444; b=Z7bjp8LG65/VL36YFcuh+4PWIi14bsC8cb7zao98EFTDFyH
	cXc2ufpqXvpE4qi1JbsTZvd/8MWYcq9TZ86qm3cD3vLjIWeViSeiV40CWWlySX3wovRxEfHwpi2nJ
	+WL1C0KFEzfV8kTKw+3Z1Ta0MP0Y9ok4cSkLV63cCqLurCCuwhv6iWALAEDllpLorApVQW6Huocbr
	VaT5ZSpI20Q1e+r91ZQUu3EfuzipSy34dpl7GQ/ZnT3USFiPX0mJCKtamdHwlrnOUP5LySp96Xbc7
	l9wT3uEuaL/mUEseNWH5lAqBk2pO6FquDR9BsCWlHCJDGJQNzNnDsMH6r6dUqmLg==;
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1sNQFk-0003YK-DT; Sat, 29 Jun 2024 07:04:00 +0200
Message-ID: <c6f4cca2-9258-4dc9-8d4e-96ab7c587783@leemhuis.info>
Date: Sat, 29 Jun 2024 07:03:59 +0200
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] lib/sort: Optimize heapsort with double-pop variation
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: akpm@linux-foundation.org, jserv@ccns.ncku.edu.tw,
 linux-kernel@vger.kernel.org, lkml@sdf.org, alexdeucher@gmail.com,
 Julian Sikorski <belegdol@gmail.com>,
 ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
 Kuan-Wei Chiu <visitorckw@gmail.com>,
 Linux regressions mailing list <regressions@lists.linux.dev>
References: <20240113031352.2395118-3-visitorckw@gmail.com>
 <70674dc7-5586-4183-8953-8095567e73df@gmail.com>
 <61f43bdd-7f73-4605-96e7-843483a53bca@leemhuis.info>
 <Zn7umr/VHtZ/Nhcu@visitorckw-System-Product-Name>
From: "Linux regression tracking (Thorsten Leemhuis)"
 <regressions@leemhuis.info>
Content-Language: en-US, de-DE
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
In-Reply-To: <Zn7umr/VHtZ/Nhcu@visitorckw-System-Product-Name>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1719637444;c90b5135;
X-HE-SMSGID: 1sNQFk-0003YK-DT

On 28.06.24 19:10, Kuan-Wei Chiu wrote:
> On Fri, Jun 28, 2024 at 05:15:15PM +0200, Linux regression tracking (Thorsten Leemhuis) wrote:
>> On 20.06.24 17:36, Julian Sikorski wrote:
>>>
>>> it appears that this patch has caused suspend-to-idle regression:
>>>
>>> https://gitlab.freedesktop.org/drm/amd/-/issues/3436
>>>
>>> In brief, my laptop fails to suspend completely with the following error
>>> in the log:
>>>
>>> Jun 18 12:42:20 kernel: amd_pmc AMDI0005:00: Last suspend didn't reach
>>> deepest state
>>>
>>> Power consumption remains high enough that my battery has already
>>> unexpectedly drained twice before I noticed something was off.
>>> I am not entirely sure how changes to sorting function can influence
>>> suspend, but it is what it is. 6.9.5 as shipped by Fedora 40 exhibits
>>> the issue, 6.9.5 as shipped by Fedora with the patch reverted does not.
> [...]
> I apologize for the regression caused by the patch. I am not familiar
> with the power management domain. I would guess there might be some
> side effects in the compare or swap functions that I was not aware of.
> 
> While reviewing the sort calls that could potentially cause the error,
> I noticed that the compare function used in the sort call within
> drivers/acpi/processor_idle.c might not satisfy the transitive
> relation. Although I'm not sure if this is the root cause of the
> problem, specifically, if there are two valid acpi_processor_cx
> elements A and B, and an invalid element C, there could be a scenario
> where A < B but simultaneously A = C and B = C.

Let's bring in Rafael, he might be able to help us out here.

> However, if I
> understand correctly, this issue should have existed before this patch
> but might not have been triggered previously. My patch might have
> exposed this issue by changing the order of comparisons and swaps.

Yeah, these things happen. But when it comes to the Linux kernel's "no
regressions" rule that does not matter much; what matters more is which
change exposed the problem.

Ciao, Thorsten

