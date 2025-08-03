Return-Path: <linux-acpi+bounces-15481-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D92D3B19513
	for <lists+linux-acpi@lfdr.de>; Sun,  3 Aug 2025 22:04:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C9C684E02E2
	for <lists+linux-acpi@lfdr.de>; Sun,  3 Aug 2025 20:04:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADB441A08A4;
	Sun,  3 Aug 2025 20:04:03 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from vps-ovh.mhejs.net (vps-ovh.mhejs.net [145.239.82.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB1E4173;
	Sun,  3 Aug 2025 20:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=145.239.82.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754251443; cv=none; b=kmDnrFuD3yIzYHYE/E271tYE/nrR+74qOteXsohX0o+bjS26n5qGPAksw0/pPHcWnOtzJEEhjsUfTLlUwkJLgJ+GuX9olpvAmlVi+aG1iomq2w5++3R0CeRFRJsV9m7lGXKNTSYX4RySZ8VTM4Kgzkb08pwhUH7Rp1ziTE1G7TE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754251443; c=relaxed/simple;
	bh=MpvstN48VRF2YFHT2xv8Ztsaz8o3z76oJbw6FLylYpo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=js8F/ZDB0VsLdqz/t5tIns4SWguxivk8EFQofstCI6FcHk0j5+hQ9DOs2OmaaaE/8n4N/wYrHS9EwcIakycbOGENB6uSslpgUHhIcg2acrW9bFqPK9MagU8n9aC2lf+OPud0oy1s2jrXrO9OM+PLdXVVj6NXm71CvoZZsk3BR4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=maciej.szmigiero.name; spf=pass smtp.mailfrom=vps-ovh.mhejs.net; arc=none smtp.client-ip=145.239.82.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=maciej.szmigiero.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vps-ovh.mhejs.net
Received: from MUA
	by vps-ovh.mhejs.net with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <mhej@vps-ovh.mhejs.net>)
	id 1uieDs-00000000Mul-1pdc;
	Sun, 03 Aug 2025 21:18:20 +0200
From: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/2] HP EliteBook 855 G7 WWAN modem power resource quirk
Date: Sun,  3 Aug 2025 21:18:10 +0200
Message-ID: <cover.1754243159.git.mail@maciej.szmigiero.name>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: mhej@vps-ovh.mhejs.net

This laptop (and possibly similar models too) has power resource called
"GP12.PXP_" for its Intel XMM7360 WWAN modem.

For this power resource to turn ON power for the modem it needs certain
internal flag called "ONEN" to be set:
Method (_ON, 0, NotSerialized) // _ON_: Power On
{
	If (^^^LPCB.EC0.ECRG)
	{
		If ((ONEN == Zero))
		{
                        Return (Zero)
		}
(..)
	}
}

This flag only gets set from this power resource "_OFF" method, while the
actual modem power gets turned off during suspend by "GP12.PTS" method
called from the global "_PTS" (Prepare To Sleep) method.

In fact, this power resource "_OFF" method implementation just sets the
aforementioned flag:
Method (_OFF, 0, NotSerialized) // _OFF: Power Off
{
	OFEN = Zero
	ONEN = One
}

Upon hibernation finish we try to set this power resource back ON since its
"_STA" method returns 0 and the resource is still considered in use as it
is declared as required for D0 for both the modem ACPI device (GP12.PWAN)
and its parent PCIe port ACPI device (GP12).
But the "_ON" method won't do anything since that "ONEN" flag is not set.

Overall, this means the modem is dead after hibernation finish until the
laptop is rebooted since the modem power has been cut by "_PTS" and its PCI
configuration was lost and not able to be restored.

The easiest way to workaround this issue is to call this power resource
"_OFF" method before calling the "_ON" method to make sure the "ONEN"
flag gets properly set.

This makes the modem alive once again after hibernation finish - with
properly restored PCI configuration space.

Since this platform does *not* support S3 the fact that
acpi_resume_power_resources() is also called during resume from S3 is
not a problem there.

Do the DMI based quirk matching and quirk flag initialization just
once - in acpi_power_resources_init() function similar to existing
acpi_*_init() functions.

This way the whole resume path overhead of this change on other systems
amounts to simple hp_eb_gp12pxp_quirk flag comparison.

Opportunistically convert the single already existing DMI match-based
quirk in this ACPI power resource handler ("leave unused power
resources on" quirk) to the same one-time initialization in
acpi_power_resources_init() function instead of re-running that DMI
match each time acpi_turn_off_unused_power_resources() gets called.


This Intel WWAN modem in general has *a lot* of issues with
suspend/resume on various laptop platforms (not only HP).

More patches are needed for these, hopefully they can be mainlined
too so suspend/resume work out of the box for users (that's
important functionality on a laptop).

See the following ModemManager issue containing patches also for
Thinkpad T14 G1 and Dell Precision 3561:
https://gitlab.freedesktop.org/mobile-broadband/ModemManager/-/issues/992


Changes from v2:
* Split out the change adding power resource init function and converting
  existing DMI-based quirk into a separate preparatory patch.

* Create a replacement __acpi_power_on() method for the affected power
  resource (including the power OFF and delay part) and call it from
  acpi_resume_power_resources() instead of ordinary __acpi_power_on()
  on the affected platform.

* Rename leave_unused_power_resources_on_quirk into suggested shorter
  unused_power_resources_quirk.


Maciej S. Szmigiero (2):
  ACPI: PM: Add power resource init function
  ACPI: PM: Add HP EliteBook 855 G7 WWAN modem power resource quirk

 drivers/acpi/internal.h |  1 +
 drivers/acpi/power.c    | 90 +++++++++++++++++++++++++++++++++++++++--
 drivers/acpi/scan.c     |  1 +
 3 files changed, 89 insertions(+), 3 deletions(-)


