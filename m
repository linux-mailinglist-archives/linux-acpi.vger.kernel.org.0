Return-Path: <linux-acpi+bounces-12228-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 27D9DA607F5
	for <lists+linux-acpi@lfdr.de>; Fri, 14 Mar 2025 04:50:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B3171694B3
	for <lists+linux-acpi@lfdr.de>; Fri, 14 Mar 2025 03:50:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D253E78F4E;
	Fri, 14 Mar 2025 03:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=colorremedies.com header.i=@colorremedies.com header.b="FOYR8SAh";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ICHooG5R"
X-Original-To: linux-acpi@vger.kernel.org
Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F60F3C6BA
	for <linux-acpi@vger.kernel.org>; Fri, 14 Mar 2025 03:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741924228; cv=none; b=BHdPcR9tkOVDWT+4ETQhNmzQcVpo/kXeqs5wb/TiQmohW0b1MWVwLvNV0Rh2/PPRoSboN5n9qwOEewW2qRc3QgbKbArGVFVdVjGRtC0FLu6pi1Lu6DOEP9ITlLLTr//rVFAHoVWX63HlSzGKMDTfhEww0ZHMoKbTSqJiBhrwa6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741924228; c=relaxed/simple;
	bh=PJECavn1xRkVkpfuceGGuMbCuH6kSir9c4Jbrw6hKrQ=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=IPksNPQ7zzqi4O3q3jfUgpkQitmJzVSZ/OaWIXjWn8h9mWGq0am/wQqoOZNsO1zN/g9XAMtu7fhYCuY6XskDX16djNeQrjebn3WwuMnumkqdaqU5aXBbYWgk6rxWJ6qznhP2vaiwBKRJ0R7RMmhcORSn7XgP+HWPI0s+5/gtS8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=colorremedies.com; spf=pass smtp.mailfrom=colorremedies.com; dkim=pass (2048-bit key) header.d=colorremedies.com header.i=@colorremedies.com header.b=FOYR8SAh; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ICHooG5R; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=colorremedies.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=colorremedies.com
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 4305F25401D6;
	Thu, 13 Mar 2025 23:50:25 -0400 (EDT)
Received: from phl-imap-12 ([10.202.2.86])
  by phl-compute-11.internal (MEProxy); Thu, 13 Mar 2025 23:50:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	colorremedies.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1741924225; x=1742010625; bh=Ig55ZdMgkK
	iQ0HU4TJwNNiTa8Iozy6deVqHHNUJ1rFE=; b=FOYR8SAhEfV1AWFogCUPr9S2bW
	ackfGI9m5ZoP9VEseQX++1SErvJtQGj+3i7z7N21HXPL3r6zU2Kj5dfeADi2SWbK
	eo0PGKsXzPljjegwmfvpxCIyJcuo9EOEQoJ4+aBFNn4VcJ1zFndLNh0QKNpf1XTu
	yk88LE+nGAggcfdSX6m0eh9wa6+P1yrnWy1o2SYtMn1iCweOnWi31aDOUIDlMzcd
	hmDjiQRZvQ0uXpeJy7auU41/Avsav2X6ZNZFoWh/1g0qU3p3J0fzSwzvZt453Gah
	kPM2y8619SMW0E7gMZ4OSwFqG2cS7JYvx0kfCKK1rV6FgDHMsJhu7Q0aTRdQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1741924225; x=
	1742010625; bh=Ig55ZdMgkKiQ0HU4TJwNNiTa8Iozy6deVqHHNUJ1rFE=; b=I
	CHooG5RO9j042VcQg9nYyww6GyiXmO0WXsQOJcTFDAKriYz2+UpPdO1pYQ2unwqE
	62ThX1AyTit3dpyBLlACLINTcGdG5Zg7hEExgiXBRBFqxT5USl6ksj9n7WKbeCkB
	Aljo6Tjfne8m98qE2oAFFYm78+azSFTVaphAuuK8oALClnKrNFZMT/wb4XtwWkoH
	SYrstLfzJ41YBuCzNgMLnU4ELtfXTn+NlFMCjKmfhTrVnzBoTn3NLr6fEhe9qkdM
	f02dYx5TwSh9jyDwUgaDEN9aOcUp1S0s3iejaCgamKz/4kC+xHQGATW+O77MD4aU
	Wz/QeIaLuMmHqtpcN19WA==
