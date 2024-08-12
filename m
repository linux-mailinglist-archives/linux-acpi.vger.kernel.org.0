Return-Path: <linux-acpi+bounces-7532-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1DC094EDDA
	for <lists+linux-acpi@lfdr.de>; Mon, 12 Aug 2024 15:16:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 30CBC282B6F
	for <lists+linux-acpi@lfdr.de>; Mon, 12 Aug 2024 13:16:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBF6917BB38;
	Mon, 12 Aug 2024 13:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="siVimqPw"
X-Original-To: linux-acpi@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59E071D699;
	Mon, 12 Aug 2024 13:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723468610; cv=none; b=bpOfuzNPTX1W1d/YSr02xGeWeBDJGMyf655N0WpXrd9mLkhlURnvZjw6R9p9rgTH4AKGnsSScfbTpVDtSJg4R79BcVRfADlvP0TYqNsiQo8D/wK0NlRvygpNLDLol1Pt2+0Kjd+5/JgRxjpc+gBkjidNIeGBno6qeB7bN6J5TzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723468610; c=relaxed/simple;
	bh=DEqs3SmQqBRuBVI0baBwHJNahYZWYBF10zKRUzqlPMo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rA0dJYSZNQT4Ea8nK1tZo08TvY+EcENFm4v1ia7KoI1juPMzx/ZxK98rGnJzfuZo9X3WEv+tGnFVqZA6K0SuXYhnL4SZT/E7VsqVAsVWpZBLjYZ1L97fkAV+S3ebrft4Ghr12pTOS0gUkg+WuF3YKxhtwK/r8THL7FkCKfDbtNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=fail (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=siVimqPw reason="signature verification failed"; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.2.0)
 id 0211acef65f60aac; Mon, 12 Aug 2024 15:16:46 +0200
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id 93CD36F0D95;
	Mon, 12 Aug 2024 15:16:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1723468606;
	bh=DEqs3SmQqBRuBVI0baBwHJNahYZWYBF10zKRUzqlPMo=;
	h=From:Subject:Date;
	b=siVimqPwQF3SqOyM4Qa9EznGuOZfMyuV9CU4+Z1Sr7vf1d//hHpMfXAmXvJ4bsTc1
	 Jpc+f0Xh4afanxWDnK1ZBy2Eqm7GvyHP45HYrf9Yd7eUNJ6p4mj9nqEZk7gBHN7zJD
	 jrGbHbyg/U6f2L7IWGWVceXNMUfxX1Dl8l0q4eduYGWUwdtUE4rtZNR5qM89f2aR9X
	 dtT91ouaBHczDkNRFiqYso0Ci8AhNaqYFE2OfISmLl3yzL7z56gCuUCn2PmMkHNl8a
	 pg8KXghrzpIVagOZiXinzhgYpLVAvWlNidoLZc/ZCodlcamsulUE6nN4EYizR32vU5
	 tGGH2zi5mCW7Q==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: Hans de Goede <hdegoede@redhat.com>, LKML <linux-kernel@vger.kernel.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Armin Wolf <w_armin@gmx.de>
Subject:
 [PATCH v1 3/3] ACPI: EC: Evaluate _REG outside the EC scope more carefully
Date: Mon, 12 Aug 2024 15:16:21 +0200
Message-ID: <23612351.6Emhk5qWAg@rjwysocki.net>
In-Reply-To: <22385894.EfDdHjke4D@rjwysocki.net>
References: <22385894.EfDdHjke4D@rjwysocki.net>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 195.136.19.94
X-CLIENT-HOSTNAME: 195.136.19.94
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeeftddruddttddgiedvucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepuefgfeefieeileekheffheeigefftddtueehgeejgfethfevffdvfeeuffetgfefnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghdprhgvughhrghtrdgtohhmnecukfhppeduleehrddufeeirdduledrleegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepudelhedrudefiedrudelrdelgedphhgvlhhopehkrhgvrggthhgvrhdrlhhotggrlhhnvghtpdhmrghilhhfrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqedpnhgspghrtghpthhtohephedprhgtphhtthhopehlihhnuhigqdgrtghpihesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehhuggvghhovgguvgesrhgvughhrghtrdgtohhmpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprhgrfhgr
 vghlsehkvghrnhgvlhdrohhrghdprhgtphhtthhopeifpggrrhhmihhnsehgmhigrdguvg
