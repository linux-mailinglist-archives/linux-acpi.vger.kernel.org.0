Return-Path: <linux-acpi+bounces-9116-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64CAC9B6336
	for <lists+linux-acpi@lfdr.de>; Wed, 30 Oct 2024 13:40:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 891741C20B5F
	for <lists+linux-acpi@lfdr.de>; Wed, 30 Oct 2024 12:40:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B365D1E8831;
	Wed, 30 Oct 2024 12:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="D+QsQA4F";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KQ345wXD"
X-Original-To: linux-acpi@vger.kernel.org
Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E81831E1023;
	Wed, 30 Oct 2024 12:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730292044; cv=none; b=Lg6v0DVz5fZjoZJZD2L6Jvck8zRpv4ZhgIgQk/qSQn+pltJqp9eXQeWe/a1jzSScEqe6CMDgrN8GkJgr6nvkLM6jNAVbU8i5mXuGISZeVvUNQVgPKB5rUQgF4LlK9zQmuKi9DEQkE3ScDVBMhgTDplXnfSpujWXSINRgCdPYEKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730292044; c=relaxed/simple;
	bh=0qAAzGekVtowe4cps1erqjPh++mnzXN1zf/BuEP3m4U=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=h6r/pABxOTnhPl6S1QVEXGpVRkCC8fpvWlRMG+BatohQSMhDlifn48fnXa85hUsjND5MkdnLWddhWVpih7GQAzSZPI5XjJgiJGbTLT0FZVsCCRNPSQRhbHz3kYSWkTyuXZoU66gZarGMCQ3+vbZ88lwKsLBezOWiQvv7b2G5j8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=D+QsQA4F; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=KQ345wXD; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfout.phl.internal (Postfix) with ESMTP id C90CE138021D;
	Wed, 30 Oct 2024 08:40:39 -0400 (EDT)
Received: from phl-imap-11 ([10.202.2.101])
  by phl-compute-10.internal (MEProxy); Wed, 30 Oct 2024 08:40:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1730292039;
	 x=1730378439; bh=3/PyFIXHNwwlaFvxYykZOeb+fLtobP6/CYzQcrA2KAg=; b=
	D+QsQA4FRY/8ASWL5YsRhv+9koR30qp+3O9GDYhtfannboPHAlDxTItLzipaT0Ay
	jLEVuzVtnuQOgZrIPlF88mHICVocgbkPQWOofmbEKMfCjCImLWdVg7aSNu17CEI8
	XjvXPR8w3w0OGOv1J++B06ed80CuwSSebh9JzT7kyHV2vk1vd/nQZD8fPe1ljMdr
	KbF+Odgbp/9f51m4YM9GT7ZQlkXTXvaTRbRFV7I8yAaXQDL+/mFkDoC1LJtZ41nF
	bRG+1dXvy65ZlJZruNwSNmJqLLYeVTX+gUpNIGsbKpbBpOaQTbvUbF18dU2rbSZo
	h42CxIeSV1o0SHsiKeI7Hw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1730292039; x=
	1730378439; bh=3/PyFIXHNwwlaFvxYykZOeb+fLtobP6/CYzQcrA2KAg=; b=K
	Q345wXDk/nPB3d/CqCW52yCIm+RpLnpA5NKv9NaEjvOH3RkR5xaB1AQ1HSVgWkzP
	74vDHkfTXkeUcJ7ZjEkHZyaO4ODNZ3KddPage1n0G/U/OuSmM1gyK0AMENUrtUik
	tjyRcY6X6otN09Ml1QxZsxqjEDiyIjaw5GrCR4k4e/KMhpXh1g2Nw6WjjQQdVsb9
	UGrBqYjVqE9qKtoM7251gMvOiOddEOgoZdnJP9CEJ7HAXUJPvj5TMaFO29iLUtt2
	XTeqwd9JEaB/vBzZSHCkZAxxJ2OCDkFlnM8GlH0ynWZMplXZfvPHz7IMENG4a5hH
	K1a2XEg6M5BkCHMj2CpkA==
