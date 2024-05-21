Return-Path: <linux-acpi+bounces-5910-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C10B98CB064
	for <lists+linux-acpi@lfdr.de>; Tue, 21 May 2024 16:26:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F86C2841C7
	for <lists+linux-acpi@lfdr.de>; Tue, 21 May 2024 14:26:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB5A812FF8E;
	Tue, 21 May 2024 14:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="rQ62mlwO"
X-Original-To: linux-acpi@vger.kernel.org
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA62976410;
	Tue, 21 May 2024 14:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716301600; cv=none; b=e+4dkdvmmRRX3F/2EX18tC/iMIg14JGfQOL9XVLEQm8MA0rpwkBSZsJeNDXFGPm6xaH91N5wngEaam1TpfhJAgP03VqCJibBxNg2EQXtPmC5LwMWS/GCAP+fMNTxo9zDuleejNdMyam8R7uuvz8GmwuO+uJCEBNcB46sy6MoT3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716301600; c=relaxed/simple;
	bh=aezd0TTdrfMJbiPLZd+W3AP1lc4sOj8uyi8Z1OsTQkM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=L2F+P19t2eEjlHL7SBCSfIwbqeGqp0AWTvr24OzQ2iwP8FrNl4BK8tsT0YKIJnKhKsVyD+9BrS3E5/K72eViZLuPpuHmFGYrgdKlXDFg3QtBjsdVuIZYrxRGH9T49k709VSFweq3I302Sbs4SnZuA1Lh0H2q0e7/vqcBm4R2ww4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=rQ62mlwO; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:From:Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:
	Content-Type:Content-Transfer-Encoding:Content-ID:Content-Description:
	In-Reply-To:References; bh=cUraUDEawq2r5fQTgzjxE+zRAfgloeEusZTs/w/sZEs=;
	t=1716301596; x=1716733596; b=rQ62mlwOMaK0HkfokZpjugaGWENzbCKqmywAqZpwq/3crId
	HJa6hssPqevmZrCgCZrQG0H7s0AymGChW+DEIh1C+2C6dMwXGkW8F9NJ4c/qf1eoMuyJNciqenO/y
	yYG9eac1CHuwPDRy6iuR+y30PMSw6/ks1cKvxGGGSNM1X2v020RcCEPz+IgNfKTRvSXIwx0DxgkIk
	kCFInSgi1QIRJZJJkXQHy2vqzV1NuamjtoSTL4cKIHf2RlTRCdBZgY4QcCTJlAxNl0fHhqo/o26vO
	+0M1LgBVhwnDK7hcPUi36yNRGi6YVAAePQSgtO29CX1IkDS1b5FRZeF0UIdAY/6A==;
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1s9QRk-0005rP-UG; Tue, 21 May 2024 16:26:33 +0200
Message-ID: <c10a77b6-e7b1-43c0-af38-79092eeb34f1@leemhuis.info>
Date: Tue, 21 May 2024 16:26:32 +0200
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] gpiolib: acpi: Move ACPI device NULL check to
 acpi_can_fallback_to_crs()
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Linux regressions mailing list <regressions@lists.linux.dev>,
 Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Laura Nao <laura.nao@collabora.com>, mika.westerberg@linux.intel.com,
 linus.walleij@linaro.org, brgl@bgdev.pl, kernel@collabora.com,
 linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
 linux-acpi@vger.kernel.org,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 "kernelci.org bot" <bot@kernelci.org>
References: <20240513095610.216668-1-laura.nao@collabora.com>
 <ZkHlLLLoagsYlll7@smile.fi.intel.com>
 <b20b567f-ce96-45e8-aab7-29768f8313f5@leemhuis.info>
 <Zkyo6DL7NQltLLNr@smile.fi.intel.com>
From: "Linux regression tracking (Thorsten Leemhuis)"
 <regressions@leemhuis.info>
Content-Language: en-US, de-DE
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
In-Reply-To: <Zkyo6DL7NQltLLNr@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1716301596;c198fba9;
X-HE-SMSGID: 1s9QRk-0005rP-UG

On 21.05.24 16:00, Andy Shevchenko wrote:
> On Tue, May 21, 2024 at 12:01:17PM +0200, Linux regression tracking (Thorsten Leemhuis) wrote:
>> On 13.05.24 12:02, Andy Shevchenko wrote:
>>> On Mon, May 13, 2024 at 11:56:10AM +0200, Laura Nao wrote:
>>>> Following the relocation of the function call outside of
>>>> __acpi_find_gpio(), move the ACPI device NULL check to
>>>> acpi_can_fallback_to_crs().
>>>
>>> Thank you, I'll add this to my tree as we have already the release happened.
>>> I will be available after v6.10-rc1 is out.
>>
>> Hmm, what exactly do you mean with that? It sounds as you only want to
>> add this to the tree once -rc1 is out -- which seems likely at this
>> point, as that patch is not yet in -next. If that's the case allow me to
>> ask: why?
> 
> Because:
> 
> - that's the policy of Linux Next (do not include what's not supposed to be
>   merged during merge window), Cc'ed to Stephen to clarify, it might be that
>   I'm mistaken
> 
> - the process of how we maintain the branches is to have them based on top of
>   rc1 (rarely on other rcX and never on an arbitrary commit from vanilla

Something like that is what I feared. And yes, some of that is true. But
the patch in this thread contains a Fixes: tag for commit 49c02f6e901c
which was merged during this merge window -- and that patch thus ideally
should (ideally after some testing in -next) be merge during the merge
window as well, to ensure the problem does not even hit -rc1.

That's something a lot of subsystem master all the time. The scheduler
for example:

https://git.kernel.org/torvalds/c/6e5a0c30b616bfff6926ecca5d88e3d06e6bf79a
https://git.kernel.org/torvalds/c/8dde191aabba42e9c16c8d9c853a72a062db27ee

Other subsystems (perf, x86, net) do this, too. Not sure how they
exactly do that with git; I think some (most?) have a dedicated -fixes
branch (based on master and fast-forwarded after Linus merged from it)
for that is also included in next in parallel to their "for-next"
branch.  Stephen will know for sure.

Ciao, Thorsten

