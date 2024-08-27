Return-Path: <linux-acpi+bounces-7911-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 105469619E7
	for <lists+linux-acpi@lfdr.de>; Wed, 28 Aug 2024 00:11:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3DB751C2162D
	for <lists+linux-acpi@lfdr.de>; Tue, 27 Aug 2024 22:11:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 427131D2F78;
	Tue, 27 Aug 2024 22:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="WnjcOj3y"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAEE1194A6C;
	Tue, 27 Aug 2024 22:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724796713; cv=none; b=eNSPgFPgKGMz5d617d3CWwnFjXN26ItB8pN39Oc5tHUBQ3El7WIcFMWsDO1yRm9X8d90arhhNln6V1JMxVDHmjgHrMT2Ci1hvYlNiy2cgrnR9xmxJ+tQ0VyQhyi8dznw4jBBfQt7WMePDOUllbC6+ymJtJKemGCLL81Ssj4Kn2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724796713; c=relaxed/simple;
	bh=2aRkULfSU9AzagsP0qiU8aDKlhnBG97zGMg4RSuUxLU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PVMLtpioEPfrW7Y1s0lMLyhyf+zfXFMswAREi6PAVfBnfD+eD6VfQZLfLeSHTizQZqbg+knDo0etEEclGxexQ/ug/KIRJi1zVyKtYRmC9Wrc8QG/RIwKey8aXQc9bMzDIzS0LaqxiC0ZRibyx/Vkt4WkdK0UwOw4p3mN9NLryD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=WnjcOj3y; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1724796694; x=1725401494; i=w_armin@gmx.de;
	bh=CUbnzYEtHJfLP1VcoboGTihEXYQaXcwV41vG7Efm3V8=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=WnjcOj3y6Z/mBoiw3tXOdjT5dd4vvbf7oUoSmRaBlzkfaGXGH1iIstF0Fe8A9rG8
	 K2BpE6af+qM0ddgXWnK+DaKbK8wvJbNclm186adOgSbvXnE1W2i8+UrgEAk3ffQjD
	 +Hs62U2hV0IMR8d4BWvnJ+eymoICwmU3G4SJOU0duzoR8k0VLk1UodhyeT5suoU0z
	 Md+kEUBQr0XBbuWKnxvVWT20u3vi+E9j4/M2BcLhx06roERU/5iyurToiEC6/qMDN
	 S0GHEtyEeAFfOGwtNW+l4+/Zb22J+f6pq2u3oKo0/aQn5l8mh8B72lfwBL016UWnG
	 7Jh/Ydm5/opQQCXgGg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [141.30.226.129] ([141.30.226.129]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MhD6W-1sDsJw2FQQ-00c1UX; Wed, 28
 Aug 2024 00:11:34 +0200
Message-ID: <1b84518a-9f6b-4083-a26b-c85188e23cff@gmx.de>
Date: Wed, 28 Aug 2024 00:11:31 +0200
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/5] hwmon: (hp-wmi-sensors) Check if WMI event data
 exists
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: james@equiv.tech, jlee@suse.com, corentin.chary@gmail.com,
 luke@ljones.dev, matan@svgalib.org, coproscefalo@gmail.com,
 Hans de Goede <hdegoede@redhat.com>, "Rafael J. Wysocki"
 <rafael@kernel.org>, lenb@kernel.org, platform-driver-x86@vger.kernel.org,
 linux-hwmon@vger.kernel.org, linux-acpi@vger.kernel.org,
 LKML <linux-kernel@vger.kernel.org>
References: <20240822173810.11090-1-W_Armin@gmx.de>
 <20240822173810.11090-3-W_Armin@gmx.de>
 <e791f8ed-f6af-d433-5c9b-a68fc9598dcc@linux.intel.com>
