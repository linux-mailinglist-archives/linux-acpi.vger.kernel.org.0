Return-Path: <linux-acpi+bounces-19732-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E317CD2695
	for <lists+linux-acpi@lfdr.de>; Sat, 20 Dec 2025 04:55:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C49123001BD2
	for <lists+linux-acpi@lfdr.de>; Sat, 20 Dec 2025 03:55:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D2232C21DF;
	Sat, 20 Dec 2025 03:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WDLRGXC7"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E379025B663;
	Sat, 20 Dec 2025 03:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766202909; cv=none; b=uA70dcmzDohiF1xCQWclZSnIazVCf2UGVwogsRZ+ExFMsVCAp11trKSGzfLwQp6eOn0pDbEn6qNp96ERkQfVEmM4cssOeUvTErcb3ahoFIO9Yqwv01rkvKbaFF3ITyjVovme7TSki0Aw8g9SnE4pPJdT6hsPQaw+kKwA0BgEREY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766202909; c=relaxed/simple;
	bh=6QZqv+jumrBAIVjCoeBPj9G1/6Zv5z9JfqMtKFzw1zo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Qmbf7B/KpsqHPFm5IBCQxMYjV4w3Xj3l+sSDGLbmk55gw1DfUiI0jWoD4l2NyBK8TD9PkP0elYma9RiRrcjDW1Q71mUjEdP4QXRXlpAeT7cPQPm2v68a+SOBBD1mbomSF2Ekxst0bI3/FslK7/GnoYVGT2MhwsH7HDL8SjKA3Jo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WDLRGXC7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59238C4CEF5;
	Sat, 20 Dec 2025 03:55:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766202908;
	bh=6QZqv+jumrBAIVjCoeBPj9G1/6Zv5z9JfqMtKFzw1zo=;
	h=From:Date:Subject:To:Cc:From;
	b=WDLRGXC71CcWVmUq+CshoCE9A4GGxRX7M8b026GQr08CUgOJdvxxR6sRpaYWchsLQ
	 mb3yJhOH15YwRegFdhyADjQcHLvqhya9CrHmiRKCttkEa0SGsVldkPDa4TIniKPa3r
	 4m9qdfZ0crZtyef0Np+DVP2LQ98DwlkCqc2s0xxsF0ijm3fW6LWfqA6WXQYLuzBzxO
	 fZd/0pm7sTVz3DhXLCpq7/LhR+NAnUUESz2b85Po+ATt8y23ZvAZd7Em4BP0qGXIoU
	 d2byRzgdHDOJTqQRfbMTh0mRl2bboS0r2kx2PyNnYx24nVCZxUJ92MRxBHT+y9UZgC
	 /pDcMFztae/Ow==
From: Daniel Gomez <da.gomez@kernel.org>
Date: Sat, 20 Dec 2025 04:55:00 +0100
Subject: [PATCH] software node: replace -EEXIST with -EBUSY
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251220-dev-module-init-eexists-linux-acpi-v1-1-af59b1a0e217@samsung.com>
X-B4-Tracking: v=1; b=H4sIABMeRmkC/x2N0QqDMAwAf0XyvICpbsP9yvChNJkGXJVGpSD+u
 8XH4+DuAJOkYvCpDkiyq+kcC9CjgjD6OAgqFwZXuyc56pBlx//M21RM1BVFstpqOGncMvqwKBL
 V3avl5u0DQwktSX6a78m3P88Ldv3E6HQAAAA=
X-Change-ID: 20251219-dev-module-init-eexists-linux-acpi-110964d37acd
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 Daniel Scally <djrscally@gmail.com>, 
 Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
 Sakari Ailus <sakari.ailus@linux.intel.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>
