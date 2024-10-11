Return-Path: <linux-acpi+bounces-8713-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 854C199A2DF
	for <lists+linux-acpi@lfdr.de>; Fri, 11 Oct 2024 13:40:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0AF551F225EC
	for <lists+linux-acpi@lfdr.de>; Fri, 11 Oct 2024 11:40:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FBC421643F;
	Fri, 11 Oct 2024 11:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="NKaCYkMQ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="EqRULKR7"
X-Original-To: linux-acpi@vger.kernel.org
Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A00821643B;
	Fri, 11 Oct 2024 11:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728646830; cv=none; b=hYCI54lZ0NhM+R8qk06AzgpWXJDPRXpFImpRwI3VEwTJrM/+Kwc21hCpsGtM6jPRXHjOipl2Ruy96Vj64yQiNGmnJvM5z/MTNT42vWVnYae/WHP0NLazYM5QgP8WP3JLRFw1tCvk3jKO/kLyMDBgUG617l66EuZa5OO5xeqbAiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728646830; c=relaxed/simple;
	bh=E0uLNKlYvH0dxSBdTiYirq/wtt16RGxOt3/DuwhvSR4=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=cfS7NSWQDgx4l071bAc4hSqWZ8e/TEex5/w6aMYhiGoVJS0oL1BnqhgkhgcYTqVBeN6nWDvMqwlUNhbgAMQpa8QPXavF8kSYhtWC9rI9YH6QyzSCFcZYsu3u+0W9qSMZlJxsRcj4J9UencDMCDS9ynbgB55m/CXIMnr0DcvQTsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=NKaCYkMQ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=EqRULKR7; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfout.phl.internal (Postfix) with ESMTP id 4BC6D1380253;
	Fri, 11 Oct 2024 07:40:26 -0400 (EDT)
Received: from phl-imap-11 ([10.202.2.101])
  by phl-compute-10.internal (MEProxy); Fri, 11 Oct 2024 07:40:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1728646826;
	 x=1728733226; bh=MhSWrtX6s8vgNNIK35j1EB/WOrIzvkqk+qHLyGkv08c=; b=
	NKaCYkMQDaeIekJyorXyJr8yiNuKIWsLwRsMkXTzg+8glsqUpwQt5a48i5aWcOoP
	olpuHS6W3wBWpvbBcJ5mdmLCpLsPgMAPZxfciPCl4/idKKrYjheRG/8xVx1xMUns
	Z97EP3YY5ln5wfceI2SFgKcS2ervHPRKK8pf3HBrgleGKzyRennD3qNWSbJQgNYn
	5fky4PNL/i3+R2vIbZJm1x3jc8BdZ0bYIDt1GeBOJrm0LsMzYGymVKxu0jRt/TVK
	CxdTvQzeKTsIxp7pK2gt3IpCVTbfz44lJp53Vu6S44ID72WZxq9rVtpmBFr/v0oI
	qocdCQ1xGgGV0LICDCtbXA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1728646826; x=
	1728733226; bh=MhSWrtX6s8vgNNIK35j1EB/WOrIzvkqk+qHLyGkv08c=; b=E
	qRULKR7ku5pHabRSyEF/vBRAKPPwp22WsLqyx0zB6XgQBd3/QAMsZ9xjaH73kSMa
	gH6p1ebHzF6G4/sfRRtSMN46yIpzNmA4eeNzjK0VwwQOZn2QWdCV46hp60QoYl7s
	9ycUHOD/F6PCkz3RNZ8vTmG+Q//6whrmI+oph4hHxELMJ+5ZqHYO85wlv72u1uue
	NZQ4S1ROQEqAvOaVD/bZVyV9mb68PZjUmQoBvNtz5lsCrgZILFqMpprTujAyie+2
	VyYM7M0j9ZpdzT4dozZjnHpj6otY0TfygrP1yUxZds0bmHLh7ztXgv0U2JZ63dic
	WoOF0KKdbi9N4lSfaORIw==
