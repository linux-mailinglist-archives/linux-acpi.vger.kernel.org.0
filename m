Return-Path: <linux-acpi+bounces-7582-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D693C952271
	for <lists+linux-acpi@lfdr.de>; Wed, 14 Aug 2024 21:02:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 92D942813FA
	for <lists+linux-acpi@lfdr.de>; Wed, 14 Aug 2024 19:02:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 423E813C673;
	Wed, 14 Aug 2024 19:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Pt0XY/2k"
X-Original-To: linux-acpi@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90DAA1BE844
	for <linux-acpi@vger.kernel.org>; Wed, 14 Aug 2024 19:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723662148; cv=none; b=Wp6gypPon85SovCd/ph10caMvfQ+v0tPovJ2Y01VW6Fdm6Tj8EdZCiZd9djGBN9qGsxypUr5ZgdQCJR+KhaN7MivFFzslzfnWfn+eSRPRBmfVctP9n4xoXvpLBAkiSZw7DR5IJQjHX28Xe4KXWBPVthpS8vsxpiMNlD1UZ4xiUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723662148; c=relaxed/simple;
	bh=Xnh2Cto9uxR6JyO/0gR8xiy8P50HYEbg0oHLAFVDbH4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=D8vLWqDkf0k+VMHbUss9vxmq4aJnixryW2MWRpuF3H4RIXvbSwTSU1VIDPKOY4wJr7dxIdToIFDupMYWMg7QvZU0/P6hd7GzUNlLMYkyIXrlQSqgkY4r23srogW5bEPlphmAkyEx6L1FS+afRdP25Oqx49KDX9GTzU/SsrhVOb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Pt0XY/2k; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723662145;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=sCzm2W6O4T8GkztKRcrottopCG1C6+IdUKb3GyWFWZU=;
	b=Pt0XY/2k6eWwLVD1HNUWy92otw08dVbUR5wOrDEmXADqiE7ByhNBwWraJD1rA43YocYqPO
	zpXGtUUcOs2a5Vps5LECY/C+3szEOi1TkjyvwAHFiuwbjnU7QQRtKi5D991kfqdZUfGjmZ
	MSheYC4IxbYUf0I9X+3E5iXv3Nhss2U=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-191-cu-_gS2zO0SWi46f11Rezw-1; Wed,
 14 Aug 2024 15:02:04 -0400
X-MC-Unique: cu-_gS2zO0SWi46f11Rezw-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 45D6718EB232;
	Wed, 14 Aug 2024 19:02:03 +0000 (UTC)
Received: from shalem.redhat.com (unknown [10.39.192.22])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 351A319560AA;
	Wed, 14 Aug 2024 19:02:00 +0000 (UTC)
From: Hans de Goede <hdegoede@redhat.com>
To: "Rafael J . Wysocki" <rafael@kernel.org>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Andy Shevchenko <andy@kernel.org>
Cc: Hans de Goede <hdegoede@redhat.com>,
	dri-devel@lists.freedesktop.org,
	linux-acpi@vger.kernel.org,
	platform-driver-x86@vger.kernel.org
Subject: [PATCH 0/3] ACPI/video / platform/x86: Add backlight=native quirk for Dell OptiPlex 7760 AIO
Date: Wed, 14 Aug 2024 21:01:56 +0200
Message-ID: <20240814190159.15650-1-hdegoede@redhat.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Hi Rafael,

6.10 has a new backlight driver for UART attached backlight controller
boards found in some Dell All in One models.

Now the first AIO has turned up which has not only the DSDT bits for this,
but also an actual controller attached to the UART, yet it is not using
this controller for backlight control (it needs GPU native control).

I did not tie the dell-uart-backlight into acpi_video_get_backlight_type()
yet, so the first 2 patches in this series deal with that and the third
patch adds a DMI quirk to select native backlight control on top.

Backlight control used to work on the Dell OptiPlex 7760 AIO with kernel
6.9 and older, so this is a regression and I would like to see this
series merged as fixes for 6.11.

Rafael, the drivers/platform/x86/dell/dell-uart-backlight.c are small
and isolated. So I believe it is best if you take the entire series,
to avoid conflicts if any other drivers/apci/video_detect.c DMI quirks
show up this cycle.

Regards,

Hans


Hans de Goede (3):
  ACPI: video: Add Dell UART backlight controller detection
  platform/x86: dell-uart-backlight: Use acpi_video_get_backlight_type()
  ACPI: video: Add backlight=native quirk for Dell OptiPlex 7760 AIO

 drivers/acpi/video_detect.c                   | 22 +++++++++++++++++++
 drivers/platform/x86/dell/Kconfig             |  1 +
 .../platform/x86/dell/dell-uart-backlight.c   |  8 +++++++
 include/acpi/video.h                          |  1 +
 4 files changed, 32 insertions(+)

-- 
2.46.0


