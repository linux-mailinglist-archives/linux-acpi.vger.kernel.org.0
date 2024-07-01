Return-Path: <linux-acpi+bounces-6707-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F372491E4C0
	for <lists+linux-acpi@lfdr.de>; Mon,  1 Jul 2024 18:05:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AABE6283AC6
	for <lists+linux-acpi@lfdr.de>; Mon,  1 Jul 2024 16:05:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6A7B16727B;
	Mon,  1 Jul 2024 16:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="OzvLiVbu"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 303C51EB2A;
	Mon,  1 Jul 2024 16:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719849914; cv=none; b=ICB3h30z/yexNe6fRsrk/uso3bsMqGJV7354+7SIfePz3gEXIyzhqHJQr2WYCOxdVLxMuoqQQALmZS+oUQpAuTF8DAtmERI8eRf6EfzzfEdgM1BNcYvgsaJlqrxNgke4WNoJkNMH0bf1MiIQ8qPn3nX8pnvZoCy5vGtPPh6eO68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719849914; c=relaxed/simple;
	bh=lhamLxssCzkjxOeUar7vMfjTkdL0ujnbTccKlDX8Opc=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=gy3i8JqUnhls/m+Pdwr6qC/DZWuSVhwrzur35n6pY4pgqFnde3cCi1Xqj3wPwwARoGsg/hYYnh9Wmpz4FRmuWYbr6MCTTLJv6RhDLojeQ/jmilZaCl1IKZ0yuCpkXipHvP4UWxP0JObex11GMReTX2fpbsyWO05fxbRZfzonNv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=OzvLiVbu; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1719849905; x=1720454705; i=w_armin@gmx.de;
	bh=CdGU7eC+qMJeNREwkW0NoXjqnQktnRTm01J5sGioeXk=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:From:To:
	 Cc:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=OzvLiVbuwqjPw5kgEiFRIvCEiGzn7iR7Q187HbznNj41SFnoO1xR+lQccyuXUxBx
	 get21u70zMHOgNOn7xM+BrsKKZuioZ8wDuDHBIHdiMRV7kG4ScEbZ0vsr2xxVpeA9
	 7IB8lxlQ60MMCr4k6HJnioJDmPc0PL5UeEbR19q0p//tiFT8/3f3PDwNWe80XKEpe
	 6vu4nfZMenmSm6UWOF/pJiPFTWsRHRVu3rFwV/C/6YTKG16uyY2hh1XBDmiL/15ds
	 aypm0ZrbO4lwS24MpnVVwBmfcm0yCFYJSbiHn7r/Obf+3m+WQ+AfiW31CvwiXCEFe
	 mBzhhTrPZAuyUq8fNA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [141.30.226.129] ([141.30.226.129]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MatRZ-1rquNu2C1j-00mqSR; Mon, 01
 Jul 2024 18:05:05 +0200
Message-ID: <1240c064-9321-4817-bae2-55687005990a@gmx.de>
Date: Mon, 1 Jul 2024 18:05:05 +0200
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] ACPI: bus: Indicate support for battery charge
 limiting thru _OSC
From: Armin Wolf <W_Armin@gmx.de>
To: rafael@kernel.org, lenb@kernel.org
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240620191410.3646-1-W_Armin@gmx.de>
 <20240620191410.3646-2-W_Armin@gmx.de>
