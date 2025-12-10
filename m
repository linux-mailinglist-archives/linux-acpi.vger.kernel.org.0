Return-Path: <linux-acpi+bounces-19538-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 86B96CB3343
	for <lists+linux-acpi@lfdr.de>; Wed, 10 Dec 2025 15:46:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C0D9C3154A70
	for <lists+linux-acpi@lfdr.de>; Wed, 10 Dec 2025 14:45:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A152B304BAB;
	Wed, 10 Dec 2025 14:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jb7X0hix"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DE32231830;
	Wed, 10 Dec 2025 14:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765377901; cv=none; b=jbx86o3Nv7h/LtMJQ6/5Shj5d2/lTJFgVW48bU+uWq2t1LdfCZRfxTnd7RlNLszjb83OZWhKgZ9s7TI/ftmeXk/tQngSzEMd53KoaB7WxykzCjg2ybS8YN/aIQsAFX9zHDTYB7iVMSS/Jz4pDdrwVAZzH07apdMYY1QOCCEm/Nc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765377901; c=relaxed/simple;
	bh=od0HFCFkKhHqxPl2tzU1C8txK2KajeGXbMBU9xCICfA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Z57ElljBamaW4kBkFci8piewFIgB62FatIKyJ77ZQKVRamLlrofrPIynLz7RHsGd+op2tmYZfelpVoRm5W9/VCbb0fpqK5m0sKwAN0Y+x+taawVE3hSBAKc/JtZ/D0gwStCy9XcrrQF+eIWsXSRWXuOevZ3gZck/5RSzP152YvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jb7X0hix; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 087C1C4CEF1;
	Wed, 10 Dec 2025 14:44:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765377901;
	bh=od0HFCFkKhHqxPl2tzU1C8txK2KajeGXbMBU9xCICfA=;
	h=From:To:Cc:Subject:Date:From;
	b=Jb7X0hixKBfVAghguqDosdIS8s/K+8LUggQsyfOUE0+eUVWGy2ui5eVr+4PwAL8K2
	 aPqwzFJq27vv1dQfZsghk/+H0eyHVce7rHmrztpkxn7jlDoMqhZnOFfcLcW7mN9vVt
	 PpjsDet3JwF80DdJnwVJF2Ab1Cdi+9aklS3KrxjmfGwCZG4Xb7GLUIJ1302MFCoedf
	 V18UojVIYMasQ/hC+fI1oSbF9Ms70oJZRiIgDk/yzFlUW08IlYgG2XGj4NOXd1pTi1
	 VWPCnzXd5Q7zKKxE2KwDbSLzfv2OqfH+YmpYomC9DT/Z/Qcr7T4SWilW/K3O0K5Ret
	 AAxHNmQ93wdNw==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>,
 Armin Wolf <w_armin@gmx.de>, Hans de Goede <hansg@kernel.org>
Subject:
 [PATCH v1 0/4] ACPI: thermal: Convert ACPI thermal driver to a platform one
Date: Wed, 10 Dec 2025 15:41:37 +0100
Message-ID: <6222428.lOV4Wx5bFT@rafael.j.wysocki>
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

specifically concerning the ACPI thermal driver which is kind of a special
case because ACPI thermal zone objects it binds to are formally not device
objects.

Also the series contains one extra modification on top of the driver
conversion.

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
should generally be avoided and so this series converts three generic ACPI
device drivers, the button driver, the tiny power button driver, and the
battery driver, to platform drivers.

Patches [1-2/4] are preparatory, patch [3/4] is the driver conversion one,
and patch [4/4] updates thermal zone power management to stop attempting
to resume active cooling devices (fans).

Thanks!






