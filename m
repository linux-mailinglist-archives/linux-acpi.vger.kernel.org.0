Return-Path: <linux-acpi+bounces-6557-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CC289111E8
	for <lists+linux-acpi@lfdr.de>; Thu, 20 Jun 2024 21:14:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 793151C21F3A
	for <lists+linux-acpi@lfdr.de>; Thu, 20 Jun 2024 19:14:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 853F01B47C1;
	Thu, 20 Jun 2024 19:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="q1GqcbJb"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 688C93A28D;
	Thu, 20 Jun 2024 19:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718910866; cv=none; b=ZJyGkgyMyk03YygJYOsYI+UnEE6sOXJDTaJEdD4F1XgLjFBIvCn2W64zVkcOhIthPpVlGnMsfrZmjl9KfxlEpLGQ1U70rQJFVnChYiIrq3guqVD7GyQQR5AOk20ay0vSWLKWzterN1I5d8y9cXkBhLPh1tbacWUQ092OL6TkUvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718910866; c=relaxed/simple;
	bh=J8AysygityxMnNuVj9BEU0a8KtA04L6LP5jPQjwyFCs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=g6BgMvo23R3e7saYFlWsmIWqyJEU3x2yFhkefd6dK9b/FgPNGyz39lkf/Cjt91ANYdfsfUdEI2S879D1TPecM1X4UrfppVZl6RMFuAJ4Vh6914UIHAi12fjygDKLiRZfXZGltZw7ieAYWlOSmisw6heRlYt80ADC+AuP94aJt3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=q1GqcbJb; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1718910858; x=1719515658; i=w_armin@gmx.de;
	bh=YRFGRPiVJpM+SVkvY2grxlxXxshhsfOesxnKljT4D2I=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-Id:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=q1GqcbJbu4WupXTWD8fIQMlFjWt+MVb5uWOJKrcgl3yGvvBwpNW73Z/mJqEVn2Ba
	 7FllkKf22U9u0zlGRcGtb7w6RXYLbgVqT92vl07GO8YKfIu3maytLlCLFdK4h5WyU
	 /x4x9LTGWiXT2Y9Ctzv3oexUhH8amtvqOXC4CSOoSGz1Tmd6O06feb0PT0sGxVV7w
	 SxSMb8YzF4ThRFDOot9LFS5U/o7oinBJZgsqr1mQDhbitoiXqZxuSRAUtAaTD1qTo
	 MzEAzY6v0fMfhsBKkA5Wwf55dKX4aTQRiu2AWfyqxnW6LQRHmOGUrrhu5p7xNmslw
	 9CjFEcL/jZ9Av/LHKQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from mx-amd-b650.users.agdsn.de ([141.30.226.129]) by mail.gmx.net
 (mrgmx105 [212.227.17.168]) with ESMTPSA (Nemesis) id
 1MQ5vc-1ryI134BcG-00UTak; Thu, 20 Jun 2024 21:14:18 +0200
From: Armin Wolf <W_Armin@gmx.de>
To: rafael@kernel.org,
	lenb@kernel.org