X-ME-Sender: <xms:qg4JZx-M3qUoy1KLHf_OQA_EVkvgwNhUpKyXr5MOVYNj3Om3EYv9BQ>
    <xme:qg4JZ1ufL-iHIIl9EZNdu3Hj99KmmYmShV1i5yfhR0s02DX4P5tPDM7pkhn3TkV5l
    Z-LsOTTLVJNKhErNOE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdefkedggeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddt
    necuhfhrohhmpedftehrnhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrd
    guvgeqnecuggftrfgrthhtvghrnhephfdthfdvtdefhedukeetgefggffhjeeggeetfefg
    gfevudegudevledvkefhvdeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomheprghrnhgusegrrhhnuggsrdguvgdpnhgspghrtghpthhtohepuddt
    pdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehmrghrihhordhlihhmohhntghivg
    hllhhosegrmhgurdgtohhmpdhrtghpthhtohepphgvrhhrhidrhihurghnsegrmhgurdgt
    ohhmpdhrtghpthhtoheprghrnhgusehkvghrnhgvlhdrohhrghdprhgtphhtthhopehlvg
    hnsgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprhgrfhgrvghlsehkvghrnhgvlhdr
    ohhrghdprhgtphhtthhopegrnhgurhhihidrshhhvghvtghhvghnkhhosehlihhnuhigrd
    hinhhtvghlrdgtohhmpdhrtghpthhtohepvggrhhgrrhhihhgrsehlihhnuhigrdhmihgt
    rhhoshhofhhtrdgtohhmpdhrtghpthhtohepjhgrrhhrvggufihhihhtvgeslhhinhhugi
    drmhhitghrohhsohhfthdrtghomhdprhgtphhtthhopehlihhnuhigqdgrtghpihesvhhg
    vghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:qg4JZ_Dztm6VajHLghvKlsBmqWt6Tqfpy0DpSOE2HJypW3m6HBM0CQ>
    <xmx:qg4JZ1fpMsmCh-GMCiRI5iwq9x4n5Hx6v7MY1pkdZ539yzyOO7tWAw>
    <xmx:qg4JZ2NIyTIUajPeQv-PCTEbRaX5wRKgFKopFpoZ0EGpD9PqjfVOBg>
    <xmx:qg4JZ3lg54z7-u2UQ68mLrQcWCbcZJ0vE3nO2ouuLki1AdIjE7YOLA>
    <xmx:qg4JZ9oNQfTPiL0Hrnco_xU5B6-3pFDj5MqViSObL1M_DeS94qMFLHab>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id EA52D2220071; Fri, 11 Oct 2024 07:40:25 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 11 Oct 2024 11:40:05 +0000
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Andy Shevchenko" <andriy.shevchenko@linux.intel.com>
Cc: "Arnd Bergmann" <arnd@kernel.org>,
 "Rafael J . Wysocki" <rafael@kernel.org>, "Len Brown" <lenb@kernel.org>,
 "Mario Limonciello" <mario.limonciello@amd.com>,
 "Jarred White" <jarredwhite@linux.microsoft.com>,
 "Perry Yuan" <perry.yuan@amd.com>,
 "Easwar Hariharan" <eahariha@linux.microsoft.com>,
 linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Message-Id: <e135bc0a-7c06-4ee2-b149-100595a29d7e@app.fastmail.com>
In-Reply-To: <ZwkIFREb1Ia90hSR@smile.fi.intel.com>
References: <20241011061948.3211423-1-arnd@kernel.org>
 <20241011061948.3211423-2-arnd@kernel.org>
 <Zwj1p3uMEA24a0sU@smile.fi.intel.com>
 <de65a5c8-1bbd-47b3-9dc5-de4ad93c41b8@app.fastmail.com>
 <ZwkIFREb1Ia90hSR@smile.fi.intel.com>
Subject: Re: [PATCH v2 2/3] acpi: allow building without CONFIG_HAS_IOPORT
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Fri, Oct 11, 2024, at 11:12, Andy Shevchenko wrote:
> On Fri, Oct 11, 2024 at 09:59:46AM +0000, Arnd Bergmann wrote:
>> On Fri, Oct 11, 2024, at 09:53, Andy Shevchenko wrote:
>> > On Fri, Oct 11, 2024 at 06:18:18AM +0000, Arnd Bergmann wrote:
>> >> +	if (!IS_ENABLED(CONFIG_HAS_IOPORT)) {
>> >> +		*value = BIT_MASK(width);
>> >> +		return AE_NOT_IMPLEMENTED;
>> >
>> > Perhaps it has already been discussed, but why do we need to file value with
>> > semi-garbage when we know it's invalid anyway?
>> 
>> It's not strictly necessary, just precaution for possible callers
>> that use the resulting data without checking the error code.
>
> Do you have any examples of that in the kernel?


drivers/acpi/processor_throttling.c:            acpi_os_read_port((acpi_io_address) throttling->status_register.
--
drivers/cpufreq/acpi-cpufreq.c-
drivers/cpufreq/acpi-cpufreq.c: acpi_os_read_port(reg->address, &val, reg->bit_width);

$ git grep ^[^=]*acpi_os_read_port 
drivers/acpi/processor_throttling.c:            acpi_os_read_port(\ (acpi_io_address) throttling->status_register.
drivers/cpufreq/acpi-cpufreq.c: acpi_os_read_port(reg->address, &val, reg->bit_width);

>> The all-ones data is what an x86 PC would see when an I/O
>> port is read that is not connected to any device.
>
> Yes, but it's not what your code does.

My bad, I was confused about what BIT_MASK() does.
I'll change it to "GENMASK(width, 0)", which should
do what I intended.

      Arnd

