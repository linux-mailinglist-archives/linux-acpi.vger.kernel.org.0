Return-Path: <linux-acpi+bounces-1833-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D05C37FA698
	for <lists+linux-acpi@lfdr.de>; Mon, 27 Nov 2023 17:37:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3C866B20DBC
	for <lists+linux-acpi@lfdr.de>; Mon, 27 Nov 2023 16:37:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D5973456F
	for <lists+linux-acpi@lfdr.de>; Mon, 27 Nov 2023 16:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DBHjoG9y"
X-Original-To: linux-acpi@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BA16EA
	for <linux-acpi@vger.kernel.org>; Mon, 27 Nov 2023 06:37:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1701095866;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=aW0YOCJul7xs+/KZ1mmsyul1gC4BX9IvFOK2PTRgq/Y=;
	b=DBHjoG9yPMtbdESVFiqPsBM98eoDx+UznDRu3AUz8gKzlV0amnv7xUl9QfoZJxihLOfGX3
	eCX3MUtadj0crPBAdvnHUipHdOekVmNHgenDzdiXCJpU5F1PdrZ6LkFWbjbqdOA/1JTFsn
	C9BW6JQSXnJxdty58IVdlQvz9zCz1KI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-470-Jfv4_HhmML6oIfViXM4COw-1; Mon, 27 Nov 2023 09:37:43 -0500
X-MC-Unique: Jfv4_HhmML6oIfViXM4COw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 095A288D016;
	Mon, 27 Nov 2023 14:37:43 +0000 (UTC)
Received: from x1.localdomain.com (unknown [10.39.192.45])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 2711F20268D2;
	Mon, 27 Nov 2023 14:37:42 +0000 (UTC)
From: Hans de Goede <hdegoede@redhat.com>
To: "Rafael J . Wysocki" <rafael@kernel.org>,
	Michal Wilczynski <michal.wilczynski@intel.com>
Cc: Hans de Goede <hdegoede@redhat.com>,
	Jani Nikula <jani.nikula@linux.intel.com>,
	linux-acpi@vger.kernel.org
Subject: [6.6 regression-fix 0/1] ACPI: video: Use acpi_video_device for cooling-dev driver data
Date: Mon, 27 Nov 2023 15:37:40 +0100
Message-ID: <20231127143741.5229-1-hdegoede@redhat.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4

Hi Rafael,

Here is a fix for a regression in 6.6 caused by:

0d16710146a1 ("ACPI: bus: Set driver_data to NULL every time .add() fails")

the root cause here is the acpi_video.c code abusing the driver_data
of a device for which it is not the driver, this fix addresses
the root cause.

This issue is being tracked here:
https://gitlab.freedesktop.org/drm/intel/-/issues/9718

Regards,

Hans


Hans de Goede (1):
  ACPI: video: Use acpi_video_device for cooling-dev driver data

 drivers/acpi/acpi_video.c | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

-- 
2.43.0


