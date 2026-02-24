Return-Path: <linux-acpi+bounces-21128-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GOUzMwWtnWmgQwQAu9opvQ
	(envelope-from <linux-acpi+bounces-21128-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Tue, 24 Feb 2026 14:52:05 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D96A18803B
	for <lists+linux-acpi@lfdr.de>; Tue, 24 Feb 2026 14:52:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id F1B6D302734D
	for <lists+linux-acpi@lfdr.de>; Tue, 24 Feb 2026 13:47:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F3FE39E193;
	Tue, 24 Feb 2026 13:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X7z7YoBn"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F07E3379974;
	Tue, 24 Feb 2026 13:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771940858; cv=none; b=C3uROa9e1sTLBe08frO/P68Mhsr9MY6+qPRTmGT9DyMrdcynI1avXlaPpVeqF7/P8wLcIRguLSlZk/ppyfg56a5kmXTBeU7+P6tJFjq5KIxQ1YHxyeI+WS0UaikviBAhomBHlK1x5kHav7jA99ybL95UIuCtsvnympVDXbdVj08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771940858; c=relaxed/simple;
	bh=q2R5e1cZ/PwyeT+nSHUGIWZ7CSz8/wQnDWc+REwaRNQ=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:From:Subject:Cc:
	 References:In-Reply-To; b=euk2YlxZYQ/sCCBIzOgq3a+G2mUUwZGEIrrFaEWFVVHE8Dgc/5wN5BBxBEw+BM0mEQHk4fdRgtzHXPDVmhdikC2VSgq6xC5JimUEL2fo+MnXHgPtffijaJQrPvSAPQxA3rM7ZuNT63fSc34MB0YaRPj6KHHtEI/qpl7LZmb/Lp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X7z7YoBn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65593C116D0;
	Tue, 24 Feb 2026 13:47:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771940857;
	bh=q2R5e1cZ/PwyeT+nSHUGIWZ7CSz8/wQnDWc+REwaRNQ=;
	h=Date:To:From:Subject:Cc:References:In-Reply-To:From;
	b=X7z7YoBnkxdp/8wnlMOhKxDrb09SX+i6bxgqHT/EYyPIxkkIGYd2x1E1PH/pTcAW3
	 w/hhgus0zqqmgSwcyMqAnlA3CO8xbsNNIF7vfa+8+oPoKXGzlfsaGpQgXRGoxtokQc
	 VGiu6LPY8fPYc5wfFXkHLWxYKFeCsG2wQHA9TBgZhfN28u0RQieGG/YTXUUqxCUpuW
	 tOf9NdY7RmGiII2hhWrh3xbzcQA5Hng8lI82W0vHzP/YV7x3i1Im+LNfiehCOgCpQ9
	 iNXOLklwaMUW6hphgg40MEpY3h3AqCfgNtLpod3BkYrY/uepGGSL+1Sij4BVU9b7oz
	 yQW6EkDwmkQVg==
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 24 Feb 2026 14:47:33 +0100
Message-Id: <DGN8LYFUE7DR.4LE7JDAMPXRI@kernel.org>
To: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
From: "Danilo Krummrich" <dakr@kernel.org>
Subject: Re: [PATCH v1 1/3] driver core: Split device data types to
 device/types.h
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, "Andy Shevchenko"
 <andriy.shevchenko@linux.intel.com>, "Zijun Hu"
 <zijun.hu@oss.qualcomm.com>, <linux-kernel@vger.kernel.org>,
 <driver-core@lists.linux.dev>, <linux-acpi@vger.kernel.org>, "Len Brown"
 <lenb@kernel.org>, "Daniel Scally" <djrscally@gmail.com>, "Heikki Krogerus"
 <heikki.krogerus@linux.intel.com>, "Sakari Ailus"
 <sakari.ailus@linux.intel.com>
References: <20260223204412.3298508-1-andriy.shevchenko@linux.intel.com>
 <20260223204412.3298508-2-andriy.shevchenko@linux.intel.com>
 <CAJZ5v0gS6kyCOmwL-9JYiaxCDVubtBoK6Rb5NSgHD1GwkGoCRA@mail.gmail.com>
 <aZ1p4lgioFlxhFr_@smile.fi.intel.com>
 <CAJZ5v0hUwCFKH3f6pCW1idquyJ-93wtXzO70tq6D+ruU17+oGw@mail.gmail.com>
 <2026022436-scrambled-mumbling-59a3@gregkh>
In-Reply-To: <2026022436-scrambled-mumbling-59a3@gregkh>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21128-lists,linux-acpi=lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,linux.intel.com,oss.qualcomm.com,vger.kernel.org,lists.linux.dev,gmail.com];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dakr@kernel.org,linux-acpi@vger.kernel.org];
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-acpi];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,intel.com:email]
X-Rspamd-Queue-Id: 4D96A18803B
X-Rspamd-Action: no action

On Tue Feb 24, 2026 at 2:17 PM CET, Greg Kroah-Hartman wrote:
> On Tue, Feb 24, 2026 at 01:21:10PM +0100, Rafael J. Wysocki wrote:
>> On Tue, Feb 24, 2026 at 10:05=E2=80=AFAM Andy Shevchenko
>> <andriy.shevchenko@linux.intel.com> wrote:
>> >
>> > On Mon, Feb 23, 2026 at 09:53:17PM +0100, Rafael J. Wysocki wrote:
>> > > On Mon, Feb 23, 2026 at 9:44=E2=80=AFPM Andy Shevchenko
>> > > <andriy.shevchenko@linux.intel.com> wrote:
>> > > >
>> > > > device.h is a huge header which is hard to follow and easy to miss
>> > > > something. Improve that by splitting device data types to device/t=
ypes.h.
>> > > >
>> > > > In particular this helps to speedup the build of the code that inc=
ludes
>> > > > device.h solely for a device data types.
>> > > >
>> > > > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>> > >
>> > > But why do you want to move the struct device definition out of devi=
ce.h?
>> >
>> > Because it's a data type, and we have many drivers that may require it
>> > (embed the struct device), but no device.h API is called directly =E2=
=80=94
>> > only via a certain framework).
>> >
>> > device.h also includes many unrelated headers in such a case.
>>=20
>> Why is this a problem?
>>=20
>> Could those headers be moved to different header files instead?
>>=20
>> device.h is mostly about the struct device definition and the other
>> stuff in it is more or less additional.  Why do you want to make it
>> the other way around?
>
> I agree, this feels wrong.

To me device/types.h also seems superfluous, the other ones seem OK to me a=
s
they structure things a bit better.

