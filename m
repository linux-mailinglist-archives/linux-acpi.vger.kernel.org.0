Return-Path: <linux-acpi+bounces-1421-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 268A97E92F7
	for <lists+linux-acpi@lfdr.de>; Sun, 12 Nov 2023 23:32:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 33E481C20442
	for <lists+linux-acpi@lfdr.de>; Sun, 12 Nov 2023 22:32:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 964E71C298
	for <lists+linux-acpi@lfdr.de>; Sun, 12 Nov 2023 22:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DZOELP70"
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1FB814294
	for <linux-acpi@vger.kernel.org>; Sun, 12 Nov 2023 20:36:33 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B81E31BEC
	for <linux-acpi@vger.kernel.org>; Sun, 12 Nov 2023 12:36:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1699821392;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=JsTSvLKKtPDIeM2vbfnmEierpQqaOVW3rPX7mSajhtk=;
	b=DZOELP70Lk+ySsg/SYHn9mep4kDzc30jO7xTpfZopO5C06e2GfEtjIgqU+k/mTK35haPuV
	hxvlL5pewAa2Gt6afnUBWFzqC3ETKG1xzIaMlVm11cPbakbhB908lfCdA/KLaDvKGMQTAG
	FsnBD1nH3p5P7wJT+wpOKULd/35QdI4=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-423-dYXPrEb2PkS5w759ZdYmcQ-1; Sun,
 12 Nov 2023 15:36:30 -0500
X-MC-Unique: dYXPrEb2PkS5w759ZdYmcQ-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9340E38C6168;
	Sun, 12 Nov 2023 20:36:29 +0000 (UTC)
Received: from shalem.redhat.com (unknown [10.39.192.51])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 84F80492BE0;
	Sun, 12 Nov 2023 20:36:28 +0000 (UTC)
From: Hans de Goede <hdegoede@redhat.com>
To: "Rafael J . Wysocki" <rafael@kernel.org>
Cc: Hans de Goede <hdegoede@redhat.com>,
	"Owen T . Heisler" <writer@owenh.net>,
	Kai-Heng Feng <kai.heng.feng@canonical.com>,
	linux-acpi@vger.kernel.org,
	regressions@lists.linux.dev,
	stable@vger.kernel.org
Subject: [PATCH 0/2] ACPI: video: Use acpi_device_fix_up_power_children()
Date: Sun, 12 Nov 2023 21:36:25 +0100
Message-ID: <20231112203627.34059-1-hdegoede@redhat.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9

Hi Rafael,

This series fixes a regression reported in 6.6:

https://lore.kernel.org/regressions/9f36fb06-64c4-4264-aaeb-4e1289e764c4@owenh.net/
https://gitlab.freedesktop.org/drm/nouveau/-/issues/273
https://bugzilla.kernel.org/show_bug.cgi?id=218124

The reporter has confirmed that this series fixes things and
Kai-Heng has confirmed that backlight control still works on
the HP ZBook Fury 16 G10 for which the original
acpi_device_fix_up_power_extended() call this replaces was added.

Assuming you agree with this series, can you get it on its way
to Linus so that it can be backported to 6.6 please ?

Regards,

Hans


Hans de Goede (2):
  ACPI: PM: Add acpi_device_fix_up_power_children() function
  ACPI: video: Use acpi_device_fix_up_power_children()

 drivers/acpi/acpi_video.c |  2 +-
 drivers/acpi/device_pm.c  | 13 +++++++++++++
 include/acpi/acpi_bus.h   |  1 +
 3 files changed, 15 insertions(+), 1 deletion(-)

-- 
2.41.0


