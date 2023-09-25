Return-Path: <linux-acpi+bounces-100-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C48A27ADD35
	for <lists+linux-acpi@lfdr.de>; Mon, 25 Sep 2023 18:32:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 74A7B281E6B
	for <lists+linux-acpi@lfdr.de>; Mon, 25 Sep 2023 16:32:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C96320B00
	for <lists+linux-acpi@lfdr.de>; Mon, 25 Sep 2023 16:32:24 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F3A71B299
	for <linux-acpi@vger.kernel.org>; Mon, 25 Sep 2023 15:58:13 +0000 (UTC)
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8250B92;
	Mon, 25 Sep 2023 08:58:11 -0700 (PDT)
Received: from localhost.localdomain (unknown [IPv6:2001:b07:646b:e2:e4be:399f:af39:e0db])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: laura.nao)
	by madras.collabora.co.uk (Postfix) with ESMTPSA id 58A83660730D;
	Mon, 25 Sep 2023 16:58:09 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1695657490;
	bh=pWW4E+juaK7sF2s3dY0MCFnnwr1NNNbo05xJAUGYROA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ls0Xjum/CtdmRFRNcGlGFVV91i4W5NGWQBarpZh8bf2tuql3/484rhRUzosm61Fkz
	 XeFO6yosnwhD1iMuW6v6UebEVR4DVGWcs/xMDhybzV0k8I8oW8dEXiY7VcWhpjqgg4
	 1iQ87heThFs7/BvP4xnEUV/E7brWT00zqhw3NurWGQUCjy6sgRt7YHPC+xr9T92TqQ
	 BIdIAUWbLAfNY/Bg6TzwVI007mD6949+ArZvts/+OxKCUVP9khlk+0Ews2VXYG2Jbe
	 e4UpgrrnjqQViZHYuniMt9Eo8mcnfY3E3dxDfCmuKfBg0JnO1QMb90SmJPFpkeQ/c4
	 aags64so693TQ==
From: Laura Nao <laura.nao@collabora.com>
To: rafael@kernel.org,
	lenb@kernel.org,
	shuah@kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	groeck@chromium.org,
	broonie@kernel.org,
	robh+dt@kernel.org,
	kernelci@lists.linux.dev,
	kernel@collabora.com,
	Laura Nao <laura.nao@collabora.com>
Subject: [RFC PATCH 1/2] acpi: Add script to extract ACPI device ids in the kernel
Date: Mon, 25 Sep 2023 17:58:05 +0200
Message-Id: <20230925155806.1812249-2-laura.nao@collabora.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230925155806.1812249-1-laura.nao@collabora.com>
References: <20230925155806.1812249-1-laura.nao@collabora.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Add a script to extract all the supported acpi device ids
from kernel sources.

The list of IDs returned by the script can be used as a
reference to determine if a device declared in the ACPI namespace
with certain _HID/_CID is supported by the kernel or not.

Signed-off-by: Laura Nao <laura.nao@collabora.com>
---
 MAINTAINERS                   |  1 +
 scripts/acpi/acpi-extract-ids | 60 +++++++++++++++++++++++++++++++++++
 2 files changed, 61 insertions(+)
 create mode 100755 scripts/acpi/acpi-extract-ids

diff --git a/MAINTAINERS b/MAINTAINERS
index 27751573e314..7540316d82f5 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -294,6 +294,7 @@ F:	drivers/pnp/pnpacpi/
 F:	include/acpi/
 F:	include/linux/acpi.h
 F:	include/linux/fwnode.h
+F:	scripts/acpi/acpi-extract-ids
 F:	tools/power/acpi/
 
 ACPI APEI
diff --git a/scripts/acpi/acpi-extract-ids b/scripts/acpi/acpi-extract-ids
new file mode 100755
index 000000000000..12c8e09281dd
--- /dev/null
+++ b/scripts/acpi/acpi-extract-ids
@@ -0,0 +1,60 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: GPL-2.0-only
+#
+# Heavily inspired by the scripts/dtc/dt-extract-compatibles script,
+# adapted for the ACPI use case.
+#
+
+import os
+import glob
+import re
+import argparse
+
+
+def parse_acpi_device_ids(file):
+    """ Find all device ID strings in acpi_device_id struct """
+    id_list = []
+
+    with open(file, 'r', encoding='utf-8') as f:
+        data = f.read().replace('\n', '')
+
+        for m in re.finditer(r'acpi_device_id(\s+\S+)?\s+(\S+)\[\](\s+\S+)?\s*=\s*({.*?);', data):
+            id_list += re.findall(r'\"(\S+)\"', m[4])
+
+    return id_list
+
+
+def print_acpi_device_ids(filename, id_list):
+    if not id_list:
+        return
+    if show_filename:
+        compat_str = ' '.join(id_list)
+        print(filename + ": ID(s): " + compat_str)
+    else:
+        print(*id_list, sep='\n')
+
+
+def files_to_parse(path_args):
+    for f in path_args:
+        if os.path.isdir(f):
+            for filename in glob.iglob(f + "/**/*.c", recursive=True):
+                yield filename
+        else:
+            yield f
+
+
+show_filename = False
+
+if __name__ == "__main__":
+    ap = argparse.ArgumentParser()
+    ap.add_argument("cfile", type=str, nargs='*',
+                    help="C source files or directories to parse")
+    ap.add_argument('-H', '--with-filename',
+                    help="Print filename with device ids", action="store_true")
+    args = ap.parse_args()
+
+    show_filename = args.with_filename
+
+    for f in files_to_parse(args.cfile):
+        id_list = parse_acpi_device_ids(f)
+        print_acpi_device_ids(f, id_list)
-- 
2.30.2


