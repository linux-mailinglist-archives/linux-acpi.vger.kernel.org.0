Return-Path: <linux-acpi+bounces-82-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 285CA7ADA1D
	for <lists+linux-acpi@lfdr.de>; Mon, 25 Sep 2023 16:31:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id CDD1C28100F
	for <lists+linux-acpi@lfdr.de>; Mon, 25 Sep 2023 14:31:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B66011C287
	for <lists+linux-acpi@lfdr.de>; Mon, 25 Sep 2023 14:31:07 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F055179E3
	for <linux-acpi@vger.kernel.org>; Mon, 25 Sep 2023 12:56:26 +0000 (UTC)
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95D9FC6;
	Mon, 25 Sep 2023 05:56:25 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.nyi.internal (Postfix) with ESMTP id 0064D5C26F7;
	Mon, 25 Sep 2023 08:56:24 -0400 (EDT)
Received: from imap52 ([10.202.2.102])
  by compute5.internal (MEProxy); Mon, 25 Sep 2023 08:56:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=squebb.ca; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm3; t=1695646584; x=1695732984; bh=Gu
	YaxQnJLWNAfmB5LaJ/NWEiM96TNXNxEIYmi/0fQfA=; b=PqZbUoiAyGkzFKLha3
	Psvg7JkD+vdeOtZsc+v2Qtv5fzlZFsgi/RiWmOQabYiP7AzDSxvjC+NN3w9SVy45
	/Ck0yHNVq0kmP9Zj6ZxoADe4ETOIf1gBbgmdUJdEKs/EYHY3UukpfsbZZHtBC8qc
	1SWC48hL0qesGSlX/PB53rV1GOfI/27m12q9G8oNBJnqhI1gexDCAEB/acEfIhqp
	hV07Aq1gKn47czQTGlrIpURiNUWAuqIES3dEJudEajVfgVbccw1iuR4FMrMx8Z2U
	ChkQvhunKUpXApOs/KwGd0zenlfldjOmd+wGaVYHMsIUln3xYB3wWTMRzPJG1rRl
	ClOQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm2; t=1695646584; x=1695732984; bh=GuYaxQnJLWNAf
	mB5LaJ/NWEiM96TNXNxEIYmi/0fQfA=; b=YizDOkAcYDPJNJIKsg0K5Xa5pYa3F
	6MvMQDB12OFvC8DDmu2Tmie4kerF2y6wpyyyxXt0wh5/TVyc5Wrouhcj/mSudzjG
	jmpA36KMdV4PkS0gSj9R05u9U9mS4hWebpMPqEPYK9458DIvaBnERdpF4jd8sNMl
	d/0vNSt/1eB6ni8ddjTe6SUWCDWuly7Aao2cxuMyZbroRt4HG3tRSRU9is+uYRLl
	UyPatJIbT8+Aj9mfa133KZf/KvNpn86Oc3V3CPNr7lxWLNAum354HOI5iuvxmbPL
	iBHYETn8evveD5HYqOm69tQdRfmxqBUPsW//Lw4/oEBzZjWWb5dVwu2Qg==
X-ME-Sender: <xms:eIMRZc188YaI18If8_Qi0hYPJBOurGH-1f4svv21vjCxeTDHHfu1HA>
    <xme:eIMRZXFt5IXq1MxSu01uk3IfDih-IM5az3pTX1XL3w-8AQKqVBtRcE8N7M2zEmsPb
    kpJSY2auUO4eMPouYM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrudelgedgheejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedfofgr
    rhhkucfrvggrrhhsohhnfdcuoehmphgvrghrshhonhdqlhgvnhhovhhosehsqhhuvggssg
    drtggrqeenucggtffrrghtthgvrhhnpeeivedtkeeftdefhfdugfelgeehieeivdefffek
    jeetuddvueeijefgjeekudevtdenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuve
    hluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepmhhpvggrrhhs
    ohhnqdhlvghnohhvohesshhquhgvsggsrdgtrg
X-ME-Proxy: <xmx:eIMRZU53IhaB_TWRcOGvjRTJGadg-HQHeLtDdNuC3hpildY0fACE8w>
    <xmx:eIMRZV1MqEjvvSVTqacPFM3Lh1nbeR7ZJPKTb3JmsGh7iHHhfyiiXQ>
    <xmx:eIMRZfHVQ2w-HVNxjSu2qd0c55A3N58R3Tqit6uHDQgXsRt2bG3GyQ>
    <xmx:eIMRZU6vmz7suZuPg1Oh-DggHz2EcWQgVuZhVHsxZ6QS-c0GdrBSzg>
Feedback-ID: ibe194615:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 75C14C6008B; Mon, 25 Sep 2023 08:56:24 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-761-gece9e40c48-fm-20230913.001-gece9e40c
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <de3914ef-6f35-47c2-b2da-a509c775ebd8@app.fastmail.com>
In-Reply-To: <e86b094a-f55a-4bdd-9d98-5710567c54cb@kernel.org>
References: <047d3c51-0a9e-4c3e-beef-625a7aa4f3c3@kernel.org>
 <505264f5-cbbb-4ffe-a3e4-93d2397e80da@kernel.org>
 <beeab87b-820a-475a-b0c6-99b1b8e491ea@kernel.org>
 <207922c7-7a56-499b-bbfd-9e8d6a0a06df@kernel.org>
 <74ad10fa-f0f6-f80f-7db3-fb01aae6f2d5@redhat.com>
 <e86b094a-f55a-4bdd-9d98-5710567c54cb@kernel.org>
Date: Mon, 25 Sep 2023 08:56:04 -0400
From: "Mark Pearson" <mpearson-lenovo@squebb.ca>
To: "Jiri Slaby" <jirislaby@kernel.org>,
 "Hans de Goede" <hdegoede@redhat.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>, "Len Brown" <lenb@kernel.org>,
 "Henrique de Moraes Holschuh" <hmh@hmh.eng.br>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
 ibm-acpi-devel@lists.sourceforge.net,
 "platform-driver-x86@vger.kernel.org" <platform-driver-x86@vger.kernel.org>,
 "Linux kernel mailing list" <linux-kernel@vger.kernel.org>
Subject: Re: WARNING at drivers/acpi/platform_profile.c:74 in platform_profile_show()
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Thanks Hans & Jiri,

On Mon, Sep 25, 2023, at 5:15 AM, Jiri Slaby wrote:
> Hi,
>
> On 25. 09. 23, 10:57, Hans de Goede wrote:
>> Jiri, Thank you for all the debugging you have done on this. Can you please file
>> a bug with the details / summary here:
>> 
>> https://bugzilla.kernel.org/enter_bug.cgi?product=Drivers
>> 
>> Using Platform_x86 as component so that Mark has all the info in one place ?
>
> Done:
> https://bugzilla.kernel.org/show_bug.cgi?id=217947
>
Ack - replied to the ticket with details. 

We'll need to debug what is going on and I think I need a patch to improve the PSC vs AMT mode detection (and handling the error to....)

Mark

