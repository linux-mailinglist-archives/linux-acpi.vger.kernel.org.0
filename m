Return-Path: <linux-acpi+bounces-19555-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A47CCB632E
	for <lists+linux-acpi@lfdr.de>; Thu, 11 Dec 2025 15:34:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9C1D130607D3
	for <lists+linux-acpi@lfdr.de>; Thu, 11 Dec 2025 14:31:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E998628489A;
	Thu, 11 Dec 2025 14:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kgQFWXOO"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD3E6255F52;
	Thu, 11 Dec 2025 14:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765462944; cv=none; b=toi1wmLYwwNmCGCQ1G8uACRZs+VGxdn57+NQJhr+X/lHhAmmv/fGqIhSHroj1c5iGYm8WipDFgNmCoX/LFe9Kj8ol98im1nNJ7bsAXRmkRW2AD7l30K9aLBQXhX2uHBgcFp2NBZsq1q1v1I1bvUvARJl/bIHVKm2cFViGj3w16U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765462944; c=relaxed/simple;
	bh=FHregWnMNDA/Xox8CB1B2KJYrvEDxYtW0mn+hiKa3SQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nSjpY9aydy6vlyO9eG6z868fc20PS0xnfDfoivDiYMCWPz3cDSMEPSfIegLOh+gBpmOreLFBJe20IoWnpuP5t0bBPkDBGG9jHBqadi5AxHs3eXH3CA5l+xd9FTEhO04q3QeR5h/HRlBDkhArIzqB5WC4L5NAqkAIB0srGCBBuOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kgQFWXOO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63384C4AF09;
	Thu, 11 Dec 2025 14:22:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765462944;
	bh=FHregWnMNDA/Xox8CB1B2KJYrvEDxYtW0mn+hiKa3SQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kgQFWXOODMTUjoI1CxotN0iL+SoWdu37Y7rLNfc0gbWlCwkAhW+M9ZojEHQE92o1O
	 MHw4amwW2ZjntnMl22iu6mZFbySW9bGQH8iPOwRq9+wuOeNLuIPTYhlm2DQpTSPo4T
	 QNR3Ai62rWE2F4AEY7x8BzVroxdeqQpLoI+Jurj9DSmgu6qHidQMEXkiEK/sIn1vrT
	 ji0+wflPdVWSMXyYDeoMQb/uEH1vfws7IbfU3EPqFh6tmKdd5lLApU/PDaSpuMAL0M
	 rgCm+kcmlK3A+AEL8cES8GLJZXmFIPeqt3hyhtPLrFB65xI97sBdvR/OCSxE4lkqiA
	 V4Uh7FBGPEvlA==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>,
 Armin Wolf <w_armin@gmx.de>, Hans de Goede <hansg@kernel.org>
Subject: [RFT][PATCH v1 1/6] ACPI: EC: Register a platform device for ECDT EC
Date: Thu, 11 Dec 2025 15:16:37 +0100
Message-ID: <2397353.ElGaqSPkdT@rafael.j.wysocki>
Organization: Linux Kernel Development
In-Reply-To: <5066996.31r3eYUQgx@rafael.j.wysocki>
References: <5066996.31r3eYUQgx@rafael.j.wysocki>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

To facilitate converting the ACPI EC driver into a platform one,
modify acpi_bus_register_early_device(), used by acpi_ec_ecdt_start()
for creating a struct acpi_device to represent the "early" EC based
on the ECDT ACPI table, to carry out the default ACPI enumeration for
the given device which will cause a platform device to be registered
for it.

No intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/scan.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -2643,6 +2643,8 @@ int acpi_bus_register_early_device(int t
 	if (result)
 		return result;
 
+	acpi_default_enumeration(device);
+
 	device->flags.match_driver = true;
 	return device_attach(&device->dev);
 }




