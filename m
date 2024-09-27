Return-Path: <linux-acpi+bounces-8458-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FC979886D2
	for <lists+linux-acpi@lfdr.de>; Fri, 27 Sep 2024 16:16:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B01AE1C22C65
	for <lists+linux-acpi@lfdr.de>; Fri, 27 Sep 2024 14:16:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 751E1139D1B;
	Fri, 27 Sep 2024 14:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BKTrU1Vj"
X-Original-To: linux-acpi@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCB8C8493
	for <linux-acpi@vger.kernel.org>; Fri, 27 Sep 2024 14:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727446580; cv=none; b=WlEV/Itk+rPaf4qGxe+oNG9VsuqBenU3NJM/Nn9wi435iiiWDwSzimOOKrvXqtpCIOd7xkiQWMbI4t7R4ZyNG/B8ksWzfNBbVXpgatH0eOzJgc3ZqehgKS5K+Xc0rNXtioy3medsi6LTjqlEsxfOtDxO/6u9jMorszKPCboDPNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727446580; c=relaxed/simple;
	bh=JGRnTam6wOgX0GfiGrUOUmnr/nbZ45ODyhVr0wrKvmM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Cx3q5kCSiU4Qznbk4ffSWOwY2oJ0Ie/5SaIlnlRT/EQINRASq07rugzYi/AyBtfFBqRywKHb/bNKiwMFghmG9lLmEIbXXDwXPhFMlXthDE9A2I+rPR9waerY+cjOTNaomviALwIN+iaqMBu8T3glHOkT57CJuo2QF9fspWTBHFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BKTrU1Vj; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727446577;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SOFBPnBC7lN1uRdqkUmvoJFNcklxzjyW8PN4nLsCvLk=;
	b=BKTrU1VjoWDJLE3lna9+NUJvOqBdRW3W27bZAv47D5Yw+KHAEXqRBzOnKMoBWb1JlmDjSO
	jbX6bBZNHufD7ogAUBQZ/lLv8bSyWnGRWI/VpcLsSXCrfFos8pLtJMJlHDx9gD0uB8l1jC
	wyKmYX5+AKMeTlTiH7Iv6DC4QW++qys=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-609-_WFFAZgiNi-5tFt9mWX0AA-1; Fri,
 27 Sep 2024 10:16:13 -0400
X-MC-Unique: _WFFAZgiNi-5tFt9mWX0AA-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (unknown [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7B63C1975ACE;
	Fri, 27 Sep 2024 14:16:12 +0000 (UTC)
Received: from shalem.redhat.com (unknown [10.39.192.213])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 603C33003DEC;
	Fri, 27 Sep 2024 14:16:10 +0000 (UTC)
From: Hans de Goede <hdegoede@redhat.com>
To: "Rafael J . Wysocki" <rafael@kernel.org>
Cc: Hans de Goede <hdegoede@redhat.com>,
	Ben Mayo <benny1091@gmail.com>,
	Paul Menzel <pmenzel@molgen.mpg.de>,
	Tamim Khan <tamim@fusetak.com>,
	linux-acpi@vger.kernel.org,
	regressions@lists.linux.dev,
	stable@vger.kernel.org
Subject: [PATCH 2/4] ACPI: resource: Loosen the Asus E1404GAB DMI match to also cover the E1404GA
Date: Fri, 27 Sep 2024 16:16:04 +0200
Message-ID: <20240927141606.66826-2-hdegoede@redhat.com>
In-Reply-To: <20240927141606.66826-1-hdegoede@redhat.com>
References: <20240927141606.66826-1-hdegoede@redhat.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Like other Asus Vivobooks, the Asus Vivobook Go E1404GA has a DSDT
describing IRQ 1 as ActiveLow, while the kernel overrides to Edge_High.

    $ sudo dmesg | grep DMI:.*BIOS
    [    0.000000] DMI: ASUSTeK COMPUTER INC. Vivobook Go E1404GA_E1404GA/E1404GA, BIOS E1404GA.302 08/23/2023
    $ sudo cp /sys/firmware/acpi/tables/DSDT dsdt.dat
    $ iasl -d dsdt.dat
    $ grep -A 30 PS2K dsdt.dsl | grep IRQ -A 1
                IRQ (Level, ActiveLow, Exclusive, )
                    {1}

There already is an entry in the irq1_level_low_skip_override[] DMI match
table for the "E1404GAB", change this to match on "E1404GA" to cover
the E1404GA model as well (DMI_MATCH() does a substring match).

Reported-by: Paul Menzel <pmenzel@molgen.mpg.de>
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=219224
Cc: Tamim Khan <tamim@fusetak.com>
Cc: stable@vger.kernel.org
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
Note this patch replaces Paul Menzel's patch which added a new entry
for the "E1404GA", instead of loosening the "E1404GAB" match:
https://lore.kernel.org/linux-acpi/20240911081612.3931-1-pmenzel@molgen.mpg.de/
---
 drivers/acpi/resource.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/resource.c b/drivers/acpi/resource.c
index 1ff251fd1901..dfe108e2ccde 100644
--- a/drivers/acpi/resource.c
+++ b/drivers/acpi/resource.c
@@ -504,10 +504,10 @@ static const struct dmi_system_id irq1_level_low_skip_override[] = {
 		},
 	},
 	{
-		/* Asus Vivobook Go E1404GAB */
+		/* Asus Vivobook Go E1404GA* */
 		.matches = {
 			DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
-			DMI_MATCH(DMI_BOARD_NAME, "E1404GAB"),
+			DMI_MATCH(DMI_BOARD_NAME, "E1404GA"),
 		},
 	},
 	{
-- 
2.46.0