Cc: Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>, 
 Daniel Gomez <da.gomez@kernel.org>, Sami Tolvanen <samitolvanen@google.com>, 
 Aaron Tomlin <atomlin@atomlin.com>, Lucas De Marchi <demarchi@kernel.org>, 
 linux-acpi@vger.kernel.org, linux-modules@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Daniel Gomez <da.gomez@samsung.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2363; i=da.gomez@samsung.com;
 h=from:subject:message-id; bh=7YqUmN4uIwzDtt9WaPgKwax56j9QqJpKf86ki4FbzFM=;
 b=owEBbQKS/ZANAwAIAUCeo8QfGVH7AcsmYgBpRh4X89eZfRBRr/B+gqnTfyL6YMeRWaO7o3ygK
 4gnUb7AygaJAjMEAAEIAB0WIQTvdRrhHw9z4bnGPFNAnqPEHxlR+wUCaUYeFwAKCRBAnqPEHxlR
 +7lmD/4kMTV5HxSRfTrfWH0Vtuj+axgpuVTYgnteJ8j8zefVeOuc7pXOVjKcd6bwZN5x1ju/Ala
 uZTO/+Oy+E4BvblOaRlaZxaQgdmfjcY3s9JPPEh/zBdlapfFff6NOdxB9GfNs/x55WPlr6RPj7J
 fDNLTPVdxJdNo3HmpNtqhapvCB5ig85ql1jcz4eGJb4PSkdwp/tEYBmZI3TVQlAy2qhhI+GiwhH
 AYSPeJSLYi8h19uyN+RmQwapckB5gRsy899NShQVbr7IXxCpcE0dvhdt/LlJrEewM8jTGG241u5
 GBHcCb4RmGIxeIbh/osOZF7AkOQwlKR1DBGAUf5rboRPu1MeAhmxbTssGOIEjzraZqX55tpzchS
 jTD88adjHP1u/wDw0UALz4zs+q4pyj5w/Bp8SiP29MDnld0/Ntakt7/Wz2TDaWFM2H7ixvCqKeN
 zoPP7a/cuIKq1XFYIlgcjRFJ61BGmsPL/6NSFXrcmxtniKP7mHq23hrcuHx9JxpNQK+MKjNKEEN
 FVqN6RuMuGacAkUa+WNK7bXI+68/1lbbZ7K/wbG6GqjGlbWVDNP7i2Om12MJ9kkQPWZSfSB+dfx
 GCQDd8IxQ3uIS90n2DHmEQCkfaixGx714bExmNxl4mN4oyG4/CAHK3G008LUCjmdQJIirWWax7V
 eC8ls9JsqA9U4oA==
X-Developer-Key: i=da.gomez@samsung.com; a=openpgp;
 fpr=B2A7A9CFDD03B540FF58B27185F56EA4E9E8138F

From: Daniel Gomez <da.gomez@samsung.com>

The -EEXIST error code is reserved by the module loading infrastructure
to indicate that a module is already loaded. When a module's init
function returns -EEXIST, userspace tools like kmod interpret this as
"module already loaded" and treat the operation as successful, returning
0 to the user even though the module initialization actually failed.

This follows the precedent set by commit 54416fd76770 ("netfilter:
conntrack: helper: Replace -EEXIST by -EBUSY") which fixed the same
issue in nf_conntrack_helper_register().

Affected modules:
  * meraki_mx100 pcengines_apuv2

Signed-off-by: Daniel Gomez <da.gomez@samsung.com>
---
The error code -EEXIST is reserved by the kernel module loader to
indicate that a module with the same name is already loaded. When a
module's init function returns -EEXIST, kmod interprets this as "module
already loaded" and reports success instead of failure [1].

The kernel module loader will include a safety net that provides -EEXIST
to -EBUSY with a warning [2], and a documentation patch has been sent to
prevent future occurrences [3].

These affected code paths were identified using a static analysis tool
[4] that traces -EEXIST returns to module_init(). The tool was developed
with AI assistance and all findings were manually validated.

Link: https://lore.kernel.org/all/aKEVQhJpRdiZSliu@orbyte.nwl.cc/ [1]
Link: https://lore.kernel.org/all/20251013-module-warn-ret-v1-0-ab65b41af01f@intel.com/ [2]
Link: https://lore.kernel.org/all/20251218-dev-module-init-eexists-modules-docs-v1-0-361569aa782a@samsung.com/ [3]
Link: https://gitlab.com/-/snippets/4913469 [4]
---
 drivers/base/swnode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/base/swnode.c b/drivers/base/swnode.c
index 16a8301c25d6..083593d99a18 100644
--- a/drivers/base/swnode.c
+++ b/drivers/base/swnode.c
@@ -919,7 +919,7 @@ int software_node_register(const struct software_node *node)
 	struct swnode *parent = software_node_to_swnode(node->parent);
 
 	if (software_node_to_swnode(node))
-		return -EEXIST;
+		return -EBUSY;
 
 	if (node->parent && !parent)
 		return -EINVAL;

---
base-commit: 8f0b4cce4481fb22653697cced8d0d04027cb1e8
change-id: 20251219-dev-module-init-eexists-linux-acpi-110964d37acd

Best regards,
--  
Daniel Gomez <da.gomez@samsung.com>


