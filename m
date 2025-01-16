Return-Path: <linux-acpi+bounces-10728-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 55EFDA14475
	for <lists+linux-acpi@lfdr.de>; Thu, 16 Jan 2025 23:20:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 730447A400C
	for <lists+linux-acpi@lfdr.de>; Thu, 16 Jan 2025 22:20:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BDF41DC98C;
	Thu, 16 Jan 2025 22:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=squebb.ca header.i=@squebb.ca header.b="uAMXcO8E";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="l8sJjVkF"
X-Original-To: linux-acpi@vger.kernel.org
Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC4E313B58C;
	Thu, 16 Jan 2025 22:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737066041; cv=none; b=jiZAonDVhFmVNnddx0K17c3yPECCNKSzxUzusjbF74mCRzIm3HKK469MJ0gyUC0SlJb40EdPcxWtwQbDfCnVKbtr2Aq5BH4csNQwFjsDjL4aKvh/itARQ6vxhmX20u8OeY7cMS6D1QDv3GuKfrtARaqdQyGzF7In307Fk/3Xz90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737066041; c=relaxed/simple;
	bh=SFy3ck1vf79DxRw1V7twdG5RfYfyfQDTCjMDg3pfv9U=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=ditCwrTr0IyHopjdpa/Rod26qkErDVobyloBpsHNLOcA+45Vdlk59pH4l79lY4yFK0Z2hueDutr3V3vGKZy/TtJ5b144dPFEoSEapl7vfo6xiXaEzYSn7ZT+kp0QocIDalO1q7pzXEMIR4M2dXQK8H73QZPTqWu1OFBocOIRmew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=squebb.ca; spf=pass smtp.mailfrom=squebb.ca; dkim=pass (2048-bit key) header.d=squebb.ca header.i=@squebb.ca header.b=uAMXcO8E; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=l8sJjVkF; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=squebb.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=squebb.ca
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id C3FCC13802C2;
	Thu, 16 Jan 2025 17:20:37 -0500 (EST)
Received: from phl-imap-10 ([10.202.2.85])
  by phl-compute-02.internal (MEProxy); Thu, 16 Jan 2025 17:20:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=squebb.ca; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1737066037;
	 x=1737152437; bh=Vb4kmYiLpZR7cnqSwRqWr3BnMdy2IX6vkQzBpGLy1OY=; b=
	uAMXcO8EhlWg6wgXZiY5hNTAz3eUj7kPHf/Q0wN8ObX15jEzaJmnXmu9JKDQk4ve
	wXKwaQ7KkYR2vLG7uTcmRCv0O5gAjbMf/EXn/gmeWLDYYQCS+U87EaBOzvoap7rg
	vqAvESB+RNotJovaILtAgGd5TQ9K8mfr+TdiDmntrnf8IDClxGNZ6h7HIO758p6s
	bgkqldLiqQ3ul/sJ4cjHoO8syK1sD0IyBsxW6RCrB+jbO4wNP4Qg+rI4JW9xvEnw
	YIwDV8yjsr798nzWTd/JqLygQaTWVfgFkJNLamR4iiPS64HWcG05vC7nXF/UBRrk
	XUnx+j5mzWJULYaL9EgivA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1737066037; x=
	1737152437; bh=Vb4kmYiLpZR7cnqSwRqWr3BnMdy2IX6vkQzBpGLy1OY=; b=l
	8sJjVkFlhrQGKOEwlFAeyh66tQeKodAibtYzwvYBjEVD04j7zC8cn7cslJu8SkxW
	gkBU8Tw/0E7f8D//MxNslNnpwu3W5+RkZ2eNO55Eai/ksPLS1c2REyRdOD+71njL
	cwD7NVAWfkT+Q6FdkOngDNNyixH9qnFsMgofeTV2SB5u6OzcEdmitcnfVvEXfCRM
	bLDQPtzZmb9aFXeYQipPuNaWrTyorhqJ/LeZZqe7DayM6aUX/QnzEtinTUj9BNCf
	Lgsi8iy8yDdsvez0+OqgHTjWj/CdGhAkE0bFXVMDnNFnDKlwUWYrJvvbw/sctNHO
	5jB2vd3+SLC5eh6arCQsQ==
