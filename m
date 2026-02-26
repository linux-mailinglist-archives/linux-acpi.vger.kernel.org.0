Return-Path: <linux-acpi+bounces-21178-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YB8YE8/pn2l7ewQAu9opvQ
	(envelope-from <linux-acpi+bounces-21178-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Thu, 26 Feb 2026 07:35:59 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A54FA1A1595
	for <lists+linux-acpi@lfdr.de>; Thu, 26 Feb 2026 07:35:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5A239304480B
	for <lists+linux-acpi@lfdr.de>; Thu, 26 Feb 2026 06:35:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10D4C2BE64F;
	Thu, 26 Feb 2026 06:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="Y+clA8gG"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20FF6223DD4;
	Thu, 26 Feb 2026 06:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772087756; cv=none; b=LJXbD7M0pFVSG0bzEoKCT18Y/dcxbG+7bfce4ZOm9XfQcNT+6JSJ+IxIxvxGUD0BZkY6IOyA8bYHC4LhiuMiuqX5SJq+vUQo2E9q4sn9vMi1sKjf2Hb6Sw0HwCpwJd95qBVdN9TxC0dhcuXirw9A9dy22Ug2WGTh1NKKHBLNzVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772087756; c=relaxed/simple;
	bh=clCIZW1g5REI+8+JPLAovHKqYTsLG3ZPRfws3cT9+oU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KjMt8T2PFiNqeUWk5ATVJfQ6JZ4T25Er0yK1bWFpDPlU4oF7HnDM8l1cmnhjoMcxPevzLRYs7rbN1z/gxvFffyO/mjHyejvn63JFC2rogX4VZFUs6pngDBIgrfd9Ub7TULSaR2pnZ0B32mteMdNoNW7kn9wIkANBBt0K2CVRJVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=Y+clA8gG; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1772087748; x=1772692548; i=w_armin@gmx.de;
	bh=i9stZFnGYSdrXOZ1q0VJaVqTGr82Zixdt5j1nUPvGmE=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=Y+clA8gGrcsT6n/8LqzFVt93Bd2uBhS2bi+DZqbxd8DLs99L5Dgvdh1jEa4j8j8M
	 Rjuo3WAyc+UIIqcbK5hPXZsNT4TQT6VXEvPV5JCYhaDH3sHYxpkAecu2zGTSWP0sS
	 2JM9jBRJO+MnHlfJhf8WOgne/HdedvS/TT/oYAZgqXyAdoItF0FZg/rArtpXkihPe
	 3g9682PKeLfTEYe9pZoOsyDhKC7/j4g7sI1hCf217V6TVfQGbfiOk6E/1h/ufssTO
	 yvVCGGI8a7iiIAbUnJGDYa357vNorQfH+UNiOjJnITBe4GE0w6bh8LZe25A2gW3QR
	 3VDF/uM5EW1gYVKHjQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1My36T-1vVBMZ0Edr-014Ykn; Thu, 26
 Feb 2026 07:35:48 +0100
Message-ID: <6825e6b2-802b-4cd2-b2c5-b4eab67b00e4@gmx.de>
Date: Thu, 26 Feb 2026 07:35:47 +0100
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] ACPI: OSL: Poweroff when encountering a fatal ACPI
 error
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: lenb@kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260204212931.3860-1-W_Armin@gmx.de>
 <c5d23d8a-8f58-48c3-90ca-5d1a46964280@gmx.de>
 <CAJZ5v0g6w_2+4oUytzxHtAhsJczK9pe84ZfXPeOcjKqU0k_GkQ@mail.gmail.com>
Content-Language: en-US
From: Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <CAJZ5v0g6w_2+4oUytzxHtAhsJczK9pe84ZfXPeOcjKqU0k_GkQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:tKfWy7GLjPVO8NpE80cRWWLU1PKIxDXssvxgjHImFFHWi5gmA5p
 u8e7jKj/z+UbxgpQ8v3OzZhbvl5NuH4UpkhyXcOPjIi8yLw2z4JDaddJcDp/ddMJbjLG0CM
 QtwE/+OTNjKk+SJ1xHBiRYqY0jCT/E2ejlNBgQOUFJZPoZaJJju3Q4HHnmfI1l370gO56js
 9V5qO3YqAFTvXZWPO/euA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:o8plUEL/j8c=;dCUqwQHh0UZqNAZnPG/KzcqQLe+
 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
 wfyQzx3xq4aGvJxE8MU3clHOQtkxv
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmx.de,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmx.de:s=s31663417];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21178-lists,linux-acpi=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[W_Armin@gmx.de,linux-acpi@vger.kernel.org];
	DKIM_TRACE(0.00)[gmx.de:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-acpi];
	FREEMAIL_FROM(0.00)[gmx.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,gmx.de:mid,gmx.de:dkim,gmx.de:email]
X-Rspamd-Queue-Id: A54FA1A1595
X-Rspamd-Action: no action

Am 25.02.26 um 22:28 schrieb Rafael J. Wysocki:

> On Wed, Feb 25, 2026 at 12:06=E2=80=AFAM Armin Wolf <W_Armin@gmx.de> wro=
te:
>> Am 04.02.26 um 22:29 schrieb Armin Wolf:
>>
>>> The ACPI spec states that the operating system should respond
>>> to a fatal ACPI error by "performing a controlled OS shutdown in
>>> a timely fashion". Comply with the ACPI specification by powering
>>> off the system when ACPICA signals a fatal ACPI error. Users can
>>> still disable this behavior by using the acpi.poweroff_on_fatal
>>> kernel option to work around firmware bugs.
>> Any updates on this?
> I was about to apply it, but then I thought that I was not sure about
> the Kconfig option.
>
>   I don't see much value in it TBH.  If you agree, I'll just apply the
> patch without that part.
>
> Thanks!

You can drop the Kconfig option if you want.

Thanks,
Armin Wolf


