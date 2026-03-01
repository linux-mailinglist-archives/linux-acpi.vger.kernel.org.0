Return-Path: <linux-acpi+bounces-21290-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6Om0KKV+pGl+igUAu9opvQ
	(envelope-from <linux-acpi+bounces-21290-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Sun, 01 Mar 2026 19:00:05 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D55D1D1032
	for <lists+linux-acpi@lfdr.de>; Sun, 01 Mar 2026 19:00:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B5E3C300B450
	for <lists+linux-acpi@lfdr.de>; Sun,  1 Mar 2026 18:00:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB63E336ECC;
	Sun,  1 Mar 2026 18:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="FzlK2gng"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2E0932FA38;
	Sun,  1 Mar 2026 18:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772388003; cv=none; b=Yzys0feVZP5fddy7vOJ/QKD2471JflxqoEcJ4lLZcUVWBmtJyMh3sH2tmknxwOyVzvypINlv6Vx+BLWIxIlz9mQpoHTMfncyxAHFgmEwfjPlQ8rzo24oIJMpbQqewFtiPdwU4JIXLrAen9ps0kvY9eZShijFFqp7RRX9dF8dXxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772388003; c=relaxed/simple;
	bh=adO1n0aNjrVW8zP0aGZ0/FcDqNSdGpaqRsK0q5EvGFk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eI9TUVaZ9GwJIQ36vLZXwUefxZU1BVP0qZI3nIEyjdAqPw2SXI/cIVcyIh2mRwmi9DFdjG+XxhyamalbZIcNYO2dwyY4HfO6PIehrqrDu2imG4V8FpcVCOw4c8Uf3hF8OBBkP8jLqH3O6/6ExdKdHYUua86y/1cfR+69aqaK1VU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=FzlK2gng; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1772387995; x=1772992795; i=w_armin@gmx.de;
	bh=bXDAOlYTkZf9mocA0abn34RyqbLiVp4O24RyCkqE/po=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=FzlK2gngL27fUFR3pyb2CayVeZZ5P9hrD183woGwvjXiTUxOP4G9oqRKVfXin5SX
	 xv8D/SIq5gDiV+mcri2nTcKdvaNICTpyqXZgbfPyTol00fiFejYHblDVhPVwTSOPj
	 sIZs7/Ho1gZsCjsVgWCcrWcdcN6bGhW8yyEiX31jFNaPuGuKPIv6w9NEhYQHidIge
	 JH52XF8JibRUswka1PvQxlD19B58gcdeQ9QPOOUn4i4uoP3HTW2y/dFK8sEfge09I
	 5AhUiPBx15kS5Lubc5ZN/HUrr2takWDVL6BWKm1CZ0CMAm1UvWSqOjxgENYLEloUp
	 WKvuAmBQkvFMUJYH1A==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MbAgq-1vPtAZ2BYm-00nOw7; Sun, 01
 Mar 2026 18:59:55 +0100
Message-ID: <5a6bbac6-e60a-426d-a6fe-d478e74b8532@gmx.de>
Date: Sun, 1 Mar 2026 18:59:55 +0100
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] ACPI: OSL: Poweroff when encountering a fatal ACPI
 error
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: lenb@kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260204212931.3860-1-W_Armin@gmx.de>
 <c5d23d8a-8f58-48c3-90ca-5d1a46964280@gmx.de>
 <CAJZ5v0g6w_2+4oUytzxHtAhsJczK9pe84ZfXPeOcjKqU0k_GkQ@mail.gmail.com>
 <6825e6b2-802b-4cd2-b2c5-b4eab67b00e4@gmx.de>
 <CAJZ5v0h7Nc2gUr_WaJSL4vEekhfL_4aojDWdkidnS=3T-=uxRg@mail.gmail.com>
 <c663548b-29ee-4d23-a6b7-9a88eab5470e@gmx.de>
 <e7ba6414-a1f3-4e49-a3af-3a8592a46a99@gmx.de>
 <CAJZ5v0jwE_CYDAxT3OYx4+i4nk1v2TTuyFHbzCKXVD0j5mBuiw@mail.gmail.com>
