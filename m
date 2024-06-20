Return-Path: <linux-acpi+bounces-6551-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E6DE3910E06
	for <lists+linux-acpi@lfdr.de>; Thu, 20 Jun 2024 19:06:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C24B28725B
	for <lists+linux-acpi@lfdr.de>; Thu, 20 Jun 2024 17:06:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9895F1AE875;
	Thu, 20 Jun 2024 17:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=squebb.ca header.i=@squebb.ca header.b="bAPRPOCR";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="tjSWHKyo"
X-Original-To: linux-acpi@vger.kernel.org
Received: from fout1-smtp.messagingengine.com (fout1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2211C1AF6A1
	for <linux-acpi@vger.kernel.org>; Thu, 20 Jun 2024 17:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718903167; cv=none; b=rZieoELpbCkD2i2/r/JSbQFsAwmLcaJc7oYFWpo5MSeT1NRVaTv71jP3xltNM2JyVxw2KSkKFkt0qf60jdE61BWciqM8uo+xIMYT3GuCwi8n4uwknOSFlk+BcbPL5Xav4OfOX+5nGveii0DR7aw/9AL0uVJeGQKQHJr+kYz9VWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718903167; c=relaxed/simple;
	bh=OA8qvioAnJhCibVDmezvixwxYbgVZG4aBHziakjH1Mw=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=mAtXpidTVzY14Cykh96cMylyG3SsTosaPpPKEqvG+Qfc92hT8OvjRe+5IwUynsh6CihuXs6V29qm/H8zFsqh84gLCsy6E1BzKcL3QsJIuhUuNsF4sXYnHWgN4xycYQVfJ+mPGE4/pPlJVwtFncjyr5XJJ3wYeixYwJrzUdIg9g4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=squebb.ca; spf=pass smtp.mailfrom=squebb.ca; dkim=pass (2048-bit key) header.d=squebb.ca header.i=@squebb.ca header.b=bAPRPOCR; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=tjSWHKyo; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=squebb.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=squebb.ca
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailfout.nyi.internal (Postfix) with ESMTP id 23BF113801B5;
	Thu, 20 Jun 2024 13:06:00 -0400 (EDT)
Received: from imap52 ([10.202.2.102])
  by compute3.internal (MEProxy); Thu, 20 Jun 2024 13:06:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=squebb.ca; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1718903160;
	 x=1718989560; bh=sdaxE9KYkJkOjlc2A3UYb8hfDW1z+CUTfbiV2kd/Mv0=; b=
	bAPRPOCR84l3AScIVFjDww9biAyadwwiNQ8zw3jc+dWzRVmSxIRL93JsfHxaCz9t
	frhhC86o+Vgu0Xu0YYSEfvo5UKhI0MDc43HXB4CxB9xd6i7lIpd1gkuJAPAZTQkG
	Aw/jqjIMrUulrEVCqzCxxgJi/oNYeHVB/dDykrchPv3IyJb9MwFFTPmxBSQKaik9
	ZLdD/iIzm0Oa7xfSTslgFt61y2GLmYAyfiuIGSL9yh9Q3ya29CLLP7xt4l0RPPEo
	qk30JZFIoxinUW2B/F5a7xZBIC6F7YLk8F57U3dA09bSND6dLE47+U3WLtS0ln1/
	skNHqYAdyyWwGHrnJp6giQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1718903160; x=
	1718989560; bh=sdaxE9KYkJkOjlc2A3UYb8hfDW1z+CUTfbiV2kd/Mv0=; b=t
	jSWHKyo4UjE6+AcyUlNl4adMD1bBuCwFIRRRkFkhcREk6G80b9HqrLf4WVDPDgQa
	CDq+ZrNTemViwr+5ce9OG/D+ioDXMhW5iMY2aq+wf31CC7ZxEuDgXEkUF0aPfmDT
	bBD/mebv8OUgESO7Nhe6sMumGwPlvyDt7hC25M4enit03GeXAT82QC+8irvqAmEv
	7A7Y/B4g5J+XY4ChCRHyrEVqaMv2S259Ta1YHpbRmTspm0iwbZGnQ1Vo+PZ5x8Nz
	tLMxpuKEClEsAEBRjfE3cUxPkuvVYFWYMuMaxCJqZ/yj9ltlyebdsIyg0xQAta1W
	qyxiTd2KSvFB7eYaOUmdA==
X-ME-Sender: <xms:d2F0ZuNawPoRcuXzuD_5oJ35MZ9w91acsacIAzjkJzlv0ME-I_A_dA>
    <xme:d2F0Zs_AyIA4UyFPWCa-elP9scpbCXt6eSyEv54Bf9t57j9HPXGLqsHlgRNTKR-LC
    rMbJ8p-Y_T09HMPUYQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfeefvddguddutdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvvefutgfgsehtqhertderreejnecuhfhrohhmpedf
    ofgrrhhkucfrvggrrhhsohhnfdcuoehmphgvrghrshhonhdqlhgvnhhovhhosehsqhhuvg
    gssgdrtggrqeenucggtffrrghtthgvrhhnpeekvdeikeegkedtvdfgledutdehleevheef
    ffefteejgedtleeihfdvueevtdffgeenucffohhmrghinhepghhithhhuhgsrdgtohhmpd
    hfrhgvvgguvghskhhtohhprdhorhhgpdgrmhgupghsvdhiughlvgdrphihnecuvehluhhs
    thgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepmhhpvggrrhhsohhnqd
    hlvghnohhvohesshhquhgvsggsrdgtrg
X-ME-Proxy: <xmx:d2F0ZlRq6GojMGYzDwa1S5MdJk2kMaCKbnc4rgKS7PQVVGJ0FxUMhg>
    <xmx:d2F0Zusp0HbNPVeAASOfSHyGUWJZRd4Wv0hv8aFBDu1HalwJoeXqkw>
    <xmx:d2F0Zme_MkcbyhbSrkB3-M19czzTwafjhfRdShnNdERabRB3nNhSXg>
    <xmx:d2F0Zi2lbC7ZiAEXqbsLi16AX5WnjZhLCISrQKqGg1MuvsUeF85UNg>
    <xmx:eGF0Zm6jwS5uhCQ8TSlmGJphqk2zm66VgUlAtjNRxVExScSDsiPMLN4u>
Feedback-ID: ibe194615:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 5EC13C60099; Thu, 20 Jun 2024 13:05:59 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-522-ga39cca1d5-fm-20240610.002-ga39cca1d
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <27080c20-7d60-433d-bbee-c03ec500aee8@app.fastmail.com>
In-Reply-To: <D2504RNGXBRM.3DUONJULSWL6H@gmail.com>
References: <ZnFYpWHJ5Ml724Nv@ohnotp>
 <40ec6e11-c279-44ba-993f-2f2475c15073@app.fastmail.com>
 <D24VBFQ86ZIA.3KHVV0P1I3MNX@gmail.com>
 <6b80e4cb-47fb-4467-b834-ffa04c9b4d8e@app.fastmail.com>
 <D2504RNGXBRM.3DUONJULSWL6H@gmail.com>
Date: Thu, 20 Jun 2024 13:05:38 -0400
From: "Mark Pearson" <mpearson-lenovo@squebb.ca>
To: "Yutaro Ohno" <yutaro.ono.418@gmail.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>, "Len Brown" <lenb@kernel.org>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
Subject: Re: [PATCH] ACPI: EC: Use ec_no_wakeup on ThinkPad T14 Gen 5
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable

Thanks Ohno

On Thu, Jun 20, 2024, at 12:57 PM, Yutaro Ohno wrote:
> On Fri Jun 21, 2024 at 12:35 AM JST, Mark Pearson wrote:
>> >>  - Get a report from running the Intel S0ix test tool - https://gi=
thub.com/intel/S0ixSelftestTool. Run it with the -S option
>> >
>> > It may not work as my machine is not Intel, but here's the output:
>> <snip>
>>
>> Yeah - that won't work. The AMD test tool is here:
>> https://gitlab.freedesktop.org/drm/amd/-/blob/master/scripts/amd_s2id=
le.py
>> Can you try that please?
>
> Sure. I've tried with/without the kernel parameter `acpi.ec_no_wakeup=3D=
1`.
>
> Booting with the kernel parameter:
> ```
> $ sudo python3 amd_s2idle.py
> Location of log file (default s2idle_report-2024-06-21.txt)?
> Debugging script for s2idle on AMD systems
> =F0=9F=92=BB LENOVO 21MCCTO1WW (ThinkPad T14 Gen 5) running BIOS 1.4 (=
R2LET23W=20
> (1.04 )) released 04/01/2024 and EC 1.1
> =F0=9F=90=A7 Arch Linux
> =F0=9F=90=A7 Kernel 6.9.5-arch1-1
> =F0=9F=94=8B Battery BAT0 (SMP 5B11H56415) is operating at 101.22% of =
design
> Checking prerequisites for s2idle
> =E2=9C=85 Logs are provided via systemd
> =E2=9C=85 AMD Ryzen 7 PRO 8840U w/ Radeon 780M Graphics (family 19 mod=
el 75)
> =E2=9C=85 SMT enabled
> =E2=9C=85 LPS0 _DSM enabled
> =E2=9C=85 ACPI FADT supports Low-power S0 idle
> =E2=9C=85 HSMP driver `amd_hsmp` not detected (blocked: False)
> =E2=9C=85 PMC driver `amd_pmc` loaded (Program 0 Firmware 76.83.0)
> =E2=9C=85 USB4 driver `thunderbolt` bound to 0000:c6:00.5
> =E2=9C=85 USB4 driver `thunderbolt` bound to 0000:c6:00.6
> =E2=9C=85 GPU driver `amdgpu` bound to 0000:c4:00.0
> =E2=9C=85 System is configured for s2idle
> =E2=9C=85 NVME KIOXIA Corporation NVMe SSD Controller XG8 is configure=
d for=20
> s2idle in BIOS
> =E2=9C=85 GPIO driver `pinctrl_amd` available
> =F0=9F=9A=A6 Device firmware checks unavailable without gobject intros=
pection
> =E2=9C=85 WCN6855 WLAN (fw build id=20
> WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3.6510.37)
> How long should suspend cycles last in seconds (default 10)?
> How long to wait in between suspend cycles in seconds (default 4)?
> How many suspend cycles to run (default 1)?
> Started at 2024-06-21 01:05:15.386691 (cycle finish expected @=20
> 2024-06-21 01:05:29.386714)
> Results from last s2idle cycle
> =E2=97=8B Suspend count: 1
> =E2=97=8B Hardware sleep cycle count: 1
> =E2=97=8B Wakeup triggered from IRQ 9: ACPI SCI
> =E2=97=8B Woke up from IRQ 9: ACPI SCI
> =E2=97=8B gpe07 increased from 9957 to 10219
> =E2=9C=85 Userspace suspended for 0:00:12.386591
> =E2=9C=85 In a hardware sleep state for 0:00:08.692840 (70.18%)
> =F0=9F=94=8B Battery BAT0 lost 10000 =C2=B5Wh (0.02%) [Average rate 0.=
29W]
> ```
>
> Booting without the kernel parameter:
> ```
> $ sudo python3 ./amd_s2idle.py
> Location of log file (default s2idle_report-2024-06-21.txt)?
> Debugging script for s2idle on AMD systems
> =F0=9F=92=BB LENOVO 21MCCTO1WW (ThinkPad T14 Gen 5) running BIOS 1.4 (=
R2LET23W=20
> (1.04 )) released 04/01/2024 and EC 1.1
> =F0=9F=90=A7 Arch Linux
> =F0=9F=90=A7 Kernel 6.9.5-arch1-1
> =F0=9F=94=8B Battery BAT0 (SMP 5B11H56415) is operating at 101.22% of =
design
> Checking prerequisites for s2idle
> =E2=9C=85 Logs are provided via systemd
> =E2=9C=85 AMD Ryzen 7 PRO 8840U w/ Radeon 780M Graphics (family 19 mod=
el 75)
> =E2=9C=85 SMT enabled
> =E2=9C=85 LPS0 _DSM enabled
> =E2=9C=85 ACPI FADT supports Low-power S0 idle
> =E2=9C=85 HSMP driver `amd_hsmp` not detected (blocked: False)
> =E2=9C=85 PMC driver `amd_pmc` loaded (Program 0 Firmware 76.83.0)
> =E2=9C=85 USB4 driver `thunderbolt` bound to 0000:c6:00.5
> =E2=9C=85 USB4 driver `thunderbolt` bound to 0000:c6:00.6
> =E2=9C=85 GPU driver `amdgpu` bound to 0000:c4:00.0
> =E2=9C=85 System is configured for s2idle
> =E2=9C=85 NVME KIOXIA Corporation NVMe SSD Controller XG8 is configure=
d for=20
> s2idle in BIOS
> =E2=9C=85 GPIO driver `pinctrl_amd` available
> =F0=9F=9A=A6 Device firmware checks unavailable without gobject intros=
pection
> =E2=9C=85 WCN6855 WLAN (fw build id=20
> WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3.6510.37)
> How long should suspend cycles last in seconds (default 10)?
> How long to wait in between suspend cycles in seconds (default 4)?
> How many suspend cycles to run (default 1)?
> Started at 2024-06-21 01:16:58.754215 (cycle finish expected @=20
> 2024-06-21 01:17:12.754238)
> Results from last s2idle cycle
> =E2=97=8B Suspend count: 1
> =E2=97=8B Hardware sleep cycle count: 10
> =E2=97=8B Wakeup triggered from IRQ 9: ACPI SCI
> =E2=97=8B Woke up from IRQ 9: ACPI SCI
> =E2=97=8B gpe07 increased from 1823 to 2085
> =E2=9C=85 Userspace suspended for 0:00:12.962868
> =E2=9C=85 In a hardware sleep state for 0:00:01.672448 (12.90%)
> =F0=9F=94=8B Battery BAT0 lost 30000 =C2=B5Wh (0.06%) [Average rate 0.=
83W]
> ```
>
>> One more question - which Wifi module do you have? The Qualcomm NCM82=
5 Wifi7 device still has a lot of problems (it's currently the main thin=
g gating our Linux certification of the platform).
>
> From `lspci`, it's the QCNFA765.
>
I'll forward these on to the FW team.
Mark

