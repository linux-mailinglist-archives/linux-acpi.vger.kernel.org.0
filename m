Return-Path: <linux-acpi+bounces-13284-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E196FA9D1AE
	for <lists+linux-acpi@lfdr.de>; Fri, 25 Apr 2025 21:35:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D5294E4257
	for <lists+linux-acpi@lfdr.de>; Fri, 25 Apr 2025 19:35:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 466D9221DA3;
	Fri, 25 Apr 2025 19:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="kGYlpr4o"
X-Original-To: linux-acpi@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6210E21CC4B;
	Fri, 25 Apr 2025 19:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745609665; cv=none; b=hIssARVMahAC8Md9CvuTAnOS6RbLta0RteU4e5EQoDNHfbZSbnHV/SWDXFVn4b7j91xe9gQsNV/D9Y0KaSuNW2KvylVKsfPsSqCLpgqDy8I2l9mvMGKjPPCrB0Kprog3hvyz4uR0Fl7wOp+fvS6CTIaTBOGcTgwwpxZYj0/JsvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745609665; c=relaxed/simple;
	bh=D42QO1gk2SkTnno/j5B058OApOyGNgwSqdsvv9VF+0g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kVBH/UDAPEnQ6kx1x+TwLCdNXsgY+SYorDGYWMLM8Mg01uNme5cv+iu1F2pMUQbM3y4P6wk026j7+9kz1tnNWHXoKjikGzXbq9WqytCoQ/8c2MCQU6aUg0WbeVwFPgYhx5sd3UjUqT7d7s/wbRyVngR6RV6USwdOTe+f3yln7B0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=kGYlpr4o; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from kreacher.localnet (unknown [217.114.34.19])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id B8F966645E9;
	Fri, 25 Apr 2025 21:34:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1745609656;
	bh=D42QO1gk2SkTnno/j5B058OApOyGNgwSqdsvv9VF+0g=;
	h=From:Subject:Date;
	b=kGYlpr4oouhxeVkWQc6/cfLdzls1wS+Auu5DLf+kOLftyXTUItgd18OYJbUbzByWD
	 XNT2YQW/2c/CWCOVTo6bb7uUCgMbd+ow7B+1DNiSnuOwoHJlfIZ6NwzH/eKlTgoODO
	 lE+vOxPMG0iBPB6RBEjDDurkNNgD5eB5yMO294kO/kmeVQn4lU0aWdYkgzjfdFLRI9
	 mPmqhqbF84XqtDBXcQBeq5JppiNFFV6KsOcljrKkFkyl6ZfnsXqMZ9xa9vA7/HGCLs
	 d6ZI53edBpQIq5h4obqUI3zugnQoDjR55HNi2xDhpHR5BixC2FtSbPdEb9HSpcyt59
	 eEL76jf/XVFSQ==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Bob Moore <robert.moore@intel.com>,
 Saket Dumbre <saket.dumbre@intel.com>
Subject: [PATCH v1 13/19] ACPICA: Apply ACPI_NONSTRING
Date: Fri, 25 Apr 2025 21:28:34 +0200
Message-ID: <2039736.usQuhbGJ8B@rjwysocki.net>
In-Reply-To: <12671029.O9o76ZdvQC@rjwysocki.net>
References: <12671029.O9o76ZdvQC@rjwysocki.net>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 217.114.34.19
X-CLIENT-HOSTNAME: 217.114.34.19
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvheefudelucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepledtieekkeekveeikeetgffgteeuteefjeevjeegudelvdduheeiuedvieehieevnecuffhomhgrihhnpehgihhthhhusgdrtghomhenucfkphepvddujedruddugedrfeegrdduleenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepihhnvghtpedvudejrdduudegrdefgedrudelpdhhvghlohepkhhrvggrtghhvghrrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpehrjhifsehrjhifhihsohgtkhhirdhnvghtpdhnsggprhgtphhtthhopeegpdhrtghpthhtoheplhhinhhugidqrggtphhisehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprhhosggvrhhtrdhmohhorhgvsehinhhtvghlrdgtohhmpdhrtghpthhtohepshgrkhgvthdrughumhgsrhgvsehinhhtvghlrdgtohhm
X-DCC--Metrics: v370.home.net.pl 1024; Body=4 Fuz1=4 Fuz2=4

From: Kees Cook <kees@kernel.org>

ACPICA commit ed68cb8e082e3bfbba02814af4fd5a61247f491b

Add ACPI_NONSTRING annotations for places found that are using char
arrays without a terminating NUL character. These were found during
Linux kernel builds and after looking for instances of arrays of size
ACPI_NAMESEG_SIZE.

Link: https://github.com/acpica/acpica/commit/ed68cb8e
Signed-off-by: Kees Cook <kees@kernel.org>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/acpica/aclocal.h   | 4 ++--
 drivers/acpi/acpica/nsnames.c   | 2 +-
 drivers/acpi/acpica/nsrepair2.c | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/acpi/acpica/aclocal.h b/drivers/acpi/acpica/aclocal.h
index 6481c48c22bb..b40e9a520618 100644
--- a/drivers/acpi/acpica/aclocal.h
+++ b/drivers/acpi/acpica/aclocal.h
@@ -293,7 +293,7 @@ acpi_status (*acpi_internal_method) (struct acpi_walk_state * walk_state);
  * expected_return_btypes - Allowed type(s) for the return value
  */
 struct acpi_name_info {
-	char name[ACPI_NAMESEG_SIZE] __nonstring;
+	char name[ACPI_NAMESEG_SIZE] ACPI_NONSTRING;
 	u16 argument_list;
 	u8 expected_btypes;
 };
@@ -370,7 +370,7 @@ typedef acpi_status (*acpi_object_converter) (struct acpi_namespace_node *
 					      converted_object);
 
 struct acpi_simple_repair_info {
-	char name[ACPI_NAMESEG_SIZE] __nonstring;
+	char name[ACPI_NAMESEG_SIZE] ACPI_NONSTRING;
 	u32 unexpected_btypes;
 	u32 package_index;
 	acpi_object_converter object_converter;
diff --git a/drivers/acpi/acpica/nsnames.c b/drivers/acpi/acpica/nsnames.c
index d91153f65700..22aeeeb56cff 100644
--- a/drivers/acpi/acpica/nsnames.c
+++ b/drivers/acpi/acpica/nsnames.c
@@ -194,7 +194,7 @@ acpi_ns_build_normalized_path(struct acpi_namespace_node *node,
 			      char *full_path, u32 path_size, u8 no_trailing)
 {
 	u32 length = 0, i;
-	char name[ACPI_NAMESEG_SIZE];
+	char name[ACPI_NAMESEG_SIZE] ACPI_NONSTRING;
 	u8 do_no_trailing;
 	char c, *left, *right;
 	struct acpi_namespace_node *next_node;
diff --git a/drivers/acpi/acpica/nsrepair2.c b/drivers/acpi/acpica/nsrepair2.c
index 330b5e4711da..0075fc80d498 100644
--- a/drivers/acpi/acpica/nsrepair2.c
+++ b/drivers/acpi/acpica/nsrepair2.c
@@ -25,7 +25,7 @@ acpi_status (*acpi_repair_function) (struct acpi_evaluate_info * info,
 				     return_object_ptr);
 
 typedef struct acpi_repair_info {
-	char name[ACPI_NAMESEG_SIZE] __nonstring;
+	char name[ACPI_NAMESEG_SIZE] ACPI_NONSTRING;
 	acpi_repair_function repair_function;
 
 } acpi_repair_info;
-- 
2.43.0





