Return-Path: <linux-acpi+bounces-21131-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WPYTFqy3nWmQRQQAu9opvQ
	(envelope-from <linux-acpi+bounces-21131-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Tue, 24 Feb 2026 15:37:32 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id ADF79188733
	for <lists+linux-acpi@lfdr.de>; Tue, 24 Feb 2026 15:37:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5B78632154C1
	for <lists+linux-acpi@lfdr.de>; Tue, 24 Feb 2026 14:31:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C68F3A0EA9;
	Tue, 24 Feb 2026 14:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ijHK9CTX"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59B1D3A0EA2
	for <linux-acpi@vger.kernel.org>; Tue, 24 Feb 2026 14:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771943446; cv=none; b=FEmPnu4gdRxlSg6ieZUM/avn0HCihXtKvcQxYQiQH3AGD/MCiLbfNQTjoKKLtILnQH6X+0+e7c9i6g18v6hlRY1ZrjwKiA4+Ksmep4/ZBr1DVnInrbpKI4lpiczOHDtG6lXdW5vw5lSplabRhzAJGEFBGVovIPm5m/5cEjWbj10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771943446; c=relaxed/simple;
	bh=41wmo8561dJtopbEtdJZbd+g4hqX6H4Uzewh81mHmzk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sy7BTu6aDh7LUCvZOTU3aVs3XoeHjGiyj+wBYAxjkjO5cztULFJRdRTaUYPZtg9nagRyrUw64PRZfIsjqgX6mKDdZ6VcksSUeNMhOk5/3cq74EanbxeJtqUMe6GVdNzZj/4HHg63WfuVs+7zf5ITC7/YuaWjazoTAiIxIAm5KhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ijHK9CTX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37D97C116D0
	for <linux-acpi@vger.kernel.org>; Tue, 24 Feb 2026 14:30:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771943446;
	bh=41wmo8561dJtopbEtdJZbd+g4hqX6H4Uzewh81mHmzk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=ijHK9CTXTi5hDr7GYPiX2ogSg1Cigc/5UThtY10yTfYVpMRC8ZafXSuJB8tkKx90g
	 MosmUGAua30SPrfdo21867/g2nj+3k7si6YznQbzOuauxgvWVEY/5rJKExy1Clrn1J
	 83kEP7xTYIoK7lABNS810zVyRNlnVpjtfZZ7+pOMQSJvjwbSZr0BU9/++KRDcHqXbN
	 JVH6xA2YBgyAHKoWSHFg/1MuxdOC6adfr07AAb6IMqCiyApQbgcGeJ/RBcX9liz3I1
	 qDJClT3LZlesDp124Lyvg5De0Hh+/Bu9WUhS9KJR6mO2OuA9jic+pt0d2G2ovJrgPP
	 VrtPvc4ciOf5g==
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-463960df4f9so3542760b6e.0
        for <linux-acpi@vger.kernel.org>; Tue, 24 Feb 2026 06:30:46 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVdmQ0hiYTuG6AbZuIXj6ieE99CCIT8RKxTQh3bAHXHwrmRiG16+AJwrARazlOC6m2seTO6q+2qtK7i@vger.kernel.org
X-Gm-Message-State: AOJu0YwGJflJyLLVrDUVyxuyGZVLBDaZj1ncNV3+UnCDg8QUlQDxEvC9
	mKlken7ukqG88MLsEt71FmpCm6whq94tXuEXjtZ6Kux60/S8LLCTyYaqB5sugnc8n0WMLkMxAmA
	QsK+EwY75hNbNehSIr9VvAdRwcXYF+jI=
X-Received: by 2002:a05:6870:f146:b0:409:99bb:1eb0 with SMTP id
 586e51a60fabf-4157b15eacemr6957155fac.44.1771943444716; Tue, 24 Feb 2026
 06:30:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260223204412.3298508-1-andriy.shevchenko@linux.intel.com>
 <20260223204412.3298508-2-andriy.shevchenko@linux.intel.com>
 <CAJZ5v0gS6kyCOmwL-9JYiaxCDVubtBoK6Rb5NSgHD1GwkGoCRA@mail.gmail.com>
 <aZ1p4lgioFlxhFr_@smile.fi.intel.com> <CAJZ5v0hUwCFKH3f6pCW1idquyJ-93wtXzO70tq6D+ruU17+oGw@mail.gmail.com>
 <2026022436-scrambled-mumbling-59a3@gregkh> <aZ2veVh1tXkFf7Nh@smile.fi.intel.com>
In-Reply-To: <aZ2veVh1tXkFf7Nh@smile.fi.intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 24 Feb 2026 15:30:33 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0hvtUYDVwT8OaxP9OCKgcmjhadELAyWxKCRZrkqM4a3AA@mail.gmail.com>
X-Gm-Features: AaiRm50KUde5LdLbp5lcn8KAEyDcyhHkbkv5mWJZF85t8dNKyJxPY1Oe3e5EAgE
Message-ID: <CAJZ5v0hvtUYDVwT8OaxP9OCKgcmjhadELAyWxKCRZrkqM4a3AA@mail.gmail.com>
Subject: Re: [PATCH v1 1/3] driver core: Split device data types to device/types.h
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Zijun Hu <zijun.hu@oss.qualcomm.com>, linux-kernel@vger.kernel.org, 
	driver-core@lists.linux.dev, linux-acpi@vger.kernel.org, 
	Danilo Krummrich <dakr@kernel.org>, Len Brown <lenb@kernel.org>, Daniel Scally <djrscally@gmail.com>, 
	Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
	Sakari Ailus <sakari.ailus@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21131-lists,linux-acpi=lfdr.de];
	FREEMAIL_CC(0.00)[linuxfoundation.org,kernel.org,oss.qualcomm.com,vger.kernel.org,lists.linux.dev,gmail.com,linux.intel.com];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rafael@kernel.org,linux-acpi@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-acpi];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:email]
