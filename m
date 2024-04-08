Return-Path: <linux-acpi+bounces-4729-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B56389BD37
	for <lists+linux-acpi@lfdr.de>; Mon,  8 Apr 2024 12:32:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 01064B21FE0
	for <lists+linux-acpi@lfdr.de>; Mon,  8 Apr 2024 10:32:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 404F057896;
	Mon,  8 Apr 2024 10:32:25 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from air.basealt.ru (air.basealt.ru [194.107.17.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D067856461;
	Mon,  8 Apr 2024 10:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.107.17.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712572345; cv=none; b=JAI30kw9OcHtL0+Cq93/OfS1lLx0+VkOjyK50klOA5ztX6y1OAyN+Yl86ahRbGSjpMQcBHxX2VzuRN2Z1yryZvhbixIiVvDkDi5mVGEH4Nu7s//d6lAdKbME49WdtJeS3Q9MmnYoFO/UmM53QE4CsWAuFIGioy1dGI3QTVv827E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712572345; c=relaxed/simple;
	bh=DJ1JPD/y1Y/bpZ4uT0bn3HqL8MEys7OhY8tmThn0Iuo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=canPYKrjsy+ujSvUVy5cNaxQ+78irA7nr1A9EAVcNBi4E1XNVSAf9yOgkD7BF3Oxu/XdFHjMeJ3y3swjqpqEEyHrhXZYXxSvYfTB9NIYzG7BtN5Tt+5i1wlh7G8rvmIG0TwKZOvGabJSQm0iplHAu1R5Kp6I53QQQBYN+TEnDC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org; spf=pass smtp.mailfrom=altlinux.org; arc=none smtp.client-ip=194.107.17.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altlinux.org
Received: by air.basealt.ru (Postfix, from userid 490)
	id 1F2522F20252; Mon,  8 Apr 2024 10:32:22 +0000 (UTC)
X-Spam-Level: 
Received: from altlinux.malta.altlinux.ru (obninsk.basealt.ru [217.15.195.17])
	by air.basealt.ru (Postfix) with ESMTPSA id 5D47D2F20248;
	Mon,  8 Apr 2024 10:32:09 +0000 (UTC)
From: kovalev@altlinux.org
To: stable@vger.kernel.org
Cc: rafael@kernel.org,
	lenb@kernel.org,
	pavel@ucw.cz,
	hdegoede@redhat.com,
	linux-acpi@vger.kernel.org,
	kovalev@altlinux.org
Subject: [PATCH v6.1.y 0/14 ]  ACPI: resource: Add IRQ override quirks (backport changes from v6.9-rc3)
Date: Mon,  8 Apr 2024 13:31:53 +0300
Message-Id: <20240408103207.197423-1-kovalev@altlinux.org>
X-Mailer: git-send-email 2.33.8
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Added support internal keyboard for the following models:

Asus ExpertBook (B1502CBA, B1502CGA, B1502CVA, B2402FBA, B2502FBA),
Asus Vivobook (E1504GA, E1504GA, E1504GAB),
TongFang GM6BGEQ / PCSpecialist Elimina Pro 16 M, RTX 3050,
TongFang GM6BG5Q, RTX 4050,
TongFang GM6BG0Q / PCSpecialist Elimina Pro 16 M, RTX 4060,
Maibenben X565.

Successfully tested on the available Asus ExpertBook B1502CVA model.

[PATCH 6.1.y 01/14] ACPI: resource: Skip IRQ override on Asus Expertbook
[PATCH 6.1.y 02/14] ACPI: resource: Skip IRQ override on ASUS ExpertBook
[PATCH 6.1.y 03/14] ACPI: resource: Always use MADT override IRQ settings
[PATCH 6.1.y 04/14] ACPI: resource: Honor MADT INT_SRC_OVR settings for
[PATCH 6.1.y 05/14] ACPI: resource: Add IRQ override quirk for PCSpecialist
[PATCH 6.1.y 06/14] ACPI: resource: Fix IRQ override quirk for PCSpecialist
[PATCH 6.1.y 07/14] ACPI: resource: Consolidate IRQ trigger-type override
[PATCH 6.1.y 08/14] ACPI: resource: Drop .ident values from dmi_system_id
[PATCH 6.1.y 09/14] ACPI: resource: Add TongFang GM6BGEQ, GM6BG5Q and
[PATCH 6.1.y 10/14] ACPI: resource: Add DMI quirks for ASUS Vivobook
[PATCH 6.1.y 11/14] ACPI: resource: Skip IRQ override on ASUS ExpertBook
[PATCH 6.1.y 12/14] ACPI: resource: Skip IRQ override on ASUS ExpertBook
[PATCH 6.1.y 13/14] ACPI: resource: Add IRQ override quirk for ASUS
[PATCH 6.1.y 14/14] ACPI: resource: Use IRQ override on Maibenben X565