X-DCC--Metrics: v370.home.net.pl 1024; Body=5 Fuz1=5 Fuz2=5

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Commit 60fa6ae6e6d0 ("ACPI: EC: Install address space handler at the
namespace root") caused _REG methods for EC operation regions outside
the EC device scope to be evaluated which on some systems leads to the
evaluation of _REG methods in the scopes of device objects representing
devices that are not present and not functional according to the _STA
return values. Some of those device objects represent EC "alternatives"
and if _REG is evaluated for their operation regions, the platform
firmware may be confused and the platform may start to behave
incorrectly.

To avoid this problem, only evaluate _REG for EC operation regions
located in the scopes of device objects representing known-to-be-present
devices.

For this purpose, partially revert commit 60fa6ae6e6d0 and trigger the
evaluation of _REG for EC operation regions from acpi_bus_attach() for
the known-valid devices.

Fixes: 60fa6ae6e6d0 ("ACPI: EC: Install address space handler at the namespace root")
Link: https://lore.kernel.org/linux-acpi/1f76b7e2-1928-4598-8037-28a1785c2d13@redhat.com
Link: https://bugzilla.redhat.com/show_bug.cgi?id=2298938
Link: https://bugzilla.redhat.com/show_bug.cgi?id=2302253
Reported-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/acpi/ec.c       |   11 +++++++++--
 drivers/acpi/internal.h |    1 +
 drivers/acpi/scan.c     |    2 ++
 3 files changed, 12 insertions(+), 2 deletions(-)

Index: linux-pm/drivers/acpi/ec.c
===================================================================
--- linux-pm.orig/drivers/acpi/ec.c
+++ linux-pm/drivers/acpi/ec.c
@@ -1530,12 +1530,13 @@ static bool install_gpio_irq_event_handl
 static int ec_install_handlers(struct acpi_ec *ec, struct acpi_device *device,
 			       bool call_reg)
 {
-	acpi_handle scope_handle = ec == first_ec ? ACPI_ROOT_OBJECT : ec->handle;
 	acpi_status status;
 
 	acpi_ec_start(ec, false);
 
 	if (!test_bit(EC_FLAGS_EC_HANDLER_INSTALLED, &ec->flags)) {
+		acpi_handle scope_handle = ec == first_ec ? ACPI_ROOT_OBJECT : ec->handle;
+
 		acpi_ec_enter_noirq(ec);
 		status = acpi_install_address_space_handler_no_reg(scope_handle,
 								   ACPI_ADR_SPACE_EC,
@@ -1549,7 +1550,7 @@ static int ec_install_handlers(struct ac
 	}
 
 	if (call_reg && !test_bit(EC_FLAGS_EC_REG_CALLED, &ec->flags)) {
-		acpi_execute_reg_methods(scope_handle, ACPI_UINT32_MAX, ACPI_ADR_SPACE_EC);
+		acpi_execute_reg_methods(ec->handle, ACPI_UINT32_MAX, ACPI_ADR_SPACE_EC);
 		set_bit(EC_FLAGS_EC_REG_CALLED, &ec->flags);
 	}
 
@@ -1764,6 +1765,12 @@ static void acpi_ec_remove(struct acpi_d
 	}
 }
 
+void acpi_ec_register_opregions(struct acpi_device *adev)
+{
+	if (first_ec && first_ec->handle != adev->handle)
+		acpi_execute_reg_methods(adev->handle, 1, ACPI_ADR_SPACE_EC);
+}
+
 static acpi_status
 ec_parse_io_ports(struct acpi_resource *resource, void *context)
 {
Index: linux-pm/drivers/acpi/internal.h
===================================================================
--- linux-pm.orig/drivers/acpi/internal.h
+++ linux-pm/drivers/acpi/internal.h
@@ -224,6 +224,7 @@ int acpi_ec_add_query_handler(struct acp
 			      acpi_handle handle, acpi_ec_query_func func,
 			      void *data);
 void acpi_ec_remove_query_handler(struct acpi_ec *ec, u8 query_bit);
+void acpi_ec_register_opregions(struct acpi_device *adev);
 
 #ifdef CONFIG_PM_SLEEP
 void acpi_ec_flush_work(void);
Index: linux-pm/drivers/acpi/scan.c
===================================================================
--- linux-pm.orig/drivers/acpi/scan.c
+++ linux-pm/drivers/acpi/scan.c
@@ -2271,6 +2271,8 @@ static int acpi_bus_attach(struct acpi_d
 	if (device->handler)
 		goto ok;
 
+	acpi_ec_register_opregions(device);
+
 	if (!device->flags.initialized) {
 		device->flags.power_manageable =
 			device->power.states[ACPI_STATE_D0].flags.valid;




