Return-Path: <linux-acpi+bounces-18053-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E0BD6BF7ECC
	for <lists+linux-acpi@lfdr.de>; Tue, 21 Oct 2025 19:36:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id AE98A506B1D
	for <lists+linux-acpi@lfdr.de>; Tue, 21 Oct 2025 17:36:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EF8634C137;
	Tue, 21 Oct 2025 17:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rJjZprwW"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73B4834C12A;
	Tue, 21 Oct 2025 17:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761068177; cv=none; b=AbPuQcODBext4a9YSraJg4xtUNde0z4Gglz0jTPgTH0jJvA1rgzPwBGD+yduvVdCzJHQKNWdCX1ivpLilTu9CA6Pznmozn87YSaCt9YCMoLQOB65TCCS24fTymZJuJdtqlQqxu8Zxr0tV0wymdTlnZEZbckDgQgHEXH1pRCMzpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761068177; c=relaxed/simple;
	bh=9SPMl5EKgnJfqBS44jhiE37W9GKsbwghIS2B6aSlfLw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=lGOwBkMWczcPrTW7//CzIN5/hx/LrOqQ5RFVraI476Vyacog8zLg/1rJHCWR4xGykAbt+lKBmlEi9U5KnyWcHbFg30JiLq95Gi6yWNLitMxpIfI9ipgYHKUPj1quSwM/mG64R7+6+Q7YIOJ91MG4mDEiFbE/G2QqCduyd+RO/uA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rJjZprwW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20ACAC4CEF1;
	Tue, 21 Oct 2025 17:36:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761068177;
	bh=9SPMl5EKgnJfqBS44jhiE37W9GKsbwghIS2B6aSlfLw=;
	h=From:To:Cc:Subject:Date:From;
	b=rJjZprwWj8piJiCiUsga3oqkspWPmTLhttiA/Kf+yOSnKGPtFGrIwsWEU5D48yEk1
	 zrbjAInN/bV7am+RPn+pP2UfoEIrMHJkuxUfGTURc74OHo4snoH05EXfcELzjnssMK
	 CaCBTQ0XKfH3mmiQhbBJgxhXZeRvfT4+d6W35OyLIvqZbFZXEKhZ7PiFAVtivTj/f2
	 bRFHXV4uKiMCLB0KeBTCqe9VRsFrC+v1Jv0/UNKdGAZdCGReaxyMQaoFnhVVsAGAP1
	 dvE+1PnUebjXKyCNQew/55+P3dANFzvWesYyZ9zjoWMZhQy60M6nELmL9tnRnMgt2Q
	 CX/O3uBSD1MiQ==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: Linux PM <linux-pm@vger.kernel.org>,
 Jonathan Cameron <jonathan.cameron@huawei.com>, Takashi Iwai <tiwai@suse.de>,
 LKML <linux-kernel@vger.kernel.org>, Zhang Qilong <zhangqilong3@huawei.com>,
 Frank Li <Frank.Li@nxp.com>, Dhruva Gole <d-gole@ti.com>,
 Mika Westerberg <mika.westerberg@linux.intel.com>,
 Dan Williams <dan.j.williams@intel.com>
Subject: [PATCH v3 0/2] ACPI: TAD: Use auto-cleanup macros for runtime PM
Date: Tue, 21 Oct 2025 19:32:29 +0200
Message-ID: <4698369.LvFx2qVVIh@rafael.j.wysocki>
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

This supersedes

https://lore.kernel.org/linux-acpi/8599731.T7Z3S40VBb@rafael.j.wysocki/

that had a kind of an issue in the second patch.  Namely, ACQUIRE()/ACQUIRE_ERR()
were used along with gotos in one function.

This addresses the problem by introducing an auxiliary function to separate
the two mechanisms.

The first patch has not been changed.

Thanks!




