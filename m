Return-Path: <linux-acpi+bounces-8461-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 43F3A9886EA
	for <lists+linux-acpi@lfdr.de>; Fri, 27 Sep 2024 16:20:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F391A2813B2
	for <lists+linux-acpi@lfdr.de>; Fri, 27 Sep 2024 14:20:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 097AB481AB;
	Fri, 27 Sep 2024 14:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="atlU4/d0"
X-Original-To: linux-acpi@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71B3F191
	for <linux-acpi@vger.kernel.org>; Fri, 27 Sep 2024 14:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727446798; cv=none; b=mJFju5z66Z972y2BIjUy8RWXQOt4MK6daXPsZYTSaZLP06916iRoFu3S7J3d/wqk5iattb6MVjFEHNYOzmmULBGQOeJZFIzL5uB1c0fep0ZjXJtb6aOtQOfnQL2RJks0Ge/VIEisuktR3/T8xCTUgtGcD5InyM94A60wvqAK4VU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727446798; c=relaxed/simple;
	bh=TAumnclaZPJ3JsP6Z6FrwJ5J4BWAABpTn6LrE92M8b0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KSjVCOVlHP430iPY+pALfhhxJGFlHOofoGSOV4nscaTYmQme8zgkt4AzHyx0GEFe16SazuFE7ZZwABWo008L+haFOUC/H2s14rN0IPYtklGXBdHFbLmFcjD4J2ifRkyuK25GzSYFvt356wrGJ80NpKpNNkd+IYauwQmNOYeQxGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=atlU4/d0; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727446796;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CsHStmWEpieZFdjzVIt+lNRUQ+HoOUuzdOx9CgVHRjs=;
	b=atlU4/d0IojlvkjSdtFJXzlAZPygROP+kqKbdHDE8v4F5FUa8oVyi1UVWNW3z76plW21q7
	sQOFeF8SYA4QYNP13gZO6T7TdRKILFS1fRDO4xBtshiPwfMzkK6tlId9kklGKTrRDPhpGx
	AwD7Ml7GLX7fKm0jP9Q5sxnIIFeEYuY=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-113-_6RO3DsfM_iMbPCPePLRuw-1; Fri, 27 Sep 2024 10:19:55 -0400
X-MC-Unique: _6RO3DsfM_iMbPCPePLRuw-1
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-5c8842f6339so515148a12.0
        for <linux-acpi@vger.kernel.org>; Fri, 27 Sep 2024 07:19:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727446794; x=1728051594;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CsHStmWEpieZFdjzVIt+lNRUQ+HoOUuzdOx9CgVHRjs=;
        b=P+6dW1M7skD401aIsL39b72jKvmGDcJg/bKNjKUiDLnqYtOTLgU+jZ/ZKNjvOpe0HK
         +dmVAoDwVGTDyBlWxwoamYCPqMDx8sPW6iuFKjMfoz+zb9AIscXdeEyvydCsbyomuhiB
         9iP79NXpUOtDhI4FUhxCv8wTSXBx2sGDof3tQ0lwTs3sa1oYDthL1skV/9i0yaTsWG9b
         9DwemZUqMqzjxwYKcmAMxlZSqSgHUfEoxhokysHFYu17jz4v99+iLKLi+YBGz0zspAeh
         vncUdIPDSITLbcrZbJ+8OXXbOPjMVO00OV9gFD9OuUquVn0JH7RavKbhZKLnvFEE3wE4
         m9pw==
X-Forwarded-Encrypted: i=1; AJvYcCXoI37fY3cSStqVR+hrPMia8X0XbTyUJJhA059CNKfhEs98NjFbdMSt6/QQXidZMewAb7efYZghui5W@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8CyJPglOOZgu600OO0T2mI/bBS1bK3Yt5kAWz9W92nQcGkYI+
	ytIawTTXvwgmdK1xI7nGvPuASU2GNXY+nmEl2EDf6Vx29KCq0lOGdhewJ+VatNkJKy91IlM9uGC
	A/hA17t7TuiwSrK0k9dnpKAG1g5ErEgbni943z9WbfdYSacAyzhok9Bu/FqI=
X-Received: by 2002:a05:6402:e9e:b0:5c0:c10c:7c1d with SMTP id 4fb4d7f45d1cf-5c88260359fmr2685258a12.23.1727446793879;
        Fri, 27 Sep 2024 07:19:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEl8zETG/nN7VCsItEgk23DbBOEAqEjpciP00WcQag6SkFOy6fRM48NrEV7cAT7D3Tod8+lxA==
X-Received: by 2002:a05:6402:e9e:b0:5c0:c10c:7c1d with SMTP id 4fb4d7f45d1cf-5c88260359fmr2685231a12.23.1727446793344;
        Fri, 27 Sep 2024 07:19:53 -0700 (PDT)
Received: from [192.168.1.35] (85-147-213-205.cable.dynamic.v4.ziggo.nl. [85.147.213.205])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c88248ac03sm1193820a12.70.2024.09.27.07.19.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Sep 2024 07:19:52 -0700 (PDT)
Message-ID: <9feac709-fbab-424a-bc5c-dedbcec40dea@redhat.com>
Date: Fri, 27 Sep 2024 16:19:50 +0200
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ACPI: resource: Skip IRQ override on Asus Vivobook Go
 E1404GAB
To: Thorsten Leemhuis <linux@leemhuis.info>, Tamim Khan <tamim@fusetak.com>,
 linux-acpi@vger.kernel.org, Paul Menzel <pmenzel@molgen.mpg.de>
