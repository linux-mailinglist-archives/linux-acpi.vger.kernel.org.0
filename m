Return-Path: <linux-acpi+bounces-19586-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8388DCBE590
	for <lists+linux-acpi@lfdr.de>; Mon, 15 Dec 2025 15:42:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 51CC1300FA5D
	for <lists+linux-acpi@lfdr.de>; Mon, 15 Dec 2025 14:41:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D687E3385A7;
	Mon, 15 Dec 2025 14:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q+JcviIx"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB17F3385A2;
	Mon, 15 Dec 2025 14:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765807475; cv=none; b=gBV0tjdqrXnOAQlPkVKgeZc0orcZxBkOlOaob7U8CTIFs8WnwUlX/2oecWeZpgS7dKmwWsKfcjvharTtDWXaDElOcP5iEqRcVkMcffZg8kftWePDzja/6BaNgZdqoSxs76XizstL3Ban1na6aA5SOBEhL7SDYLT0RG+YOT6nYrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765807475; c=relaxed/simple;
	bh=LclMBG+oMB2W3XcVZd5f9au0ndsmhr3xP+voKeNCflc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=b6yyfu7D6GDNAFEaibcadKcbkShd4G9k8jZ8ADjhshanDoMsujcVGljaA7T8s2Md38OOIcRezymnbS1fTATy7fJTnRqRRSZt5x57Hii4z9QUj74pbClEJNb2F02AyT8iG44P9dn2PZpIj8ERzQwqwC4u2FttoJaoO6RGBqkUVMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q+JcviIx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29030C19423;
	Mon, 15 Dec 2025 14:04:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765807475;
	bh=LclMBG+oMB2W3XcVZd5f9au0ndsmhr3xP+voKeNCflc=;
	h=From:To:Cc:Subject:Date:From;
	b=Q+JcviIxS8mVhMtj3xW2UX48UygXiuHGYNPzHEI8BoXl46Xfb1eexQMnnBsBngabY
	 84SHaO8a/uo4QsK06R1CFkgmMgQlVN4xNf9znyBDOiZNoZz15PP9jxV7b6qWcxcyEX
	 DZE6eB/e+yBk1JtXPEQ+EO99d1hRo/5TNx7brjp0kIPoQ2h2WsxHGbF/Dwnw0VjGxv
	 3Pvpxs7WcE9J7x7AsN93ezamHSnqbzHp8gxVBcPUEAR9JiCE/IEKxSnAn9E/pswBAV
	 yOrzTrkhax4TxCxjkBMDKbRFC3B7BI4Of51Nwh/wyH1I4s1glxzoAMcOsBCXIYcxUe
	 uZjUOfwfr4+gw==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: Hans de Goede <hdegoede@redhat.com>, LKML <linux-kernel@vger.kernel.org>,
 Linux PM <linux-pm@vger.kernel.org>,
 Thomas =?ISO-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>,
 Armin Wolf <w_armin@gmx.de>
Subject:
 [PATCH v2 00/10] ACPI: Convert button and battery drivers to platform ones
Date: Mon, 15 Dec 2025 14:50:25 +0100
Message-ID: <2685338.Lt9SDvczpP@rafael.j.wysocki>
Organization: Linux Kernel Development
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"

Hi All,

This is a v2 of

https://lore.kernel.org/linux-acpi/2339822.iZASKD2KPV@rafael.j.wysocki/

with the majority of patches unchanged and some of them updated, mostly
for cleanliness.

The following intro still applies.

While binding drivers directly to struct acpi_device objects allows
basic functionality to be provided, at least in the majority of cases,
there are some problems with it, related to general consistency, sysfs
layout, power management operation ordering, and code cleanliness.

First of all, struct acpi_device objects represent firmware entities
rather than hardware and in many cases they provide auxiliary information
on devices enumerated independently (like PCI devices or CPUs).  It is
therefore generally questionable to assign resources to them or create
class devices and similar under them because they don't provide
functionality associated with those entities by themselves (for example,
they don't generate wakeup or input events).

As a general rule, a struct acpi_device can only be a parent of another
struct acpi_device.  If that's not the case, the location of the child
device in the device hierarchy is at least confusing and it may not be
straightforward to identify the piece of hardware corresponding to that
device.

Using system suspend and resume callbacks directly with struct acpi_device
objects is questionable either because it may cause ordering problems to
happen.  Namely, struct acpi_device objects are registered before any
devices corresponded to by them and they land on the PM list before all
of those devices.  Consequently, the execution ordering of their PM
callbacks may be different from what is generally expected.  Moreover,
dependencies returned by _DEP objects don't generally affect struct
acpi_device objects themselves, only the "physical" device objects
associated with them, which potentially is one more source of inconsistency.

All of the above means that binding drivers to struct acpi_device "devices"
should generally be avoided and so this series converts three generic ACPI
device drivers, the button driver, the tiny power button driver, and the
battery driver, to platform drivers.

Patches [01-03/10] are preliminary for the button driver conversions.  Patch
[01/10] causes platform devices to be registered for "fixed event device"
buttons, patch [02/10] cleans up the "fixed event device" registration code,
and patch [03/10] rearranges the notification handling code in the button
driver to use internal "button" structures for passing data instead of
struct acpi_device objects.

Patches [04-05/10] convert the two button drivers to platform ones and
patches [06-07/10] do some cleanups on top of them.

Patches [08-09/10] are preliminary for the battery driver conversion which
is carried out in patch [10/10].

Thanks!






