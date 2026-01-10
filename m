Return-Path: <linux-acpi+bounces-20146-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 995F6D0D5E1
	for <lists+linux-acpi@lfdr.de>; Sat, 10 Jan 2026 12:59:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CDC4530216A4
	for <lists+linux-acpi@lfdr.de>; Sat, 10 Jan 2026 11:59:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B7A3340A43;
	Sat, 10 Jan 2026 11:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mqyZBevG"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12347310762;
	Sat, 10 Jan 2026 11:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768046338; cv=none; b=mbzpXGzrvJuo+qED4Iotji8x8/l8YzEUDQd8awxTKJCJuVuh4UA79WNAh5/o8c697DIU0cztI9Scb1+U4RYSKnZ46pZ/V+VaoBbSr/M+h8YxX8q9bU7voBctr78iwNIusuTgFsEp2uSOJkvKzCJI5dVo8sJA0R/RSSagpaOMz+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768046338; c=relaxed/simple;
	bh=z1w783pNPPoJLWQpEOnJl2rdpBeHzskVS43NSpi1Ogo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Oc2bhKrN4vuCBNiA4PJ9VYZ3rEXcTicPbMGX3ty/IpQLRuA/cJEr4pwU1Yq7VKEOOZObpcqdjI56eA9w39FC7+H5fqDaVdnciUBFH3Y1b5iLPEf5evSpmUn/FLS/CrjUb1ZypfO2rxTZZCSLnFfx3up66HRPaXKttu7R5xnioX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mqyZBevG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77980C4CEF7;
	Sat, 10 Jan 2026 11:58:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768046337;
	bh=z1w783pNPPoJLWQpEOnJl2rdpBeHzskVS43NSpi1Ogo=;
	h=From:To:Cc:Subject:Date:From;
	b=mqyZBevGXj2/I9MSQ5W0H4xgGoVCXBoyMe6GB5vxBs7nXfMiPPZkPA7rzJHgTufMJ
	 8ftjUeMzWmSuMnKVYUA5Z4RzDxOlXoxl/OW7x/73PA+doE9svzIin501XyRkOlC6aW
	 Clwoc5mElfdlePQ0mvaJz5q5Hk1wP4lzDLW5E23Q/yqoUoFfntGXFi6gf3C1cAwrMq
	 5sns1mKkYqHhT9w0Eg7ZKI61lwSbDy9LUKaC4rCIfdNOq0kX3B1FgsRwakBvEMr9ex
	 pmfvvL0CLqNDHiDw5ISnXaAIVFmZV9BbokKMH+m5uL3yooY3N6UOYYTbCH4MRA2GF4
	 egJ465NnldicQ==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>,
 Todd Brandt <todd.e.brandt@linux.intel.com>,
 Xi Pardee <xi.pardee@linux.intel.com>
Subject:
 [PATCH v1 0/2] ACPI: PM: Refine acpi_dev_pm_attach() and stop special-casing
 buttons
Date: Sat, 10 Jan 2026 12:55:53 +0100
Message-ID: <4715380.LvFx2qVVIh@rafael.j.wysocki>
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

The first patch causes acpi_dev_pm_attach() to skip devices whose ACPI
companions cannot do ACPI PM or wakeup and the second one (which is
a fix) causes device ACPI PM enumeration to stop treating buttons in
a special way (which is not necessary and becomes harmful after the
conversion of the button driver to a platform one).

Thanks!




