Return-Path: <linux-acpi+bounces-8435-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D343F987122
	for <lists+linux-acpi@lfdr.de>; Thu, 26 Sep 2024 12:19:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 92486281493
	for <lists+linux-acpi@lfdr.de>; Thu, 26 Sep 2024 10:19:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D6331AC437;
	Thu, 26 Sep 2024 10:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="lITTgP2M"
X-Original-To: linux-acpi@vger.kernel.org
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 818145647F;
	Thu, 26 Sep 2024 10:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727345941; cv=none; b=OywEBd+8Vs9qJODrTczL3Be9QRF50d9yFBFPHXxg1hGiIHhZRe/Wqs01Jz39yUBv8YVpyvE/IuGGeUr455Sd4ak6nD80oCbMUtwzzI1lwlXdV2c+9twBFK8oI9KkBj5gy3VbnwCCtAnuEPVYJpw3CiT7U2oAGL6q4KBP5O+js9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727345941; c=relaxed/simple;
	bh=jofM7Q5aS76ZNLfcMgMBEeX3gAqN6j6s3g02UtRiWa4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UQHWew/bOGaMNdSX5ZAuKKOSxQCQpPS7eyRS3CQOeVuH3lywog2vzQn+MDjV2lmwx2sBHRIiAadPS/kbnSbpbqDLIhP5R1zZNHwi7L31W0au8cqssTvyz3nV0+hcazJFDU63I3m3vzI244btNiOonKxE8XtI9sfaOU4eFhSdGpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=lITTgP2M; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=vcQOEOghojEEcKzBYWCBaalez3tMu6zJ0B+RBH5pf0I=; t=1727345939;
	x=1727777939; b=lITTgP2M+/SrjouAGVJ7kNtAol4InXfuHxYQwHbBUMIOwZXJCAGKIWAp4dcj2
	88vzSpmq/h+ctAtfEjJbJoF77iQN8d5+25dPlJnQt1eaIJYy6ybY8hWlEo1wZzP1QOzM+gntkHvL2
	qTtkfantvnMSatP7Q12RR0IHk8FRYdgvJFCGQnU7rmqiSoxL8GODx/PDU/Qusc3ojb5UsvAYZK9vS
	hY6A3XCZx2D2gp2A64aWZMvIG7blf6LtPSvmK2w6JDz1+PsciGdMBcg5Tvm1N+/u+JZYQHU1YhtE2
	wJgUsnTJ4LeY0zWXxl/+tgv32uyOvSAo57fb1aTdeu+eh1/ATg==;
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1stlaG-0006Jr-33; Thu, 26 Sep 2024 12:18:52 +0200
Message-ID: <7ce7f7cc-870f-4f7f-98c6-95eb784008ff@leemhuis.info>
Date: Thu, 26 Sep 2024 12:18:51 +0200
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
 linux-acpi@vger.kernel.org
Cc: rafael@kernel.org, lenb@kernel.org, LKML <linux-kernel@vger.kernel.org>,
 Linux kernel regressions list <regressions@lists.linux.dev>
References: <20240903014317.38858-1-tamim@fusetak.com>
 <c73420b7-c186-4b5d-a074-961b35ed829c@leemhuis.info>
 <f79854bd-b338-458f-bc04-466376d05a65@leemhuis.info>
 <87cf24b3-5ddd-4532-b186-dd1dcc62f712@leemhuis.info>
 <c1276139-d26f-457a-8a73-7f17538dbd28@redhat.com>
From: Thorsten Leemhuis <linux@leemhuis.info>
Content-Language: en-US, de-DE
Autocrypt: addr=linux@leemhuis.info; keydata=
 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 n7RI
In-Reply-To: <c1276139-d26f-457a-8a73-7f17538dbd28@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;linux@leemhuis.info;1727345939;5d8a54f4;
X-HE-SMSGID: 1stlaG-0006Jr-33

