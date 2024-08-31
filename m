Return-Path: <linux-acpi+bounces-8028-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 436EE967298
	for <lists+linux-acpi@lfdr.de>; Sat, 31 Aug 2024 18:09:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A4C41C21255
	for <lists+linux-acpi@lfdr.de>; Sat, 31 Aug 2024 16:09:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9FD41EB5B;
	Sat, 31 Aug 2024 16:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=david-bauer.net header.i=@david-bauer.net header.b="lYI/X3a3"
X-Original-To: linux-acpi@vger.kernel.org
Received: from perseus.uberspace.de (perseus.uberspace.de [95.143.172.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D23572B9D6
	for <linux-acpi@vger.kernel.org>; Sat, 31 Aug 2024 16:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.143.172.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725120537; cv=none; b=ZwSwjkle5Nwt7ZKr9E6wfIDzsIZs1MqUYKxH8Lgivaff4dllnJZAvSoMY5MAJgBzoTHfrK//QNKByhTAwKcAMaY+t6M8APiQNHR8pZ8amAgLRTevg5kw/XRr11s2K+PkR//uC5chvPhksKXBL3n9K1/U2RNbBocrBg5FiJLQM60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725120537; c=relaxed/simple;
	bh=sELXf3L1lXL1KtimIQy38cvRJ7Cj8SygzuYy/lL24sg=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=fLDIMs0YpBP7pqSZv3cs1qlXDtl2zgMcQZOpCjDsDGq/afBgMTrs6jHooMsXVCEJrINBNqQagvLTqPdu6jmZTlrAhm/zM8lkZerlCngyTIVIZ6d25EGkKd++ecrOhGNAAXQRV6pY+PdBiEClx3qgbhujkU42qgP2Wxn1zcfP8mE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=david-bauer.net; spf=pass smtp.mailfrom=david-bauer.net; dkim=pass (4096-bit key) header.d=david-bauer.net header.i=@david-bauer.net header.b=lYI/X3a3; arc=none smtp.client-ip=95.143.172.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=david-bauer.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=david-bauer.net
Received: (qmail 14490 invoked by uid 988); 31 Aug 2024 16:08:51 -0000
Authentication-Results: perseus.uberspace.de;
	auth=pass (plain)
Received: from unknown (HELO unkown) (::1)
	by perseus.uberspace.de (Haraka/3.0.1) with ESMTPSA; Sat, 31 Aug 2024 18:08:51 +0200
Message-ID: <c9526f7a-a4d3-4e42-9225-3a12bc6cf148@david-bauer.net>
Date: Sat, 31 Aug 2024 18:08:50 +0200
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ACPI: EC: add quirk for Lenovo X13 G4 (AMD)
To: Mark Pearson <mpearson-lenovo@squebb.ca>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
 "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
References: <20240831003610.89970-1-mail@david-bauer.net>
 <84ec8f08-bc7b-490b-a6f3-0f41ca99dbc0@app.fastmail.com>
Content-Language: en-US
From: David Bauer <mail@david-bauer.net>
In-Reply-To: <84ec8f08-bc7b-490b-a6f3-0f41ca99dbc0@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Bar: ---
X-Rspamd-Report: BAYES_HAM(-2.999999) XM_UA_NO_VERSION(0.01) MIME_GOOD(-0.1)
X-Rspamd-Score: -3.089999
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=david-bauer.net; s=uberspace;
	h=from:to:subject:date;
	bh=sELXf3L1lXL1KtimIQy38cvRJ7Cj8SygzuYy/lL24sg=;
	b=lYI/X3a3Ls52ufCRqITnlxfA5vGjigd7IoaRM0XMYIN/MAk1vceL1T9FjK2u0EPmiwOIHwxk3i
	Dq9DyQy/b0ACwbqrrFVDl7BXhZyWKDnRx8Phu0ngZtbXKRpRDp4FBulCbE23Yqj18NWN8cHYPhIM
	QC3Xnu+bb+PkSouhF48MosnYyjxSwTpRP3MZ0JcYWxhvT+sACftEqBIqrpoWPFCweqBTayz9fPFU
	L2Ff2d4J44LSRCu3kBf5D3r7xqD1JugHZ3k7Kol9qw1sPBUsnpgeciZXf7iXOT911KOL/8inwEzi
	e974pSH7tz87aXyCFZJpB+OyrPNwAPbYixpFN1aWERrK5W+KA1ze3yS6HXClNeMlUhVFRv84wfK/
	1Ie4KyM4T07hwFNqgjv8TOxzNEDY+GGUy77QhF6OxUFcK0zWoaS2mIxESFrrvtwde38IW6fuS+Rd
	QPwYythjRDd6Rwu2SWAiTf/0msyYBn4YjRboiB+wyR7RgAKChTIRKxkzBANiAJdESzdiJfbawlp4
	mfW61V0O9XJYewJVkPqPik0ZFahYS1Y2ELVLOrRHPtPXr/xNOZPvfu706SOOFA+gZw10mFwHSIPP
	rDElhWH8Vqss+2QuoP+d8O/qaElL32qrFQ4GZd578zKC5Tm8rPhj+V55VPZrgeJ+Pk2qg+a/NQwd
	k=

Hey Mark,

thanks for your message.

On 8/31/24 02:53, Mark Pearson wrote:
> Hi David,
> 
> On Fri, Aug 30, 2024, at 8:36 PM, David Bauer wrote:
>> This adds a quirk for the Lenovo X13 Gen 4 AMD platform.
>>
>> If booted without the kernel-parameter acpi.ec_no_wakeup=1 the system
>> will resume from sleep upon change of AC state. Unplugging or plugging
>> the power cable thus wakes the system from suspend.
>>
>> Disabling wakeups from the embedded controller fixes this behavior.
>> Resuming by opening the lid stays functional.
>>
>> Only apply this fix for the AMD version, as it is unknown if the Intel
>> platform is also affected.
>>
>> This was observed on a system with the following BIOS / EC software:
>> BIOS: 1.28 (R29ET54W)
>> EC: 1.31 (R29HT55W)
>>
>> Signed-off-by: David Bauer <mail@david-bauer.net>
>> ---
>>   drivers/acpi/ec.c | 7 +++++++
>>   1 file changed, 7 insertions(+)
>>
>> diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
>> index 38d2f6e6b12b..f00cdcf06eb8 100644
>> --- a/drivers/acpi/ec.c
>> +++ b/drivers/acpi/ec.c
>> @@ -2252,6 +2252,13 @@ static const struct dmi_system_id acpi_ec_no_wakeup[] = {
>>   			DMI_MATCH(DMI_PRODUCT_FAMILY, "ThinkPad X1 Yoga 3rd"),
>>   		},
>>   	},
>> +	{
>> +		.matches = {
>> +			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
>> +			/* ThinkPad X13 Gen 4 (AMD) */
>> +			DMI_MATCH(DMI_PRODUCT_SKU, "LENOVO_MT_21J3_BU_Think_FM_ThinkPad X13 Gen 4"),
>> +		},
>> +	},
>>   	{
>>   		.matches = {
>>   			DMI_MATCH(DMI_SYS_VENDOR, "HP"),
>> -- 
>> 2.45.2
> 
> I believe you've hit the issue that is being tracked in https://bugzilla.kernel.org/show_bug.cgi?id=219196
> 
> We're working with Qualcomm to get that addressed. It impacts systems with the Qualcomm Wifi chip that uses the ath11k driver. I haven't specifically reproduced it on the X13 G4 - but we've seen it on three other platforms and it sounds exactly the same.
> 
> You can confirm by using a 6.9 kernel and it should work correctly. If it doesn't, please let me know and we can investigate further.
> This is a Linux certified platform and I'd rather get issues fixed correctly than have to quirk them in the kernel and potentially impact other functionality.

Understandable and i fully agree. I can confirm the wakeups do not occur 
on an older 6.9 kernel. So it's most likely the issue documented in the 
ticket.

I can also confirm that the wakes also happen when i disable Bluetooth 
and WiFi from within the BIOS and then boot Linux regardless of the 
kernel version.

Best
David

> 
> Thanks
> Mark