Content-Language: en-US
From: Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <CAJZ5v0jwE_CYDAxT3OYx4+i4nk1v2TTuyFHbzCKXVD0j5mBuiw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Fd6n3bqBV3+WSqW3vHMtwKKoUJMd2E9jgmcDgIu5AHIWlr/ksYE
 NFc9wq81Bgc9dv3AHBNPI1c4lIoVv6HxdqKMCzn9RGO7Mq9sEJ7qQlHIWn9TQxjMUSGP4/j
 qrH6YW3LThGcnCu0w7TRb9TTFGng/tOSm3gW7B4ua1IwKPoeWj5XBoK36jzfbaJZ9vBbkeq
 2FpMeBAV6UF2u2mofmtfA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:eJnR10GKuns=;dzogzRMhpON8QJ6Pe64keY35ECy
 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
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmx.de,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74];
	R_DKIM_ALLOW(-0.20)[gmx.de:s=s31663417];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21290-lists,linux-acpi=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[W_Armin@gmx.de,linux-acpi@vger.kernel.org];
	DKIM_TRACE(0.00)[gmx.de:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-acpi];
	FREEMAIL_FROM(0.00)[gmx.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,gmx.de:mid,gmx.de:dkim,gmx.de:email]
X-Rspamd-Queue-Id: 5D55D1D1032
X-Rspamd-Action: no action

Am 27.02.26 um 21:39 schrieb Rafael J. Wysocki:

> On Fri, Feb 27, 2026 at 8:55=E2=80=AFPM Armin Wolf <W_Armin@gmx.de> wrot=
e:
>> Am 27.02.26 um 20:50 schrieb Armin Wolf:
>>
>>> Am 26.02.26 um 19:46 schrieb Rafael J. Wysocki:
>>>
>>>> On Thu, Feb 26, 2026 at 7:35=E2=80=AFAM Armin Wolf <W_Armin@gmx.de> w=
rote:
>>>>> Am 25.02.26 um 22:28 schrieb Rafael J. Wysocki:
>>>>>
>>>>>> On Wed, Feb 25, 2026 at 12:06=E2=80=AFAM Armin Wolf <W_Armin@gmx.de=
> wrote:
>>>>>>> Am 04.02.26 um 22:29 schrieb Armin Wolf:
>>>>>>>
>>>>>>>> The ACPI spec states that the operating system should respond
>>>>>>>> to a fatal ACPI error by "performing a controlled OS shutdown in
>>>>>>>> a timely fashion". Comply with the ACPI specification by powering
>>>>>>>> off the system when ACPICA signals a fatal ACPI error. Users can
>>>>>>>> still disable this behavior by using the acpi.poweroff_on_fatal
>>>>>>>> kernel option to work around firmware bugs.
>>>>>>> Any updates on this?
>>>>>> I was about to apply it, but then I thought that I was not sure abo=
ut
>>>>>> the Kconfig option.
>>>>>>
>>>>>>     I don't see much value in it TBH.  If you agree, I'll just appl=
y
>>>>>> the
>>>>>> patch without that part.
>>>>>>
>>>>>> Thanks!
>>>>> You can drop the Kconfig option if you want.
>>>> OK, applied as 7.1 material.
>>>>
>>>> Please double check
>>>> https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git/c=
ommit/?h=3Dbleeding-edge&id=3D6f09a7009a1d7a132ddce3a8dd0c46aac66ad8e2
>>>>
>>> Looks good to me, except that the include of kconfig.h should be
>>> dropped now.
>>>
>>> Thanks,
>>> Armin Wolf
>>>
>> I also just noticed that we still need to include panic.h for add_taint=
().
> It complied regardless, likely because kernel.h was included, but yes.
>
>> Should i send a new revision?
> No need, I've just updated it by hand and pushed it out.

Thank you very much :)

Armin Wolf


