Return-Path: <linux-acpi+bounces-9115-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2DA19B632A
	for <lists+linux-acpi@lfdr.de>; Wed, 30 Oct 2024 13:37:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 87C61282A50
	for <lists+linux-acpi@lfdr.de>; Wed, 30 Oct 2024 12:37:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09C991E570B;
	Wed, 30 Oct 2024 12:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TldWA8YT"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4CAA1E1301;
	Wed, 30 Oct 2024 12:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730291857; cv=none; b=YAKi3UVOv7iQ3ZqQOu9aRgXNvQttekyorbizv1Fk52dmz/BSchNV+QY2hx2yuW73iK4xPz4hH/vYBEL34MnxZFuKK4N7lFbms4Dm2+ISwuw9qfhw4sb3WbdPg1FWB/ouWSZ325HMdxiEkCJjNxLnmbQ6cMOkcszfNNghnX0IXV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730291857; c=relaxed/simple;
	bh=iQ5MWg6guKwc54quNaLMTdgp1XfHAz9Kqtg3TI+nJrk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GxklLGWGnjhTAnl9tHIyfdMGkunOIrzEyOPmFieTu63dQtK0bflYvnISqozgMsQoIKMr95eoBnxVrU6GIXEw5U4p6Upu0qvYFssptw1qNZ7VUZAUkFyMwjFafbUmt9h/P5DNz5P5+Kg4Zzpm7SCk8thLcRjd+JI39UpgWu55DUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TldWA8YT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2568C4CEE3;
	Wed, 30 Oct 2024 12:37:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730291857;
	bh=iQ5MWg6guKwc54quNaLMTdgp1XfHAz9Kqtg3TI+nJrk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TldWA8YTm6BRMU+Oi1vrsYUKDDlOK745njA6aZ71oGQmL0pP5h/HmhBUkpaZP0Jc9
	 tHZn3TB3FWVGPONOKT01zdkbpEkFSYM/M8963gK9wqMQMbSnqqZnNr3IHiuO09AQL9
	 CuQIhT4dWlIKqYojo+8ENR2f06AsqbxR3s5eTMuHi/QWqy6n1875leqn9mgq7MuOnk
	 NTXo8a3SwQzi7lCjjW7uGct3GnHoMUj0+BUZFdZVuk1tsgpMrZxMQa9qDZVYZ1IU+D
	 RW+AAAncR1n3oXHQ5MbuM4JUSYVfO/AV51ikheJ/vluK4Qhaco/gVQMrZLi0IoU2bM
	 /zyecQk2UxKQw==
From: Arnd Bergmann <arnd@kernel.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Len Brown <lenb@kernel.org>,
	Jarred White <jarredwhite@linux.microsoft.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] [v3] acpi: allow building without CONFIG_HAS_IOPORT
Date: Wed, 30 Oct 2024 12:36:41 +0000
Message-Id: <20241030123701.1538919-2-arnd@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241030123701.1538919-1-arnd@kernel.org>
References: <20241030123701.1538919-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

CONFIG_HAS_IOPORT will soon become optional and cause a build time
failure when it is disabled but a driver calls inb()/outb(). At the
moment, all architectures that can support ACPI have port I/O, but this
is not necessarily the case in the future on non-x86 architectures.
The result is a set of errors like:

drivers/acpi/osl.c: In function 'acpi_os_read_port':
include/asm-generic/io.h:542:14: error: call to '_inb' declared with attribute error: inb()) requires CONFIG_HAS_IOPORT

Nothing should actually call these functions in this configuration,
and if it does, the result would be undefined behavior today, possibly
a NULL pointer dereference.

Change the low-level functions to return a proper error code when
HAS_IOPORT is disabled.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
v3: fix the returned value and add a comment
---
 drivers/acpi/cppc_acpi.c |  6 ++++--
 drivers/acpi/osl.c       | 12 ++++++++++++
 2 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
index 1a40f0514eaa..3757424b715f 100644
--- a/drivers/acpi/cppc_acpi.c
+++ b/drivers/acpi/cppc_acpi.c
@@ -1017,7 +1017,8 @@ static int cpc_read(int cpu, struct cpc_register_resource *reg_res, u64 *val)
 	*val = 0;
 	size = GET_BIT_WIDTH(reg);
 
-	if (reg->space_id == ACPI_ADR_SPACE_SYSTEM_IO) {
+	if (IS_ENABLED(CONFIG_HAS_IOPORT) &&
+	    reg->space_id == ACPI_ADR_SPACE_SYSTEM_IO) {
 		u32 val_u32;
 		acpi_status status;
 
@@ -1091,7 +1092,8 @@ static int cpc_write(int cpu, struct cpc_register_resource *reg_res, u64 val)
 
 	size = GET_BIT_WIDTH(reg);
 
-	if (reg->space_id == ACPI_ADR_SPACE_SYSTEM_IO) {
+	if (IS_ENABLED(CONFIG_HAS_IOPORT) &&
+	    reg->space_id == ACPI_ADR_SPACE_SYSTEM_IO) {
 		acpi_status status;
 
 		status = acpi_os_write_port((acpi_io_address)reg->address,
diff --git a/drivers/acpi/osl.c b/drivers/acpi/osl.c
index 78a81969d90e..8ab1802c164b 100644
--- a/drivers/acpi/osl.c
+++ b/drivers/acpi/osl.c
@@ -642,6 +642,15 @@ acpi_status acpi_os_read_port(acpi_io_address port, u32 *value, u32 width)
 {
 	u32 dummy;
 
+	if (!IS_ENABLED(CONFIG_HAS_IOPORT)) {
+		/*
+		 * set all-1 result as if reading from non-existing
+		 * I/O port
+		 */
+		*value = GENMASK(width, 0);
+		return AE_NOT_IMPLEMENTED;
+	}
+
 	if (value)
 		*value = 0;
 	else
@@ -665,6 +674,9 @@ EXPORT_SYMBOL(acpi_os_read_port);
 
 acpi_status acpi_os_write_port(acpi_io_address port, u32 value, u32 width)
 {
+	if (!IS_ENABLED(CONFIG_HAS_IOPORT))
+		return AE_NOT_IMPLEMENTED;
+
 	if (width <= 8) {
 		outb(value, port);
 	} else if (width <= 16) {
-- 
2.39.5


