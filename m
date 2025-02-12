Return-Path: <linux-acpi+bounces-11129-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D02CDA32F2D
	for <lists+linux-acpi@lfdr.de>; Wed, 12 Feb 2025 20:03:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7FBAB7A3515
	for <lists+linux-acpi@lfdr.de>; Wed, 12 Feb 2025 19:02:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCFBA257AC7;
	Wed, 12 Feb 2025 19:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KTV9kS5R"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2904C1FC0FD;
	Wed, 12 Feb 2025 19:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739387005; cv=none; b=ZMkJdv7vssrtCKVD+bj28/55NKvMhzbAxrvx59YVvZtF4fMBj0PTNSVU6KXIDOBuPcU+hDMxj5DTk7tA+zLGaSJcOcC3MYiUG0Zf4J703ESQUX+CPkcD9WbKgvQyRS/Tubq7fgAgvDZ2Qo4zHwryR4gTGZMPk/WkE5CLkJK0Ayw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739387005; c=relaxed/simple;
	bh=Q5WCinM78joO19bz4ipSZN2nHA4SwWHLZZzByfpdgQc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=n2I9FxBrowEzjs1gWRuqbUwAMLCQdkc0EgsnvJWEVLNyGQuh9RK2JZAnnYseHHEClQfTyBgISwdTc3KstMISM92iZN1k2NFGwl9O6mlCh0m2k0egUGWUJG2HSAQIdmyXHccsphzm+jE9vq/VEMJJbYj8DJ6ns2QldGRrEY6EafQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KTV9kS5R; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-6f9b1bc594dso993507b3.0;
        Wed, 12 Feb 2025 11:03:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739387003; x=1739991803; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Li3QvOn0MBSxnCwMnn2tzHDETkUA5jkI5FjmbsImGcQ=;
        b=KTV9kS5R8OKlNHn2R1jC0iGD+eRoplLYj64luTaGCdehBT4oLY64tZJ3ugq/PXvDQp
         fIrH4Vhr+WQma2OPaJBxDy6ug3rem9Fzh03jhHkaFLtwP5Mx/f7r4GACiX8KyoZQgSB7
         3jI5RtUsirAoaGn2x8GXk0uN8klbBCy/deC5A13QRZVY+g8i10TkAKr+qut1i7EnqYUP
         DLNqhmfKBJNwqpyVFDpO9PSZ5drBXAc/v0LqbHASBNbjc07BT33qUAJ0F8OcRBFKVcIc
         o+8bPxOydcPnEx/qHUJw+D/jwWG1Jf2ljwGRQbqcqdOyFmt3eypZnAcaUthpQMX9G/NI
         8L3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739387003; x=1739991803;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Li3QvOn0MBSxnCwMnn2tzHDETkUA5jkI5FjmbsImGcQ=;
        b=h56Q/7yKSDSEIJt9UoS9U2CzzqOi38VFkTV39Cg3+BgCu/7p7SnkBxiqSOIs734uiX
         n/yJAAk4DEU8r9n/xBnuILpu6OA6SbE6vCH2Oh6IT7aAXugB9H1BEne2ToPqFkmmdl2h
         o+5bgC2SmAvKlpX2E/MgpxoFmBuElXrSGAVCPlvL7gYmhw4iO7hFuvzz7XE0c7qhXbEY
         K/uuhhVmYbhjLAWLwWQpFv2Rpzpq+pXY1rO37qMfO9qUGnmpzQT8tQ6LRcWI6JbEfVsi
         VezCQS83sdy9hgM4IHPGQNL3ulgGygH+4bN3UJU5rbzUUMSzXOZeoPKYqjjtYK0FxrqL
         KaSg==
X-Forwarded-Encrypted: i=1; AJvYcCUfd4P8Cy+DaTTrnqQqkeWb2WRf/jqcR9siIqmofD7by3vn5uu8DZT+YlmRa0ZnJNKeFJkJw5OmTOiPPZo+djBIRj/C1g==@vger.kernel.org, AJvYcCUoS8iMw4WCBdOvmDKOONveVGkwQhf9axBZX3qV+RJoz2tKYLMVc/cUS9sDoteAC72A/Xpzp5jLJfZmtLBs@vger.kernel.org, AJvYcCWJ7ezWQMjdGISNEyQmN4X1ykXiaqZpKJsQxTceHxBseYUO/7HdJkrfEbmhf190Du6q2VTxI1QWiKxM@vger.kernel.org
X-Gm-Message-State: AOJu0YxVIZIn1VVSeFwzTCFd5yCsmdhEkCJsZyA8cNniEM5Sc/qejGaS
	UjW/2yyI++cLTvT1Qxj2TAGlCexRwiYmRtX8NvHIJydX2U9hrwjC