Content-Language: en-US
In-Reply-To: <20240620191410.3646-2-W_Armin@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:OgeEkorGtvmJdTnzJ4k5uJpUeooTvUmkfoUOVPWNUOMZEGeW5Ja
 ibWabv4EZJLTA/gznX3XuPI5+9DBSnVTgKvOckIAxxcDLStCjoJMIJsIhOWwD/zTn16PUPR
 dRZDGzWzRTVy7htdVeU5dQP6j8M2F42ZN8BLXH3zhaVbIowVafUCHEbykMNdEHq6XhQvqfh
 JPLVqmhtPBX51MucGxTqw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:YpdjvBXLOZE=;mhROOKY+0p4qAENhlKOSFWHEDWG
 nIY0+HMo6wv4ZMc8B1BFqeA5YqvS72z93DTL5CUhXjjgDBxd6nfCQlL9ZMLatBzde8jjGX225
 fw1ysxrrkJwq1w664C6RT0Nt1iqxtMsGH/W4+czCsrMRFWQwhScIEZ97+HHnEYb2QM/+K8zqe
 XHFN0pgQEz45y5KTi50IbND6OPaEGqikIUpgIGMBEeaEURQkIe+pN4Ub8TbYARBKTw13MeXfB
 0t5XTrAPpwrHEyI/N64bfgqO4Yi1czFuWN+MMAFDr7M2Wobj87C58cMTLEQWFsTr4iqudZlHz
 49wSKoTYecFB3LpsvhRDeZ2w6L8phfVkW24tL26nJqZPClvyhpvQ4sW0efHWASrnJeSyh8pmF
 E5/t/SjEO2oV4Z4GVg7eZ7IuuMsPSPe9H1X3t4SYgSaplaW9WURoGqtBv26t7S8oRYKMri9w6
 4G9VfQwfukEh9bSccwyH/BnI6ffrMgfh49mgP+2SGuEVABlQ5bc3U1p1xkW4Q5V0sVqNGeF6x
 VtRxihs8b65N3BxlRQPe5RgeznE9Sgc9c1tqeP26NcUHIxZIuDVRQW6AcC0y/Y4f1/us5nNm1
 AbKLP1yQ9Z7lSVts6U6t8VbrbMjtO++oQFqA2mbeA+IB3MKBvsKqaDleeSEcvP4NEtjqOqvDJ
 QANbgbDif4JzxkW2QI4yvhN1p8YbhrSQTBHoHP3x4yNPbkZl0qEEEq5DK/9pYlYPXi8jyxsMS
 XgCvn0FqnoSJQUvu9X6eD/LumYRBfwl405/i388G2TAgo2dS+c2pVH90FVwfD0AWaCqp93K80
 BJ9+oGVNP0dcmqtd91r1b88CkY4oYWSblqIx6j+jKxMUk=

Am 20.06.24 um 21:14 schrieb Armin Wolf:

> The ACPI battery driver can handle the "charge limiting" state
> of the battery, so the platform can advertise this state.
>
> Indicate this by setting bit 19 ("Battery Charge Limiting Support")
> when evaluating _OSC.
>
> Tested on a Lenovo Ideapad S145-14IWL.

What is the status of this?

Thanks,
Armin Wolf