On 25.09.24 16:31, Hans de Goede wrote:
> 
> On 25-Sep-24 1:56 PM, Thorsten Leemhuis wrote:
>> [CCing Hans]
> Can you next time maybe also add a bit of text explaining why ?

Sorry, yes, you are right, will keep that in mind.

>> On 05.09.24 12:45, Thorsten Leemhuis wrote:
>>> On 05.09.24 11:51, Thorsten Leemhuis wrote:
>>>> On 03.09.24 03:43, Tamim Khan wrote:
>>>>> Like other Asus Vivobooks, the Asus Vivobook Go E1404GAB has a DSDT
>>>>> that describes IRQ 1 as ActiveLow, while the kernel overrides to Edge_High.
>>>>> This override prevents the internal keyboard from working. This patch fixes
>>>>> this problem by adding this laptop to the table that prevents the kernel from
>>>>> overriding the IRQ.
>>>>>
>>>>> Link: https://bugzilla.kernel.org/show_bug.cgi?id=219212
>>>> Thx for that. FWIW, I by chance noticed another such report about the
>>>> E1404GA: https://bugzilla.kernel.org/show_bug.cgi?id=219224
>>>
>>> TWIMC, shortly after sending this mail I noticed there is another request
>>> for a quirk that was send to the list, bug afaics fall through the
>>> cracks. See here:
>>> https://lore.kernel.org/all/1226760b-4699-4529-bf57-6423938157a3@wanadoo.fr/
>>>
>>> It afaics add a X1704VAP:
> [...]
> 
> Ok, I wonder did you Cc me so that I can write / submit patches upstream
> for these ones?

Not really. Of course it would be nice if you or someone else took care
of that one and...

> It seems that there are 3 missing models:
> - E1404GA: https://bugzilla.kernel.org/show_bug.cgi?id=219224
> - X1704VAP https://lore.kernel.org/all/1226760b-4699-4529-bf57-6423938157a3@wanadoo.fr/
> - B2502CV: https://bugzilla.kernel.org/show_bug.cgi?id=217760#c12
> 
> Which someone needs to submit upstream, right ?

...these as well -- and ideally would even be willing to act as go-to
person from now on in case more of these quirk entries are needed, which
I guess will be the case. But given the backstory (see below) I don't
think you or anyone else is obliged to do this, even if the current
situation is parlty caused by regressions and recent fixes for them.

>> """
>>> adding this section to file drivers/acpi/resource.c helped; if someone could do an official patch it would be great :-|
>>>
>>>         {
>>>                 /* Asus ExpertBook B2502CVA */
>>>                 .matches = {
>>>                         DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
>>>                         DMI_MATCH(DMI_BOARD_NAME, "B2502CVA"),
>>>                 },
>> """
>>
>> This is not a regression, but given how frequently I notice these issues
>> please as a bystander allow me to ask: is there maybe some way to
>> improve the situation so that we do not have to add all these and likely
>> many other Asus Laptops to that file?
> 
> This has been discussed before and unfortunately there is no other way
> to deal with this. There has been some discussion about reading back
> the polarity and edge/level from the hardware for the keyboard IRQ
> to get the values which the BIOS has setup. But it is uncertain if this
> will work and no one is working on this.

A refresher like this was more what I was fishing for. Thx for this.

Now that you wrote it, it makes me think: given the amount of quirk
entries we apparently need I wonder if it might be wise to revisit this
at some point in the not to distant future, as I suspect otherwise
sooner or later Linus might yell at all of us with something along the
lines of "the kernel is clearly broken, why did we work around this with
lots of quirk entries instead of fixing this for real". Something like
that happened in a somewhat (but not exactly) similar situation a year
ago, and it iirc was not the first time.

Writing this lead to another thought: does anyone have contacts to Asus
and could just ask if there is some generic way to detect which of their
Laptops need a quirk?

Ciao, Thorsten