X-ME-Sender: <xms:M4aJZ4vWyXnX0wtMXsB0ogXp4yBC60Gw82981HCsoERhdvk2U1kj1w>
    <xme:M4aJZ1dXy8tdBJHzUsfjl-M_KBjiKswgi9h8HHvNIfPOMxISncT4CydSvkD9sX8T6
    4WjOwvu6KnUqSlo5Bs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudeiuddgudehiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefoggffhffvvefkjghfufgtgfesthejredtredt
    tdenucfhrhhomhepfdforghrkhcurfgvrghrshhonhdfuceomhhpvggrrhhsohhnqdhlvg
    hnohhvohesshhquhgvsggsrdgtrgeqnecuggftrfgrthhtvghrnheptdffvefgtefhveet
    uddvfeelveektdduvdelgfehgfeikeffjeetjeevffektdfhnecuffhomhgrihhnpehkvg
    hrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhl
    fhhrohhmpehmphgvrghrshhonhdqlhgvnhhovhhosehsqhhuvggssgdrtggrpdhnsggprh
    gtphhtthhopedvhedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepshhhhigrmhdq
    shhunhgurghrrdhsqdhksegrmhgurdgtohhmpdhrtghpthhtohepmhgrrhhiohdrlhhimh
    honhgtihgvlhhlohesrghmugdrtghomhdprhgtphhtthhopehikhgvrdhprghnsegtrghn
    ohhnihgtrghlrdgtohhmpdhrtghpthhtohepuggvlhhlrdgtlhhivghnthdrkhgvrhhnvg
    hlseguvghllhdrtghomhdprhgtphhtthhopegrlhgvgigsvghlmhegkeesghhmrghilhdr
    tghomhdprhgtphhtthhopegtohhrvghnthhinhdrtghhrghrhiesghhmrghilhdrtghomh
    dprhgtphhtthhopeguvghrvghkjhhohhhnrdgtlhgrrhhksehgmhgrihhlrdgtohhmpdhr
    tghpthhtohepkhhuuhhrthgssehgmhgrihhlrdgtohhmpdhrtghpthhtoheplhhuiihmrg
    igihhmihhlihgrnhesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:M4aJZzyyoGPMKmyZ86YezqbAXb2M1pDzZeKSdQG4h24I3IFRecrjaA>
    <xmx:M4aJZ7M3wWf3jcBrhx-DFdZSt96NRGBkG-QYZwFqUVEfJq-dIT7I6A>
    <xmx:M4aJZ49Nl5Tg_tdR5PgKIwUh0Cb6mmA4o_5k-_CdQuB8wcoX9L8n3w>
    <xmx:M4aJZzUc1TY5pHQfVMAHkcc7KfsJotlztzIribiOlofU8UYWCjJpOA>
    <xmx:NYaJZ2NiWWNPAwnG-Dcib6_9mooTYlRtxQp3Y0Hq-jmxk2BS-dOw0Oai>
Feedback-ID: ibe194615:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 2874A3C0068; Thu, 16 Jan 2025 17:20:35 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 16 Jan 2025 17:20:14 -0500
From: "Mark Pearson" <mpearson-lenovo@squebb.ca>
To: "Kurt Borja" <kuurtb@gmail.com>,
 "platform-driver-x86@vger.kernel.org" <platform-driver-x86@vger.kernel.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, "Len Brown" <lenb@kernel.org>,
 "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
 linux-kernel@vger.kernel.org,
 "Limonciello, Mario" <mario.limonciello@amd.com>,
 "Armin Wolf" <W_Armin@gmx.de>, "Joshua Grisham" <josh@joshuagrisham.com>,
 "Derek J . Clark" <derekjohn.clark@gmail.com>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 "Hans de Goede" <hdegoede@redhat.com>,
 "Maximilian Luz" <luzmaximilian@gmail.com>, "Lee Chun-Yi" <jlee@suse.com>,
 "Shyam Sundar S K" <Shyam-sundar.S-k@amd.com>,
 "Corentin Chary" <corentin.chary@gmail.com>,
 "Luke D . Jones" <luke@ljones.dev>, "Lyndon Sanche" <lsanche@lyndeno.ca>,
 "Ike Panhc" <ike.pan@canonical.com>,
 "Henrique de Moraes Holschuh" <hmh@hmh.eng.br>,
 "Alexis Belmonte" <alexbelm48@gmail.com>, "Ai Chao" <aichao@kylinos.cn>,
 "Gergo Koteles" <soyer@irl.hu>, Dell.Client.Kernel@dell.com,
 ibm-acpi-devel@lists.sourceforge.net
