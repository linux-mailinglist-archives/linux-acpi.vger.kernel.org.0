Return-Path: <linux-acpi+bounces-16763-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 26C48B55713
	for <lists+linux-acpi@lfdr.de>; Fri, 12 Sep 2025 21:45:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A6B6F7B517A
	for <lists+linux-acpi@lfdr.de>; Fri, 12 Sep 2025 19:43:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 766BB33A01D;
	Fri, 12 Sep 2025 19:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="leNApAzR"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4091533A004;
	Fri, 12 Sep 2025 19:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757706246; cv=none; b=Tv4jXPNTXYSkHJwXfkRt12g3ri5TTt8qvQZ8Z72jhMYYBucNy2Pr8RnrjcWCvEQSIRSTqAcjre+6knXL9yrxShz0R3pEC65dt13UwDmvxO+ZR2b42+cCvaLusab+yhRxJvMFisuuKQKUKJChRtUz7YAdNTzZnM+U/ZeFihKBx28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757706246; c=relaxed/simple;
	bh=L7/ch1AeVDMbG+MPfAnRwGn2Nys5E+FT9vZnW7GbuJw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=qVGmKg9N4wzY7NSlHx+gRhp2RJtlZHvS30Fo+FS6rcNmM2CiDyFgqKj3McJFMviJl2ZL1FROIZiY9vyq868yCmuuQo1HoRPGDwtGW0y8P4XobQ/B5dbPxOONn/SX/dA6KVE36/R6iSSd7f7ZAIhMNhoy23GPJicZ1TPlZAdNqAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=leNApAzR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 032DAC4CEF4;
	Fri, 12 Sep 2025 19:44:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757706246;
	bh=L7/ch1AeVDMbG+MPfAnRwGn2Nys5E+FT9vZnW7GbuJw=;
	h=From:To:Cc:Subject:Date:From;
	b=leNApAzRvY8v2gPIcnoosD8iYRknYITiLlUDTWfcfWuN34yHnjVHVNknLBKkWVEko
	 FdlcuPAoDv1EvOR0QgYieq+8qNP1D/w6ECn2FQrl87bPNtca4L8tRdCTqP50vgZyAU
	 R7ecLlbijTliWY9wfMJon2zi9i9UnY8aDlfZcQOotgeeN4K4XEIoUgIvJQMkWuYQBp
	 T/kK8VTG4MBMjvIBOPKlF+JAPZxNMnbZKdtp4hJlIuUFykX8s8ViEXHkJJ4LO5zXcy
	 Z9MmcVSMo/havJLccl/n68XIHp0SUZH0X9FHSiYDaDdWb5OG70J2h1P4/8eG0tgVp9
	 qAkVXHXbWmHHw==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Mika Westerberg <mika.westerberg@linux.intel.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Sakari Ailus <sakari.ailus@linux.intel.com>
Subject: [PATCH v1 0/4] ACPI: property: Two fixes,
 more documentation and a cleanup
Date: Fri, 12 Sep 2025 21:37:39 +0200
Message-ID: <5046661.31r3eYUQgx@rafael.j.wysocki>
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




