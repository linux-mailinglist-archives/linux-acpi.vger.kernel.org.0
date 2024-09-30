Return-Path: <linux-acpi+bounces-8487-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 922D4989BC8
	for <lists+linux-acpi@lfdr.de>; Mon, 30 Sep 2024 09:45:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C2B1E1C216C0
	for <lists+linux-acpi@lfdr.de>; Mon, 30 Sep 2024 07:45:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A3D9161313;
	Mon, 30 Sep 2024 07:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="1jmzJMtY"
X-Original-To: linux-acpi@vger.kernel.org
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81C8E15C13A;
	Mon, 30 Sep 2024 07:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727682292; cv=none; b=otrUBUjzZrQKB5t/3H38T4F2gZvp8oPLAB0CQZJYm2UruxzxtoA+i27MbyFSWsXlnm51Z84sqGa9LfgplFDST97c8sCpL1pUcxYrwdHNv4ht4sNpweIpvwHVAg/sjuIS3RMe+co+sGwWkyt56L1HX7HVIOyWtuyxxY8rFFH1/MM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727682292; c=relaxed/simple;
	bh=j7RGII9g3Po6cu1gX7o2B+tuk4vrlYYa6ySx2mjDLuw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GXze2UcnjfwT6gjkLsCxvFsfNIdHWvc4O4eoTS/Vg1w9KFrzntO2/ZoGNLpo2dW9TZWllkgZED1D91gZNga9Ys3tdiicR4LydMWJbVDtW+NNv2pWKJOp5s/Dx9ldYt33T56dgbyLITD917JlVg3y++QVLl7muqv+yIamf4x5xmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=1jmzJMtY; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=k1U/88ZtoQLAF8tHTyw8LiGNPUA1RAE+qVtpSBnQjhg=; t=1727682290;
	x=1728114290; b=1jmzJMtYITtqa15sn7EargiBu6f2yeuB0IKpLSm+k557merPh87mr+Afc0XMw
	XqehCP1oGbiudEEdvpYO6S6brD1hNRgkbTFHmQn46EYb7SQjDF6n6asnDirOXpZsNblyBcuHtlYYk
	iyL5y8ffP9zNUYYUvE8ynTwIXp9fB2rTZ74BnkQODleGVHnSzRBYRT+l4wK6qrCltLtNExAImmJU1
	Dehhmi68B+JuM2sLIwCVABkS0cEg7vh+EwsuvjciDRSCF06qonRPNRtACQpP54+mWZDfhh10diOjF
	QmccdH4Sq36lX3rWAjuNtYGS555uiYU46mKQ2bDk//+vTWXmIA==;
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1svB5G-0003Ng-LM; Mon, 30 Sep 2024 09:44:42 +0200
Message-ID: <38fc4bf7-804f-449b-a9a4-a33bb7486656@leemhuis.info>
Date: Mon, 30 Sep 2024 09:44:42 +0200
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ACPI: resource: Skip IRQ override on Asus Vivobook Go
 E1404GAB
To: Hans de Goede <hdegoede@redhat.com>, Tamim Khan <tamim@fusetak.com>,
 linux-acpi@vger.kernel.org, Paul Menzel <pmenzel@molgen.mpg.de>
Cc: rafael@kernel.org, lenb@kernel.org, LKML <linux-kernel@vger.kernel.org>,
 Linux kernel regressions list <regressions@lists.linux.dev>
References: <20240903014317.38858-1-tamim@fusetak.com>
 <c73420b7-c186-4b5d-a074-961b35ed829c@leemhuis.info>
 <f79854bd-b338-458f-bc04-466376d05a65@leemhuis.info>
 <87cf24b3-5ddd-4532-b186-dd1dcc62f712@leemhuis.info>
 <c1276139-d26f-457a-8a73-7f17538dbd28@redhat.com>
 <7ce7f7cc-870f-4f7f-98c6-95eb784008ff@leemhuis.info>
 <9feac709-fbab-424a-bc5c-dedbcec40dea@redhat.com>
From: Thorsten Leemhuis <regressions@leemhuis.info>
Content-Language: en-US, de-DE
In-Reply-To: <9feac709-fbab-424a-bc5c-dedbcec40dea@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1727682290;e7ea498c;
X-HE-SMSGID: 1svB5G-0003Ng-LM

On 27.09.24 16:19, Hans de Goede wrote:
> On 26-Sep-24 12:18 PM, Thorsten Leemhuis wrote:
>> On 25.09.24 16:31, Hans de Goede wrote:
>>> On 25-Sep-24 1:56 PM, Thorsten Leemhuis wrote:
>>>>> https://lore.kernel.org/all/1226760b-4699-4529-bf57-6423938157a3@wanadoo.fr/
>>> Ok, I wonder did you Cc me so that I can write / submit patches upstream
>>> for these ones?
>>
>> Not really. Of course it would be nice if you or someone else took care
>> of that one and...
>>
>>> It seems that there are 3 missing models:
>>> - E1404GA: https://bugzilla.kernel.org/show_bug.cgi?id=219224
>>> - X1704VAP https://lore.kernel.org/all/1226760b-4699-4529-bf57-6423938157a3@wanadoo.fr/
>>> - B2502CV: https://bugzilla.kernel.org/show_bug.cgi?id=217760#c12
>>>
>>> Which someone needs to submit upstream, right ?
>>
>> ...these as well -- and ideally would even be willing to act as go-to
>> person from now on in case more of these quirk entries are needed, which
>> I guess will be the case. But given the backstory (see below) I don't
>> think you or anyone else is obliged to do this, even if the current
>> situation is parlty caused by regressions and recent fixes for them.
> 
> I have already done a bunch of these patches. So I would be happy to
> submit more of these, but someone needs to bring them to my attention first.

Great, good to know.

> Also maybe Paul Menzel (added to the Cc) and Tamim Khan can help with
> adding more quirks, when reports come in ?

That would be great, but nevertheless allow me to ask:

Does anyone now if kernelnewbies has some place where we could submit
requests for creating quirk entries?

> Either way I have submitted a set of patches to add quirks for the 3 new
> known broken models now.

Many thx!

>> Writing this lead to another thought: does anyone have contacts to Asus
>> and could just ask if there is some generic way to detect which of their
>> Laptops need a quirk?
> I don't have any contacts at Asus.

I asked in the fediverse, maybe someone knows somebody that can help.
And if not: no harm done.

Have a nice week everyone!

Ciao, Thorsten

