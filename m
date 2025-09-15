Return-Path: <linux-acpi+bounces-16962-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BB81B584A1
	for <lists+linux-acpi@lfdr.de>; Mon, 15 Sep 2025 20:31:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C2AAB2A700E
	for <lists+linux-acpi@lfdr.de>; Mon, 15 Sep 2025 18:31:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9C72313271;
	Mon, 15 Sep 2025 18:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OKC9Bf8t"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A20C623908B;
	Mon, 15 Sep 2025 18:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757961030; cv=none; b=ZlrCXiUDlASddtWExQCLXP2fXN2cRY9gZOZOeaHwRGLWnDko2O08fQ5eBBi5K4tNxc0Y7m9obj8HXgHljezFY/5UCPeZTE6szWEFjHxsrXeRNUkNBz75xEcGhx+uMgx9KZCFsjdZ0mb1/laumHmLTxpJMNof9HNJ6ywH2xagHhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757961030; c=relaxed/simple;
	bh=+7UiS/QXjF9RQTAZNXTIp+fTmoFVr00pxKkZiLSRZn8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=t8YWPFNvKH2st4vnpGMJg1O8w6fDB/T/M1r6urfmXTcJO7X9I/1R6r0vxj9sl9ObAucb9iTBdSo9RjG55+GoAfLUCZoGvV0Iqi7QRTdMPShOyvk8PzjJQm0M7dA6HaOng9ocXW6DK5bRsrVtv3WOAAijBn2TQECRvwZozNSKLnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OKC9Bf8t; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03C39C4CEF7;
	Mon, 15 Sep 2025 18:30:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757961029;
	bh=+7UiS/QXjF9RQTAZNXTIp+fTmoFVr00pxKkZiLSRZn8=;
	h=From:To:Cc:Subject:Date:From;
	b=OKC9Bf8t0x0hiQJ2CjHgusfDf6K7fXPYOvfFhhbxyY7hP/cJ+kzOoBU6HwQFy3KFZ
	 ytOm0r7kcnjvbBVsXylee09wB7Lir8tMakxTwZrNz01JTGECQUflk+x+MqjAzOHBE4
	 NZtTNCKXHtUrQGLJ2Zw/ke08tY1AbwoJA0bQlxdxtLQccC/JDU8viZBX0P26d8AVne
	 QrINjhoGK5PcEDnEmqen1kDcfgMfDSFAeDiJy3lR/ySsRrUyji4HpoJVp+OKqr2WS3
	 BHJLhM6S6Tsiw3tXxd+nBYfk49Wu+P/UZ+4S634W5j87cuoLMInVA4IQqhE2NdNxKj
	 tyfOLfiYy8qoQ==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Mika Westerberg <mika.westerberg@linux.intel.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Sakari Ailus <sakari.ailus@linux.intel.com>
Subject: [PATCH v2 0/5] ACPI: property: Two fixes,
 more documentation and a cleanup
Date: Mon, 15 Sep 2025 20:20:03 +0200
Message-ID: <5922318.DvuYhMxLoT@rafael.j.wysocki>
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

This is an update of

https://lore.kernel.org/linux-acpi/5046661.31r3eYUQgx@rafael.j.wysocki/

A user report regarding "ACPI: \: Can't tag data node" error messages in dmesg
made me look at the ACPI property code and I've found a couple of issues in
it.

Also, it took me some time to figure out why the code was doing what it was
doing, so I decided to add some comments explaining it.

Finally, there's always something that can be cleaned up in every piece of
kernel code.

Hence, this series.

Please refer to the patch changelogs for details.

Thanks!




