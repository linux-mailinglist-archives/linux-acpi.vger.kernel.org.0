Return-Path: <linux-acpi+bounces-21240-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0F59CNL2oWkwxgQAu9opvQ
	(envelope-from <linux-acpi+bounces-21240-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Fri, 27 Feb 2026 20:56:02 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 993C41BD24F
	for <lists+linux-acpi@lfdr.de>; Fri, 27 Feb 2026 20:56:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 35EAC3007646
	for <lists+linux-acpi@lfdr.de>; Fri, 27 Feb 2026 19:55:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 009C444CF51;
	Fri, 27 Feb 2026 19:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="miGJ4hkD"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39742364E91;
	Fri, 27 Feb 2026 19:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772222111; cv=none; b=UckkV5Azg/8HuzRh5FxESTwU/PNvVO+tQFaGDtdZQ9awA8CgNCMdBOzTGScJt2EGUGbb0B+b9INBXCAs3QpObQ1Z+fmKcR9B5wXNw1ug4wvZaMkLrtCWtjPXTFRNBS7Aj8ozhmoBd83xHZgcVXxW7ty8hErTy9Nldk/umZrjwpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772222111; c=relaxed/simple;
	bh=t+vRlOTMrKXHbX3ul9PXuu8EeVsvzpbD5WcKjEr+aag=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=nNVCmCLWsj3YL5g4UiUPwSzd5VMxSwfNYei7EeHz3xozqZnRUovQWaVgr3i8stnTZhcrJ/S24Hv7p8BDJH8wFMoZbk2EEvM5RDAiuc4kXaKssLAgd4/YVb181wJWbvIM5dYCpLK/UPR9UcrIbxKo3a+3qmYaX7Nn2w6EPbY9MJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=miGJ4hkD; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1772222103; x=1772826903; i=w_armin@gmx.de;
	bh=t+vRlOTMrKXHbX3ul9PXuu8EeVsvzpbD5WcKjEr+aag=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:From:To:
	 Cc:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=miGJ4hkDbNErxRLNZbPAVjip/e9iHlIA9aba1SAVNFjr2LQpzIcyRoknTP3G1flS
	 OxWCp7aOscqmN7PVRQBRaPDW0fyy57Lr2pA97hwSfWOnU9s1ufXNf5ZBx0r4rYk/g
	 9QvDjPtXYEVqxpLlVXGgQBOfC9OCFp7KhVITlPjDoyKlMfUAJ228aDBEpmlNyOwNk
	 NeVdycZ6ewA1+NP/JhM63cMp9okyG1O0LsuzCn5Jc4IHkTupFdwDiPAVVq2JM1uga
	 2oFhaTXSsqlXIePKNKTGJXWpegTQPjwZijVY+rliyu+S2md5ceDu7pmGyl12LydKT
	 oyloc1VgTKkXTN/7gg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MMXUN-1wExij2zYd-00VihQ; Fri, 27
 Feb 2026 20:55:02 +0100
Message-ID: <e7ba6414-a1f3-4e49-a3af-3a8592a46a99@gmx.de>
Date: Fri, 27 Feb 2026 20:55:01 +0100
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] ACPI: OSL: Poweroff when encountering a fatal ACPI
 error
From: Armin Wolf <W_Armin@gmx.de>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: lenb@kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260204212931.3860-1-W_Armin@gmx.de>
 <c5d23d8a-8f58-48c3-90ca-5d1a46964280@gmx.de>
 <CAJZ5v0g6w_2+4oUytzxHtAhsJczK9pe84ZfXPeOcjKqU0k_GkQ@mail.gmail.com>
 <6825e6b2-802b-4cd2-b2c5-b4eab67b00e4@gmx.de>
 <CAJZ5v0h7Nc2gUr_WaJSL4vEekhfL_4aojDWdkidnS=3T-=uxRg@mail.gmail.com>
 <c663548b-29ee-4d23-a6b7-9a88eab5470e@gmx.de>
Content-Language: en-US
In-Reply-To: <c663548b-29ee-4d23-a6b7-9a88eab5470e@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:vLW1j/pCUEETjWgjQHijYPMlZueAJgHBfURz2lA31zAYG9Cw/yp
 mcdci7kpu0a4HlgjxQeC9wmqbbGQsv7W99IRSveTq7AzOJzYY2y68KPEhMUJlC1XT2dkxBC
 /mHWWX6Wk8IhSkqEcFkG2McM7QWsQN8Pe4mM4IxSZMjOQav6mPaWyzy1B7KmlTrJy7kw8bW
 tPY1gXZyEF+plzO1HCVPw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:TKcmWMxWm+U=;Q58ScHdINVsebQBCuEc0tWievua
 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
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmx.de,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	R_DKIM_ALLOW(-0.20)[gmx.de:s=s31663417];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21240-lists,linux-acpi=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[W_Armin@gmx.de,linux-acpi@vger.kernel.org];
	DKIM_TRACE(0.00)[gmx.de:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-acpi];
	FREEMAIL_FROM(0.00)[gmx.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,gmx.de:mid,gmx.de:dkim,gmx.de:email]
X-Rspamd-Queue-Id: 993C41BD24F
X-Rspamd-Action: no action

Am 27.02.26 um 20:50 schrieb Armin Wolf:

> Am 26.02.26 um 19:46 schrieb Rafael J. Wysocki:
>
>> On Thu, Feb 26, 2026 at 7:35=E2=80=AFAM Armin Wolf <W_Armin@gmx.de> wro=
te:
>>> Am 25.02.26 um 22:28 schrieb Rafael J. Wysocki:
>>>
>>>> On Wed, Feb 25, 2026 at 12:06=E2=80=AFAM Armin Wolf <W_Armin@gmx.de> =
wrote:
>>>>> Am 04.02.26 um 22:29 schrieb Armin Wolf:
>>>>>
>>>>>> The ACPI spec states that the operating system should respond
>>>>>> to a fatal ACPI error by "performing a controlled OS shutdown in
>>>>>> a timely fashion". Comply with the ACPI specification by powering
>>>>>> off the system when ACPICA signals a fatal ACPI error. Users can
>>>>>> still disable this behavior by using the acpi.poweroff_on_fatal
>>>>>> kernel option to work around firmware bugs.
>>>>> Any updates on this?
>>>> I was about to apply it, but then I thought that I was not sure about
>>>> the Kconfig option.
>>>>
>>>> =C2=A0=C2=A0 I don't see much value in it TBH.=C2=A0 If you agree, I'=
ll just apply=20
>>>> the
>>>> patch without that part.
>>>>
>>>> Thanks!
>>> You can drop the Kconfig option if you want.
>> OK, applied as 7.1 material.
>>
>> Please double check
>> https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git/com=
mit/?h=3Dbleeding-edge&id=3D6f09a7009a1d7a132ddce3a8dd0c46aac66ad8e2=20
>>
>
> Looks good to me, except that the include of kconfig.h should be=20
> dropped now.
>
> Thanks,
> Armin Wolf
>
I also just noticed that we still need to include panic.h for add_taint().=
 Should i send
a new revision?

Thanks,
Armin Wolf


