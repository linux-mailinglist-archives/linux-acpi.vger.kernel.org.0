Return-Path: <linux-acpi+bounces-20317-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9478AD1EE4F
	for <lists+linux-acpi@lfdr.de>; Wed, 14 Jan 2026 13:49:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 64D403033AF6
	for <lists+linux-acpi@lfdr.de>; Wed, 14 Jan 2026 12:44:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3742939B4A8;
	Wed, 14 Jan 2026 12:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HyuhdHBO"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA1E839A807;
	Wed, 14 Jan 2026 12:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768394578; cv=none; b=hjVySEgwBfoV/Gt9ueoNzH6/c9OSbTMSkO4IlQWrsZgUx6aCFb1w4/H7MY2JUzxJf9fVJfmXjr7daiKxsFPwaefz8A62mJo2nb8bzjHOhOYWN8X+HqR/3Z7zYRAnHBRk1kCOBRMncFD8Hmk9H6L0AhuyuSaJaVJSgZpmDQ6CMUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768394578; c=relaxed/simple;
	bh=sHBqbufL5owlFFWfDJrqc3teanWTvxPdNYM1i94Usg8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=tDQfHBchLpejTUH7RdfydtIPKAZ5eZ4Vz4bsj7V+jS8q7rxF2sfGN802e3+qoMSNlVJbc4TYOZyG5c4QoFChXNDpOTZ8xnDXh/FBD3uZzCsHh7bF2LWhYl1E25ZJ1S67aqrQS13lL3muQz9vGFPIWY+4wvG/1I8zw787+tf3zAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HyuhdHBO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E357C4CEF7;
	Wed, 14 Jan 2026 12:42:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768394577;
	bh=sHBqbufL5owlFFWfDJrqc3teanWTvxPdNYM1i94Usg8=;
	h=From:To:Cc:Subject:Date:From;
	b=HyuhdHBOpPuXs+hihfUcXw+70KuIyKLOM4l1r3x3U4/RqpuOStwRHg3epOTZusza2
	 EIQJSzSSqMY9EdlH72J5HH3b4w9WlzSdkZyyK0IyDxXPA6TafFvIEJQMj8pkz/4/Dq
	 +X4zEkAZDzUgZ9yEpfStaIczPtAMvfoPX8AReuB3xQn+7xO8W4jIazgWbLpWT2JT+p
	 i/n2w1kmXX8yPoH9jf8pIa+ox7vQy+G+2msu99nrzRxGV8yTWOAulBI6mjwgET09FJ
	 UEOf2nTaC4riKp8SW/E4orMk/U8X0QST2zyqSf9dfUKR36pUJynDZEI9ODXad3G0Zr
	 BCx3fCoNKMY8g==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 "Dumbre, Saket" <saket.dumbre@intel.com>
Subject: [PATCH v1 00/26] ACPICA: ACPICA 20251212
Date: Wed, 14 Jan 2026 13:14:38 +0100
Message-ID: <12822121.O9o76ZdvQC@rafael.j.wysocki>
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

This series of patches represents upstream ACPICA changes made between
the 20250807 release and the 20251212 release that have not been included
into the Linux source code yet, and some upstream ACPICA changes made after
the 20251212 release.

It contains the following material:

Alexey Simakov (1):
      ACPICA: Fix NULL pointer dereference in acpi_ev_address_space_dispatch()

Armin Wolf (5):
      ACPICA: Add UUID for Microsoft fan extensions
      ACPICA: Add UUIDs associated with TPM 2.0 devices
      ACPICA: Add support for the Microsoft display mux _OSI string
      ACPICA: Abort AML bytecode execution when executing AML_FATAL_OP
      ACPICA: Fix asltests using the Fatal() opcode

Ben Horgan (1):
      ACPICA: ACPI 6.4: PPTT: include all fields in subtable type 1

Dave Jiang (1):
      ACPICA: Add KEYP table definition

Jose Marinho (2):
      ACPICA: Add GICv5 MADT structures
      ACPICA: Add Arm IORT IWB node definitions

Michal Camacho Romero (10):
      ACPICA: Add support for the new ACPI Table: DTPR
      ACPICA: Add DTPR table support for the ASL compiler
      ACPICA: Define DTPR structure related info tables and data template
      ACPICA: Create auxiliary ACPI_TPR_AUX_SR structure for iASL compiler
      ACPICA: Fix Segmentation Fault error related to DTPR
      ACPICA: Verify DTPR and TPR Instance buffer pointers
      ACPICA: Cleanup comments and DTPR Table handle functions
      ACPICA: Align comments in TPRn-related structures
      ACPICA: Replace TPRn Base and Limit registers
      ACPICA: Refactor for TPR Base/Limit registers bitmasks

Pawel Chmielewski (3):
      ACPICA: actbl2.h: ACPI 6.6: RAS2: Update Parameter Block structure
      ACPICA: actbl3.h: ACPI 6.6: SRAT: New flag in Memory Affinity Structure
      ACPICA: ACPI 6.6: Add _VDM (Voltage Domain) object

Saket Dumbre (1):
      ACPICA: Logfile: Changes for version 20251212

Xianglai Li (1):
      ACPICA: iASL: Add definitions for the IOVT table

Zilin Guan (1):
      ACPICA: ACPICA: replace ACPI_FREE() with acpi_ut_delete_object_desc()



Thanks!




