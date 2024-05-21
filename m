Return-Path: <linux-acpi+bounces-5918-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 049138CB3BF
	for <lists+linux-acpi@lfdr.de>; Tue, 21 May 2024 20:43:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 35D341C21536
	for <lists+linux-acpi@lfdr.de>; Tue, 21 May 2024 18:43:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C0E9148FF1;
	Tue, 21 May 2024 18:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="hiqxO9EB"
X-Original-To: linux-acpi@vger.kernel.org
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00A1514B945;
	Tue, 21 May 2024 18:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716316870; cv=none; b=jOc6RClly3CnoLn7HS5ohxDe7QcGv+0t5q2ac6Ei33wl1pNOkUIPyQevD1hMyNjYeMo2JS6Y8+rDsqKDWLfmfyR6PwBePQSYYNcsL5W8SvUMO8pvhdaXvfrBGLbHMLMvBnAX38rzY9FccqxaSBKQ6Rqo4zQf7CnWLosByuJKKRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716316870; c=relaxed/simple;
	bh=6XpijqtccTHGXA+AoieILf4pViR2pTCtkLRfit3mgFA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IhDuhWecnOZVtpD+cdK5hmUkzgtmV/r19pIu0SqzQ5PQxFEUE5wsnXzWs87/JSZpYIvNLJohrcWl6pempzyp6D580kERXE4J5nI/RDgCsz0ty7eZ74b0pNoiXA9j5Z0mL7GdbWgO9LmhC/5RKHSKWzx1j6V++5UKIc8p5LdBSjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=hiqxO9EB; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:From:Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:
	Content-Type:Content-Transfer-Encoding:Content-ID:Content-Description:
	In-Reply-To:References; bh=s0vsdZ7jPEzrw+PhFnU9mrUZ+GaBCox5t4ZNvaUAMzQ=;
	t=1716316868; x=1716748868; b=hiqxO9EBHgPHF86mKMWpl8g5AYL39tV1kK+YjnfqmddZQj3
	o8OSLRgj+MS9x2OqvcApOtVqAtCOx1zgCEo4rn9ekcAFYFv7lRL4UinmGU1ZEAxj+dLc/+iggUG16
	7ucYdPX5eox+lrj1ZkvDXIeFMayUJvG/X74E3IcSFOY08TPQzyDXl/4uA3B0JeaRZtX6tOvTiOjNK
	qsvWZp0VnGQCvfqk2Sej/a4o8wW4L+BqV8r45qVduq4Z/tzMaXULEc8gS8eowjhz5Ww4zSVY02yiB
	mmkBHlOLEJlZs0NlX8BRuhCPBPreBq+05FthCgNS11ZnK2ZKWlwoGMwfNnCbx6Rg==;
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1s9UQ3-0000WH-Df; Tue, 21 May 2024 20:41:03 +0200
Message-ID: <5252311c-1b40-48ac-96f6-0fd94a095dc2@leemhuis.info>
Date: Tue, 21 May 2024 20:41:02 +0200
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
 Linux regressions mailing list <regressions@lists.linux.dev>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>,
 Laura Nao <laura.nao@collabora.com>, mika.westerberg@linux.intel.com,
 linus.walleij@linaro.org, brgl@bgdev.pl, kernel@collabora.com,
 linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
 linux-acpi@vger.kernel.org,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 "kernelci.org bot" <bot@kernelci.org>
References: <20240513095610.216668-1-laura.nao@collabora.com>
 <ZkHlLLLoagsYlll7@smile.fi.intel.com>
 <b20b567f-ce96-45e8-aab7-29768f8313f5@leemhuis.info>
 <Zkyo6DL7NQltLLNr@smile.fi.intel.com>
 <c10a77b6-e7b1-43c0-af38-79092eeb34f1@leemhuis.info>
 <Zky1UgJSf_ybRMOI@smile.fi.intel.com>
 <4f1bcc8b-1795-4e3c-90a6-742cd8443396@leemhuis.info>
 <Zky9bovo_99LwDfY@smile.fi.intel.com>
From: "Linux regression tracking (Thorsten Leemhuis)"
 <regressions@leemhuis.info>
Content-Language: en-US, de-DE
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
In-Reply-To: <Zky9bovo_99LwDfY@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1716316868;77975787;
X-HE-SMSGID: 1s9UQ3-0000WH-Df

On 21.05.24 17:27, Andy Shevchenko wrote:
> On Tue, May 21, 2024 at 05:14:07PM +0200, Linux regression tracking (Thorsten Leemhuis) wrote:
>> On 21.05.24 16:53, Andy Shevchenko wrote:
>>> On Tue, May 21, 2024 at 04:26:32PM +0200, Linux regression tracking (Thorsten Leemhuis) wrote:
>>>> On 21.05.24 16:00, Andy Shevchenko wrote:
>>>>> On Tue, May 21, 2024 at 12:01:17PM +0200, Linux regression tracking (Thorsten Leemhuis) wrote:
>>>>>> On 13.05.24 12:02, Andy Shevchenko wrote:
>>>>>>> On Mon, May 13, 2024 at 11:56:10AM +0200, Laura Nao wrote:
> [...]
>>> The other thing, that we have 3 regressions
>>> now for very this code. And some of them are still under discussions.
>>>
>>> Wouldn't be better to gather all fixes and send a bunch via proper process
>>> after rc1? 
>>
>> Depends on the situation. As a general approach I'd say no, but there
>> definitely can be situations where that is wise.
>>
>>> This will ensure that everything we know about is covered properly
>>> and processed accordingly,
>>>
>>> In broader way, the process should be amended if you want a fast track for
>>> the patches like this. I'm on the second level here, Bart is the maintainer
>>> who sends PRs directly to Linus. Do we have anything like this?
>>
>> Pretty sure Linus wants maintains to just fast-track things when needed
>> by sending an additional PR; he multiple times said that this is not a
>> problem.
>>
>> But there is a way to fast track things: just ask Linus to pull a patch
>> from the list (e.g. in a reply to the patch while CCIng tim). He
>> multiple times said this is no problem for him, unless it becomes the
>> norm. This is documented in
>> Documentation/process/handling-regressions.rst /
>> https://docs.kernel.org/process/handling-regressions.html
> 
> "For urgent regressions, consider asking Linus to pick up the fix straight from
> the mailing list: he is totally fine with that for uncontroversial fixes.
> Ideally though such requests should happen in accordance with the subsystem
> maintainers or come directly from them."
> 
> The first thing I'm not so comfortable with is that Bart as a subsystem
> maintainer will be by-passed.

Well, that's why the last sentence you quoted is there; but yeah, the
"sub-subsystem" case it only kinda indirectly covered there. I can add
something about it if people feel that this is needed. But in the end
I'd say in this case Bart should be involved or the one that feeds this
to Linus. We'll see soon how both react to your PR. Thx for that BTW!

> The second one, is the metrics of urgency.
> I can assume that something from a TIP tree is really urgent and they
> even have established fast track for ages. But why do you think this fix
> is of the same level of urgency? 

We get into "best to ask Linus directly" territory here. I suspect
things for him boil down to "a fix is a fix; if it was reviewed and
ideally in next for ~2 days, let's just merge it to get rid of the
regression, unless there are strong reasons to wait a bit more (for
example if the fix is dangerous and better should be in -next somewhat
longer)".

Ciao, Thorsten

