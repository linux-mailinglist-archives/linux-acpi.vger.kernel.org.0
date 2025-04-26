Return-Path: <linux-acpi+bounces-13306-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89809A9DDA7
	for <lists+linux-acpi@lfdr.de>; Sun, 27 Apr 2025 00:52:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C66A617C626
	for <lists+linux-acpi@lfdr.de>; Sat, 26 Apr 2025 22:52:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 294521FCCF8;
	Sat, 26 Apr 2025 22:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="L95TWp1n"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 280597081E;
	Sat, 26 Apr 2025 22:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745707960; cv=none; b=gnhpdxZQMNk+ryhm8Xvj1LjSy3KwzQpYBS1HFP2WF1ezNzfgvOyFlh8/ORQwLk3KpwgMZXt8o2vWcq2h4ej9dQdqVv6CqpRAqSMjJos+ohskeKXe5ElOFC8LI/noNnNZ9deugVggT8u9RObgG2yMAso0L45UvpQDzjca4CIPciI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745707960; c=relaxed/simple;
	bh=6FMljxDfwcPHMjoI6emPrT1PM9bcxdN0GYxMB+ekWOo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fFqS+N/Pk+1NgdicmWRxEeGcJnCM30KHn+71jeP79Xe9Z9A4Vajk/rviPnBHmLXzLAWm+Gcciln7qkf7dxXAwbDa9TKbYKPcg/9wmS08hGj3AlWVvpNe0+LfnyX5gSffevvz5gETZYVewiFiZKuChgbPrNQ0fI9aF1qG3asSLlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=L95TWp1n; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1745707955; x=1746312755; i=w_armin@gmx.de;
	bh=15293qI1XNxR0MSTBcL5RXPAlIBx3AIDveUQvBF+ZEU=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=L95TWp1n9TS6CBQX+awhhKE5zvIZhDnkCFgD28u4cTtxCBXEhXgnOh796P2hupTh
	 QlPFjQ6ljXOuQB2sTymtcr02zJBIKJElMtvVIFXDN59ilhiJEdCqvVzxckQsikSGa
	 v2bSsD3CerecrVoKbdiAkTSxih0FogqAvhUZCODgEqiQur5rgfc5Y8f8T+Z5xAJ4W
	 Ob477Iqv2vw7WPdf0h/yMHbsRSCMO8OJTkLapPZECPOlAsQWu/eJZ3QjuDewz8oIG
	 Eb/7uKQRdnMLvalzFxyCSZ9kNUS1Hg8EKZtYi5rFrKChZWI6C2qhq/2KJxBBcr0Xs
	 Zmu6f4cdybNVgSF1wA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.0.69] ([87.177.78.219]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MbivM-1ufPJc3MgY-00oALI; Sun, 27
 Apr 2025 00:52:35 +0200
Message-ID: <90cba8fa-e6a9-4dab-a4ea-fa96d570a870@gmx.de>
Date: Sun, 27 Apr 2025 00:52:33 +0200
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] ACPI: thermal: Properly support the _SCP control
 method
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: rui.zhang@intel.com, lenb@kernel.org, linux-acpi@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250410165456.4173-1-W_Armin@gmx.de>
 <91ea8aed-5f98-4e4e-b3ee-fdc86d54f787@gmx.de>
 <CAJZ5v0jOR9=jA=8XASBpxJyXaB4TvXmxcZQWq1qUgq1J4h_tEg@mail.gmail.com>
Content-Language: en-US
From: Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <CAJZ5v0jOR9=jA=8XASBpxJyXaB4TvXmxcZQWq1qUgq1J4h_tEg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:OuHZIsC2fwZx17zO2hzjP/GMjtTW/RTswwcvSw5/Kdh0OOiLlkR
 6VXwUAEqmz7LK5BCXv4CDRyjlGB3pZjkA5chNmZCt29QkEdQQCtxOvMowmIOzYN8ZHFD45K
 3xzKYLtudtCJvDRVVpDGrlH7zTrixIIzJVtQm6R8h45jRZojZeIpT2xqlj32VI/QnrKhON0
 WgV+cwOpJVznVM3JCepqA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:sLm2Fy5L5A0=;H0f6RguWyDWCYpnabi4asvPTmQT
 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
 k1SkCrs8gXnAsA3l4q2dPk=

Am 26.04.25 um 15:12 schrieb Rafael J. Wysocki:

> On Sat, Apr 26, 2025 at 1:20=E2=80=AFAM Armin Wolf <W_Armin@gmx.de> wrot=
e:
>> Am 10.04.25 um 18:54 schrieb Armin Wolf:
>>
>>> The ACPI specification defines an interface for the operating system
>>> to change the preferred cooling mode of a given ACPI thermal zone.
>>> This interface takes the form of a special ACPI control method called
>>> _SCP (see section 11.4.13 for details) and is already supported by the
>>> ACPI thermal driver.
>>>
>>> However this support as many issues:
>>>
>>>    - the kernel advertises support for the "3.0 _SCP Extensions" yet t=
he
>>>      ACPI thermal driver does not support those extensions. This may
>>>      confuse the ACPI firmware.
>>>
>>>    - the execution of the _SCP control method happens after the driver
>>>      retrieved the trip point values. This conflicts with the ACPI
>>>      specification:
>>>
>>>        "OSPM will automatically evaluate _ACx and _PSV objects after
>>>         executing _SCP."
>>>
>>>    - the cooling mode is hardcoded to active cooling and cannot be
>>>      changed by the user.
>>>
>>> Those issues are fixed in this patch series. In the end the user
>>> will be able to tell the ACPI firmware wether he prefers active or
>>> passive cooling. This setting will also be interesting for
>>> applications like TLP (https://linrunner.de/tlp/index.html).
>>>
>>> The whole series was tested on various devices supporting the _SCP
>>> control method and on a device without the _SCP control method and
>>> appears to work flawlessly.
>> Any updates on this? I can proof that the new interface for setting the=
 cooling mode
>> works. Additionally the first two patches fix two issues inside the und=
erlying code
>> itself, so having them inside the mainline tree would be beneficial to =
users.
> Sure.
>
> I'm going to get to them next week, probably on Monday.

Ok, thanks.

Armin Wolf


