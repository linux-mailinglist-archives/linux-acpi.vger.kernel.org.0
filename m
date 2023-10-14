Return-Path: <linux-acpi+bounces-646-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 010D17C970A
	for <lists+linux-acpi@lfdr.de>; Sun, 15 Oct 2023 00:32:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3164F1C20924
	for <lists+linux-acpi@lfdr.de>; Sat, 14 Oct 2023 22:32:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89E8026E11
	for <lists+linux-acpi@lfdr.de>; Sat, 14 Oct 2023 22:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fjJFYE1b"
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01D8F1D53A
	for <linux-acpi@vger.kernel.org>; Sat, 14 Oct 2023 20:53:20 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6526BCC
	for <linux-acpi@vger.kernel.org>; Sat, 14 Oct 2023 13:53:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1697316798;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Yj/0QNYZsOIhUSH3tNxwgd4vsbyRiEDoe3GvHn5M7WI=;
	b=fjJFYE1bIvSOIBaOF6nI1i++cYofN7yyA4UO/hUZ0NyGW/q1DQ+KVu/YxNdb4SoLaxiy0M
	vcKYaTGADsQYKDkUmlKFWhouoiO6OjlxcMbQUaO3YI46hnMOjNDjikL/EzJkhu0y6f6BUB
	1DeIfeBbu/GDIeJ0vjQmgAA7k8m9Bkg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-333-ZYCTH57ZMvqLWKf6ZEAWTQ-1; Sat, 14 Oct 2023 16:53:16 -0400
X-MC-Unique: ZYCTH57ZMvqLWKf6ZEAWTQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 322A9946DC1;
	Sat, 14 Oct 2023 20:53:16 +0000 (UTC)
Received: from shalem.redhat.com (unknown [10.39.192.6])
	by smtp.corp.redhat.com (Postfix) with ESMTP id F06D125C0;
	Sat, 14 Oct 2023 20:53:14 +0000 (UTC)
From: Hans de Goede <hdegoede@redhat.com>
To: "Rafael J . Wysocki" <rafael@kernel.org>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Andy Shevchenko <andy@kernel.org>,
	Mark Brown <broonie@kernel.org>
Cc: Hans de Goede <hdegoede@redhat.com>,
	linux-acpi@vger.kernel.org,
	platform-driver-x86@vger.kernel.org,
	linux-spi@vger.kernel.org
Subject: [PATCH 0/4] spi/ACPI: Add support for SPI WM5102 coded on Lenovo YT3-X90
Date: Sat, 14 Oct 2023 22:53:10 +0200
Message-ID: <20231014205314.59333-1-hdegoede@redhat.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi All,

Here is a patch series to fix audio on the Lenovo YT3-X90 x86 Android
tablet.

This series takes care of instantiating the SPI device for the codec,
to make things fully work there also are some sound/soc/intel/boards
changes necessary which I'm still working on.

The reason to post this initial series now is to get at least
the first patch merged before the next merge window so that
the rest of the series can easily be merged after the next
merge window without needing coordination between subsystem trees.

Mark can you please pickup patch 1/4 for the 6.7 merge-windows?
then I can queue up patches 3+4 for the 6.8 merge-window once
6.7-rc1 is released.

Regards,

Hans


Hans de Goede (4):
  spi: Export acpi_spi_find_controller_by_adev()
  ACPI: scan: Add LNXVIDEO HID to ignore_serial_bus_ids[]
  platform/x86: x86-android-tablets: Add support for SPI device
    instantiation
  platform/x86: x86-android-tablets: Add audio codec info for Lenovo
    Yoga Tab 3 Pro YT3-X90F

 drivers/acpi/scan.c                           |  1 +
 .../platform/x86/x86-android-tablets/core.c   | 62 ++++++++++++
 .../platform/x86/x86-android-tablets/lenovo.c | 99 +++++++++++++++++++
 .../x86-android-tablets/x86-android-tablets.h |  9 ++
 drivers/spi/spi.c                             |  5 +-
 include/linux/spi/spi.h                       |  1 +
 6 files changed, 174 insertions(+), 3 deletions(-)

-- 
2.41.0