X-Rspamd-Queue-Id: ADF79188733
X-Rspamd-Action: no action

On Tue, Feb 24, 2026 at 3:02=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Tue, Feb 24, 2026 at 05:17:43AM -0800, Greg Kroah-Hartman wrote:
> > On Tue, Feb 24, 2026 at 01:21:10PM +0100, Rafael J. Wysocki wrote:
> > > On Tue, Feb 24, 2026 at 10:05=E2=80=AFAM Andy Shevchenko
> > > <andriy.shevchenko@linux.intel.com> wrote:
> > > > On Mon, Feb 23, 2026 at 09:53:17PM +0100, Rafael J. Wysocki wrote:
> > > > > On Mon, Feb 23, 2026 at 9:44=E2=80=AFPM Andy Shevchenko
> > > > > <andriy.shevchenko@linux.intel.com> wrote:
> > > > > >
> > > > > > device.h is a huge header which is hard to follow and easy to m=
iss
> > > > > > something. Improve that by splitting device data types to devic=
e/types.h.
> > > > > >
> > > > > > In particular this helps to speedup the build of the code that =
includes
> > > > > > device.h solely for a device data types.
> > > > > >
> > > > > > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.c=
om>
> > > > >
> > > > > But why do you want to move the struct device definition out of d=
evice.h?
> > > >
> > > > Because it's a data type, and we have many drivers that may require=
 it
> > > > (embed the struct device), but no device.h API is called directly =
=E2=80=94
> > > > only via a certain framework).
> > > >
> > > > device.h also includes many unrelated headers in such a case.
> > >
> > > Why is this a problem?
> > >
> > > Could those headers be moved to different header files instead?
> > >
> > > device.h is mostly about the struct device definition and the other
> > > stuff in it is more or less additional.  Why do you want to make it
> > > the other way around?
> >
> > I agree, this feels wrong.
>
> Nobody is going to remove device.h :-)

And nobody is talking about removing it.

We are simply saying that the definition of struct device should
remain in device.h proper.  I'm not sure what is unclear about that.

> It's a split based on the trend in the kernel.

Well, in this particular case that trend doesn't appear to be helpful.

