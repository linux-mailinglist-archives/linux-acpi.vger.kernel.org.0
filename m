Return-Path: <linux-acpi+bounces-15422-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 86A8CB16508
	for <lists+linux-acpi@lfdr.de>; Wed, 30 Jul 2025 18:49:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF7A2171FAF
	for <lists+linux-acpi@lfdr.de>; Wed, 30 Jul 2025 16:49:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 874AE2DCF45;
	Wed, 30 Jul 2025 16:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="s0HRWjhO"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CAAC19FA93;
	Wed, 30 Jul 2025 16:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753894181; cv=none; b=uQg1g1ZhLpbFyXK+BzpS3ED33ZKAo1edAWbHzQp8A0nCbUtt2AwbwzpikguizZ40dIHCARsXBCfMk7WaGyEm2jIGK8fuAwkSqzDra4uDErWiRRoiuwpEYM4EeIpY69HK21lYGLmFh98a6D0flUMobf1yL7NHJXLNRmqdD+aDfns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753894181; c=relaxed/simple;
	bh=8IWg4D0A127Ud77sz80AqKP9QaA37XJBRXx5golNszw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YeQYYdz6p8C+K83E/4QzLso54VFeHCc1l+t/z3r5BQST3eJaacUecfJT2P4UVuU4VZEoef3LrBYYUE9e+Lewt5vIaix7Bjt3t/OtVZEf1ErS3+Sp4Altvi37yQ4RLi4gv1p8UMKnSZmp9KcYj14/6aYY67vzVDU1T/v7zRclD5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=s0HRWjhO; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1753894171; x=1754498971; i=w_armin@gmx.de;
	bh=rtYohrdBlhN/r00M1EQA7z6XtSBmhzdN5scRpOf2SYw=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=s0HRWjhOIoWSjPwllD95xkUoNg74oPRvLafbbU72Y7qZLuQht4x7Wgx+nAf+fxFG
	 re1NX9dlZKE/u/e0Eqi9nYtctaHC4zBt9aPqvLbgFfErRziz3/eq2dEc6oDFZg37F
	 AfdGsmSXcHVmBic1fIw9dO5AENlHH2W37KuCdi/igkO8ahCEOScxIJD7vwUBbfPqy
	 oc0rf9nCMXapIIFMbL1iwhSo01klDJRJgwCuYLvKS/o27algJDAgcfyuUANb/6E9f
	 rFNp7k1OHTrLsMEK7DrJjITmZXxN8ug/DgQH9NDRYa3EUYCO4kC/TsQ6YqTBojGCF
	 sYyIuIFJA4QSvie0hA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.0.69] ([87.177.78.219]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N3bSt-1uYBth2RQx-017tBF; Wed, 30
 Jul 2025 18:49:30 +0200
Message-ID: <d8f9875b-03be-465b-9715-addd8334a782@gmx.de>
Date: Wed, 30 Jul 2025 18:49:29 +0200
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ACPI: EC: Relax sanity check of the ECDT ID string
To: Ilya K <me@0upti.me>, rafael@kernel.org, lenb@kernel.org
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250729062038.303734-1-W_Armin@gmx.de>
 <e911ca96-fe8f-4cc5-bf68-f20ec7da46be@0upti.me>
Content-Language: en-US
From: Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <e911ca96-fe8f-4cc5-bf68-f20ec7da46be@0upti.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:h06vpeGl/KQFRXcysy+3W4RHci0G2c5v8QP7e5JK5+kPDRmnaxv
 kLZaeAiLHN8smi+oaCQiQQ5yFsWkKqpVbTU6/gFqgOIygAU5H8wkfW6EaOqbghlvZG4ntzE
 f/NRywof+5g5Czorw6YaE9PcfXDbiqapH8sOhYJpYLev0hOUm5IDh/5i1ON50ak8BdCPv/p
 55Fwe1g569U4zWQ5oK1JA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:BZJm1AsMKqI=;PaWdNKDvCDWf1sWkZs4KBvuFd0K
 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
 ISHapOoQZENzgj3VikypNvo=

Am 29.07.25 um 09:00 schrieb Ilya K:

> On 2025-07-29 09:20, Armin Wolf wrote:
>> It turns out that the ECDT table inside the ThinkBook 14 G7 IML
>> contains a valid EC description but an invalid ID string
>> ("_SB.PC00.LPCB.EC0"). Ignoring this ECDT based on the invalid
>> ID string prevents the kernel from detecting the built-in touchpad,
>> so relax the sanity check of the ID string and only reject ECDTs
>> with empty ID strings.
>>
>> Compile-tested only.
>>
>> Reported-by: Ilya K <me@0upti.me>
>> Fixes: 7a0d59f6a913 ("ACPI: EC: Ignore ECDT tables with an invalid ID s=
tring")
>> Signed-off-by: Armin Wolf <W_Armin@gmx.de>
>> ---
>>   drivers/acpi/ec.c | 10 +++++++---
>>   1 file changed, 7 insertions(+), 3 deletions(-)
>>
> Thanks, this works!
>
> Tested-by: Ilya K <me@0upti.me>
>
>> diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
>> index 75c7db8b156a..7855bbf752b1 100644
>> --- a/drivers/acpi/ec.c
>> +++ b/drivers/acpi/ec.c
>> @@ -2033,7 +2033,7 @@ void __init acpi_ec_ecdt_probe(void)
>>   		goto out;
>>   	}
>>  =20
>> -	if (!strstarts(ecdt_ptr->id, "\\")) {
>> +	if (!strlen(ecdt_ptr->id)) {
>>   		/*
>>   		 * The ECDT table on some MSI notebooks contains invalid data, toge=
ther
>>   		 * with an empty ID string ("").
>> @@ -2042,9 +2042,13 @@ void __init acpi_ec_ecdt_probe(void)
>>   		 * a "fully qualified reference to the (...) embedded controller de=
vice",
>>   		 * so this string always has to start with a backslash.
>>   		 *
>> -		 * By verifying this we can avoid such faulty ECDT tables in a safe =
way.
>> +		 * However some ThinkBook machines have a ECDT table with a valid EC
>> +		 * description but an invalid ID string ("_SB.PC00.LPCB.EC0").
>> +		 *
>> +		 * Because of this we only check if the ID string is empty in order =
to
>> +		 * avoid the obvious cases.
>>   		 */
>> -		pr_err(FW_BUG "Ignoring ECDT due to invalid ID string \"%s\"\n", ecd=
t_ptr->id);
>> +		pr_err(FW_BUG "Ignoring ECDT due to empty ID string\n");
>>   		goto out;
>>   	}
>>  =20
> Would it maybe make sense to also log a warning for the old case? Maybe =
a vendor will notice it and fix the firmware...
> (yeah yeah fat chance)

The Linux kernel is not a verification kit, so i am against keeping the ol=
d check. Instead i suggest that we ensure that
the FWTS project (https://github.com/fwts/fwts) detects such invalid ECDT =
tables. Can you share the full output of
acpidump so that i can run the fwts tool on it?

Thanks,
Armin Wolf


