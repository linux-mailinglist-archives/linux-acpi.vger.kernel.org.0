Return-Path: <linux-acpi+bounces-5744-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 507328C28F6
	for <lists+linux-acpi@lfdr.de>; Fri, 10 May 2024 18:53:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 733B61C22753
	for <lists+linux-acpi@lfdr.de>; Fri, 10 May 2024 16:53:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90CC716426;
	Fri, 10 May 2024 16:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="CpeLNlie"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 079631429A;
	Fri, 10 May 2024 16:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715359980; cv=none; b=DmGDD0ZJPUixzs9L1snRpWttTtrDvzac0CUqMzT8xsWQjxHHDy0a2lsKIc296sHCTC0NH8NXm7YFDDjjFBoBZEvFSMcXjv+Wu8nBj2jZaXLiIvEwgB7dvk/LQ/F4Bal69VRwIhcSNlZ91oXqcbS6BBVLjnf7TRof3y9L+vFmxy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715359980; c=relaxed/simple;
	bh=wobM+EUBnTvnR3c74kJs6/+/i326MO182y/6299O00s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=N9ZP90/Tk1aeg8EA70OaNVUdGSVdLPC48GvhjnLd9n4Fp2/cuQJkKM3z/qpyaXUoKXA7OR3reM+DUxHxRcB1+0DpX8BHYcl7rch+ZszzSJuEPSopv2J7GblGXQNlF/wZk39mF6b/cPLppfgc4CBD3wdJm+hwhvxAhu271PVBNQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=CpeLNlie; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1715359963; x=1715964763; i=w_armin@gmx.de;
	bh=mhQkjxX4w4Mf8leWb3/CRafMDhGUNfdMTpC/gKigdVs=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=CpeLNlieKIKBy+RC7bHVnYTvjxkaEwilqq14lnD8zAGJDvhsjFj0pfFPlCZDC0jJ
	 TC1U4g66lFDNRzBwj+V45eAj8MFxtI3wV7Y/v4pZvdWy/JddpXGhtvomwQ7ttRC7S
	 NcJUJllFJfMRGzTFpDpW8x+RxMCj4PxYITHVwas8xbrKWit+gl05akzS0xc1ZxCcW
	 NXPYKu5sms4dizQfBkrdH6RCFe96ybVfr+AJkfLzRaAykUOFiGfrQfUBVsaE2avvD
	 yGVTo3zWR34QWicWJYggT55V2/Tx6ExdkcPDB4PVrJz6JDnOylLHzGk55FBW84BKg
	 4nBYbzBUyM/l7UqMDQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [141.30.226.129] ([141.30.226.129]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mof9P-1sPiDK0iXB-00o0FB; Fri, 10
 May 2024 18:52:43 +0200
Message-ID: <568291fc-fd79-4f08-9eb7-aed7f5a32345@gmx.de>
Date: Fri, 10 May 2024 18:52:41 +0200
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/2] ACPI: EC: Install address space handler at the
 namespace root
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Linux ACPI <linux-acpi@vger.kernel.org>, LKML
 <linux-kernel@vger.kernel.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Hans de Goede <hdegoede@redhat.com>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Heikki Krogerus <heikki.krogerus@linux.intel.com>
References: <5787281.DvuYhMxLoT@kreacher> <4926735.31r3eYUQgx@kreacher>
 <ac04c433-b0ac-4b82-b8eb-98ac16f872d8@gmx.de>
 <CAJZ5v0g_NjGHRvhm-N5vQFnOsqnxExSq99v8n_B_6ANoaCga0w@mail.gmail.com>