Message-Id: <1eb2720a-c9af-4e5c-8df2-c4ce3c017d5c@app.fastmail.com>
In-Reply-To: <20250116002721.75592-1-kuurtb@gmail.com>
References: <20250116002721.75592-1-kuurtb@gmail.com>
Subject: Re: [PATCH v4 00/19] Hide platform_profile_handler from consumers
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi

On Wed, Jan 15, 2025, at 7:27 PM, Kurt Borja wrote:
> Hi :)
>
> The merge window is about to open, so I rebased this patchset on top of
> pdx86/review-ilpo-next to pick up acer-wmi latest commits, in case we
> manage to squeeze this into v6.14.
>
> ~ Kurt
> ---
> v3 -> v4:
>
> [09/19]
>   - Replace error message with a user-friendly one
>
> v3: 
> https://lore.kernel.org/platform-driver-x86/20250115071022.4815-1-kuurtb@gmail.com/
>
> Kurt Borja (19):
>   ACPI: platform_profile: Replace *class_dev member with class_dev
>   ACPI: platform_profile: Let drivers set drvdata to the class device
>   ACPI: platform_profile: Remove platform_profile_handler from callbacks
>   ACPI: platform_profile: Add `ops` member to handlers
>   ACPI: platform_profile: Add `probe` to platform_profile_ops
>   platform/surface: surface_platform_profile: Use
>     devm_platform_profile_register()
>   platform/x86: acer-wmi: Use devm_platform_profile_register()
>   platform/x86: amd: pmf: sps: Use devm_platform_profile_register()
>   platform/x86: asus-wmi: Use devm_platform_profile_register()
>   platform/x86: dell-pc: Use devm_platform_profile_register()
>   platform/x86: ideapad-laptop: Use devm_platform_profile_register()
>   platform/x86: hp-wmi: Use devm_platform_profile_register()
>   platform/x86: inspur_platform_profile: Use
>     devm_platform_profile_register()
>   platform/x86: thinkpad_acpi: Use devm_platform_profile_register()
>   ACPI: platform_profile: Remove platform_profile_handler from exported
>     symbols
>   ACPI: platform_profile: Move platform_profile_handler
>   ACPI: platform_profile: Clean platform_profile_handler
>   ACPI: platform_profile: Add documentation
>   ACPI: platform_profile: Add a prefix to log messages
>
>  .../ABI/testing/sysfs-class-platform-profile  |  44 +++++
>  drivers/acpi/platform_profile.c               | 172 +++++++++++++-----
>  .../surface/surface_platform_profile.c        |  48 ++---
>  drivers/platform/x86/acer-wmi.c               | 114 ++++++------
>  drivers/platform/x86/amd/pmf/core.c           |   1 -
>  drivers/platform/x86/amd/pmf/pmf.h            |   3 +-
>  drivers/platform/x86/amd/pmf/sps.c            |  51 +++---
>  drivers/platform/x86/asus-wmi.c               |  55 +++---
>  drivers/platform/x86/dell/alienware-wmi.c     |  34 ++--
>  drivers/platform/x86/dell/dell-pc.c           |  60 +++---
>  drivers/platform/x86/hp/hp-wmi.c              |  83 +++++----
>  drivers/platform/x86/ideapad-laptop.c         |  45 +++--
>  .../platform/x86/inspur_platform_profile.c    |  48 +++--
>  drivers/platform/x86/thinkpad_acpi.c          |  37 ++--
>  include/linux/platform_profile.h              |  37 ++--
>  15 files changed, 495 insertions(+), 337 deletions(-)
>  create mode 100644 Documentation/ABI/testing/sysfs-class-platform-profile
>
>
> base-commit: d98bf6a6ed61a8047e199495b0887cce392f8e5b
> -- 
> 2.48.1

For the series up to v4 commit 15/19:
Reviewed-by: Mark Pearson <mpearson-lenovo@squebb.ca>

I need to go over the last few commits just once more, as there a few pieces I need to get my head around - and I'm not going to get it done this evening. Hope it's OK to add review for the bits that I have done.

Thanks
Mark

