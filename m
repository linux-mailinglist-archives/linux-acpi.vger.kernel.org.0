Return-Path: <linux-acpi+bounces-19542-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 55099CB337B
	for <lists+linux-acpi@lfdr.de>; Wed, 10 Dec 2025 15:51:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7C98430309D6
	for <lists+linux-acpi@lfdr.de>; Wed, 10 Dec 2025 14:51:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2AC6248F69;
	Wed, 10 Dec 2025 14:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h9VihVKA"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 576CE23BF9C;
	Wed, 10 Dec 2025 14:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765378312; cv=none; b=Yr2vjG1D/CYgbdX9lFa/OjK+l/W+Os/lR/O84QQx14PSLW2cvGwC/NbYk+SM2FjOUqJU+wfXFVGZlLfAZSrp+WcPz62iPky9BcIO/JD1CR1lYtAHxAvpD5Ft+stdLD1jt+BX/YcO8Dm9KJF9X///UPKIcL/ZEfdrf/5H8ywZ0ds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765378312; c=relaxed/simple;
	bh=izr7/LN9/bWfO6kF07G9Tmq+DLJEtc6ivbfspIC/PNs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=hZliRnYPbHWF+WjeCn2lyBg/6/hf4ZWfx2dfm/15DvQKRDN+MqecDBEpnm73MN/aI4KPiJ8SSuq3h5Hex5R/gPWjdITWsOWynPcVzA1kfaIX0odjsp7kpe0J1GWGwerm9I1Rsi3sz0ZDg47XdUQbd1UOIz1XcQeYJXTm5Ag8XM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h9VihVKA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5BD0C116B1;
	Wed, 10 Dec 2025 14:51:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765378311;
	bh=izr7/LN9/bWfO6kF07G9Tmq+DLJEtc6ivbfspIC/PNs=;
	h=From:To:Cc:Subject:Date:From;
	b=h9VihVKAhv+LhJjQIvD5HPa1QIupAWT4mSBhNycK1KXzYmqhi4op66Aq+9Pp3XJWL
	 XiQw2jTFo2ze6HpUABvzCy9OP2xYIKq9Cfq22sSq0VBZV+KhM1WjuYYqfQLU/a8B0G
	 JLxRyEQCyTRnRZr4DSdSEy/JJC44FEmtt49WcQUMWBjz30U3pF1RmEMcNO/vpUHQrV
	 0MnHM4ozy1J09iH1yjNht5iQRfF+S6lOO+COVriaBf13TKqsmrCnqUGSIPhFCE56Ek
	 KKxIt12aJCyqDUWa0aQBCpbaFHN3jmDRHq4/TUe73YTj2RUSHhP1xSNyVvmCEJehck
	 wxxGBdrnStWBQ==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>,
 Armin Wolf <w_armin@gmx.de>, Hans de Goede <hansg@kernel.org>
Subject:
 [PATCH v1 0/3] ACPI: video: Convert ACPI video driver to a platform one
Date: Wed, 10 Dec 2025 15:47:34 +0100
Message-ID: <8617910.T7Z3S40VBb@rafael.j.wysocki>
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

This is a continuation of

https://lore.kernel.org/linux-acpi/2339822.iZASKD2KPV@rafael.j.wysocki/

specifically concerning the ACPI video (backlight) driver which is kind of
a special case because ACPI backlight device objects it binds to are ACPI
companions of PCI devices (GPUs).

The general rationale is the same as for the series linked above.

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
should generally be avoided and so this series converts the ACPI video
driver to a platform one.

Patches [1-2/3] are preparatory and patch [3/3] is the driver conversion one.

Thanks!