Content-Language: en-US
From: Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <e791f8ed-f6af-d433-5c9b-a68fc9598dcc@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1://U4Sw6iSSfjz3bI8Qyz5EOyGLzZPQwwffGRQNyCBIeBUoN+RHB
 ciJsCDkPhD9XpLTq0N8+H+kYxdh5qbKP88bZTPUiNP/VFtd4/6XFiqkeaszWc89VdDRa/9n
 GoRNyByoi/GuOsS/VDN9bKpkBGFyLE+v+M7RiB7zrkCdSaXunopYbkGAN2O1JBfgoNEN2m7
 fogMuE4u0bJWINGUQGdUA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:l3P7y/s2z6I=;S0J3w75s6//IgmFTPtwHNrBQQ/J
 RVJcItIr+PqrCw33o9/7w1T0SGphk82+2f21HgAWtp+B8IUKBlFvnRDTrh+I13nDgDYyGjsmb
 YauEb52w5eF4SuCZ3/rCo32AFJuf5WYwtx/k4y91zNWGZkvVftwyJPJ7r27f0kS5wV8G+ggGr
 i5nb3LVEyPYy9+WXAs2/yKBcL4RaLEZridbg1YUUDBaCol1j5a62P1A8Tn21fPzoQKJdy+MPm
 9TszEQ1T5RvHMByhWZZQVPkosnG6o5jNNqK0HS8IMabbjo3qa4j1avCOKnlZtkn+DH1Mz1eQG
 xipYvWnxfZy40DL6fTfjrDDpGvQ082l/2lF2fu+aLVqhIyG79Y09V1UecGcZmjSxf6/oBiVe1
 J5mSnXMRrxzl6PWvAo0806Jd77JXbqNzWKOJbxUbeFGL5XbnA6sIvQXfkIhpH+26b07VPJBSf
 bZzNRYOP86XqmDyhZqFMj+9bRzudPmvtNJGQ953q43Zcn6Mh+XVmCuqVVwCW9tk1n0Xk3x6Ef
 BssKLTpmGE9rCnrVC6NMsEDv6x7gV2mcwQ90cFd2wh3CS0h+koHXi4ebC4Ch9+2if2ldqhPDd
 0A6ODFdW2F9d8pnzlhgo0A8iF9r1U61G0fcfg7BVNS2xOiARSVAmUY984FhUJBTXi1V0T5V81
 t8yiIXe2B2VFdlPTcqrGZKgnnxM29KUMoT2r+xnipUsbvWYG3U26Zd1Ckeykp67w0asZpd+15
 lYLog01LNvUquHs/Hnn0o/htIR4S6uIIWtbXIpYNVOZHFH9asxD5LWclFwkDmAmbYBd+HAgCf
 TGtPPCEvxLK6shwrIZLTHlVQ==

Am 27.08.24 um 10:20 schrieb Ilpo J=C3=A4rvinen:

> On Thu, 22 Aug 2024, Armin Wolf wrote:
>
>> The BIOS can choose to return no event data in response to a
>> WMI event, so the ACPI object passed to the WMI notify handler
>> can be NULL.
>>
>> Check for such a situation and ignore the event in such a case.
>>
>> Signed-off-by: Armin Wolf <W_Armin@gmx.de>
>> ---
>>   drivers/hwmon/hp-wmi-sensors.c | 3 +++
>>   1 file changed, 3 insertions(+)
>>
>> diff --git a/drivers/hwmon/hp-wmi-sensors.c b/drivers/hwmon/hp-wmi-sens=
ors.c
>> index 6892518d537c..d6bdad26feb1 100644
>> --- a/drivers/hwmon/hp-wmi-sensors.c
>> +++ b/drivers/hwmon/hp-wmi-sensors.c
>> @@ -1628,6 +1628,9 @@ static void hp_wmi_notify(union acpi_object *wobj=
, void *context)
>>   	 * HPBIOS_BIOSEvent instance.
>>   	 */
>>
>> +	if (!wobj)
>> +		return;
>> +
> I'm left to wonder why is this patch is not placed first? Can't this
> happen regardless who gets the wobj? And in that case, should this have
> a Fixes tag?
>
Good point, i will send a v2 series to correct this.

Thanks,
Armin Wolf


