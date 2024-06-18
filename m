Return-Path: <linux-acpi+bounces-6510-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2970A90DFDD
	for <lists+linux-acpi@lfdr.de>; Wed, 19 Jun 2024 01:29:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F28F01C22EBC
	for <lists+linux-acpi@lfdr.de>; Tue, 18 Jun 2024 23:29:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08B4516FF28;
	Tue, 18 Jun 2024 23:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=squebb.ca header.i=@squebb.ca header.b="gQE/63zG";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="P/cZ55O4"
X-Original-To: linux-acpi@vger.kernel.org
Received: from fhigh5-smtp.messagingengine.com (fhigh5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B042618C3D
	for <linux-acpi@vger.kernel.org>; Tue, 18 Jun 2024 23:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718753343; cv=none; b=QSWD3uwiYaHonDjsHzNK5HeDP/dbOUyZG8BvaS3Jc1s/ONBmny3Wy5j7Zz6ilNCi8GIgU7NPxQxfd4M0qsB/5Dc/jdUI9YofPItuJ3+e9j8D9JGxpMylBTrcZ17/m0mob4GW3yQxhUFm7h+XI1AakQY5tNeSZOC2bCj2+PTy5jA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718753343; c=relaxed/simple;
	bh=o8G1JENNT5X6dMBlnC92WwBoEzH3lImmrAlILVMCvrM=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=QtWmGindAs7pTQJaW0xEfCnORAW8XliJNsFd1qQDcuL1eyHuz1ebnmMcvzI6x4ynwDF8Y1X5/3EB5RNXLutrWFlqUN0XSc/qWp7ujVS9NOkj7qQR0OYryvzOxRMkqhoVbhH3lIagC0LdMpgBgNDCOwxzuixzFQoUOYv9l24UWdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=squebb.ca; spf=pass smtp.mailfrom=squebb.ca; dkim=pass (2048-bit key) header.d=squebb.ca header.i=@squebb.ca header.b=gQE/63zG; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=P/cZ55O4; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=squebb.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=squebb.ca
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id B3B061140159;
	Tue, 18 Jun 2024 19:29:00 -0400 (EDT)
Received: from imap52 ([10.202.2.102])
  by compute3.internal (MEProxy); Tue, 18 Jun 2024 19:29:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=squebb.ca; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1718753340; x=1718839740; bh=4NAsDGItay
	VAr6++h1l3+Wp1xcWii1XHGorCWaTXMI8=; b=gQE/63zGfzsR7J9xtXD7cSykkC
	PufRpWyi5RIJA4jbX1QT7UogX+dlCPg5F7V5Fbabvh6H2rTixJGkCYuPA7RwjAMS
	vOFTBKjtsX/PcflQJPl59hgNMoUtUiFKhtofGM05EThOdoYUTzE0AH2tujAd5p3V
	4BxJ45lwwdTXtExiqFc/ttZHeZUQ/nscF6GpKSSu6z0zncjKYmQmcuO+ovvjv6n0
	YLtXEmi9am/vHoGBM7LU+cjdOkJWrb3wcTn/c3w83T216Uf74Ktzo0CjbMxMlCEF
	GwOsPDlP/f/FjbIBGrQoHy0+arRbT16OoxFU6kf19LyCsMMmFkYv7nVZqWEw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1718753340; x=1718839740; bh=4NAsDGItayVAr6++h1l3+Wp1xcWi
	i1XHGorCWaTXMI8=; b=P/cZ55O4FsDf4/sAwTuXPTx122IQ10dBzTLTIuvaJVfD
	eIg1UaQH8k9JEfT/RJY7QB2GIpDifXOA0hhH+Aqgk0/ycV2EJ8b6qFGwUohJ9eTD
	ozqMBsMAW+GIbReQ9+KalED1pJbXbRa+qGOH6NqpqO66kP1H+ioAWy5+ZBR9FdFx
	nsVR/5BM2GSi/r6ZUGPkK5lnQ9Urd3v+s9TeQPWy5M5iwVjSVD3yW7U1Cj4Oo4wP
	9aGRMuYECK92d5vGMFkztZyQIyXahPTRgAsJDSdRx6HiryJyKJYMPc9eyVeoRKOS
	gLfpth27CB7mBNweq+4sGcKjzeIuAbM7ufqTOn+KpA==
X-ME-Sender: <xms:PBhyZmhnbQZNCWErPd80Ocr59q_s2HajdSpjkhoM0ISjs2H1kqbNbA>
    <xme:PBhyZnCTUtP97lhWRH8sk4WS8PqrJCRaS6rV-rB7TWnUT05kF6c2FpG9w5eGrLkyi
    J7ZSbVf84_9o_KZlnk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfedvledgvdefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedfofgr
    rhhkucfrvggrrhhsohhnfdcuoehmphgvrghrshhonhdqlhgvnhhovhhosehsqhhuvggssg
    drtggrqeenucggtffrrghtthgvrhhnpeevgfevtefhteegteejleefvdejueeiteelveef
    gfehhfeuvdevhefggfdtgeehgfenucffohhmrghinhepghhithhhuhgsrdgtohhmnecuve
    hluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepmhhpvggrrhhs
    ohhnqdhlvghnohhvohesshhquhgvsggsrdgtrg
X-ME-Proxy: <xmx:PBhyZuG-Py2YRZBUE5Gda2eKZKvQZNcNqc-rB7YDxCY6yke81g1TuQ>
    <xmx:PBhyZvTX8ePvfO48eKUxUPB2SehdM5mSAq3b8OgCHsQ-mu3rrfpVbQ>
    <xmx:PBhyZjzvMT9Wb-ew1GE0Wz5FfUySy4i5-Ws6RvL72E-49KgPctMZEA>
    <xmx:PBhyZt5gadnkJ0rWhUWQPwQH5Lv5k5iVTwX-cTuvc0-BGDvo1Zi6tQ>
    <xmx:PBhyZj_EfUH_3soUNdjKlB3VQaDulVbLM3WRCoefRz00YOyXY-54irjq>
Feedback-ID: ibe194615:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 6FE82C60097; Tue, 18 Jun 2024 19:29:00 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-522-ga39cca1d5-fm-20240610.002-ga39cca1d
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <40ec6e11-c279-44ba-993f-2f2475c15073@app.fastmail.com>
In-Reply-To: <ZnFYpWHJ5Ml724Nv@ohnotp>
References: <ZnFYpWHJ5Ml724Nv@ohnotp>
Date: Tue, 18 Jun 2024 19:28:40 -0400
From: "Mark Pearson" <mpearson-lenovo@squebb.ca>
To: "Yutaro Ohno" <yutaro.ono.418@gmail.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>, "Len Brown" <lenb@kernel.org>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
Subject: Re: [PATCH] ACPI: EC: Use ec_no_wakeup on ThinkPad T14 Gen 5
Content-Type: text/plain

Hi Yutaro,

On Tue, Jun 18, 2024, at 5:51 AM, Yutaro Ohno wrote:
> On ThinkPad T14 Gen 5, EC interrupts constantly wake up the system from
> s2idle, resulting in high power consumption.
>
> This sets `acpi.ec_no_wakeup=1` to fix the high power consumption issue
> in s2idle state.
>
> Signed-off-by: Yutaro Ohno <yutaro.ono.418@gmail.com>
> ---
>  drivers/acpi/ec.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
> index 299ec653388c..c7d5231edca7 100644
> --- a/drivers/acpi/ec.c
> +++ b/drivers/acpi/ec.c
> @@ -2248,6 +2248,12 @@ static const struct dmi_system_id acpi_ec_no_wakeup[] = {
>  			DMI_MATCH(DMI_PRODUCT_FAMILY, "ThinkPad X1 Yoga 3rd"),
>  		},
>  	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
> +			DMI_MATCH(DMI_PRODUCT_FAMILY, "ThinkPad T14 Gen 5"),
> +		},
> +	},
>  	{
>  		.matches = {
>  			DMI_MATCH(DMI_SYS_VENDOR, "HP"),
> -- 
> 2.45.2

We're doing Linux enablement on the T14 G5 right now - and if this is an issue in the Lenovo FW I would rather fix it there instead of introducing a quirk into the kernel that might later need to be removed. This platform is getting full Linux support.

I'd like to collect some debug details from you (if preferred you can ping me off thread using this email address):

 - Can I get your BIOS, EC and ME versions (easiest is to get these from the BIOS setup screen - F1 during early boot)
 - Get a report from running the Intel S0ix test tool - https://github.com/intel/S0ixSelftestTool. Run it with the -S option
 - There is a known issue if the ethernet is plugged in on this system that Intel are working on - can you confirm if you're using wired networking please?
 - Do you have WWAN enabled? If you have it can you try with WWAN disabled.

I'll also highlight that Linux enablement is not complete on this platform yet, so some patience might be needed.

Thanks
Mark (Lenovo employee working on the Linux PC enablement program)

