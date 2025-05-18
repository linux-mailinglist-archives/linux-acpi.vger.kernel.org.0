Return-Path: <linux-acpi+bounces-13778-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E60CABAF42
	for <lists+linux-acpi@lfdr.de>; Sun, 18 May 2025 12:18:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 31098177F99
	for <lists+linux-acpi@lfdr.de>; Sun, 18 May 2025 10:18:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FC9D2135B7;
	Sun, 18 May 2025 10:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O8wdZL2/"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5D90212B1F;
	Sun, 18 May 2025 10:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747563521; cv=none; b=I9IDgIkNvTh292Vh0DhXGN4ga0WfBWiSy7U/INUG1akKdYtxtZ+tkdVLTjT9d8t88lZ8H0J1FL3dKH8sDADY+FeBeFcjZZ+OqyohIbrmxyJ3/9dK3ZSGAjDAM2gn9ECMqQY2XNl8jwmk6iShWFZGIzp+CD4STFDceJbNzm5s92o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747563521; c=relaxed/simple;
	bh=f8yNvFacwIT2UBvCLLpHpjc6kqW1QOVGmRxfY131Q44=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Nw6igViUss1wCxlTSbiUUl8+kN9fgkk48DPI8o+pF7jWu3iRZWnbE4GUI3xOy8LS7KoMuJCbTk1xaEp8ojM4ZOUakQkapyHRxUMkWNLuNlNU2jGPgT4CMczGQ2Eo2eZogvtRDvd2BC0M3cxEtRlqPzgzjsYAO56HqZG+B3V0VUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O8wdZL2/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 49C3EC4CEE7;
	Sun, 18 May 2025 10:18:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747563521;
	bh=f8yNvFacwIT2UBvCLLpHpjc6kqW1QOVGmRxfY131Q44=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=O8wdZL2/cNLVFhQHfJ8+MW5GVmJwodFm23oxOSCA1/Ln4LqdrFAL2SKD66ZHzu5qP
	 QFDUpYOucwwCJZX3wruCWJHnCT+odPE92yDeeiCd3Dq9KlGhtf8sOZTjRS6kKM1SQO
	 VnZKGfhTL9kEIO9nk/ldNT1+q1d38AJsz3zM04gfcYvu8kzAoyEKsxhx9W3k6xWuou
	 4/lk3dc+DGZab3F19QvNqiygYk9gdqnCgBrs5SIWV8sZbMc5JQmm9mlqfNElOba67J
	 UOQe2OHJXIkfHMXM0Wfj/2MKIo+Dw8jvwXBdqdzWuduDWwV7Di78jtgwMTItZR1fYF
	 nJLVQ1XGO+HOw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33CB4C3ABD8;
	Sun, 18 May 2025 10:18:41 +0000 (UTC)
From: Janne Grunau via B4 Relay <devnull+j.jannau.net@kernel.org>
Subject: [PATCH 0/2] Remove HID_LENOVO's dependency on ACPI
Date: Sun, 18 May 2025 12:18:36 +0200
Message-Id: <20250518-hid_lenovo_acpi_dependency-v1-0-afdb93b5d1a6@jannau.net>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPyzKWgC/x3MQQqDMBAF0KvIrA1E0Sq9SpEQM791oExCAtIi3
 t3g8m3eQQVZUOjZHJSxS5GoFV3bUNi8fmCEq6m3/WjHbjabsPtC4x6dD0kcI0EZGv7Gwk+zf6w
 8DZZqkDLe8rvz13KeF+s/Ge5sAAAA
X-Change-ID: 20250518-hid_lenovo_acpi_dependency-0ea78a6bd740
To: Arnd Bergmann <arnd@arndb.de>, Jiri Kosina <jikos@kernel.org>, 
 Benjamin Tissoires <bentiss@kernel.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, 
 linux-acpi@vger.kernel.org, Janne Grunau <j@jannau.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1170; i=j@jannau.net;
 s=yk2024; h=from:subject:message-id;
 bh=f8yNvFacwIT2UBvCLLpHpjc6kqW1QOVGmRxfY131Q44=;
 b=owGbwMvMwCW2UNrmdq9+ahrjabUkhgzNzf9nn8pcwrEx+YZ9/J7D39Qvm7DuSyialmX9/pqNW
 wHvrN8MHaUsDGJcDLJiiixJ2i87GFbXKMbUPgiDmcPKBDKEgYtTACYidIvhf8iEzxPDtd7ll3ia
 HrA+/OS67fWXM1dGfNZ572LYJMDncIORYfOfynuyR66wJsZ3RfllBM+x/PzXZPmcqSxZbXobjv8
 NYgEA
X-Developer-Key: i=j@jannau.net; a=openpgp;
 fpr=8B336A6BE4E5695E89B8532B81E806F586338419
X-Endpoint-Received: by B4 Relay for j@jannau.net/yk2024 with auth_id=264
X-Original-From: Janne Grunau <j@jannau.net>
Reply-To: j@jannau.net

hid-lenovo supports external generic USB and Bluetooth devices and
should be buildable and usable on non-ACPI kernels and systems. Commit
84c9d2a968c82 ("HID: lenovo: Support for ThinkPad-X12-TAB-1/2 Kbd Fn
keys") added a hot key to cycle through power profiles using ACPI's
platform_profile. This resulted in adding a dependency on ACPI and
selecting CONFIG_ACPI_PLATFORM_PROFILE to fix build an link errors in
commit 52572cde8b4a ("HID: lenovo: select
CONFIG_ACPI_PLATFORM_PROFILE"). This is undesirable for HID drivers
supporting generic USB and Bluetooth devices. So instead stub the only
used function platform_profile_cycle() and relax the dependency.

Signed-off-by: Janne Grunau <j@jannau.net>
---
Janne Grunau (2):
      ACPI: platform_profile: Stub platform_profile_cycle
      HID: lenovo: Remove CONFIG_ACPI dependency

 drivers/hid/Kconfig              |  4 ++--
 include/linux/platform_profile.h | 11 +++++++++++
 2 files changed, 13 insertions(+), 2 deletions(-)
---
base-commit: 0af2f6be1b4281385b618cb86ad946eded089ac8
change-id: 20250518-hid_lenovo_acpi_dependency-0ea78a6bd740

Best regards,
-- 
Janne Grunau <j@jannau.net>



