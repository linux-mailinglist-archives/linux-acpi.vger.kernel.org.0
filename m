Return-Path: <linux-acpi+bounces-8576-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9886D991AD1
	for <lists+linux-acpi@lfdr.de>; Sat,  5 Oct 2024 23:28:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 60059283831
	for <lists+linux-acpi@lfdr.de>; Sat,  5 Oct 2024 21:28:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E029016132F;
	Sat,  5 Oct 2024 21:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bCSfC3iG"
X-Original-To: linux-acpi@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41D23153BF6
	for <linux-acpi@vger.kernel.org>; Sat,  5 Oct 2024 21:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728163723; cv=none; b=RZGMnnpZbax0MENYUR9SLrMZBBGduYh9ZdteCt4eehtmVi9wU9c0loqtZot7S3IyQyOPxo5SslAOiXiwl9cgxfJdOnK9wHabOd5qMy9f6i1T594KTdMj+M3HGEzvHWJBP53eI7KCl9U/OyXoyCZmPZQvkNQh3yMX7IvyGDjLWwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728163723; c=relaxed/simple;
	bh=/zFzC7SbGD0njJSofZsGCh8sehdojr8j24i1kD4SXrU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DEExhmn5Xola74YVLuBrIhDFumq7QObedGaaUpkF5prlXL423dJo43VB4qewH1XCm44skUAlZGzMXdvf8eO7B9heIDW0kxTVoE/Fl/9qS17SshWG2dgvlBnEODbRb1vUwDOATknGp8saG/ekIpFnroRLyTUA/RAJcdeRFA1i4jU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bCSfC3iG; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728163721;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=OdZ7f0Fs1MhBF6v0t0pu7LgvhDwaoFSQRq1ePdrj7Ro=;
	b=bCSfC3iG5LcTr3ZdEhoHtG3W6KvlfiPhHiEMfhKdbBRdByz7pjLO2FAO7tKOR4MSg9uFKq
	3xanB1102jDkQjkSCANWfz0LAypU/LtO0NShkspxeDDtJkT/7oa7nFIYhxa6TDbWu3kaQk
	xTskOcYi/dX4uXDW0jy32IGl/B9dtok=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-581-XOFuBvgjP6OPYZAoSNHeeQ-1; Sat,
 05 Oct 2024 17:28:37 -0400
X-MC-Unique: XOFuBvgjP6OPYZAoSNHeeQ-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B8D031977009;
	Sat,  5 Oct 2024 21:28:35 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.39.192.19])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 288EE1956088;
	Sat,  5 Oct 2024 21:28:27 +0000 (UTC)
From: Hans de Goede <hdegoede@redhat.com>
To: "Rafael J . Wysocki" <rafael@kernel.org>
Cc: Hans de Goede <hdegoede@redhat.com>,
	"Luke D . Jones" <luke@ljones.dev>,
	linux-acpi@vger.kernel.org,
	platform-driver-x86@vger.kernel.org
Subject: [PATCH 0/4] ACPI: resource: Improve Asus skip IRQ override quirks
Date: Sat,  5 Oct 2024 23:28:15 +0200
Message-ID: <20241005212819.354681-1-hdegoede@redhat.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

Hi Rafael,

After receiving yet another Asus skip IRQ override bug report / patch:
https://lore.kernel.org/platform-driver-x86/a983e6d5-c7ab-4758-be9b-7dcfc1b44ed3@gmail.com/

I have taken a closer look at the existing Asus quirks to see if they can
be simplied to cover more models.

This patch series removes 8 quirks by making the quirks match more models,
while extending coverage with 3 new models which also need a skip IRQ
override quirk for their keyboards to work (including the model from
the new report).

Please send these to Linus as 6.12-rc# fixes, since this fixes
the keyboard not working on 3 more models.

Regards,

Hans


Hans de Goede (4):
  ACPI: resource: Make Asus ExpertBook B2402 matches cover more models
  ACPI: resource: Make Asus ExpertBook B2502 matches cover more models
  ACPI: resource: Fold Asus ExpertBook B1402C* and B1502C* DMI quirks
    together
  ACPI: resource: Fold Asus Vivobook Pro N6506M* DMI quirks together

 drivers/acpi/resource.c | 76 ++++++-----------------------------------
 1 file changed, 10 insertions(+), 66 deletions(-)

-- 
2.46.2