X-ME-Sender: <xms:RykiZ2f3IqHF9f5UT5p3s9lpyCWltVEMbe3XL9fWSbYb_qoEMsqeMg>
    <xme:RykiZwP9E7Oo1IsLrRus_PQkVuzpgBmliUqTEvGss4e8DbDtnBAsYaRJ3Ixzaiv3e
    bFpev9tQ4Bk6KobH3o>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdekfedggedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepofggfffhvfevkfgjfhfutgfgsehtqhertdertdej
    necuhfhrohhmpedftehrnhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrd
    guvgeqnecuggftrfgrthhtvghrnhepvdfhvdekueduveffffetgfdvveefvdelhedvvdeg
    jedvfeehtdeggeevheefleejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomheprghrnhgusegrrhhnuggsrdguvgdpnhgspghrtghpthhtohepudef
    pdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehjohhnrghthhgrnhdrtggrmhgvrh
    honheshhhurgifvghirdgtohhmpdhrtghpthhtoheprghrnhgusehkvghrnhgvlhdrohhr
    ghdprhgtphhtthhopehlvghnsgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprhgrfh
    grvghlsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehilhhpohdrjhgrrhhvihhnvghn
    sehlihhnuhigrdhinhhtvghlrdgtohhmpdhrtghpthhtohepghhrvghgkhhhsehlihhnuh
    igfhhouhhnuggrthhiohhnrdhorhhgpdhrtghpthhtohephhguvghgohgvuggvsehrvggu
    hhgrthdrtghomhdprhgtphhtthhopehlihhnuhigsehrohgvtghkqdhushdrnhgvthdprh
    gtphhtthhopehjuggvlhhvrghrvgesshhushgvrdgtohhm
X-ME-Proxy: <xmx:RykiZ3jE9wRvtMd7ykr9VA2jmaLtOIsUhT6X8S8mv1MTQKJOcWBBoA>
    <xmx:RykiZz_jhStJmuADBQwO0N0-CAgcF54ooRyRGTIuQpadK65hSGNt0w>
    <xmx:RykiZysghC6avGitncwY5ua74hKtCta3CXNaUEkdc8Rg6COJlxevMA>
    <xmx:RykiZ6HwsvUWHgN6hJDO2E0KmT-ZgV6s7V1zefHJypnNqCVzU01nDw>
    <xmx:RykiZzHXtXVCf-1-f7KdRUW9WpB1zhtavEXzHr3-4j-lTezpRj77Gkzg>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 58DF52220071; Wed, 30 Oct 2024 08:40:39 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 30 Oct 2024 12:40:18 +0000
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Rafael J . Wysocki" <rafael@kernel.org>,
 "Arnd Bergmann" <arnd@kernel.org>
Cc: "Len Brown" <lenb@kernel.org>,
 "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
 "Jean Delvare" <jdelvare@suse.com>, "Guenter Roeck" <linux@roeck-us.net>,
 "Hans de Goede" <hdegoede@redhat.com>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 "Jonathan Cameron" <Jonathan.Cameron@huawei.com>, linux-acpi@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
 platform-driver-x86@vger.kernel.org
Message-Id: <43b6bbd9-ef5e-4031-9322-fecfa2a5c5cd@app.fastmail.com>
In-Reply-To: 
 <CAJZ5v0iCvPuey3EN5D5+0QNt5ZkQN5TtfKhA7Qod0_JBFbsB=g@mail.gmail.com>
References: <20241011061948.3211423-1-arnd@kernel.org>
 <CAJZ5v0jX1Ga9g8BweYJT2GQsJh03pD_imrY7tCP-Xg_gq0EbOA@mail.gmail.com>
 <CAJZ5v0iCvPuey3EN5D5+0QNt5ZkQN5TtfKhA7Qod0_JBFbsB=g@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] acpi: make EC support compile-time conditional
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 24, 2024, at 15:49, Rafael J. Wysocki wrote:
> On Mon, Oct 21, 2024 at 1:39=E2=80=AFPM Rafael J. Wysocki <rafael@kern=
el.org> wrote:
>> On Fri, Oct 11, 2024 at 8:19=E2=80=AFAM Arnd Bergmann <arnd@kernel.or=
g> wrote:
>> >
>> > All the direct callers of ec_read/ec_write already had an x86
>> > dependency and now also need to depend on APCI_EC.
>> >
>> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>>
>> I think I can pick up this one as the other two patches in the series
>> don't depend on it.
>>
>> Any concerns about doing that?
>
> No concerns, so applied (as 6.13 material, with minor edits in the sub=
ject).
>
> The other two patches in the series need to be updated AFAICS.

Thanks for picking up the first patch, I sent the other
updated patches as well now.

    ARnd