Content-Language: en-US
From: Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <CAJZ5v0g_NjGHRvhm-N5vQFnOsqnxExSq99v8n_B_6ANoaCga0w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:65zII5bXn7iGnNlKowCzVpQpphVdt6/gLiy+9vE9bdqUagLeE1+
 8DYZyTLyqHq+vPT6WDRAwUdkfBRjzNzBuFl/y5BJgEC/asgrKEx1Zqp0VDYaosVcjneCsb3
 AYnkGLG6PzXyrU3mbUdN8dbeOE5iuVaMx+jJ7SAokboSK6CADSsFNPPjHmLu7jE0GG6YWbS
 BKtIY333VN27THAkvZbEA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:MxWBLCHTiOE=;zivxnuFUWIO8ZckWjLUWROWykZ7
 IviydntdKeRc4kvo42JvpZniPyQ3yS1z09840MYgFJLdbIP1Mg6AVJxPCw7aqd9yhU+WOtdD5
 /mhk2FSOTEhJTRyRc+U3BoUbKhcZ1IAqtcW/8GzDLOtVgfM5ieRcFFfP1phuT6G5Cb0X9NyVp
 iYiFFlTdhO+ZubE4uVRnFLTkOZ+VfcmFOJBl1hjoG3mDO1/ZOzcD10eNuvrYzmTIePKqczDkI
 wj5AnqXkdGSFqisiGUvdVphQBAkmCAeU/s8kfc1LRDOEIh+dTE//S7gvTkO4dkPGyEW0SSqJN
 5BZUBlZobNkWKK9fcH1XC5cCrfu6U7BtrSad7TYKf5sE0dS8KCdJPE5jMxUN+BjJz24xwsww2
 6u0fUBoDXhuh0XxSJxmokVgASvGKwPm06yECSKkvvGcoDcKQ23ygKoKrPSPh7K/13ijtP9mJb
 k7KgkuASAH9hvG7H4b4t/SM8Rikip6Sqe5NJHuypG/UL07aTJFbEkcLqCv3jxFexc/knej5Gx
 Z1C7LkheHRnalqP0JLXC/5jKgFcr3SVCMx59I26vKy8pCME/h+88IgGRyYLnKWRi1f8BAvuYL
 YnqVkswQOKtT+V4EZlaNA85DcijA5uU0njnpXOMr/lQbuwhPjBxJsBUGxDkatSZNrYxJszkL6
 9aODojqTgiw3j5UFnub+M/hyEMEkSS8yikQx9y8ivwJ++oeBMqr2hSfmWk51TVq4dZT5A5msl
 HjmM/ZYI8Vr8hfgSVhxPtc/C8ZTSvwPy3B+bjS1PFOz1C+HHSWfs0egr9h8AU+G3gpdq1JrvD
 MuBjemZsfc5oAjYpKpWqHHXLVVysmNLrZdh4XdSizzORM=

Am 10.05.24 um 18:41 schrieb Rafael J. Wysocki:

> On Fri, May 10, 2024 at 6:10=E2=80=AFPM Armin Wolf <W_Armin@gmx.de> wrot=
e:
>> Am 10.05.24 um 16:03 schrieb Rafael J. Wysocki:
>>
>>> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>>>
>>> It is reported that _DSM evaluation fails in ucsi_acpi_dsm() on Lenovo
>>> IdeaPad Pro 5 due to a missing address space handler for the EC addres=
s
>>> space:
>>>
>>>    ACPI Error: No handler for Region [ECSI] (000000007b8176ee) [Embedd=
edControl] (20230628/evregion-130)
>>>
>>> This happens because the EC driver only registers the EC address space
>>> handler for operation regions defined in the EC device scope of the
>>> ACPI namespace while the operation region being accessed by the _DSM
>>> in question is located beyond that scope.
>>>
>>> To address this, modify the ACPI EC driver to install the EC address
>>> space handler at the root of the ACPI namespace.
>>>
>>> Note that this change is consistent with some examples in the ACPI
>>> specification in which EC operation regions located outside the EC
>>> device scope are used (for example, see Section 9.17.15 in ACPI 6.5),
>>> so the current behavior of the EC driver is arguably questionable.
>> Hi,
>>
>> the patch itself looks good to me, but i wonder what happens if multipl=
e
>> ACPI EC devices are present. How would we handle such a situation?
> I'm wondering if this is a theoretical question or do you have any
> existing or planned systems in mind?
>
> ec_read(), ec_write() and ec_transaction() use only the first EC that
> has been found anyway.

Its a theoretical question, i do not know of any systems which have more t=
han
one ACPI EC device.

This patch would prevent any ACPI ECs other than the first one from probin=
g,
since they would fail to register their address space handler.
I am just curious if/how we want to handle such situations.

Thanks,
Armin Wolf