X-Gm-Gg: ASbGncv2XKTzl5uPPHMvNraFOSm1g8xE9+DwfbUXLX4zU4+qScMz7UpjadLfJ/eYvGA
	X5tJ9gHFSc0i1rZUjbeJrH3TLyYfyjDazMofGUa+WoU0z0HqyAuC5mZ1273Owlgnn3Z0LNOcHLY
	qYj65WsT/chP4o/kI6u08lDqCw9nk8u+5NlYqKrcVYJKAClhNKLUC+sKC6L4SywLZsB6qOAxBMG
	7sUCwxXGq06HpGRpUCO/qRKki8/fVmLudGvcmc12HI5ne79Osv+t7i+qpJwhUnDr/6h9AmyUPGL
	pAKFsIGpaOT5/Ra/gPvc0UORFw==
X-Google-Smtp-Source: AGHT+IEMDcy30J1r8ZQyPcNj7CY5wjrIU4TXGEmAeo+IbTY5sT7ecfDSaE3/dnVTG5EvzP2vpW4mRA==
X-Received: by 2002:a05:690c:6988:b0:6f6:cad6:6b5a with SMTP id 00721157ae682-6fb1f19ba28mr57684867b3.13.1739387002932;
        Wed, 12 Feb 2025 11:03:22 -0800 (PST)
Received: from localhost.localdomain ([2800:bf0:179:113e:f067:4e25:4298:6451])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6f99fce16d1sm28059507b3.23.2025.02.12.11.03.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2025 11:03:22 -0800 (PST)
From: Kurt Borja <kuurtb@gmail.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: "Len Brown" <lenb@kernel.org>,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	"Mario Limonciello" <mario.limonciello@amd.com>,
	platform-driver-x86@vger.kernel.org,
	"Kurt Borja" <kuurtb@gmail.com>,
	Mark Pearson <mpearson-lenovo@squebb.ca>
Subject: [PATCH v2] ACPI: platform_profile: Improve platform_profile_unregister
Date: Wed, 12 Feb 2025 14:03:08 -0500
Message-ID: <20250212190308.21209-1-kuurtb@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Drivers usually call this method on error/exit paths and do not check
for it's return value, which is always 0 anyway, so make it void. This
is safe to do as currently all drivers use
devm_platform_profile_register().

While at it improve the style and make the function safer by checking
for IS_ERR_OR_NULL before dereferencing the device pointer.

Signed-off-by: Kurt Borja <kuurtb@gmail.com>
---
Hi all,

I made a little modification that I forgot in the last version.

Rafael, please tell me if you prefer different commits for this. Also
should we WARN_ON(IS_ERR_OR_NULL)?

Based on the acpi branch of the linux-pm tree.

~ Kurt

Changes in v2:
  - Get reference to pprof after checking for IS_ERR_OR_NULL(dev)
  - CC Mark Pearson (sorry!)

 drivers/acpi/platform_profile.c  | 19 +++++++++----------
 include/linux/platform_profile.h |  2 +-
 2 files changed, 10 insertions(+), 11 deletions(-)

diff --git a/drivers/acpi/platform_profile.c b/drivers/acpi/platform_profile.c
index fc92e43d0fe9..ed9c0cc9ea9c 100644
--- a/drivers/acpi/platform_profile.c
+++ b/drivers/acpi/platform_profile.c
@@ -569,24 +569,23 @@ EXPORT_SYMBOL_GPL(platform_profile_register);
 /**
  * platform_profile_remove - Unregisters a platform profile class device
  * @dev: Class device
- *
- * Return: 0
  */
-int platform_profile_remove(struct device *dev)
+void platform_profile_remove(struct device *dev)
 {
-	struct platform_profile_handler *pprof = to_pprof_handler(dev);
-	int id;
+	struct platform_profile_handler *pprof;
+
+	if (IS_ERR_OR_NULL(dev))
+		return;
+
+	pprof = to_pprof_handler(dev);
+
 	guard(mutex)(&profile_lock);
 
-	id = pprof->minor;
+	ida_free(&platform_profile_ida, pprof->minor);
 	device_unregister(&pprof->dev);
-	ida_free(&platform_profile_ida, id);
 
 	sysfs_notify(acpi_kobj, NULL, "platform_profile");
-
 	sysfs_update_group(acpi_kobj, &platform_profile_group);
-
-	return 0;
 }
 EXPORT_SYMBOL_GPL(platform_profile_remove);
 
diff --git a/include/linux/platform_profile.h b/include/linux/platform_profile.h
index 8ab5b0e8eb2c..d5499eca9e1d 100644
--- a/include/linux/platform_profile.h
+++ b/include/linux/platform_profile.h
@@ -47,7 +47,7 @@ struct platform_profile_ops {
 struct device *platform_profile_register(struct device *dev, const char *name,
 					 void *drvdata,
 					 const struct platform_profile_ops *ops);
-int platform_profile_remove(struct device *dev);
+void platform_profile_remove(struct device *dev);
 struct device *devm_platform_profile_register(struct device *dev, const char *name,
 					      void *drvdata,
 					      const struct platform_profile_ops *ops);

base-commit: 3e3e377dd1f300bbdd230533686ce9c9f4f8a90d
-- 
2.48.1


