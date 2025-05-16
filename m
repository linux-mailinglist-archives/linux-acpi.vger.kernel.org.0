Return-Path: <linux-acpi+bounces-13742-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 39008AB9569
	for <lists+linux-acpi@lfdr.de>; Fri, 16 May 2025 07:13:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A2F9A07DE6
	for <lists+linux-acpi@lfdr.de>; Fri, 16 May 2025 05:13:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5120F21CC70;
	Fri, 16 May 2025 05:13:51 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E127710E4;
	Fri, 16 May 2025 05:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747372431; cv=none; b=X9PR7WxxZpdznO+mF41+PmZt4zmBpsQXq1UTyGM30mC+akwgi7vdZG37hpfQOlRDAoElJ/NuWX2jg5JBmFZUQ6AxFmIbx6g7CYQkDIx3o1kCu6i/hKpj/oEHK/DOpGy11EkMst97RGy4d1cSp6qTtxzPUOnkh1mhY5X4q83Vtcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747372431; c=relaxed/simple;
	bh=eKp8lo6Qx6V1arvqE+jB4ho2QnzrhvvpIh/jHeGunvs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=M6WfcDrZDvsiKdAXUnlDpjkDr65tmrfFuEJZtbkZIXMvO43X/2qDCxp6TyjG0F0BEYpTTpxRXO/wREQKtPkPZl+UDRxVbGnRk7vA//T+9+TcS98WZLcennSO5BAn6wtSBng5VTdFWiEBlIPxMNBolXn01Va4P0q85H9Aiq0ZLcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 82f30d08321411f0b29709d653e92f7d-20250516
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45,REQID:34f36f89-905d-4fcc-bcc8-b818c3493781,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6493067,CLOUDID:a8be6d281134e9d6791eb22432fcdf2d,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102,TC:nil,Content:0|52,EDM:
	-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,
	AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 82f30d08321411f0b29709d653e92f7d-20250516
Received: from mail.kylinos.cn [(10.44.16.175)] by mailgw.kylinos.cn
	(envelope-from <zhangzihuan@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 1035424688; Fri, 16 May 2025 13:13:32 +0800
Received: from mail.kylinos.cn (localhost [127.0.0.1])
	by mail.kylinos.cn (NSMail) with SMTP id 6F392E003505;
	Fri, 16 May 2025 13:13:32 +0800 (CST)
X-ns-mid: postfix-6826C97C-3723227
Received: from [172.25.120.24] (unknown [172.25.120.24])
	by mail.kylinos.cn (NSMail) with ESMTPA id 1327CE006100;
	Fri, 16 May 2025 13:13:31 +0800 (CST)
Message-ID: <74beaec6-eae5-4456-9202-f77c71456682@kylinos.cn>
Date: Fri, 16 May 2025 13:13:31 +0800
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] ACPI: battery: Reduce unnecessary calls to
 acpi_battery_update()
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: lenb@kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250422091056.972734-1-zhangzihuan@kylinos.cn>
 <CAJZ5v0guh4MGJpaCoh3Guc8BL_37=KHWW10wvK+iD6jZLvZWwg@mail.gmail.com>
From: zhangzihuan <zhangzihuan@kylinos.cn>
In-Reply-To: <CAJZ5v0guh4MGJpaCoh3Guc8BL_37=KHWW10wvK+iD6jZLvZWwg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable

Hi Rafael,
Thank you for the review!

=E5=9C=A8 2025/5/10 02:23, Rafael J. Wysocki =E5=86=99=E9=81=93:
> On Tue, Apr 22, 2025 at 11:11=E2=80=AFAM zhangzihuan <zhangzihuan@kylin=
os.cn> wrote:
>> When entering the acpi_mattery_notify function, no matter what the eve=
nt
>> is, acpi_mattery_update will definitely be called.
> I think you mean acpi_battery_update().
Right.
>> Use the acpi_listen command to listen, sometimes the log looks like th=
is:
>>
>> battery xxx:00 00000081 00000001
>> battery xxx:00 00000000 00000001
>> battery xxx:00 00000080 00000001
>>
>> Firmware manufacturers will customize some events like 0x0, so
>> non-matching events will be ignored.
> I don't quite get what you are trying to achieve here.
>
While the laptop is charging, acpi_battery_notify() receives a steady=20
stream of 0x81 events, and only receives 0x80 events
when the battery is almost fully charged or the adapter is plugged in.=20
If acpi_battery_update() is just to
update the battery status,=C2=A0 it didn't need to be called frequently.
>> Signed-off-by: zhangzihuan <zhangzihuan@kylinos.cn>
>> ---
>>   drivers/acpi/battery.c | 3 ++-
>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/acpi/battery.c b/drivers/acpi/battery.c
>> index 6760330a8af5..9446c57b77e7 100644
>> --- a/drivers/acpi/battery.c
>> +++ b/drivers/acpi/battery.c
>> @@ -1083,7 +1083,8 @@ static void acpi_battery_notify(acpi_handle hand=
le, u32 event, void *data)
>>                  msleep(battery_notification_delay_ms);
>>          if (event =3D=3D ACPI_BATTERY_NOTIFY_INFO)
>>                  acpi_battery_refresh(battery);
>> -       acpi_battery_update(battery, false);
>> +       if (event =3D=3D ACPI_BATTERY_NOTIFY_STATUS)
>> +               acpi_battery_update(battery, false);
> So only call acpi_battery_update() for ACPI_BATTERY_NOTIFY_STATUS.
>
> Why do you think this is the only case in which acpi_battery_update()
> needs to be called?
acpi_battery_update() calls acpi_battery_get_status() to get the battery=20
update status. It will only be updated
if it receives an event that the battery status has changed.
>>          acpi_bus_generate_netlink_event(device->pnp.device_class,
>>                                          dev_name(&device->dev), event=
,
>>                                          acpi_battery_present(battery)=
);
>> --

