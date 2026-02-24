Return-Path: <linux-acpi+bounces-21126-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wGRZLKeYnWnwQgQAu9opvQ
	(envelope-from <linux-acpi+bounces-21126-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Tue, 24 Feb 2026 13:25:11 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 597D1186EAF
	for <lists+linux-acpi@lfdr.de>; Tue, 24 Feb 2026 13:25:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1DA71311FA9E
	for <lists+linux-acpi@lfdr.de>; Tue, 24 Feb 2026 12:21:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE580396D23;
	Tue, 24 Feb 2026 12:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OLfbpEwP"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAEB8396D1A
	for <linux-acpi@vger.kernel.org>; Tue, 24 Feb 2026 12:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771935683; cv=none; b=TBGWAGzEu6qS/f0lwdVUO7DUMiMtJUCgfohml1ZQCR+tczUN2b0HkMHwyGfSY9RbbDNnAEk0Ra1HZgkZlUaD+tKZFvMXgvBqBJ645B/dHTBOc4jLGhaLhBEnTwfbPBTr77p97qr1Nn48du8e937h6btvQuu4viFYpgQV2qzbDVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771935683; c=relaxed/simple;
	bh=qeiE8prTSBBAw3kzkORhXcd0llIS/zF9fU+idkLpvc0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I26Rn99dhQCBhT/2wr0+jGwS0wcwdD/BlM+8lSTn+9mlDmNHnKCusnLvbKqQd3/umFckohEnid9Vh4lYQoUNuTy55oWo8L/5Wlo5HXzz3ncFHxIXPVP7rP4swohEP0XV/RHg3XUC2Pp3/cnyznhzFXuVHS3Bo8z2lNwKuFiRphs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OLfbpEwP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87115C19424
	for <linux-acpi@vger.kernel.org>; Tue, 24 Feb 2026 12:21:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771935683;
	bh=qeiE8prTSBBAw3kzkORhXcd0llIS/zF9fU+idkLpvc0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=OLfbpEwP34kfma9oJIt/FpcFz79Oi+NcwY5X25e/q+58YlQoPCL+gTJmaivq36xic
	 4/bVGe1xIOXu9R9Z6Hrl1ZV29j77Uorr+2OECYiHGS9bMxGPVBaEf7g8BvyX4ibPwj
	 CzCmqHk6Eyvc8GSZT2yvRxW9H02+OmZdyXkmCH68kUy0UIL0MxUDBBJmgDUDdqTh4j
	 DKjB0f+qpyrd0Y7QbPmzmjmtLmvuoRyv2mpf7srhGEyykHVpzhECz2zSQ7zSzJc4ew
	 QVy6tZpDF/RKyiJhX/u+Q/Y83eZQxHshF6Ucr4P7lfp3WuqhHCFziqu4jY1WK0QaTX
	 hXNUopFnF8N1w==
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-7d4c68f0e47so3252691a34.1
        for <linux-acpi@vger.kernel.org>; Tue, 24 Feb 2026 04:21:23 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXMvRiaZk3uILITG2crruOKUq9o9Iqw53qHqFSkpYZhbIqFaE198aFCHR3mBV3ZsEWJJBcMjklKSizv@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6dZElfLucboyC5QL23g33/YRDvwY5nNBCvsNTMty6KF6jjCnG
	d8toiUJVP+DlGemhH7PtrkfrmIzmqlTmVmn4sK7iO92goh+nj7KRyzFrEdpeXhtTHuCzhSwG9U5
	45+N1Hoc5FImnxalOMwLKrr7Is7MzYIM=
X-Received: by 2002:a05:6830:7181:b0:7c7:2d7d:5d0f with SMTP id
 46e09a7af769-7d52bf3ea23mr6651601a34.20.1771935682677; Tue, 24 Feb 2026
 04:21:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260223204412.3298508-1-andriy.shevchenko@linux.intel.com>
 <20260223204412.3298508-2-andriy.shevchenko@linux.intel.com>
 <CAJZ5v0gS6kyCOmwL-9JYiaxCDVubtBoK6Rb5NSgHD1GwkGoCRA@mail.gmail.com> <aZ1p4lgioFlxhFr_@smile.fi.intel.com>
In-Reply-To: <aZ1p4lgioFlxhFr_@smile.fi.intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 24 Feb 2026 13:21:10 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0hUwCFKH3f6pCW1idquyJ-93wtXzO70tq6D+ruU17+oGw@mail.gmail.com>
X-Gm-Features: AaiRm50Lc8LqRacvNU19wNDDonluoX7up49q2kXb2dcY2nK4iMjMXkGPP-hHwCQ
Message-ID: <CAJZ5v0hUwCFKH3f6pCW1idquyJ-93wtXzO70tq6D+ruU17+oGw@mail.gmail.com>
Subject: Re: [PATCH v1 1/3] driver core: Split device data types to device/types.h
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Zijun Hu <zijun.hu@oss.qualcomm.com>, 
	linux-kernel@vger.kernel.org, driver-core@lists.linux.dev, 
	linux-acpi@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21126-lists,linux-acpi=lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,oss.qualcomm.com,vger.kernel.org,lists.linux.dev,linuxfoundation.org,gmail.com,linux.intel.com];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rafael@kernel.org,linux-acpi@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-acpi];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,mail.gmail.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 597D1186EAF
X-Rspamd-Action: no action

On Tue, Feb 24, 2026 at 10:05=E2=80=AFAM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Mon, Feb 23, 2026 at 09:53:17PM +0100, Rafael J. Wysocki wrote:
> > On Mon, Feb 23, 2026 at 9:44=E2=80=AFPM Andy Shevchenko
> > <andriy.shevchenko@linux.intel.com> wrote:
> > >
> > > device.h is a huge header which is hard to follow and easy to miss
> > > something. Improve that by splitting device data types to device/type=
s.h.
> > >
> > > In particular this helps to speedup the build of the code that includ=
es
> > > device.h solely for a device data types.
> > >
> > > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> >
> > But why do you want to move the struct device definition out of device.=
h?
>
> Because it's a data type, and we have many drivers that may require it
> (embed the struct device), but no device.h API is called directly =E2=80=
=94
> only via a certain framework).
>
> device.h also includes many unrelated headers in such a case.

Why is this a problem?

Could those headers be moved to different header files instead?

device.h is mostly about the struct device definition and the other
stuff in it is more or less additional.  Why do you want to make it
the other way around?

