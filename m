Return-Path: <linux-acpi+bounces-19556-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id ADAC7CB635C
	for <lists+linux-acpi@lfdr.de>; Thu, 11 Dec 2025 15:37:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 695D13096D31
	for <lists+linux-acpi@lfdr.de>; Thu, 11 Dec 2025 14:32:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A17D1288C20;
	Thu, 11 Dec 2025 14:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n/r3yYTj"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74DF0288514;
	Thu, 11 Dec 2025 14:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765462947; cv=none; b=kXGnW7Y08XVJa1W1C1aWDu26e0R+M5da98bqt2Wu4z43vhgwcynqe3RnJ8+TMKgSnszUIlni3odLSW+SspsPA/Wgtbwc8GenU57P1w1evpeDlJb07YqDjFgg9uOgzVhqbf4OZxL6U6Uu+FqVzTJkDNNt87hzzrhlDlcW1f8I2/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765462947; c=relaxed/simple;
	bh=gJj1Lic7z2YZcmjvWqi3nWloKI25nl3Fjgt2mV6fyRo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ErhGFjOnNy2bHQXC5hqEz2UK5kcE3DVJLluaSqaGd7RjiiGSMljNyI1BqZdoHz0C7k2l80UUCPQP7Zf6QvdaGFN8TD2rHkQe0Pd23B7eP5coCKPnLXtr1WOR58NI+adR44B6Ff1CsZaVyCtblr6qOfKmkj9gkTAUlEJQ3Ny68v4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n/r3yYTj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B4BFC19421;
	Thu, 11 Dec 2025 14:22:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765462947;
	bh=gJj1Lic7z2YZcmjvWqi3nWloKI25nl3Fjgt2mV6fyRo=;
	h=From:To:Cc:Subject:Date:From;
	b=n/r3yYTjdohXigC/DXb1p5qTfKQRvzSonjIU+zXyIbeiXQ/2ggHVESbtMeRHCj+uL
	 gkDt4tP0EGkJwz2AMZrpD2TazIHULRa4XaqOG8HnunTUkxCCEBAwrdxXhQJo6JcgtI
	 TbT06RhaDv94gbycDCxxL1Skqx50KGp1mOuC+lVVSFlkCMjYxIzV7kKK9hb9pz3W36
	 6d0gM1baO8perXZpeaWavMo9zgqeFaKCpjk8V7+X29CSY+9/xBRKv4joWttX0UWKVr
	 J7rnu/pdo271jqTxjejaOSXFDMfkPp0kLAyFgSRlR8hrixWtuVOFfpr4zQjClCmaVf
	 vudJl1TZgJwWQ==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>,
 Armin Wolf <w_armin@gmx.de>, Hans de Goede <hansg@kernel.org>
Subject:
 [RFT][PATCH v1 0/6] ACPI: Convert remaining ACPI drivers in drivers/acpi/ to
 platform drivers
Date: Thu, 11 Dec 2025 15:15:32 +0100
Message-ID: <5066996.31r3eYUQgx@rafael.j.wysocki>
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

and the two series posted yesterday:

https://lore.kernel.org/linux-acpi/6222428.lOV4Wx5bFT@rafael.j.wysocki/
https://lore.kernel.org/linux-acpi/8617910.T7Z3S40VBb@rafael.j.wysocki/

with the same rationale, but it does not depend on any of them.

This one takes care of the EC driver, the SMBUS HC one (that turns out to
depend on the EC one), the SBS one (that depends on the SMBUS HC one), the
HED (hardware error device) driver and the NFIT driver.  I would appreciate
testing it on systems with an ECDT table and with SMBUS HC and SBS, but
overall testing it everywhere is welcome.

After all of the series above and this one, all of the struct acpi_driver
drivers in drivers/acpi/ will become proper platform drivers and the
plan going forward is to convert all of the struct acpi_driver in other
subsystems (for instance, platform/x86/) to platform drivers and eliminate
struct acpi_driver from the kernel along with all of its dependencies and
related code.

Thanks!