X-ME-Sender: <xms:gKfTZ96MzvOLHdvYdUd9icJUMZWBwG_ZyEelebeSM47MNhMRtsuZPg>
    <xme:gKfTZ66KHwogF2z0owlj_ohK8r0DEcfWc38nt34bHK23Ud9kTuoMaRWY4PX-YzJjc
    NhjuGDHq76QDjh_rMQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduvdeljeelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepofggfffhvfevkfgjfhfutgfgsehtqhertder
    tdejnecuhfhrohhmpedfvehhrhhishcuofhurhhphhihfdcuoegthhhrihhssegtohhloh
    hrrhgvmhgvughivghsrdgtohhmqeenucggtffrrghtthgvrhhnpeehudetgfekfedttddv
    tdejleevheeikeegueeilefftedvveeiveffffelvdevgfenucevlhhushhtvghrufhiii
    gvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegthhhrihhssegtohhlohhrrhgvmhgv
    ughivghsrdgtohhmpdhnsggprhgtphhtthhopedvpdhmohguvgepshhmthhpohhuthdprh
    gtphhtthhopehrrghfrggvlheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhu
    gidqrggtphhisehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:gKfTZ0e4zll-mv3AiQ-QFXdm0HEN3hQfz2ynQ9z0UVwUmSuTz53N3w>
    <xmx:gKfTZ2Ks665nZMy6WXlpJVFzz1RXai9H9UYH-zl5WIiJ99F977Ws7Q>
    <xmx:gKfTZxI21FlMz6CN7q5wkW4fESYh7VrqbwTi_gn13vgj9ECDqnaZWg>
    <xmx:gKfTZ_zNbd3LJBw_KZjLHW6J-Ii_90EDKOe8S_mhqq2pkkmY4kq_BA>
    <xmx:gafTZ_gh88-gvR_JYAwtZIniLRbBYnVkxaAxwMX7HtMnqUEXj0nNjxR7>
Feedback-ID: i07814636:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id D58C81C20066; Thu, 13 Mar 2025 23:50:24 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 13 Mar 2025 21:50:03 -0600
From: "Chris Murphy" <chris@colorremedies.com>
To: "Rafael Wysocki" <rafael@kernel.org>
Cc: linux-acpi@vger.kernel.org
Message-Id: <9fb371c9-420d-4d45-9b6d-d213f87064d6@app.fastmail.com>
In-Reply-To: 
 <CAJZ5v0jH99jkZrsE-Ne---FwPcaOSThL+TEL0BP_w+QXaKng0g@mail.gmail.com>
References: <90e6da7b-a2b2-4ff3-bb04-f39b1f6c5e70@app.fastmail.com>
 <CAJZ5v0jH99jkZrsE-Ne---FwPcaOSThL+TEL0BP_w+QXaKng0g@mail.gmail.com>
Subject: Re: 6.14.0-rc debug kernel is slow, kacpi_notify high cpu usage
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



On Thu, Mar 13, 2025, at 9:35 AM, Rafael J. Wysocki wrote:
> On Thu, Mar 13, 2025 at 5:12=E2=80=AFAM Chris Murphy <chris@colorremed=
ies.com> wrote:
>>
>> Four kacpi_notify kernel threads are continuously using CPU, makes th=
e laptop warm,
>> fans run continuosly. This is a Fedora debug kernel, it's not intende=
d for production.
>> But I'm wondering if this performance hit is expected and if it's wor=
th it (for kernel developers).
>
> No and no.

Is it a firmware or kernel bug? Any other info I should provide?

I updated the firmware to the latest firmware, but the behavior is uncha=
nged. I'm not sure what kernel config might be responsible for this, so =
I'm not sure what to suggest to the kernel team to make the performance =
hit go away.


> kacpi_notify is only used for Notify() processing which only happens
> when there are events signaled by the platform firmware.  Like battery
> or thermal events, for example.

It seems to happen more often than not, happens with AC power connected =
or not.

--=20
Chris