>
> Signed-off-by: Armin Wolf <W_Armin@gmx.de>
> ---
>   drivers/acpi/bus.c   | 2 ++
>   include/linux/acpi.h | 1 +
>   2 files changed, 3 insertions(+)
>
> diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
> index 787eca838410..bdbd60ae8897 100644
> --- a/drivers/acpi/bus.c
> +++ b/drivers/acpi/bus.c
> @@ -329,6 +329,8 @@ static void acpi_bus_osc_negotiate_platform_control(=
void)
>   		capbuf[OSC_SUPPORT_DWORD] |=3D OSC_SB_PPC_OST_SUPPORT;
>   	if (IS_ENABLED(CONFIG_ACPI_THERMAL))
>   		capbuf[OSC_SUPPORT_DWORD] |=3D OSC_SB_FAST_THERMAL_SAMPLING_SUPPORT;
> +	if (IS_ENABLED(CONFIG_ACPI_BATTERY))
> +		capbuf[OSC_SUPPORT_DWORD] |=3D OSC_SB_BATTERY_CHARGE_LIMITING_SUPPORT=
;
>
>   	capbuf[OSC_SUPPORT_DWORD] |=3D OSC_SB_HOTPLUG_OST_SUPPORT;
>   	capbuf[OSC_SUPPORT_DWORD] |=3D OSC_SB_PCLPI_SUPPORT;
> diff --git a/include/linux/acpi.h b/include/linux/acpi.h
> index bb18e7bf8826..b9d6882f323e 100644
> --- a/include/linux/acpi.h
> +++ b/include/linux/acpi.h
> @@ -576,6 +576,7 @@ acpi_status acpi_run_osc(acpi_handle handle, struct =
acpi_osc_context *context);
>   #define OSC_SB_CPC_FLEXIBLE_ADR_SPACE		0x00004000
>   #define OSC_SB_GENERIC_INITIATOR_SUPPORT	0x00020000
>   #define OSC_SB_NATIVE_USB4_SUPPORT		0x00040000
> +#define OSC_SB_BATTERY_CHARGE_LIMITING_SUPPORT	0x00080000
>   #define OSC_SB_PRM_SUPPORT			0x00200000
>   #define OSC_SB_FFH_OPR_SUPPORT			0x00400000
>
> --
> 2.39.2
>
>
>  From mboxrd@z Thu Jan  1 00:00:00 1970
> Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
> 	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
> 	(No client certificate requested)
> 	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 311791B4C49;
> 	Thu, 20 Jun 2024 19:14:26 +0000 (UTC)
> Authentication-Results: smtp.subspace.kernel.org; arc=3Dne smtp.client-i=
p!2.227.15.19
> ARC-Seal:i=3D a=3Drsa-sha256; d=3Dsubspace.kernel.org; s=3Darc-20240116;
> 	t=1718910869; cv=3Dnone; b=3DPNV4pnv5gdeDQ6rB2hU1/ZjHVFLTc57fDIDsaOLhos=
raq8aj2nG78LkoXubdSkBQZj2o0ASSObniw4/Fr+kBxA9iY2cRtFzQ+xFjevfYjlIsIlMrHler=
ntx5q0p7BBt1PgbHMZ9NHxYlRZr6zLsCzdeT6JqAXSNrP1N20H2H5WAARC-Message-Signatu=
re:i=3D1; a=3Drsa-sha256; d=3Dsubspace.kernel.org;
> 	s=3Dc-20240116; t=1718910869; c=3Drelaxed/simple;
> 	bh=3D7d2nU/1EXglGqyMknsqP4KzMVjfNITvBaD0xtbb8U=3D;
> 	h=3DFrom:To:Cc:Subject:Date:Message-Id:MIME-Version; b=3DFSSGUWdjXpIOmk=
B5tG0jHhXkNWu6Yh/Ms7qA6VzQ2ek91bTYG1FbBHECiLveTd7nNZdecgHbq0UE688Zc7qgvG3z=
9b9MwO/ZOc8rA9KM2UkBaFhacVjQtFe0AotjWA07QNlmsTTnbkB1ywNKCse77kiM/g3sStU2yq=
nGaeZktmUARC-Authentication-Results:i=3D1; smtp.subspace.kernel.org; dmarc=
=3Dpass (p=3Dquarantine dis=3Dnone) header.from=3Dgmx.de; spf=3Dpass smtp.=
mailfrom=3Dgmx.de; dkim=3Dpass (2048-bit key) header.d=3Dgmx.de header.i=
=3Dw_armin@gmx.de header.b=3DXxTpuznq; arc=3Dnone smtp.client-ip!2.227.15.=
19
> Authentication-Results: smtp.subspace.kernel.org; dmarc=3Dss (p=3Dquaran=
tine dis=3Dnone) header.from=3Dgmx.de
> Authentication-Results: smtp.subspace.kernel.org; spf=3Dss smtp.mailfrom=
=3Dgmx.de
> Authentication-Results: smtp.subspace.kernel.org;
> 	dkim=3Dss (2048-bit key) header.d=3Dgmx.de header.i=3Dw_armin@gmx.de he=
ader.b=3D"XxTpuznq"
> DKIM-Signature: v=3D a=3Drsa-sha256; c=3Drelaxed/relaxed; d=3Dgmx.de;
> 	s=3D1663417; t=1718910856; x=1719515656; i=3Dw_armin@gmx.de;
> 	bh=3DxDuAxw0I5rokPnnN/NN9/gOvD5EFn1E9laPeck6iA=3D;
> 	h=3DX-UI-Sender-Class:From:To:Cc:Subject:Date:Message-Id:
> 	 MIME-Version:Content-Transfer-Encoding:cc:
> 	 content-transfer-encoding:content-type:date:from:message-id:
> 	 mime-version:reply-to:subject:to;
> 	b=3DTpuznqa5s0SpQ6YdBrvZNwCXRJ0edFeG7RwA4nafWEyqJXBNYwkwFHqkAwFph/
> 	 obu4vTPFY+7Qo8UXInbPMrj96MAUMv7WH+7KynWZbaU6jWpmgpfI3EtAqC0iGv7tB
> 	 R6/iC0NBkzpWYJe/A+3dBrppWvzsVla1nGnwu66kc6DXtUyEZ/Znr8eFMdKXi77bu
> 	 +xt7LGs4mr+Swymo1EOxUvTy59CZERil76zkUyBO9n3ndytFj8qd11eeWXYQwZGYP
> 	 y9QhxcX50jwPqpUX5rCcdjiU6Z6DT0uJoGV+4O4YWpCBzUpj4V+Bq1MYzUKtq/GeN
> 	 ytkbdoU/jbWr0NIakw=3DX-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01=
a50d3a
> Received: from mx-amd-b650.users.agdsn.de ([141.30.226.129]) by mail.gmx=
.net
>   (mrgmx004 [212.227.17.190]) with ESMTPSA (Nemesis) id
>   1N8XTv-1sP43t1c9p-015xmJ; Thu, 20 Jun 2024 21:14:16 +0200
> From: Armin Wolf <W_Armin@gmx.de>
> To: rafael@kernel.org,
> 	lenb@kernel.org
> Cc: linux-acpi@vger.kernel.org,
> 	linux-kernel@vger.kernel.org
> Subject: [PATCH 1/2] ACPI: battery: Add support for charge limiting stat=
e
> Date: Thu, 20 Jun 2024 21:14:09 +0200
> Message-Id: <20240620191410.3646-1-W_Armin@gmx.de>
> X-Mailer: git-send-email 2.39.2
> Precedence: bulk
> X-Mailing-List: linux-acpi@vger.kernel.org
> List-Id: <linux-acpi.vger.kernel.org>
> List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
> List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
> MIME-Version: 1.0
> Content-Transfer-Encoding: quoted-printable
> X-Provags-ID: V03:K1:uNBDOBDXPCELTkGamOlx2L0j/W2Zhplj2lD9/D7v5T+apEJnnw9
>   YiM8dfeyyR6Sy2iqGvBwBDR6TNNFBsC9VaQzIPF0Zi5MqlrWxVwPMPuZuRC8nQgDl6lfsI=
T
>   NNaneKZl8AKNkuZEFKyFzA3bTq9rBVXFdlx/onmHI+b7i3oAv8ZBdY2ucgGs31HLhjlPCC=
Z
>   eV4atUc4q9u9vxLvvUQpg=3DX-Spam-Flag: NO
> UI-OutboundReport: notjunk:1;M01:P0:1ivwSHmpePc=3DSM9rr41Wuw5kjzAoyyV5tk=
2mIl
>   i3jkEV278EZxI7Tk/3ljPtMJcjPoU7q2SD0TKmrBG8zaCd1wn9zF183BELhNv0Vz6fxEa1=
Op0
>   CYjwyMDqZHupFczhdiADcP3WdB53f9HVAK0KB+USScSkLgiu1AGKwkoHNnhLvXxK6K0vaN=
csZ
>   A8iThkF8WUgig558RbKPTTVjpE4yyI5xeuJ8m5wxTj/BvHcenpIuXOFPuhmIZAETe+JbVj=
ZyY
>   kdVion2B/yeZ+WS2V2FVwbyh1s9sXNLNvioudWhER+U7rEqykfYIHoJll5px93LumYyval=
SNo
>   b6b4eAt5FMXefwAdhc1WQaf9LcUuXwTvLBJxDVMmk+MToV0W9eRkYanJbW/YAune218sx7=
M3w
>   UyTwWk5eBSckWg2GFCz8zjLJ62pYXFWo2gC3d8UVVmSG+sudcgEBjyaDxaVHF6WPfRl2Ny=
heG
>   /ss80HzssXQwewBtvvvm4QzyloC5TNoD9KaORUWWFYYKO7xMg0avbO33Z0vEV9kqMsTSa1=
Wel
>   wb0JtzFQhnBIRS1/ulhAjNtrKVtMQzBqLiDPgmUUv8zfMxoLhiYpMagXzvDQCoc5Buzr6F=
gvH
>   jDhA3MuPWGLufg+nCVMyiOsYRArwG52PSBbF107eEPGxEkM3igcCkaprQVTZv+huO+fSOV=
K/Y
>   YSw1InfHXFjx9mRga1WvahMB06QO7rCfD7/3H4ht8+hLQxPIn4J/gyFGXLRkdumLXtayoU=
7kh
>   nEAPyxyGRIMZOmvO0O2EHYiwveoCWIc7U+2D+KnQ6UnaZ/nQmLJ/1XtzCA2dRL6V4tefU6=
9Qy
>   1dWpymJu7A6bbYvJ5cBYL7zeMf8Q3zp1OitpB8c7FIj0g
> The ACPI specification says that bit 3 inside the battery state
> signals that the battery is in charge limiting state. In this state,
> the platform limits the battery from reaching its full capacity, the
> exact limit is platform-specific.
>
> This might explain why a number of batteries reported a "Unknown"
> battery state in the past when using platform-specific interfaces to
> stop battery charging at a user defined level.
>
> Unfortunately not all platforms set this bit in such cases, so
> "non-charging" is still the default state when the battery is neither
> charging, discharging or full.
>
> Tested on a Lenovo Ideapad S145-14IWL.
>
> Signed-off-by: Armin Wolf <W_Armin@gmx.de>
> ---
>   drivers/acpi/battery.c | 11 +++++++----
>   1 file changed, 7 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/acpi/battery.c b/drivers/acpi/battery.c
> index d289b98a2cca..9ba2191a96d6 100644
> --- a/drivers/acpi/battery.c
> +++ b/drivers/acpi/battery.c
> @@ -38,9 +38,10 @@
>   /* Battery power unit: 0 means mW, 1 means mA */
>   #define ACPI_BATTERY_POWER_UNIT_MA	1
>
> -#define ACPI_BATTERY_STATE_DISCHARGING	0x1
> -#define ACPI_BATTERY_STATE_CHARGING	0x2
> -#define ACPI_BATTERY_STATE_CRITICAL	0x4
> +#define ACPI_BATTERY_STATE_DISCHARGING		0x1
> +#define ACPI_BATTERY_STATE_CHARGING		0x2
> +#define ACPI_BATTERY_STATE_CRITICAL		0x4
> +#define ACPI_BATTERY_STATE_CHARGE_LIMITING	0x8
>
>   #define MAX_STRING_LENGTH	64
>
> @@ -155,7 +156,7 @@ static int acpi_battery_get_state(struct acpi_batter=
y *battery);
>
>   static int acpi_battery_is_charged(struct acpi_battery *battery)
>   {
> -	/* charging, discharging or critical low */
> +	/* charging, discharging, critical low or charge limited */
>   	if (battery->state !=3D 0)
>   		return 0;
>
> @@ -215,6 +216,8 @@ static int acpi_battery_get_property(struct power_su=
pply *psy,
>   			val->intval =3D acpi_battery_handle_discharging(battery);
>   		else if (battery->state & ACPI_BATTERY_STATE_CHARGING)
>   			val->intval =3D POWER_SUPPLY_STATUS_CHARGING;
> +		else if (battery->state & ACPI_BATTERY_STATE_CHARGE_LIMITING)
> +			val->intval =3D POWER_SUPPLY_STATUS_NOT_CHARGING;
>   		else if (acpi_battery_is_charged(battery))
>   			val->intval =3D POWER_SUPPLY_STATUS_FULL;
>   		else
> --
> 2.39.2
>
>

