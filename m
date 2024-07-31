Return-Path: <linux-acpi+bounces-7158-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 89384942419
	for <lists+linux-acpi@lfdr.de>; Wed, 31 Jul 2024 03:14:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4008B1F24EC1
	for <lists+linux-acpi@lfdr.de>; Wed, 31 Jul 2024 01:14:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EAA38F54;
	Wed, 31 Jul 2024 01:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="x9VrWy/l"
X-Original-To: linux-acpi@vger.kernel.org
Received: from xmbghk7.mail.qq.com (xmbghk7.mail.qq.com [43.163.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A30688BE0
	for <linux-acpi@vger.kernel.org>; Wed, 31 Jul 2024 01:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=43.163.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722388473; cv=none; b=fnJf8cwN181XNwUfUhNp6Dk37eMQ/+pF51aNgUd6Q7v9x9W8zg2rAEkYM3wV5LKb5SRottoMNw54ok0+mYKoQAzYeelpf7l0yex1lwISpBBszzygN5E0KVv/Fhb+e3seyR/N178/Rp5/jGPXn747zqWurHppb5xNZwGOvLZsNFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722388473; c=relaxed/simple;
	bh=Ol6fsE837BWnDsz8i/J0CfxAa59HnAGNzCu3Ne8NyJA=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=fSAuYJazAkh1NCUntAh1M9YsmfoqcLDw89rGNou14SxDY2zbpnksH2XkowcPlu1c/udPSaXrV5dnEk7Pk0p5+csOvedQ83uoobgavzScFOHyF23lKjuLrkbvYmGQJj23G5HjX0UhhCWqKyBi/yhguWIBcgXoeUcPVwheOoPh2fY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=x9VrWy/l; arc=none smtp.client-ip=43.163.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1722388468;
	bh=xmziSWrE762AJPUBIoJqWj3lQPscDyDVM+Fh5GgSVGQ=;
	h=From:To:Cc:Subject:Date;
	b=x9VrWy/lIw99tosAbX6RQWWt7sDU9LqdXIaRemsSXlYkUxywNBoWaGZj+R3zk3BAH
	 UCVDz9HaT6W/pdDu+GSOgmjReAX3ObAOXg9pYIJEtGXUZwS1yVlTA7WiieD3Gb6FB4
	 GTuMgaGsd8VpBPgdDQcPGD4dGo6bEIfGs6z9wyU0=
Received: from xp-virtual-machine.. ([39.156.73.11])
	by newxmesmtplogicsvrszc19-0.qq.com (NewEsmtp) with SMTP
	id 399B164C; Wed, 31 Jul 2024 09:14:25 +0800
X-QQ-mid: xmsmtpt1722388465tnp8i6sky
Message-ID: <tencent_ADB80DA880207BBCFA4F5CE7F05CDD221409@qq.com>
X-QQ-XMAILINFO: NkHKfw09D6j8rCF2OiIEIyVkqJu9N/P/cpDW5VGsn6jBXZaKkXLdvPQY0e3kb0
	 EZoSs58fF/H586O8GGLJ5IO15XPQUahdwXSVjUNTfTOrKwKXqyIWnsfFGRLS3GPbTcfIxB0tEPZR
	 AmclmZuCqPAafMYgJl1vc0If4I7ZijRTKxlZEesIEiDZ8oLa9n1PkC5v3S9E/t2HiUeUpnbrPtTF
	 Jeoq0wbPywGx3wsfOhxOD7mqy32nYnUhTywpEVABq/k4WvuiyLOCmOGDc1Bz615OsSEVB7ZbG5FL
	 ps7MrL8KykTl2NnjbHxo29xIe8Bf2XIvpKPk8lbmoEKnLlcZJXSJ/A3L9VrKXGIFgypqgzAPvGWe
	 scYpsZYObZB3grH1LuKM86Kamfsb3YQGUagnbnCWjyFF0Iht4GX2H0m82zr2NYbKI/EituEnkDnK
	 8XvcGikA76NhfaSVhkfhqlrxiPTlpinW4EUUFFzzz785h+EgQh3hXkocV/EzwvGKzBYHu8IsFn4t
	 Ni6h2WQGmWN+Rc1Wgl/guvIVt+E7nIPf1BvYE6VdSp+5Lua3+dwkFpScCMC2EuuhvypA2JPUEL4q
	 ryk/wOQS7rF0g/vh/kIKKt/0SyTgv7hDfnIOHfY0AY/xJhacPZfumaoVaWEd+jkBtUqDrhymr3Da
	 ccN8puIyboqDL+OxKFqD2lqdbcvi+7kjyqesqLDwZ9khQQYURqxJjGA87WAN2xhC86HnMICoVBuj
	 Eess7XZ3oX/stBg9s00VF2Z+jOyZiUUgIxlGZ0oWYbqYzLbsj5zJ0zl8BQr5+Bw9V0gLUrwv9PJn
	 UmpzQJcHEybx0jrvAdr2ytWBV9Lry3x70gV0KmZnzkADDrB0HYYJATk6uxED8brfNfUgj668d9nH
	 nVyH/qu0qpNOv4TOaBL4YWkyQAc9CgVw5puBaDdIqonoppWSFzLJFRZcynJlaBCCg4m1icna9hBH
	 ibR6emSWOl4hW+2Nw6SWLc+qNGAAQmT05uuiMW/P4=
X-QQ-XMRINFO: MSVp+SPm3vtS1Vd6Y4Mggwc=
From: xiaopeitux@foxmail.com
To: robert.moore@intel.com,
	rafael.j.wysocki@intel.com
Cc: acpica-devel@lists.linux.dev,
	linux-acpi@vger.kernel.org,
	xiaopei01@kylinos.cn
Subject: [PATCH] ACPI:dbconvert:check null return of ACPI_ALLOCATE_ZEROED in acpi_db_convert_to_package
Date: Wed, 31 Jul 2024 09:14:23 +0800
X-OQ-MSGID: <e4f084d1fdc3fbcab24cefcbc5f484be43dc37a8.1722388346.git.xiaopei01@kylinos.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Pei Xiao <xiaopei01@kylinos.cn>

ACPI_ALLOCATE_ZEROED may fails, elements might be null and will cause
null pointer dereference later.

Link: https://github.com/acpica/acpica/commit/4d4547cf
Signed-off-by: Pei Xiao <xiaopei01@kylinos.cn>
---
 drivers/acpi/acpica/dbconvert.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/acpi/acpica/dbconvert.c b/drivers/acpi/acpica/dbconvert.c
index 2b84ac093698..a60d1098a105 100644
--- a/drivers/acpi/acpica/dbconvert.c
+++ b/drivers/acpi/acpica/dbconvert.c
@@ -175,6 +175,8 @@ acpi_status acpi_db_convert_to_package(char *string, union acpi_object *object)
 	    ACPI_ALLOCATE_ZEROED(DB_DEFAULT_PKG_ELEMENTS *
 				 sizeof(union acpi_object));
 
+	if (!elements)
+		return (AE_NO_MEMORY);
 	this = string;
 	for (i = 0; i < (DB_DEFAULT_PKG_ELEMENTS - 1); i++) {
 		this = acpi_db_get_next_token(this, &next, &type);
-- 
2.34.1


No virus found
		Checked by Hillstone Network AntiVirus


