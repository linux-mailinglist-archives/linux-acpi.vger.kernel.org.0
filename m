Return-Path: <linux-acpi+bounces-5238-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E95ED8ACA22
	for <lists+linux-acpi@lfdr.de>; Mon, 22 Apr 2024 12:02:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5307A2834BC
	for <lists+linux-acpi@lfdr.de>; Mon, 22 Apr 2024 10:02:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BBD513B2BA;
	Mon, 22 Apr 2024 10:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="C/Bm7/YV"
X-Original-To: linux-acpi@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E16E6518F
	for <linux-acpi@vger.kernel.org>; Mon, 22 Apr 2024 10:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713780146; cv=none; b=hmrgVIpoFHsBdcTRI9LAXiDnt/hzm/Ri6MqNl3QHMXxP8RpiphQiYSZ0yjteTrEBZ89WB5neDRht4Z5AY1PIAaY1mKc8g0SNmVDAsgfrvkXo9pu6zOhjrGYS7UVgU8dnN7RHNjGUqUye9bzLUCnnL5rmQ6fG+j3+KF/0LBhtt04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713780146; c=relaxed/simple;
	bh=8sOJmMJD2vQcj0/LPz0esuDxDFtO03WqDjdBe5eORY0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Kdyqcyu5g+oixET1qaf51v/DfcOtu8ySWGtpQwnoy4ogGbbl5eYUWVwX5cvvZv+ZdHlPomhuHo0MGjJ1VGtv0F6SacsV6cZfTGtAVl5ZYp/cEM03Le5OuwOXIWqkrLL1ZVPonRYazwPEArWWG+uIi+1BeVdCv9j+hGM0KsP1YjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=C/Bm7/YV; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713780143;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=M7WtTk/6/zyFIKqMmnKnMfF2rx1NzfGA5mIv03dRJRI=;
	b=C/Bm7/YVj3eoZFH08EJeYE6m0DYlt0O3Fe65MdzV+3O/yJQBspdwOrTVs+IsNIiTsNkSGk
	YH0KYPv9K6eStP1lDpyPeaVqzS3inh6GKtDt+rHID0CusDrVEOrdkRTf4cQNucqZAs1yp6
	U3XGkyxtyFvzvPsMZOLyQqqn6BRIbkQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-491-YETLEgKIPHe0CrluzktLtQ-1; Mon, 22 Apr 2024 06:02:22 -0400
X-MC-Unique: YETLEgKIPHe0CrluzktLtQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 97852812C59;
	Mon, 22 Apr 2024 10:02:21 +0000 (UTC)
Received: from x1.localdomain.com (unknown [10.39.192.177])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 66BE743FB1;
	Mon, 22 Apr 2024 10:02:19 +0000 (UTC)
From: Hans de Goede <hdegoede@redhat.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Hans de Goede <hdegoede@redhat.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Sean Rhodes <sean@starlabs.systems>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	linux-iio@vger.kernel.org,
	linux-acpi@vger.kernel.org
Subject: [PATCH v2 0/4] iio: accel: Share ACPI ROTM parsing between drivers and add it to mxc4005
Date: Mon, 22 Apr 2024 12:02:14 +0200
Message-ID: <20240422100218.7693-1-hdegoede@redhat.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5

Hi All,

Here is v2 of the patch series to refactor the ACPI ROTM orientation matrix
handling in kxcjk-1013 + bmc150-accel to share the code instead of having
2 copies and then also use the shared implementation in the mxc4005 driver
since some MXC6655 ACPI firmware nodes also include this.

Changes in v2:
- Add comment about the Microsoft specification for the "ROTM" ACPI method

Regards,

Hans


Hans de Goede (4):
  iio: accel: kxcjk-1013: Simplify ACPI ROTM mount matrix retreival
  iio: accel: kxcjk-1013: Move ACPI ROTM parsing to new acpi-helpers.h
  iio: bmc150-accel-core: Use acpi_read_mount_matrix() helper
  iio: accel: mxc4005: Read orientation matrix from ACPI ROTM method

 drivers/iio/accel/acpi-helpers.h      | 83 +++++++++++++++++++++++++++
 drivers/iio/accel/bmc150-accel-core.c | 45 +--------------
 drivers/iio/accel/kxcjk-1013.c        | 82 +-------------------------
 drivers/iio/accel/mxc4005.c           | 24 ++++++++
 4 files changed, 113 insertions(+), 121 deletions(-)
 create mode 100644 drivers/iio/accel/acpi-helpers.h

-- 
2.44.0