Cc: linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] ACPI: bus: Indicate support for battery charge limiting thru _OSC
Date: Thu, 20 Jun 2024 21:14:10 +0200
Message-Id: <20240620191410.3646-2-W_Armin@gmx.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240620191410.3646-1-W_Armin@gmx.de>
References: <20240620191410.3646-1-W_Armin@gmx.de>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:m6yBZdM3LtbL2MUuXWybwR1AJUY7VaiRZZX6ZnjfyUXcTIS9Bxh
 nQXKPL4qg4Q1+fZdw+3arCEVLw6fBmsAE61jEb+kSDaHdcc6GBReFNggtrqXgomvKcHYCmC
 CcqDeRkja3tZpcPh+DUkEvEsxIOu/fVGwFP5Il9rigTxIYcJOIYYJ9jzAljpjgumWvC3UA7
 fjHERptObkkAopui3M2Zw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:DJkWtcaidCc=;40xOfPlwgyOKcU+I+ytzwfxUVOT
 X1fgurEvjCHr8RgA19zB4vBJ3dwXilAGkl7PD/OgPnj5aon7dQ6rCaxo2G8RDyxiRLyslQBpI
 IJR3qsv3jtmQPGKH745Oe2q9prMOeVAhUTIo2mDsOj1Sw/jUMrP2EKFR3TfxT1l6pclVBz5gF
 lNZChYtrRC/l+os7A0qDSx27jHGlht5UGnUlizGav/MhZkIzww9hMyXDR7Pj98ZG+RH/OQbxZ
 ChL6nqLUgcMjprzQP5rXge2qNLsHO6NZmbGb6vcS2CP1UI+4SKCWaz3LJCeGz3tAjMczUm0FZ
 ao9BGkiKdMWsXY8AXOe09JMHe1+dz2aIxkbnE61eJJqNG+9LhsFWnbCBI12Uf7J13kCeXhZX3
 tLoPwJB0tRNt8J7JwCrgv9Fkqz/TJv/Y8z8QgUZZMFz6Ke8CmBuPZCmGaalJd1Le9tRuiHp+b
 gIX4+tEMtDkoMfgCFa2tF95KigONm9rYtDX5WcOHOw/vR78DomiQjL560Fi+w1oomPV+v+Gn5
 59MrBlLXIwKUpqqQRQAQapDLPvhLVIl5NrjVqviw7HEV8vp2xWP1MX887zuYhZJIniwtR7Ux2
 LShsYKOK0CuVA0EU13ofmKXsCeOZtZWQcmb0eEEk7lsGydkwAGrhk5W2ySdDxZljfMC9hePo9
 wbcyyI8tJ13yRTr1YN4i67d2btwAo1PoLAIVbxgHjyLqDGqP5d8moyOXVwrCEp+z2TC03NzGd
 muPmhjIxziid1vRybvTckmmEGgoJTPzOWpNGe+2O8uxpYnxelG3gvdHnr/KdJLgzhbH/HS2Jv
 My0nbYbljrvKIlMCcosMRrumbfXk15W1J8PboCVO3fDmM=

The ACPI battery driver can handle the "charge limiting" state
of the battery, so the platform can advertise this state.

Indicate this by setting bit 19 ("Battery Charge Limiting Support")
when evaluating _OSC.

Tested on a Lenovo Ideapad S145-14IWL.

Signed-off-by: Armin Wolf <W_Armin@gmx.de>
=2D--
 drivers/acpi/bus.c   | 2 ++
 include/linux/acpi.h | 1 +
 2 files changed, 3 insertions(+)

diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
index 787eca838410..bdbd60ae8897 100644
=2D-- a/drivers/acpi/bus.c
+++ b/drivers/acpi/bus.c
@@ -329,6 +329,8 @@ static void acpi_bus_osc_negotiate_platform_control(vo=
id)
 		capbuf[OSC_SUPPORT_DWORD] |=3D OSC_SB_PPC_OST_SUPPORT;
 	if (IS_ENABLED(CONFIG_ACPI_THERMAL))
 		capbuf[OSC_SUPPORT_DWORD] |=3D OSC_SB_FAST_THERMAL_SAMPLING_SUPPORT;
+	if (IS_ENABLED(CONFIG_ACPI_BATTERY))
+		capbuf[OSC_SUPPORT_DWORD] |=3D OSC_SB_BATTERY_CHARGE_LIMITING_SUPPORT;

 	capbuf[OSC_SUPPORT_DWORD] |=3D OSC_SB_HOTPLUG_OST_SUPPORT;
 	capbuf[OSC_SUPPORT_DWORD] |=3D OSC_SB_PCLPI_SUPPORT;
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index bb18e7bf8826..b9d6882f323e 100644
=2D-- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -576,6 +576,7 @@ acpi_status acpi_run_osc(acpi_handle handle, struct ac=
pi_osc_context *context);
 #define OSC_SB_CPC_FLEXIBLE_ADR_SPACE		0x00004000
 #define OSC_SB_GENERIC_INITIATOR_SUPPORT	0x00020000
 #define OSC_SB_NATIVE_USB4_SUPPORT		0x00040000
+#define OSC_SB_BATTERY_CHARGE_LIMITING_SUPPORT	0x00080000
 #define OSC_SB_PRM_SUPPORT			0x00200000
 #define OSC_SB_FFH_OPR_SUPPORT			0x00400000

=2D-
2.39.2


