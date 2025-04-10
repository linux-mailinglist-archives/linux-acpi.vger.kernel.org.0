Return-Path: <linux-acpi+bounces-12950-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DF5DDA84A80
	for <lists+linux-acpi@lfdr.de>; Thu, 10 Apr 2025 18:55:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7BAB51B62E77
	for <lists+linux-acpi@lfdr.de>; Thu, 10 Apr 2025 16:55:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 634D41EFF88;
	Thu, 10 Apr 2025 16:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="MdYsLCof"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 554541EF376;
	Thu, 10 Apr 2025 16:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744304122; cv=none; b=O6v6q5VZEozkrfTLMP4awYzKmJx/AvbnQCVTiwCLu/fw2yn7sLkDnQjJ/c4eoc0OufejVMw6DF2ezmIXNFObQ7aKG6j86OPn6UYuwbpg2HxryjVNS7gJ5jRNe1j4murYcX3AnFlSfUNu3EGgZseQIbJ1U8SZ9SAyKwWGA6MjlM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744304122; c=relaxed/simple;
	bh=qIjKVz0o/qsw/7k4DyWMBBl+ZLuJOgLNmBrx66+OnH8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Nzo81sJYi9CxsESJy3rE+13i9hcoOujiqLW1dOXm+vggd7qMFii4czV6CVHjY71r59oep8fGg3fHVRnNOmgBxOtcsFuljTZonO68fE17lzQL0Ui58p/3HAe4V6T6MDJJEHQ5i4RaiOhTqkVB440Z3gVLTi8WuMIezoIR4DUihjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=MdYsLCof; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1744304111; x=1744908911; i=w_armin@gmx.de;
	bh=XKDVlJ1S472IrTqYQzZq0rnJAxNsudD3NR6aRC7hpz4=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-Id:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=MdYsLCofg7uYxpZYg79SyIr1k+0T2RM/qdpGMaKryoSe6UdmVnMa+p4GPe+/JGap
	 LHXjFFVL98yYwvUykso/6byfNFn2f3hlLKaN0wu3L4pO64+fM4cuCrAwumSjDL2V4
	 sX9kmSzZYecyLk3VPMhEXwrvUiWWqZ8EF0KWN7TdDr6bxH9ua4C0b6O7xtN9rO52G
	 BXDwFFrgHActPy7ylXx+/+eQtEDvRa8e8NbadkO5NoeWXYjtd4kikNei5oteMNfkY
	 cKXARNL6Of2AZyKoUcPJf6wyOof1dyDcuPFi89cfK5lNgE+iqiU5LNzmC8NEjkA7C
	 WtuQBNY1F5LJlYIQMA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from mx-amd-b650.fritz.box ([87.177.78.219]) by mail.gmx.net
 (mrgmx104 [212.227.17.168]) with ESMTPSA (Nemesis) id
 1MIwz4-1tmuSj2VK6-00Kbcc; Thu, 10 Apr 2025 18:55:11 +0200
From: Armin Wolf <W_Armin@gmx.de>
To: rafael@kernel.org,
	rui.zhang@intel.com
Cc: lenb@kernel.org,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] ACPI: thermal: Execute _SCP before reading trip points
Date: Thu, 10 Apr 2025 18:54:55 +0200
Message-Id: <20250410165456.4173-3-W_Armin@gmx.de>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250410165456.4173-1-W_Armin@gmx.de>
References: <20250410165456.4173-1-W_Armin@gmx.de>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:x/e9h8HjEkr3E6Y3rSlOCZ3HcBPAj6dDFxw075ekYpDp9OlHOGI
 j/Byt8hTZ6FlOihWyyK1dT1dMNAeB6qA823+cjpsgV0+mKvqptUVWD+d8OLQRIOHdeA0oPd
 a1aIsUhWIrFGJdvvPf+Rrf50eDC8bVDC55IAjoGuizdt2uIEVndeuIoFAngR9mivCl5y9LM
 dRHMuuuTWsAwpf+CDL+og==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:EWxuqpPprxk=;fTen949bYHgKA7sJfggR4UGl1CC
 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
 ps5iwCYElMFwumjgY2InJ8=

As specified in section 11.4.13 of the ACPI specification the
operating system is required to evaluate the _ACx and _PSV objects
after executing the _SCP control method.

Move the execution of the _SCP control method before the invocation
of acpi_thermal_get_trip_points() to avoid missing updates to the
_ACx and _PSV objects.

Fixes: b09872a652d3 ("ACPI: thermal: Fold acpi_thermal_get_info() into its=
 caller")
Signed-off-by: Armin Wolf <W_Armin@gmx.de>
=2D--
 drivers/acpi/thermal.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/acpi/thermal.c b/drivers/acpi/thermal.c
index 0c874186f8ae..5c2defe55898 100644
=2D-- a/drivers/acpi/thermal.c
+++ b/drivers/acpi/thermal.c
@@ -803,6 +803,12 @@ static int acpi_thermal_add(struct acpi_device *devic=
e)

 	acpi_thermal_aml_dependency_fix(tz);

+	/*
+	 * Set the cooling mode [_SCP] to active cooling. This needs to happen b=
efore
+	 * we retrieve the trip point values.
+	 */
+	acpi_execute_simple_method(tz->device->handle, "_SCP", ACPI_THERMAL_MODE=
_ACTIVE);
+
 	/* Get trip points [_ACi, _PSV, etc.] (required). */
 	acpi_thermal_get_trip_points(tz);

@@ -814,10 +820,6 @@ static int acpi_thermal_add(struct acpi_device *devic=
e)
 	if (result)
 		goto free_memory;

-	/* Set the cooling mode [_SCP] to active cooling. */
-	acpi_execute_simple_method(tz->device->handle, "_SCP",
-				   ACPI_THERMAL_MODE_ACTIVE);
-
 	/* Determine the default polling frequency [_TZP]. */
 	if (tzp)
 		tz->polling_frequency =3D tzp;
=2D-
2.39.5


