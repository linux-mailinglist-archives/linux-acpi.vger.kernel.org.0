Return-Path: <linux-acpi+bounces-3091-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A75B2842065
	for <lists+linux-acpi@lfdr.de>; Tue, 30 Jan 2024 11:02:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E8241F2BE77
	for <lists+linux-acpi@lfdr.de>; Tue, 30 Jan 2024 10:02:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95310679E4;
	Tue, 30 Jan 2024 09:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="DLf2goTP"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-40134.protonmail.ch (mail-40134.protonmail.ch [185.70.40.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0058466B50
	for <linux-acpi@vger.kernel.org>; Tue, 30 Jan 2024 09:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706608646; cv=none; b=AkutWv8x9uIdmefDk9gS0j/HpVWnTPjPTLMloi9jjLefkiwB6spLDBa96jl/HfTWnP4KnqupKHW0fVoib5xRz+yKUI7tSijyhIXWnYtbtWMZ8Ryhzy7NIIBVs6NtObNYAKoEPQXg8B5yKPyJdyWVHFuNbWAPhtb0VB4v4fuqvf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706608646; c=relaxed/simple;
	bh=lLPz68jLPD6vDTR6Q/KVPglSsaCLhfglKkla3XqjRZo=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=DXtoCkIjf0W6hzzdpWEiqz9aFd5+vgc7Ng8OKjJepXuwaIOT1/9AmpOBjoT5sORwGFE77lep7xtLOWKMjc/lD1WGkMFogpTRXlEz/KLz+tzxBVXOqsQmRu0trscTZ99MmcEK1OwpQBigWxTmNHiYKl45Ml0dPDd3enIpFEsP3uY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=DLf2goTP; arc=none smtp.client-ip=185.70.40.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1706608635; x=1706867835;
	bh=hNKx+8gdk2cYkBcowL75l3LitJlJ/0cfaVuCNlTC438=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=DLf2goTPPTop0BQA/R55ekhXaeLN3YoCtQIVkj31SEhU7TNjLPpw4WL4rWbnG3P5l
	 rIQVuYlb/pFaKovq6Wtb+JRxgt8q6nhvP2hIH5P9T9DcVMpQQMYREkmraPGVbiQ00w
	 9otkk05CWo5iaXs98FFXWQ75xrFG46aFxVV6G1t89XyALu9LMtfuyF7pgrcCMN+ZtO
	 niDu5AxdvsZ3j9LQATLG6REHeXyRzbM2ZeOUMRbQTPS+W4QMZmHWXYx+25zqsMlvRU
	 0yIoH777/zF5hfV7nK/lgbdqc6Sbn7MtEYB3LBOiwqyAkSzFV7Wr1U+4X5PFwsn4mN
	 /8LthKqyjYLAg==
Date: Tue, 30 Jan 2024 09:57:04 +0000
To: linux-acpi@vger.kernel.org
From: Nicolas Haye <nicolas.haye@proton.me>
Cc: rafael@kernel.org, n1coh <nicolas.haye@groupegaillard.fr>, Nicolas Haye <nicolas.haye@proton.me>
Subject: [PATCH] ACPI: resource: Skip IRQ override on ASUS ExpertBook B1502CVA
Message-ID: <20240130095700.165544-1-nicolas.haye@proton.me>
Feedback-ID: 45495416:user:proton
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

From: n1coh <nicolas.haye@groupegaillard.fr>

Like many b1502 models,
the b1502CVA keyboard doesn't work because of an ACPI DSDT table that descr=
ibes IRQ 1
as ActiveLow while the kernel overrides it to Edge_High.

Signed-off-by: Nicolas Haye <nicolas.haye@proton.me>
---
 drivers/acpi/resource.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/acpi/resource.c b/drivers/acpi/resource.c
index dacad1d846c0..65ce43ecfa8c 100644
--- a/drivers/acpi/resource.c
+++ b/drivers/acpi/resource.c
@@ -468,6 +468,13 @@ static const struct dmi_system_id irq1_level_low_skip_=
override[] =3D {
 =09=09=09DMI_MATCH(DMI_BOARD_NAME, "B1502CGA"),
 =09=09},
 =09},
+        {
+                /* Asus ExpertBook B1502CVA */
+                .matches =3D {
+                        DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC.")=
,
+                        DMI_MATCH(DMI_BOARD_NAME, "B1502CVA"),
+                },
+        },
 =09{
 =09=09/* Asus ExpertBook B2402CBA */
 =09=09.matches =3D {
--=20
2.43.0



