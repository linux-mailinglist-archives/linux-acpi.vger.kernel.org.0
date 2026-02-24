Return-Path: <linux-acpi+bounces-21116-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UF2kJs9onWnBPwQAu9opvQ
	(envelope-from <linux-acpi+bounces-21116-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Tue, 24 Feb 2026 10:01:03 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EA18184279
	for <lists+linux-acpi@lfdr.de>; Tue, 24 Feb 2026 10:00:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4231630BDA8F
	for <lists+linux-acpi@lfdr.de>; Tue, 24 Feb 2026 08:58:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90F75369961;
	Tue, 24 Feb 2026 08:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="LiQO4QDA"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1354D36920D
	for <linux-acpi@vger.kernel.org>; Tue, 24 Feb 2026 08:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771923482; cv=none; b=cD77xR1y37sRhNZtnqN6mofc5dfzWM5HM5wbu2q42oam7qA4OyO81Ol0X5TJ5wKo/pmfX15oeK18h4qCMGpkvdXZo2JPzNVIskYTTXKTmjF+MAHb7eAI22005Z05LgTVrpw4oWXt7KNi/uVE6lLGf8/RB5fdn/wtGakSCivciH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771923482; c=relaxed/simple;
	bh=75tIlJhL7lTvbSGE7D59R10soZGFPbIv0b8WGkPwmek=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SouG8Gzmad3smTF9dV6RPxm0sd46thMRw23Cywzeo1hwDBebOhE5rWADJJT3o/9aUB6PgRqoZ1RF6dNAPfZkXccYJ0yk6rIsMRhD93bhnY7LV4HEJS/ao/HWvSzhShXU2dXwzB4mQOVHZvoJyMi0oX9EVyppqpLNHTmsOygW6FA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=LiQO4QDA; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=from:to:cc:subject:date:message-id
	:mime-version:content-transfer-encoding; s=k1; bh=LkBWz+K1nxLr/l
	Bo/t63y5ciaH4V8V92AgZnhwFxGiA=; b=LiQO4QDAIPC7jcFmuXQdpS9cUIzzff
	rXWVlM9nR60bsKOnCkWjG0KnKQTqD81SwstkLHp6FEz3vYXFtiamSQVd5hgItMGq
	GV9+bJGPQ50+Ac4ldqd1/vlEg3Mj4E28u/nF02AdxtVuthUCsJE7ELD9+nntiQ7h
	d0HkE9X1UbIZxLn9T9E1VlZ9/bTfDL/nH/EjGWSGImvrCKh9VZ52v5gdOg2K2Rru
	LrZjemW/Q8ZwVyzT83Y5GQOkT/mcff8RaSRsEL4wIxcuq3mV1aJSsP7ogw/qBrbz
	l0XrVuhNFsQj8xLj9ahx68kzfmuU8AEKWck47h34E3GWLiq9ixsTjLgg==
Received: (qmail 175537 invoked from network); 24 Feb 2026 09:57:54 +0100
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 24 Feb 2026 09:57:54 +0100
X-UD-Smtp-Session: l3s3148p1@Nso9FY5LUsUgAwDPXzF+ANZpdrMKUeLI
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: linux-renesas-soc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Peter Chen <peter.chen@cixtech.com>,
	Fugang Duan <fugang.duan@cixtech.com>,
	CIX Linux Kernel Upstream Group <cix-kernel-upstream@cixtech.com>,
	Jassi Brar <jassisinghbrar@gmail.com>,
	Frank Li <Frank.Li@nxp.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Sudeep Holla <sudeep.holla@kernel.org>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev,
	linux-acpi@vger.kernel.org,
	linux-tegra@vger.kernel.org
Subject: [RFC PATCH] mailbox: remove superfluous internal header
Date: Tue, 24 Feb 2026 09:50:21 +0100
Message-ID: <20260224085720.18055-2-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[sang-engineering.com:s=k1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21116-lists,linux-acpi=lfdr.de,renesas];
	DMARC_NA(0.00)[sang-engineering.com];
	RSPAMD_URIBL_FAIL(0.00)[sang-engineering.com:query timed out];
	RCPT_COUNT_TWELVE(0.00)[18];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,sang-engineering.com,cixtech.com,gmail.com,nxp.com,pengutronix.de,kernel.org,nvidia.com,lists.infradead.org,lists.linux.dev];
	RSPAMD_EMAILBL_FAIL(0.00)[wsa.sang-engineering.com:query timed out];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FROM_NEQ_ENVFROM(0.00)[wsa@sang-engineering.com,linux-acpi@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[sang-engineering.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-acpi,renesas];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sang-engineering.com:mid,sang-engineering.com:dkim,sang-engineering.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 3EA18184279
X-Rspamd-Action: no action

Quite some controller drivers use the defines from the internal header
already. This prevents controller drivers outside the mailbox directory.
Move the defines to the public controller header to allow this again as
the defines are not strictly internal anyhow.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---

I need this for a combined driver (mailbox + hwspinlock at least) which
probably ends up in drivers/soc. But it seems reasonable to me to do
this anyway. Locally build tested. Still waiting for buildbot results.
Opinions?

 drivers/mailbox/cix-mailbox.c      |  2 --
 drivers/mailbox/hi3660-mailbox.c   |  2 --
 drivers/mailbox/imx-mailbox.c      |  2 --
 drivers/mailbox/mailbox-sti.c      |  2 --
 drivers/mailbox/mailbox.c          |  2 --
 drivers/mailbox/mailbox.h          | 12 ------------
 drivers/mailbox/omap-mailbox.c     |  2 --
 drivers/mailbox/pcc.c              |  2 --
 drivers/mailbox/tegra-hsp.c        |  2 --
 include/linux/mailbox_controller.h |  5 +++++
 10 files changed, 5 insertions(+), 28 deletions(-)
 delete mode 100644 drivers/mailbox/mailbox.h

diff --git a/drivers/mailbox/cix-mailbox.c b/drivers/mailbox/cix-mailbox.c
index 443620e8ae37..864f98f21fc3 100644
--- a/drivers/mailbox/cix-mailbox.c
+++ b/drivers/mailbox/cix-mailbox.c
@@ -12,8 +12,6 @@
 #include <linux/module.h>
 #include <linux/platform_device.h>
 
-#include "mailbox.h"
-
 /*
  * The maximum transmission size is 32 words or 128 bytes.
  */
diff --git a/drivers/mailbox/hi3660-mailbox.c b/drivers/mailbox/hi3660-mailbox.c
index 17c29e960fbf..9b727a2b54a5 100644
--- a/drivers/mailbox/hi3660-mailbox.c
+++ b/drivers/mailbox/hi3660-mailbox.c
@@ -15,8 +15,6 @@
 #include <linux/platform_device.h>
 #include <linux/slab.h>
 
-#include "mailbox.h"
-
 #define MBOX_CHAN_MAX			32
 
 #define MBOX_RX				0x0
diff --git a/drivers/mailbox/imx-mailbox.c b/drivers/mailbox/imx-mailbox.c
index 003f9236c35e..22331b579489 100644
--- a/drivers/mailbox/imx-mailbox.c
+++ b/drivers/mailbox/imx-mailbox.c
@@ -23,8 +23,6 @@
 #include <linux/slab.h>
 #include <linux/workqueue.h>
 
-#include "mailbox.h"
-
 #define IMX_MU_CHANS		24
 /* TX0/RX0/RXDB[0-3] */
 #define IMX_MU_SCU_CHANS	6
diff --git a/drivers/mailbox/mailbox-sti.c b/drivers/mailbox/mailbox-sti.c
index b4b5bdd503cf..b6c9ecbbc8ec 100644
--- a/drivers/mailbox/mailbox-sti.c
+++ b/drivers/mailbox/mailbox-sti.c
@@ -21,8 +21,6 @@
 #include <linux/property.h>
 #include <linux/slab.h>
 
-#include "mailbox.h"
-
 #define STI_MBOX_INST_MAX	4      /* RAM saving: Max supported instances */
 #define STI_MBOX_CHAN_MAX	20     /* RAM saving: Max supported channels  */
 
diff --git a/drivers/mailbox/mailbox.c b/drivers/mailbox/mailbox.c
index e63b2292ee7a..9d41a1ab9018 100644
--- a/drivers/mailbox/mailbox.c
+++ b/drivers/mailbox/mailbox.c
@@ -18,8 +18,6 @@
 #include <linux/property.h>
 #include <linux/spinlock.h>
 
-#include "mailbox.h"
-
 static LIST_HEAD(mbox_cons);
 static DEFINE_MUTEX(con_mutex);
 
diff --git a/drivers/mailbox/mailbox.h b/drivers/mailbox/mailbox.h
deleted file mode 100644
index e1ec4efab693..000000000000
--- a/drivers/mailbox/mailbox.h
+++ /dev/null
@@ -1,12 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-only */
-
-#ifndef __MAILBOX_H
-#define __MAILBOX_H
-
-#include <linux/bits.h>
-
-#define TXDONE_BY_IRQ	BIT(0) /* controller has remote RTR irq */
-#define TXDONE_BY_POLL	BIT(1) /* controller can read status of last TX */
-#define TXDONE_BY_ACK	BIT(2) /* S/W ACK received by Client ticks the TX */
-
-#endif /* __MAILBOX_H */
diff --git a/drivers/mailbox/omap-mailbox.c b/drivers/mailbox/omap-mailbox.c
index d9f100c18895..5772c6b9886a 100644
--- a/drivers/mailbox/omap-mailbox.c
+++ b/drivers/mailbox/omap-mailbox.c
@@ -22,8 +22,6 @@
 #include <linux/pm_runtime.h>
 #include <linux/mailbox_controller.h>
 
-#include "mailbox.h"
-
 #define MAILBOX_REVISION		0x000
 #define MAILBOX_MESSAGE(m)		(0x040 + 4 * (m))
 #define MAILBOX_FIFOSTATUS(m)		(0x080 + 4 * (m))
diff --git a/drivers/mailbox/pcc.c b/drivers/mailbox/pcc.c
index 22e70af1ae5d..636879ae1db7 100644
--- a/drivers/mailbox/pcc.c
+++ b/drivers/mailbox/pcc.c
@@ -59,8 +59,6 @@
 #include <linux/io-64-nonatomic-lo-hi.h>
 #include <acpi/pcc.h>
 
-#include "mailbox.h"
-
 #define MBOX_IRQ_NAME		"pcc-mbox"
 
 /**
diff --git a/drivers/mailbox/tegra-hsp.c b/drivers/mailbox/tegra-hsp.c
index ed9a0bb2bcd8..2231050bb5a9 100644
--- a/drivers/mailbox/tegra-hsp.c
+++ b/drivers/mailbox/tegra-hsp.c
@@ -16,8 +16,6 @@
 
 #include <dt-bindings/mailbox/tegra186-hsp.h>
 
-#include "mailbox.h"
-
 #define HSP_INT_IE(x)		(0x100 + ((x) * 4))
 #define HSP_INT_IV		0x300
 #define HSP_INT_IR		0x304
diff --git a/include/linux/mailbox_controller.h b/include/linux/mailbox_controller.h
index 80a427c7ca29..16fef421c30c 100644
--- a/include/linux/mailbox_controller.h
+++ b/include/linux/mailbox_controller.h
@@ -3,6 +3,7 @@
 #ifndef __MAILBOX_CONTROLLER_H
 #define __MAILBOX_CONTROLLER_H
 
+#include <linux/bits.h>
 #include <linux/completion.h>
 #include <linux/device.h>
 #include <linux/hrtimer.h>
@@ -11,6 +12,10 @@
 
 struct mbox_chan;
 
+#define TXDONE_BY_IRQ	BIT(0) /* controller has remote RTR irq */
+#define TXDONE_BY_POLL	BIT(1) /* controller can read status of last TX */
+#define TXDONE_BY_ACK	BIT(2) /* S/W ACK received by Client ticks the TX */
+
 /**
  * struct mbox_chan_ops - methods to control mailbox channels
  * @send_data:	The API asks the MBOX controller driver, in atomic
-- 
2.51.0


