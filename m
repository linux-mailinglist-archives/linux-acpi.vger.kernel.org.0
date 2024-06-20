Return-Path: <linux-acpi+bounces-6547-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CF569109F0
	for <lists+linux-acpi@lfdr.de>; Thu, 20 Jun 2024 17:35:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 04779283FA0
	for <lists+linux-acpi@lfdr.de>; Thu, 20 Jun 2024 15:35:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C09D1AF6B4;
	Thu, 20 Jun 2024 15:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=squebb.ca header.i=@squebb.ca header.b="FzJMIlIu";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="OdPCGoWD"
X-Original-To: linux-acpi@vger.kernel.org
Received: from fout8-smtp.messagingengine.com (fout8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F02491AED4D
	for <linux-acpi@vger.kernel.org>; Thu, 20 Jun 2024 15:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718897733; cv=none; b=Vcvkjm3zhGNlH/nJAkG09Jv1mayj54FN3+p6aivO49PkQbr7dTCvnFSNBqzkRQdwpA0Z6h0dVfA1cPFx6Ch2zq5YGxyggvpay4aNHQUcBY/b74MoT4U/0IHR3OsOHkE2cW/41n533waik9+zT+GE0+jvmWed4riC0wX3ug3+6s4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718897733; c=relaxed/simple;
	bh=xwYc4MsnFV4bXwbJ1/KA/d4lITDjMQUMfNreDbKpI7g=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=lLIqvEJwdeiUz7fsXdrLKTVChpWJ8Hpo6t/o7Rk9/pGall09DzUL8gYzBr0eg3N3/3gjshW4+XjhEi9aNXQCO5qsPurrxr6ybu0BLX85W4ZhuIlWg3SkvePIGNu4jNRZkT8/f0iJd7LGknAljbgGqdWO8NiPlUkmGvUU5+Fy+o8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=squebb.ca; spf=pass smtp.mailfrom=squebb.ca; dkim=pass (2048-bit key) header.d=squebb.ca header.i=@squebb.ca header.b=FzJMIlIu; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=OdPCGoWD; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=squebb.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=squebb.ca
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailfout.nyi.internal (Postfix) with ESMTP id D4B34138010A;
	Thu, 20 Jun 2024 11:35:29 -0400 (EDT)
Received: from imap52 ([10.202.2.102])
  by compute3.internal (MEProxy); Thu, 20 Jun 2024 11:35:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=squebb.ca; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1718897729; x=1718984129; bh=v1LdTswQvo
	7Zh+81AN6grkXNnDOPx2tM82zsrl2yC7c=; b=FzJMIlIucUUtnUFEbyH/NDIfsG
	Lt0toZ4aKKOO+/ln9X1hruXpO10QXGuiJ/iBXssOsLtNLdQWuLty+KmTb5Ro6CWk
	DxT4q0uZIwMp3b8UnkffSued/qAStJ+XpNbfYSntBHfS7wSE0/O5jDcIghTDZ+6u
	mB3CxFn9/a2J15jfsFCcoafODhE7h81KqfFY6Jv5J8VdB+wPmW0JdRCSlg2L/2gb
	QE32g5xVyfzQbETVo0Kbz8cD39dsRjn2IH7RZoTVrA7kDmlodgN2TlqeyDJSC1iH
	MzAtuhcnRQbNGRAzRgAfQ8LIPtwE9zNUEFCzLcZf9C/tCko829ZnYq/rE89Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1718897729; x=1718984129; bh=v1LdTswQvo7Zh+81AN6grkXNnDOP
	x2tM82zsrl2yC7c=; b=OdPCGoWDH6ZbURmhUpC5bKE2KYR3MlCGGpzU1X8YjNoL
	/RkICbSx+Ah/W+O03ztUer5l6wobXPwxGQRTZWVJJwjEa1pM6+sBSdUlR4/xn7s3
	dN/2fdGJYJ8/1skwr2qfz36YZKY6VsK76PULJgpESydaPAN5oNq27wUPFROktFtf
	bV1i181cUjbtQN/uyoQMHdlfKD3LInpozpcZTKjlgIbxo7iB1J70cAg6z/UOL/TE
	TlCfPBSZsc8qERZGqPdHLres2wsGrR9X9L8WcPC1XrIexMe83+30xiXhTXJj7Ck0
	3s0g+MIzGWg4g8MnZVJlEi4W2mthrq5J54UmZifNQw==
X-ME-Sender: <xms:QUx0ZmxK5NLq8WgZzQcHCk_fmFG9wn_y7bDkoI-H6Spq_GA34M7VdA>
    <xme:QUx0ZiTUlnF2xj8Ob7d8Lw7T6Dro7d7WNwDIZvmmJc0D3gniSbb0F8y2S-mRdQoIA
    0B_usFjqyHuGny0N-w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfeefvddgleduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedfofgr
    rhhkucfrvggrrhhsohhnfdcuoehmphgvrghrshhonhdqlhgvnhhovhhosehsqhhuvggssg
    drtggrqeenucggtffrrghtthgvrhhnpedvleevtdetteehteefheelfeefteffgeduleet
    ueeiudfghedtieetgfetieehfeenucffohhmrghinhepghhithhhuhgsrdgtohhmpdhfrh
    gvvgguvghskhhtohhprdhorhhgpdgrmhgupghsvdhiughlvgdrphihnecuvehluhhsthgv
    rhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepmhhpvggrrhhsohhnqdhlvg
    hnohhvohesshhquhgvsggsrdgtrg
X-ME-Proxy: <xmx:QUx0ZoUDYaC4Je0uLvS8I_m4_nphMS1YSyJJG0Ly3OEsb3cCYqoejQ>
    <xmx:QUx0Zshp90smEJqBZHlnpBddr7s5h16HGIDAqC9U_dQ-0cPCJQGv4g>
    <xmx:QUx0ZoB-BdK2qTw7hPdg93tKW8hD_rWozwniVpIM4oF_n7u5eEivYQ>
    <xmx:QUx0ZtJ45Hppw6UDoepUyb4S6NGsUyMnburvwmLIdhd7ZsZCBklIMA>
    <xmx:QUx0ZrNmgIiPjrqKKYpMVGyy3UOPUApdGnnQmJKNrm1RDzGEjBEwOLpm>
Feedback-ID: ibe194615:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 7BD1CC60097; Thu, 20 Jun 2024 11:35:29 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-522-ga39cca1d5-fm-20240610.002-ga39cca1d
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <6b80e4cb-47fb-4467-b834-ffa04c9b4d8e@app.fastmail.com>
In-Reply-To: <D24VBFQ86ZIA.3KHVV0P1I3MNX@gmail.com>
References: <ZnFYpWHJ5Ml724Nv@ohnotp>
 <40ec6e11-c279-44ba-993f-2f2475c15073@app.fastmail.com>
 <D24VBFQ86ZIA.3KHVV0P1I3MNX@gmail.com>
Date: Thu, 20 Jun 2024 11:35:08 -0400
From: "Mark Pearson" <mpearson-lenovo@squebb.ca>
To: "Yutaro Ohno" <yutaro.ono.418@gmail.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>, "Len Brown" <lenb@kernel.org>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
Subject: Re: [PATCH] ACPI: EC: Use ec_no_wakeup on ThinkPad T14 Gen 5
Content-Type: text/plain

Hi Ohno

On Thu, Jun 20, 2024, at 9:10 AM, Yutaro Ohno wrote:
> Hi, Mark.
>
> On Wed Jun 19, 2024 at 8:28 AM JST, Mark Pearson wrote:
>> We're doing Linux enablement on the T14 G5 right now - and if this is an issue in the Lenovo FW I would rather fix it there instead of introducing a quirk into the kernel that might later need to be removed. This platform is getting full Linux support.
>
> That sounds wonderful! I agree that my change is more of a workaround solution.
>
>> I'd like to collect some debug details from you (if preferred you can ping me off thread using this email address):
>
> Sure. But first, please note that my machine is AMD, not Intel.

Ooops - my bad! Thanks for the clarification.

>
>>  - Can I get your BIOS, EC and ME versions (easiest is to get these from the BIOS setup screen - F1 during early boot)
>
> - BIOS: R2LET23W (1.04)
> - EC:   R2LHT18W (1.01)
> - ME:   Not applicable, as my machine is AMD, not Intel.
Thanks

>
>>  - Get a report from running the Intel S0ix test tool - https://github.com/intel/S0ixSelftestTool. Run it with the -S option
>
> It may not work as my machine is not Intel, but here's the output:
<snip>

Yeah - that won't work. The AMD test tool is here:
https://gitlab.freedesktop.org/drm/amd/-/blob/master/scripts/amd_s2idle.py
Can you try that please?

>
>>  - There is a known issue if the ethernet is plugged in on this system that Intel are working on - can you confirm if you're using wired networking please?
>
> I haven't used the ethernet on my machine. It's not plugged in.
>
>>  - Do you have WWAN enabled? If you have it can you try with WWAN disabled.
>
> No, I don't. My machine doesn't have a WWAN module.
>
One more question - which Wifi module do you have? The Qualcomm NCM825 Wifi7 device still has a lot of problems (it's currently the main thing gating our Linux certification of the platform).

>> I'll also highlight that Linux enablement is not complete on this platform yet, so some patience might be needed.
>
> Sure!
>
> Please let me know if there's anything else I can do.
>
Thanks for the details. I've created internal ticket LO-3140 for tracking and we'll see if we can reproduce

Mark

