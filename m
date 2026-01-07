Return-Path: <linux-acpi+bounces-19996-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 74906CFDA37
	for <lists+linux-acpi@lfdr.de>; Wed, 07 Jan 2026 13:24:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C363E3011F9C
	for <lists+linux-acpi@lfdr.de>; Wed,  7 Jan 2026 12:21:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8987B313E38;
	Wed,  7 Jan 2026 12:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N0icFhC0"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BA9530FC0F;
	Wed,  7 Jan 2026 12:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767788514; cv=none; b=FVBAqpor/fufcv2TWbss4euiT59w1OFuWKPUAQZjPT6zQRobYpu6Tav8B63B9K+QssCoNorfR+AkXR8fx0zwp0s2QwWtx8zhZGYYrZU+PxDZ2ZRtpStwPs3U2HIMB78Nhy/O7qSGfa+HRV/Cvi9jRkiE3jEZClhyDBc2R8cT4qs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767788514; c=relaxed/simple;
	bh=zXFoS4zHTy0V5PAm7R3MWzyYBGz1up+78Si09Dd2B9o=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=nIZzA3bX4Nj7HjrxHXb1/ieU4TDZXbtxua09c30TuIvFf5HJKX/YX2KTeStsKZ+RZKqHl23Ewr7v8iTGKBOQKSC2dgbUdpyM24bUdgTkcV9ImLOQy7ONPC2pvZej/4wHYmQ4w9uOUhrgfeLX3D4Zbx/ytuzzb0Vcl1oNijAx3MQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N0icFhC0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38AF9C4CEF7;
	Wed,  7 Jan 2026 12:21:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767788513;
	bh=zXFoS4zHTy0V5PAm7R3MWzyYBGz1up+78Si09Dd2B9o=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=N0icFhC0SqQYqQtNT+qZ/P3gK/Gv81vhCPFYqxq9pc7lQemEhGyhb7dAAOjGGe87y
	 V80RmXJ+PxoOin5Ytsdqj5sPmfi0Li92s5cA9EkiZKrBDNtToDGKdVlvUrA+xlrRVS
	 qr5N4wtJ4NvvF9UEaGswPaOtgicEcRJJ3F0I3FCJ9ygs3h0RCf1xeHjg0YdY7iQ9ac
	 TwxQ7xdoiK6T2j2t+fzOViWMqxmFykOn2MkkQVvLYX3TtRO6p5QtxuuGabISsqVCGQ
	 PdgiLGdwgwI+vI+7jt3xNyJTfsByxctUfua8r+4+zVw45x6Q/82N7EXZGTAw3BsgMk
	 sf0AsWJG9G/gA==
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 07 Jan 2026 13:21:49 +0100
Message-Id: <DFICQ5UQZLVB.24RQQD89L7F3R@kernel.org>
Subject: Re: [PATCH v2] ACPI: Documentation: driver-api: Disapprove of using
 ACPI drivers
Cc: "Linux ACPI" <linux-acpi@vger.kernel.org>, "LKML"
 <linux-kernel@vger.kernel.org>, "Andy Shevchenko"
 <andriy.shevchenko@linux.intel.com>, "Bjorn Helgaas" <helgaas@kernel.org>,
 "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>, "Hans de Goede"
 <hansg@kernel.org>, "Linux Documentation" <linux-doc@vger.kernel.org>,
 "Mika Westerberg" <mika.westerberg@linux.intel.com>, "Zhang Rui"
 <rui.zhang@intel.com>, "Armin Wolf" <w_armin@gmx.de>, "Ilpo Jarvinen"
 <ilpo.jarvinen@linux.intel.com>, "Mario Limonciello"
 <mario.limonciello@amd.com>, "Randy Dunlap" <rdunlap@infradead.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <2396510.ElGaqSPkdT@rafael.j.wysocki>
 <DFHK7ZS7H7LJ.1POCUDPSLC3CP@kernel.org>
 <CAJZ5v0gDXSdAy9wJYUc_yyHD-Y_tPk0eVzWTyMLe7uHm30_Ncw@mail.gmail.com>
In-Reply-To: <CAJZ5v0gDXSdAy9wJYUc_yyHD-Y_tPk0eVzWTyMLe7uHm30_Ncw@mail.gmail.com>

On Wed Jan 7, 2026 at 1:14 PM CET, Rafael J. Wysocki wrote:
> On Tue, Jan 6, 2026 at 3:01=E2=80=AFPM Danilo Krummrich <dakr@kernel.org>=
 wrote:
>>
>> On Tue Jan 6, 2026 at 1:27 PM CET, Rafael J. Wysocki wrote:
>> > +This means that it really should never be necessary to bind a driver =
directly to
>> > +an ACPI device node because there is a "proper" device object represe=
nting the
>> > +corresponding piece of hardware that can be bound to by a "proper" dr=
iver using
>> > +the given ACPI device node as the device's ACPI companion.  Thus, in =
principle,
>> > +there is no reason to use ACPI drivers and if they all were replaced =
with other
>> > +driver types (for example, platform drivers), some code could be drop=
ped and
>> > +some complexity would go away.
>>
>> I think it would be good to explicitly encourage people to convert exist=
ing
>> drivers (maybe even list some of those) and rephrase the last sentence t=
o list
>> what exact infrastructure, complexity, etc. can go away once that happen=
ed.
>
> I can rephrase the last sentence, but the purpose of this document is
> to explain the motivation for the change rather than to make a call to
> action.
>
>> I think this would make it more likely to receive some contributions tow=
ards
>> this goal.
>
> I have prototype driver conversion patches for almost 50% of the cases
> right now and I'm expecting to have them for all of the cases by the
> end of the current development cycle, so I'm not sure how much there
> is to gain.
>
> I want people to not be surprised when they see those patches though.


Ok, sounds good then. With or without rephrasing the last sentence,

Reviewed-by: Danilo Krummrich <dakr@kernel.org>

