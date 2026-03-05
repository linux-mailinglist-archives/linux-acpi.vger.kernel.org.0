Return-Path: <linux-acpi+bounces-21444-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GKudHPDnqWnuHQEAu9opvQ
	(envelope-from <linux-acpi+bounces-21444-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Thu, 05 Mar 2026 21:30:40 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DD68C218283
	for <lists+linux-acpi@lfdr.de>; Thu, 05 Mar 2026 21:30:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 760D5307C4B1
	for <lists+linux-acpi@lfdr.de>; Thu,  5 Mar 2026 20:29:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA805339861;
	Thu,  5 Mar 2026 20:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t8NX1EBR"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C48DB33893D;
	Thu,  5 Mar 2026 20:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772742554; cv=none; b=T7uGMSQfyC06USlpOK9VAc2H1tXRHeGNCDpadKt4e7+zDbpsW5QAsV9VUUB06nWEI6pd/oKPfyrURCooUYQQVoYVIuVarkEdkLicQqAw+ISBEs8z9+Gfwh43xEI6Gj2dvNGnWDBHtLsUAs6uB9VvO27509yjbPZ/DKUd4yxzIGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772742554; c=relaxed/simple;
	bh=8U6oCaz2fszjX0uJDiK5nFm+1kN/ZxnPUg0Hj9h2Qyg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KeNGLaECNPDPqPy0SJemsWUwBgcPEFz4cVdY6QwM7T1ubA2u/u2KNYZ6WYwt5lXCbBgFg+XTzSbG1Z6giv6yJkbJo9dEfK0Pezty9XOh/8z501Av/YyaQVh6ulSfttjiFVlO8o/K8T2Ah+HMZ5yRjUyczOg9FK6CWMLMcL1xR5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t8NX1EBR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F3C4C19425;
	Thu,  5 Mar 2026 20:29:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772742554;
	bh=8U6oCaz2fszjX0uJDiK5nFm+1kN/ZxnPUg0Hj9h2Qyg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=t8NX1EBRD0hxHnXP1yJDXKiGll76O/NmVv1jMSuxTgVMFb5THrHWoMXkbYoJi7Voz
	 MTKJLiz9I4953q3e7NCKqtyPMmrznRi8g4PKkqxslR3f+6JsEcENA247ugvKV9+IAX
	 WRUMpdrIL5ACuP7/V1DvWPWUDlJZiLwlBdePPYd+ZwjKkhiSvI+DXGyUTEFILcTusg
	 L+Tn58+6H2YHxuoifRQqprri9xI+eiNNBrrOUy84g1dlEztT2SDRSaqYwUqPIqIFR5
	 oJt1SF74UG9ErymwY1JKf3RXqEI2enl3v+dA6sBzo6/VwwZDhQ4AWbFS6L6GKGsvW0
	 BI5Vosv3/KpMA==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Hans de Goede <hansg@kernel.org>,
 Ilpo =?ISO-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 platform-driver-x86@vger.kernel.org, amd-gfx@lists.freedesktop.org,
 Alex Deucher <alexander.deucher@amd.com>,
 Christian =?ISO-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
Subject: [PATCH v1 9/9] ACPI: AC: Define ACPI_AC_CLASS in one place
Date: Thu, 05 Mar 2026 21:27:28 +0100
Message-ID: <2787819.X9hSmTKtgW@rafael.j.wysocki>
Organization: Linux Kernel Development
In-Reply-To: <4505861.ejJDZkT8p0@rafael.j.wysocki>
References: <4505861.ejJDZkT8p0@rafael.j.wysocki>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: DD68C218283
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	CTE_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21444-lists,linux-acpi=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	HAS_ORG_HEADER(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rafael@kernel.org,linux-acpi@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-acpi];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,rafael.j.wysocki:mid]
X-Rspamd-Action: no action

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

The ACPI_AC_CLASS symbol is defined in several places in the same way
which is rather unfortunate.

Instead, define it in one common header file (acpi_bus.h) that is
already included by all of its users.

No intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/ac.c                         |    1 -
 drivers/acpi/sbs.c                        |    1 -
 drivers/gpu/drm/amd/include/amd_acpi.h    |    2 --
 drivers/gpu/drm/radeon/radeon_acpi.c      |    2 --
 drivers/platform/x86/hp/hp-wmi.c          |    2 --
 drivers/platform/x86/lenovo/wmi-capdata.c |    1 -
 include/acpi/acpi_bus.h                   |    2 ++
 7 files changed, 2 insertions(+), 9 deletions(-)

--- a/drivers/acpi/ac.c
+++ b/drivers/acpi/ac.c
@@ -21,7 +21,6 @@
 #include <linux/acpi.h>
 #include <acpi/battery.h>
 
-#define ACPI_AC_CLASS			"ac_adapter"
 #define ACPI_AC_FILE_STATE		"state"
 #define ACPI_AC_NOTIFY_STATUS		0x80
 #define ACPI_AC_STATUS_OFFLINE		0x00
--- a/drivers/acpi/sbs.c
+++ b/drivers/acpi/sbs.c
@@ -26,7 +26,6 @@
 
 #include "sbshc.h"
 
-#define ACPI_AC_CLASS			"ac_adapter"
 #define ACPI_SBS_DEVICE_NAME		"Smart Battery System"
 #define ACPI_BATTERY_DIR_NAME		"BAT%i"
 #define ACPI_AC_DIR_NAME		"AC0"
--- a/drivers/gpu/drm/amd/include/amd_acpi.h
+++ b/drivers/gpu/drm/amd/include/amd_acpi.h
@@ -26,8 +26,6 @@
 
 #include <linux/types.h>
 
-#define ACPI_AC_CLASS           "ac_adapter"
-
 struct atif_verify_interface {
 	u16 size;		/* structure size in bytes (includes size field) */
 	u16 version;		/* version */
--- a/drivers/gpu/drm/radeon/radeon_acpi.c
+++ b/drivers/gpu/drm/radeon/radeon_acpi.c
@@ -44,8 +44,6 @@ bool radeon_atpx_dgpu_req_power_for_disp
 static inline bool radeon_atpx_dgpu_req_power_for_displays(void) { return false; }
 #endif
 
-#define ACPI_AC_CLASS           "ac_adapter"
-
 struct atif_verify_interface {
 	u16 size;		/* structure size in bytes (includes size field) */
 	u16 version;		/* version */
--- a/drivers/platform/x86/hp/hp-wmi.c
+++ b/drivers/platform/x86/hp/hp-wmi.c
@@ -58,8 +58,6 @@ enum hp_ec_offsets {
 #define HP_POWER_LIMIT_DEFAULT	 0x00
 #define HP_POWER_LIMIT_NO_CHANGE 0xFF
 
-#define ACPI_AC_CLASS "ac_adapter"
-
 #define zero_if_sup(tmp) (zero_insize_support?0:sizeof(tmp)) // use when zero insize is required
 
 enum hp_thermal_profile_omen_v0 {
--- a/drivers/platform/x86/lenovo/wmi-capdata.c
+++ b/drivers/platform/x86/lenovo/wmi-capdata.c
@@ -53,7 +53,6 @@
 #define LENOVO_CAPABILITY_DATA_01_GUID "7A8F5407-CB67-4D6E-B547-39B3BE018154"
 #define LENOVO_FAN_TEST_DATA_GUID "B642801B-3D21-45DE-90AE-6E86F164FB21"
 
-#define ACPI_AC_CLASS "ac_adapter"
 #define ACPI_AC_NOTIFY_STATUS 0x80
 
 #define LWMI_FEATURE_ID_FAN_TEST 0x05
--- a/include/acpi/acpi_bus.h
+++ b/include/acpi/acpi_bus.h
@@ -613,6 +613,8 @@ struct acpi_bus_event {
 	u32 data;
 };
 
+#define ACPI_AC_CLASS	"ac_adapter"
+
 extern struct kobject *acpi_kobj;
 extern int acpi_bus_generate_netlink_event(const char*, const char*, u8, int);
 void acpi_bus_private_data_handler(acpi_handle, void *);