Cc: rafael@kernel.org, lenb@kernel.org, LKML <linux-kernel@vger.kernel.org>,
 Linux kernel regressions list <regressions@lists.linux.dev>
References: <20240903014317.38858-1-tamim@fusetak.com>
 <c73420b7-c186-4b5d-a074-961b35ed829c@leemhuis.info>
 <f79854bd-b338-458f-bc04-466376d05a65@leemhuis.info>
 <87cf24b3-5ddd-4532-b186-dd1dcc62f712@leemhuis.info>
 <c1276139-d26f-457a-8a73-7f17538dbd28@redhat.com>
 <7ce7f7cc-870f-4f7f-98c6-95eb784008ff@leemhuis.info>
Content-Language: en-US, nl
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <7ce7f7cc-870f-4f7f-98c6-95eb784008ff@leemhuis.info>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Thorsten,

On 26-Sep-24 12:18 PM, Thorsten Leemhuis wrote:
> On 25.09.24 16:31, Hans de Goede wrote:
>>
>> On 25-Sep-24 1:56 PM, Thorsten Leemhuis wrote:
>>> [CCing Hans]
>> Can you next time maybe also add a bit of text explaining why ?
> 
> Sorry, yes, you are right, will keep that in mind.
> 
>>> On 05.09.24 12:45, Thorsten Leemhuis wrote:
>>>> On 05.09.24 11:51, Thorsten Leemhuis wrote:
>>>>> On 03.09.24 03:43, Tamim Khan wrote:
>>>>>> Like other Asus Vivobooks, the Asus Vivobook Go E1404GAB has a DSDT
>>>>>> that describes IRQ 1 as ActiveLow, while the kernel overrides to Edge_High.
>>>>>> This override prevents the internal keyboard from working. This patch fixes
>>>>>> this problem by adding this laptop to the table that prevents the kernel from
>>>>>> overriding the IRQ.
>>>>>>
>>>>>> Link: https://bugzilla.kernel.org/show_bug.cgi?id=219212
>>>>> Thx for that. FWIW, I by chance noticed another such report about the
>>>>> E1404GA: https://bugzilla.kernel.org/show_bug.cgi?id=219224
>>>>
>>>> TWIMC, shortly after sending this mail I noticed there is another request
>>>> for a quirk that was send to the list, bug afaics fall through the
>>>> cracks. See here:
>>>> https://lore.kernel.org/all/1226760b-4699-4529-bf57-6423938157a3@wanadoo.fr/
>>>>
>>>> It afaics add a X1704VAP:
>> [...]
>>
>> Ok, I wonder did you Cc me so that I can write / submit patches upstream
>> for these ones?
> 
> Not really. Of course it would be nice if you or someone else took care
> of that one and...
> 
>> It seems that there are 3 missing models:
>> - E1404GA: https://bugzilla.kernel.org/show_bug.cgi?id=219224
>> - X1704VAP https://lore.kernel.org/all/1226760b-4699-4529-bf57-6423938157a3@wanadoo.fr/
>> - B2502CV: https://bugzilla.kernel.org/show_bug.cgi?id=217760#c12
>>
>> Which someone needs to submit upstream, right ?
> 
> ...these as well -- and ideally would even be willing to act as go-to
> person from now on in case more of these quirk entries are needed, which
> I guess will be the case. But given the backstory (see below) I don't
> think you or anyone else is obliged to do this, even if the current
> situation is parlty caused by regressions and recent fixes for them.

I have already done a bunch of these patches. So I would be happy to
submit more of these, but someone needs to bring them to my attention first.

Also maybe Paul Menzel (added to the Cc) and Tamim Khan can help with
adding more quirks, when reports come in ?

Either way I have submitted a set of patches to add quirks for the 3 new
known broken models now.


>>> """
>>>> adding this section to file drivers/acpi/resource.c helped; if someone could do an official patch it would be great :-|
>>>>
>>>>         {
>>>>                 /* Asus ExpertBook B2502CVA */
>>>>                 .matches = {
>>>>                         DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
>>>>                         DMI_MATCH(DMI_BOARD_NAME, "B2502CVA"),
>>>>                 },
>>> """
>>>
>>> This is not a regression, but given how frequently I notice these issues
>>> please as a bystander allow me to ask: is there maybe some way to
>>> improve the situation so that we do not have to add all these and likely
>>> many other Asus Laptops to that file?
>>
>> This has been discussed before and unfortunately there is no other way
>> to deal with this. There has been some discussion about reading back
>> the polarity and edge/level from the hardware for the keyboard IRQ
>> to get the values which the BIOS has setup. But it is uncertain if this
>> will work and no one is working on this.
> 
> A refresher like this was more what I was fishing for. Thx for this.
> 
> Now that you wrote it, it makes me think: given the amount of quirk
> entries we apparently need I wonder if it might be wise to revisit this
> at some point in the not to distant future, as I suspect otherwise
> sooner or later Linus might yell at all of us with something along the
> lines of "the kernel is clearly broken, why did we work around this with
> lots of quirk entries instead of fixing this for real". Something like
> that happened in a somewhat (but not exactly) similar situation a year
> ago, and it iirc was not the first time.

I hear you, but I don't really know anyone who has both the expertise
as well as the bandwidth to deal with this.

> Writing this lead to another thought: does anyone have contacts to Asus
> and could just ask if there is some generic way to detect which of their
> Laptops need a quirk?

I don't have any contacts at Asus.

Regards,

Hans



